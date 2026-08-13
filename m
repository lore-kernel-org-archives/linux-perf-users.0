Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B02CA320A37
	for <linux-perf-users@vger.kernel.org>; Thu, 13 Aug 2026 01:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786583083; cv=none; b=OQGBjy27Kt0OXCUjl05oWqkpu5yjpYjyc+/S9zZ+GeaQJ67lL4NUCJRtVtXKIkU1OVVXcIX7rIplW8LV68STV3HRJUabUXqoPs7CdVudH9MdJ0sqvIIQHtEBSl1vL4dfU8YfDRfyxPXii1p1Udp30NLYPIjM7SlvCmhTtwNDdMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786583083; c=relaxed/simple;
	bh=ZsW9Q/Bpf3mPnRgtwDpfhjTwChDZkJU4DjN/4du6tEs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=b9u16a7ZXVaPWm1tFRiXyp1KCB2RPAAEwDQi4DgSDUFaDO9CH4objsUMRk+dnqGLBKyeScxv/RdnHtD59uSIcmqrGb9Q9Qk8p4ctaYiwrtD/MOEJGlpZoHsnN3lrCqCD33FjbC4VM9mSGfY0Yn+Ie1wzMzarTqfLLZQkUbw/lqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MnpwVcJT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MnpwVcJT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52CD31F000E9;
	Thu, 13 Aug 2026 01:04:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786583081;
	bh=pAqaVtCcR76FLcZjdSomgcuGTB0SwR1bCjHnJtd+4RE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=MnpwVcJTz1/yZgBPfT8ByncWAgRm7B9GsJz0/LygtDkXsL0haER1Pc1Xc2ASYIMGS
	 +DNxB4G5rMwsX04XnaQv8Hk7bvhYMTNWCEVM+pbTIi6rCSUO9rmy2Qeby4w8vBSZgL
	 TRWJNLaUdJjCs4njwHmRwJwjf/qnOEZ4BxeqNBCiZarLVmLKSASaCqHY6SIWEW1Eql
	 K1inlOCt1Q+3QL12xa/8gWNJwxwo5c4QViGm3Cr6BLY3wi2EiJYa4JwgLTuAUjPRr4
	 QqAKb/MCcBbe0+TbawkFtmkAw8XODW+TuV64H8oUWcGLSzQR7GOgyLhhIPRe4Wp1Bn
	 +DIARWw1wGV+Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/5] perf dso: Guard against errno==0 when
 dso__get_filename() returns NULL
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260813004927.16738-2-acme@kernel.org>
References: <20260813004927.16738-1-acme@kernel.org>
 <20260813004927.16738-2-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 13 Aug 2026 01:04:40 +0000
Message-Id: <20260813010441.52CD31F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [High] Stale `errno` usage in `dso__get_filename()` and `__open_dso()` cr=
eates brittle logic, incorrect error propagation, and loop pollution.

Pre-existing issues:
- [High] `file_read()` attempts to extract the failure reason using `-errno=
` after several cleanup and namespace functions have clobbered the `errno` =
value.
- [High] Strict AB-BA deadlock between `_dso__data_open_lock` and `dso__loc=
k` when `REFCNT_CHECKING` is enabled and the `EMFILE` limit is hit.
--

--- Patch [1]: [PATCH 1/5] perf dso: Guard against errno=3D=3D0 when dso__g=
et_filename() returns NULL ---
commit b3606e9e10d4ce3d99991eea12437267b852da75
Author: Arnaldo Carvalho de Melo <acme@redhat.com>

perf dso: Guard against errno=3D=3D0 when dso__get_filename() returns NULL

This commit fixes an issue where __open_dso() could incorrectly return 0
(stdin) when dso__get_filename() returns NULL without setting errno.
It forces errno to ENOENT if it is 0 upon failure, ensuring a negative
file descriptor is returned.

> --- tools/perf/util/dso.c
> +++ tools/perf/util/dso.c
> @@ -640,10 +640,13 @@ static int __open_dso(struct dso *dso, struct machi=
ne *machine)
>  	mutex_lock(dso__lock(dso));

[Severity: High]
This is a pre-existing issue, but can this lock ordering cause an AB-BA
deadlock when REFCNT_CHECKING is enabled?

If do_open() hits the EMFILE limit, close_first_dso() calls
dso__list_del(). Under REFCNT_CHECKING, dso__list_del() drops and
reacquires dso__data_open_lock() to satisfy constraints:

tools/perf/util/dso.c:dso__list_del() {
#ifdef REFCNT_CHECKING
    mutex_unlock(dso__data_open_lock());
    dso__put(dso__data(dso)->dso);
    mutex_lock(dso__data_open_lock());
#endif
}

Since dso__lock(dso) is held here in __open_dso(), if another thread
acquires dso__data_open_lock() and then attempts __open_dso() on the
same dso, will they deadlock waiting on each other?

> =20
>  	name =3D dso__get_filename(dso, machine ? machine->root_dir : "", &deco=
mp);
> -	if (name)
> +	if (name) {
>  		fd =3D do_open(name);
> -	else
> +	} else {
> +		if (errno =3D=3D 0)
> +			errno =3D ENOENT;

[Severity: High]
Does setting errno to ENOENT here pollute the thread-local state for
subsequent loop iterations?

If a missing DSO file triggers a fallback loop like try_to_open_dso(),
and the next iteration evaluates a directory instead of an ELF file,
is_regular_file() will return false.

Since stat() succeeds on a directory, it won't change errno. The
stale ENOENT from here means dso__get_filename() evaluates
if (errno !=3D ENOENT || ...) as false.

Will this cause the code to incorrectly bypass the error path,
proceed to dso__filename_with_chroot(), and successfully open a
directory instead of an ELF file?

> +		fd =3D -errno;
> +	}

[Severity: High]
This is a pre-existing issue, but does relying on -errno here and in
file_read() lead to incorrect error propagation?

When try_to_open_dso() fails, file_read() attempts to extract the failure
reason:

tools/perf/util/dso.c:file_read() {
    ...
    if (dso__data(dso)->fd < 0) {
        dso__data(dso)->status =3D DSO_DATA_STATUS_ERROR;
        ret =3D -errno;
        goto out;
    }
}

However, between the actual failure and this check, cleanup functions like
unlink(), mutex_unlock(), and nsinfo__mountns_exit() execute.

Will these calls clobber errno, causing file_read() to return an arbitrary
error code or 0, silently failing to report the true failure reason?

> =20
>  	if (decomp)
>  		unlink(name);
>  	mutex_unlock(dso__lock(dso));
>  	free(name);
>  	return fd;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260813004927.1673=
8-1-acme@kernel.org?part=3D1
