From: Jiri Olsa <jolsa@redhat.com>
Subject: Re: [RFC] perf/jevents: Add new structure to pass json fields.
Date: Wed, 26 Aug 2020 13:59:54 +0200
Message-ID: <20200826115954.GA766216@krava>
References: <20200825074041.378520-1-kjain@linux.ibm.com>
 <20200826105656.GC703542@krava>
 <6a4e977e-4f77-6a2a-252c-cfdda26db3e2@linux.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <6a4e977e-4f77-6a2a-252c-cfdda26db3e2@linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: kajoljain <kjain@linux.ibm.com>
Cc: acme@kernel.org, ak@linux.intel.com, yao.jin@linux.intel.com, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, irogers@google.com, maddy@linux.ibm.com, ravi.bangoria@linux.ibm.com
List-Id: linux-perf-users.vger.kernel.org

On Wed, Aug 26, 2020 at 05:02:04PM +0530, kajoljain wrote:
> 
> 
> On 8/26/20 4:26 PM, Jiri Olsa wrote:
> > On Tue, Aug 25, 2020 at 01:10:41PM +0530, Kajol Jain wrote:
> > 
> > SNIP
> > 
> >>  {
> >>  	/* try to find matching event from arch standard values */
> >>  	struct event_struct *es;
> >> @@ -498,8 +486,7 @@ try_fixup(const char *fn, char *arch_std, char **event, char **desc,
> >>  		if (!strcmp(arch_std, es->name)) {
> >>  			if (!eventcode && es->event) {
> >>  				/* allow EventCode to be overridden */
> >> -				free(*event);
> >> -				*event = NULL;
> >> +				je->event = NULL;
> >>  			}
> >>  			FOR_ALL_EVENT_STRUCT_FIELDS(TRY_FIXUP_FIELD);
> >>  			return 0;
> >> @@ -513,13 +500,8 @@ try_fixup(const char *fn, char *arch_std, char **event, char **desc,
> >>  
> >>  /* Call func with each event in the json file */
> >>  int json_events(const char *fn,
> >> -	  int (*func)(void *data, char *name, char *event, char *desc,
> >> -		      char *long_desc,
> >> -		      char *pmu, char *unit, char *perpkg,
> >> -		      char *metric_expr,
> >> -		      char *metric_name, char *metric_group,
> >> -		      char *deprecated, char *metric_constraint),
> >> -	  void *data)
> >> +		int (*func)(void *data, struct json_event *je),
> >> +			void *data)
> >>  {
> >>  	int err;
> >>  	size_t size;
> >> @@ -537,24 +519,16 @@ int json_events(const char *fn,
> >>  	EXPECT(tokens->type == JSMN_ARRAY, tokens, "expected top level array");
> >>  	tok = tokens + 1;
> >>  	for (i = 0; i < tokens->size; i++) {
> >> -		char *event = NULL, *desc = NULL, *name = NULL;
> >> -		char *long_desc = NULL;
> >>  		char *extra_desc = NULL;
> >> -		char *pmu = NULL;
> >>  		char *filter = NULL;
> >> -		char *perpkg = NULL;
> >> -		char *unit = NULL;
> >> -		char *metric_expr = NULL;
> >> -		char *metric_name = NULL;
> >> -		char *metric_group = NULL;
> >> -		char *deprecated = NULL;
> >> -		char *metric_constraint = NULL;
> >> +		struct json_event *je;
> >>  		char *arch_std = NULL;
> >>  		unsigned long long eventcode = 0;
> >>  		struct msrmap *msr = NULL;
> >>  		jsmntok_t *msrval = NULL;
> >>  		jsmntok_t *precise = NULL;
> >>  		jsmntok_t *obj = tok++;
> >> +		je = (struct json_event *)calloc(1, sizeof(struct json_event));
> > 
> > hum, you don't check je pointer in here.. but does it need to be allocated?
> > looks like you could just have je on stack as well..
> 
> Hi Jiri,
>    Yes I will add check for je pointer here.The reason for allocating memory to 'je' is,
> later we are actually referring one by one to its field and in case if won't allocate memory
> we will get segmentaion fault as otherwise je will be NULL. Please let me know if I am
> getting correct.

I don't see reason why not to use automatic variable in here,
I tried and it seems to work.. below is diff to your changes,
feel free to squash it with your changes

jirka

---
diff --git a/tools/perf/pmu-events/jevents.c b/tools/perf/pmu-events/jevents.c
index 606805af69fe..eaac5c126a52 100644
--- a/tools/perf/pmu-events/jevents.c
+++ b/tools/perf/pmu-events/jevents.c
@@ -521,14 +521,13 @@ int json_events(const char *fn,
 	for (i = 0; i < tokens->size; i++) {
 		char *extra_desc = NULL;
 		char *filter = NULL;
-		struct json_event *je;
+		struct json_event je = {};
 		char *arch_std = NULL;
 		unsigned long long eventcode = 0;
 		struct msrmap *msr = NULL;
 		jsmntok_t *msrval = NULL;
 		jsmntok_t *precise = NULL;
 		jsmntok_t *obj = tok++;
-		je = (struct json_event *)calloc(1, sizeof(struct json_event));
 
 		EXPECT(obj->type == JSMN_OBJECT, obj, "expected object");
 		for (j = 0; j < obj->size; j += 2) {
@@ -544,7 +543,7 @@ int json_events(const char *fn,
 			       "Expected string value");
 
 			nz = !json_streq(map, val, "0");
-			if (match_field(map, field, nz, &je->event, val)) {
+			if (match_field(map, field, nz, &je.event, val)) {
 				/* ok */
 			} else if (json_streq(map, field, "EventCode")) {
 				char *code = NULL;
@@ -557,14 +556,14 @@ int json_events(const char *fn,
 				eventcode |= strtoul(code, NULL, 0) << 21;
 				free(code);
 			} else if (json_streq(map, field, "EventName")) {
-				addfield(map, &je->name, "", "", val);
+				addfield(map, &je.name, "", "", val);
 			} else if (json_streq(map, field, "BriefDescription")) {
-				addfield(map, &je->desc, "", "", val);
-				fixdesc(je->desc);
+				addfield(map, &je.desc, "", "", val);
+				fixdesc(je.desc);
 			} else if (json_streq(map, field,
 					     "PublicDescription")) {
-				addfield(map, &je->long_desc, "", "", val);
-				fixdesc(je->long_desc);
+				addfield(map, &je.long_desc, "", "", val);
+				fixdesc(je.long_desc);
 			} else if (json_streq(map, field, "PEBS") && nz) {
 				precise = val;
 			} else if (json_streq(map, field, "MSRIndex") && nz) {
@@ -584,34 +583,34 @@ int json_events(const char *fn,
 
 				ppmu = field_to_perf(unit_to_pmu, map, val);
 				if (ppmu) {
-					je->pmu = strdup(ppmu);
+					je.pmu = strdup(ppmu);
 				} else {
-					if (!je->pmu)
-						je->pmu = strdup("uncore_");
-					addfield(map, &je->pmu, "", "", val);
-					for (s = je->pmu; *s; s++)
+					if (!je.pmu)
+						je.pmu = strdup("uncore_");
+					addfield(map, &je.pmu, "", "", val);
+					for (s = je.pmu; *s; s++)
 						*s = tolower(*s);
 				}
-				addfield(map, &je->desc, ". ", "Unit: ", NULL);
-				addfield(map, &je->desc, "", je->pmu, NULL);
-				addfield(map, &je->desc, "", " ", NULL);
+				addfield(map, &je.desc, ". ", "Unit: ", NULL);
+				addfield(map, &je.desc, "", je.pmu, NULL);
+				addfield(map, &je.desc, "", " ", NULL);
 			} else if (json_streq(map, field, "Filter")) {
 				addfield(map, &filter, "", "", val);
 			} else if (json_streq(map, field, "ScaleUnit")) {
-				addfield(map, &je->unit, "", "", val);
+				addfield(map, &je.unit, "", "", val);
 			} else if (json_streq(map, field, "PerPkg")) {
-				addfield(map, &je->perpkg, "", "", val);
+				addfield(map, &je.perpkg, "", "", val);
 			} else if (json_streq(map, field, "Deprecated")) {
-				addfield(map, &je->deprecated, "", "", val);
+				addfield(map, &je.deprecated, "", "", val);
 			} else if (json_streq(map, field, "MetricName")) {
-				addfield(map, &je->metric_name, "", "", val);
+				addfield(map, &je.metric_name, "", "", val);
 			} else if (json_streq(map, field, "MetricGroup")) {
-				addfield(map, &je->metric_group, "", "", val);
+				addfield(map, &je.metric_group, "", "", val);
 			} else if (json_streq(map, field, "MetricConstraint")) {
-				addfield(map, &je->metric_constraint, "", "", val);
+				addfield(map, &je.metric_constraint, "", "", val);
 			} else if (json_streq(map, field, "MetricExpr")) {
-				addfield(map, &je->metric_expr, "", "", val);
-				for (s = je->metric_expr; *s; s++)
+				addfield(map, &je.metric_expr, "", "", val);
+				for (s = je.metric_expr; *s; s++)
 					*s = tolower(*s);
 			} else if (json_streq(map, field, "ArchStdEvent")) {
 				addfield(map, &arch_std, "", "", val);
@@ -620,7 +619,7 @@ int json_events(const char *fn,
 			}
 			/* ignore unknown fields */
 		}
-		if (precise && je->desc && !strstr(je->desc, "(Precise Event)")) {
+		if (precise && je.desc && !strstr(je.desc, "(Precise Event)")) {
 			if (json_streq(map, precise, "2"))
 				addfield(map, &extra_desc, " ",
 						"(Must be precise)", NULL);
@@ -629,34 +628,33 @@ int json_events(const char *fn,
 						"(Precise event)", NULL);
 		}
 		snprintf(buf, sizeof buf, "event=%#llx", eventcode);
-		addfield(map, &je->event, ",", buf, NULL);
-		if (je->desc && extra_desc)
-			addfield(map, &je->desc, " ", extra_desc, NULL);
-		if (je->long_desc && extra_desc)
-			addfield(map, &je->long_desc, " ", extra_desc, NULL);
+		addfield(map, &je.event, ",", buf, NULL);
+		if (je.desc && extra_desc)
+			addfield(map, &je.desc, " ", extra_desc, NULL);
+		if (je.long_desc && extra_desc)
+			addfield(map, &je.long_desc, " ", extra_desc, NULL);
 		if (filter)
-			addfield(map, &je->event, ",", filter, NULL);
+			addfield(map, &je.event, ",", filter, NULL);
 		if (msr != NULL)
-			addfield(map, &je->event, ",", msr->pname, msrval);
-		if (je->name)
-			fixname(je->name);
+			addfield(map, &je.event, ",", msr->pname, msrval);
+		if (je.name)
+			fixname(je.name);
 
 		if (arch_std) {
 			/*
 			 * An arch standard event is referenced, so try to
 			 * fixup any unassigned values.
 			 */
-			err = try_fixup(fn, arch_std, eventcode, je);
+			err = try_fixup(fn, arch_std, eventcode, &je);
 			if (err)
 				goto free_strings;
 		}
-		je->event = real_event(je->name, je->event);
-		err = func(data, je);
+		je.event = real_event(je.name, je.event);
+		err = func(data, &je);
 free_strings:
 		free(extra_desc);
 		free(filter);
 		free(arch_std);
-		free(je);
 
 		if (err)
 			break;
