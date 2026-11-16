Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794809651;
	b=kN0zmTp8yZGAMgQ4QGpJWdP9Vj/gjWTJN2pV0+gJco/DPvbwJM+pJDjHlYcTrL5S2CR8
	 N9/IuStVJqdz+EhXzxVJ5p+cqMzogSMADH4YBFJgtgZRioD1KYKBeQRQkxlzniqXHzhCc
	 CRlb1LL5OMnBoBSfOjfOKSQlM+eTE0ttICkGrtc93GlUhkfMcADT0E+VotSkrgyHmcIb8
	 XclL6qaAJEMH5mg5mnGCEkjpmqjjXgkEZdeBKPEF/Pbb542fL8/6u1lOIxSsXtE58GvuF
	 sb6Sm2TgSHXqFVJBh5wB3/HXXlu2uaexr1VCXHCTUlASlCzYtklboVw6VG//7ibIxYw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794809651;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=/KwszXI6jl/gQ5LR9Pby9P+o2IEtYv4ZsLPkntkqn+k=;
	b=fUNP0Q2i+RhYisq6tcGV/o3HsyizgksH4W/pqiO5GAoOUizTLxKKhR4t1UYUIHYl4UR4
	 SVqaqw39IwD6MLkN5b7hk+SY6KxhscZ+UPsIrCaYB2PPEUqHiHTZowtrPa/pm9vf1vZpm
	 96nLu2UL6GmDXXIaV9vbu3kgIS1V8lRZzcOCLJp8Gak7URW27JLxmSzimp6siq4+nj1xD
	 I1LDdVcpi/g1JyD+Vy4wx/DqQQfF9kiuaKzRjPr1UKwQbkOEgQYvgg0Wnsp0uHJVdH+pO
	 ehy1OKz9ayKEKpq6mK0vcWmGOy5AEUuGetNF0EJzIY7sHcCh94A2adwjz3Kl4HyYAew==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TA2Uqt1l;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BEB8606A323
	for <linux-perf-users@vger.kernel.org>; Mon, 16 Nov 2026 06:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TA2Uqt1l
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 955AB1F000C4;
	Mon, 16 Nov 2026 06:14:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794809650;
	bh=/KwszXI6jl/gQ5LR9Pby9P+o2IEtYv4ZsLPkntkqn+k=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=TA2Uqt1lMud3xiXcUnbkcSiJWFH/2jzx9WfJEWm3AksgOSLgeoOSvl7i3F8TwJSzz
	 PHEjO3p7DPvJTixl/hJUUwsDnLmn51xReYS4Yl/bd7pd1a7Dp39eoc4iDs0qP0nikW
	 sm+rWb5eilE49wvrj0g8h70cLplsb2svnLT5aByYn0KABztPLzGEn3MIflDdr5TjM5
	 ROlV8nf+M5eMygdeDGZ0Fpav63fy+tGWqavklq2RG3JTli+Foi17QbtK4oTI+g8kOk
	 MeoU33hKT5cQm6h1IXNnvi6lZ1hnv/NSrfgDg0EVsR22fadlS/4I/GJsEP5SfPx9ea
	 KWT9VLXxOqWPg==
Message-ID: <sashiko-outbox-216248@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 06/11] perf tools: Verify thread status and mount
 namespace inode
Reply-To: sashiko-reviews@lists.linux.dev
To: "Namhyung Kim" <namhyung@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261116055731.707164-7-namhyung@kernel.org>
References: <20261116055731.707164-1-namhyung@kernel.org>
 <20261116055731.707164-7-namhyung@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 16 Nov 2026 06:14:10 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Low] perf namespaces: nsinfo__init_locked() returns 0 when stat()
  fails
--

commit e6cbb7bd6fc00579ed776b5b31e5e5cfe0cc41a2
Author: Namhyung Kim <namhyung@kernel.org>

perf tools: Verify thread status and mount namespace inode

This commit verifies that /proc/<pid>/task/<tid>/status exists with a
matching Tgid and checks the mount namespace inode via fstat() before
entering a thread's mount namespace.

> diff --git a/tools/perf/util/namespaces.c b/tools/perf/util/namespaces.c
> index afd8ad7f843ec..860b90e8384ed 100644
> --- a/tools/perf/util/namespaces.c
> +++ b/tools/perf/util/namespaces.c

[ ... ]

> @@ -101,16 +116,41 @@ static int nsinfo__init_locked(struct nsinfo *nsi)
>  	char *newns =3D NULL;
>  	struct stat old_stat;
>  	struct stat new_stat;
> +	pid_t tgid =3D 0, nstgid =3D 0;
> +	bool in_pidns =3D false;
>  	int rv =3D -1;
> =20
> +	if (RC_CHK_ACCESS(nsi)->exited)
> +		return -1;
> +
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
> +	rv =3D nsinfo__get_nspid(&tgid, &nstgid, &in_pidns, spath);
> +	if (rv < 0 || tgid !=3D nsinfo__pid(nsi)) {
> +		nsinfo__set_exited_locked(nsi);
> +		rv =3D -1;
> +		goto out;
> +	}
> +
> +	RC_CHK_ACCESS(nsi)->tgid =3D tgid;
> +	RC_CHK_ACCESS(nsi)->nstgid =3D nstgid;
> +	RC_CHK_ACCESS(nsi)->in_pidns =3D in_pidns;
> +
>  	if (snprintf(oldns, PATH_MAX, "/proc/self/ns/mnt") >=3D PATH_MAX)
> -		return rv;
> +		return -1;
> =20
>  	if (asprintf(&newns, "/proc/%d/task/%d/ns/mnt",
>  		     nsinfo__pid(nsi), nsinfo__tid(nsi)) =3D=3D -1)
> -		return rv;
> +		return -1;
> =20
>  	if (stat(oldns, &old_stat) < 0)
>  		goto out;
> @@ -124,19 +164,10 @@ static int nsinfo__init_locked(struct nsinfo *nsi)
>  	if (old_stat.st_ino !=3D new_stat.st_ino) {
>  		RC_CHK_ACCESS(nsi)->need_setns =3D true;
>  		RC_CHK_ACCESS(nsi)->mntns_path =3D newns;
> +		RC_CHK_ACCESS(nsi)->mntns_ino =3D new_stat.st_ino;
>  		newns =3D NULL;
>  	}
> =20
> -	/* If we're dealing with a process that is in a different PID namespace,
> -	 * attempt to work out the innermost tgid for the process.
> -	 */
> -	if (snprintf(spath, PATH_MAX, "/proc/%d/task/%d/status",
> -		     nsinfo__pid(nsi), nsinfo__tid(nsi)) >=3D PATH_MAX)
> -		goto out;
> -
> -	rv =3D nsinfo__get_nspid(&RC_CHK_ACCESS(nsi)->tgid, &RC_CHK_ACCESS(nsi)=
->nstgid,
> -			       &RC_CHK_ACCESS(nsi)->in_pidns, spath);
> -
>  out:
>  	free(newns);
>  	return rv;

[Severity: Low]
Does nsinfo__init_locked() return 0 instead of -1 when stat() fails?

Moving nsinfo__get_nspid() ahead of the stat() checks sets rv to 0 on
success.  If stat(newns, &new_stat) then fails (for example with EACCES
because /proc/<pid>/task/<tid>/ns/mnt requires PTRACE_MODE_READ_FSCREDS
while status is world-readable), jumping to out returns 0 to callers of
nsinfo__init().

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261116055731.7071=
64-1-namhyung@kernel.org?part=3D6
