From: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Subject: Re: [PATCH] tools/perf/metricgroup: Fix printing event names of
 metric group with multiple events
Date: Wed, 4 Dec 2019 12:25:22 +0530
Message-ID: <ed80bcc2-a507-bcf8-9084-181b18b6a95f@linux.ibm.com>
References: <20191120084059.24458-1-kjain@linux.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191120084059.24458-1-kjain@linux.ibm.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Kajol Jain <kjain@linux.ibm.com>, acme@kernel.org, Andi Kleen <ak@linux.intel.com>, Jin Yao <yao.jin@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, Kan Liang <kan.liang@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, Madhavan Srinivasan <maddy@linux.vnet.ibm.com>, Anju T Sudhakar <anju@linux.vnet.ibm.com>, Ravi Bangoria <ravi.bangoria@linux.ibm.com>
List-Id: linux-perf-users.vger.kernel.org



On 11/20/19 2:10 PM, Kajol Jain wrote:
> Commit f01642e4912b ("perf metricgroup: Support multiple
> events for metricgroup") introduced support for multiple events
> in a metric group. But with the current upstream, metric events
> names are not printed properly
> 
> In power9 platform:
> command:# ./perf stat --metric-only -M translation -C 0 -I 1000 sleep 2
>       1.000208486
>       2.000368863
>       2.001400558
> 
> Similarly in skylake platform:
> command:./perf stat --metric-only -M Power -I 1000
>       1.000579994
>       2.002189493
> 
> With current upstream version, issue is with event name comparison
> logic in find_evsel_group(). Current logic is to compare events
> belonging to a metric group to the events in perf_evlist.
> Since the break statement is missing in the loop used for comparison
> between metric group and perf_evlist events, the loop continues to
> execute even after getting a pattern match, and end up in discarding
> the matches.
> Incase of single metric event belongs to metric group, its working fine,
> because in case of single event once it compare all events it reaches to
> end of perf_evlist.
> 
> Example for single metric event in power9 platform
> command:# ./perf stat --metric-only  -M branches_per_inst -I 1000 sleep 1
>       1.000094653                  0.2
>       1.001337059                  0.0
> 
> Patch fixes the issue by making sure once we found all events
> belongs to that metric event matched in find_evsel_group(), we
> successfully break from that loop by adding corresponding condition.
> 
> With this patch:
> In power9 platform:
> 
> command:# ./perf stat --metric-only -M translation -C 0 -I 1000 sleep 2
> result:#           time derat_4k_miss_rate_percent  derat_4k_miss_ratio
>       derat_miss_ratio derat_64k_miss_rate_percent derat_64k_miss_ratio
>           dslb_miss_rate_percent islb_miss_rate_percent
>       1.000135672                         0.0                  0.3
>                    1.0                          0.0                  0.2
>                   0.0                     0.0
>       2.000380617                         0.0                  0.0
>                                                0.0                  0.0
>                  0.0                     0.0
> 
> command:# ./perf stat --metric-only -M Power -I 1000
> 
> Similarly in skylake platform:
> result:#           time    Turbo_Utilization    C3_Core_Residency
>              C6_Core_Residency    C7_Core_Residency     C2_Pkg_Residency
>               C3_Pkg_Residency     C6_Pkg_Residency     C7_Pkg_Residency
>       1.000563580                  0.3                  0.0
>                    2.6                44.2                 21.9
>                    0.0                  0.0                  0.0
>       2.002235027                  0.4                  0.0
>                    2.7           43.0                 20.7
>                    0.0                  0.0               0.0
> 
> Signed-off-by: Kajol Jain <kjain@linux.ibm.com>
> Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> Cc: Andi Kleen <ak@linux.intel.com>
> Cc: Jiri Olsa <jolsa@kernel.org>
> Cc: Kan Liang <kan.liang@linux.intel.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Jin Yao <yao.jin@linux.intel.com>
> Cc: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
> Cc: Anju T Sudhakar <anju@linux.vnet.ibm.com>
> Cc: Ravi Bangoria <ravi.bangoria@linux.ibm.com>

Fixes: f01642e4912b ("perf metricgroup: Support multiple events for metricgroup")
Reviewed-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>

But while looking at the patch, I found that, commit f01642e4912b
has (again) screwed up logic for metric with overlapping events.

   $ sudo ./perf stat -M UPI,IPC sleep 1

    Performance counter stats for 'sleep 1':

            948,650      uops_retired.retire_slots
            866,182      inst_retired.any          #      0.7 IPC
            866,182      inst_retired.any
          1,175,671      cpu_clk_unhalted.thread

This also needs to be fixed.

Ravi
