Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF0FD39280A
	for <linux-perf-users@vger.kernel.org>; Sat, 26 Sep 2026 06:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790404427; cv=none; b=HyweDn8OXr7ADSsYdB7BvC3xpi1PB0dQsVFmgvVynuQbbrvkMaV4IEjRS1yZA01HMbY5JRBRVb4KxdrC0wSGQPrXfFRA6xwTmHqZf4SLLfSb59mgaBlmiGnbHvWFsf6CwpwrD0FJvXlB/rFGRcafjeovCfsi79A2rLOd1ixB5+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790404427; c=relaxed/simple;
	bh=XWHNTaZhYYniYtVjZ7j27SQnU0XS9lFUVVyzwKCfOTg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Od1mjKhfA1C7IeWvRt5a5QM9cPAtd3vw1qVt1hYDjpJBrSwHr6Hc3sl3PDi6xleeHGyvhFuSKiOqcygh/4rz6TZQFiSm6HdC/CUYVPLC2yInk6asYJk9C34EwTmJ0TF9Y6wICyAXtYmREImvE3UFRjJZzvwxySqNC0D8FFWUmJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o3oEVsc8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o3oEVsc8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C4011F0089A;
	Sat, 26 Sep 2026 06:33:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790404426;
	bh=7/n1r/RAfytrKsKcJmfIo0WKn//HNacVvZ0lsLq4MIg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=o3oEVsc8I+g6wwMH4S4L6cO5W2szBaMUazdYW8gVCiwNXprX/6yhXrx6qIULd2RSy
	 SHjTNR8VTApoMSVIiWZL7uMpFxbg4L/0yJM0HkmTdHWKt+HT2Ajv2/+POpfIQcKtlQ
	 Y4BylMAD8RvlZffCJ/1bORbV1Ka2Cra4qdG3BN3VnihxqIczVtUNRVvAu5vDsfQ36l
	 5PWi4v0XJAFn3azWFDMxq49MDMA/AO6GjI1s8wpIPzIfUYPGjQRth0bBYGEiko/FDS
	 Tonl6Bj7n+sqTgX66WkSX2txQoQC3qosEZyA2k3K5xqbxucOXZFFy+AfDpa2qtg0ql
	 PsTyZPrsyyJ2Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 34/49] perf python: Port compaction-times to perf
 module
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260926062029.800743-35-irogers@google.com>
References: <20260923181213.3032038-1-irogers@google.com>
 <20260926062029.800743-1-irogers@google.com>
 <20260926062029.800743-35-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 26 Sep 2026 06:33:45 +0000
Message-Id: <20260926063346.2C4011F0089A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> Port compaction-times.py to a standalone script in tools/perf/python/
> using the perf module directly to analyze mm_compaction tracepoints.
>=20
> Improvements compared to the legacy script:
> - Replace Python 2 constructs (such as sys.maxint and raw integer
>   bitmasks) with Python 3 enum.IntEnum (Popt) and enum.IntFlag (Topt)
>   types.
> - Access tracepoint fields directly on perf.sample_event and add
>   -i/--input CLI option support via argparse.
> - Add full type annotations passing mypy and pylint without suppression
>   comments.
>=20
> Add a shell test (test_compaction_times_python.sh) to verify the
> standalone script.
>=20
> Assisted-by: Antigravity:gemini-3.1-pro
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260926062029.8007=
43-1-irogers@google.com?part=3D34

