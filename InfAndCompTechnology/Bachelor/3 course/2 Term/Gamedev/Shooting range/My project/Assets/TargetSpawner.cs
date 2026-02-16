using UnityEngine;

public class TargetSpawner : MonoBehaviour
{
    [SerializeField] private GameObject _targetPrefab;
    [SerializeField] private int _count = 5;
    [SerializeField] private float _radius = 8f;

    void Start() => GenerateTargets();

    public void GenerateTargets()
    {
        for (int i = 0; i < _count; i++)
        {
            Vector3 pos = new Vector3(
                Random.Range(-_radius, _radius),
                1.5f,
                Random.Range(-_radius, _radius)
            );
            Instantiate(_targetPrefab, pos, Quaternion.identity);
        }
    }
}