Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 798EF405C4D
	for <linux-perf-users@vger.kernel.org>; Sun, 17 May 2026 12:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779019968; cv=none; b=BlZXRInHyh/nExgMmYUYhUprlMwt0Z6KF19NllbSWS1byZSfRRjzXfA3rIP9o2Gq0tmn1g5HVNMfjPmpDrty/QpmP0yaacipMhVJ1ZCR5OxaUtaYXhlWmJLL1SkT8HekKqWm5Xc93epQ2ZDN6ihdjWvrBizB7+p9fgcnCATLVAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779019968; c=relaxed/simple;
	bh=UOvGlG/rrVR+zu+U00Id5jk+v803Ye4C2TXIQlBQBS4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=HI73OlcrBIrgZ//N8UDpPgSSnRAfkN6PtUOikmQg6U/2GIBpF5pZKEzVZByyUvkMXuguQQmkK4iWn4hGGWB6t6kGHJbSWza9f0ZeoP1f8dwgDPFh+avt0VuMnhhXPNEzXq8e+3OBZ4xoIMMmJQW9xrciN0HBD2TRspkmeY7+M1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gnLBpjIw; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gnLBpjIw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E501C2BCB0;
	Sun, 17 May 2026 12:12:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779019968;
	bh=UOvGlG/rrVR+zu+U00Id5jk+v803Ye4C2TXIQlBQBS4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=gnLBpjIwVk8pNO7HfvSCUxdVlCBvKXxbmIv0t++CBpOQz8t7T/MpAJTAWZJ7md6qj
	 Uo558l9FSDHrshSroNnbTqR3NPRWriYDX0teXEvenRzWLDyp2BQutQK072t3qeZgoL
	 ZNEmxsI/2eOodUSe4CKosOuDu9y/FydppVg8E00yPjVw3UekgsDWUTuCVokz1kvTXz
	 7WHPzStnrZSq1qJE523nmnD5nA3rYnLwdrOJEMBZINfxVjxWkN3TMo0ZAPhuE1+JFV
	 CaSma4o/KOgwY6bAwcUK+jqaAj1Slp3eC3SNjuQaUSHghcZwSIL9t8Df1I0ZxGcTVy
	 RWdOV2FhWsLsg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] x86/events/amd/iommu: Fix cpumask of IOMMU events
Reply-To: sashiko-reviews@lists.linux.dev
To: "Vasant Hegde" <vasant.hegde@amd.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260517114026.6817-1-vasant.hegde@amd.com>
References: <20260517114026.6817-1-vasant.hegde@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 17 May 2026 12:12:47 +0000
Message-Id: <20260517121248.0E501C2BCB0@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] PMU initialization fails for IOMMUs located on NUMA nodes without =
online CPUs.
--

commit ef1363d0a37870d7cf1f1095cd3ebf42cc5a8bdc
Author: Vasant Hegde <vasant.hegde@amd.com>

x86/events/amd/iommu: Fix cpumask of IOMMU events

This commit changes the IOMMU PMU cpumask from a single global mask to a
per-IOMMU mask based on the NUMA node of the IOMMU, allowing per-socket
performance counter collection.

> diff --git a/arch/x86/events/amd/iommu.c b/arch/x86/events/amd/iommu.c
> --- a/arch/x86/events/amd/iommu.c
> +++ b/arch/x86/events/amd/iommu.c
[ ... ]
> @@ -440,6 +445,20 @@ static __init int init_one_iommu(unsigned int idx)
>  		return -EINVAL;
>  	}
> =20
> +	dev =3D amd_iommu_idx_to_dev(idx);
> +	node =3D dev ? dev_to_node(dev) : NUMA_NO_NODE;
> +	if (node !=3D NUMA_NO_NODE)
> +		cpu =3D cpumask_any_and(cpumask_of_node(node), cpu_online_mask);

If the IOMMU resides on a CPU-less NUMA node (like a PCIe expansion switch
or a memory-only CXL node), or if all CPUs on that node are currently
offline, will cpumask_any_and() return a value greater than or equal to
nr_cpu_ids?

> +	else
> +		cpu =3D cpumask_any(cpu_online_mask);
> +
> +	if (cpu >=3D nr_cpu_ids) {
> +		pr_warn("Failed to find online CPU for IOMMU %d.\n", idx);
> +		kfree(perf_iommu);
> +		return -ENODEV;
> +	}

Could this cause PMU initialization to fail for IOMMUs on CPU-less nodes?

Since AMD IOMMU performance counters are accessed via MMIO space, they can
be driven by any CPU in the system. Would it be better to fall back to
cpumask_any(cpu_online_mask) instead of returning -ENODEV when a local CPU
is not available?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260517114026.6817=
-1-vasant.hegde@amd.com?part=3D1
