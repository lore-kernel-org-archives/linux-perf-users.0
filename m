Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D4D725A357
	for <linux-perf-users@vger.kernel.org>; Mon, 20 Jul 2026 23:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784588606; cv=none; b=aMLM4F9E4DRUIJOKfvqxOeHEN+i5+0yCspmzR6/5AZVU/R6bA6YI6sjBTBRWcsXRgsF6N3Ah4+u5+R81V44stD85cmkiPcIwvcQiiUf52P7/aRYAB5g9RgyRvQ2HSAIY+eSTPh0l1KgFuUuyCkG25NuTzcJFCz7Ii+Y5n+d0Goo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784588606; c=relaxed/simple;
	bh=WqdVtPIeFcFdj8QNXmHd0pNMaGErMUVh+ATmdreB1RY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Iey5x2syhO+HygHDS9bZZydxb0jhCbW9i8KQQpSD2mS/VYCF8Zkcf+JuPbxccsLyj800KDTKwqKHLByFYkHYBjoVtuqz4JTniPsWjbf2fXsg3kmKxEW90UTfeWn/C1iRIXG7h6lr6PFWKcr4Nd1X2LBjeNuFY+wNfdct93h6m6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mfilp6Sg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mfilp6Sg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B2BD1F000E9;
	Mon, 20 Jul 2026 23:03:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784588604;
	bh=XMmfCBXc7BNF6iMTVM43MhVXydJhQf5XhAcYFfS14Ic=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mfilp6SgdPz6vAD73+tAFRWmz/kIrBrZKrRK8R1PFa29w4u/im0qbjfLjQVR2dobq
	 /IwqdQgxtzphsN9I0n+wpdvgITvYZOiQJeRO5lA3uav8v+l5dSQPGqEhFzDrr3gtfm
	 ylqJMK1ZgNFK+v6GNBPSaq5HtXRZeiMRgRDNmKOGznDoCFHknWNUIWlSFrcm6tf96s
	 RPvpg8gQrJOJ8Zv7BY86uq45rsFzuEa48I9hpF2D5L4SYiIMZXFciBhf55K2i8kWvA
	 pSoVVlSOjkG+z9SJ0c07+Er/BJUUTx1/WiPxIB8T1fkLuDYXdbzuQt5KWyfzCYzWYw
	 l0n3uzw2nO6Qg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/4] perf synthetic-events: Fix line synchronization,
 bounds, and truncation bugs in proc maps reader
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260720225200.3810501-3-irogers@google.com>
References: <20260720175455.3645946-1-irogers@google.com>
 <20260720225200.3810501-1-irogers@google.com>
 <20260720225200.3810501-3-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 20 Jul 2026 23:03:23 +0000
Message-Id: <20260720230324.2B2BD1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] `io__drain_line()` fails to drain the remainder of the line when=
 `ch =3D=3D -2` is passed, causing parsing synchronization failure.
--

--- Patch [2]: [PATCH v2 2/4] perf synthetic-events: Fix line synchronizati=
on, bounds, and truncation bugs in proc maps reader ---
commit f1400c3fd8b406d3bc0aa09991216359f2f3eb18
Author: Ian Rogers <irogers@google.com>
Subject: perf synthetic-events: Fix line synchronization, bounds, and trunc=
ation bugs in proc maps reader

This commit addresses logic and boundary issues in the proc maps reader. It
adds explicit line drainage to handle mid-line parsing failures and introdu=
ces
timeout handling for truncated map entries.

> diff --git a/tools/perf/util/synthetic-events.c b/tools/perf/util/synthet=
ic-events.c
> index 5307d707711d8..059dd558a564c 100644
> --- a/tools/perf/util/synthetic-events.c
> +++ b/tools/perf/util/synthetic-events.c
[ ... ]
> @@ -291,6 +291,17 @@ static int perf_event__synthesize_fork(const struct =
perf_tool *tool,
[ ... ]
> +static void io__drain_line(struct io *io, int ch)
> +{
> +	if (ch =3D=3D '\n')
> +		return;
> +	if (ch =3D=3D -2 && io->data > io->buf && io->data[-1] =3D=3D '\n')
> +		return;
> +
> +	while (ch >=3D 0 && ch !=3D '\n')
> +		ch =3D io__get_char(io);

[Severity: Medium]
Will this loop properly drain the line if ch is initially passed as -2?

When read_proc_maps_line() encounters a malformed line where io__get_hex()
or io__get_dec() fails immediately, they return the error code -2. This
value is passed into io__drain_line() as the ch argument.

Because the loop condition requires ch >=3D 0, passing -2 causes the loop to
be skipped entirely without reading any characters from io__get_char(io).
This appears to leave the stream positioned mid-line, potentially causing
the parser to repeatedly fail character-by-character on the exact same
line, defeating the line synchronization mechanism.

> +}
> +
>  static bool read_proc_maps_line(struct io *io, __u64 *start, __u64 *end,

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260720225200.3810=
501-1-irogers@google.com?part=3D2
