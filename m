Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794219759;
	b=siPxRitF5W5RzON3r8mDzxoNu00cVOL/80VSYUOftvsRXZ8obnGdV+BeS803wf2RzCzU
	 fObOIx+bT4VkUuqAsdXzrISsZvR3ExVgei5VjI0roXksKi4fmPLEGbnBhTwe5yTrYf6ZQ
	 GO4f6RxIB5jnpHOJNZgXmEbEJHhLPM2WeAVCvL3TZWFCaFrg5pjkDOdAdeGhGtQDbzz8V
	 cshPudFnnxj24XVmMQdFmSdrz5RKw+X3i9AyuBKYN/97sOl+HIzFXxgnq7n2HiJyHDCMA
	 /BZjs3NiQQbt5iYg6FRNPKnHEuUhCoaPvyuk1QxrMSIDl7T0oOMNziDm25i2vKRnZag==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794219759;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=XsDhRqZASdPoTGZKLIWYTnvuBjs1FVioaWeC9S3f0Yg=;
	b=jeVMNNdH602E71nyrsY0UVF7z2xkDuKmURZkgDZTCDY7SjxJ4cZlKAxbSjShPShkG/bd
	 1mj0zSsX4m5V5QlnF9huiHWcpUfXxyz9sGgpKv6CD2cOCYI8jAFvyzxl31LJYPXXApl+0
	 w4w9olPd6YUhqegy5l879vPfbiOoSqKf5UbezUM6OAD0WNZ4gVgubrs/tXsx1Ysmq5Edr
	 pXhiKKah4dnM9IOIZaeAxNtt/DzbVg+Cq8V4xkQDf3CDS3rbJh+3VChz9SVpAfRMhLlP6
	 3/tP6/McD5t5EjQhSFpioZyCtd7miLUeoEsjwXw1ZJfIRKPrUqN0GLpMnF3oo/r64fw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=d0xBAzNU;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A65EE606A31C
	for <linux-perf-users@vger.kernel.org>; Mon,  9 Nov 2026 10:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=d0xBAzNU
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6436A1F0089F;
	Mon,  9 Nov 2026 10:22:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794219758;
	bh=XsDhRqZASdPoTGZKLIWYTnvuBjs1FVioaWeC9S3f0Yg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=d0xBAzNUj0DeEhRHsHK6oXYhGkM3YxbWTx39YLSXygEmTNkwOCnDvW9DEtOEwanwT
	 MUiYjleBQcGMFixguuGbGaqp0O5cbV09AFv2gHtJZel+v6q8qiL+E8eXxT8nrms4fZ
	 B6aJMBBgDS2liPJYDXPxzrP9uxepKl8Efw0dPwieYr6sCRVNqVx0V89cQ74zNabVUe
	 VZaI3y6sERUn0PF5CIa2yvrvDj21SqNJu2HaDxvxax32ZXp0aq4mE2WpLpqvu6JorL
	 Q/xn6AsqJoZWtJwHhFy+yijsTbWioelpKlLMqJXkor6kInwHiN/xA34Jo1IRX3nggT
	 dnwXozFl2b8+Q==
Message-ID: <sashiko-outbox-204808@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 4/4] perf test: Don't starve per-process tests with
 system-wide events
Reply-To: sashiko-reviews@lists.linux.dev
To: "James Clark" <james.clark@linaro.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261109-james-perf-test-fixes-v3-4-e8d0a65e618a@linaro.org>
References: <20261109-james-perf-test-fixes-v3-0-e8d0a65e618a@linaro.org>
 <20261109-james-perf-test-fixes-v3-4-e8d0a65e618a@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 09 Nov 2026 10:22:38 +0000
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261109-james-perf=
-test-fixes-v3-0-e8d0a65e618a@linaro.org?part=3D4

