From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: [PATCH v2] perf script/python: add new compaction-times script
Date: Thu, 20 Aug 2015 16:42:42 -0300
Message-ID: <20150820194242.GD3154@kernel.org>
References: <55C9BCC1.4030202@suse.cz>
 <1439840932-8933-1-git-send-email-tonyj@suse.com>
 <55D59EE4.7040705@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <55D59EE4.7040705@suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Tony Jones <tonyj@suse.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Mel Gorman <mgorman@suse.com>
List-Id: linux-perf-users.vger.kernel.org

Em Thu, Aug 20, 2015 at 11:33:24AM +0200, Vlastimil Babka escreveu:
> On 08/17/2015 09:48 PM, Tony Jones wrote:
> >This patch creates a new script (compaction-times) to report time
> >spent in mm compaction. It is possible to report times in nanoseconds
> >(default) or microseconds (-u). The option -p will break down results
> >by process id, -pv will further decompose by each compaction entry/exit.
> >For each compaction entry/exit what is reported is controlled by the
> >options -t (report only timing), -m (report migration stats), -ms
> >(report migration scanner stats) and -fs (report free scanner stats).
> >The default is to report all.  Entries may be further filtered by pid,
> >pid-range or comm (regex).
> >
> >The script is useful when analysing workloads that compact memory. The
> >most common example will be THP allocations on systems with a lot of
> >uptime that has fragmented memory. This is an example of using the script
> >to analyse a thpscale from mmtests which deliberately fragments memory
> >and allocates THP in 4 separate threads
> >
> >     # Recording step, one of the following;
> >     $ perf record -e 'compaction:mm_compaction_*' ./workload
> >     $ perf script record compaction-times
> >
> >     # Reporting: basic
> >     total: 2444505743ns migration: moved=357738 failed=39275
> >     free_scanner: scanned=2705578 isolated=387875
> >     migration_scanner: scanned=414426 isolated=397013
> >
> >     # Reporting: Per task stall times
> >     $ perf script report compaction-times -- -t -p
> >     total: 2444505743ns
> >     6384[thpscale]: 740800017ns
> >     6385[thpscale]: 274119512ns
> >     6386[thpscale]: 832961337ns
> >     6383[thpscale]: 596624877ns
> >
> >     # Reporting: Per-compaction attempts for task 6385
> >     $ perf script report compaction-times -- -m -pv 6385
> >     total: 274119512ns migration: moved=14893 failed=24285
> >     6385[thpscale]: 274119512ns migration: moved=14893 failed=24285
> >     6385[thpscale].1: 3033277ns migration: moved=511 failed=1
> >     6385[thpscale].2: 9592094ns migration: moved=1524 failed=12
> >     6385[thpscale].3: 2495587ns migration: moved=512 failed=0
> >     6385[thpscale].4: 2561766ns migration: moved=512 failed=0
> >     6385[thpscale].5: 2523521ns migration: moved=512 failed=0
> >     ..... output continues ...
> >
> >Changes since v1:
> >- report stats for isolate_migratepages and isolate_freepages
> >   (Vlastimil Babka)
> >- refactor code to achieve above
> >- add help text
> >- output to stdout/stderr explicitly
> >
> >Signed-off-by: Tony Jones <tonyj@suse.com>
> >Cc: Mel Gorman <mgorman@suse.com>
> >Cc: Vlastimil Babka <vbabka@suse.cz>
> 
> Acked-by: Vlastimil Babka <vbabka@suse.cz>
> 
> Works for me, thanks. I'll leave it to perf experts to judge if the options
> and output formatting matches what's common for perf scripts.

Well, we don't have any firm set standard for outputting from scripts,
so if you did it inspired by existing scripts outputs, probably that is
good enough, having someone testing it is a plus, and in these cases, if
the "works for me" means you actually tested it, can we replace the
"Acked-by" with a "Tested-by"?

Ingo, others, comments on formatting?

- Arnaldo
