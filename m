Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792740517;
	b=cvQOPOf8s0nv3fqozsbmWLdNTBjIXP+OrLreSHDebdvjVYboas9SYWztzYU5MYnKvDjp
	 gctZXnmCnpgpW8mK+D7DlRq6NG8MKViWxi9L8f+2/Bv83O0znW251svOQP44QIR7kcWkv
	 gmMgEYlg/Xt5xSsyPmtSOES423/HJZesdruW4Zljn/96DXf/YM8RetCtBdH8Nw2xfrH/p
	 mxx5TUxpzuRv0FfgphMPYLYS2zevJyVB9H27fuWf9HxLhR6CjmOW4RYw5xWbbkss+M+/F
	 56WqGphKyyGnYGt0LK6WBbl3dmNAm+G8JlKdXvVre+FX3OjkztIkQZXJSB0/NjnEd/w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792740517;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=xixe4XdUuL7WZTyf8jgLSPiYOwBgMowaXqsd+tNWMo0=;
	b=uwTvTWwt9eHxlFlAexydCkP9auyFn2vT0pssyBl362JzGN++PV1qHeX9FrmlrDP47oiC
	 CNrHaKOSRJIsVerJR6Cb9L59Sn9bxlAze4Bt/HXbT9eNV0WZS0XF5qvD8mA2ysK+veZeE
	 mKFM4IGBj6OxnwGVdtUvxdQ5X3xsv4mQo4RPoEjgLSkN9Db6zWcI7xuLDPidBhzgCEtGm
	 YvO8BLC2g8kPvwRLOCduaQSgLEfCIUkvAePRn7saSQiG20YXSkajGAWhmGMNbbtMee1lx
	 r8AG2QHDNUGNXHlCinZmxbLNKDlEPRqTdC+nu69NvBIaAuZGLpzX1Qe3SO81OVsGkng==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dNWFi7lq;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9544606A31A
	for <linux-perf-users@vger.kernel.org>; Fri, 23 Oct 2026 07:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dNWFi7lq
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 875921F01825;
	Fri, 23 Oct 2026 07:28:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792740516;
	bh=xixe4XdUuL7WZTyf8jgLSPiYOwBgMowaXqsd+tNWMo0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=dNWFi7lqShGbxXSe3VB5kmCxrYGai/pJscneMQBiQaplmzBoDGZUwt6GZcfJk0qj0
	 umN42Z+yEn5RDlgi8QBnD9qszB7Lz4YhKquIOXVNO06jDYwZp97eIX4B/EpCI6seBr
	 D1s6UHupIOnrm2AGs32jRJTjbMxM2/zGwE5ud8SlswSmsLPh+JzgkpBkH7D6h6Uias
	 5LljcoexjGyDGA8Jwh8E8sBD8B1qWYZHCi2YEux4il99Yznkk28+tx2qu9f1L700EW
	 dsZAHPRsb7TvKZlooLl/DFpaHF8Zg/096zIAztlYhfMWQ7gpKCx6I6WLh5Qn0+I39f
	 tqQXumrPsBdWA==
Message-ID: <sashiko-outbox-182413@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 05/11] perf tools: Verify thread status and mount
 namespace inode
Reply-To: sashiko-reviews@lists.linux.dev
To: "Namhyung Kim" <namhyung@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261023071141.134149-6-namhyung@kernel.org>
References: <20261023071141.134149-1-namhyung@kernel.org>
 <20261023071141.134149-6-namhyung@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 23 Oct 2026 07:28:36 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] perf namespaces: nsinfo__init() clobbers tgid and pidns on TID r=
ecycling
- [Medium] perf namespaces: nsinfo__mountns_enter() sets exited on mntns in=
ode change
--

commit da6e91e676149798d39ba6f5e75c0b31c436121c
Author: Namhyung Kim <namhyung@kernel.org>

perf tools: Verify thread status and mount namespace inode

This commit verifies that /proc/<pid>/task/<tid>/status exists and has a
matching Tgid before accessing a thread's namespaces to guard against PID/T=
ID
recycling, and records the mount namespace inode to verify it via fstat() w=
hen
entering the namespace.

> diff --git a/tools/perf/util/namespaces.c b/tools/perf/util/namespaces.c
> index 843d075d30409..bb119a6cc6064 100644
> --- a/tools/perf/util/namespaces.c
> +++ b/tools/perf/util/namespaces.c

[ ... ]

> @@ -103,17 +105,34 @@ int nsinfo__init(struct nsinfo *nsi)
>  	struct stat new_stat;
>  	int rv =3D -1;
> =20
> -	if (!nsi)
> +	if (!nsi || RC_CHK_ACCESS(nsi)->exited)
>  		return -1;
> =20
>  	RC_CHK_ACCESS(nsi)->inited =3D true;
> =20
> +	/*
> +	 * Verify that the thread (pid, tid) still exists in /proc and its Tgid
> +	 * matches pid (guarding against PID/TID recycling), while resolving the
> +	 * innermost tgid if the process is in a different PID namespace.
> +	 */
> +	if (snprintf(spath, PATH_MAX, "/proc/%d/task/%d/status",
> +		     nsinfo__pid(nsi), nsinfo__tid(nsi)) >=3D PATH_MAX)
> +		goto out;
> +
> +	rv =3D nsinfo__get_nspid(&RC_CHK_ACCESS(nsi)->tgid, &RC_CHK_ACCESS(nsi)=
->nstgid,
> +			       &RC_CHK_ACCESS(nsi)->in_pidns, spath);
> +	if (rv < 0 || RC_CHK_ACCESS(nsi)->tgid !=3D nsinfo__pid(nsi)) {
> +		nsinfo__set_exited(nsi);
> +		rv =3D -1;
> +		goto out;
> +	}

[Severity: Medium]
Can this overwrite tgid, nstgid, and in_pidns with an unrelated process's
values when PID/TID recycling is detected?

In nsinfo__new_thread(pid, tid), tgid and nstgid are initialized to pid and
in_pidns to false as fallback values in case the thread exits before /proc =
is
queried.

If a process with pid =3D=3D tid exits before lazy initialization in
nsinfo__init(), and its ID is recycled as a non-leader thread of an unrelat=
ed
process P2, /proc/<pid>/task/<tid>/status still resolves in procfs because
both refer to the same thread group.

In that case, nsinfo__get_nspid() succeeds and writes P2's Tgid, NStgid, and
in_pidns directly into nsi before the tgid !=3D nsinfo__pid(nsi) check dete=
cts
the mismatch. Calling nsinfo__set_exited(nsi) marks exited =3D true and cle=
ars
need_setns, but leaves the overwritten tgid, nstgid, and in_pidns in place.

Downstream callers that query an exited nsinfo via nsinfo__tgid(),
nsinfo__nstgid(), nsinfo__in_pidns(), or nsinfo__copy(), such as
dso__find_perf_map() in tools/perf/util/symbol.c:

	if (!nsinfo__need_setns(nsi)) {
		...
		nsinfo__clear_need_setns(nnsi);
		snprintf(filebuf, bufsz, "/tmp/perf-%d.map", nsinfo__tgid(nnsi));

as well as jr_entry_pid() and jit_detect() in tools/perf/util/jitdump.c, wi=
ll
then use P2's identifiers instead of the original process's pid.

Should nsinfo__init() read into local variables first, similar to
nsinfo__check_proc(), and only update nsi after verifying that tgid matches
nsinfo__pid(nsi)?

[ ... ]

> @@ -273,15 +285,44 @@ void nsinfo__clear_need_setns(struct nsinfo *nsi)
>  	zfree(&RC_CHK_ACCESS(nsi)->mntns_path);
>  }
> =20
> -void nsinfo__reset_init(struct nsinfo *nsi)
> +void nsinfo__set_exited(struct nsinfo *nsi)
>  {
>  	if (!nsi)
>  		return;
> =20
> +	RC_CHK_ACCESS(nsi)->exited =3D true;
> +	nsinfo__clear_need_setns(nsi);
> +}
> +
> +void nsinfo__reset_init(struct nsinfo *nsi)
> +{
> +	if (!nsi || RC_CHK_ACCESS(nsi)->exited)
> +		return;
> +
>  	nsinfo__clear_need_setns(nsi);
>  	RC_CHK_ACCESS(nsi)->inited =3D false;
>  }

[ ... ]

> @@ -339,16 +384,26 @@ void nsinfo__mountns_enter(struct nsinfo *nsi,
>  	if (!oldcwd)
>  		return;
> =20
> -	oldns =3D open("/proc/self/ns/mnt", O_RDONLY);
> -	if (oldns < 0)
> -		goto errout;
> +	if (RC_CHK_ACCESS(nsi)->need_setns) {
> +		struct stat st;
> +
> +		oldns =3D open("/proc/self/ns/mnt", O_RDONLY | O_CLOEXEC);
> +		if (oldns < 0)
> +			goto errout;
> =20
> -	newns =3D open(nsinfo__mntns_path(nsi), O_RDONLY);
> -	if (newns < 0)
> -		goto errout;
> +		newns =3D open(nsinfo__mntns_path(nsi), O_RDONLY | O_CLOEXEC);
> +		if (newns < 0)
> +			goto errout;
> =20
> -	if (setns(newns, CLONE_NEWNS) < 0)
> -		goto errout;
> +		if (fstat(newns, &st) < 0 ||
> +		    st.st_ino !=3D RC_CHK_ACCESS(nsi)->mntns_ino) {
> +			nsinfo__set_exited(nsi);
> +			goto errout;
> +		}

[Severity: Medium]
What happens if a live thread changes its mount namespace via
unshare(CLONE_NEWNS) or setns(..., CLONE_NEWNS)?

If a thread in a non-root mount namespace is initialized via nsinfo__init()
and later changes its mount namespace while still alive, procfs immediately
updates the inode of /proc/<pid>/task/<tid>/ns/mnt.

If perf symbolizes an earlier sample or loads a DSO via
dso__load() -> nsinfo__mountns_enter() before the corresponding
PERF_RECORD_NAMESPACES or exec PERF_RECORD_COMM event is processed,
nsinfo__check_proc(nsi) succeeds because the thread is still alive with
Tgid =3D=3D pid, but fstat(newns, &st) sees st.st_ino !=3D nsi->mntns_ino a=
nd calls
nsinfo__set_exited(nsi).

Because dso->nsinfo shares the thread's struct nsinfo via
nsinfo__get(thread__nsinfo(thread)) in map__new(), setting exited =3D true
causes subsequent calls to nsinfo__reset_init() in thread__set_namespaces()
and __thread__set_comm() to return early without resetting inited, permanen=
tly
disabling mount namespace entry and nsinfo__check_proc() checks for the rest
of the thread's lifetime.

Should a mount namespace inode mismatch here call nsinfo__clear_need_setns(=
nsi)
instead of nsinfo__set_exited(nsi) so that a subsequent namespace or exec
event can still re-initialize the thread's nsinfo?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261023071141.1341=
49-1-namhyung@kernel.org?part=3D5
