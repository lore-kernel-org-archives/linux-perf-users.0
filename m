Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C9531F16B
	for <linux-perf-users@vger.kernel.org>; Sat, 17 Oct 2026 17:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792258510; cv=none; b=oFQ8lOg2aKj8oozaXQeR4VKpjpmvNrr0mozY0VKqinR8uNni7yDrHtJKov0U6utAcgvKKlBtxcdb56i45A1ztEC5tFU9RlTEhxNtueI5NrEA4fX6E3S++7dBBSSEJNQtjXQ9X/JHutIMc3ZB4iiRVgamGptfgyGT5RRTPHc50zg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792258510; c=relaxed/simple;
	bh=U4fWEeVq3N4gI4TxaC6ezANoS672iOpFjNVE0YpmrTQ=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=jZguZkFhNcguFVFVHoBuhS7tcpTEyvPgZSKGLf9QWhY/7QGAvi80b6tr6P74Q++ExormrjTZvyzXZBt87Zj0nzH7TYBPT9lilP1DDsTM7dVUGE4v7Fmptk3JLc5fUZEOs+TCEanVbDMBhFpKAtqde6RHDBiXny9PatyxdONFGhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mObOvxYl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mObOvxYl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 552751F000C5;
	Sat, 17 Oct 2026 17:35:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792258509;
	bh=EbMsBDAmOsNP8pxLAbwhEMQI16Ha1cHaccsrZXYKoIg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mObOvxYln1x61TCgJajtbZOx/SE72bATgj64J6qJk0G48Bo3xnfynPe96BprWY9Pw
	 VmnV2Gyn3h4fdRAZI3bl+42z9mUOSnV65sdOVK9x6vmYl9AY++9AaxsxhAjHhK/Fb6
	 +SeecGjaRBC1JV6R8VqLCBb62xz6yCxW+VtUocPli539qGUD6n1Gh3vGhjjx+qYmRe
	 lS79Q64RNb/IVS7BgMeX2r+Xdqvf4zmfRgy/S2tz1SlnJ7HCLTugJKtLrY8C95RA6B
	 Xc30LOsS49udYjNvawe4UOW8GsWRzt+M54X6twTWCvj3PIJkIAA+LIWc4HQ3dcRU+z
	 1iDrIOmoaD7+w==
Message-ID: <sashiko-outbox-175711@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/6] perf bpf-filter: Add lock_held() sample filter
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261017171437.2066343-3-irogers@google.com>
References: <20261017054555.1655407-1-irogers@google.com>
 <20261017171437.2066343-1-irogers@google.com>
 <20261017171437.2066343-3-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 17 Oct 2026 17:35:08 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] perf bpf-filter: rwlock read_count leak in record_lock_acquired_=
owner()
- [Medium] perf bpf-filter: missing error return on node_data lookup in ini=
t_numa_data()
--

commit 782c7a3aaec8d457ca5bf045258b33f6bbfbcae8
Author: Ian Rogers <irogers@google.com>

perf bpf-filter: Add lock_held() sample filter

This commit adds BPF sample filter predicates lock_held(<lock>),
lock_held_read(<lock>) / lock_held_shared(<lock>), and
lock_held_write(<lock>) / lock_held_exclusive(<lock>) to record perf event
samples only when a specified kernel lock is held. It evaluates lock
ownership directly in kernel memory where possible and falls back to a
held_locks BPF hash map populated by fentry/fexit hooks on kernel
lock/unlock functions.

> diff --git a/tools/perf/util/bpf-filter.c b/tools/perf/util/bpf-filter.c
> index 72e83ac1d6a4b..2f4c6bd85f89f 100644
> --- a/tools/perf/util/bpf-filter.c
> +++ b/tools/perf/util/bpf-filter.c
[ ... ]
> @@ -155,9 +171,814 @@ static int check_sample_flags(struct evsel *evsel, =
struct perf_bpf_filter_expr *
[ ... ]
> +static void init_numa_data(struct sample_filter_bpf *skel, struct btf *b=
tf)
> +{
> +	u64 addr =3D 0;
> +	char *buf =3D NULL, *p;
> +	size_t len;
> +	long last =3D -1;
> +	int ret;
> +
> +	if (!btf)
> +		return;
> +
> +	ret =3D btf__find_by_name_kind(btf, "zone", BTF_KIND_STRUCT);
> +	if (ret < 0)
> +		return;
> +
> +	ret =3D btf__resolve_size(btf, ret);
> +	if (ret < 0)
> +		return;
> +
> +	skel->rodata->sizeof_zone =3D ret;
> +
> +	if (find_kernel_lock_sym("contig_page_data", &addr) =3D=3D 0) {
> +		skel->rodata->contig_page_data_addr =3D addr;
> +		return;
> +	}
> +
> +	if (find_kernel_lock_sym("node_data", &addr) =3D=3D 0)
> +		skel->rodata->node_data_addr =3D addr;
> +
> +	if (sysfs__read_str("devices/system/node/online", &buf, &len) >=3D 0) {
> +		p =3D buf;
> +		while (p && *p) {
> +			char *end;
> +
> +			last =3D strtol(p, &end, 0);
> +			if (end =3D=3D p)
> +				break;
> +			p =3D end;
> +			if (*p =3D=3D ',' || *p =3D=3D '-' || *p =3D=3D '\n')
> +				p++;
> +		}
> +		skel->rodata->nr_nodes =3D last + 1;
> +		free(buf);
> +	}
> +}

[Severity: Medium]
What happens in init_numa_data() when find_kernel_lock_sym("node_data",
&addr) fails (for example, when /proc/kallsyms zeroes symbol addresses
under kptr_restrict for a non-root user with CAP_BPF)?

Unlike init_numa_data() in tools/perf/util/bpf_lock_contention.c, this does
not return early on failure, so skel->rodata->node_data_addr remains 0
while skel->rodata->nr_nodes is populated from devices/system/node/online.

When collect_lock_syms later calls do_collect_lock_syms() ->
do_collect_zone_lock() in tools/perf/util/bpf_skel/lock_data.h:

	} else if (nr_nodes > 0) {
		struct pglist_data **node_data =3D (void *)(long)node_data_addr;

		for (int i =3D 0; i < nr_nodes; i++) {
			struct pglist_data *pgdat =3D NULL;
			int err;

			err =3D bpf_core_read(&pgdat, sizeof(pgdat), &node_data[i]);

will this attempt to read from kernel address 0x0 and leave lock_syms
unpopulated without reporting an error for lock_held(zone_lock)?

[ ... ]
> diff --git a/tools/perf/util/bpf_skel/sample_filter.bpf.c b/tools/perf/ut=
il/bpf_skel/sample_filter.bpf.c
> index e5666d4c17228..480ba4b49793d 100644
> --- a/tools/perf/util/bpf_skel/sample_filter.bpf.c
> +++ b/tools/perf/util/bpf_skel/sample_filter.bpf.c
[ ... ]
> @@ -295,4 +525,739 @@ int perf_sample_filter(void *ctx)
[ ... ]
> +static __always_inline int record_lock_acquired_owner(__u64 lock_addr, _=
_u32 flags, __u32 owner_id)
> +{
[ ... ]
> +	existing =3D bpf_map_lookup_elem(&held_locks, &addr_key);
> +	if (existing) {
> +		/* Non-reader locks are not recursive; avoid double-counting */
> +		if (!is_read && existing->write_count > 0)
> +			return 0;
> +		if (is_read)
> +			__sync_fetch_and_add(&existing->read_count, 1);
> +		else
> +			__sync_fetch_and_add(&existing->write_count, 1);
> +	} else {
> +		struct held_lock_val first =3D {
> +			.read_count =3D is_read ? 1 : 0,
> +			.write_count =3D is_read ? 0 : 1,
> +			.flags =3D flags,
> +		};
> +
> +		if (bpf_map_update_elem(&held_locks, &addr_key, &first, BPF_ANY) < 0)
> +			return 0;
> +	}
> +
> +	if (class_id)
> +		update_held_lock_count(class_id, owner_id, PBF_LOCK_CLASS, flags, true=
);
> +	if (kmem_cache_addr) {
> +		update_held_lock_count((__u64)kmem_cache_addr, owner_id,
> +				       PBF_LOCK_SLAB, flags, true);
> +	}
> +	if (match_type)
> +		update_held_lock_count(type_flag, owner_id, PBF_LOCK_TYPE, flags, true=
);
> +
> +	return 0;
> +}

[Severity: Medium]
Can record_lock_acquired_owner() leak read_count in the held_locks map when
rwlocks are acquired via read_lock_irq() or read_lock_bh() on kernels with
CONFIG_GENERIC_LOCKBREAK=3Dy and CONFIG_DEBUG_LOCK_ALLOC=3Dn?

In kernel/locking/spinlock.c, BUILD_LOCK_OPS(read, rwlock, __acquires_share=
d)
implements __raw_read_lock_irq() and __raw_read_lock_bh() by calling the
noinline function _raw_read_lock_irqsave():

	static void __lockfunc __raw_##op##_lock_irq(locktype##_t *lock)	\
		lock_ctx_op(lock)						\
	{									\
		_raw_##op##_lock_irqsave(lock);					\
	}									\
										\
	static void __lockfunc __raw_##op##_lock_bh(locktype##_t *lock)		\
		lock_ctx_op(lock)						\
	{									\
		unsigned long flags;						\
		flags =3D _raw_##op##_lock_irqsave(lock);				\
		local_bh_disable();						\
		local_irq_restore(flags);					\
	}

Since LOCK_PROG_RWLOCK_READ attaches fexit hooks to _raw_read_lock_irq,
_raw_read_lock_bh, and _raw_read_lock_irqsave, a single read_lock_irq() or
read_lock_bh() call fires both the inner fexit_raw_read_lock_irqsave hook
and the outer fexit_raw_read_lock_irq / fexit_raw_read_lock_bh hook.

Because is_read is true for LCB_F_SPIN | LCB_F_READ, the nested-call check
(!is_read && existing->write_count > 0) is bypassed and read_count is
incremented twice (for PBF_LOCK_ADDR as well as any active PBF_LOCK_SLAB or
PBF_LOCK_TYPE entries). On release, _raw_read_unlock_irq() and
_raw_read_unlock_bh() do not call _raw_read_unlock_irqrestore(), so
record_lock_released() only runs once, leaving read_count permanently
elevated in held_locks.

[ ... ]
> +/* RWlock acquire/release hooks */
> +SEC("fexit/_raw_read_lock")
> +int BPF_PROG(fexit_raw_read_lock, void *lock)
> +{
> +	return record_lock_acquired(ctx, LCB_F_SPIN | LCB_F_READ);
> +}
> +
> +SEC("fexit/_raw_read_lock_irq")
> +int BPF_PROG(fexit_raw_read_lock_irq, void *lock)
> +{
> +	return record_lock_acquired(ctx, LCB_F_SPIN | LCB_F_READ);
> +}
> +
> +SEC("fexit/_raw_read_lock_irqsave")
> +int BPF_PROG(fexit_raw_read_lock_irqsave, void *lock, unsigned long flag=
s)
> +{
> +	return record_lock_acquired(ctx, LCB_F_SPIN | LCB_F_READ);
> +}
> +
> +SEC("fexit/_raw_read_lock_bh")
> +int BPF_PROG(fexit_raw_read_lock_bh, void *lock)
> +{
> +	return record_lock_acquired(ctx, LCB_F_SPIN | LCB_F_READ);
> +}
[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261017171437.2066=
343-1-irogers@google.com?part=3D2
