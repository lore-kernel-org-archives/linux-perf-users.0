Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795188961;
	b=eN2wHu1xoC+JGdKp2D86WYRNCJ8+60TpNMEIIHpGvS12m0bKnPPnG+kAvE0rTxYS2Wlb
	 UFzhQqWgbQggg+0Opv4F1Gupp6RaFr1zK2KmYNGja2WKBinsBhs44I/fWtLgflhFSVrfp
	 j0iccizVEnXOFSCfMztYwe48ugn907Ri7KA8FP+3pOUGT7oNMq4ktZRC4OTPC5bVAJ5HR
	 9z8eRqtvR61P94YXt4N1pD+39bQk6OCBDXG5SSSApcc/QdzvXw+eQa8qUQ8pnCpcSYwHz
	 CVRRcCnchqJYcHCuar15docf8dxzmYFit3wUZeG9Y2n6Z8uO4T9HXTtELPY/bq4KVBA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795188961;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=eyKrry+VAkWvkZ8JRTKXdXArU4CUMR5fgSYJsZP+elo=;
	b=lqcSO4Ss/NKieer0PEGX21z2HI6z+N67JM9Wxrt0wrzfbIc3BqXp2X81YE/IjKr3cC2a
	 SqEMD9hOB+Nt7fmCXTPS2EwNV+RbY9hQLCGwnYHZmb9sswKkHnNWwInEyA/2p0dkS8S0Z
	 JkmS4d92Ymwf+EqOd5ePGbX1I1wlcqGgVQexoItV1JDO3/Ty2ZQ6Q/m87brQRg0szM1Ay
	 /xFIuEWdpBHABxU3uqSUyTkHQPpsRs7SodWRvYvlaAVUZSORHjh6ZqSC1YhlQ5Fh7tvk7
	 U/V18D2PSFJIBgNOPIcc5wQE782K6uej6W7lX6qag2BAfthKSx9IiCevM1KkcoeiIvQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=l5sTMaoM;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C712606A320
	for <linux-perf-users@vger.kernel.org>; Fri, 20 Nov 2026 15:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=l5sTMaoM
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDB741F000EF;
	Fri, 20 Nov 2026 15:36:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795188961;
	bh=eyKrry+VAkWvkZ8JRTKXdXArU4CUMR5fgSYJsZP+elo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=l5sTMaoMpQ/KYNRl5KUNBZjAee3hwKU1hC2UCtOmT8+vH4QfOBc4yyhTg7gxbFq2c
	 ijdVD9BMiLVEGMWqGL+SuLxw4I3tjGvynE4PF+A4JSfeAeb8fTcLIdDb9Norpkjv9D
	 UyKgFIJIeoEflxnH48PjTXYC/7RAsljefGA/VvkIlfPwebAvbaLyiVD2/VhD8cqQXF
	 irGO4QnHr58CzHLdTy14Sz0XH+DHnZMv75qEdsLApFCgDqPjsokDvbsYwtv2vUDXyY
	 4keiiiLGg7CbbRvVoUz/YM8MRbiA5F1TuZ3xrTC9HCXXKLQ0XH3yzMQGQpqo3gLHVW
	 4LV6gBkkGGy/Q==
Message-ID: <sashiko-outbox-225471@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 6/7] coresight: etm4x: Report whether the PMU counts
 the external outputs
Reply-To: sashiko-reviews@lists.linux.dev
To: "Amir Ayupov" <aaupov@fb.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <d9c953867b9ff40c20c8ddd52771bada2fa8a4b9.1795182850.git.aaupov@fb.com>
References: <cover.1795182850.git.aaupov@fb.com>
 <d9c953867b9ff40c20c8ddd52771bada2fa8a4b9.1795182850.git.aaupov@fb.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 20 Nov 2026 15:36:00 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Medium] coresight: etm4x: PMU coupling and 1-event match in
  etm4_pmu_counts_extout()
--

commit f0c882070427fa54aeaa9ce26f43db28f9511f4e
Author: Amir Ayupov <aaupov@fb.com>

coresight: etm4x: Report whether the PMU counts the external outputs

This commit checks at probe whether an ETE trace unit's CPU PMU implements
the TRCEXTOUTn events corresponding to its external outputs and exposes
the CS_CFG_MATCH_CAP_ETE_TRCEXTOUT capability match flag to CoreSight
system configuration.

> diff --git a/drivers/hwtracing/coresight/coresight-etm4x-core.c b/drivers=
/hwtracing/coresight/coresight-etm4x-core.c
> index af017bd8a5477..ecf2a6c945cf0 100644
> --- a/drivers/hwtracing/coresight/coresight-etm4x-core.c
> +++ b/drivers/hwtracing/coresight/coresight-etm4x-core.c
[ ... ]
> @@ -1399,6 +1401,29 @@ static void etm4_fixup_wrong_ccitmin(struct etmv4_=
caps *caps)
>  	}
>  }
> =20
> +/*
> + * Whether the PMU counts each external output of this trace unit as
> + * TRCEXTOUTn. The trace unit has an external output for each of its eve=
nts.
> + * Only ETE is checked: per its specification, an implemented TRCEXTOUTn=
 event
> + * counts external output n.
> + *
> + * Must run on the CPU that owns the trace unit.
> + */
> +static bool etm4_pmu_counts_extout(struct etmv4_drvdata *drvdata)
> +{
> +	int n;
> +
> +	if (!etm4x_is_ete(drvdata) || !drvdata->caps.nr_event)
> +		return false;
> +
> +	for (n =3D 0; n < drvdata->caps.nr_event; n++) {
> +		if (!pmuv3_event_implemented(ARMV8_PMUV3_PERFCTR_TRCEXTOUT0 + n))
> +			return false;
> +	}
> +
> +	return true;
> +}

[Severity: Medium]
As reported by Mike Leach on v2 [1], should ETM/ETE configuration matching
depend on the trace unit's own event resource registers (TRCIDR0 and
TRCIDR4) rather than querying CPU PMU TRCEXTOUTn support inside the ETMv4
driver?  Counting external outputs is a PMU feature that the PMU driver
validates when a trcextoutN event is opened, whereas coupling it into a
single ETM capability flag here still returns true when
drvdata->caps.nr_event =3D=3D 1 and only TRCEXTOUT0 exists.  On such an ETE,
event 1 (TRCEVENTCTL0R bits [15:8], driving external output 1) is RES0 and
TRCEXTOUT1 is not checked, yet a feature like extout_pulse in commit
"coresight: Add pmu_pulse/extout_pulse" that matches
CS_CFG_MATCH_CAP_ETE_TRCEXTOUT and unconditionally programs event 1 will
still match and load.

[1] https://lore.kernel.org/r/DB9PR08MB64752311F395D91F4FCBD0CB8C722@DB9PR0=
8MB6475.eurprd08.prod.outlook.com

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1795182850.gi=
t.aaupov@fb.com?part=3D6
