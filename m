From: kajoljain <kjain@linux.ibm.com>
Subject: Re: [PATCH v4] tools/perf/metricgroup: Fix printing event names of
 metric group with multiple events incase of overlapping events
Date: Tue, 18 Feb 2020 11:27:08 +0530
Message-ID: <d4ff2f6d-d3c4-a981-db7f-9becec7e51b2@linux.ibm.com>
References: <20200212054102.9259-1-kjain@linux.ibm.com>
 <20200216202143.GA145986@krava>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200216202143.GA145986@krava>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Olsa <jolsa@redhat.com>
Cc: acme@kernel.org, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Andi Kleen <ak@linux.intel.com>, Kan Liang <kan.liang@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, Jin Yao <yao.jin@linux.intel.com>, Madhavan Srinivasan <maddy@linux.vnet.ibm.com>, Anju T Sudhakar <anju@linux.vnet.ibm.com>, Ravi Bangoria <ravi.bangoria@linux.ibm.com>
List-Id: linux-perf-users.vger.kernel.org



On 2/17/20 1:51 AM, Jiri Olsa wrote:
> On Wed, Feb 12, 2020 at 11:11:02AM +0530, Kajol Jain wrote:
> 
> SNIP
> 
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
>> +	if (!evlist_used) {
>> +		ret = -ENOMEM;
>> +		break;
> 
> hum, how did this compile for you? ;-)
> 
> util/metricgroup.c: In function ‘metricgroup__setup_events’:
> util/metricgroup.c:170:3: error: break statement not within loop or switch
>   170 |   break;
> 
> 
Hi jiri,
        Yes you are right. My bad I send patch from other branch. Will send correct one.
Thanks,
Kajol

> jirka
> 
