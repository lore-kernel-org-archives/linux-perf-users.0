From: kajoljain <kjain@linux.ibm.com>
Subject: Re: [PATCH v6] tools/perf/metricgroup: Fix printing event names of
 metric group with multiple events incase of overlapping events
Date: Fri, 20 Mar 2020 12:14:36 +0530
Message-ID: <caf17575-423a-b3f3-8fd5-e2e9925bb3bd@linux.ibm.com>
References: <20200221101121.28920-1-kjain@linux.ibm.com>
 <20200318192856.GQ11531@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200318192856.GQ11531@kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Andi Kleen <ak@linux.intel.com>, Kan Liang <kan.liang@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, Jin Yao <yao.jin@linux.intel.com>, Madhavan Srinivasan <maddy@linux.vnet.ibm.com>, Anju T Sudhakar <anju@linux.vnet.ibm.com>, Ravi Bangoria <ravi.bangoria@linux.ibm.com>
List-Id: linux-perf-users.vger.kernel.org



On 3/19/20 12:58 AM, Arnaldo Carvalho de Melo wrote:
> Em Fri, Feb 21, 2020 at 03:41:21PM +0530, Kajol Jain escreveu:
>> Commit f01642e4912b ("perf metricgroup: Support multiple
>> events for metricgroup") introduced support for multiple events
>> in a metric group. But with the current upstream, metric events
>> names are not printed properly incase we try to run multiple
>> metric groups with overlapping event.
>>
>> With current upstream version, incase of overlapping metric events
>> issue is, we always start our comparision logic from start.
>> So, the events which already matched with some metric group also
>> take part in comparision logic. Because of that when we have overlapping
>> events, we end up matching current metric group event with already matched
>> one.
>>
>> For example, in skylake machine we have metric event CoreIPC and
>> Instructions. Both of them need 'inst_retired.any' event value.
>> As events in Instructions is subset of events in CoreIPC, they
>> endup in pointing to same 'inst_retired.any' value.
>>
>> In skylake platform:
>>
>> command:# ./perf stat -M CoreIPC,Instructions  -C 0 sleep 1
>>
>>  Performance counter stats for 'CPU(s) 0':
>>
>>      1,254,992,790      inst_retired.any          # 1254992790.0
>>                                                     Instructions
>>                                                   #      1.3 CoreIPC
>>        977,172,805      cycles
>>      1,254,992,756      inst_retired.any
>>
>>        1.000802596 seconds time elapsed
>>
>> command:# sudo ./perf stat -M UPI,IPC sleep 1
>>
>>    Performance counter stats for 'sleep 1':
>>            948,650      uops_retired.retire_slots
>>            866,182      inst_retired.any          #      0.7 IPC
>>            866,182      inst_retired.any
>>          1,175,671      cpu_clk_unhalted.thread
>>
>> Patch fixes the issue by adding a new bool pointer 'evlist_used' to keep
>> track of events which already matched with some group by setting it true.
>> So, we skip all used events in list when we start comparision logic.
>> Patch also make some changes in comparision logic, incase we get a match
>> miss, we discard the whole match and start again with first event id in
>> metric event.
>>
>> With this patch:
>> In skylake platform:
>>
>> command:# ./perf stat -M CoreIPC,Instructions  -C 0 sleep 1
>>
>>  Performance counter stats for 'CPU(s) 0':
>>
>>          3,348,415      inst_retired.any          #      0.3 CoreIPC
>>         11,779,026      cycles
>>          3,348,381      inst_retired.any          # 3348381.0
>>                                                     Instructions
>>
>>        1.001649056 seconds time elapsed
>>
>> command:# ./perf stat -M UPI,IPC sleep 1
>>
>>  Performance counter stats for 'sleep 1':
>>
>>          1,023,148      uops_retired.retire_slots #      1.1 UPI
>>            924,976      inst_retired.any
>>            924,976      inst_retired.any          #      0.6 IPC
>>          1,489,414      cpu_clk_unhalted.thread
>>
>>        1.003064672 seconds time elapsed
>>
>> Signed-off-by: Kajol Jain <kjain@linux.ibm.com>
>> Acked-by: Jiri Olsa <jolsa@kernel.org>
> 
> This is an area I think needs some improvement, look how it ends up
> setting up the inst_retired.any multiple times:
> 
> [root@seventh ~]# perf stat -vv -M CoreIPC,Instructions  -C 0 sleep 1
> Using CPUID GenuineIntel-6-9E-9
> metric expr inst_retired.any / cycles for CoreIPC
> found event inst_retired.any
> found event cycles
> metric expr inst_retired.any for Instructions
> found event inst_retired.any
> adding {inst_retired.any,cycles}:W,{inst_retired.any}:W
> intel_pt default config: tsc,mtc,mtc_period=3,psb_period=3,pt,branch
> inst_retired.any -> cpu/event=0xc0,(null)=0x1e8483/
> inst_retired.any -> cpu/event=0xc0,(null)=0x1e8483/
> ------------------------------------------------------------
> perf_event_attr:
>   type                             4
>   size                             120
>   config                           0xc0
>   sample_type                      IDENTIFIER
>   read_format                      TOTAL_TIME_ENABLED|TOTAL_TIME_RUNNING|ID|GROUP
>   disabled                         1
>   inherit                          1
>   exclude_guest                    1
> ------------------------------------------------------------
> sys_perf_event_open: pid -1  cpu 0  group_fd -1  flags 0x8 = 3
> ------------------------------------------------------------
> perf_event_attr:
>   size                             120
>   sample_type                      IDENTIFIER
>   read_format                      TOTAL_TIME_ENABLED|TOTAL_TIME_RUNNING|ID|GROUP
>   inherit                          1
>   exclude_guest                    1
> ------------------------------------------------------------
> sys_perf_event_open: pid -1  cpu 0  group_fd 3  flags 0x8 = 4
> ------------------------------------------------------------
> perf_event_attr:
>   type                             4
>   size                             120
>   config                           0xc0
>   sample_type                      IDENTIFIER
>   read_format                      TOTAL_TIME_ENABLED|TOTAL_TIME_RUNNING
>   disabled                         1
>   inherit                          1
>   exclude_guest                    1
> ------------------------------------------------------------
> sys_perf_event_open: pid -1  cpu 0  group_fd -1  flags 0x8 = 5
> inst_retired.any: 0: 507070 1000948076 1000948076
> cycles: 0: 1250258 1000948076 1000948076
> inst_retired.any: 0: 507038 1000953052 1000953052
> inst_retired.any: 507070 1000948076 1000948076
> cycles: 1250258 1000948076 1000948076
> inst_retired.any: 507038 1000953052 1000953052
> 
>  Performance counter stats for 'CPU(s) 0':
> 
>            507,070      inst_retired.any          #      0.4 CoreIPC
>          1,250,258      cycles
>            507,038      inst_retired.any          # 507038.0 Instructions
> 
>        1.000964961 seconds time elapsed
> 
> [root@seventh ~]#
> 
> And it ends up printing the "inst_retired.any" multiple times, with
> different values, as after all two events were allocated, can't we
> notice this and set just one inst_retired.any and then when calculating
> the metrics just do something like:
> 
>   # perf stat -M CoreIPC,Instructions -C 0 sleep 1
> 
>  Performance counter stats for 'CPU(s) 0':
> 
>            507,070      inst_retired.any          #      0.4 CoreIPC,
> 						  #  507,070 Instructions
>          1,250,258      cycles
> 
>        1.000964961 seconds time elapsed
> #
> 
> ?
> 
> Ditto for:
> 
>     command:# perf stat -M UPI,IPC sleep 1
> 
>      Performance counter stats for 'sleep 1':
> 
>              1,023,148      uops_retired.retire_slots #      1.1 UPI
>                924,976      inst_retired.any
>                924,976      inst_retired.any          #      0.6 IPC
>              1,489,414      cpu_clk_unhalted.thread
> 
>            1.003064672 seconds time elapsed
> 
> Wouldn't this be better as:
> 
>     command:# perf stat -M UPI,IPC sleep 1
> 
>      Performance counter stats for 'sleep 1':
> 
>              1,023,148      uops_retired.retire_slots #      1.1 UPI
>                924,976      inst_retired.any
>              1,489,414      cpu_clk_unhalted.thread   #      0.6 IPC
> 
>            1.003064672 seconds time elapsed
> 
> This should help to look at many metrics at the same time by requiring
> less counters to be allocated, etc, or am I missing something here?

Hi Arnaldo,
	Yes that will be better. I will look into it from my end.

Thanks,
Kajol

> 
> Since this went thru multiple versions and Jiri is satisfied with it,
> I'm applying the patch, but please consider this suggestion.
> 
> - Arnaldo
> 
