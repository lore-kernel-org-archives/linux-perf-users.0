Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793962316;
	b=KMwCyG7LZ8LPmd4suHLa7Mto/kpSAcxRZ6Lkmc3Udzz/lQe/ly34K0M/Rt6r7N7n4V6L
	 7HbWbrEdSby5SpjsC+fToup13ia/u1cVqZRY99jYVkv5vmdKFsGhpxC1FnKB+fT2CxNhA
	 bepoplX8V75gfKGGCHD/P4FrqfRzeEEyfxRFB0HhZ2qMz6BdNscsYDQ40zTCH/VQ9P7ZD
	 IvrZvYevfZd+bHdi4xNboe8Cc/51+woBvJgRx+ly1fpe/btjog5xL53tHbZESx1C3JaQZ
	 +CYH4NIz3A5nTK/ioivlOXBbGtZz22z3XJy37em5GjtTIrVQSn20zFQg5ujm1I3HaDw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793962316;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=r9foQXmJTV1etxPqaKfMUteZLLHTbt4TSVeqZt/ZyMo=;
	b=0HycjQNVxk+WcDBoMVu2K24HHZOw28IZZAQZ2koWpHNd6OquvrFHVxZ/4IJWvrFfEY0L
	 2oQxD5wNbXDc0stCncoQBtRyKWkpbdGDt1et+965fRjlG4roWPSb/SZzCTwMKppHcZ4et
	 w6mmJcZald5siZoCH5BgfcRvFrkAoYgvXItyKOaxKvOR7VnhCAHM6DN1Jfufk6TsCzIvM
	 87EizmUkYdnhDiWei2CJpthiPcK5x/qx2DL2kpOmDnZlC4Lw3FaubIvcA8aL74jWNCo4w
	 0D/B+d+VCxtsw0LXEHxNE4EF0G96pHpSPgupi8nMB27tYdiucH6CxlOdlQjw6wNbZog==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gAAZzHqA;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF23A606A333
	for <linux-perf-users@vger.kernel.org>; Fri,  6 Nov 2026 10:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gAAZzHqA
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48D481F0089F;
	Fri,  6 Nov 2026 10:51:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793962315;
	bh=r9foQXmJTV1etxPqaKfMUteZLLHTbt4TSVeqZt/ZyMo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=gAAZzHqAeW5OqYv0FXB/fwrK6w7ujIJRDdsfwCUG841u3dDBCIPUQjs+FMZW07I/4
	 X6c4714Dp2Zp7MaYL3HCm49ZZOU9oBFf4/3jvDfOJg2I+dbgzmD/R/q1mlAjBOVl4+
	 b3RNbvUooNk0tJwq6dRESG/Nqjkw1mOtbrNYCaQUsRYoQA0HW2W1zdeNmYWYbapOVJ
	 DnoSXbaMEaPFbscoZhZwCAMaUR8XE5/6f/P6Tut8amSTDUDIxNSM82k+bh62AQvgMs
	 d/StFxgGg/vsWM7B7nZpRNgZEhImuPq48PTQBJEw+oQf5BJlQ4hGHfziYz39X7QtG4
	 3UsHvofMhQe7Q==
Message-ID: <sashiko-outbox-201234@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 4/4] perf test: Don't starve per-process tests with
 system-wide events
Reply-To: sashiko-reviews@lists.linux.dev
To: "James Clark" <james.clark@linaro.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261106-james-perf-test-fixes-v2-4-9a912662f822@linaro.org>
References: <20261106-james-perf-test-fixes-v2-0-9a912662f822@linaro.org>
 <20261106-james-perf-test-fixes-v2-4-9a912662f822@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 06 Nov 2026 10:51:54 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> Some tests intermittently fail when run in parallel, for example "Check
> branch stack sampling" fails with no branches recorded at all.
>=20
> The default event is cycles:P which there may only be 1 or 2 HW counters
> for on Intel because it's precise. System wide or per-core precise
> events hog the HW counter leaving other per-process tests with no
> samples. Rather than make all the tests that use default record commands
> run serially, just make the system wide ones use a software event which
> has the greatest possible compatibility. They don't need precise
> sampling or HW counters anyway. The per-process tests can be left alone
> as their events/processes never run concurrently on any one core.
>=20
> The LBR filter is another resource shared by all events on a CPU, and
> the system-wide LBR test uses different filters to the per-process
> branch stack test, so mark the LBR test as exclusive.
> [ ... ]
>   ...
>   ---- end(-1) ----
>   138: Check branch stack sampling : FAILED!
>=20
> Signed-off-by: James Clark <james.clark@linaro.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261106-james-perf=
-test-fixes-v2-0-9a912662f822@linaro.org?part=3D4

