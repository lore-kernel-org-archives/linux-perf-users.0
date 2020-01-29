From: kajoljain <kjain@linux.ibm.com>
Subject: Re: [PATCH v2] tools/perf/metricgroup: Fix printing event names of
 metric group with multiple events incase of overlapping events
Date: Wed, 29 Jan 2020 12:10:22 +0530
Message-ID: <238f6f80-dc3e-3245-2fc0-a10e37e49a74@linux.ibm.com>
References: <20200122064721.24276-1-kjain@linux.ibm.com>
 <20200127154110.GF1114818@krava>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200127154110.GF1114818@krava>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Olsa <jolsa@redhat.com>
Cc: acme@kernel.org, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Andi Kleen <ak@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, Kan Liang <kan.liang@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, Jin Yao <yao.jin@linux.intel.com>, Madhavan Srinivasan <maddy@linux.vnet.ibm.com>, Anju T Sudhakar <anju@linux.vnet.ibm.com>, Ravi Bangoria <ravi.bangoria@linux.ibm.com>
List-Id: linux-perf-users.vger.kernel.org


On 1/27/20 9:11 PM, Jiri Olsa wrote:
> On Wed, Jan 22, 2020 at 12:17:21PM +0530, Kajol Jain wrote:
>
> SNIP
>
>> Cc: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
>> Cc: Anju T Sudhakar <anju@linux.vnet.ibm.com>
>> Cc: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
>> ---
>>   tools/perf/util/evlist.h      |  1 +
>>   tools/perf/util/metricgroup.c | 14 +++++++++++++-
>>   2 files changed, 14 insertions(+), 1 deletion(-)
>>
>> ---
>> Changelog:
>> v1 -> v2
>> - Rather then adding static variable in metricgroup.c,
>>    add a new variable in evlist itself with name 'evlist_iter'
>> ---
>> diff --git a/tools/perf/util/evlist.h b/tools/perf/util/evlist.h
>> index f5bd5c386df1..255f872aee92 100644
>> --- a/tools/perf/util/evlist.h
>> +++ b/tools/perf/util/evlist.h
>> @@ -54,6 +54,7 @@ struct evlist {
>>   	bool		 enabled;
>>   	int		 id_pos;
>>   	int		 is_pos;
>> +	int		 evlist_iter;
>>   	u64		 combined_sample_type;
>>   	enum bkw_mmap_state bkw_mmap_state;
>>   	struct {
>> diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
>> index 02aee946b6c1..911fab4ac04b 100644
>> --- a/tools/perf/util/metricgroup.c
>> +++ b/tools/perf/util/metricgroup.c
>> @@ -96,10 +96,13 @@ static struct evsel *find_evsel_group(struct evlist *perf_evlist,
>>   				      struct evsel **metric_events)
>>   {
>>   	struct evsel *ev;
>> -	int i = 0;
>> +	int i = 0, j = 0;
>>   	bool leader_found;
>>   
>>   	evlist__for_each_entry (perf_evlist, ev) {
>> +		j++;
>> +		if (j <= perf_evlist->evlist_iter)
>> +			continue;
> hm, but that won't work when event does not match and all
> is rolled over in th next condition, no?

Hi jiri,

     Thanks for the review. Yes you are right. Need to take care of that 
case.

>
> how about something like below.. I only checked I got same
> results as you did in the changelog, but haven't tested
> otherwise.. especially I think that the check I removed
> is redundant
>
> could you please also add test for this testcase?
>
> thanks,
> jirka
>
>
> ---
> diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
> index 02aee946b6c1..c12f3efccec8 100644
> --- a/tools/perf/util/metricgroup.c
> +++ b/tools/perf/util/metricgroup.c
> @@ -93,13 +93,16 @@ struct egroup {
>   static struct evsel *find_evsel_group(struct evlist *perf_evlist,
>   				      const char **ids,
>   				      int idnum,
> -				      struct evsel **metric_events)
> +				      struct evsel **metric_events,
> +				      bool used[])
>   {
>   	struct evsel *ev;
> -	int i = 0;
> +	int i = 0, j = 0;
>   	bool leader_found;
>   
>   	evlist__for_each_entry (perf_evlist, ev) {
> +		if (used[j++])
> +			continue;
>   		if (!strcmp(ev->name, ids[i])) {
>   			if (!metric_events[i])
>   				metric_events[i] = ev;
> @@ -107,22 +110,11 @@ static struct evsel *find_evsel_group(struct evlist *perf_evlist,
>   			if (i == idnum)
>   				break;
>   		} else {
> -			if (i + 1 == idnum) {
> +			if (i) {
>   				/* Discard the whole match and start again */
>   				i = 0;
>   				memset(metric_events, 0,
>   				       sizeof(struct evsel *) * idnum);
> -				continue;
> -			}
> -
> -			if (!strcmp(ev->name, ids[i]))
> -				metric_events[i] = ev;
> -			else {
> -				/* Discard the whole match and start again */
> -				i = 0;
> -				memset(metric_events, 0,
> -				       sizeof(struct evsel *) * idnum);
> -				continue;
>   			}

Incase we have match miss, we need to restart the match comparison again.

But I think we can't totally remove this check as, we also need to make 
sure we take current event in match logic. Maybe something like this:

                 } else {

-                       if (i + 1 == idnum) {
-                               /* Discard the whole match and start 
again */
-                               i = 0;
-                               memset(metric_events, 0,
-                                      sizeof(struct evsel *) * idnum);
-                               continue;
-                       }
-
-                       if (!strcmp(ev->name, ids[i]))
-                               metric_events[i] = ev;
-                       else {
-                               /* Discard the whole match and start 
again */
-                               i = 0;
-                               memset(metric_events, 0,
-                                      sizeof(struct evsel *) * idnum);
-                               continue;

+                       /* Discard the whole match and start again */
+                       i = 0;
+                       memset(metric_events, 0,
+                               sizeof(struct evsel *) * idnum);
+
+                       if (!strcmp(ev->name, ids[i])) {
+                               if (!metric_events[i])
+                                       metric_events[i] = ev;
+                               i++;
+                               if (i == idnum)
+                                       break;
                         }

Please let me know if it sounds fine.

Thanks,

Kajol

>   		}
>   	}
> @@ -144,9 +136,11 @@ static struct evsel *find_evsel_group(struct evlist *perf_evlist,
>   			    !strcmp(ev->name, metric_events[i]->name)) {
>   				ev->metric_leader = metric_events[i];
>   			}
> +			j++;
>   		}
> +		ev = metric_events[i];
> +		used[ev->idx] = true;
>   	}
> -
>   	return metric_events[0];
>   }
>   
> @@ -160,6 +154,9 @@ static int metricgroup__setup_events(struct list_head *groups,
>   	int ret = 0;
>   	struct egroup *eg;
>   	struct evsel *evsel;
> +	bool used[perf_evlist->core.nr_entries];
> +
> +	memset(used, 0, perf_evlist->core.nr_entries);
>   
>   	list_for_each_entry (eg, groups, nd) {
>   		struct evsel **metric_events;
> @@ -170,7 +167,7 @@ static int metricgroup__setup_events(struct list_head *groups,
>   			break;
>   		}
>   		evsel = find_evsel_group(perf_evlist, eg->ids, eg->idnum,
> -					 metric_events);
> +					 metric_events, used);
>   		if (!evsel) {
>   			pr_debug("Cannot resolve %s: %s\n",
>   					eg->metric_name, eg->metric_expr);
>
