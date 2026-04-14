Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A77C3B9DAC
	for <linux-perf-users@vger.kernel.org>; Tue, 14 Apr 2026 11:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776166084; cv=none; b=JZTQK9FatiF3L4a63C+ccgB+O9VHN2O/Aqjitlv0CwBaLCeVeYgBY/Jhv3nbfGBD4eFuQGUsvfQEMgCliKO3zBuRJ8PaTBF1OF9BQ5psPZnDcXhcd7EL274gblT/3SZLreZBJ1WxaC8IYs3t6LxL8n+mrthxnldFYnvSngCOLNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776166084; c=relaxed/simple;
	bh=38cDj/oWajCq5xpmhSqZBnUzfS29ke3jW3nFqfGOgA4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=FSUQLLzoJAgDTAakMDmTwq7d0v3mXSstk8Oq22OAQNVXR4+OvttCbNn6vRP1hEpvEc4qU2dsp2wwH2jQWCeiJgum8aMboFYEx0Jltb7Mh0SpPmMBfuyMI/a8nio+A+RJxfQr0x0Op+oVgpF3bIoDPw2WBm5y2DGsAf6p8wreifo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TaiGzrzb; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TaiGzrzb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4054CC19425;
	Tue, 14 Apr 2026 11:28:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776166084;
	bh=38cDj/oWajCq5xpmhSqZBnUzfS29ke3jW3nFqfGOgA4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=TaiGzrzbIILizKODa4J54x7IiMZX3Ld5fZ0Vt024XdJx/mgm8TEBYEGWoJzw5s6N7
	 nG2ZapVVkL2cPGIEZz7npGy/yI5vEtkC79KcSMSihmxQBP3eaRpSlkVPgRurbjOIzL
	 8r6D0Sgym+tnHzwJI4gUyoirkV+Vi+ac8b4b75vNgfED6jkqnQZCBSd9tAVw1qsuwM
	 i/nDuHPC4hLE5jFY0guSXNvlCp/Y3t7ya4BF8TWkd1mW11zgxz1VsjBxrCGi/v3fdP
	 RJLm/vtBM6+c4fVCdXuJdLjuMdbJ4IeuFBIKW3DsRrqpFmu7MCmTvBRHRg2FK539cn
	 5G7Mce5HONpVA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 2/6] perf arm_spe: Handle missing CPU IDs
Reply-To: sashiko@lists.linux.dev
To: "James Clark" <james.clark@linaro.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260414-james-spe-impdef-decode-v3-2-63baf9c893b1@linaro.org>
References: <20260414-james-spe-impdef-decode-v3-2-63baf9c893b1@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 14 Apr 2026 11:28:03 +0000
Message-Id: <20260414112804.4054CC19425@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Sashiko AI review found 1 potential issue(s):
- [High] Unconditional `pr_err()` on the per-sample hot path causes severe =
log spam and performance degradation.
--

commit be72d9e89c04e5b03be3ccecb3b4bb5f759902c7
Author: James Clark <james.clark@linaro.org>

perf arm_spe: Handle missing CPU IDs

This commit avoids undefined behavior by checking for a null pointer before
calling strtol() during CPU ID lookup. It also adds an error message when
SPE decoding continues with reduced functionality due to a missing MIDR.

> diff --git a/tools/perf/util/arm-spe.c b/tools/perf/util/arm-spe.c
> --- a/tools/perf/util/arm-spe.c
> +++ b/tools/perf/util/arm-spe.c
> @@ -982,16 +982,23 @@ static int arm_spe__get_midr(struct arm_spe *spe, i=
nt cpu, u64 *midr)

[ ... ]

>  	metadata =3D arm_spe__get_metadata_by_cpu(spe, cpu);
>  	if (!metadata)
> -		return -EINVAL;
> +		goto err;
> =20
>  	*midr =3D metadata[ARM_SPE_CPU_MIDR];
>  	return 0;
> +
> +err:
> +	pr_err("Failed to get MIDR for CPU %d\n", cpu);
> +	return -EINVAL;
>  }

Will this unconditional pr_err() cause severe log spam and performance issu=
es
on the per-sample hot path?

Since arm_spe__get_midr() is invoked continuously via arm_spe__synth_ds(),
there are scenarios where this error path is hit frequently. For example,
when processing a per-thread trace (where cpu is -1) on a heterogeneous
system, arm_spe__get_metadata_by_cpu() returns NULL until a context packet
provides the CPU ID.

In these cases, printing an error for every single sample could flood the
output with millions of messages. Could this be mitigated by using
pr_err_once() or rate-limiting the message instead?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260414-james-spe-=
impdef-decode-v3-0-63baf9c893b1@linaro.org?part=3D2
