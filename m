Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE9214A99CA
	for <linux-perf-users@vger.kernel.org>; Wed,  2 Sep 2026 15:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788364737; cv=none; b=gwdyT9c84k5QfXIov9hpotfPIYOHQ3FKlJ0ez7TNCE177CN1H5EcwN5lwqIWKnkgsEDR7CbuFrkdUvyQGcKtc+wc9VAxg7YQGUi5lYf4gIOMGa4dHi18X22TCzNAcRluHvHAgUmTG1DrafnsCB+oCR3/N8N9wNeQSYUFCnuMU1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788364737; c=relaxed/simple;
	bh=oCneJ+Co3/3CAF9oXKtzf/2YOsVDgma58qluUYX3ZAE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Dn769lJurMv5pjVe4NSPyo1fNny/x/kJT/EOUEz+LGh+DLYRdt5utyiV3481yd2rKpuXW1d5l2vkNu3Jko6r4zP0VZDnTmtUahUiySH/OJeKRNpQo5EG0K40V/0kGOAnyrEvfA7eX2lYqj70mcE/f8PcwkUiSY/YQAF5e45l9bk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DXVziPLv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DXVziPLv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85D701F00A3D;
	Wed,  2 Sep 2026 15:58:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788364735;
	bh=83LXtGiii9a85KaVIsNaBNDp4dBFzx9DeSubsmLPxqU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=DXVziPLv0k2CDbhHWmhMUEgaXCJsOwqQRKylZJoHL2qONjIDQuKSI33NWv/oicLn5
	 fvfxatdTnsjaN3lHX0x7FxGcYEGx3sm/LkyTnR2rD6piT7s4sxOcnwb5/AyKkhsDnU
	 RdxXSU/A2OKKXcGP35+V52zx0lTp0Cv5NDJURs1BX90tsruaWmvO6ZtXcAxzCRfREu
	 SxMvNrwyiyhDuMTt8eyYp9bHuThuFeQSDyn5nKQRYrjrl2fzgWWJY58T+jfYG0YbBZ
	 m5FYttK55GXNzqn1nJkckuwPDNmlax+6RlmiKa9DOtx8SoUPNoyqXCXivIMMDExBUA
	 iyNO7V9TEwnxA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 5/6] perf tool: Add fallback stubs for missing
 dependencies
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260902154858.2078885-6-irogers@google.com>
References: <20260902154858.2078885-1-irogers@google.com>
 <20260902154858.2078885-6-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 02 Sep 2026 15:58:55 +0000
Message-Id: <20260902155855.85D701F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Feature fallback stubs are generated in the C source file instea=
d of providing dummy inline stubs in the header file.
--

commit f19b5b661c978968c83e8af505c2279ba5f83167
Author: Ian Rogers <irogers@google.com>

perf tool: Add fallback stubs for missing dependencies

This commit adds fallback stubs directly in perf.c for commands that have
optional library dependencies, such as libtraceevent and libelf. This ensur=
es
a unified warning is shown when users try to run these commands, rather than
silently omitting them from the commands array.

> diff --git a/tools/perf/perf.c b/tools/perf/perf.c
> index 65bdfd71f6262..6c5baa285b13f 100644
> --- a/tools/perf/perf.c
> +++ b/tools/perf/perf.c
[ ... ]
> @@ -53,6 +54,38 @@ static void __noreturn usage(const char *err)
>  static int use_pager =3D -1;
>  static FILE *debug_fp =3D NULL;
> =20
> +
> +#ifndef HAVE_LIBTRACEEVENT
> +#define DECLARE_LIBTRACEEVENT_STUB(_cmd) \
> +	int cmd_##_cmd(int argc __always_unused, const char **argv __always_unu=
sed) \
> +	{ \
> +		fprintf(stderr, \
> +			"'" #_cmd "' command not available: missing libtraceevent " \
> +			"devel package at build time.\n"); \
> +		return -1; \
> +	}

[Severity: Medium]
Does defining these fallback stubs directly in the C source file violate the
subsystem guidelines for optional features?=20

The perf subsystem guide expects that header files provide compatible dummy
inline stubs when a feature define is absent, rather than generating them v=
ia
macros directly in the C source file.

> +
> +DECLARE_LIBTRACEEVENT_STUB(timechart)
> +DECLARE_LIBTRACEEVENT_STUB(sched)
> +DECLARE_LIBTRACEEVENT_STUB(kmem)
> +DECLARE_LIBTRACEEVENT_STUB(lock)
> +DECLARE_LIBTRACEEVENT_STUB(trace)
> +DECLARE_LIBTRACEEVENT_STUB(kwork)
> +#endif
[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260902154858.2078=
885-1-irogers@google.com?part=3D5
