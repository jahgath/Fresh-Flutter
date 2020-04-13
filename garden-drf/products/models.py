from django.db import models

# Create your models here.

class Product(models.Model):
    name = models.TextField(
        max_length = 512,
        null=False,
        )
    description = models.TextField( 
        max_length = 4096,
        null=False,
    )
    image_url = models.URLField(
        max_length = 512,
    )
    price = models.DecimalField(
        max_digits=10,
        decimal_places=2,   
    )

    class Meta:
        verbose_name = "product"
        verbose_name_plural = "products"
    
    def __str__(self):
        return self.name
    
    def get_absolute_url(self):
        return reverse('company_details', kwargs={'pk': self.id})
    