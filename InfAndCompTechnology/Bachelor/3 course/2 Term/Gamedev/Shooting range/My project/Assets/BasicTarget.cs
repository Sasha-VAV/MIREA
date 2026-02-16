using UnityEngine;

public class BasicTarget : Target
{
    [SerializeField] private Material _mat;

    void Start()
    {
        GetComponent<Renderer>().material = _mat;
    }

    public override void OnHit() => TakeDamage(100);
}