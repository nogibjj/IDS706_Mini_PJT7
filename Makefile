install:
	pip install --upgrade pip &&\
		pip install -r requirements.txt

test:
	python -m pytest -vv --cov=main --cov=mylib test_*.py

format:	
	black *.py 

lint:
	ruff check *.py mylib/*.py

container-lint:
	docker run --rm -i hadolint/hadolint < Dockerfile

refactor: format lint

deploy:
	#deploy goes here
		
all: install lint test format deploy

generate_and_push:
	# Create the markdown file 
	python test_main.py 

	# Add, commit, and push the generated files to GitHub
	@if [ -n "$$(git status --porcelain)" ]; then \
		git config --local user.email "action@github.com"; \
		git config --local user.name "GitHub Action"; \
		git add .; \
		git commit -m "Add SQL log"; \
		git push; \
	else \
		echo "No changes to commit. Skipping commit and push."; \
	fi

extract:
	etl_query extract

transform_load: 
	etl_query transform_load

query:
	python main.py general_query "SELECT a.state, AVG(a.median_household_income) AS average_median_household_income, AVG(a.share_unemployed_seasonal) AS average_share_unemployed_seasonal, a.share_population_in_metro_areas, b.gini_index FROM default.hate_crimes1DB AS a JOIN default.hate_crimes2DB AS b ON a.id = b.id GROUP BY a.state, a.share_population_in_metro_areas, b.gini_index ORDER BY b.gini_index LIMIT 5;"

setup_package: 
	python setup.py develop --user