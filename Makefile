REGION=eu-west-1
BUCKET=s3://scaling-python.com/
DISTRIBUTION_ID=E1SN1JCVYE1CFX

css/%.min.css: css/%.css
	uglifycss $< > $@

js/%.min.js: js/%.js
	uglifyjs $< > $@

pub: css/custom.min.css
	aws s3 --region $(REGION) sync . $(BUCKET) --exclude 'resources/*' --exclude ".git/*" --delete
	aws cloudfront create-invalidation --distribution-id $(DISTRIBUTION_ID) --paths /index.html

clean-pub:
	aws s3 rm --recursive --region $(REGION) $(BUCKET)
