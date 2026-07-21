Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54C0335C69E
	for <linux-perf-users@vger.kernel.org>; Tue, 21 Jul 2026 21:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784668538; cv=none; b=Jt6grFdObFZtgFcLYQ+vtkQPWPiQHGSbSx8c1nHf7XrLkmmRriSGZ6NT2HICtV4yz5BqkfT7g/BWHwu0rdeWoLJq+978pBvUo3h9FP1beCGdvTIG5JppRFJwkyZkXl+udD1bDnrog8yR0H1W/8+ptiicXZG3X+7mS7T+eCrtyOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784668538; c=relaxed/simple;
	bh=ruBMjmyh5O3RJVoLFvBEo+izTIziq8f67hPnXXRbQCo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=p5MKdusy7G8QMh7Q9Ko3DsRNO7cRhBklH+lObo0I2zJD5UXSCwabSUEPjFZSZLd8ChmP5+GI98wYlHam25i7J/qTPpEP8CqF9ctKPy0aKkei3fOBbE7ZRiZexlVGJKTSWOeFoxmLYMJQ6jqZIlZi+cewGUpCAd4sQdqUlI0qb7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BN1KD8Jk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BN1KD8Jk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEFC11F00A3A;
	Tue, 21 Jul 2026 21:15:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784668537;
	bh=RBM3Sop/8EtKmETtH6NGePN/Okc56f5+MX6/r+gV/4g=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=BN1KD8JkkMtn8nKXSTvYixtfu4h68FzWrfohmoi3EO5d5HB5lgRsitoJ1qEnAKVmv
	 PV0FoDUbvxALZaX2fv0+lyE0zdy9sf3f/DCz4DgVI6+bVLwYRHGcfKrPC39mxPLHuP
	 LF//7wzgCEqy9RLddW1riXzkP0ZEi60kiFYpiX+tm+xwwb6R0r2uChC+Y+cHjkVqbP
	 1j7x2nzupGoF2RVj6bUXxWlJ2rNPaOk8Ad+U0dmOl/nsEE4lTHZ4pnrf4r6I40AwaE
	 r0o6bfqJjBVDQP7eljuuWCaq8n8GQ4PLvvexnSd+JBnxDLf+xDFbOWRue06ygFsAAi
	 ksHTDoWip8adQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 2/4] perf synthetic-events: Fix line synchronization,
 bounds, and truncation bugs in proc maps reader
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260721205746.183206-3-irogers@google.com>
References: <20260721182150.94016-1-irogers@google.com>
 <20260721205746.183206-1-irogers@google.com>
 <20260721205746.183206-3-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 21 Jul 2026 21:15:36 +0000
Message-Id: <20260721211536.EEFC11F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Stale build ID leakage across kernel module synthesis due to rem=
oved loop cleanup.
--

--- Patch [2]: [PATCH v5 2/4] perf synthetic-events: Fix line synchronizati=
on, bounds, and truncation bugs in proc maps reader ---
commit 7ed1842aa319aa810201b4aedeba9993fa02dfd6
Author: Ian Rogers <irogers@google.com>

perf synthetic-events: Fix line synchronization, bounds, and truncation bug=
s in proc maps reader

This commit addresses logic and boundary bugs in read_proc_maps_line() and =
its
caller. It ensures parsing failures invoke safe drain paths, clamps pathname
extraction sizes, and correctly handles timeout flags.

> diff --git a/tools/perf/util/synthetic-events.c b/tools/perf/util/synthet=
ic-events.c
> index 5307d707711d8..e379174ae002d 100644
> --- a/tools/perf/util/synthetic-events.c
> +++ b/tools/perf/util/synthetic-events.c
[ ... ]
> @@ -703,11 +783,6 @@ static int perf_event__synthesize_modules_maps_cb(st=
ruct map *map, void *data)
> =20
>  		memcpy(event->mmap2.filename, dso__long_name(dso), dso__long_name_len(=
dso) + 1);
> =20
> -		/* Clear stale build ID from previous module iteration */
> -		event->mmap2.header.misc &=3D ~PERF_RECORD_MISC_MMAP_BUILD_ID;
> -		memset(event->mmap2.build_id, 0, sizeof(event->mmap2.build_id));
> -		event->mmap2.build_id_size =3D 0;
> -

[Severity: Medium]
Does this removal cause stale build IDs to leak across module syntheses?

Since the event structure is allocated once and reused across all kernel mo=
dules
in the loop, if perf_record_mmap2__read_build_id() fails to read a build ID=
 for
a subsequent module, it seems the event will retain the
PERF_RECORD_MISC_MMAP_BUILD_ID flag and the build ID from the last successf=
ully
processed module.

Will this cause perf to misattribute samples from the failing module to the
debug symbols of a completely different module?

>  		perf_record_mmap2__read_build_id(&event->mmap2, args->machine, false);
>  	} else {
>  		size =3D PERF_ALIGN(dso__long_name_len(dso) + 1, sizeof(u64));

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260721205746.1832=
06-1-irogers@google.com?part=3D2
