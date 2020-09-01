From: Jiri Olsa <jolsa@redhat.com>
Subject: Re: [PATCH v6 2/5] perf/jevents: Add new structure to pass json
 fields.
Date: Tue, 1 Sep 2020 22:37:06 +0200
Message-ID: <20200901203706.GB656443@krava>
References: <20200827130958.189146-1-kjain@linux.ibm.com>
 <20200827130958.189146-3-kjain@linux.ibm.com>
 <20200831084357.GC287892@krava>
 <e0cd9e5c-2e9a-5198-108e-14998a757d62@linux.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <e0cd9e5c-2e9a-5198-108e-14998a757d62@linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: kajoljain <kjain@linux.ibm.com>
Cc: acme@kernel.org, peterz@infradead.org, mingo@redhat.com, mark.rutland@arm.com, alexander.shishkin@linux.intel.com, pc@us.ibm.com, namhyung@kernel.org, ak@linux.intel.com, yao.jin@linux.intel.com, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, irogers@google.com, maddy@linux.ibm.com, ravi.bangoria@linux.ibm.com, john.garry@huawei.com
List-Id: linux-perf-users.vger.kernel.org

On Tue, Sep 01, 2020 at 11:32:45AM +0530, kajoljain wrote:
> 
> 
> On 8/31/20 2:13 PM, Jiri Olsa wrote:
> > On Thu, Aug 27, 2020 at 06:39:55PM +0530, Kajol Jain wrote:
> > 
> > SNIP
> > 
> >> -	if (!*field)						\
> >> +#define TRY_FIXUP_FIELD(field) do { if (es->field && !je->field) {\
> >> +	je->field = strdup(es->field);				\
> >> +	if (!je->field)						\
> >>  		return -ENOMEM;					\
> >>  } } while (0)
> >>  
> >> @@ -428,11 +440,7 @@ static void free_arch_std_events(void)
> >>  	}
> >>  }
> >>  
> >> -static int save_arch_std_events(void *data, char *name, char *event,
> >> -				char *desc, char *long_desc, char *pmu,
> >> -				char *unit, char *perpkg, char *metric_expr,
> >> -				char *metric_name, char *metric_group,
> >> -				char *deprecated, char *metric_constraint)
> >> +static int save_arch_std_events(void *data, struct json_event *je)
> >>  {
> >>  	struct event_struct *es;
> >>  
> >> @@ -486,17 +494,16 @@ static char *real_event(const char *name, char *event)
> >>  		return NULL;
> >>  
> >>  	for (i = 0; fixed[i].name; i++)
> >> -		if (!strcasecmp(name, fixed[i].name))
> >> -			return (char *)fixed[i].event;
> >> +		if (!strcasecmp(name, fixed[i].name)) {
> >> +			strcpy(event, fixed[i].event);
> > 
> > hum what's this strcpy for in here? we're just replacing separated
> > variables with struct members, why do you need to copy the event in
> > here?
> > 
> 
> Hi Jiri,
>     Actually, initially when events is not part of 'json_event' structure, we are not
> assigning result of function `real_event` to event field. But as we are not passing
> event filed separately in functions like 'save_arch_std_events', freeing event
> memory was giving me issue as we are returning pointer from real_event function in some cases.
> So, that's why I replace it to strcpy to make sure we free je.event memory. Or should I remove
> free(je.event) part?
> 
> -		err = func(data, name, real_event(name, event), desc, long_desc,
> -			   pmu, unit, perpkg, metric_expr, metric_name,
> -			   metric_group, deprecated, metric_constraint);
> +		je.event = real_event(je.name, je.event);
> 
> This is the part, I am referring, here we are assigning result of real_event into je.event field.

hum, I dont't think you can strcpy like that in real_event,

but how about keeping the event variable on stack and freeing
just that one as the original code is doing.. like in change
below, it's diff against your patch

thanks,
jirka


---
diff --git a/tools/perf/pmu-events/jevents.c b/tools/perf/pmu-events/jevents.c
index b205cd904a4f..6abd2abf62fc 100644
--- a/tools/perf/pmu-events/jevents.c
+++ b/tools/perf/pmu-events/jevents.c
@@ -494,10 +494,8 @@ static char *real_event(const char *name, char *event)
 		return NULL;
 
 	for (i = 0; fixed[i].name; i++)
-		if (!strcasecmp(name, fixed[i].name)) {
-			strcpy(event, fixed[i].event);
+		if (!strcasecmp(name, fixed[i].name))
 			return event;
-		}
 	return event;
 }
 
@@ -546,6 +544,7 @@ int json_events(const char *fn,
 	EXPECT(tokens->type == JSMN_ARRAY, tokens, "expected top level array");
 	tok = tokens + 1;
 	for (i = 0; i < tokens->size; i++) {
+		char *event = NULL;
 		char *extra_desc = NULL;
 		char *filter = NULL;
 		struct json_event je = {};
@@ -570,7 +569,7 @@ int json_events(const char *fn,
 			       "Expected string value");
 
 			nz = !json_streq(map, val, "0");
-			if (match_field(map, field, nz, &je.event, val)) {
+			if (match_field(map, field, nz, &event, val)) {
 				/* ok */
 			} else if (json_streq(map, field, "EventCode")) {
 				char *code = NULL;
@@ -655,15 +654,15 @@ int json_events(const char *fn,
 						"(Precise event)", NULL);
 		}
 		snprintf(buf, sizeof buf, "event=%#llx", eventcode);
-		addfield(map, &je.event, ",", buf, NULL);
+		addfield(map, &event, ",", buf, NULL);
 		if (je.desc && extra_desc)
 			addfield(map, &je.desc, " ", extra_desc, NULL);
 		if (je.long_desc && extra_desc)
 			addfield(map, &je.long_desc, " ", extra_desc, NULL);
 		if (filter)
-			addfield(map, &je.event, ",", filter, NULL);
+			addfield(map, &event, ",", filter, NULL);
 		if (msr != NULL)
-			addfield(map, &je.event, ",", msr->pname, msrval);
+			addfield(map, &event, ",", msr->pname, msrval);
 		if (je.name)
 			fixname(je.name);
 
@@ -676,10 +675,10 @@ int json_events(const char *fn,
 			if (err)
 				goto free_strings;
 		}
-		je.event = real_event(je.name, je.event);
+		je.event = real_event(je.name, event);
 		err = func(data, &je);
 free_strings:
-		free(je.event);
+		free(event);
 		free(je.desc);
 		free(je.name);
 		free(je.long_desc);
