Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAFA447CC6A;
	Thu,  4 Jun 2026 14:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780582045; cv=none; b=K9xxjpkAbYWe1BYD8bvE59Jc5BhbhSccKpEy2plc9/0ISCqX7Mpzp8NIG8V58XLGkmZez7iW5HEWIfEC+ClV6xgTauh+Wyddi7A49UMnGa+YSdjoGQXV8MIDbs22GTFbEj8sN9LjWhXaGw+2jYnYzor2n7WHvJ53IJ7wpkwPMSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780582045; c=relaxed/simple;
	bh=UIt8SFLjPgAFHAgsHxcs0u4I3gXlNxCBhbdA+WZyi+4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BkY6MOTBGsTYYj0013QPzVnWg8q5Ex5prxhM2MOzw64XedqN17LmHnlL+Yhvjg2k4PwSlzs/SisLb+RvPeVY57aCUaNbN4JIIVYyQzqksYz9NSlk/R6CK021Dpz19vZSLVWqRWhdECCZqVAqVl9be5r3uZ1ZtFIcYqFmu8OKniE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HW/U0GSg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HW/U0GSg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67AB71F00893;
	Thu,  4 Jun 2026 14:07:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780582043;
	bh=iLV5PSvnDbXsI12NPpxP91UyGJrfQLikYnozlkEwlZM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=HW/U0GSgT/TQ53kIK9gysCoy1TmUG8jNtB4toZGIv65SSfaZOsD6WfApu0in7VIxu
	 kF5sS2iVIUGc7uAZ+wTQ73wPJsmdcQS/eowwmRT4Gwy2lktebuKv59VfKv32QZe1v0
	 JcqfJNRtZu60BfYXi1FHVrJIw2BPOdPIh4/kp5oh5irtDnn/Tssbyhko1Js/5uoQ2F
	 SJ8339O3PCH/tdYBh1yyexeqjOq3jnF2OXD5uo8FspGrD6Iqzb2j2ZbR7b2bwoXLsw
	 2dlGrWRtBPhZ/ffzsAgDSKiyVVtrAd1vcHidDyFyUxIiS7nCtymtgdi65ykixxyX6m
	 VCIqWZDQPpRHw==
Date: Thu, 4 Jun 2026 11:07:20 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org, Chun-Tse Shao <ctshao@google.com>,
	Suchit Karunakaran <suchitkarunakaran@gmail.com>
Subject: Re: [PATCH v2] perf lock contention: Allow 'mmap_lock' in
 -L/--lock-filter
Message-ID: <aiGGmN0jIsTHgUJH@x1>
References: <20260505231136.691907-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260505231136.691907-1-namhyung@kernel.org>

On Tue, May 05, 2026 at 04:11:35PM -0700, Namhyung Kim wrote:
> The -L/--lock-filter option is to specify target locks by name or
> address.  It's basically for global locks where name or address is known
> and fixed.  But 'mmap_lock' is a per-process lock so it cannot be used
> for the -L option.
> 
>   $ sudo perf lock con -ab -L mmap_lock
>   ignore unknown symbol: mmap_lock
>   libbpf: map 'addr_filter': failed to create: -EINVAL
>   libbpf: failed to load BPF skeleton 'lock_contention_bpf': -EINVAL
>   Failed to load lock-contention BPF skeleton
>   lock contention BPF setup failed

Hi,

	Did this fell thru the cracks? :-)

- Arnaldo
 
> However, it's still a common source of contention especially in a large
> process so we want to use it for the -L/--lock-filter option.  As there
> is check_lock_type() to check mmap_lock at runtime, let's used it to
> filter mmap_locks as a special case.
> 
> Of course, this only works with -b/--use-bpf option.
> 
>   $ sudo perf lock con -b -L mmap_lock -- perf bench mem mmap -f demand -t 2
>   # Running 'mem/mmap' benchmark:
>   # function 'demand' (Demand loaded mmap())
>   # Copying 1MB bytes ...
> 
>          2.679184 GB/sec/thread	( +-   1.78% )
>    contended   total wait     max wait     avg wait         type   caller
> 
>            1     15.22 us     15.22 us     15.22 us      rwsem:W   __vm_munmap+0x7e
>            1      7.72 us      7.72 us      7.72 us      rwsem:R   lock_mm_and_find_vma+0x97
> 
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---
> v2)
>  * handle a bad lock name for -L option  (Sashiko)
>  * handle mmap_lock and other lock together  (Sashiko)
> 
>  tools/perf/tests/shell/lock_contention.sh     | 11 +++++++++
>  tools/perf/util/bpf_lock_contention.c         |  9 +++++++-
>  .../perf/util/bpf_skel/lock_contention.bpf.c  | 23 +++++++++++++++++--
>  3 files changed, 40 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/perf/tests/shell/lock_contention.sh b/tools/perf/tests/shell/lock_contention.sh
> index 6dd90519f45cec1d..52e8b9db9fbd8844 100755
> --- a/tools/perf/tests/shell/lock_contention.sh
> +++ b/tools/perf/tests/shell/lock_contention.sh
> @@ -208,6 +208,17 @@ test_lock_filter()
>  		err=1
>  		exit
>  	fi
> +
> +	perf lock con -b -L mmap_lock -q -- perf bench mem mmap -t 2 -l 10 > /dev/null 2> ${result}
> +
> +	# find out the type of mmap_lock
> +	test_lock_filter_type=$(head -1 "${result}" | awk '{ print $8 }' | sed -e 's/:.*//')
> +
> +	if [ "$(grep -c -v "${test_lock_filter_type}" "${result}")" != "0" ]; then
> +		echo "[Fail] BPF result should not have non-${test_lock_filter_type} locks:" "$(cat "${result}")"
> +		err=1
> +		exit
> +	fi
>  }
>  
>  test_stack_filter()
> diff --git a/tools/perf/util/bpf_lock_contention.c b/tools/perf/util/bpf_lock_contention.c
> index cbd7435579feaf8e..eb8e29b8064b7348 100644
> --- a/tools/perf/util/bpf_lock_contention.c
> +++ b/tools/perf/util/bpf_lock_contention.c
> @@ -186,6 +186,7 @@ int lock_contention_prepare(struct lock_contention *con)
>  	int ncpus = 1, ntasks = 1, ntypes = 1, naddrs = 1, ncgrps = 1, nslabs = 1;
>  	struct evlist *evlist = con->evlist;
>  	struct target *target = con->target;
> +	bool has_mmap_lock = false;
>  
>  	/* make sure it loads the kernel map before lookup */
>  	map__load(machine__kernel_map(con->machine));
> @@ -244,6 +245,11 @@ int lock_contention_prepare(struct lock_contention *con)
>  		unsigned long *addrs;
>  
>  		for (i = 0; i < con->filters->nr_syms; i++) {
> +			if (!strcmp(con->filters->syms[i], "mmap_lock")) {
> +				has_mmap_lock = true;
> +				continue;
> +			}
> +
>  			sym = machine__find_kernel_symbol_by_name(con->machine,
>  								  con->filters->syms[i],
>  								  &kmap);
> @@ -263,7 +269,7 @@ int lock_contention_prepare(struct lock_contention *con)
>  			addrs[con->filters->nr_addrs++] = map__unmap_ip(kmap, sym->start);
>  			con->filters->addrs = addrs;
>  		}
> -		naddrs = con->filters->nr_addrs;
> +		naddrs = con->filters->nr_addrs ?: has_mmap_lock;
>  		skel->rodata->has_addr = 1;
>  	}
>  
> @@ -298,6 +304,7 @@ int lock_contention_prepare(struct lock_contention *con)
>  	skel->rodata->aggr_mode = con->aggr_mode;
>  	skel->rodata->needs_callstack = con->save_callstack;
>  	skel->rodata->lock_owner = con->owner;
> +	skel->rodata->has_mmap_lock = has_mmap_lock;
>  
>  	if (con->aggr_mode == LOCK_AGGR_CGROUP || con->filters->nr_cgrps) {
>  		if (cgroup_is_v2("perf_event"))
> diff --git a/tools/perf/util/bpf_skel/lock_contention.bpf.c b/tools/perf/util/bpf_skel/lock_contention.bpf.c
> index 96e7d853b9edf3b5..8b1aa64deb6e4141 100644
> --- a/tools/perf/util/bpf_skel/lock_contention.bpf.c
> +++ b/tools/perf/util/bpf_skel/lock_contention.bpf.c
> @@ -184,6 +184,7 @@ const volatile int has_type;
>  const volatile int has_addr;
>  const volatile int has_cgroup;
>  const volatile int has_slab;
> +const volatile int has_mmap_lock;
>  const volatile int needs_callstack;
>  const volatile int stack_skip;
>  const volatile int lock_owner;
> @@ -214,6 +215,8 @@ int data_map_full;
>  struct task_struct *bpf_task_from_pid(s32 pid) __ksym __weak;
>  void bpf_task_release(struct task_struct *p) __ksym __weak;
>  
> +static inline __u32 check_lock_type(__u64 lock, __u32 flags);
> +
>  static inline __u64 get_current_cgroup_id(void)
>  {
>  	struct task_struct *task;
> @@ -239,6 +242,8 @@ static inline __u64 get_current_cgroup_id(void)
>  
>  static inline int can_record(u64 *ctx)
>  {
> +	bool is_addr_ok = false;
> +
>  	if (has_cpu) {
>  		__u32 cpu = bpf_get_smp_processor_id();
>  		__u8 *ok;
> @@ -271,8 +276,10 @@ static inline int can_record(u64 *ctx)
>  		__u64 addr = ctx[0];
>  
>  		ok = bpf_map_lookup_elem(&addr_filter, &addr);
> -		if (!ok && !has_slab)
> +		if (!ok && !has_slab && !has_mmap_lock)
>  			return 0;
> +
> +		is_addr_ok = !!ok;
>  	}
>  
>  	if (has_cgroup) {
> @@ -284,6 +291,10 @@ static inline int can_record(u64 *ctx)
>  			return 0;
>  	}
>  
> +	if (is_addr_ok)
> +		return 1;
> +
> +	/* slab and mmap_lock are part of the addr_filter */
>  	if (has_slab && bpf_get_kmem_cache) {
>  		__u8 *ok;
>  		__u64 addr = ctx[0];
> @@ -291,7 +302,15 @@ static inline int can_record(u64 *ctx)
>  
>  		kmem_cache_addr = (long)bpf_get_kmem_cache(addr);
>  		ok = bpf_map_lookup_elem(&slab_filter, &kmem_cache_addr);
> -		if (!ok)
> +		if (!ok && !has_mmap_lock)
> +			return 0;
> +	}
> +
> +	if (has_mmap_lock) {
> +		__u64 lock = ctx[0];
> +		__u32 flag = ctx[1];
> +
> +		if (check_lock_type(lock, flag) != LCD_F_MMAP_LOCK)
>  			return 0;
>  	}
>  
> -- 
> 2.54.0.545.g6539524ca2-goog
