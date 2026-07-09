Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4630331328C
	for <linux-perf-users@vger.kernel.org>; Thu,  9 Jul 2026 14:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783608536; cv=none; b=WzbCPgjxM0RDjz91hRCadQnjyuhJyMrORq1/FWrHjAg37tDZZqOV4ZoaIqKwuyg3H+9wMEa7UmwLv/0/vizT8v3z+HQWD0rcsokAxBJD6WUVbMg4+zFpF2CWD3695c/MX9ILnzqPwWoRLedY6drkXpQEVuuub4kdDiqfwK9uUdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783608536; c=relaxed/simple;
	bh=XIOBwS2nTkpuTvPmPsCzCyhIFAAiA/Ss4SFKOU8DU2Q=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=S0skXskOfHaTCNChqP3WbRgNZVVw2cNr0zhwE8nRKLMBxQVjxAagB9MAZLk0jo5bOTK08Nol2Ywep5zo1ka9E7qCUbzUiGrXEjUuj0viG+hZquuxQaPeOMBNmRmAZG6Kf8WPh1Sb0D3am3JI+CxMs4CshNAL2XphZL55f9bEH98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fwJU2GgK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fwJU2GgK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0279B1F000E9;
	Thu,  9 Jul 2026 14:48:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783608535;
	bh=fpxQsnqOB+M8fVdIV3Wp08CZ2I7mxmEsKhlp2GV50Hk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=fwJU2GgKO5J32UsUVtMcDoxsWT1ZgJOyS5jdp4dP4Hr7IMYq0ig9SmfQBrhbcvcOG
	 RxXMSsIyLI0d2xsIM3DJA0X8rRp0rLgT3Vdbko1ZtmFrfRIXqod5oUFn8ku18OW4Sx
	 JFmuUjTEMSwaPNtY2EwD/pwewTXqx/MpFRE6n7X81uGIo0P7Pwi04SprhVJdiJtvVy
	 2BnHlcCnXPiGCFlWXSDOo6V51PBinCXcnK/JQwFRKyqyD+tOFz07I8DhZaXTnRdv9p
	 tiZUUyt6n+hi8zsZ4l9nScQiUsDq3lZ84ob3hEUbxQ5HQqIxW4n9Px2Hk6Ldqi5u40
	 sskOqGBteaOPA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/4] perf/arm_cspmu: Improve APMT-based PMU naming
Reply-To: sashiko-reviews@lists.linux.dev
To: "Robin Murphy" <robin.murphy@arm.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <74b46977582689be3ec7ba456809db89aad92bfe.1783605641.git.robin.murphy@arm.com>
References: <cover.1783605641.git.robin.murphy@arm.com>
 <74b46977582689be3ec7ba456809db89aad92bfe.1783605641.git.robin.murphy@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 09 Jul 2026 14:48:54 +0000
Message-Id: <20260709144855.0279B1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] The computed PMU identifier `id` is ignored during string formatti=
ng, resulting in incorrect PMU names. Furthermore, `apmt_node->inst_primary=
` (u64) is truncated when assigned to `id` (u32).
--

--- Patch [2]: [PATCH 2/4] perf/arm_cspmu: Improve APMT-based PMU naming ---
commit a5bff38f664770528aefdc9e26aafbe6dc541317
Author: Robin Murphy <robin.murphy@arm.com>

perf/arm_cspmu: Improve APMT-based PMU naming

This commit attempts to improve APMT-based PMU naming on ACPI systems. It
modifies arm_cspmu_get_name() to substitute arbitrary numbers with more
meaningful identifiers based on APMT definitions by using a switch statement
over the PMU type.

> diff --git a/drivers/perf/arm_cspmu/arm_cspmu.c b/drivers/perf/arm_cspmu/=
arm_cspmu.c
> index e6292021f653e..b6565eda8e521 100644
> --- a/drivers/perf/arm_cspmu/arm_cspmu.c
> +++ b/drivers/perf/arm_cspmu/arm_cspmu.c
> @@ -250,38 +250,44 @@ static const char *arm_cspmu_get_name(const struct =
arm_cspmu *cspmu)
[ ... ]
> +	case ACPI_APMT_NODE_TYPE_MC:
> +		id =3D apmt_node->id;
> +		break;
> +	case ACPI_APMT_NODE_TYPE_SMMU:
> +	case ACPI_APMT_NODE_TYPE_PCIE_ROOT:
> +		id =3D apmt_node->inst_primary;

[Severity: High]
Does this assignment truncate the 64-bit inst_primary value?

Looking at struct acpi_apmt_node, inst_primary is a u64, but the id variable
is defined as a u32. This might cause sysfs name collisions if the upper 32
bits are non-zero.

> +		break;
> +	case ACPI_APMT_NODE_TYPE_CACHE:
> +		id =3D apmt_node->inst_secondary;
> +		break;
> +	};
> =20
> -	return name;
> +	return devm_kasprintf(dev, GFP_KERNEL, "%s_%s_%u", PMUNAME,
> +			      arm_cspmu_type_str[pmu_type],
> +			      apmt_node->id);

[Severity: High]
Is it intentional to use apmt_node->id here instead of the local variable id
we just computed in the switch statement above?

Since the computed id is ignored, multiple PMUs of the same type sharing
the same apmt_node->id might result in identical names being generated.
Will this cause sysfs name collisions and driver registration failures?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1783605641.gi=
t.robin.murphy@arm.com?part=3D2
