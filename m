Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2249C3F1058
	for <linux-perf-users@vger.kernel.org>; Sun,  4 Oct 2026 06:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791094260; cv=none; b=I34D7kS5lJ/6l2qdpz51xV5K1vpOuqbGT0AmxmRijPQqBa7ZMTprEb2HUZ781qivh3WlSbprB8zytXaZyVUskB3EnLVm3cQQ8J3SjkHAp0fbCq9kZYL6Dg52ymzNQrgaDVrDPTBc6jTZJCdDTPN6Z+yGayGy8uXsdK4OGGzDu44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791094260; c=relaxed/simple;
	bh=UWj75/0eOTHc1HgF1FRBTIqr/PM1yKht2s4PZu/CfZ8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=IRgbm8EbzRBamdgrcL2YqP10JnzhnzOwLtDC41KcCsMU6y/xyPDpvxTfVMFqpr4mqodEqOmfL7UKF0tW3s/l1NP4BIMCbi0FzHkpiBAFfcEIq5YTLPowAHMLBisjL+Lu0eDV7o3wmNmcyBww/bepJ64wsHB1Mmw4zXlijCNcIPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DCMaUQAB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DCMaUQAB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D795D1F000FF;
	Sun,  4 Oct 2026 06:10:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791094259;
	bh=UWj75/0eOTHc1HgF1FRBTIqr/PM1yKht2s4PZu/CfZ8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=DCMaUQABYdHfkOhMCseK/6u8T0k1h3GUGZ77kOHceVcBLLyIUvo8yIgBsw/813oUa
	 1ST0rwnFMGCwkuZD4YJ8Xw/2A7SMQGFpr+3r1sw+DqCRLNUT715Vw+rFXRmpQy9Ef9
	 Bt52IE29WJBNLlvJx9OdPQlmocpXFWcqw/4wC39sivveLq4L9IhEuGHmFXLuvpbCHH
	 eWoHaSGpSshBiM4yuyUUGXl+EvOL1ar/HIWf9VP+HO094UN5cKgzTymTbw4hNDPGvd
	 scEkcDLL4jG7cvFxdiNMTJJE0mddjoR90/aZ8aYHCGkZYQJYBoAjOiIDxd8nP3Rh5w
	 2+E4jSg0hbRfQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 4/9] perf mutex: Add DO_ONCE() for one-time
 initialization
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261004060457.3353-5-acme@kernel.org>
References: <20261004060457.3353-1-acme@kernel.org>
 <20261004060457.3353-5-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 04 Oct 2026 06:10:58 +0000
Message-Id: <20261004061058.D795D1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> From: Arnaldo Carvalho de Melo <acme@redhat.com>
>=20
> For lazy init that more than one thread can race into, without
> pthread_once() so that it stays within perf's locking primitives and
> clang's -Wthread-safety keeps an eye on the mutexes involved.
>=20
> Mirrors the kernel's include/linux/once.h DO_ONCE(), dropping its
> static key fast path, unnecessary at these cold init paths: a per call
> site static bool plus a statically initialized mutex, double checked.
> As there, code reachable from more than one call site must go through
> a common helper.
>=20
> The lockless fast path reads ___done with an acquire, paired with a
> release store after fn(), so that fn()'s side effects are visible to
> threads taking the fast path, which the dropped static key used to
> guarantee.
>=20
> The __atomic builtins are used rather than smp_load_acquire()/
> smp_store_release() because ThreadSanitizer understands them,
> avoiding reports on ___done and on what fn() initialized.
>=20
> Assisted-by: LLM
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261004060457.3353=
-1-acme@kernel.org?part=3D4

