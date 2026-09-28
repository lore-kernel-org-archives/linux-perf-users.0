Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F7A9352029
	for <linux-perf-users@vger.kernel.org>; Mon, 28 Sep 2026 18:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790618458; cv=none; b=VIFepkPS7+WTj9sUv55G2RYQjfHhHJH1ApQUa8g8LaVky7zTh67VqbsXQiR5loLymM82MkXsz70NU+1JdeEXKysjY4bUHGwFdSV/arsF6PJdoIm0nAYaClitjHRh1KECuRm8HTPAfstJAEJyvsQRyTewYtr/nV0qOmQNxPSv4L4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790618458; c=relaxed/simple;
	bh=j3NUFdWQiMLIW63OC2hczallXyft4vRhX5CAAlDAXCE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=eSoIYVCBOyIQMGGskxNK9m1u16fChMoQyoPU8IpFYRR5625KYsm1Fs09T+VyaFNJF3HwLcS8keFZIEmSdKAy5LrHzQ9ttjv4HcyWatVbUrvNnx5xgLpTP6UKnLTi+CL0K/pPDcarshPRb+RolqtiirOr9iM1eJO81xRgvWKaUEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fz1wDLJU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fz1wDLJU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CF6D1F000FF;
	Mon, 28 Sep 2026 18:00:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790618456;
	bh=/gcySimlfhdKFE3uirmTGOPunbsvIKEtW5vSfbgyxdc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Fz1wDLJUZuNfBzG0JXo8vUPbQQMbeGHcI4u9WI8lYE+hjdfdnigeR8RPNIWPAbR8J
	 4eA/yd0JyxgtF/e84sFqB/Q6yyKn/4g5ynkUM0KI1828OufVslF4aGbYCKlt/uOVD2
	 xOSDTpgoJgXD8IlrOeXburrsWORMkqdJ7Mfr6WT83AznhQ5ZEusDPC671i0r75GkZq
	 J0jELEpolfcSIiDLmkz166PBuw3KUDQU+K4sAGMS3+AZrg/WlsER7ufP9PdG7Lepla
	 518M4d3bAEDzq7Ik+3+Bx+AY9Flev7RadtFUtBuoivGCR9IvRBpA16r9k4Ib5636yn
	 JFc5DYG3TUaZw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/2] perf jevents: Add NVIDIA Tegra410 uncore DDR
 metrics
Reply-To: sashiko-reviews@lists.linux.dev
To: "Chun-Tse Shao" <ctshao@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260928175127.1032535-2-ctshao@google.com>
References: <20260928175127.1032535-1-ctshao@google.com>
 <20260928175127.1032535-2-ctshao@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 28 Sep 2026 18:00:56 +0000
Message-Id: <20260928180056.9CF6D1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> Add DDR bandwidth and latency metrics for the NVIDIA Tegra410 SoC. The
> formulas follow Documentation/admin-guide/perf/nvidia-tegra410-pmu.rst:
>=20
>   AVG_MEM_READ_BANDWIDTH_IN_GBPS =3D MEM_BYTES_RD / ELAPSED_TIME_IN_NS
>   AVG_MEM_WRITE_BANDWIDTH_IN_GBPS =3D MEM_BYTES_WR / ELAPSED_TIME_IN_NS
>=20
>   FREQ_IN_GHZ =3D CYCLES / ELAPSED_TIME_IN_NS
>   AVG_LATENCY_IN_CYCLES =3D RD_CUM_OUTS / RD_REQ
>   AVERAGE_LATENCY_IN_NS =3D AVG_LATENCY_IN_CYCLES / FREQ_IN_GHZ
>=20
> The bandwidth metrics use the mem_bytes_rd/mem_bytes_wr events of the
> Unified Coherence Fabric (UCF) PMU with source/destination filters:
>=20
>   lpm_ddr_bw, lpm_ddr_rd_bw, lpm_ddr_wr_bw: all sources to local CMEM.
>   lpm_ddr_loc_rd_bw, lpm_ddr_loc_wr_bw: local CPU and non-CPU sources to
> [ ... ]
> pmu-events/Build only runs arm64_metrics.py for the "arm" vendor models,
> so also run it for the "nvidia" vendor models to generate the Tegra410
> metrics.
>=20
> Signed-off-by: Chun-Tse Shao <ctshao@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260928175127.1032=
535-1-ctshao@google.com?part=3D1

