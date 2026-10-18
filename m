Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1291E37F006
	for <linux-perf-users@vger.kernel.org>; Sun, 18 Oct 2026 06:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792303935; cv=none; b=gJuNwRjAYNa6cYlYybEN8jqwmIxsBzPRMkMelq2VcJx+iUGpsaRFmHI+sk+5gkHmkR8zfCCuH/p4EZzcPZ44xTcxCQ32vdeggmaabDyV19oSwFN2OyF99kaQPcPDpuEp3f+ZuSprqclqHAAnsp4nYMLws/qN8Y0UqynLUTz5GBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792303935; c=relaxed/simple;
	bh=uhMc/5C6MCgprWSpYGaIJxvnU3Ym0dFjnyOiFJLn7YU=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=oSHYhlRS9unHEBhkzpaCs/8LCkUUPWUU21dS/ssQUykDdkDlEfjXCWHEvzIjDQf0XCXqlGFPDf852Jlk9++D4UPJmKpZJBjGl4SDmamikya9qVaYaVJGB/Ky7Lr4m2ge2m8kF1SXtPfgPTF9RJaUXHswMscNncEPm69CYQ/MbMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V4gypw+G; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V4gypw+G"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D60C1F000C4;
	Sun, 18 Oct 2026 06:12:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792303933;
	bh=E5cWA2XFbpyK/WSsKh/jgpgHf/ilwu+s3TMgPpRDOEo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=V4gypw+G/asnM0Bd/ZNfkMdG+Br4cDURLVGRHA+mxfuM6Gcw9U3YGDB0ymyhdjatK
	 6UxG6+/ZFNNJcjXaGLfLUMpq/I7VrAWKvRL2acZkZExJf1PE/C+K9wFwDTXGTyVvnM
	 2X4p/J3kBNymS4xM6BQuUVHrQfjQZMzcbzULx2Vk1wkz4jAlMRjijAhu3cynEI/TL6
	 b3gXrNc6xSoi4Yz9ehVZUrwGNGuw8WfsXijRukf8rUvekXqaooweBMOhahfEDG5r3D
	 KCaeHITwIkJ9XVxF5iP3mIx1XuvlYoHdLPBaIF5ThwefvRMeKBQtTIupMstPSPiH4R
	 MuCx9NAAIEcsQ==
Message-ID: <sashiko-outbox-175981@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 2/6] perf bpf-filter: Add lock_held() sample filter
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261018053710.2572636-3-irogers@google.com>
References: <20261017171437.2066343-1-irogers@google.com>
 <20261018053710.2572636-1-irogers@google.com>
 <20261018053710.2572636-3-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 18 Oct 2026 06:12:13 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [Medium] perf bpf-filter: unreachable BTF check in configure_lock_progs()
- [Medium] perf bpf-filter: read mode accepted for exclusive locks in resol=
ve_lock_expr()
- [Medium] perf bpf-filter: unhandled mutex:spin entry in parse_lock_type_n=
ame()
- [Medium] perf bpf-filter: leak of bpf_link in perf_bpf_filter__prepare()
--

commit 62241acfb0cf66852754002cba52ca231185bd12
Author: Ian Rogers <irogers@google.com>

perf bpf-filter: Add lock_held() sample filter

This commit adds BPF sample filter predicates lock_held(), lock_held_read(),
lock_held_shared(), lock_held_write(), and lock_held_exclusive() to record
perf event samples only when a specified kernel lock is held. It evaluates
lock ownership by inspecting kernel lock owner fields directly where possib=
le
and falling back to a held_locks BPF hash map populated by fentry/fexit hoo=
ks
on kernel lock and unlock functions.

> diff --git a/tools/perf/util/bpf-filter.c b/tools/perf/util/bpf-filter.c
> index 72e83ac1d6a4b..0c133b31b5d54 100644
> --- a/tools/perf/util/bpf-filter.c
> +++ b/tools/perf/util/bpf-filter.c

[ ... ]

> +static bool parse_lock_type_name(const char *name, unsigned int mode,
> +				 struct sample_filter_bpf *skel,
> +				 u64 *encoded_pair, unsigned int *prog_groups)
> +{
> +	bool found =3D false;
> +	u32 flag1 =3D 0xff, flag2 =3D 0xff;
> +	unsigned int groups =3D 0;
> +	const char *lookup =3D !strcmp(name, "pcpu-sem") ? "percpu-rwsem" : nam=
e;
> +
> +	for (size_t i =3D 0; i < ARRAY_SIZE(lock_type_table); i++) {
> +		u32 f =3D lock_type_table[i].flags;
> +		bool is_read =3D (f & LCB_F_READ) !=3D 0;
> +
> +		if (strcmp(lock_type_table[i].lock_name, lookup) &&
> +		    strcmp(lock_type_table[i].flags_name, name))
> +			continue;
> +
> +		/*
> +		 * percpu_down_read() / percpu_up_read() fast paths are inlined
> +		 * per-CPU counter increments without function entry points, so
> +		 * only writer holding (percpu_down_write / percpu_up_write) can
> +		 * be tracked for percpu-rwsem. rwlock-rt is also not hooked.
> +		 */
> +		if ((f & LCB_F_PERCPU) && is_read)
> +			continue;
> +		if ((f & LCB_F_RT) && (f & (LCB_F_READ | LCB_F_WRITE)))
> +			continue;
> +
> +		if (is_read && !(mode & PBF_LOCK_MODE_READ))
> +			continue;
> +		if (!is_read && !(mode & PBF_LOCK_MODE_WRITE))
> +			continue;
> +
> +		if (!found)
> +			flag1 =3D f;
> +		else if (f !=3D flag1)
> +			flag2 =3D f;
> +		if (skel && f < LCB_F_TYPE_MAX) {
> +			skel->bss->has_lock_type =3D 1;
> +			skel->bss->lock_type_filter[f] =3D 1;
> +		}
> +		groups |=3D lock_flags_to_prog_group(f);
> +		found =3D true;
> +	}

[Severity: Medium]
Should parse_lock_type_name() also skip the LCB_F_MUTEX | LCB_F_SPIN entries
in lock_type_table?

lock_type_table contains both { LCB_F_MUTEX | LCB_F_SPIN, "mutex", "mutex" }
and { LCB_F_MUTEX | LCB_F_SPIN, "mutex:spin", "mutex-spin" }, whereas all
mutex hooks in sample_filter.bpf.c record acquisitions with LCB_F_MUTEX:

tools/perf/util/bpf_skel/sample_filter.bpf.c:
    SEC("fexit/mutex_lock")
    int BPF_PROG(fexit_mutex_lock, void *lock)
    {
        return record_lock_acquired(ctx, LCB_F_MUTEX);
    }

Because LCB_F_MUTEX | LCB_F_SPIN is never recorded in held_locks, filters
like lock_held(mutex:spin) or lock_held(mutex-spin) are accepted and attach
all mutex fentry/fexit hooks, but only set
lock_type_filter[LCB_F_MUTEX | LCB_F_SPIN] =3D 1 and always evaluate to 0.
Furthermore, lock_held(mutex) encodes flag2 =3D LCB_F_MUTEX | LCB_F_SPIN,
causing is_lock_type_in_map() to perform two extra BPF map lookups on every
sample whenever no mutex is held.

[ ... ]

> +static int configure_lock_progs(struct sample_filter_bpf *skel, struct b=
tf *btf,
> +				unsigned int needed_groups,
> +				unsigned int required_groups,
> +				bool needs_lock_syms, bool needs_slab_iter,
> +				bool is_tracepoint)
> +{
> +	unsigned int supported_groups =3D supported_lock_prog_groups(btf);
> +	unsigned int enabled_progs =3D 0;
> +
> +	bpf_program__set_autoload(skel->progs.perf_sample_filter, !is_tracepoin=
t);
> +	bpf_program__set_autoload(skel->progs.perf_tp_sample_filter, is_tracepo=
int);
> +
> +	if ((required_groups & supported_groups) !=3D required_groups) {
> +		pr_err("Error: Kernel BTF lacks required lock/unlock tracing entry poi=
nts\n");
> +		return -ENOTSUP;
> +	}
> +
> +	needed_groups &=3D supported_groups;
> +	if (skel)
> +		skel->bss->track_rwsem_read =3D !!(needed_groups & LOCK_PROG_RWSEM_REA=
D);
> +
> +	for (size_t i =3D 0; i < ARRAY_SIZE(lock_progs); i++) {
> +		struct bpf_program **progp =3D (void *)skel + lock_progs[i].prog_offse=
t;
> +		struct bpf_program *prog =3D *progp;
> +		bool enable =3D false;
> +
> +		if ((needed_groups & lock_progs[i].group) && btf &&
> +		    lock_progs[i].btf_func) {
> +			if (btf__find_by_name_kind(btf, lock_progs[i].btf_func,
> +						   BTF_KIND_FUNC) > 0)
> +				enable =3D true;
> +		}
> +
> +		if (enable)
> +			enabled_progs++;
> +		bpf_program__set_autoload(prog, enable);
> +	}
> +
> +	bpf_program__set_autoload(skel->progs.collect_lock_syms, needs_lock_sym=
s);
> +	if (needs_slab_iter && btf &&
> +	    btf__find_by_name_kind(btf, "bpf_iter__kmem_cache", BTF_KIND_STRUCT=
) > 0) {
> +		bpf_program__set_autoload(skel->progs.slab_cache_iter, true);
> +	} else {
> +		bpf_program__set_autoload(skel->progs.slab_cache_iter, false);
> +	}
> +
> +	if (needed_groups && !enabled_progs) {
> +		pr_err("Error: Kernel BTF lacks required lock tracing entry points\n");
> +		return -ENOTSUP;
> +	}
> +	return 0;
> +}

[Severity: Medium]
Can this final check in configure_lock_progs() ever trigger?

Earlier in configure_lock_progs(), needed_groups is masked in-place via
needed_groups &=3D supported_groups. Because every group bit set by
supported_lock_prog_groups(btf) guarantees that its corresponding BTF
functions exist in lock_progs[], enabled_progs will only be 0 when
(needed_groups & supported_groups) is 0. However, in that case
needed_groups &=3D supported_groups has already cleared needed_groups to 0,=
 so
if (needed_groups && !enabled_progs) always evaluates to false.

When a filter specifies a target with required_groups =3D=3D 0 and
needed_groups =3D=3D LOCK_PROG_ALL (such as a hex lock address, a slab cach=
e like
&dentry, or a lock symbol without a recognized type suffix like
&tasklist_lock) on a kernel without BTF or lacking the lock entry points,
configure_lock_progs() will silently succeed with zero lock-tracking progra=
ms
enabled instead of returning -ENOTSUP.

[ ... ]

> +static int resolve_lock_expr(struct sample_filter_bpf *skel,
> +			     struct perf_bpf_filter_expr *expr,
> +			     struct perf_bpf_filter_entry *entry)
> +{

[ ... ]

> +	ret =3D find_kernel_lock_sym(base, &addr);
> +	if (ret =3D=3D 0) {
> +		unsigned int direct_flag =3D 0;
> +
> +		if (strtailcmp(base, "rt_mutex") =3D=3D 0 || strtailcmp(base, "rtmutex=
") =3D=3D 0)
> +			direct_flag =3D PBF_LOCK_DIRECT_RTMUTEX;
> +		else if (strtailcmp(base, "mutex") =3D=3D 0)
> +			direct_flag =3D PBF_LOCK_DIRECT_MUTEX;
> +		else if (strtailcmp(base, "rwsem") =3D=3D 0 &&
> +			 strtailcmp(base, "percpu_rwsem") !=3D 0 &&
> +			 strtailcmp(base, "pcpu_rwsem") !=3D 0)
> +			direct_flag =3D PBF_LOCK_DIRECT_RWSEM;
> +
> +		entry->part =3D PBF_LOCK_ADDR | mode | direct_flag;
> +		entry->target =3D addr;
> +		if (skel) {
> +			int fd =3D bpf_map__fd(skel->maps.lock_addr_filter);
> +
> +			bpf_map_update_elem(fd, &addr, &one, BPF_ANY);
> +			skel->bss->has_lock_addr =3D 1;
> +		}
> +		return 0;
> +	}

[Severity: Medium]
Should resolve_lock_expr() reject read-only mode (!(mode & PBF_LOCK_MODE_WR=
ITE))
when a global/static kernel lock symbol has an exclusive-only suffix?

In prescan_one_lock_expr(), symbols ending in rt_mutex, rtmutex, mutex,
percpu_rwsem, pcpu_rwsem, or spinlock only enable their respective exclusive
BPF program groups, which only increment write_count.

If a user specifies read/shared mode on such a symbol (for example,
lock_held_read(&cgroup_mutex) or lock_held(&cgroup_mutex:R)),
resolve_lock_expr() accepts it without returning -EINVAL, attaches the
exclusive lock hooks, and sets mode to PBF_LOCK_MODE_READ. At runtime in
check_lock_held(), is_direct_lock_owner() is skipped when
mode =3D=3D PBF_LOCK_MODE_READ and match_held_val() checks val->read_count =
> 0,
which can never be non-zero.

[ ... ]

> @@ -501,23 +1434,44 @@ int perf_bpf_filter__prepare(struct evsel *evsel, =
struct target *target)
>  		goto err;
>  	}
> =20
> -	prog =3D skel->progs.perf_sample_filter;
> -	for (x =3D 0; x < xyarray__max_x(evsel->core.fd); x++) {
> -		for (y =3D 0; y < xyarray__max_y(evsel->core.fd); y++) {
> -			link =3D bpf_program__attach_perf_event_opts(prog, FD(evsel, x, y),
> -								   &pe_opts);
> -			if (IS_ERR(link)) {
> -				pr_err("Failed to attach perf sample-filter program\n");
> -				ret =3D PTR_ERR(link);
> -				goto err;
> +	if (is_tracepoint) {
> +		/*
> +		 * For PERF_TYPE_TRACEPOINT, PERF_EVENT_IOC_SET_BPF attaches the
> +		 * BPF program to event->tp_event->prog_array on the shared
> +		 * trace_event_call, which perf_trace_run_bpf_submit() executes
> +		 * for all CPUs and tasks before iterating the per-CPU perf
> +		 * events. Attach once on the first FD so tp_event->prog_array
> +		 * does not get duplicate copies for each per-CPU FD.
> +		 */
> +		prog =3D skel->progs.perf_tp_sample_filter;
> +		link =3D bpf_program__attach_perf_event_opts(prog, FD(evsel, 0, 0),
> +							   &pe_opts);
> +		ret =3D libbpf_get_error(link);
> +		if (ret) {
> +			pr_err("Failed to attach perf tracepoint sample-filter program\n");
> +			goto err;
> +		}
> +	} else {
> +		prog =3D skel->progs.perf_sample_filter;
> +		for (x =3D 0; x < xyarray__max_x(evsel->core.fd); x++) {
> +			for (y =3D 0; y < xyarray__max_y(evsel->core.fd); y++) {
> +				link =3D bpf_program__attach_perf_event_opts(prog, FD(evsel, x, y),
> +									   &pe_opts);
> +				ret =3D libbpf_get_error(link);
> +				if (ret) {
> +					pr_err("Failed to attach perf sample-filter program\n");
> +					goto err;
> +				}
>  			}
>  		}
>  	}

[Severity: Medium]
Does perf_bpf_filter__prepare() leak the struct bpf_link returned by
bpf_program__attach_perf_event_opts() in the new is_tracepoint branch (as
well as in the existing per-FD loop)?

bpf_program__attach_perf_event_opts() heap-allocates a struct bpf_link_perf,
creates a kernel BPF_PERF_EVENT link fd holding references to the perf_event
file and BPF program, and returns ownership of the struct bpf_link * to the
caller without registering it in skel->links. Storing it in the local link
variable without saving or destroying it in perf_bpf_filter__destroy() (or =
on
the err path) leaks both the struct bpf_link_perf allocation and the kernel
link fd.

Because the leaked link fd holds a reference to the underlying perf_event
file, closing the evsel fds does not release the perf_event or detach
perf_tp_sample_filter from tp_event->prog_array while the process remains
alive (for example, across repeated runs in perf stat -r N).

[ ... ]

> @@ -532,6 +1486,21 @@ int perf_bpf_filter__prepare(struct evsel *evsel, s=
truct target *target)
>  	return ret;
>  }
> =20

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261018053710.2572=
636-1-irogers@google.com?part=3D2
