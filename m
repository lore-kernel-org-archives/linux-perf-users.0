Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 012E753D0A6
	for <linux-perf-users@vger.kernel.org>; Wed, 23 Sep 2026 18:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790188256; cv=none; b=DhASt1o2YuZpNDJ9j4GpeFUvpkw3xdbL6+CtOqMriW7G1Xryb0clmZweSfJe0xuZmh/GlieDBXr/ibFxnLnpcjx3Uv2ByK5nJl5erOPCcYnOgM6BWfQQipfOttksF058BM+JKTNyIxX7VCrE56UYQmFYQ9xpUzcFpqtM8JEMA/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790188256; c=relaxed/simple;
	bh=pkmGzIEqbxk4NZdTUjP3SnKWM4AIAR2Jvsuv4JvCB5w=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=eFWCX2bXP0+rZ7jK/EtNwSoB4CJhCr/8arcjuJpm2sWfggHKBIqRZJwUVSoBhBeAplM/sZd1ntDz6B/0z+2LftVjYmRpkVvEVKf+obwDFrF3MHddj8yRta8Y2AT2qVtIFKjhhzb9oUFI8RtioOgF6BkAN0NdfAYslIY0wzojfxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gucF6zmk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gucF6zmk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C8851F000FF;
	Wed, 23 Sep 2026 18:30:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790188249;
	bh=F34SbGyw4bMt4u9fGFpybBE76br5Jeb0V1n+T2MsDKo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=gucF6zmkCmrXLesvT6s6XIHMbXxUiCzokR/z5ehJpT1CPBwerLOtbBYfKzCD/IDcn
	 +Ikn4RCdi1LATk7jUPtTxCUJnPNgeuV5OEmjxzbl+hRZehiap3bV6Qp48qlPJU1h36
	 e3y1UUOkFDzYu4/FqecmesJArBidKDDdd6rR+uNRfiXVFDl/TF8yhIV/2kYaDfrYhJ
	 xb0kM8d4S0wAio8E6yNTLTW7go8YVWsAw4CjoTU2MS7hUG0U1t6o4FdsqigS/mFB2d
	 j9kaWBYdd+QSpC/LLnCGh0ccnfgG5yFDTDQTTLUWpmEisPWJNoBCepwka1l6m6qLF3
	 aVDXA1c/b/AWQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 22/49] perf python: Port syscall-counts to perf
 module
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260923181213.3032038-23-irogers@google.com>
References: <cover.1789966896.git.irogers@google.com>
 <20260923181213.3032038-1-irogers@google.com>
 <20260923181213.3032038-23-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 23 Sep 2026 18:30:48 +0000
Message-Id: <20260923183049.6C8851F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> Port tools/perf/scripts/python/syscall-counts.py to a standalone script
> in tools/perf/python/ using the perf module. Avoiding the embedded
> interpreter and per-event dictionary allocation overhead improves
> execution speed by ~4x:
>=20
> ```
> $ perf record -e raw_syscalls:sys_enter -a sleep 1
> ...
> $ time perf script tools/perf/scripts/python/syscall-counts.py perf
> ...
> real    0m3.887s
> user    0m3.578s
> sys     0m0.308s
> $ time python3 tools/perf/python/syscall-counts.py perf
> ...
> [ ... ]
> temporarily during the transition to maintain bisectability and are
> removed once all scripts are migrated.
>=20
> Assisted-by: Antigravity:gemini-3.1-pro
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260923181213.3032=
038-1-irogers@google.com?part=3D22

