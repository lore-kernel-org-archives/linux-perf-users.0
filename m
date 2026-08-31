Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98733422541
	for <linux-perf-users@vger.kernel.org>; Mon, 31 Aug 2026 13:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788182592; cv=none; b=kzmhHzUWBoqekGBUntXjRGOkwoq9pC7ufjd36ue4sg7LP3Oj8J64WHSBKBRbHKH8623O9s0nuMIK7MVe44jsQjCT7nnh5pYflJLcTEEQewFAuaMadc6J5i6h/eU4F45hj/KgrF6LvibtSW20bz2jdhEf19dhe2OoVsWdDWTrZ3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788182592; c=relaxed/simple;
	bh=i5RsbQ9Fd8OnVXO1TA+VJnPMbFgqoa4I2gga6MxTa+I=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=h8wk8EvY5y8YLlpQd1GlcOe32kAZM7h5P+jznMf6dpby1Y0HD0TO4mJBUmFdD3xO991EAAiQ3YxZMWxrBHvqGMImv9Nl91rUVAgz4kk5jLvrd8OGUAQ5836hO8Sxs0ef+LA9D5+CHRv25yOva7e9R32Uw6ObEO5ps7LOpZLiBVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gw3B7MKq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gw3B7MKq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 223841F00A3E;
	Mon, 31 Aug 2026 13:23:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788182591;
	bh=Bl6KcZK8KAYF/dw/9PHy2F77z/wCy4ZhhkLQfmfNfa8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Gw3B7MKq3jZDEGg/zeAjMApkC1mjQaAp5Tvh9Ro/B9pnXoFQl3anvQaj3lffW1HJ5
	 +qdhifnf/+b3sPcSfHZs4fZXj1pSfiU+++XrtlycFteClr2sdUJz1Cu3O6BgzoaDrH
	 4TtnZfzFfVRobkr/kBbWAekLi6vViR+6vqX8GG5hWFkBItb6ji6T310ZiD635ZilOc
	 i2jdI5IA5AIHeENq5eUswWVjjQBqd2JUtIH2IzIcg+OJx0L4FBP4loma0ysgOv1PVN
	 4S2saA8YLQtH8u5QcW9ckmnsN+rGgWZ4jLYYrMae9cn+a+PEn/3f3PkfSfJx18Q6aR
	 PPq19UmeoFXhA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 10/12] perf jitdump: Validate debug entries on native
 (non-swap) path
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260831131110.4681-11-acme@kernel.org>
References: <20260831131110.4681-1-acme@kernel.org>
 <20260831131110.4681-11-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 31 Aug 2026 13:23:10 +0000
Message-Id: <20260831132311.223841F00A3E@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> From: Arnaldo Carvalho de Melo <acme@redhat.com>
>=20
> The bounds-checking and nr_entry clamping added for the byte-swap path
> only runs when jd->needs_bswap is true.  On native-endian files, nr_entry
> passes through unvalidated to jit_repipe_debug_info(), which stores it
> as jd->nr_debug_entries.  Downstream, jit_process_debug_info() in
> genelf_debug.c iterates nr_debug_entries times via debug_entry_next(),
> which calls strlen() on each entry's name field =E2=80=94 a crafted nr_en=
try
> causes OOB reads and writes.
>=20
> Add bounds-checked iteration in jit_repipe_debug_info() that validates
> each debug_entry fits in the payload and its name is NUL-terminated
> before calling debug_entry_next().  Clamp nr_debug_entries to the count
> of valid entries.
>=20
> Fixes: 598b7c6919c7bbcc ("perf jit: add source line info support")
> Reported-by: sashiko-bot <sashiko-bot@kernel.org>
> Reviewed-by: Ian Rogers <irogers@google.com>
> Cc: Stephane Eranian <eranian@google.com>
> Assisted-by: LLM
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260831131110.4681=
-1-acme@kernel.org?part=3D10

