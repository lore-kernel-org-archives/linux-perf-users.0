Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E7B31FF1C7;
	Sat, 10 Jan 2026 00:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768006143; cv=none; b=fN4psuX6YbkbOabPC3kiioLFA6R5K0J4oGAzrSIqS/dCnRSkWx4rFvy37KV3kwh+0akRHfzNeZuxpAkhHnjRKaP4GuWFihzY0yQEM11l+TSeJoebix4l1E2iItOYfz3HeER4br7V46efvo8y5HwpLkKEJBudUrMGKAbZ0FCIRqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768006143; c=relaxed/simple;
	bh=SpjWBkzdOt3KnO2RCX/GfupaO9tBYxQiA3HIWp44IxY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=es/5sB8noJItUbqCZzt88BnYxY8KRxcYTZwDO0QhYLtnO4MN1TYELjqsDcglMTPie5xdb+aV+mKuhXOEC3Kp+nunXlUfLe8odpWMPC3qaZ4GHkCrLkUKnYTOnMr2S5SI6wEMGl5En7sDMXK3W6hoGrjDSaIMR1fVt53UnfNhdCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=azio/CcU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="azio/CcU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC9A9C4CEF1;
	Sat, 10 Jan 2026 00:49:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768006143;
	bh=SpjWBkzdOt3KnO2RCX/GfupaO9tBYxQiA3HIWp44IxY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=azio/CcUdZ/AnHtjEDxn4XeqwJbAtGtU+59A5v5vyk1Q9skBWMBS8FFG0cC8pB7bj
	 uY7DqYnlYzTsnX2TPn9wQzZRyof0cM+/uNXt34Y3sE59aY6cEnr87Sme+wM7pdv27F
	 3VN0xHJjXzyg9J/k8jXn/8mDrC5GK6Mn7BKsgOFqDDKvGrx5c0/fnKg5w3vwwqeSwF
	 PoaI9yCOZUAAdyzhlPkhcYIna4ei20KTYiQn8de2jpCRh2QteffMYY9Rj5Z0QlEyzC
	 FSrPydXpwyKmXqisEhhubTBTXWarAM5cgdCn9RzJFA69YhC60na3aI6uC2wSxFCGyP
	 RELiCQIQtQRVg==
Date: Fri, 9 Jan 2026 16:49:01 -0800
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
Subject: Re: [PATCH] perf: fix segfault in `lock contention -b`
Message-ID: <aWGh_XNyt-hmSamy@google.com>
References: <20260109164417.396138-1-tycho@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260109164417.396138-1-tycho@kernel.org>

On Fri, Jan 09, 2026 at 09:44:17AM -0700, Tycho Andersen wrote:
> From: "Tycho Andersen (AMD)" <tycho@kernel.org>
> 
> When run on a kernel without BTF info, I get:
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
> If we really are running -b without BTF info, the error is fatal, so let's
> propagate it and exit accordingly.

Thanks for the patch.

I'm curious how the kernel will react if we want to load the BPF.
Probably the verifier will reject as it calls some helpers like
bpf_get_current_task_btf().

I think it used to work without BTF - the callstack (default) and task
output mode won't need it.  It'd be nice if we could run it when the
kernel doesn't have BTF.  But maybe it's out of scope of this patch.

That said, can you add a NULL check in the init_numa_data() instead
and see how far it can go?

Thanks,
Namhyung

> 
> Signed-off-by: Tycho Andersen (AMD) <tycho@kernel.org>
> CC: Ravi Bangoria <ravi.bangoria@amd.com>
> CC: K Prateek Nayak <kprateek.nayak@amd.com>
> ---
>  tools/perf/util/bpf_lock_contention.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/tools/perf/util/bpf_lock_contention.c b/tools/perf/util/bpf_lock_contention.c
> index 7b5671f13c53..0f207e577037 100644
> --- a/tools/perf/util/bpf_lock_contention.c
> +++ b/tools/perf/util/bpf_lock_contention.c
> @@ -34,7 +34,7 @@ static bool slab_cache_equal(long key1, long key2, void *ctx __maybe_unused)
>  	return key1 == key2;
>  }
>  
> -static void check_slab_cache_iter(struct lock_contention *con)
> +static int check_slab_cache_iter(struct lock_contention *con)
>  {
>  	s32 ret;
>  
> @@ -43,19 +43,20 @@ static void check_slab_cache_iter(struct lock_contention *con)
>  	con->btf = btf__load_vmlinux_btf();
>  	if (con->btf == NULL) {
>  		pr_debug("BTF loading failed: %s\n", strerror(errno));
> -		return;
> +		return -errno;
>  	}
>  
>  	ret = btf__find_by_name_kind(con->btf, "bpf_iter__kmem_cache", BTF_KIND_STRUCT);
>  	if (ret < 0) {
>  		bpf_program__set_autoload(skel->progs.slab_cache_iter, false);
>  		pr_debug("slab cache iterator is not available: %d\n", ret);
> -		return;
> +		return ret;
>  	}
>  
>  	has_slab_iter = true;
>  
>  	bpf_map__set_max_entries(skel->maps.slab_caches, con->map_nr_entries);
> +	return 0;
>  }
>  
>  static void run_slab_cache_iter(void)
> @@ -301,7 +302,8 @@ int lock_contention_prepare(struct lock_contention *con)
>  			skel->rodata->use_cgroup_v2 = 1;
>  	}
>  
> -	check_slab_cache_iter(con);
> +	if (check_slab_cache_iter(con) < 0)
> +		return -1;
>  
>  	if (con->filters->nr_slabs && has_slab_iter) {
>  		skel->rodata->has_slab = 1;
> 
> base-commit: 5572ad8fddecd4a0db19801262072ff5916b7589
> -- 
> 2.52.0
> 
