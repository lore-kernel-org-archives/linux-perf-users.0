Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E07023E51D4
	for <linux-perf-users@vger.kernel.org>; Wed, 23 Sep 2026 18:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790188609; cv=none; b=d1frfaEoJW66fHgf6gjpaWKY7Oj9cuTdWfjeaKxPzvbCh5RsIVHiUbKh+Al52BdVLEbuzUZ1qOPhp7QGDCbxDI6J8dKckSjmmqsdJ2dgTmnj34jFRwrO5G/SLwKEkn1/JSbO6bKr81GMsitTMRcC76jHTU0FOMx+ySeiIM1hsTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790188609; c=relaxed/simple;
	bh=VlTcXBiCp5jOJCImLz9hHjXBYP/WFY6zPggiprgGBI0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Np5bvDH9d1tR050MgSwhVHapE3xvHSVgKDmj7RvJrrPWEO9Rfaz6gFQvXtieXP2sl4j4PwA7ztw8EGaUMHzTpRnJAPh2GPV6FDBAFs9Kjuv864eOojiIZShhMITzCgkFlX8Ynjn4woVE74mqkpxdcFQiq/mpPnV55mCERHe54Z4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z0LbmT8C; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z0LbmT8C"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BDA51F000FF;
	Wed, 23 Sep 2026 18:36:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790188607;
	bh=Hv2Mdok6F9PE/jGI/HiA2tQiOYSxky+HZuj9Klz6C4c=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Z0LbmT8CGJId+YrlMvxkYvePeCaNAsLC4h/XcyZKPiVYyId+A372JUOgibLvvt1kT
	 FaIIXosapg7PMgfHMaKPY/o7VbylAIUudqajN6GN86neH9OmhXEmj2XvBHieCc11uK
	 P4JRxB7ISVEaBBXrP1hNODGgPGYb12+tl6GUuhGeHutTl1DpIcV0UYiJE5f93jnPM/
	 oXoOe3YSOD3F0SczB3riJ1kkM8zJSFP2CU9cFmZLzTb4V97TgFXSUwqGxKsbSHmff8
	 R4MIeWaN19NJJOPPcPSjk6pqhFtmpEYg+hEAzjrnIBiWZIUKdrgFJ1TrgDgDFvhoBP
	 yIHgfqYi73a3w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 29/49] perf python: Port rwtop from Perl to perf
 module
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260923181213.3032038-30-irogers@google.com>
References: <cover.1789966896.git.irogers@google.com>
 <20260923181213.3032038-1-irogers@google.com>
 <20260923181213.3032038-30-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 23 Sep 2026 18:36:46 +0000
Message-Id: <20260923183647.5BDA51F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> Replace the legacy Perl script rwtop.pl with a standalone Python script
> in tools/perf/python/rwtop.py using the perf Python module.
>=20
> Improvements compared to the legacy Perl script:
> - Remove the dependency on libperl and Perf::Trace::Util.
> - Support both offline perf.data files (via perf.session) and live
>   recording (via LiveSession with --live), driving periodic interval
>   summaries from event timestamps rather than wall-clock SIGALRM timers
>   so both live and offline runs produce deterministic output.
> - Convert unsigned 32-bit and 64-bit error return values
>   (0xfffff000..0xffffffff and >=3D 0x8000000000000000) to negative errnos
>   so failed read/write syscalls are recorded in the error table rather
>   than inflating bytes_read / bytes_written.
> - Sanitize non-printable characters in /proc/<pid>/comm to prevent
>   terminal control sequence injection.
>=20
> Add a shell test
> (test_rwtop_python.sh) to verify the standalone script.
>=20
> Assisted-by: Antigravity:gemini-3.1-pro
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260923181213.3032=
038-1-irogers@google.com?part=3D29

