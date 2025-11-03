class Mealy:
    def __init__(self):
        self.edges = {
            ("N2", "swap"): ("N5", "F4"),
            ("N5", "view"): ("N5", "F3"),
            ("N5", "put"): ("N0", "F5"),
            ("N0", "swap"): ("N6", "F0"),
            ("N6", "view"): ("N0", "F1"),
            ("N0", "fill"): ("N1", "F4"),
            ("N1", "put"): ("N4", "F2"),
            ("N4", "view"): ("N6", "F2"),
            ("N6", "speed"): ("N7", "F5"),
            ("N7", "fill"): ("N0", "F0"),
            ("N7", "put"): ("N1", "F1"),
            ("N7", "swap"): ("N3", "F5"),
        }
        self.keys = set()
        for _, k in self.edges:
            self.keys.add(k)
        self.seen_states = dict()
        self.state = "N2"
        self.seen_states[self.state] = 1

    def __getattr__(self, name):
        if name.startswith("run_"):

            def next_state():
                key = name[4:]
                if (self.state, key) not in self.edges:
                    if key not in self.keys:
                        return "unknown"
                    return "unsupported"
                self.state, res = self.edges[(self.state, key)]
                self.seen_states[self.state] = (
                        self.seen_states.get(self.state, 0) + 1)
                return res

            return next_state
        raise AttributeError

    def has_max_in_edges(self):
        if self.state == "N0":
            return True
        return False

    def has_path_to(self, new_state):
        REACHABLE_STATES = {
            "N0": {"N0", "N1", "N3", "N4", "N6", "N7"},
            "N1": {"N1", "N3", "N4", "N6", "N7", "N0"},
            "N2": {"N0", "N1", "N3", "N4", "N5", "N6", "N7"},
            "N3": {},
            "N4": {"N1", "N3", "N4", "N6", "N7", "N0"},
            "N5": {"N5", "N0", "N1", "N3", "N4", "N6", "N7"},
            "N6": {"N6", "N0", "N1", "N3", "N4", "N7"},
            "N7": {"N1", "N3", "N4", "N6", "N7", "N0"},
        }
        if new_state in REACHABLE_STATES[self.state]:
            return True
        return False

    def seen_state(self, state):
        return self.seen_states.get(state, 0)


def main():
    mealy = Mealy()
    return mealy


def test():
    mealy = main()
    assert mealy.run_swap() == "F4"
    assert mealy.has_max_in_edges() is False
    assert mealy.run_open() == "unknown"
    assert mealy.run_view() == "F3"
    assert mealy.run_put() == "F5"
    assert mealy.has_max_in_edges()
    assert mealy.seen_state("N4") == 0
    assert mealy.has_path_to("N7")
    assert mealy.run_swap() == "F0"
    assert mealy.run_speed() == "F5"
    assert mealy.run_swap() == "F5"
    assert mealy.run_speed() == "unsupported"
    assert mealy.has_path_to("N2") is False
    try:
        mealy.run()
    except AttributeError:
        pass
