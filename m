Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B03D30C153
	for <linux-perf-users@vger.kernel.org>; Fri, 15 May 2026 18:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778869386; cv=none; b=Mkz5FsDWwO1q65b3pBU4/lft49sOZd1ZY0QyawHfOF2HUVF0gn/xJEVkqSj9lzUifSE6HPLo9fZG5CuZwhCiVuo21PuYC7QmUnTsh+hzQeO11fbKz+wadhyq70Fj1xDJUDfDTfL7YFn3NcKOpl0iXgRtMcpsXSnnorzEKS6Wex8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778869386; c=relaxed/simple;
	bh=PsACD621iPoUcaTq4bbkj/9tZGxdaaA7I1YoWLwDtHQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=MYcIWHrSkPZRxfL8gn9hrcfKDOG5Y69kg3lbwoo0/HurW2un8tlHDKOskw5anan2JMafWJpKOQuaQSvlWqIM33F/Idh1iWpSQRB0NL3ebFq6xoCzfREZU1xosc6tMzwtgwVU4Y23+M44+y8O4ID0UkVQgHEfDRV2cPLzxqwdlS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qFzUkZZX; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qFzUkZZX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D9AEC2BCB0;
	Fri, 15 May 2026 18:23:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778869385;
	bh=PsACD621iPoUcaTq4bbkj/9tZGxdaaA7I1YoWLwDtHQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=qFzUkZZXZWWp3Jay59Pq7bpdVsHSnp7LdiPEDyZRW+TBeFaU3Hft+1BP1er6NP1Iz
	 hvMNXSN8x+COgDhh2D/40U3swk7ZZaf8ljatFht2ORCHV39O/m1DwBAAtALCP0s4dv
	 pGgwPcYyrxXEkXB7rQ2XOBl4m/5tPuS8AcZQcRMSZvg3qLsR1h/Esmn91YLe/MsfPd
	 x2cc/s12RKB8qyiNYybBn5Y3hxC58bYmiyvxkSpbiVqfWl+84s6bnfdsEIk7lnMmTT
	 nm8j27/1e7TOeeF4MwsfVBoRmsGoK/eLa1Es6t04fNjn9FFjrWPEn/xyAt+DCHgQjD
	 Sv3bO5Rb/sRrg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 2/2] perf pmu intel: Adjust cpumasks for sub-NUMA
 clusters on Sapphire Rapids and Emerald Rapids
Reply-To: sashiko-reviews@lists.linux.dev
To: "Chun-Tse Shao" <ctshao@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260515172710.428474-2-ctshao@google.com>
References: <20260515172710.428474-2-ctshao@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 15 May 2026 18:23:04 +0000
Message-Id: <20260515182305.8D9AEC2BCB0@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Missing IMC cpumask adjustment and silent failure for SNC4 confi=
gurations on Sapphire Rapids.
--

commit 312ea8a1894ae6a4d9318072afccaf0abbbb29bd
Author: Chun-Tse Shao <ctshao@google.com>

perf pmu intel: Adjust cpumasks for sub-NUMA clusters on Sapphire Rapids an=
d Emerald Rapids

This commit adjusts the cpumasks for sub-NUMA clusters on Sapphire Rapids
and Emerald Rapids processors. It updates the detection logic and the
mapping arrays to support SNC configurations for these architectures.

> diff --git a/tools/perf/arch/x86/util/pmu.c b/tools/perf/arch/x86/util/pm=
u.c
> index b8fab260c4238..09caec0a32a57 100644
> --- a/tools/perf/arch/x86/util/pmu.c
> +++ b/tools/perf/arch/x86/util/pmu.c
[ ... ]
> @@ -142,23 +146,43 @@ static int uncore_imc_snc(struct perf_pmu *pmu)
>  	// Compute the IMC SNC using lookup tables.
>  	unsigned int imc_num;
>  	int snc_nodes =3D snc_nodes_per_l3_cache();
[ ... ]
> +	/* snc_map is not inited yet. We only look up once to avoid expensive o=
perations. */
> +	if (!snc_map) {
> +		switch (snc_nodes) {
> +		case 2:
[ ... ]
> +			break;
> +		case 3:
> +			snc_map =3D snc3_map;
> +			snc_map_len =3D ARRAY_SIZE(snc3_map);
> +			break;
> +		default:
> +			/* Error or no lookup support for SNC with >3 nodes. */
> +			return 0;

Sapphire Rapids natively supports 4-way sub-NUMA clustering, which would
make snc_nodes evaluate to 4. Does this regression silently skip IMC
cpumask adjustments for SNC4 configurations?

Because this default case returns 0 immediately, it entirely bypasses the
newly added warning block below.

> +		}
> +
> +		if (!snc_map) {
> +			pr_warning("Unexpected: can not find snc map config");
> +			return 0;
> +		}

Could this leave users unaware that the IMC PMUs are unmapped, even though
CHA PMUs are correctly adjusted for SNC4 elsewhere?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260515172710.4284=
74-1-ctshao@google.com?part=3D2
