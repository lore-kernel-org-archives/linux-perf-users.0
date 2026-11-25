Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795642982;
	b=ClPoWdLVOKMMpGjgqfdHT+dV65SlET4PxYXUB/cp1SPnAmAm5nsFe+Y+NrGWxQJcWEq0
	 5l65Z2k2PIV/HuQ14CJdMxgjpNXvx7KyqhI1LGmYrd1JNGM6D03pLLDe2EwuWsUymuWyH
	 GGrzKtSQAr+8CZJ40m2HEHwtFlt31v2vIoHVbw6lE4VJAviravToq4ZzabfST0For2aYZ
	 B4NATUWue2EApZqd690M0FbjrppttL1+pHcBILtxThnadNR/lb4s75UNy4a7M2o711RJN
	 G+kImit7NCkXW9cLtoHG/SxTWQaF/dO5DC8KrBruHNU/K/bXj05T/dSZ0N9YTw+pEfA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795642982;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=fext65oXtLvi/Xrp8/knkU9aCKg4unXZwYmbKEzDlQw=;
	b=BslPLvykDFxzK0iJqUqWwgiC268IEKWSt5gDuiHTXM4uBtCkrZA53DcHjFJ/DcQy6hQB
	 SV84mS637mhQdUfJrkH8QWqftxppJzTB+LQXrd9T5UkF5kiRo+8hkcqJQPxGixxUG8E44
	 rO3Hricd4b8ML9mmVxvnLMHnJ7Duvgs4FvGXFC9G0FhYPrgM6wODhnwTiOM+/hicdNJ/Y
	 HOKnyVVmAYAOEiJ9sXeMxjFNsmt0AkuFsVP7CJ3TTBaNSigMzyiRq3CqUf4OZuogSmxXs
	 srHUBLI8Ds4/GAz9P6Ibm9IjvZX+3+OcSMWHeXW+Lpbn6fFH5mBwh4nvgBfNx4f6fCw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gU6SglSY;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8D8D606A321
	for <linux-perf-users@vger.kernel.org>; Wed, 25 Nov 2026 21:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gU6SglSY
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 485A01F000D3;
	Wed, 25 Nov 2026 21:43:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795642982;
	bh=fext65oXtLvi/Xrp8/knkU9aCKg4unXZwYmbKEzDlQw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=gU6SglSYO/pwaCvvWzgdeodg9+LDzgODOmdLL49gc9vqAtPUVHAaAnp8NVgCPBazy
	 egal3rFFQBxhI0CngsfsfL8wEGYCVY0XQh4sXcUNkkR9OnbcdwIJwqeRB8HzIk3MDH
	 rFQlT+uEMsTllOM+w0anOqGDSRARIgZ686ybvf1ueLR/e6OZ2AdZbPMTx6McvQ+IAA
	 SjzCpiJBINEOxIb9VNQ4Beq+n94oEULMZtZOfHlkG00DfHvO9zRdR5I9LX+cLBdTTY
	 D/mN0dlhQM9wkCIRVHIeDIVthkLi+jurs7z4ScwaYFyVfIQe0LLceuejbElEOSM88u
	 RnD1X7ecYYRkw==
Message-ID: <sashiko-outbox-234203@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 06/11] perf tools: Verify thread status and mount
 namespace inode
Reply-To: sashiko-reviews@lists.linux.dev
To: "Namhyung Kim" <namhyung@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261125212851.1792988-7-namhyung@kernel.org>
References: <20261125212851.1792988-1-namhyung@kernel.org>
 <20261125212851.1792988-7-namhyung@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 25 Nov 2026 21:43:01 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 2 potential
issues to consider:
- [Medium] perf namespaces: strstr() in nsinfo__get_nspid() matches comm
  in status
- [Low] perf namespaces: unchecked open() in nsinfo__host_proc_get()
  unpins /proc
--

commit 6ff70afbeba62bd6dad2f202209288f4822b3205
Author: Namhyung Kim <namhyung@kernel.org>

perf tools: Verify thread status and mount namespace inode

This commit verifies that a thread's /proc/<pid>/task/<tid>/status Tgid
matches pid and its mount namespace inode matches mntns_ino before entering
its mount namespace, while pinning a reference-counted host /proc file
descriptor across setns().

> diff --git a/tools/perf/util/namespaces.c b/tools/perf/util/namespaces.c
> index 940132d3458be..704f69663129d 100644
> --- a/tools/perf/util/namespaces.c
> +++ b/tools/perf/util/namespaces.c
[ ... ]
> @@ -59,22 +60,102 @@ void namespaces__free(struct namespaces *namespaces)
>  	free(namespaces);
>  }
> =20
> -static int nsinfo__get_nspid(pid_t *tgid, pid_t *nstgid, bool *in_pidns,=
 const char *path)
> +static DEFINE_MUTEX(host_proc_lock);
> +static int host_proc_fd __guarded_by(&host_proc_lock) =3D -1;
> +static unsigned int host_proc_refcnt __guarded_by(&host_proc_lock);
> +
> +static void nsinfo__host_proc_get(void)
> +{
> +	mutex_lock(&host_proc_lock);
> +	if (host_proc_refcnt++ =3D=3D 0)
> +		host_proc_fd =3D open("/proc", O_RDONLY | O_DIRECTORY | O_CLOEXEC);
> +	mutex_unlock(&host_proc_lock);
> +}
> +
> +static void nsinfo__host_proc_put(void)
> +{
> +	mutex_lock(&host_proc_lock);
> +	if (host_proc_refcnt > 0 && --host_proc_refcnt =3D=3D 0 &&
> +	    host_proc_fd >=3D 0) {
> +		close(host_proc_fd);
> +		host_proc_fd =3D -1;
> +	}
> +	mutex_unlock(&host_proc_lock);
> +}
> +
> +static int nsinfo__proc_open(const char *rel_path, int flags)
> +{
> +	char path[64];
> +	int ret;
> +
> +	mutex_lock(&host_proc_lock);
> +	if (host_proc_fd >=3D 0) {
> +		ret =3D openat(host_proc_fd, rel_path, flags);
> +	} else {
> +		scnprintf(path, sizeof(path), "/proc/%s", rel_path);
> +		ret =3D open(path, flags);
> +	}
> +	mutex_unlock(&host_proc_lock);
> +	return ret;
> +}

[Severity: Low]
Can nsinfo__mountns_enter() enter a target mount namespace without pinning
host /proc if open("/proc", ...) in nsinfo__host_proc_get() fails?

Because host_proc_refcnt is incremented unconditionally and
nsinfo__mountns_enter() does not check whether host_proc_fd >=3D 0, a failed
open leaves host_proc_fd =3D=3D -1 while nsinfo__proc_open() falls back to
opening /proc/<rel_path> by path.  Once setns() succeeds, subsequent
nsinfo__proc_open(), nsinfo__proc_stat(), and nsinfo__proc_readlink() calls
take the fallback path and resolve /proc inside the target mount namespace
instead of the host /proc.

[ ... ]

> +static int nsinfo__get_nspid(pid_t *tgid, pid_t *nstgid, bool *in_pidns,
> +			     const char *rel_path)
>  {
>  	FILE *f =3D NULL;
>  	char *statln =3D NULL;
>  	size_t linesz =3D 0;
>  	char *nspid;
> +	int fd;
> +	bool got_tgid =3D false;
> =20
> -	f =3D fopen(path, "r");
> -	if (f =3D=3D NULL)
> +	fd =3D nsinfo__proc_open(rel_path, O_RDONLY | O_CLOEXEC);
> +	if (fd < 0)
>  		return -1;
> +	f =3D fdopen(fd, "r");
> +	if (f =3D=3D NULL) {
> +		close(fd);
> +		return -1;
> +	}
> =20
>  	while (getline(&statln, &linesz, f) !=3D -1) {
>  		/* Use tgid if CONFIG_PID_NS is not defined. */
>  		if (strstr(statln, "Tgid:") !=3D NULL) {
>  			*tgid =3D (pid_t)strtol(strrchr(statln, '\t'), NULL, 10);
>  			*nstgid =3D *tgid;
> +			got_tgid =3D true;
>  		}
> =20
>  		if (strstr(statln, "NStgid:") !=3D NULL) {
> @@ -91,7 +172,17 @@ static int nsinfo__get_nspid(pid_t *tgid, pid_t *nstg=
id, bool *in_pidns, const c
> =20
>  	fclose(f);
>  	free(statln);
> -	return 0;
> +	return got_tgid ? 0 : -1;
> +}

[Severity: Medium]
Can strstr() in nsinfo__get_nspid() match the user-controlled comm in the
"Name:\t<comm>\n" line at the top of /proc/<pid>/task/<tid>/status?

If a non-leader thread with a recycled TID (<pid>) sets its comm to
"<pid>Tgid:NStgid:", both strstr() checks match on line 1, strtol() parses
<pid> after the "Name:\t" tab into *tgid, and the NStgid branch breaks out
of the loop before reading the real Tgid line, bypassing the
tgid !=3D nsinfo__pid(nsi) recycling check in nsinfo__init_locked() and
nsinfo__check_proc().  Similarly, a live thread whose comm contains
"NStgid:" breaks out on line 1 with got_tgid =3D=3D false and is falsely ma=
rked
exited.  Using strstarts(statln, "Tgid:\t") and
strstarts(statln, "NStgid:\t") would ensure only the actual status keys are
matched.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261125212851.1792=
988-1-namhyung@kernel.org?part=3D6
