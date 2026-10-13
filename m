Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF2B0528453
	for <linux-perf-users@vger.kernel.org>; Tue, 13 Oct 2026 20:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791923241; cv=none; b=Oqv73b1mKllczAxrjopkKWkxbYEpLz9ZYglSYkJqUOWXGp8SlYq3uErlAClfLYIz3aRFyYOum5FUUEkxPbU4t98CmiiEklH8Bq91AQ3ErWCEL7VdIhGXQ/VWrAH+/AnZaQYjkR09nyTko5MqhL6L3dg+pf9PWr1z8d4k6WKhrxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791923241; c=relaxed/simple;
	bh=zbgZ4Mpf9RCuxFv5dzh8RN931aD6Aes44+ZeeMiDOig=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=peGTTyfCOvp3GdlQzG21EXd8ydb/QcWJHxd/C6w+XP1x54YVNAS0emEvCIwlLMDScdleIaT+KD6At4LBz8cTUJLZgWaFPF/hLRUGeBhLXn5dSLiq+0YZz4oM05hM/GOBTr+WRgWS5tl3e0Tub2WTAPmIRYZbzaKyP2HdgHMZ0m8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xx1qTdfH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xx1qTdfH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1E661F000FF;
	Tue, 13 Oct 2026 20:27:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791923239;
	bh=237AGHCtyiJDrVylcpJN9XIzN7+wq4+BaU7wJtLjM6Q=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Xx1qTdfHtJwB9FS0gC41HROeLT+doD7Mn/igidqSDgUo5tDnRnSXiBxirewHQNVgz
	 OZY88Tw6hq2wkcyssB+tHAl9g+E/2kYimkrXNprZEu7N+IKTC3qGIHRkrIhMpZmGG2
	 0zcDqf7G8BovpooAe+RXOApyHE4pgq4WRUFsylwimt2PTpg1VGUWN+YS5Z9OP2JAZT
	 GCKANlDd5LyQ0Ve9G13tr8zyfOeMiP/qz0V6q8dlTHkAxzQqW7SX2eD1iroRsQvTsd
	 7SxBnK+SBDmVTi8VEDFJHu+9qzcc4uMmWGgDPUCGBKgehwNCMAb/9AS7XBFYUpOF9H
	 YRV/Yfef33aiA==
Message-ID: <sashiko-outbox-170462@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 16/19] perf mutex: Add a robust, process-shared mutex
 initializer
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261013201415.36428-17-acme@kernel.org>
References: <20261013201415.36428-1-acme@kernel.org>
 <20261013201415.36428-17-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 13 Oct 2026 20:27:18 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] perf/mutex: mutex_trylock and cond_wait break robust mutexes
--

commit be4b6030ad2e50ab9f547f2302595658b05224cb
Author: Arnaldo Carvalho de Melo <acme@redhat.com>

perf mutex: Add a robust, process-shared mutex initializer

A mutex held by a process that can die before unlocking it, like the
tests forked by 'perf test' that will take turns using the per user
budget set in kernel.perf_event_mlock_kb, has to be taken over by the
next locker instead of staying locked forever.

Robust mutexes, on top of the kernel's robust futexes, do that: when an
owner dies while holding it the kernel marks the futex word owner-died
and the next pthread_mutex_lock() returns EOWNERDEAD, then mutex_lock()
makes it consistent and takes it over.

> diff --git a/tools/perf/util/mutex.c b/tools/perf/util/mutex.c
> index 7aa1f3f55a7d4..712fbf839d590 100644
> --- a/tools/perf/util/mutex.c
> +++ b/tools/perf/util/mutex.c

[ ... ]

> @@ -58,7 +105,22 @@ void mutex_destroy(struct mutex *mtx)
>  void mutex_lock(struct mutex *mtx)
>  	NO_THREAD_SAFETY_ANALYSIS
>  {
> +#ifdef HAVE_PTHREAD_MUTEX_ROBUST
> +	int err =3D pthread_mutex_lock(&mtx->lock);
> +
> +	/*
> +	 * A robust mutex whose owner died while holding it comes back as
> +	 * EOWNERDEAD, marked by the kernel: take it over.
> +	 */
> +	if (err =3D=3D EOWNERDEAD) {
> +		pr_debug("mutex: taking over one left by a dead owner\n");
> +		CHECK_ERR(pthread_mutex_consistent(&mtx->lock));
> +	} else {
> +		CHECK_ERR(err);
> +	}
> +#else
>  	CHECK_ERR(pthread_mutex_lock(&mtx->lock));
> +#endif
>  }

[Severity: Medium]
Since this patch introduces robust mutexes and adds EOWNERDEAD handling to
mutex_lock(), does it leave mutex_trylock() and cond_wait() broken when used
with them?

If pthread_mutex_trylock() returns EOWNERDEAD, the lock is acquired by the
caller, but mutex_trylock() currently treats it as an error:

tools/perf/util/mutex.c:mutex_trylock() {
        ...
        if (ret =3D=3D 0)
                return true; /* Lock acquired. */

        if (ret =3D=3D EBUSY)
                return false; /* Lock busy. */

        /* Print error. */
        CHECK_ERR(ret);
        return false;
}

This will silently leak the lock and cause the caller to incorrectly assume
the lock is not held.

Similarly, if pthread_cond_wait() returns EOWNERDEAD:

tools/perf/util/mutex.c:cond_wait() {
        CHECK_ERR(pthread_cond_wait(&cnd->cond, &mtx->lock));
}

The mutex is re-acquired but inconsistent. Failing to call
pthread_mutex_consistent() before the caller unlocks it will permanently
break the mutex.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261013201415.3642=
8-1-acme@kernel.org?part=3D16
