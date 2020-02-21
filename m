From: kajoljain <kjain@linux.ibm.com>
Subject: Re: [PATCH v5] tools/perf/metricgroup: Fix printing event names of
 metric group with multiple events incase of overlapping events
Date: Fri, 21 Feb 2020 15:12:15 +0530
Message-ID: <1346f859-601f-4d79-c0b9-2dda41e71354@linux.ibm.com>
References: <20200220050104.14094-1-kjain@linux.ibm.com>
 <20200220105645.GB553812@krava>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200220105645.GB553812@krava>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Olsa <jolsa@redhat.com>
Cc: acme@kernel.org, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Andi Kleen <ak@linux.intel.com>, Kan Liang <kan.liang@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, Jin Yao <yao.jin@linux.intel.com>, Madhavan Srinivasan <maddy@linux.vnet.ibm.com>, Anju T Sudhakar <anju@linux.vnet.ibm.com>, Ravi Bangoria <ravi.bangoria@linux.ibm.com>
List-Id: linux-perf-users.vger.kernel.org



On 2/20/20 4:26 PM, Jiri Olsa wrote:
> On Thu, Feb 20, 2020 at 10:31:04AM +0530, Kajol Jain wrote:
> 
> SNIP
> 
>> +				i++;
>> +				if (i == idnum)
>> +					break;
>>  			}
>>  		}
>>  	}
>> @@ -144,7 +142,10 @@ static struct evsel *find_evsel_group(struct evlist *perf_evlist,
>>  			    !strcmp(ev->name, metric_events[i]->name)) {
>>  				ev->metric_leader = metric_events[i];
>>  			}
>> +			j++;
>>  		}
>> +		ev = metric_events[i];
>> +		evlist_used[ev->idx] = true;
>>  	}
>>  
>>  	return metric_events[0];
>> @@ -160,6 +161,14 @@ static int metricgroup__setup_events(struct list_head *groups,
>>  	int ret = 0;
>>  	struct egroup *eg;
>>  	struct evsel *evsel;
>> +	bool *evlist_used;
>> +
>> +	evlist_used = (bool *)calloc(perf_evlist->core.nr_entries,
>> +				     sizeof(bool));
> 
> no need for the (bool *) cast

Hi Jiri,
     Should I resend patch with this change?
Thanks,
Kajol
> 
> other than that
> 
> Acked-by: Jiri Olsa <jolsa@redhat.com>
> 
> thanks,
> jirka
> 
