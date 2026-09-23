Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A4AA1DDF0
	for <linux-perf-users@vger.kernel.org>; Wed, 23 Sep 2026 18:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790188745; cv=none; b=Sal1al7kF1TO8A8wEz4Hu14QUFGGUfKI9HjAoe11icnmkdywdlswaN6wpiMq7AJt8yZJU4rdFzHe6miHr8Kxqgdl4OzEyIuG3CdkiseOh7VeyC7P6OutEs2syGkJt15gFtX9bhhgXxL+8hKdzp6QJhQL2+hQdnkmthg1oKlQnSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790188745; c=relaxed/simple;
	bh=bIeMKpWsAWTdrNrIzyW0iRLYPE5k/PTFV8/7ErXLQQQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=la7tCn+ctxXElEdgEeTmakoGpjpI5X7gGkPEsqYuT98k6VkJfVG5n/XlNnUPlGhKRSPoU3Ag0AlCQS4tGpx3epdhyYH7XTBgBidxgh9DE5d6cb9Hk1MQYHhiuL2pUFKm+Ar+//+2BQOLfdBflecoVwuDYu2nmysHcnGw2G08cKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B0QObfp/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B0QObfp/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABA611F00893;
	Wed, 23 Sep 2026 18:39:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790188743;
	bh=Sh5Bugrtygpq7OcyLRcUwwUimcHDrhBEPVxdJOrxaHA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=B0QObfp/pXdTiNjNnQVEiCaueE/ZbfbQFS/jgDhYf6f+hgRwwDXuLbfxeFOctKx34
	 fcZYyIVU8wDZ/DtO1kDw9W+YpZVeKTRgbei8nkFT7en4oG8wdhx4e0KfGPaAMTjCpW
	 vCvqrKS1Dj2C7kDef09HU5RGxvtfVRbXH/TLtMalTwb4uvUW+kMChUaBZEaB9SZcUz
	 Zca14/loarHFkpwTAb/6k2E35HN6/98OcIbaDH1Wxk1VIns1KzXexeiCDmD4FWNsRU
	 rQdPiOdLUgReL+6iRPF/Y7PyfxvgA7KyqWa2WXcsOKSjVUUtnNXdGEHSt4+3a/HNGj
	 V5O7h/tdzOflA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 33/49] perf python: Port wakeup-latency from Perl to
 perf module
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260923181213.3032038-34-irogers@google.com>
References: <cover.1789966896.git.irogers@google.com>
 <20260923181213.3032038-1-irogers@google.com>
 <20260923181213.3032038-34-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 23 Sep 2026 18:39:03 +0000
Message-Id: <20260923183903.ABA611F00893@smtp.kernel.org>
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260923181213.3032=
038-1-irogers@google.com?part=3D33

