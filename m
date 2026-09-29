Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90CA64483B4;
	Tue, 29 Sep 2026 19:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790709793; cv=none; b=HugBoGZ1mkVmlr7q9kHvdsmwG1AFDtsTeoKY140Z2VenFP5MHTxxrQznslc1s5LIVn7+7OLWhHHT5en1JmJsy/xXYqNt6TZd8adOlUwqTnav/j5xWbPtfR7/HAieI/S7Xz+AXq7VWBNLKrpdzMvkQQ2YCQ0kpxSBCFVRb0gILBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790709793; c=relaxed/simple;
	bh=I5WUhXAfhAbnyBzRfivbs1AmYqn2xJKLbaFgMFNgsl0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Rk5ePXNLh9ygpiPi1D6P9TavkjVCpUAAoPMpu0CazTdPCw8K+vQZWkMXY5T1DbhvaW+3d37curJuoLgTSbNV9ry30x0mM/c741/SzwQAE9qCYYkuqd4WUu7BxpngBrXv6TmIxJAEJ4AUDQbGR5g8w63M8fOaf3h68L8BjTEEBuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HUKlHtNY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HUKlHtNY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 000C91F000FF;
	Tue, 29 Sep 2026 19:23:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790709792;
	bh=tjcrUK0cSisZ2xdPFzqY8/FgS593HiIkPd6r4XQ3JDo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=HUKlHtNYc7vaTcqzGPRspVpL/FB0r0CsuT8addW3pwQFQDT31/0nKkY/Ad5ffZ0Tg
	 +rpnCVzP/xHTPWujoIeC6w5HUawpsZQGz7XTwZxTiiKup0afBSnNe54r1AGxefvVpX
	 kUjVPCBuSCKpXTeH+F27UQQbZPDa2AudZRIrcx9p4CuQ1zRJSlJ0qh/d/3jN6qsoDh
	 SJHxcUCEz8f1Gv1R0h5Fmz2v5izKw2WPlUhnyOxizdTvMlZAxPZh3p3IpaAjkfbFh5
	 ZEjjwtF69CGIbXxcaYg4pU1e+09TYJ1geVfeoxpj7mDkYvm4XUbN50E20PqvhLVJAk
	 7QB2GARR4f4vQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH stable 5.15 1/2] perf tools: Fix a asan issue in
 parse_events_multi_pmu_add()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Florian Fainelli" <florian.fainelli@broadcom.com>
Cc: linux-perf-users@vger.kernel.org, bpf@vger.kernel.org
In-Reply-To: <20260929191541.264038-2-florian.fainelli@broadcom.com>
References: <20260929191541.264038-1-florian.fainelli@broadcom.com>
 <20260929191541.264038-2-florian.fainelli@broadcom.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 29 Sep 2026 19:23:11 +0000
Message-Id: <20260929192312.000C91F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> From: Namhyung Kim <namhyung@kernel.org>
>=20
> commit 66c9598bd8916c6c1319d0100ac916cac89d4b0e upstream
>=20
> In the parse_events_multi_pmu_add() it passes the 'config' variable
> twice to parse_events_term__num() - one for config and another for
> loc_term.  I'm not sure about the second one as it's converted to
> YYLTYPE variable.  Asan reports it like below:
>=20
>   In function =E2=80=98parse_events_term__num=E2=80=99,
>       inlined from =E2=80=98parse_events_multi_pmu_add=E2=80=99 at util/p=
arse-events.c:1602:6:
>   util/parse-events.c:2653:64: error: array subscript =E2=80=98YYLTYPE[0]=
=E2=80=99 is partly outside
>                                       array bounds of =E2=80=98char[8]=E2=
=80=99 [-Werror=3Darray-bounds]
>    2653 |                 .err_term  =3D loc_term ? loc_term->first_colum=
n : 0,
>         |                              ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
^~~
> [ ... ]
> Link: https://lore.kernel.org/r/20230331202949.810326-2-namhyung@kernel.o=
rg
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> [florian: Resolve conflict in parse_events_multi_pmu_add() where term
>  initialization is located inside the PMU scan loop in 5.15.y]
> Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260929191541.2640=
38-1-florian.fainelli@broadcom.com?part=3D1

