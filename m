From: Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH] perf script/python: add new compaction-times script
Date: Tue, 11 Aug 2015 11:13:37 +0200
Message-ID: <55C9BCC1.4030202@suse.cz>
References: <1438902116-9320-1-git-send-email-tonyj@suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1438902116-9320-1-git-send-email-tonyj@suse.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Jones <tonyj@suse.com>, acme@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Mel Gorman <mgorman@suse.com>
List-Id: linux-perf-users.vger.kernel.org

On 08/07/2015 01:01 AM, Tony Jones wrote:
> This patch creates a new script (compaction-times) to report time
> spent in mm compaction. Report times in nanoseconds (default) or
> microseconds (-u). Option -p will break down times by process id,
> -pv will further decompose by each compaction entry/exit.
> Entries may be further filtered by pid, pid-range or comm (regex).
>
> The script is useful when analysing workloads that compact memory.
> The most common example will be THP allocations on systems with a
> lot of uptime that has fragmented memory. This is an example of
> using the script to analyse a thpscale from mmtests which
> deliberately fragments memory and allocates THP in 4 separate
> threads
>
>     # Recording step, one of the following;
>     $ perf record -e 'compaction:mm_compaction_*' ./workload
>     $ perf script record compaction-times
>
>     # Reporting: basic
>     $ perf script report compaction-times
>     total: 15825912302ns (1416084 migrated 160674 failed)
>
>     # Reporting: Per task stall times
>     $ perf script report compaction-times -- -p
>     total: 15825912302ns (1416084 migrated 160674 failed)
>     5024[thpscale]: 2588338168ns (476189 migrated 32 failed)
>     5025[thpscale]: 2469205861ns (460767 migrated 7 failed)
>     5026[thpscale]: 8246032631ns (659 migrated 160621 failed)
>     5023[thpscale]: 2522335642ns (478469 migrated 14 failed)
>
>     # Reporting: Per-compaction attempt broken down by task
>     $ perf script report compaction-times -- -pv
>     total: 15825912302ns (1416084 migrated 160674 failed)
>     5024[thpscale]: 2588338168ns (476189 migrated 32 failed)
>     5024[thpscale].1: 3549721ns (352 migrated 0 failed)
>     5024[thpscale].2: 173091ns (32 migrated 0 failed)
>     5024[thpscale].3: 695548ns (160 migrated 0 failed)
>     5024[thpscale].4: 138561ns (32 migrated 0 failed)
>     5024[thpscale].5: 1123068ns (224 migrated 0 failed)
>     5024[thpscale].6: 163610ns (32 migrated 0 failed)
>     ..... output continues ...
>
> Signed-off-by: Tony Jones <tonyj@suse.com>

Tested-by: Vlastimil Babka <vbabka@suse.cz>

It would be nice, if the script also reported number of pages scanned 
and isolated by the compaction migration and free scanners.
This would provide the same metrics as vmstat, but possible to break 
down per process, which is useful.

You would need to process two extra tracepoints:
mm_compaction_isolate_migratepages
mm_compaction_isolate_freepages

Note that vmstat lumps the pages isolated in either of those into a 
shared counter COMPACTISOLATED, but for determining efficiency of each 
of the scanners, it would be better if the script reported them separately.

Thanks,
Vlastimil
