Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4668B1E3DE5;
	Fri,  6 Feb 2026 00:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770337073; cv=none; b=ZmcUC8vt8Lm3oGRfwwo4XkoFUonDqOhkimbAU4uX67KRPxFOLyYoo1EmRXH/juPfHSxfsEtyv53ibm4cjgap4ycvN1HBGNadGmw3N2nSIHseIiP+Be5PDqeXxnon0VAh4cMNmAazJdKapzJwHi5wFRNpu3vF9VXVa2/fwjnjKAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770337073; c=relaxed/simple;
	bh=h2yZBxqQs5Upprq+VPaGz83n0GLUAzwxYaUC1tv9mjs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e6KD6qc9015tOsiLNaCBRDbPS+3DVi7cGNYHicJixPlV1SCkFePtGVy/6Xyv24EDFjxOku38M3E87q3CNWMRGh1uQGrunDpp36YxnZmMH13OnphH8nJe74wLU0bax/gxRd+2ySqbEeg6vjqlcCjpQQnSRr9JoiN4ng0nM7ltwrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mDHHpWOb; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mDHHpWOb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45D92C4CEF7;
	Fri,  6 Feb 2026 00:17:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770337072;
	bh=h2yZBxqQs5Upprq+VPaGz83n0GLUAzwxYaUC1tv9mjs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mDHHpWObKIKy5HhMW+0vs/7kQHIm5x49oNirE4v+b3y301qBLmkfpZMy7y+2tVLOr
	 pqVk95yvXKhBsXTtYIB97rg9Tvp0qTz2iPY/xlertGElgxGyMlpuuTwg1XRxUntwE0
	 Mbd7YO+Y6WjfPuSKeb2NOijViyXGIWotw2JYJUFDXuSI2kE23TylPSZvKtjq2LFu4d
	 xtnEj8zUNJVY1BTFGvUmHUzmX1wAhYBFiMXFTCcOcmpahXu3wXwbf/SKbbvboahyCD
	 rliok/OK6MyEpbnSdTzLNFH445czjgYkNW/p/tVKC60Q6jjDiOG+YCNJ0bFmRUrRS1
	 LLknKm2NdP6IA==
Date: Thu, 5 Feb 2026 16:17:50 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: Tycho Andersen <tycho@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Chun-Tse Shao <ctshao@google.com>, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org, Ravi Bangoria <ravi.bangoria@amd.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>
Subject: Re: [PATCH v2] perf: fix segfault in `lock contention -b`
Message-ID: <aYUzLjODMw2NqEzq@google.com>
References: <20260205163250.1980640-1-tycho@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260205163250.1980640-1-tycho@kernel.org>

Hello,

On Thu, Feb 05, 2026 at 09:32:50AM -0700, Tycho Andersen wrote:
> From: "Tycho Andersen (AMD)" <tycho@kernel.org>
> 
> When run on a kernel without BTF info, perf crashes:
> 
>     libbpf: kernel BTF is missing at '/sys/kernel/btf/vmlinux', was CONFIG_DEBUG_INFO_BTF enabled?
>     libbpf: failed to find valid kernel BTF
> 
>     Program received signal SIGSEGV, Segmentation fault.
>     0x00005555556915b7 in btf.type_cnt ()
>     (gdb) bt
>     #0  0x00005555556915b7 in btf.type_cnt ()
>     #1  0x0000555555691fbc in btf_find_by_name_kind ()
>     #2  0x00005555556920d0 in btf.find_by_name_kind ()
>     #3  0x00005555558a1b7c in init_numa_data (con=0x7fffffffd0a0) at util/bpf_lock_contention.c:125
>     #4  0x00005555558a264b in lock_contention_prepare (con=0x7fffffffd0a0) at util/bpf_lock_contention.c:313
>     #5  0x0000555555620702 in __cmd_contention (argc=0, argv=0x7fffffffea10) at builtin-lock.c:2084
>     #6  0x0000555555622c8d in cmd_lock (argc=0, argv=0x7fffffffea10) at builtin-lock.c:2755
>     #7  0x0000555555651451 in run_builtin (p=0x555556104f00 <commands+576>, argc=3, argv=0x7fffffffea10)
>         at perf.c:349
>     #8  0x00005555556516ed in handle_internal_command (argc=3, argv=0x7fffffffea10) at perf.c:401
>     #9  0x000055555565184e in run_argv (argcp=0x7fffffffe7fc, argv=0x7fffffffe7f0) at perf.c:445
>     #10 0x0000555555651b9f in main (argc=3, argv=0x7fffffffea10) at perf.c:553
> 
> Check if btf loading failed, and don't do anything with it in
> init_numa_data(). This leads to the following error message, instead of
> just a crash:
> 
>     libbpf: kernel BTF is missing at '/sys/kernel/btf/vmlinux', was CONFIG_DEBUG_INFO_BTF enabled?
>     libbpf: failed to find valid kernel BTF
>     libbpf: kernel BTF is missing at '/sys/kernel/btf/vmlinux', was CONFIG_DEBUG_INFO_BTF enabled?
>     libbpf: failed to find valid kernel BTF
>     libbpf: Error loading vmlinux BTF: -ESRCH
>     libbpf: failed to load BPF skeleton 'lock_contention_bpf': -ESRCH
>     Failed to load lock-contention BPF skeleton
>     lock contention BPF setup failed
> 
> Signed-off-by: Tycho Andersen (AMD) <tycho@kernel.org>
> CC: Ravi Bangoria <ravi.bangoria@amd.com>
> CC: K Prateek Nayak <kprateek.nayak@amd.com>

Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks,
Namhyung

> ---
>  tools/perf/util/bpf_lock_contention.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/tools/perf/util/bpf_lock_contention.c b/tools/perf/util/bpf_lock_contention.c
> index 7b5671f13c53..8cd991b3f209 100644
> --- a/tools/perf/util/bpf_lock_contention.c
> +++ b/tools/perf/util/bpf_lock_contention.c
> @@ -117,6 +117,9 @@ static void init_numa_data(struct lock_contention *con)
>  	long last = -1;
>  	int ret;
>  
> +	if (!con->btf)
> +		return;
> +
>  	/*
>  	 * 'struct zone' is embedded in 'struct pglist_data' as an array.
>  	 * As we may not have full information of the struct zone in the
> 
> base-commit: 18f7fcd5e69a04df57b563360b88be72471d6b62
> -- 
> 2.52.0
> 
