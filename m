Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2507A27726;
	Fri, 24 Jan 2025 19:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737745364; cv=none; b=l6Oz5tLcqo18pCWwFfM/xlZGeX9UH6/56gTh2cqe0YQI/Uh9co1n6eSjhqD4P86SDH09/xFkl0xTVMEnDjBLaJ6CqPa/aMk9MPz77wgqGBddj4YkeZAS4ujGg4duLRGU6VfiwL348QDNw7xe6wEOmiTkgS7K+SI+yhXwT0OayfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737745364; c=relaxed/simple;
	bh=YFtcT8k7o8CPcQY9L20EbU0kNi1+wv73jVxtEmSnSbo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kvaXIOv6c3RFIdB8hl7X476X9iXnyK3KfBe0bvXgb65dCbEWO8ybHxCW6cAjWmeapXlVbM9WtgVoR5JEjjxsb5jG4EomZdhdLjiwhoSK5BDnvuiAohLTwzYQSUxRYgdtMAhkZuiNkAy9cQYLT8MGcS8WwG0Rd6Jrl9/b3AXzEVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sPk9PS3q; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sPk9PS3q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72123C4CED2;
	Fri, 24 Jan 2025 19:02:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737745362;
	bh=YFtcT8k7o8CPcQY9L20EbU0kNi1+wv73jVxtEmSnSbo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sPk9PS3qb8m0qW1OljuK7+Fbp7pj0ryfcSteg4WxGLSMFMoXTLlBtQWkWYSqINwqJ
	 oii80noJBagrXX1EmQOD7rvGNLIlqDzkNCKk8EVyDTF6eOLOijSyLWUXXjYqY1GS5S
	 8gIoCzA5yJwV5RB1cOBkSnBFHXvjt9q1Dfj8IILB6WakdQUT+6LBOIGAaIff9CPzhW
	 5loQVDqJLui8bEpHZlc0KzBaUzoDPrk533a8EX7QuNXWnkZgNKyczXeEOc4ElFsRZo
	 SBpsiKB0MqfPjn7ZuxHH1nlDICHe4hOHlYAT8yUVDPUnvNmctylXSrM9i8nNu5uJcf
	 NwATgh3plFEKA==
Date: Fri, 24 Jan 2025 11:02:41 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: Dmitry Vyukov <dvyukov@google.com>
Cc: irogers@google.com, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] perf report: Add wall-clock and parallelism profiling
Message-ID: <Z5Pj0dwelXtG06qm@google.com>
References: <CACT4Y+b4WYa9TSqKtDKTJNgXth1U30=KddutfSdp5gmXVOV_jA@mail.gmail.com>
 <20250113134022.2545894-1-dvyukov@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250113134022.2545894-1-dvyukov@google.com>

On Mon, Jan 13, 2025 at 02:40:06PM +0100, Dmitry Vyukov wrote:
> There are two notions of time: wall-clock time and CPU time.
> For a single-threaded program, or a program running on a single-core
> machine, these notions are the same. However, for a multi-threaded/
> multi-process program running on a multi-core machine, these notions are
> significantly different. Each second of wall-clock time we have
> number-of-cores seconds of CPU time.
> 
> Currently perf only allows to profile CPU time. Perf (and all other
> existing profilers to the be best of my knowledge) does not allow to
> profile wall-clock time.
> 
> Optimizing CPU overhead is useful to improve 'throughput', while
> optimizing wall-clock overhead is useful to improve 'latency'.
> These profiles are complementary and are not interchangeable.
> Examples of where wall-clock profile is needed:
>  - optimzing build latency
>  - optimizing server request latency
>  - optimizing ML training/inference latency
>  - optimizing running time of any command line program
> 
> CPU profile is useless for these use cases at best (if a user understands
> the difference), or misleading at worst (if a user tries to use a wrong
> profile for a job).
> 
> This patch adds wall-clock and parallelization profiling.
> See the added documentation and flags descriptions for details.
> 
> Brief outline of the implementation:
>  - add context switch collection during record
>  - calculate number of threads running on CPUs (parallelism level)
>    during report
>  - divide each sample weight by the parallelism level
> This effectively models that we were taking 1 sample per unit of
> wall-clock time.
> 
> The feature is added on an equal footing with the existing CPU profiling
> rather than a separate mode enabled with special flags. The reasoning is
> that users may not understand the problem and the meaning of numbers they
> are seeing in the first place, so won't even realize that they may need
> to be looking for some different profiling mode. When they are presented
> with 2 sets of different numbers, they should start asking questions.

Can you please split the change into pieces?  It'd be helpful to
reviewrs.  I think you can do:

* add parallelism sort key
* add parallelism filter
* add wallclock output field
* organize the feature using a proper option or config

> 
> Signed-off-by: Dmitry Vyukov <dvyukov@google.com>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Cc: Ian Rogers <irogers@google.com>
> Cc: linux-perf-users@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> 
> ---
> Changes in v2:
>  - just rebased and changed subject
> ---
>  .../callchain-overhead-calculation.txt        |  5 +-
>  .../cpu-and-wallclock-overheads.txt           | 85 +++++++++++++++++
>  tools/perf/Documentation/perf-report.txt      | 50 ++++++----
>  tools/perf/Documentation/tips.txt             |  3 +
>  tools/perf/builtin-record.c                   |  6 ++
>  tools/perf/builtin-report.c                   | 30 ++++++
>  tools/perf/ui/browsers/hists.c                | 27 ++++--
>  tools/perf/ui/hist.c                          | 61 +++++++++++--
>  tools/perf/util/addr_location.c               |  1 +
>  tools/perf/util/addr_location.h               |  6 +-
>  tools/perf/util/event.c                       |  6 ++
>  tools/perf/util/events_stats.h                |  2 +
>  tools/perf/util/hist.c                        | 91 ++++++++++++++++---
>  tools/perf/util/hist.h                        | 25 ++++-
>  tools/perf/util/machine.c                     |  7 ++
>  tools/perf/util/machine.h                     |  6 ++
>  tools/perf/util/session.c                     | 12 +++
>  tools/perf/util/session.h                     |  1 +
>  tools/perf/util/sort.c                        | 59 +++++++++++-
>  tools/perf/util/sort.h                        |  1 +
>  tools/perf/util/symbol.c                      | 34 +++++++
>  tools/perf/util/symbol_conf.h                 |  7 +-
>  22 files changed, 467 insertions(+), 58 deletions(-)
>  create mode 100644 tools/perf/Documentation/cpu-and-wallclock-overheads.txt
> 
> diff --git a/tools/perf/Documentation/callchain-overhead-calculation.txt b/tools/perf/Documentation/callchain-overhead-calculation.txt
> index 1a757927195ed..e0202bf5bd1a0 100644
> --- a/tools/perf/Documentation/callchain-overhead-calculation.txt
> +++ b/tools/perf/Documentation/callchain-overhead-calculation.txt
> @@ -1,7 +1,8 @@
>  Overhead calculation
>  --------------------
> -The overhead can be shown in two columns as 'Children' and 'Self' when
> -perf collects callchains.  The 'self' overhead is simply calculated by
> +The CPU overhead can be shown in two columns as 'Children' and 'Self'
> +when perf collects callchains (and corresponding 'Wall' columns for
> +wall-clock overhead).  The 'self' overhead is simply calculated by
>  adding all period values of the entry - usually a function (symbol).
>  This is the value that perf shows traditionally and sum of all the
>  'self' overhead values should be 100%.
> diff --git a/tools/perf/Documentation/cpu-and-wallclock-overheads.txt b/tools/perf/Documentation/cpu-and-wallclock-overheads.txt
> new file mode 100644
> index 0000000000000..4f739ff4de437
> --- /dev/null
> +++ b/tools/perf/Documentation/cpu-and-wallclock-overheads.txt
> @@ -0,0 +1,85 @@
> +CPU and wall-clock overheads
> +----------------------------
> +There are two notions of time: wall-clock time and CPU time.
> +For a single-threaded program, or a program running on a single-core machine,
> +these notions are the same. However, for a multi-threaded/multi-process program
> +running on a multi-core machine, these notions are significantly different.
> +Each second of wall-clock time we have number-of-cores seconds of CPU time.
> +Perf can measure overhead for both of these times (shown in 'overhead' and
> +'wallclock' columns for CPU and wall-clock correspondingly).
> +
> +Optimizing CPU overhead is useful to improve 'throughput', while optimizing
> +wall-clock overhead is useful to improve 'latency'. It's important to understand
> +which one is useful in a concrete situation at hand. For example, the former
> +may be useful to improve max throughput of a CI build server that runs on 100%
> +CPU utilization, while the latter may be useful to improve user-perceived
> +latency of a single interactive program build.
> +These overheads may be significantly different in some cases. For example,
> +consider a program that executes function 'foo' for 9 seconds with 1 thread,
> +and then executes function 'bar' for 1 second with 128 threads (consumes
> +128 seconds of CPU time). The CPU overhead is: 'foo' - 6.6%, 'bar' - 93.4%.
> +While wall-clock overhead is: 'foo' - 90%, 'bar' - 10%. If we try to optimize
> +running time of the program looking at the (wrong in this case) CPU overhead,
> +we would concentrate on the function 'bar', but it can yield only 10% running
> +time improvement at best.
> +
> +By default, perf shows both overheads (for parallel programs), but sorts by
> +CPU overhead:
> +
> +-----------------------------------
> +Overhead  Wallclock  Command
> +  93.88%     25.79%  cc1
> +   1.90%     39.87%  gzip
> +   0.99%     10.16%  dpkg-deb
> +   0.57%      1.00%  as
> +   0.40%      0.46%  sh
> +-----------------------------------
> +
> +To sort by wall-clock overhead, use '--sort=wallclock' flag:

Strictly speaking, 'wallclock' is not a sort key.  It's an output field
like 'overhead'.  It can be used as a sort key but it'd be meaningless
unless it's used with other sort keys or output field (using -F option).

For example, I got this with 'overhead' only.

  $ perf report -s overhead
  ...
  #
  # Overhead
  # ........
  #
     100.00%

This is because perf uses --sort option in a different meaning.  It's
more like 'group-by'.  But, probably more confusingly, it has the
original meaning when it used with -F/--fields option.

So the correct way to do it would be:

  $ perf report -F wallclock,overhead,comm -s wallclock

But it's cumbersome.. :(

Also I'm not still happy with the name "Wallclock".  If it shows any
events contributing to latency, maybe we can call it "Latency"?

> +
> +-----------------------------------
> +Wallclock  Overhead  Command
> +   39.87%     1.90%  gzip
> +   25.79%    93.88%  cc1
> +   10.16%     0.99%  dpkg-deb
> +    4.17%     0.29%  git
> +    2.81%     0.11%  objtool
> +-----------------------------------
> +
> +To get insight into the difference between the overheads, you may check
> +parallelization histogram with '--sort=wallclock,parallelism,comm,symbol --hierarchy'
> +flags. It shows fraction of (wall-clock) time the workload utilizes different
> +numbers of cores ('parallelism' column). For example, in the following case
> +the workload utilizes only 1 core most of the time, but also has some
> +highly-parallel phases, which explains significant difference between
> +CPU and wall-clock overheads:
> +
> +-----------------------------------
> +  Wallclock  Overhead     Parallelism / Command / Symbol
> ++    56.98%     2.29%     1
> ++    16.94%     1.36%     2
> ++     4.00%    20.13%     125
> ++     3.66%    18.25%     124
> ++     3.48%    17.66%     126
> ++     3.26%     0.39%     3
> ++     2.61%    12.93%     123
> +-----------------------------------
> +
> +By expanding corresponding lines, you may see what programs/functions run
> +at the given parallelism level:
> +
> +-----------------------------------
> +  Wallclock  Overhead     Parallelism / Command / Symbol
> +-    56.98%     2.29%     1
> +        32.80%     1.32%     gzip
> +         4.46%     0.18%     cc1
> +         2.81%     0.11%     objtool
> +         2.43%     0.10%     dpkg-source
> +         2.22%     0.09%     ld
> +         2.10%     0.08%     dpkg-genchanges
> +-----------------------------------
> +
> +To see the normal function-level profile for particular parallelism levels
> +(number of threads actively running on CPUs), you may use '--parallelism'
> +filter. For example, to see the profile only for low parallelism phases
> +of a workload use '--sort=wallclock,comm,symbol --parallelism=1-2' flags.
> diff --git a/tools/perf/Documentation/perf-report.txt b/tools/perf/Documentation/perf-report.txt
> index 87f8645194062..e79ff412af0a5 100644
> --- a/tools/perf/Documentation/perf-report.txt
> +++ b/tools/perf/Documentation/perf-report.txt
> @@ -44,7 +44,7 @@ OPTIONS
>  --comms=::
>  	Only consider symbols in these comms. CSV that understands
>  	file://filename entries.  This option will affect the percentage of
> -	the overhead column.  See --percentage for more info.
> +	the overhead and wallclock columns.  See --percentage for more info.
>  --pid=::
>          Only show events for given process ID (comma separated list).
>  
> @@ -54,12 +54,12 @@ OPTIONS
>  --dsos=::
>  	Only consider symbols in these dsos. CSV that understands
>  	file://filename entries.  This option will affect the percentage of
> -	the overhead column.  See --percentage for more info.
> +	the overhead and wallclock columns.  See --percentage for more info.
>  -S::
>  --symbols=::
>  	Only consider these symbols. CSV that understands
>  	file://filename entries.  This option will affect the percentage of
> -	the overhead column.  See --percentage for more info.
> +	the overhead and wallclock columns.  See --percentage for more info.
>  
>  --symbol-filter=::
>  	Only show symbols that match (partially) with this filter.
> @@ -68,6 +68,16 @@ OPTIONS
>  --hide-unresolved::
>          Only display entries resolved to a symbol.
>  
> +--parallelism::
> +        Only consider these parallelism levels. Parallelism level is the number
> +        of threads that actively run on CPUs at the time of sample. The flag
> +        accepts single number, comma-separated list, and ranges (for example:
> +        "1", "7,8", "1,64-128"). This is useful in understanding what a program
> +        is doing during sequential/low-parallelism phases as compared to
> +        high-parallelism phases. This option will affect the percentage of
> +        the overhead and wallclock columns. See --percentage for more info.
> +        Also see the `CPU and wall-clock overheads' section for more details.
> +
>  -s::
>  --sort=::
>  	Sort histogram entries by given key(s) - multiple keys can be specified
> @@ -87,6 +97,7 @@ OPTIONS
>  	entries are displayed as "[other]".
>  	- cpu: cpu number the task ran at the time of sample
>  	- socket: processor socket number the task ran at the time of sample
> +	- parallelism: number of running threads at the time of sample
>  	- srcline: filename and line number executed at the time of sample.  The
>  	DWARF debugging info must be provided.
>  	- srcfile: file name of the source file of the samples. Requires dwarf
> @@ -97,12 +108,14 @@ OPTIONS
>  	- cgroup_id: ID derived from cgroup namespace device and inode numbers.
>  	- cgroup: cgroup pathname in the cgroupfs.
>  	- transaction: Transaction abort flags.
> -	- overhead: Overhead percentage of sample
> -	- overhead_sys: Overhead percentage of sample running in system mode
> -	- overhead_us: Overhead percentage of sample running in user mode
> -	- overhead_guest_sys: Overhead percentage of sample running in system mode
> +	- overhead: CPU overhead percentage of sample
> +	- wallclock: Wall-clock (latency) overhead percentage of sample.
> +	  See the `CPU and wall-clock overheads' section for more details.
> +	- overhead_sys: CPU overhead percentage of sample running in system mode
> +	- overhead_us: CPU overhead percentage of sample running in user mode
> +	- overhead_guest_sys: CPU overhead percentage of sample running in system mode
>  	on guest machine
> -	- overhead_guest_us: Overhead percentage of sample running in user mode on
> +	- overhead_guest_us: CPU overhead percentage of sample running in user mode on
>  	guest machine
>  	- sample: Number of sample
>  	- period: Raw number of event count of sample
> @@ -125,8 +138,9 @@ OPTIONS
>  	- weight2: Average value of event specific weight (2nd field of weight_struct).
>  	- weight3: Average value of event specific weight (3rd field of weight_struct).
>  
> -	By default, comm, dso and symbol keys are used.
> -	(i.e. --sort comm,dso,symbol)
> +	By default, overhead, comm, dso and symbol keys are used.
> +	(i.e. --sort overhead,comm,dso,symbol). If only wallclock is specified,
> +	(i.e. --sort wallclock), it expands to wallclock,comm,dso,symbol.
>  
>  	If --branch-stack option is used, following sort keys are also
>  	available:
> @@ -201,9 +215,9 @@ OPTIONS
>  --fields=::
>  	Specify output field - multiple keys can be specified in CSV format.
>  	Following fields are available:
> -	overhead, overhead_sys, overhead_us, overhead_children, sample, period,
> -	weight1, weight2, weight3, ins_lat, p_stage_cyc and retire_lat.  The
> -	last 3 names are alias for the corresponding weights.  When the weight
> +	overhead, wallclock, overhead_sys, overhead_us, overhead_children, sample,
> +	period, weight1, weight2, weight3, ins_lat, p_stage_cyc and retire_lat.
> +	The last 3 names are alias for the corresponding weights.  When the weight
>  	fields are used, they will show the average value of the weight.
>  
>  	Also it can contain any sort key(s).
> @@ -289,7 +303,7 @@ OPTIONS
>  	Accumulate callchain of children to parent entry so that then can
>  	show up in the output.  The output will have a new "Children" column
>  	and will be sorted on the data.  It requires callchains are recorded.
> -	See the `overhead calculation' section for more details. Enabled by
> +	See the `Overhead calculation' section for more details. Enabled by
>  	default, disable with --no-children.
>  
>  --max-stack::
> @@ -442,9 +456,9 @@ OPTIONS
>  	--call-graph option for details.
>  
>  --percentage::
> -	Determine how to display the overhead percentage of filtered entries.
> -	Filters can be applied by --comms, --dsos and/or --symbols options and
> -	Zoom operations on the TUI (thread, dso, etc).
> +	Determine how to display the CPU and wall-clock overhead percentage
> +	of filtered entries. Filters can be applied by --comms, --dsos, --symbols
> +	and/or --parallelism options and Zoom operations on the TUI (thread, dso, etc).
>  
>  	"relative" means it's relative to filtered entries only so that the
>  	sum of shown entries will be always 100%.  "absolute" means it retains
> @@ -627,6 +641,8 @@ include::itrace.txt[]
>  --skip-empty::
>  	Do not print 0 results in the --stat output.
>  
> +include::cpu-and-wallclock-overheads.txt[]
> +
>  include::callchain-overhead-calculation.txt[]
>  
>  SEE ALSO
> diff --git a/tools/perf/Documentation/tips.txt b/tools/perf/Documentation/tips.txt
> index 67b326ba00407..50916c58b81c5 100644
> --- a/tools/perf/Documentation/tips.txt
> +++ b/tools/perf/Documentation/tips.txt
> @@ -62,3 +62,6 @@ To show context switches in perf report sample context add --switch-events to pe
>  To show time in nanoseconds in record/report add --ns
>  To compare hot regions in two workloads use perf record -b -o file ... ; perf diff --stream file1 file2
>  To compare scalability of two workload samples use perf diff -c ratio file1 file2
> +For latency analysis, try: perf report --sort wallclock
> +For parallelism histogram, try: perf report --hierarchy --sort wallclock,parallelism,comm,symbol
> +To analyze particular parallelism levels, try: perf report --sort=wallclock,symbol --parallelism=32-64
> diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
> index f832524729211..225e3997f03cb 100644
> --- a/tools/perf/builtin-record.c
> +++ b/tools/perf/builtin-record.c
> @@ -3342,6 +3342,12 @@ static struct record record = {
>  		.ctl_fd              = -1,
>  		.ctl_fd_ack          = -1,
>  		.synth               = PERF_SYNTH_ALL,
> +		/*
> +		 * This is enabled by default because it's required to show
> +		 * wallclock overhead and parallelism profile, and does not
> +		 * add lots of overhead on top of samples data.

I'm not sure about this and don't want to enable it by default.
There's --switch-events option to enable this.  Or you can add --latency
option to make it explicit and give more hints to users.

For example, if we want to target single process only it can reject
system-wide monitoring when --latency is given.

Thanks,
Namhyung

> +		 */
> +		.record_switch_events	= true,
>  	},
>  };
>  
