using UnityEngine;

public abstract class Target : MonoBehaviour
{
    [SerializeField] protected int health = 100;
    public abstract void OnHit();

    public void TakeDamage(int dmg)
    {
        health -= dmg;
        if (health <= 0) Destroy(gameObject);
    }
}

