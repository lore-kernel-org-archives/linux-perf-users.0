Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 367CB39A078
	for <linux-perf-users@vger.kernel.org>; Sat, 26 Sep 2026 06:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790404548; cv=none; b=hlKzpZN/qyVA2PdOJapbDW47d7Ip22vK9IhSD/ZsBwtvKdEP/+G+gdVqmuUuju94ai31tFR9TcNkfmgpdd+fLdTIDWIfgsIq0z3PFBF2BnKB/nIwkwXm+Q6JUBBse8BmcLSDAh9HoPDJh/TocB9r/Bk/IzNVbx2CGS/hp4vTJMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790404548; c=relaxed/simple;
	bh=FCHgMOVT+++zGf7/u3h8u1m4EuNE9pfrhJcZ/rkXTPs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=DI8yYYR+AhfQvjyndFGYdpakwJyE34mVlQ1TWorwMbQ/KjMHebHGt+yASVQi2E+eOO+fV/tKe7DYIdTWY0dhRVs2VnVaVsomAEngjqiT1F9STDL4eFIGgf9KHCR2Aop4k2R5xvAzlvYCgZ31hN0jsAwAAlYp3pFjmyuHM+V8MaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NnbX8PkW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NnbX8PkW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E8861F000FF;
	Sat, 26 Sep 2026 06:35:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790404539;
	bh=BlduKkAvYw72fnqJDSa3SWEbh1EMwmVAkpRKmvWhnxQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=NnbX8PkWMxlT+W0ryGHmwnDB6YE6OkPEDCU5VXtYPbTSKXDHAcGTtYVwtJsTPh6/X
	 PhJbPNVpTiKA9Ty0nQ8Qs0XqQWj8oChnkkJP1DY0jtqWTKHBptLXHU1TX2NAvZRhrE
	 TU7LbHaaAU1zuc8dmBhibYiCoIr0XuM+ldGDsNeixBGl5gzsgDdEk4AzyvPRS+23JT
	 F1alaYa+kCcTs2+3Mw4SdsU6E5EPr9qepBqyjSZ6uwstThmYeWmoAfDH5jVEtNDGBY
	 ofb7g/jdYKlaGCOAdklNysQp8QyB7cL6cKZbuwwRLmlzCzNypAzlL5nT5PTVXRB8r8
	 ZuttdrDnneFRA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 33/49] perf python: Port wakeup-latency from Perl to
 perf module
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260926062029.800743-34-irogers@google.com>
References: <20260923181213.3032038-1-irogers@google.com>
 <20260926062029.800743-1-irogers@google.com>
 <20260926062029.800743-34-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 26 Sep 2026 06:35:39 +0000
Message-Id: <20260926063539.8E8861F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> Replace the legacy Perl script wakeup-latency.pl with a standalone
> Python script in tools/perf/python/wakeup-latency.py using the perf
> Python module.
>=20
> Improvements compared to the legacy Perl script:
> - Remove the dependency on libperl and Perf::Trace::Util.
> - Track wakeup timestamps per-task (keyed by the wakee PID on
>   sched:sched_wakeup and matched against next_pid on sched:sched_switch)
>   rather than per-CPU, avoiding mixed latencies when multiple wakeups
>   occur on a CPU before a context switch.
> - Guard print_totals() when total_wakeups =3D=3D 0 (printing 'N/A' instead
>   of dividing by zero when a trace contains no matched wakeup/switch
>   pairs).
> - Add argparse CLI options (-i/--input) and full type annotations.
>=20
> Add a shell test
> (test_wakeup_latency_python.sh) to verify the standalone script.
>=20
> Assisted-by: Antigravity:gemini-3.1-pro
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260926062029.8007=
43-1-irogers@google.com?part=3D33

