From: Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH v2] perf script/python: add new compaction-times script
Date: Thu, 20 Aug 2015 11:33:24 +0200
Message-ID: <55D59EE4.7040705@suse.cz>
References: <55C9BCC1.4030202@suse.cz>
 <1439840932-8933-1-git-send-email-tonyj@suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:49029 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751265AbbHTJd0 (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Thu, 20 Aug 2015 05:33:26 -0400
In-Reply-To: <1439840932-8933-1-git-send-email-tonyj@suse.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Tony Jones <tonyj@suse.com>, acme@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Mel Gorman <mgorman@suse.com>

On 08/17/2015 09:48 PM, Tony Jones wrote:
> This patch creates a new script (compaction-times) to report time
> spent in mm compaction. It is possible to report times in nanoseconds
> (default) or microseconds (-u). The option -p will break down results
> by process id, -pv will further decompose by each compaction entry/exit.
> For each compaction entry/exit what is reported is controlled by the
> options -t (report only timing), -m (report migration stats), -ms
> (report migration scanner stats) and -fs (report free scanner stats).
> The default is to report all.  Entries may be further filtered by pid,
> pid-range or comm (regex).
>
> The script is useful when analysing workloads that compact memory. The
> most common example will be THP allocations on systems with a lot of
> uptime that has fragmented memory. This is an example of using the script
> to analyse a thpscale from mmtests which deliberately fragments memory
> and allocates THP in 4 separate threads
>
>      # Recording step, one of the following;
>      $ perf record -e 'compaction:mm_compaction_*' ./workload
>      $ perf script record compaction-times
>
>      # Reporting: basic
>      total: 2444505743ns migration: moved=357738 failed=39275
>      free_scanner: scanned=2705578 isolated=387875
>      migration_scanner: scanned=414426 isolated=397013
>
>      # Reporting: Per task stall times
>      $ perf script report compaction-times -- -t -p
>      total: 2444505743ns
>      6384[thpscale]: 740800017ns
>      6385[thpscale]: 274119512ns
>      6386[thpscale]: 832961337ns
>      6383[thpscale]: 596624877ns
>
>      # Reporting: Per-compaction attempts for task 6385
>      $ perf script report compaction-times -- -m -pv 6385
>      total: 274119512ns migration: moved=14893 failed=24285
>      6385[thpscale]: 274119512ns migration: moved=14893 failed=24285
>      6385[thpscale].1: 3033277ns migration: moved=511 failed=1
>      6385[thpscale].2: 9592094ns migration: moved=1524 failed=12
>      6385[thpscale].3: 2495587ns migration: moved=512 failed=0
>      6385[thpscale].4: 2561766ns migration: moved=512 failed=0
>      6385[thpscale].5: 2523521ns migration: moved=512 failed=0
>      ..... output continues ...
>
> Changes since v1:
> - report stats for isolate_migratepages and isolate_freepages
>    (Vlastimil Babka)
> - refactor code to achieve above
> - add help text
> - output to stdout/stderr explicitly
>
> Signed-off-by: Tony Jones <tonyj@suse.com>
> Cc: Mel Gorman <mgorman@suse.com>
> Cc: Vlastimil Babka <vbabka@suse.cz>

Acked-by: Vlastimil Babka <vbabka@suse.cz>

Works for me, thanks. I'll leave it to perf experts to judge if the 
options and output formatting matches what's common for perf scripts.
