From: kajoljain <kjain@linux.ibm.com>
Subject: Re: [PATCH v5 09/11] perf/tools: Enhance JSON/metric infrastructure
 to handle "?"
Date: Wed, 18 Mar 2020 18:15:58 +0530
Message-ID: <15a73fa0-4c94-221f-020d-687f91d08de6@linux.ibm.com>
References: <20200317062333.14555-1-kjain@linux.ibm.com>
 <20200317062333.14555-10-kjain@linux.ibm.com> <20200317150647.GA757893@krava>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200317150647.GA757893@krava>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Olsa <jolsa@redhat.com>
Cc: acme@kernel.org, linuxppc-dev@lists.ozlabs.org, mpe@ellerman.id.au, sukadev@linux.vnet.ibm.com, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, anju@linux.vnet.ibm.com, maddy@linux.vnet.ibm.com, ravi.bangoria@linux.ibm.com, peterz@infradead.org, yao.jin@linux.intel.com, ak@linux.intel.com, jolsa@kernel.org, kan.liang@linux.intel.com, jmario@redhat.com, alexander.shishkin@linux.intel.com, mingo@kernel.org, paulus@ozlabs.org, namhyung@kernel.org, mpetlan@redhat.com, gregkh@linuxfoundation.org, benh@kernel.crashing.org, mamatha4@linux.vnet.ibm.com, mark.rutland@arm.com, tglx@linutronix.de
List-Id: linux-perf-users.vger.kernel.org



On 3/17/20 8:36 PM, Jiri Olsa wrote:
> On Tue, Mar 17, 2020 at 11:53:31AM +0530, Kajol Jain wrote:
> 
> SNIP
> 
>> diff --git a/tools/perf/util/expr.h b/tools/perf/util/expr.h
>> index 0938ad166ece..7786829b048b 100644
>> --- a/tools/perf/util/expr.h
>> +++ b/tools/perf/util/expr.h
>> @@ -17,12 +17,13 @@ struct expr_parse_ctx {
>>  
>>  struct expr_scanner_ctx {
>>  	int start_token;
>> +	int expr__runtimeparam;
> 
> no need for expr__ prefix in here.. jsut runtime_param

Hi Jiri,
	Will take care for this part.
> 
>> diff --git a/tools/perf/util/stat-shadow.c b/tools/perf/util/stat-shadow.c
>> index 402af3e8d287..85ac6d913782 100644
>> --- a/tools/perf/util/stat-shadow.c
>> +++ b/tools/perf/util/stat-shadow.c
>> @@ -336,7 +336,7 @@ void perf_stat__collect_metric_expr(struct evlist *evsel_list)
>>  		metric_events = counter->metric_events;
>>  		if (!metric_events) {
>>  			if (expr__find_other(counter->metric_expr, counter->name,
>> -						&metric_names, &num_metric_names) < 0)
>> +						&metric_names, &num_metric_names, 1) < 0)
>>  				continue;
>>  
>>  			metric_events = calloc(sizeof(struct evsel *),
>> @@ -777,7 +777,15 @@ static void generic_metric(struct perf_stat_config *config,
>>  	}
>>  
>>  	if (!metric_events[i]) {
>> -		if (expr__parse(&ratio, &pctx, metric_expr) == 0) {
>> +		int param = 1;
>> +		if (strstr(metric_expr, "?")) {
>> +			char *tmp = strrchr(metric_name, '_');
>> +
>> +			tmp++;
>> +			param = strtol(tmp, &tmp, 10);
>> +		}
> 
> so, if metric_expr contains '?' you go and search metric_name for '_'
> and use the number after '_' ... ugh.. what's the logic? 
> 
> I understand you create as many metrics as the magic runtime param
> tells you.. but what's the connection to this?
> 
> could you please outline in the changelog or comment the whole scheme
> of how this all should work? like step by step on some simple example?

Sure, will add that part as comment in my next patch series.
So, you are right, basically right now I am trying to create as many metric events
as define by runtime_param.

To do that, I add one loop in function `metricgroup__add_metric_runtime_param`
where, we are actually passing this parameter value as part of `expr__find_other` function
and changing "?" present in metric expression with this value.

And then adding this metric event to the tail of group_list.

As in our json file, there gonna be single metric event, and out of which we are creating
multiple events, I am also merging this value to the original metric name to specify parameter value.

For example,
command:# ./perf stat  -M PowerBUS_Frequency -C 0 -I 1000
#           time             counts unit events
     1.000101867          9,356,933      hv_24x7/pm_pb_cyc,chip=0/ #      2.3 GHz  PowerBUS_Frequency_0
     1.000101867          9,366,134      hv_24x7/pm_pb_cyc,chip=1/ #      2.3 GHz  PowerBUS_Frequency_1
     2.000314878          9,365,868      hv_24x7/pm_pb_cyc,chip=0/ #      2.3 GHz  PowerBUS_Frequency_0
     2.000314878          9,366,092      hv_24x7/pm_pb_cyc,chip=1/ #      2.3 GHz  PowerBUS_Frequency_1

So, here _0 and _1 after PowerBUS_Frequency specify parameter value.

So, after adding this to group_list, again we call expr__parse in generic_metric function present in
util/stat-display.c. By this time again we need to pass this parameter value. So, now to get this value actually
I am trying to extract it from metric name itself. Not sure if its good way to do that.

Is it sound fine, or should I add param as part of structure evsel as well. So, another way to do that
is adding this parameter in `evsel` structure and also egroup structure. So, I will update this value
in metricgroup.c and access it in stat-shadow?

Thanks,
Kajol
  

> 
> thanks,
> jirka
> 
