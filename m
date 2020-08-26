From: kajoljain <kjain@linux.ibm.com>
Subject: Re: [RFC] perf/jevents: Add new structure to pass json fields.
Date: Wed, 26 Aug 2020 17:02:04 +0530
Message-ID: <6a4e977e-4f77-6a2a-252c-cfdda26db3e2@linux.ibm.com>
References: <20200825074041.378520-1-kjain@linux.ibm.com>
 <20200826105656.GC703542@krava>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200826105656.GC703542@krava>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Olsa <jolsa@redhat.com>
Cc: acme@kernel.org, ak@linux.intel.com, yao.jin@linux.intel.com, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, irogers@google.com, maddy@linux.ibm.com, ravi.bangoria@linux.ibm.com
List-Id: linux-perf-users.vger.kernel.org



On 8/26/20 4:26 PM, Jiri Olsa wrote:
> On Tue, Aug 25, 2020 at 01:10:41PM +0530, Kajol Jain wrote:
> 
> SNIP
> 
>>  {
>>  	/* try to find matching event from arch standard values */
>>  	struct event_struct *es;
>> @@ -498,8 +486,7 @@ try_fixup(const char *fn, char *arch_std, char **event, char **desc,
>>  		if (!strcmp(arch_std, es->name)) {
>>  			if (!eventcode && es->event) {
>>  				/* allow EventCode to be overridden */
>> -				free(*event);
>> -				*event = NULL;
>> +				je->event = NULL;
>>  			}
>>  			FOR_ALL_EVENT_STRUCT_FIELDS(TRY_FIXUP_FIELD);
>>  			return 0;
>> @@ -513,13 +500,8 @@ try_fixup(const char *fn, char *arch_std, char **event, char **desc,
>>  
>>  /* Call func with each event in the json file */
>>  int json_events(const char *fn,
>> -	  int (*func)(void *data, char *name, char *event, char *desc,
>> -		      char *long_desc,
>> -		      char *pmu, char *unit, char *perpkg,
>> -		      char *metric_expr,
>> -		      char *metric_name, char *metric_group,
>> -		      char *deprecated, char *metric_constraint),
>> -	  void *data)
>> +		int (*func)(void *data, struct json_event *je),
>> +			void *data)
>>  {
>>  	int err;
>>  	size_t size;
>> @@ -537,24 +519,16 @@ int json_events(const char *fn,
>>  	EXPECT(tokens->type == JSMN_ARRAY, tokens, "expected top level array");
>>  	tok = tokens + 1;
>>  	for (i = 0; i < tokens->size; i++) {
>> -		char *event = NULL, *desc = NULL, *name = NULL;
>> -		char *long_desc = NULL;
>>  		char *extra_desc = NULL;
>> -		char *pmu = NULL;
>>  		char *filter = NULL;
>> -		char *perpkg = NULL;
>> -		char *unit = NULL;
>> -		char *metric_expr = NULL;
>> -		char *metric_name = NULL;
>> -		char *metric_group = NULL;
>> -		char *deprecated = NULL;
>> -		char *metric_constraint = NULL;
>> +		struct json_event *je;
>>  		char *arch_std = NULL;
>>  		unsigned long long eventcode = 0;
>>  		struct msrmap *msr = NULL;
>>  		jsmntok_t *msrval = NULL;
>>  		jsmntok_t *precise = NULL;
>>  		jsmntok_t *obj = tok++;
>> +		je = (struct json_event *)calloc(1, sizeof(struct json_event));
> 
> hum, you don't check je pointer in here.. but does it need to be allocated?
> looks like you could just have je on stack as well..

Hi Jiri,
   Yes I will add check for je pointer here.The reason for allocating memory to 'je' is,
later we are actually referring one by one to its field and in case if won't allocate memory
we will get segmentaion fault as otherwise je will be NULL. Please let me know if I am
getting correct.

Thanks,
Kajol Jain

> 
> thanks,
> jirka
> 
