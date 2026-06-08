Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C09C33A6F7
	for <linux-perf-users@vger.kernel.org>; Mon,  8 Jun 2026 20:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780951540; cv=none; b=nugLtQ9+/Kdc1Dx2mbCIW99lNep3mUTUFld5anH2FIrMaQ1BUwLjrMDrAO+m9zYcmMmd9zSMi3czHqyxWPos+8LoNlOveUGBMpZgXweq0Gu9r1HdfwFcsF6UWTHxYY5NLRyW5jB9brqXj0grirar8jCFZq7HWif2D52qLSmoeFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780951540; c=relaxed/simple;
	bh=xf5TeghNVoYRnnn8L4xvUgUHXOonIhAsDlyfbuSkPhI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=QUphSSDoXDaNrsH0eufE/f3hk6nRuMqkp9Z3Goas+RgL6X433NpCmcjAjtsNjJl7ReGxJDMMHEmzzhdqAJpmntow5shtdmE7UzysqGU1wG5vbSzl4PZddZ4yWup+JXGcRMmQ1WYmOkYwCkQhDdzRSs0hFWhpQtzuFtxd6Q++Euk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HIJHrwFN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HIJHrwFN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E0C91F00893;
	Mon,  8 Jun 2026 20:45:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780951539;
	bh=AY2IgoYUnohJN2fNHEEgTzZWm1Fyfgkcpcu65bvDelI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=HIJHrwFNLHDIrWvWxQTmEOLQzKEQrh2ofeTYFUhVt/JItBmKlOU9NPkmAZ3Gi7n9F
	 3wUUxEkv+QQzYQOd8wqMnjXISoZx9U3vEvQbBPcMPbR/u8UkzUSyYOo24vXZc9mX7m
	 oR71EiZSaGqzuXDEyv/tYOJJEXcrYWSyugYVlpGB6dc9DhH66Sxm8aLtCXeFb1DUz1
	 ggR4ikgy61HHrJy2VC0tYxjzP/CKujGMZmnCBTV9StEfDID1FhbUIOg9Du0whItW7Z
	 HlH5P+LYI75iViasw3f4wMl3e7nOyKAlHS4pZ0ZY6/zvC7ShghlOwt+h/PNOol0mLU
	 ZGYxArfoecLxw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 11/11] libperf: Document code simplification case for
 widening struct perf_cpu
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260608201753.1979464-12-acme@kernel.org>
References: <20260608201753.1979464-12-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 08 Jun 2026 20:45:38 +0000
Message-Id: <20260608204539.0E0C91F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] The documentation added to `tools/lib/perf/TODO` incorrectly states=
 that narrowing values > 32767 to `int16_t` wraps them to 'small positive n=
umbers'. In two's complement arithmetic, values from 32768 to 65535 wrap to=
 negative numbers (-32768 to -1) when truncated to a signed 16-bit integer.
--

commit e8f5b26d672396c3173a77e6aaeee613f6d309bd
Author: Arnaldo Carvalho de Melo <acme@redhat.com>

libperf: Document code simplification case for widening struct perf_cpu

Add a bullet point to the libperf ABI TODO explaining the code
simplification benefit of widening struct perf_cpu.cpu from int16_t
to int.

> diff --git a/tools/lib/perf/TODO b/tools/lib/perf/TODO
> index 486dd95dc5720..1a3644aa1f38d 100644
> --- a/tools/lib/perf/TODO
> +++ b/tools/lib/perf/TODO
> @@ -11,6 +11,13 @@ together.
>       (x86_64 max is 8192, arm64 is 4096), but NR_CPUS limits keep
>       growing.  perf clamps to INT16_MAX in set_max_cpu_num() as a
>       safety net.
> +   - Code simplification: the int16_t forces defensive truncation
> +     checks at every boundary where a wider CPU index (int from
> +     sample->cpu, al->cpu, etc.) is narrowed into struct perf_cpu.
> +     Without these checks, values > 32767 silently wrap to small
> +     positive numbers, bypassing bounds validation.  Widening to int
       ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

[Severity: Low]
This isn't a bug, but is the arithmetic description accurate here?

In two's complement arithmetic, truncating values between 32768 and 65535
into a signed 16-bit integer (int16_t) wraps them to negative numbers
(-32768 to -1), rather than small positive numbers.

The overall conclusion remains correct since negative values trivially
bypass bounds checks, but the description of the wrapping behavior appears
mathematically inaccurate.

> +     eliminates this entire class of silent truncation bugs and
> +     removes the need for the INT16_MAX clamp in set_max_cpu_num().
>     - Scope: struct perf_cpu is embedded everywhere =E2=80=94 perf_cpu_ma=
p__cpu(),

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260608201753.1979=
464-1-acme@kernel.org?part=3D11
