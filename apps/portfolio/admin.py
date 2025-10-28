from django.contrib import admin
from unfold.admin import ModelAdmin
from .models import (
    Personal,
    About,
    Experience,
    Description,
    Technology,
    Education,
    Portfolio,
    Issuing_Organization,
)


@admin.register(Experience)
class ExperienceAdmin(ModelAdmin):
    list_display = [field.name for field in Experience._meta.fields]
    list_filter = ('is_current',)
    search_fields = ('title', 'company')
    list_editable = ('is_current',)
    ordering = ('-start_date',)


@admin.register(Description)
class DescriptionAdmin(ModelAdmin):
    list_display = [field.name for field in Description._meta.fields]
    ordering = ('experience', 'order_number')


@admin.register(Portfolio)
class PortfolioAdmin(ModelAdmin):
    list_display = [field.name for field in Portfolio._meta.fields]
    search_fields = [field.name for field in Portfolio._meta.fields if field.get_internal_type() == 'CharField']


@admin.register(Personal)
class PersonalAdmin(ModelAdmin):
    list_display = [field.name for field in Personal._meta.fields]


@admin.register(About)
class AboutAdmin(ModelAdmin):
    list_display = [field.name for field in About._meta.fields]


@admin.register(Technology)
class TechnologyAdmin(ModelAdmin):
    list_display = [field.name for field in Technology._meta.fields]


@admin.register(Education)
class EducationAdmin(ModelAdmin):
    list_display = [field.name for field in Education._meta.fields]


@admin.register(Issuing_Organization)
class IssuingOrganizationAdmin(ModelAdmin):
    list_display = [field.name for field in Issuing_Organization._meta.fields]
