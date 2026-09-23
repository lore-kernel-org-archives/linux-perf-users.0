Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14209535FA3
	for <linux-perf-users@vger.kernel.org>; Wed, 23 Sep 2026 18:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790188391; cv=none; b=DVAl7OF6kLkNIaRIujwtZb+lgmr2NhMf4PBEyOzvItB6y+uhz4vw/qi2KMSOkTQAtDWX4pP38mfTQm5h527ypVV+GkHkt2c4eyLP2+OBXYFNhq2X/IaUEwA8x9IP8pSyvonnCmQcnuyn5jHOsQYO/Q7XkYLjmIiLDOlcmB7rA4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790188391; c=relaxed/simple;
	bh=aIa7lJn2WhjXzv2xXRlt5tP6maOzWh7w0rYuHHJ1OIE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=eLzl/A0KOiAyCy2zzHuDWLsAjLFMCzt5InzVIh0BrEJCDfJZFVA9EEw4gTRLOtxCsEto4Q2ckdt7KAnH96gu8RqTtdncOCnd6xM4vnercMmtAgcAj/R1PCbMwPgez6Y6ceOXdPiiAccxhg+Mu6POz1dI2elNwnXZQHPh55ElBtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PeUoTHXz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PeUoTHXz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9614B1F000FF;
	Wed, 23 Sep 2026 18:33:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790188388;
	bh=OBAjdWhHVhxY67HYElmDW9iAko8j1ZoQBbFVkkrdFog=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=PeUoTHXzvPRfJuEoEhgrilAZC5nZFmnMc1I1i7YtT7txEe/BguAAeKzzUdDG/z68f
	 svb0dyUQraxXYA7UUJlGPLjT4Lc25PHztiGOSaAUYAVRBuTVBlpmqQNSdHeM0MEzUF
	 kC5Wz1Ft+d1zBehfU34LamTubsGnwuIwtF97TgUEwqANz0MSxffPi2cYHZ/5SqmXXp
	 ZfGsssYEXziPrEO4nQ5rA/rPHMwmmfvtICUgnhorO2uRq/boEr8TAmux+J501W3oBi
	 OirCNxHmGQJuq8ekEg3EGpGk/pRfe2hp8V0aiuuktUfLsOBC0jKwb2562w0oV9IafF
	 Qfksfc4jLagvg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 24/49] perf python: Port failed-syscalls-by-pid to
 perf module
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260923181213.3032038-25-irogers@google.com>
References: <cover.1789966896.git.irogers@google.com>
 <20260923181213.3032038-1-irogers@google.com>
 <20260923181213.3032038-25-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 23 Sep 2026 18:33:08 +0000
Message-Id: <20260923183308.9614B1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> Port failed-syscalls-by-pid.py to a standalone script in
> tools/perf/python/ using the perf module:
> - Resolve architecture-aware syscall names using
>   perf.syscall_name(id, session.e_machine) instead of host python-audit
>   tables, supporting cross-architecture perf.data files without external
>   dependencies.
> - Translate negative syscall return values into symbolic E* error names
>   using perf.arch_strerrno(ret, session.e_machine), leveraging the
>   auto-generated trace beauty architecture errno tables.
> - Encapsulate aggregation in a SyscallAnalyzer class using
>   collections.defaultdict and add argparse filtering by comm, PID, and
>   -i/--input.
>=20
> Add a shell test (test_failed_syscalls_by_pid_python.sh) to verify the
> standalone script.
>=20
> Assisted-by: Antigravity:gemini-3.1-pro
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260923181213.3032=
038-1-irogers@google.com?part=3D24

