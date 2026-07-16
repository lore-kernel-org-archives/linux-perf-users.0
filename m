Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF819405F7
	for <linux-perf-users@vger.kernel.org>; Thu, 16 Jul 2026 15:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784214921; cv=none; b=X5exEhIBOU4GJIG9+SsDM2iioz/KTnf4qbA5yU1LM/ufsTTr18NTFl48zfGtsmaoEIb/XfJdLBt2ZZEXqHpGonKn68ssqJnsZGpv2T5FE4aGVwmukAwZomnND0UAz2KXkM/ABNBcjK1QFFzUIGCkNyCpXJUK+zJz/d1AwYHHRTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784214921; c=relaxed/simple;
	bh=OJHr0UTdBEynuBDC3vRd9j9r+m7vv/CxOdaSdaAVS8I=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=TSN3OEyZeeG1laAYc66G1vBs9lUpjTPOUuevL2zM9C4qNvJO8Lq9xrrpY3yy7fzv96+usaMzutj/RViRD8RLj4Py6dwhg7ef7AewwlXQxO92e1dYR9C5Dj/yUEaZ6Yf/xFQOgVvszVNFUdQAHtPMrwTANBvKuqFZSNzPvUb0v/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BDleAxhQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BDleAxhQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 505091F000E9;
	Thu, 16 Jul 2026 15:15:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784214920;
	bh=2wSox7UgMg8OuQiNdLQ7UokF2qyezYbNnW0UKMng3uk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=BDleAxhQZ32qgXoqSlkXWCW3RPbJi+RE2azdF8KB7QZcX/IcIH0iNC3ftgbWAvboc
	 72ES42FcoyWOe5AKcQtyjIsNVzJw46KWY8e588aBrI67Jb+890h6qs+jtp+/AaiPtP
	 Xoz1c/aXXEUen8Siu6cS96qek68Mu+8tDtniApWFoxWGrDnSmt+ti/MxmOG/unbJvD
	 BiAHK/jXAgp26Jq5xa/ZzNJ8pQBJFPcKRrgy7hFl2zt2C16poIoE+tGdb7csls7D5t
	 1nA9+jzOT9kapMiVQ5FREsLJk8h+Qrl5yRuPfS6pCWhbRnzkv1OegK3J6r002UO1AY
	 I840uIP0HN/bg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/4] perf/arm_cspmu: Improve APMT-based PMU naming
Reply-To: sashiko-reviews@lists.linux.dev
To: "Robin Murphy" <robin.murphy@arm.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <8f260d150da4fd8acbe0a070033c9b9e045fced2.1784213435.git.robin.murphy@arm.com>
References: <cover.1784213435.git.robin.murphy@arm.com>
 <8f260d150da4fd8acbe0a070033c9b9e045fced2.1784213435.git.robin.murphy@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 16 Jul 2026 15:15:19 +0000
Message-Id: <20260716151520.505091F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Naming PMUs based solely on their target component's instance ID=
 can cause sysfs name collisions if a single hardware component has multipl=
e independent PMUs.
--

--- Patch [2]: [PATCH v2 2/4] perf/arm_cspmu: Improve APMT-based PMU naming=
 ---
commit c464ddb014cc8172e2e952ddcc892f142c6f5839
Author: Robin Murphy <robin.murphy@arm.com>

perf/arm_cspmu: Improve APMT-based PMU naming

This commit tweaks the PMU devices to substitute the arbitrary number with a
more meaningful one based on the APMT definitions. On ACPI systems, it asso=
ciates
the actual APMT unique ID rather than relying on arbitrarily-numbered platf=
orm
devices.

> diff --git a/drivers/perf/arm_cspmu/arm_cspmu.c b/drivers/perf/arm_cspmu/=
arm_cspmu.c
> index e6292021f653e..e3aaf587e6e54 100644
> --- a/drivers/perf/arm_cspmu/arm_cspmu.c
> +++ b/drivers/perf/arm_cspmu/arm_cspmu.c

[ ... ]

> @@ -250,38 +250,43 @@ static const char *arm_cspmu_get_name(const struct =
arm_cspmu *cspmu)
>  	struct device *dev;
>  	struct acpi_apmt_node *apmt_node;
>  	u8 pmu_type;
> -	char *name;
>  	char acpi_hid_string[ACPI_ID_LEN] =3D { 0 };
> -	static atomic_t pmu_idx[ACPI_APMT_NODE_TYPE_COUNT] =3D { 0 };
> +	static atomic_t pmu_idx;
> +	u32 id;

[ ... ]

> +	case ACPI_APMT_NODE_TYPE_MC:
> +		id =3D apmt_node->id;
> +		break;
> +	case ACPI_APMT_NODE_TYPE_SMMU:
> +	case ACPI_APMT_NODE_TYPE_PCIE_ROOT:
> +		id =3D apmt_node->inst_primary;
> +		break;

[Severity: Medium]
Will this lead to a sysfs name collision if a single hardware component has
multiple independent PMUs?

If multiple PMUs target the same component (like separate PMUs for an SMMU =
TCU
and TBUs), they will get identical names since apmt_node->inst_secondary is
ignored here. This could cause perf_pmu_register() to fail with -EEXIST dur=
ing
device probe, preventing all but the first PMU on the hardware component fr=
om
being registered.

> +	case ACPI_APMT_NODE_TYPE_CACHE:
> +		id =3D apmt_node->inst_secondary;
> +		break;
> +	};
> =20
> -	return name;
> +	return devm_kasprintf(dev, GFP_KERNEL, "%s_%s_%u", PMUNAME,
> +			      arm_cspmu_type_str[pmu_type], id);
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1784213435.gi=
t.robin.murphy@arm.com?part=3D2
