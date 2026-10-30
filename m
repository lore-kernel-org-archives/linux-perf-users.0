Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793373611;
	b=Zo6Rck6XkW/t7Fq/zP1s3QEsZrxPGFoEZDt2bu0ex/r1cStDp953WR0LW1cXcOrQyu2d
	 3dZJNO/HcG0q78UBwzi8MwO1j5g8rOMjv7QMS6HB6l9lNJ6cPNs4l39ayH6u+AfN9UyCP
	 b09hGe7HBGmQzUbk18qyRBtTFL4cSYbsVHSU4lPfclmExLbkkXNfl18NlSiYEsSBT58vc
	 HsKcDKfNuecNGHpUwPMH1ACcsIKsjy1RE/xoCnTxla9BKottdhVgkBXYe7fOIMUJtHmkC
	 PDXUGuI5ztbcxWgf8wrg3xsc5EMJPAtRJ3+paJmtj1TSrjw3+r0mGiX9YU2SR3/39JQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793373611;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=Mgi+HoJTGTigFRqKprfnwrVt+kAZ27VSoEp0QpD+aIw=;
	b=HD2tpQvYOqIeo7Q9+xyYfFE7j/W5QAz2AOL0bGAtES//LK25o8rbSWrEdWRnZYb65vO+
	 LGYf/sPMHwwRUGggtJ/KPv4H1lnoqHaWxq/kxcI7qiU3N7TS0NOx7IF1jI9FHkOFqcSDW
	 H5oOgJ1BxQnvX9K7Q5tEqeKI64kLRkS227WLUp7LAhqKqJUU5FJQES47PbGCuSxPgS4RU
	 JPKzhaxLZujbuUGSw+optrMItQ9O/1VIKY1CM3dLKeAVI5MlwzLRKm6eQZSFsFDAUtq1m
	 PbfW6aOIIJqd05CPUYyLLcfrECVFUAfF9vLBbvvUBRjBGtJsXs57LNWzg6iM8+OIxww==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FLB8wLHc;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CBC7606A31E
	for <linux-perf-users@vger.kernel.org>; Fri, 30 Oct 2026 15:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FLB8wLHc
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05A641F000C1;
	Fri, 30 Oct 2026 15:20:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793373611;
	bh=Mgi+HoJTGTigFRqKprfnwrVt+kAZ27VSoEp0QpD+aIw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=FLB8wLHctNEvRGCQmas71n6z4HavsFABetqcIJ3hSvfFVHgG1X6U+vH2sruhokawW
	 Y0/hFQrUGhMBPg3+u+UhlFm+37f3XKkzItRcFKg5QVl2kAz26kQVsHSRX7HcfxYJSc
	 rM8FNxvFVjKPjUiyPmPxQ1DGw1eyxg5cde3bTo2OeqN4S4RFouyivTHVRkLcnX2XZu
	 j4L9z+KSOfqyIrVonIALc/Y90bZ95mhY8MNtphmNjFJJYljiZJLxtPLCfqE1G8lk4Y
	 HIMnGoATH1P0UajUi0Vtrb2CsEqS+d9aJn/30VMv3PTDf8PmfBcV2EYzSU0jp2XFfw
	 USmiIr9Xgfc1g==
Message-ID: <sashiko-outbox-191154@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 01/14] perf sample: Allow decoders to supply branch
 return addresses
Reply-To: sashiko-reviews@lists.linux.dev
To: "Leo Yan" <leo.yan@arm.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261030-perf_cs_etm_fix_non_taken-v3-1-7629b52ab047@arm.com>
References: <20261030-perf_cs_etm_fix_non_taken-v3-0-7629b52ab047@arm.com>
 <20261030-perf_cs_etm_fix_non_taken-v3-1-7629b52ab047@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 30 Oct 2026 15:20:10 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> The thread stack derives return addresses from IP + insn_len. For an
> interrupt or fault, the return address can instead be the sample IP even
> when instruction bytes at that address are available.
>=20
> Add ret_addr to perf_sample and prefer it in thread_stack__trace_end()
> and thread_stack__process() when supplied. Initialize it to zero so other
> samples retain the IP + insn_len calculation.
>=20
> Add a regression test for explicit exception return addresses and the
> ordinary call fallback when the return address is zero.
>=20
> Reviewed-by: Adrian Hunter <adrian.hunter@intel.com>
> Reviewed-by: James Clark <james.clark@linaro.org>
> Signed-off-by: Leo Yan <leo.yan@arm.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261030-perf_cs_et=
m_fix_non_taken-v3-0-7629b52ab047@arm.com?part=3D1

