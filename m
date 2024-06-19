Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2B1314E2F5;
	Wed, 19 Jun 2024 13:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718803707; cv=none; b=XoHUgIdInMU4sG94L8DrnO4QT0vZn7un7XQs1QV/06OWX2+XKp9DDPA5YRwXp5RmaE7PGJcKVVrf/TB9PmAdO42HS1GA5vpFimChCIkmkHgxspd+fikWizPjfV/i5j6BHiF0NzNk/3GozfJe4nMwG13JqO0m94VMl2ZonEQYh1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718803707; c=relaxed/simple;
	bh=q2wQ31q4JEnfnDeXHlVSXpsQVlkgKJUdKeicKGWjQGQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qh11tdBW+gKDHlHzEWaqWSn5EcEvavUdyJB4Y9DHUaO7lNHBT56f0eD0vDLJogN98mFq7tOh9EBtTRifvGXrvcdiUwUdcMe33++q4RpZJyUCpyaxgz7ufLQ2wqGIlKQwyi9EHNZkqt5fUykCuBwYkduC/AAL0dy4ipdBB/5dJA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KT2ZcKx6; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KT2ZcKx6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB6A3C4AF49;
	Wed, 19 Jun 2024 13:28:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718803706;
	bh=q2wQ31q4JEnfnDeXHlVSXpsQVlkgKJUdKeicKGWjQGQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KT2ZcKx6W8Zb6w/izWxY3Xm8FOXdwj8pEvRuzFfmG8W+xizt29tRyx0DwolGUX0vv
	 W/9hzrVa1lkObVLiYy9RwshGBaHj7fg7YCGc1XiJcQi5vbIkX8LEq/TV5dlwXcAj+j
	 sgCICaD1wMXYAHGWgGWwIi3Ak6zYK9FyV+GQ0tUkCJ5THp/0eL0mTXZH7n9YRig5sv
	 +o4DijQQ9dlmnr2X/1PM10Xa7487Ralo1abIIrFL0ASDBUn6Nn489izklkWKfKrVE7
	 myjp9ar3H0VPbXpQUIOAB5t7wkSicYf6iapiE3qCa6HWuGDFGT6RWoxVtPNN0TBoe6
	 vc3h81uwIWe1A==
Date: Wed, 19 Jun 2024 10:28:21 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ravi Bangoria <ravi.bangoria@amd.com>
Cc: namhyung@kernel.org, irogers@google.com, peterz@infradead.org,
	mingo@redhat.com, mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com, jolsa@kernel.org,
	adrian.hunter@intel.com, kan.liang@linux.intel.com,
	yangjihong1@huawei.com, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org, sandipan.das@amd.com,
	ananth.narayan@amd.com, santosh.shukla@amd.com
Subject: Re: [PATCH] perf doc: Add AMD IBS usage document
Message-ID: <ZnLc9V9UHBFvuqRg@x1>
References: <20240619092234.1165-1-ravi.bangoria@amd.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240619092234.1165-1-ravi.bangoria@amd.com>

On Wed, Jun 19, 2024 at 09:22:34AM +0000, Ravi Bangoria wrote:
> Add a perf man page document that describes how to exploit AMD IBS with
> Linux perf. Brief intro about IBS and simple one-liner examples will help
> naive users to get started. This is not meant to be an exhaustive IBS
> guide. User should refer latest AMD64 Architecture Programmer's Manual
> for detailed description of IBS.
> 
> Usage:
> 
>   $ man perf-amd-ibs
> 
> Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>
> ---
>  tools/perf/Documentation/perf-amd-ibs.txt | 126 ++++++++++++++++++++++
>  tools/perf/Documentation/perf.txt         |   3 +-
>  2 files changed, 128 insertions(+), 1 deletion(-)
>  create mode 100644 tools/perf/Documentation/perf-amd-ibs.txt
> 
> diff --git a/tools/perf/Documentation/perf-amd-ibs.txt b/tools/perf/Documentation/perf-amd-ibs.txt
> new file mode 100644
> index 000000000000..d3dfa71e320c
> --- /dev/null
> +++ b/tools/perf/Documentation/perf-amd-ibs.txt
> @@ -0,0 +1,126 @@
> +perf-amd-ibs(1)
> +===============
> +
> +NAME
> +----
> +perf-amd-ibs - Support for AMD Instruction-Based Sampling with perf tool
> +
> +SYNOPSIS
> +--------
> +[verse]
> +'perf record' -e ibs_op//
> +'perf record' -e ibs_fetch//
> +
> +DESCRIPTION
> +-----------
> +
> +Instruction-Based Sampling (IBS) provides precise Instruction Pointer (IP)
> +profiling support on AMD platforms. IBS has two independent components: IBS
> +Op and IBS Fetch. IBS Op sampling provides information about instruction
> +execution (micro-op execution to be precise) with details like d-cache
> +hit/miss, d-TLB hit/miss, cache miss latency, load/store data source, branch
> +behavior etc. IBS Fetch sampling provides information about instruction fetch
> +with details like i-cache hit/miss, i-TLB hit/miss, fetch latency etc. IBS is
> +per-smt-thread i.e. each SMT hardware thread contains standalone IBS units.
> +
> +Both, IBS Op and IBS Fetch, are exposed as PMUs by Linux and can be exploited
> +using Linux perf utility. Following files will be created at boot time if IBS
        the                  The
> +is supported by the hardware and kernel.
> +
> +  /sys/bus/event_source/devices/ibs_op/
> +  /sys/bus/event_source/devices/ibs_fetch/
> +
> +IBS Op PMU supports two events: cycles and micro ops. IBS Fetch PMU supports
> +one event: fetch ops.
> +
> +IBS VS. REGULAR CORE PMU
> +------------------------
> +
> +IBS gives samples with precise IP, i.e. the IP recorded with IBS sample has
> +no skid. Whereas the IP recorded by regular core PMU will have some skid
> +(sample was generated at IP X but perf would record it at IP X+n). Hence,
> +regular core PMU might not help for profiling with instruction level
> +precision. Further, IBS provides additional information about the sample in
> +question. On the other hand, regular core PMU has it's own advantages like
> +plethora of events, counting mode (less interference), up to 6 parallel
> +counters, event grouping support, filtering capabilities etc.

IIRC if one does:

   perf record -e cycles:P

on AMD systems it maps it to 

   ibs_op//

No?

I don't have access right now to my 5950X, so its from memory, about
"IBS invocation from core PMUs with precise_ip set"

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=78075d947534013b4575687d19ebcbbb6d3addcd

One other thing to mention is 'perf mem record' that will use ibs_op//
as we can see in the cover letter for this perf-tools merge commit
upstream:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=9d64bf433c53cab2f48a3fff7a1f2a696bc5229a

         # perf mem record -a --filter 'mem_op == load || mem_op == store, ip > 0x8000000000000000'
         ^C[ perf record: Woken up 1 times to write data ]
         [ perf record: Captured and wrote 2.199 MB perf.data (2913 samples) ]
         #
         # ls -la perf.data
         -rw-------. 1 root root 2346486 Jan  9 18:36 perf.data
         # perf evlist
         ibs_op//
         dummy:u
         # perf evlist -v
         ibs_op//: type: 11, size: 136, config: 0, { sample_period, sample_freq }: 4000, sample_type: IP|TID|TIME|ADDR|CPU|PERIOD|IDENTIFIER|DATA_SRC|WEIGHT, read_format: ID, disabled: 1, inherit: 1, freq: 1, sample_id_all: 1

Another examples available in the merge commit of when ibs_op support
was added to 'perf c2c' and 'perf mem':

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=d465bff130bf4ca17b6980abe51164ace1e0cba4

Showing how you can use 'perf report -D' to extract info about these
samples should be interesting as well:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=0429796e45ec17eee26d7a59de92271c275d7666
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=291dcb98d7ee5cd719f4c5991d977794b1829c16

> +EXAMPLES
> +--------
> +
> +IBS Op PMU
> +~~~~~~~~~~
> +
> +System-wide profile, cycles event, sampling period: 100000
> +
> +	$ sudo perf record -e ibs_op// -c 100000 -a
> +
> +Per-cpu profile (cpu10), cycles event, sampling period: 100000
> +
> +	$ sudo perf record -e ibs_op// -c 100000 -C 10
> +
> +Per-cpu profile (cpu10), cycles event, sampling freq: 1000
> +
> +	$ sudo perf record -e ibs_op// -F 1000 -C 10
> +
> +System-wide profile, uOps event, sampling period: 100000
> +
> +	$ sudo perf record -e ibs_op/cnt_ctl=1/ -c 100000 -a
> +
> +Same command, but also capture IBS register raw dump along with perf sample:
> +
> +	$ sudo perf record -e ibs_op/cnt_ctl=1/ -c 100000 -a --raw-samples
> +
> +System-wide profile, uOps event, sampling period: 100000, L3MissOnly (Zen4 onward)
> +
> +	$ sudo perf record -e ibs_op/cnt_ctl=1,l3missonly=1/ -c 100000 -a
> +
> +Per process(upstream v6.2 onward), uOps event, sampling period: 100000
> +
> +	$ sudo perf record -e ibs_op/cnt_ctl=1/ -c 100000 -p 1234
> +
> +Per process(upstream v6.2 onward), uOps event, sampling period: 100000
> +
> +	$ sudo perf record -e ibs_op/cnt_ctl=1/ -c 100000 -- ls
> +
> +To analyse recorded profile in aggregate mode
> +
> +	$ sudo perf report
> +	/* Select a line and press 'a' to drill down at instruction level. */
> +
> +To go over each sample
> +
> +	$ sudo perf script

Here I think it would be to have an example of such output.
> +
> +Raw dump of IBS registers when profiled with --raw-samples
> +
> +	$ sudo perf report -D
> +	/* Look for PERF_RECORD_SAMPLE */

Ditto

> +
> +IBS applied in a real world usecase
> +
> +~90% regression was observed in tbench with specific scheduler hint which
> +was counter intuitive. IBS profile of good and bad run captured using perf
> +helped in identifying exact cause of the problem:
> +
> +	https://lore.kernel.org/r/20220921063638.2489-1-kprateek.nayak@amd.com
> +
> +IBS Fetch PMU
> +~~~~~~~~~~~~~
> +
> +Similar commands can be used with Fetch PMU as well.
> +
> +System-wide profile, fetch ops event, sampling period: 100000
> +
> +	$ sudo perf record -e ibs_fetch// -c 100000 -a
> +
> +System-wide profile, fetch ops event, sampling period: 100000, Random enable
> +
> +	$ sudo perf record -e ibs_fetch/rand_en=1/ -c 100000 -a
> +
> +etc.
> +
> +SEE ALSO
> +--------
> +
> +linkperf:perf-record[1], linkperf:perf-script[1], linkperf:perf-report[1]

perf-mem, perf-c2c

> diff --git a/tools/perf/Documentation/perf.txt b/tools/perf/Documentation/perf.txt
> index 09f516f3fdfb..cbcc2e4d557e 100644
> --- a/tools/perf/Documentation/perf.txt
> +++ b/tools/perf/Documentation/perf.txt
> @@ -82,7 +82,8 @@ linkperf:perf-stat[1], linkperf:perf-top[1],
>  linkperf:perf-record[1], linkperf:perf-report[1],
>  linkperf:perf-list[1]
>  
> -linkperf:perf-annotate[1],linkperf:perf-archive[1],linkperf:perf-arm-spe[1],
> +linkperf:perf-amd-ibs[1], linkperf:perf-annotate[1],
> +linkperf:perf-archive[1], linkperf:perf-arm-spe[1],
>  linkperf:perf-bench[1], linkperf:perf-buildid-cache[1],
>  linkperf:perf-buildid-list[1], linkperf:perf-c2c[1],
>  linkperf:perf-config[1], linkperf:perf-data[1], linkperf:perf-diff[1],
> -- 
> 2.45.2
