Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792538261;
	b=hx9Lgkk/OmMS0FWTJ8JQ/69UG/qpO5icYga8pOeofaMNhj8RkdFEJYI9iSF0t3e6FTHU
	 egzilSTsZXsTuqurm1Eg3yAyhOMB7pU+hBHHJotti8UDGzeI62Ehudd5phVEzvm7eyN2R
	 52ElBVPlBNkRRjGXr0T9GGXaSS658euIWXJt7XV5I1DF7T+UrA+FIcfPAp3tCPPZQHBii
	 J1sh8xY6Hfjbr6MnAa1bbaWS0nNDECfAn7RHsyH28CRUTFOg+jMby9KRQuwnpmsQKZs69
	 FB7FYsfU2MEmOYfLte5DFlUz/ge+hLnaFacdu9HnNJVEFdJmhwgZ4YshsqaLxFvn5yQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792538261;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=KOsvKf24lI901yy8ICFznnvv1AaZdxqz6vs8G+cg9Jc=;
	b=qTe4q9Op9g8Ajj0VeCFpGg5Cfb2Ked/E0+ryvPwmsUvjJwlfcCRg0h8M/5v2/rIlhiaE
	 25lG/845pt6OjfiR2UasKyd8IpiyGNA1tPPJK4HxkxhjmXlBzdjAAvcFGwvrV0joF6Tfs
	 rYNcjMldP3amm/zbKqucA5wHNyvLn2/2snRHMrcj9Z8bd67DjGRcmaceG+oQP5SjEEz19
	 RzJm1D5fEHCqSSMgO2SSB2jlsV3zgQn/91+E1MxJIP9Uux8iXnOmLMqOu+h7ZrOyTYpdi
	 +W8wzlUtbWh5YeSHlDYh+rK6OFTnAdS7YN1MHMhbHJD3gFB50moNunZ/EazG/dpJi7A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BYmVSPDr;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B7F3606A319
	for <linux-perf-users@vger.kernel.org>; Tue, 20 Oct 2026 23:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BYmVSPDr
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9EA21F000C9;
	Tue, 20 Oct 2026 23:17:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792538260;
	bh=KOsvKf24lI901yy8ICFznnvv1AaZdxqz6vs8G+cg9Jc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=BYmVSPDrMDdA3fMzDlb9SNKOHh7uSCtbQgBE3reVGn84zM5h9qoWwX7QsAoC7VMnc
	 cD+XiQSHgwCM07xK7Py6WT1v19iLQgMfp3mJI0RjbAyCXFj7cpi5bKfuinTdvEh2Bs
	 2DrwMsfmi42anazaVpZlIJ74pdxZPUQCg80LVIPPH+gwi8FTHmYuNMH9Pc0/2LUGhO
	 B3ZmryM/ixQxa6Za0tZzNjMNkfFulhufz65sBM4P6PI8O77Y7aKkFuRJNWaSxT0q6A
	 Td/r97RgBC6pRziiIiraFC2scnZC6MZ/jxALXizqTLvgMFu1CYUWLWvSYxpG5aIX/w
	 BABNCu/9IfV6Q==
Message-ID: <sashiko-outbox-179597@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 5/8] perf bpf-filter: Add lock_held() sample filter
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261020205859.1080743-6-irogers@google.com>
References: <20261019220915.3943592-1-irogers@google.com>
 <20261020205859.1080743-1-irogers@google.com>
 <20261020205859.1080743-6-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 20 Oct 2026 23:17:40 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] perf bpf-filter: strtailcmp() misclassifies short lock symbol na=
mes
--

commit 16bcda5fecfa952837c229e2749fdc8c298eb5ca
Author: Ian Rogers <irogers@google.com>

perf bpf-filter: Add lock_held() sample filter

This commit adds BPF sample filter predicates lock_held(), lock_held_read(),
and lock_held_write() (along with :R and :W suffixes) to filter perf samples
based on whether a specified kernel lock is held. It supports direct owner
inspection for mutexes, rt-mutexes, and write-locked rwsems, and uses BPF
fentry/fexit hooks with an LRU hash map for other lock families and modes.

> diff --git a/tools/perf/util/bpf-filter.c b/tools/perf/util/bpf-filter.c
> index ac0e7cf40f3af..d5a85ee98d5fd 100644
> --- a/tools/perf/util/bpf-filter.c
> +++ b/tools/perf/util/bpf-filter.c
[ ... ]
> @@ -166,9 +182,913 @@ static int check_sample_flags(struct evsel *evsel, =
struct perf_bpf_filter_expr *
[ ... ]
> +static void prescan_one_lock_expr(struct perf_bpf_filter_expr *expr,
> +				  bool *has_lock_filter,
> +				  unsigned int *prog_groups,
> +				  unsigned int *required_groups,
> +				  bool *needs_lock_syms,
> +				  bool *needs_slab_iter)
> +{
[ ... ]
> +	if (strtailcmp(base, "rt_mutex") =3D=3D 0 || strtailcmp(base, "rtmutex"=
) =3D=3D 0 ||
> +	    strtailcmp(base, "mutex") =3D=3D 0) {
> +		/* Inspected directly via lock->owner; no tracing hooks needed. */
> +		return;
> +	} else if (strtailcmp(base, "percpu_rwsem") =3D=3D 0 ||
> +		   strtailcmp(base, "pcpu_rwsem") =3D=3D 0) {
> +		*prog_groups |=3D LOCK_PROG_PERCPU_RWSEM;
> +		*required_groups |=3D LOCK_PROG_PERCPU_RWSEM;
> +	} else if (strtailcmp(base, "rwsem") =3D=3D 0) {
> +		if (mode & PBF_LOCK_MODE_READ) {
> +			*prog_groups |=3D LOCK_PROG_RWSEM_READ;
> +			*required_groups |=3D LOCK_PROG_RWSEM_READ;
> +		}
> +		if (mode & PBF_LOCK_MODE_WRITE) {
> +			*prog_groups |=3D LOCK_PROG_RWSEM_WRITE | LOCK_PROG_PERCPU_RWSEM;
> +			*required_groups |=3D LOCK_PROG_RWSEM_WRITE;
> +		}
> +	} else if (strtailcmp(base, "spinlock") =3D=3D 0) {
> +		*prog_groups |=3D LOCK_PROG_SPIN;
> +		*required_groups |=3D LOCK_PROG_SPIN;
> +	} else if (strtailcmp(base, "sem") =3D=3D 0) {
> +		*prog_groups |=3D LOCK_PROG_SEM;
> +		*required_groups |=3D LOCK_PROG_SEM;
> +	} else if (strtailcmp(base, "rwlock") =3D=3D 0) {
> +		if (mode & PBF_LOCK_MODE_READ)
> +			groups |=3D LOCK_PROG_RWLOCK_READ;
> +		if (mode & PBF_LOCK_MODE_WRITE)
> +			groups |=3D LOCK_PROG_RWLOCK_WRITE;
> +		*prog_groups |=3D groups;
> +		*required_groups |=3D groups;
> +	} else {
> +		*prog_groups |=3D LOCK_PROG_ALL;
> +	}
> +}
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
> +		if ((direct_flag =3D=3D PBF_LOCK_DIRECT_MUTEX ||
> +		     direct_flag =3D=3D PBF_LOCK_DIRECT_RTMUTEX ||
> +		     strtailcmp(base, "percpu_rwsem") =3D=3D 0 ||
> +		     strtailcmp(base, "pcpu_rwsem") =3D=3D 0 ||
> +		     strtailcmp(base, "spinlock") =3D=3D 0 ||
> +		     (strtailcmp(base, "sem") =3D=3D 0 &&
> +		      strtailcmp(base, "rwsem") !=3D 0)) &&
> +		    !(mode & PBF_LOCK_MODE_WRITE)) {
> +			pr_err("Error: Lock '%s' is exclusive and does not support read/share=
d mode\n",
> +			       name);
> +			return -EINVAL;
> +		}

[Severity: Medium]
Can strtailcmp() in prescan_one_lock_expr() and resolve_lock_expr() in
tools/perf/util/bpf-filter.c misclassify lock symbol names that are shorter
than the compared suffix?

In tools/perf/util/string.c, strtailcmp() compares characters backward from
the end of both strings and returns 0 as soon as either string reaches the
beginning:

int strtailcmp(const char *s1, const char *s2)
{
	int i1 =3D strlen(s1);
	int i2 =3D strlen(s2);
	while (--i1 >=3D 0 && --i2 >=3D 0) {
		if (s1[i1] !=3D s2[i2])
			return s1[i1] - s2[i2];
	}
	return 0;
}

Because strtailcmp() is symmetric, it returns 0 when base is shorter than t=
he
tested suffix and matches the tail of that suffix:

1. Passing a lock symbol named "lock" (such as the static mutexes named lock
   in kernel/ksysfs.c or mm/folio.c) to lock_held(lock) or
   lock_held_read(lock) matches strtailcmp("lock", "spinlock") =3D=3D 0. In=
stead
   of falling through to LOCK_PROG_ALL, prescan_one_lock_expr() only enables
   LOCK_PROG_SPIN, and resolve_lock_expr() treats it as an exclusive spinlo=
ck
   and rejects read mode with -EINVAL.

2. Any rw_semaphore symbol shorter than 12 characters whose name is a suffix
   of "percpu_rwsem" or "pcpu_rwsem" (such as "cpu_rwsem" or "u_rwsem")
   matches strtailcmp(base, "percpu_rwsem") =3D=3D 0, causing
   prescan_one_lock_expr() to only enable LOCK_PROG_PERCPU_RWSEM and
   resolve_lock_expr() to omit PBF_LOCK_DIRECT_RWSEM and reject read mode
   with -EINVAL.

3. Any mutex symbol named "_mutex" or "t_mutex" matches
   strtailcmp(base, "rt_mutex") =3D=3D 0, causing resolve_lock_expr() to set
   PBF_LOCK_DIRECT_RTMUTEX instead of PBF_LOCK_DIRECT_MUTEX.

Would it be better to use str_ends_with() from linux/string.h here so that
base is required to be at least as long as the suffix?

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261020205859.1080=
743-1-irogers@google.com?part=3D5
