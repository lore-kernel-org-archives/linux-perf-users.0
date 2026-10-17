Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7821637F01B
	for <linux-perf-users@vger.kernel.org>; Sat, 17 Oct 2026 17:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792258223; cv=none; b=RfsLrBkZV4ub3Bi8ZWc+Qt938vUH8Eo5nr5nk6hYNsieD6q/iQs7XKa/weXMWGMhuL1ceoAmW8pFgN/3jSWRSU2t49VIbo0mgfc9HPZTgz9Zqf+YQGAu9kKNTsPYANsC1doF38rGwFAYy76O1fCpFqkATfWbnuWwtM40Df9ZP2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792258223; c=relaxed/simple;
	bh=4Kwa3Y7wGAqaqLdgccFfnmsFHjlcIdqyEgcY34IEbAg=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=AUmLvOW2oZ71W/mMnrazCQSIIzrhx/93ZQW2xlVR8jlBIDrMiUOUMmFC3Vmkj5GOFxN9Z/KLHk+Rodfg3Y7o4AsT2i0EEC8a9UxrqOZhb/+RXRYfpAcAgQxcZADOBsDFO7tPLhMvOg/X0GUUr9PUOdWCJ00YgnFWR2a2+Z21Gac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J1UV+c14; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J1UV+c14"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FB0F1F000C4;
	Sat, 17 Oct 2026 17:30:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792258222;
	bh=DiDl4kPscuK/8gn6KIXM0nKfNvev3QSLVQnWp+1eo08=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=J1UV+c14Rh60MQeVGl+JfR8aj6wnPA5IJu1A/l51wxuJgvt+J844a6xHFKpND6x8e
	 onO8Ne85FDT7po2NJRnnJ3AYZnseMxOpzpr9eaiUyrVzzdJV7CzXFvc0GWtJIT0WGw
	 spxR9kSsbiqRnk9rd042HDZD1fxgaODN5Uc8H637KQ0bDFIauQXQ9cpQxrMblm32VR
	 V1rUTeKYF2wLGgqd7WUE61OoV2GGFsvpWQBJbQjs7PAJd8c+FhVCMZjs9a1cQwRugB
	 hfVXp3NMKTEta0Kdl8QH9Owhqxt+/H+3by4nwS0i4fpAKD4RcmDv0yYmNmqx/UG5cO
	 w4wQi+3kbP5nw==
Message-ID: <sashiko-outbox-175708@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 5/6] perf lock contention: Extend BPF lock contention
 to RCU and SRCU
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261017171437.2066343-6-irogers@google.com>
References: <20261017054555.1655407-1-irogers@google.com>
 <20261017171437.2066343-1-irogers@google.com>
 <20261017171437.2066343-6-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 17 Oct 2026 17:30:21 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] perf lock: rcu_state_addr collides with rcu_state.node[0].lock i=
n BPF
--

commit 66aefea7c5ca7c7c5ee421770f454d75f5c24b84
Author: Ian Rogers <irogers@google.com>

perf lock contention: Extend BPF lock contention to RCU and SRCU

This commit extends 'perf lock contention --use-bpf' to track RCU and SRCU
grace-period and barrier waits using fentry/fexit BPF programs and adds
support for filtering by RCU and SRCU lock types and names.

> diff --git a/tools/perf/util/bpf_lock_contention.c b/tools/perf/util/bpf_=
lock_contention.c
> index c20bd075664e1..fa7df9187b08b 100644
> --- a/tools/perf/util/bpf_lock_contention.c
> +++ b/tools/perf/util/bpf_lock_contention.c
[ ... ]
> @@ -180,6 +181,129 @@ static void init_numa_data(struct lock_contention *=
con)
[ ... ]
> +static void configure_rcu_contention_progs(struct lock_contention *con,
> +					   bool has_rcu_lock)
> +{
[ ... ]
> +	sym =3D machine__find_kernel_symbol_by_name(con->machine, "rcu_state", =
&kmap);
> +	if (sym) {
> +		skel->rodata->rcu_state_addr =3D map__unmap_ip(kmap, sym->start);
> +		map__put(kmap);
> +	} else {
> +		skel->rodata->rcu_state_addr =3D 1ULL;
> +	}
[ ... ]
> diff --git a/tools/perf/util/bpf_skel/lock_contention.bpf.c b/tools/perf/=
util/bpf_skel/lock_contention.bpf.c
> index 0f2118006005a..58d45c43150b5 100644
> --- a/tools/perf/util/bpf_skel/lock_contention.bpf.c
> +++ b/tools/perf/util/bpf_skel/lock_contention.bpf.c
[ ... ]
> @@ -613,14 +639,19 @@ int contention_end(u64 *ctx)
>  	 */
>  	pelem =3D bpf_map_lookup_elem(&tstamp_cpu, &idx);
>  	if (pelem && pelem->lock) {
> -		if (pelem->lock !=3D ctx[0])
> +		if (pelem->lock !=3D lock)
>  			return 0;
>  	} else {
>  		pid =3D bpf_get_current_pid_tgid();
>  		pelem =3D bpf_map_lookup_elem(&tstamp, &pid);
> -		if (!pelem || pelem->lock !=3D ctx[0])
> -			return 0;
> -		need_delete =3D true;
> +		if (pelem && pelem->lock =3D=3D lock) {
> +			ts_map =3D &tstamp;
> +		} else {
> +			pelem =3D bpf_map_lookup_elem(&tstamp_rcu, &pid);
> +			if (!pelem || pelem->lock !=3D lock)
> +				return 0;
> +			ts_map =3D &tstamp_rcu;
> +		}
>  	}

[Severity: Medium]
Can setting rcu_state_addr to the start address of rcu_state and sharing
do_contention_end() between tp_btf/contention_end and the RCU/SRCU fexit
hooks cause lock address collisions and corrupted wait tracking?

In kernel/rcu/tree.h, struct rcu_state begins at offset 0 with
node[NUM_RCU_NODES], and struct rcu_node begins at offset 0 with its
raw_spinlock_t lock:

kernel/rcu/tree.h:
    struct rcu_node {
        raw_spinlock_t __private lock;
        ...
    };

    struct rcu_state {
        struct rcu_node node[NUM_RCU_NODES];
        ...
    };

Because of this layout, &rcu_state.node[0].lock has the exact same address
as rcu_state (rcu_state_addr). Together with do_contention_end() not
distinguishing whether its caller is tp_btf/contention_end or an RCU/SRCU
fexit program, three issues can occur:

1. When filtering for RCU (for example with '-Y rcu', '-Y rcu:W', or
'-L rcu'), a task executing synchronize_rcu(), synchronize_rcu_expedited(),
or rcu_barrier() records an active entry in tstamp_rcu[pid] with
pelem->lock =3D=3D rcu_state_addr. If that task contends on
&rcu_state.node[0].lock during grace-period initialization or waiting,
tp_btf/contention_begin(lock =3D rcu_state_addr, flags =3D LCB_F_SPIN) is
rejected by can_record(), leaving tstamp_cpu empty. When the spinlock is
acquired and tp_btf/contention_end(lock =3D rcu_state_addr) fires,
do_contention_end() falls through tstamp_cpu and tstamp into
tstamp_rcu[pid], matches pelem->lock =3D=3D rcu_state_addr, records the sho=
rt
spinlock wait duration as the RCU wait, and deletes tstamp_rcu[pid] before
the fexit hook runs.

2. If an RCU or SRCU fexit program runs on a CPU where tstamp_cpu happens
to have an active spinlock entry (pelem->lock !=3D 0 and pelem->lock !=3D l=
ock),
do_contention_end() returns 0 at the tstamp_cpu check without looking up or
deleting tstamp_rcu[pid]. That leaves a stale entry in tstamp_rcu[pid] that
blocks subsequent RCU/SRCU waits for that task in get_tstamp_elem() and
charges end_ts - pelem->timestamp in account_end_timestamp().

3. In LOCK_AGGR_ADDR mode ('perf lock con -a -b -l'), both
do_contention_end() and lock_contention_read() key lock_stat entries by
lock address:

tools/perf/util/bpf_skel/lock_contention.bpf.c:do_contention_end()
    case LOCK_AGGR_ADDR:
        key.lock_addr_or_cgroup =3D pelem->lock;

Because &rcu_state.node[0].lock and rcu_state_addr share the same address,
root rcu_node spinlock contentions (LCB_F_SPIN) and RCU grace-period waits
(LCB_F_RCU | LCB_F_WRITE) merge into a single lock_stat entry under
whichever lock type was recorded first.

Would it make sense to pass a distinct synthetic address or offset for RCU
waits (or disambiguate the lock key), and pass an explicit flag to
do_contention_end() so that RCU/SRCU fexit hooks only inspect tstamp_rcu
while tp_btf/contention_end only inspects tstamp_cpu and tstamp?

[ ... ]
> @@ -795,11 +825,109 @@ int contention_end(u64 *ctx)
>  		check_lock_delay(pelem->lock);
> =20
>  	pelem->lock =3D 0;
> -	if (need_delete)
> -		bpf_map_delete_elem(&tstamp, &pid);
> +	if (ts_map)
> +		bpf_map_delete_elem(ts_map, &pid);
>  	return 0;
>  }
> =20
> +SEC("tp_btf/contention_begin")
> +int contention_begin(u64 *ctx)
> +{
> +	return do_contention_begin(ctx, (__u64)ctx[0], (__u32)ctx[1]);
> +}
> +
> +SEC("tp_btf/contention_end")
> +int contention_end(u64 *ctx)
> +{
> +	return do_contention_end((__u64)ctx[0], (__s32)ctx[1]);
> +}
> +
> +/* RCU grace-period synchronize / barrier contention hooks */
> +SEC("fentry/synchronize_rcu")
> +int BPF_PROG(fentry_synchronize_rcu)
> +{
> +	return do_contention_begin(ctx, rcu_state_addr, LCB_F_RCU | LCB_F_WRITE=
);
> +}
> +
> +SEC("fexit/synchronize_rcu")
> +int BPF_PROG(fexit_synchronize_rcu)
> +{
> +	return do_contention_end(rcu_state_addr, 0);
> +}
[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261017171437.2066=
343-1-irogers@google.com?part=3D5
