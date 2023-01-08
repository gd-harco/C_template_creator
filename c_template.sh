#!/bin/bash
# This script is a template for creating new C programs during my 42 studies.


# Globals variables
script_path=$(dirname $(readlink -f $0))
make_temp=$(script_path)/makefile_template

# asked the name of the project and put it in a variable
echo "Enter the name of the project to be created"
read project_name

#check if the project already exists
if [ -d $project_name ]
then
	echo "ERROR : The project already exists"
	exit 1
fi

# Create the folder and basic template
mkdir $project_name $project_name/src $project_name/include

# ask if the user wants to use libraries
echo "Do you want to use libft? (y/n)"
read libft
if [ $libft = "y" ]
then
#check if the lib folder exists
	if [! -d lib ]
	then
		mkdir $project_name/lib
	fi
	echo "Downloading libft from gd-harco's Github..."
	git clone https://github.com/gd-harco/libft.git $project_name/lib/libft
fi

# ask if the user wants to use minilibx
echo "Do you want to use minilibx? (y/n)"
read minilibx
if [ $minilibx = "y" ]
then
#check ifd the lib folder doesn't exist
	if [! -d lib ]
	then
		mkdir $project_name/lib
	fi
	echo "Downloading minilibx Linux..."
	git clone https://github.com/42Paris/minilibx-linux.git $project_name/lib/mlx/linux
	echo "Downloading minilibx OSX..."
	git clone https://github.com/gd-harco/mlx_mac.git $project_name/lib/mlx/mac
fi

echo "Generating basic files..."
touch $project_name/.gitignore $project_name/Makefile $project_name/README.md $project_name/src/main.c

# add the basic template to Makefile
if [ $libft = "y" && $minilibx = "y" ]
then
	cat $make_temp/mlx_libft.txt >> $project_name/Makefile
elif [ $libft = "y" ]
	cat $make_temp/libft_only.txt >> $project_name/Makefile
elif [ $minilibx = "y" ]
	cat $make_temp/mlx_only.txt >> $project_name/Makefile
else
	cat $make_temp/no_lib.txt >> $project_name/Makefile
fi

#replace every ##project_name## by the project name in the Makefile
sed -i "s/##project_name##/$project_name/g" $project_name/Makefile

# add the basic template to .gitignore
cat $script_path/gitignore_template.txt >> $project_name/.gitignore

# Git
git init $project_name

# ask if the user wants to add a github remote
echo "Do you want to add a github remote? (y/n)"
read github
if [ $github = "y" ]
then
	echo "Enter the github url"
	read github_url
	git remote add github $github_url
fi

# ask if the user wants to add a vogsphere remote
echo "Do you want to add a vogsphere remote? (y/n)"
read vogsphere
if [ $vogsphere = "y" ]
then
	echo "Enter the vogsphere remote url"
	read remote_url
	git remote add remote $remote_url
fi
