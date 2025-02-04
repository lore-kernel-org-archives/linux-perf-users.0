Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97FD618858A;
	Tue,  4 Feb 2025 04:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738643271; cv=none; b=K8Dd0HVy7ZmQ8MduJV0RSSKe4+SKz/SgI033ZN7SdVZIRPo6C0t1NurebfbhYhTo056FKWcrmkjWqFn4Ql1FLkYU09DekLplMpri8ZzrX2C6nJ+Dewr9OBq/zOE2vUzy5iypx49Anv8o3Tc6JJizGICxPi/58+UGD6iPO3EQppE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738643271; c=relaxed/simple;
	bh=U/EzLb92gORbHR+90FsDZyMbFuAxD8VZ4ZDPbBb34VA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YU8+KhYeVwpLzvpnR+MI7+2h4kLCBljNYHfv/osynW6prGHqsPcvGxRUq55JX1ocNdfq4RWV0Zy1N0UT46fKt2alXtw5eISWush4BQhyn56BNea1bNQiaMA82FdHCAiK04a+uYCR8iscFfbu495K86JK+9vo1O2NgmOIn2jxh1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NXLSx0ba; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NXLSx0ba"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDB92C4CEDF;
	Tue,  4 Feb 2025 04:27:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738643271;
	bh=U/EzLb92gORbHR+90FsDZyMbFuAxD8VZ4ZDPbBb34VA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NXLSx0baNRTpaFMrnJvAqnbs8yGNJ7HNpYb1lwD6TYhY6dXVPQYhGzio+xv7r80yj
	 B5z8TGpCQvAWegcU1J8qML1ZDg8rpQTvrsjJfX4JfUh7eg8sUgQwY7TyCUTylT8N2f
	 lZ/xKi2wEzMLtQu7vIU9D562asUlZIln/0bY4fHObk8haj0rmEnUgWYhIYEdLxxVH8
	 pX96UXU6ftwAtg8owKHBTEv+WPqZedCgyELGV1m53ghnl36A87Yr/Ffm3w7ezuTFr2
	 TsaC0Zb+/a66R2GFEnnokHRRvkyM0//o8/gPnmehcqYOBKRG+4XxZEHOiIKhuSdUCk
	 /4xadKAFRqmjA==
Date: Mon, 3 Feb 2025 20:27:49 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: Dmitry Vyukov <dvyukov@google.com>
Cc: irogers@google.com, acme@kernel.org, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 7/8] perf report: Add latency and parallelism
 profiling documentation
Message-ID: <Z6GXRZ9NWVQVAanZ@google.com>
References: <cover.1738592865.git.dvyukov@google.com>
 <4b49d5dd316f5d7119d8b16d5d70f13574158dc6.1738592865.git.dvyukov@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4b49d5dd316f5d7119d8b16d5d70f13574158dc6.1738592865.git.dvyukov@google.com>

On Mon, Feb 03, 2025 at 03:30:42PM +0100, Dmitry Vyukov wrote:
> Describe latency and parallelism profiling, related flags, and differences
> with the currently only supported CPU-consumption-centric profiling.

It doesn't seem to have descriptions for the --latency option (for perf
record and report).  Probably better to put them in the previous patch.

> 
> Signed-off-by: Dmitry Vyukov <dvyukov@google.com>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
> Cc: Ian Rogers <irogers@google.com>
> Cc: linux-perf-users@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> ---
>  .../callchain-overhead-calculation.txt        |  5 +-
>  .../cpu-and-latency-overheads.txt             | 85 +++++++++++++++++++
>  tools/perf/Documentation/perf-report.txt      | 49 +++++++----
>  tools/perf/Documentation/tips.txt             |  3 +
>  4 files changed, 123 insertions(+), 19 deletions(-)
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
> diff --git a/tools/perf/Documentation/cpu-and-latency-overheads.txt b/tools/perf/Documentation/cpu-and-latency-overheads.txt
> new file mode 100644
> index 0000000000000..3b6d637054651
> --- /dev/null
> +++ b/tools/perf/Documentation/cpu-and-latency-overheads.txt
> @@ -0,0 +1,85 @@
> +CPU and latency overheads
> +-------------------------
> +There are two notions of time: wall-clock time and CPU time.
> +For a single-threaded program, or a program running on a single-core machine,
> +these notions are the same. However, for a multi-threaded/multi-process program
> +running on a multi-core machine, these notions are significantly different.
> +Each second of wall-clock time we have number-of-cores seconds of CPU time.
> +Perf can measure overhead for both of these times (shown in 'overhead' and
> +'latency' columns for CPU and wall-clock time correspondingly).
> +
> +Optimizing CPU overhead is useful to improve 'throughput', while optimizing
> +latency overhead is useful to improve 'latency'. It's important to understand
> +which one is useful in a concrete situation at hand. For example, the former
> +may be useful to improve max throughput of a CI build server that runs on 100%
> +CPU utilization, while the latter may be useful to improve user-perceived
> +latency of a single interactive program build.
> +These overheads may be significantly different in some cases. For example,
> +consider a program that executes function 'foo' for 9 seconds with 1 thread,
> +and then executes function 'bar' for 1 second with 128 threads (consumes
> +128 seconds of CPU time). The CPU overhead is: 'foo' - 6.6%, 'bar' - 93.4%.
> +While the latency overhead is: 'foo' - 90%, 'bar' - 10%. If we try to optimize
> +running time of the program looking at the (wrong in this case) CPU overhead,
> +we would concentrate on the function 'bar', but it can yield only 10% running
> +time improvement at best.
> +
> +By default, perf shows only CPU overhead. To show latency overhead, use
> +'perf record --latency' and 'perf report':
> +
> +-----------------------------------
> +Overhead  Latency  Command
> +  93.88%   25.79%  cc1
> +   1.90%   39.87%  gzip
> +   0.99%   10.16%  dpkg-deb
> +   0.57%    1.00%  as
> +   0.40%    0.46%  sh
> +-----------------------------------
> +
> +To sort by latency overhead, use 'perf report --latency':
> +
> +-----------------------------------
> +Latency  Overhead  Command
> + 39.87%     1.90%  gzip
> + 25.79%    93.88%  cc1
> + 10.16%     0.99%  dpkg-deb
> +  4.17%     0.29%  git
> +  2.81%     0.11%  objtool
> +-----------------------------------
> +
> +To get insight into the difference between the overheads, you may check
> +parallelization histogram with '--sort=latency,parallelism,comm,symbol --hierarchy'

I think you need to omit latency in the sort key and recommend users to
use --latency option instead.

  'perf report --hierarchy --latency --sort=parallelism,comm,symbol'


> +flags. It shows fraction of (wall-clock) time the workload utilizes different
> +numbers of cores ('Parallelism' column). For example, in the following case
> +the workload utilizes only 1 core most of the time, but also has some
> +highly-parallel phases, which explains significant difference between
> +CPU and wall-clock overheads:
> +
> +-----------------------------------
> +  Latency  Overhead     Parallelism / Command / Symbol
> ++  56.98%     2.29%     1
> ++  16.94%     1.36%     2
> ++   4.00%    20.13%     125
> ++   3.66%    18.25%     124
> ++   3.48%    17.66%     126
> ++   3.26%     0.39%     3
> ++   2.61%    12.93%     123
> +-----------------------------------
> +
> +By expanding corresponding lines, you may see what commands/functions run
> +at the given parallelism level:
> +
> +-----------------------------------
> +  Latency  Overhead     Parallelism / Command / Symbol
> +-  56.98%     2.29%     1
> +      32.80%     1.32%     gzip
> +       4.46%     0.18%     cc1
> +       2.81%     0.11%     objtool
> +       2.43%     0.10%     dpkg-source
> +       2.22%     0.09%     ld
> +       2.10%     0.08%     dpkg-genchanges
> +-----------------------------------
> +
> +To see the normal function-level profile for particular parallelism levels
> +(number of threads actively running on CPUs), you may use '--parallelism'
> +filter. For example, to see the profile only for low parallelism phases
> +of a workload use '--latency --parallelism=1-2' flags.
> diff --git a/tools/perf/Documentation/perf-report.txt b/tools/perf/Documentation/perf-report.txt
> index 87f8645194062..7e0ba990d71e8 100644
> --- a/tools/perf/Documentation/perf-report.txt
> +++ b/tools/perf/Documentation/perf-report.txt
> @@ -44,7 +44,7 @@ OPTIONS
>  --comms=::
>  	Only consider symbols in these comms. CSV that understands
>  	file://filename entries.  This option will affect the percentage of
> -	the overhead column.  See --percentage for more info.
> +	the overhead and latency columns.  See --percentage for more info.
>  --pid=::
>          Only show events for given process ID (comma separated list).
>  
> @@ -54,12 +54,12 @@ OPTIONS
>  --dsos=::
>  	Only consider symbols in these dsos. CSV that understands
>  	file://filename entries.  This option will affect the percentage of
> -	the overhead column.  See --percentage for more info.
> +	the overhead and latency columns.  See --percentage for more info.
>  -S::
>  --symbols=::
>  	Only consider these symbols. CSV that understands
>  	file://filename entries.  This option will affect the percentage of
> -	the overhead column.  See --percentage for more info.
> +	the overhead and latency columns.  See --percentage for more info.
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
> +        the overhead and latency columns. See --percentage for more info.
> +        Also see the `CPU and latency overheads' section for more details.
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
> +	- overhead: CPU overhead percentage of sample.
> +	- latency: latency (wall-clock) overhead percentage of sample.
> +	  See the `CPU and latency overheads' section for more details.
> +	- overhead_sys: CPU overhead percentage of sample running in system mode
> +	- overhead_us: CPU overhead percentage of sample running in user mode
> +	- overhead_guest_sys: CPU overhead percentage of sample running in system mode
>  	on guest machine
> -	- overhead_guest_us: Overhead percentage of sample running in user mode on
> +	- overhead_guest_us: CPU overhead percentage of sample running in user mode on
>  	guest machine
>  	- sample: Number of sample
>  	- period: Raw number of event count of sample
> @@ -125,8 +138,8 @@ OPTIONS
>  	- weight2: Average value of event specific weight (2nd field of weight_struct).
>  	- weight3: Average value of event specific weight (3rd field of weight_struct).
>  
> -	By default, comm, dso and symbol keys are used.
> -	(i.e. --sort comm,dso,symbol)
> +	By default, overhead, comm, dso and symbol keys are used.
> +	(i.e. --sort overhead,comm,dso,symbol).
>  
>  	If --branch-stack option is used, following sort keys are also
>  	available:
> @@ -201,9 +214,9 @@ OPTIONS
>  --fields=::
>  	Specify output field - multiple keys can be specified in CSV format.
>  	Following fields are available:
> -	overhead, overhead_sys, overhead_us, overhead_children, sample, period,
> -	weight1, weight2, weight3, ins_lat, p_stage_cyc and retire_lat.  The
> -	last 3 names are alias for the corresponding weights.  When the weight
> +	overhead, latency, overhead_sys, overhead_us, overhead_children, sample,
> +	period, weight1, weight2, weight3, ins_lat, p_stage_cyc and retire_lat.
> +	The last 3 names are alias for the corresponding weights.  When the weight
>  	fields are used, they will show the average value of the weight.
>  
>  	Also it can contain any sort key(s).
> @@ -289,7 +302,7 @@ OPTIONS
>  	Accumulate callchain of children to parent entry so that then can
>  	show up in the output.  The output will have a new "Children" column
>  	and will be sorted on the data.  It requires callchains are recorded.
> -	See the `overhead calculation' section for more details. Enabled by
> +	See the `Overhead calculation' section for more details. Enabled by
>  	default, disable with --no-children.
>  
>  --max-stack::
> @@ -442,9 +455,9 @@ OPTIONS
>  	--call-graph option for details.
>  
>  --percentage::
> -	Determine how to display the overhead percentage of filtered entries.
> -	Filters can be applied by --comms, --dsos and/or --symbols options and
> -	Zoom operations on the TUI (thread, dso, etc).
> +	Determine how to display the CPU and latency overhead percentage
> +	of filtered entries. Filters can be applied by --comms, --dsos, --symbols
> +	and/or --parallelism options and Zoom operations on the TUI (thread, dso, etc).
>  
>  	"relative" means it's relative to filtered entries only so that the
>  	sum of shown entries will be always 100%.  "absolute" means it retains
> @@ -627,6 +640,8 @@ include::itrace.txt[]
>  --skip-empty::
>  	Do not print 0 results in the --stat output.
>  
> +include::cpu-and-latency-overheads.txt[]
> +
>  include::callchain-overhead-calculation.txt[]
>  
>  SEE ALSO
> diff --git a/tools/perf/Documentation/tips.txt b/tools/perf/Documentation/tips.txt
> index 67b326ba00407..f6f71e70ff2cb 100644
> --- a/tools/perf/Documentation/tips.txt
> +++ b/tools/perf/Documentation/tips.txt
> @@ -62,3 +62,6 @@ To show context switches in perf report sample context add --switch-events to pe
>  To show time in nanoseconds in record/report add --ns
>  To compare hot regions in two workloads use perf record -b -o file ... ; perf diff --stream file1 file2
>  To compare scalability of two workload samples use perf diff -c ratio file1 file2
> +For latency profiling, try: perf record/report --latency
> +For parallelism histogram, try: perf report --hierarchy --sort latency,parallelism,comm,symbol

Ditto.

Thanks,
Namhyung


> +To analyze particular parallelism levels, try: perf report --latency --parallelism=32-64
> -- 
> 2.48.1.362.g079036d154-goog
> 
