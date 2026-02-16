using UnityEngine;

public class RandomMovement : MonoBehaviour
{
    [SerializeField] private float _minSpeed = 1f;
    [SerializeField] private float _maxSpeed = 3f;
    [SerializeField] private Vector3 _movementAxis = Vector3.one;

    private Vector3 _direction;
    private float _speed;

    void Start()
    {
        _direction = new Vector3(
            Random.value * _movementAxis.x,
            Random.value * _movementAxis.y,
            Random.value * _movementAxis.z
        ).normalized;

        if (_direction == Vector3.zero)
            _direction = Vector3.forward;

        _speed = Random.Range(_minSpeed, _maxSpeed);
    }

    void Update() => transform.Translate(_direction * _speed * Time.deltaTime);
}