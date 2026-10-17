Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 484C53A1686
	for <linux-perf-users@vger.kernel.org>; Sat, 17 Oct 2026 17:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792258284; cv=none; b=OShVJwTgQfnsSP8ak/OUUlCpfVFHrcOYzEumn2yQc5Ypw+qeSs9xXBEoDkkoOZrI5deUGY5dqgDN6uoUpWTzBdh56d8D5MG6usCLTk5j1Gv1z52aOwLaRvAJccGVm66V5zWBi3OSnrfFhXKhxyuHjst3H4IBN5ABww8k26su+r8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792258284; c=relaxed/simple;
	bh=FfdchEwt85GmpPxjQ32aMWYlTkMSwE8AqbT9MO3xQCA=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=G1XI8cd5yblWLEo5OADrGWAMlPxNPjabzZwZiqQxiXGtrLkbfsAq3IMzLVQKZvz1zyAwLL0lv8s4eisABndBDJeRNuPKM2E8fLdWCPnwIbmRP7Zb6cdfLAnn2uzVkRIxPa3BE2ZtDMwDsml1mJoCKNw0MgBQt7z1LBBaAaqwMa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iwLZfo8v; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iwLZfo8v"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D27B41F000C4;
	Sat, 17 Oct 2026 17:31:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792258283;
	bh=lJe4huhoE6dlL72SOkVakG1eA2Ep01PoKybvAO8vpZM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=iwLZfo8vlALcKfYaWRY1QLUa9dclJXw62mItsGTbPPYkpQo6BjO3rtX8EoraJHiym
	 LpsbF8H2uz8riC+ka5PVl8MGT5NFj9dDWkhvOVU7DSRvrsA/0/se1L++pDaTzlLv4m
	 Qq/yrR5WaOnQHDa1VTCGpBUKcjivdAtT0t784UOI4Bhsz3WDMJRpevseLUkXlMUya8
	 LtdNptcBYZaLNyi2b62CluH2WjmLDM1pRdSUxxX22bCGL0cKZDNKhxObiWMJRiDsYL
	 06tWcXEA2M/B5LOH8f8PQyq+46FmIeFlWcR749oWbvSxyxhmXViLcdhT/uHf0A3CY8
	 nLvyaOF3SdqLw==
Message-ID: <sashiko-outbox-175709@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/6] perf lock contention: Share common BPF and lock
 type definitions in lock_data.h
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261017171437.2066343-2-irogers@google.com>
References: <20261017054555.1655407-1-irogers@google.com>
 <20261017171437.2066343-1-irogers@google.com>
 <20261017171437.2066343-2-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 17 Oct 2026 17:31:22 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] perf lock: get_lock_owner() conflates waiter and owner rwsem fla=
gs
--

commit bc2b5a2f6b16ec842dcc1aeeebcdc72f657fd11b
Author: Ian Rogers <irogers@google.com>

perf lock contention: Share common BPF and lock type definitions in lock_da=
ta.h

This commit moves lock_type_table, LCB_F_* flags, CO-RE structs, and common
BPF lock helpers into tools/perf/util/bpf_skel/lock_data.h so they can be
shared with BPF sample filtering. It also extends get_lock_owner() to suppo=
rt
rt_mutex and check writer-ownership and handoff flags.

> diff --git a/tools/perf/util/bpf_skel/lock_data.h b/tools/perf/util/bpf_s=
kel/lock_data.h
> index 652e114e6b877..bf39128e0be15 100644
> --- a/tools/perf/util/bpf_skel/lock_data.h
> +++ b/tools/perf/util/bpf_skel/lock_data.h
> @@ -76,4 +84,320 @@ struct slab_cache_data {

[ ... ]

> +static __always_inline struct task_struct *get_lock_owner(__u64 lock, __=
u32 flags)
> +{
> +	struct task_struct *task;
> +	__u64 owner =3D 0;
> +
> +	if (flags & LCB_F_MUTEX) {
> +		struct mutex *mutex =3D (void *)lock;
> +
> +		if (bpf_core_field_exists(mutex->owner.counter)) {
> +			owner =3D BPF_CORE_READ(mutex, owner.counter);
> +			if (owner & 0x4UL)
> +				return NULL;
> +		} else if (bpf_core_type_exists(struct rt_mutex_base)) {
> +			struct rt_mutex_base *rtm =3D (void *)lock;
> +
> +			owner =3D (__u64)BPF_CORE_READ(rtm, owner);
> +			return (void *)(owner & ~1UL);
> +		}
> +	} else if (flags =3D=3D LCB_F_READ || flags =3D=3D LCB_F_WRITE) {
> +		struct rw_semaphore___new *rwsem =3D (void *)lock;
> +
> +		if (flags =3D=3D LCB_F_WRITE && bpf_core_field_exists(rwsem->count.cou=
nter)) {
> +			__u64 count =3D BPF_CORE_READ(rwsem, count.counter);
> +
> +			/* Must have RWSEM_WRITER_LOCKED (bit 0) set */
> +			if (!(count & 1UL))
> +				return NULL;
> +		}
> +	/*
> +	 * Support for the BPF_TYPE_MATCHES argument to the
> +	 * __builtin_preserve_type_info builtin was added at some point during
> +	 * development of clang 15 and it's what is needed for
> +	 * bpf_core_type_matches.
> +	 */
> +#if __has_builtin(__builtin_preserve_type_info) && __clang_major__ >=3D =
15
> +		if (bpf_core_type_matches(struct rw_semaphore___old)) {
> +			struct rw_semaphore___old *old =3D (void *)lock;
> +
> +			owner =3D (unsigned long)BPF_CORE_READ(old, owner);
> +		} else if (bpf_core_type_matches(struct rw_semaphore___new)) {
> +			owner =3D BPF_CORE_READ(rwsem, owner.counter);
> +		}
> +#else
> +		/* assume new struct */
> +		if (bpf_core_field_exists(rwsem->owner.counter))
> +			owner =3D BPF_CORE_READ(rwsem, owner.counter);
> +#endif
> +		/* RWSEM_READER_OWNED is bit 0 of owner */
> +		if (flags =3D=3D LCB_F_WRITE && (owner & 1UL))
> +			return NULL;

[Severity: Medium]
In tools/perf/util/bpf_skel/lock_contention.bpf.c, contention_begin() calls
get_lock_owner(pelem->lock, pelem->flags) for both owner stack tracing and
LOCK_AGGR_TASK owner PID attribution:

tools/perf/util/bpf_skel/lock_contention.bpf.c:contention_begin() {
	...
	task =3D get_lock_owner(pelem->lock, pelem->flags);
	if (!task)
		goto skip_owner;
	...
	if (lock_owner) {
		task =3D get_lock_owner(pelem->lock, pelem->flags);
	...
}

Here pelem->flags comes from trace_contention_begin() and represents the
contending waiter's mode (LCB_F_READ in rwsem_down_read_slowpath() or
LCB_F_WRITE in rwsem_down_write_slowpath()), rather than the lock owner's
mode.

When a writer contends on a reader-owned rw_semaphore, pelem->flags is
LCB_F_WRITE while rwsem->count does not have RWSEM_WRITER_LOCKED (bit 0) set
and rwsem->owner has RWSEM_READER_OWNED (bit 0) set. Conversely, when a
reader contends (flags =3D=3D LCB_F_READ), both checks are bypassed.

Will checking flags =3D=3D LCB_F_WRITE in get_lock_owner() cause it to alwa=
ys
return NULL whenever a writer contends on a reader-owned rw_semaphore,
dropping owner attribution and owner callstacks in perf lock contention -b =
-o?

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261017171437.2066=
343-1-irogers@google.com?part=3D1
