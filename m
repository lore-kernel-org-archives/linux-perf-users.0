Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792448887;
	b=XbeSONZGqgevz2ZCclX6DeqPB4xLQFlv+iFpMiuaFneNIbvQF1YQVsTcEaIX2f/vHRpJ
	 cayl2VPCgGIj3PRmdt1U6zOfkYQQlqrzEv8YuLh2sQujZAXpeULyxqvv2P0NavwuGG5q4
	 cpb7btBNbQ3o1lMP1cXv1y0oj9UhQrqWitYjjF0v8RSal4TTzxudRSIutY+MA6x1d4G2U
	 9un8cxrHvb1oIrYuZyopEKzX+VLywd5BiD8lwx4LFBevs7Okw8wmrkAj/2fwcq5+ZvrRR
	 Rf1kJgc5GcAdHReB7BScuKYSP1XInRuzMp9NDQuLZiqINh+MPNvUabvi28B9VKGDKmA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792448887;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=pJmnkWiYjFXmgLUiid0v0dD+mRnbOx5CAoFZ1InzcZ4=;
	b=xq+7IBrXAR/XNHmnyJP2FBgOMLyRQZGAMJ7zD/3fLyfljJ1e/h4ZD0+YpDw/6LEOjkrU
	 CqJrcJjmZADlf004tRcwcKhRwALTM43vuCJShs3/BjEwD6OtDqlyqoCSMPaVG4KFWBh2q
	 G3MeljV0ywv3PT+jDj/nGXfcnjwqWOjmAqjljZuvqkNpc0fknb6WMyneJmLEZ7a5F80hw
	 taVrd13O+wEpHHb3DDGcBCNWq8gYJlkPGpJWVtBOHifGBl586C5OIJCJWQYlvMc4XRv3P
	 1HMTxiVUIXFw2lkkmqvBuYm6djjqhMnszT4wnsd+8sJ2+yc4jHwfJVaRoOEimxGoBCQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PaCpPSuo;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AA4D606A31C
	for <linux-perf-users@vger.kernel.org>; Mon, 19 Oct 2026 22:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PaCpPSuo
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D81B11F000C5;
	Mon, 19 Oct 2026 22:28:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792448887;
	bh=pJmnkWiYjFXmgLUiid0v0dD+mRnbOx5CAoFZ1InzcZ4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=PaCpPSuoC732jxXJZoZldvDYUulvHmoEYbo2xLnAyJLsDf/uQALRIqA4/4ZnTkxUu
	 pLURhp7lKI9qn+dBrAFzjaG2fjAVWVpjIPT984WwzT0vqf/FoX6CoL9ek7wYtnZm20
	 oZQOw+7SfLmHCKcu7nDcZVxYPYVrFNqsQ3Qr021yvvyZpxFpdT2hy3uI1HCRtUh/1U
	 8Rbz6PHfwQhkwQf8SCXzAFwbUVIqvolnXxeffbDD2IIic25xh9ood2fEvD4hRFs5b3
	 L2ADFFhUxZPvsSE1ihab3taXvePEq6lLr4yGgv8ABYZ0/IpdqEPi2zsbtKeb6ke+yX
	 y0wBjvLuAZLYQ==
Message-ID: <sashiko-outbox-178319@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 4/7] perf bpf-filter: Add lock_held() sample filter
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261019220915.3943592-5-irogers@google.com>
References: <20261018053710.2572636-1-irogers@google.com>
 <20261019220915.3943592-1-irogers@google.com>
 <20261019220915.3943592-5-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 19 Oct 2026 22:28:06 +0000
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
- [Medium] perf bpf-filter: wrong lock suffix match via strtailcmp() on sho=
rt names
--

commit 30b0f8cede3e3d90dc8406410f23666b838bbc6b
Author: Ian Rogers <irogers@google.com>

perf bpf-filter: Add lock_held() sample filter

This commit adds BPF sample filter predicates lock_held(), lock_held_read(),
lock_held_shared(), lock_held_write(), and lock_held_exclusive() to record
perf event samples only when a specified kernel lock is held. It evaluates
lock ownership directly in kernel memory where possible and falls back to an
LRU hash map populated by fentry/fexit hooks on lock/unlock functions.

> diff --git a/tools/perf/util/bpf-filter.c b/tools/perf/util/bpf-filter.c
> index 4e99af4764f1d..ab9b58f6cb713 100644
> --- a/tools/perf/util/bpf-filter.c
> +++ b/tools/perf/util/bpf-filter.c
[ ... ]
> @@ -166,9 +182,844 @@ static int check_sample_flags(struct evsel *evsel, =
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
Can strtailcmp() in prescan_one_lock_expr() and resolve_lock_expr()
misclassify short kernel lock symbol names?

In tools/perf/util/string.c, strtailcmp() compares backward from the end of
both strings and returns 0 as soon as either string reaches the start:

tools/perf/util/string.c:strtailcmp() {
	int i1 =3D strlen(s1);
	int i2 =3D strlen(s2);
	while (--i1 >=3D 0 && --i2 >=3D 0) {
		if (s1[i1] !=3D s2[i2])
			return s1[i1] - s2[i2];
	}
	return 0;
}

Because strtailcmp(base, suffix) does not require base to be at least as lo=
ng
as suffix, a lock symbol in kallsyms that is shorter than suffix and matches
its tail will return 0:

- A lock symbol named "lock" (such as a static mutex or rwsem named lock)
  matches strtailcmp("lock", "spinlock") =3D=3D 0, causing prescan_one_lock=
_expr()
  to only enable LOCK_PROG_SPIN instead of LOCK_PROG_ALL and
  resolve_lock_expr() to reject lock_held_read(lock) with -EINVAL.
- A short rwsem symbol such as "cpu_rwsem" or "_rwsem" matches
  strtailcmp(base, "percpu_rwsem") =3D=3D 0, attaching LOCK_PROG_PERCPU_RWS=
EM
  instead of LOCK_PROG_RWSEM_READ/WRITE, omitting PBF_LOCK_DIRECT_RWSEM, and
  rejecting read-mode filtering with -EINVAL.
- A short mutex symbol such as "_mutex" matches
  strtailcmp(base, "rt_mutex") =3D=3D 0, setting PBF_LOCK_DIRECT_RTMUTEX in=
stead
  of PBF_LOCK_DIRECT_MUTEX.

Should this use a helper that checks strlen(base) >=3D strlen(suffix) before
comparing the suffix?

> +
> +		entry->part =3D PBF_LOCK_ADDR | mode | direct_flag;
> +		entry->target =3D addr;

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261019220915.3943=
592-1-irogers@google.com?part=3D4
