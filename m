Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FA65D531
	for <linux-perf-users@vger.kernel.org>; Mon, 13 Apr 2026 05:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776056461; cv=none; b=JdvC7azf7mQvZsUPKUWK5FhchoT8LQFRNyMfLQf7qqsc2tQRJ9/NZvEcoG5qsJfx0kVfkobDqL5XQJugUCtDAOE9rFCY2026EPcd5BXkHQQQ4NHs/BPyePTbeOrbC+qNsd3zjgiUCLBEZ7Jqh/PN+ClPnvnKkBRjByk5k4Ga6yo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776056461; c=relaxed/simple;
	bh=qf5UJrNIwvhFXO6TSAJSNx21mDzibKwzv9aRLn1gGHI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=g7Mv1NBMdGP1SztlUtY7UlaYskYXYjDQldzoyDv4ra/FqhozaXXNSAhTrIDNvMoFaBlKxGrCrIEk2MiTvfDDIAeUz2qk7I72rx0qNMMQTrjertFIOrONpD/aG2z7PeoRmuakKLqdpYuNnDPVFHLOFMUtclnA/4XRZZTcGOIYMEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tCrg+iYh; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tCrg+iYh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 237E7C116C6;
	Mon, 13 Apr 2026 05:01:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776056461;
	bh=qf5UJrNIwvhFXO6TSAJSNx21mDzibKwzv9aRLn1gGHI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=tCrg+iYhSSBaNJCn/7cWA0ZeBY6RQqHg42HMvAr2n7SciEXVkD8eGJIZUGr2Gf1Dp
	 yMVRRcoJIKfFPs6gv/PODtAE1YBBIYk4kZanmeut+57KkNXPy4INTjH/HApUL/JnxM
	 B8qboCSZNDcG/yXJob/O2z6TjQ4ZY3sUhe7/SgTGrAPdvZcvyVpbtWIMmRqUVfBb5q
	 uL3WnqfjupwMUqmqgFxbbgg8kk1jTYPpOqABCBD+R/f7boxPx5WO3q1rmMrY0qaLZL
	 y+IHkJG0SA9PpL6nuFzuWXRwvOGDcFqC0lRxe0lELcM54WM4vcH4bU/UKAc/Y5yBoL
	 ZiCwQzB6y3irg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v12 27/33] perf synthetic-events: Bound check when
 synthesizing mmap2 and build_id events
Reply-To: sashiko@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260413041143.1736055-28-irogers@google.com>
References: <20260413041143.1736055-28-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 13 Apr 2026 05:01:00 +0000
Message-Id: <20260413050101.237E7C116C6@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Sashiko AI review found 1 potential issue(s):
- [Low] Validation of `filename_len` in `perf_event__synthesize_build_id` u=
ses the size of an unrelated union member's array.
--

commit ff006c7c376557f4e6b32e50c6f06e3663828f94
Author: Ian Rogers <irogers@google.com>

perf synthetic-events: Bound check when synthesize mmap2 and build_id events

This commit adds bounds checks when synthesizing mmap2 and build_id events
to prevent filename overflows from causing stack corruption.

> diff --git a/tools/perf/util/synthetic-events.c b/tools/perf/util/synthet=
ic-events.c
> --- a/tools/perf/util/synthetic-events.c
> +++ b/tools/perf/util/synthetic-events.c
> @@ -2257,14 +2257,20 @@ int perf_event__synthesize_build_id(const struct =
perf_tool *tool,
>  				    const char *filename)
>  {
>  	union perf_event ev;
> -	size_t len;
> +	size_t len, filename_len =3D strlen(filename);
>  	u64 sample_type =3D sample->evsel ? sample->evsel->core.attr.sample_typ=
e : 0;
>  	void *array =3D &ev;
>  	int ret;
> =20
> -	len =3D sizeof(ev.build_id) + strlen(filename) + 1;
> +	if (filename_len >=3D sizeof(ev.mmap2.filename))

This isn't a bug, but is it intentional to use the mmap2 member's filename =
size
to validate the build_id event's filename?

While this effectively acts as a limit and prevents integer overflow, it
seems a bit unusual to reference an unrelated union member for the size che=
ck.
Would it be more clear to use PATH_MAX directly, or check the available spa=
ce
in the union instead?

> +		return -EINVAL;
> +
> +	len =3D sizeof(ev.build_id) + filename_len + 1;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260413041143.1736=
055-1-irogers@google.com?part=3D27
