---
categories:
- FastPages
- Jekill
- Jupyter
- Quarto
- Blog
date: '2023-07-08'
description: A guide to migrate fastpages to quarto.
layout: post
title: Migration from FastPages to Quarto
toc: true

---
# Migration from FastPages to Quarto
I was updating my blog and I found some issues in the GitHub action I configured to automatically build my blog.
The Jekill build was failing due to an issue with the minima package. I was getting this error:

```
 Rendering Liquid: assets/minima-social-icons.liquid
  Liquid Exception: Invalid syntax for include tag. File contains invalid characters or sequences: social-icons/.svg Valid syntax: {% include file.ext param='value' param2='value' %} in assets/minima-social-icons.liquid
```

After some research, I discovered that the "minima" package changed the way to specify the social networks. There is a config file "_config.yml" where you can specify the social networks you want to show in your blog. 
The old way was:

```
# Github and twitter are optional:
minima:
  social_links:
    github: politeles
```	
And the new way is:

```
minima:
   - { platform: github,  user_url: "https://github.com/politeles" }
```

After I changed that, the GitHub action was working again. 
I read the [Fast.AI forum and I found that FastPages is being deprecated in favor of Quarto]. So I decided to migrate my blog to Quarto.

First of all, I have to download and install Quarto CLI for windows. You can find the instructions [here](https://quarto.org/docs/getting-started/installation.html#installing-quarto-cli).

I'm using VS code as my main editor, so, I installed the Quarto extension for VS code. You can find the instructions [here](https://quarto.org/docs/get-started/hello/vscode.html).

Basically, we create a new project in a new folder:

```powershell
 quarto create-project -type website:blog .
 quarto install extension quarto-ext/video
```	

Then, I started the migration process as described [here](https://nbdev.fast.ai/tutorials/blogging.html). I'm copying the blog posts, the notebooks and the images to the post folder. In this case, all my posts are under the politeles folder.

```powershell
copy ..\politeles\_posts\* .\posts\
copy ..\politeles\_notebooks\* .\posts\
copy ..\politeles\images\* .\posts\
copy ..\politeles\images\copied_from_nb\* .\posts\
```	

Then, I have to change the metadata in the posts. In the guide, they are using nbdev_migrate. The problem is that doesn't exists in my windows system. 
The solution is to install nbdev, I'm doing all that using Anaconda prompt in powershell. If you want to install Anaconda in your windows env, you can find the instructions [here](https://docs.anaconda.com/free/anaconda/install/windows/).

Once you have Anaconda installed, I create a new [virtual environment][conda_v] and install nbdev:

```powershell
conda create --name fastpages
```

Now switch to the new environment:
```powershell
conda activate fastpages
```

First we have to install Jupyter Lab:
```powershell
conda install -c conda-forge -y jupyterlab
```

And install nbdev:
```powershell
conda install -c fastai nbdev
```


[Fastpages is being deprecated in favor of Quarto][fp_forum]. This is a guide to migrate your blog from Fastpages to Quarto. 

[If you have a custom domain][custom_domain], like I do, then, you have to update your quarto config file "_quarto.yml" to include the following line:

```
resources:
  - CNAME
```

inside the CNAME file, you should include your domain name.



[fp_dep]: https://fastpages.fast.ai/fastpages/jupyter/2020/02/21/deprecation.html
[fp_forum]: https://forums.fast.ai/t/fastpages-deprecating-fastpages-in-favor-of-quarto/99095
[conda_v]: https://conda.io/projects/conda/en/latest/user-guide/tasks/manage-environments.html
[custom_domain]: https://github.com/quarto-dev/quarto-cli/issues/4941#issuecomment-1482565364