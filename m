Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEA5D382283;
	Wed,  8 Apr 2026 11:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775646939; cv=none; b=nGSuw9dzgvCqOvt5KHLIYiBNuhwxM3cPjencllBXk1qIk1B9CqfBLgFrpOE1QPMirv8QJrpd5z3K+APBNsQRDJO4Kj6Lz6v9W+XsoeiaTSfeoCWLRnU0wRItbXbhulZKx4tPo6Lv/O8Ve162UBo7Y1iZulUUHWimMyAGu6EVgA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775646939; c=relaxed/simple;
	bh=igR4tf9tvQIXuyv1BNumq6EyMN3XRctwsRk0w2FJVXM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FqtHYpy4oFOlsT+Y+f2NfS9z4hc4RA2e2qnHoIgK2xMjnYZ3tGU17vRFGbDbeeQvWs9YvYWbiioYwBySUCcUdGs0oLMCC/AepcOwVtwifs+XKUW4/i4cXWBEDrBNx4wLXMbb7eTMs6iaK8vpJrPfMSc7RdHNPfBhcOTBxQKpZMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=vmSjwA7D; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="vmSjwA7D"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7A5603161;
	Wed,  8 Apr 2026 04:15:31 -0700 (PDT)
Received: from [10.57.86.179] (unknown [10.57.86.179])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 65DE03F641;
	Wed,  8 Apr 2026 04:15:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1775646937; bh=igR4tf9tvQIXuyv1BNumq6EyMN3XRctwsRk0w2FJVXM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=vmSjwA7DZY/mrvzmHWRHTxc8XRQEDtjI/NSPo+eCaom6KcIlEdJNksO3Ug2p32frD
	 bmssI77hNNjyHZbmiXYcj6Z+SnjoN3yx4TSxtECLlBIK9kTaVScZIcg+SWNq9WCl9l
	 ei7sqx3WBZdUfzeW3vdvTzF2MEUrE172T8LpGmog=
Message-ID: <2c1a1694-9597-400d-b441-714225b5377b@arm.com>
Date: Wed, 8 Apr 2026 12:15:31 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] arm-smmu-v3: Add PMCG child support and update PMU
 MMIO mapping
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>, Will Deacon <will@kernel.org>,
 Joerg Roedel <joro@8bytes.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-perf-users@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
References: <20260408-smmu-perf-v1-0-d75dac96e828@nxp.com>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <20260408-smmu-perf-v1-0-d75dac96e828@nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2026-04-08 8:51 am, Peng Fan (OSS) wrote:
> This patch series adds proper support for describing and probing the
> Arm SMMU v3 PMCG (Performance Monitor Control Group) as a child node of
> the SMMU in Devicetree, and updates the relevant drivers accordingly.
> 
> The SMMU v3 architecture allows an optional PMCG block, typically
> associated with TCUs, to be implemented within the SMMU register
> address space. For example, mmu700 PMCG is at the offset 0x2000 of the
> TCU page 0.

But what's wrong with the existing binding? Especially given that it 
even has an upstream user already:

https://git.kernel.org/torvalds/c/aef9703dcbf8

> Patch 1 updates the SMMU v3 Devicetree binding to allow PMCG child nodes,
> referencing the existing arm,smmu-v3-pmcg binding.
> 
> Patch 2 updates the arm-smmu-v3 driver to populate platform devices for
> child nodes described in DT once the SMMU probe succeeds.
> 
> Patch 3 updates the SMMUv3 PMU driver to correctly handle MMIO mapping when
> PMCG is described as a child node. The PMCG registers occupy a sub-region
> of the parent SMMU MMIO window, which is already requested by the SMMU

That has not been the case since 52f3fab0067d ("iommu/arm-smmu-v3: Don't 
reserve implementation defined register space") nearly 6 years ago, 
where the whole purpose was to support Arm's PMCG implementation 
properly. What kernel is this based on?

Thanks,
Robin.

> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
> Peng Fan (3):
>        dt-bindings: iommu: arm-smmu-v3: Allow PMU child nodes
>        iommu/arm-smmu-v3: Populate PMU child devices from Devicetree
>        perf/arm-smmuv3: Avoid double-requesting shared SMMU MMIO for PMCG
> 
>   .../devicetree/bindings/iommu/arm,smmu-v3.yaml        | 10 ++++++++++
>   drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c           |  3 +++
>   drivers/perf/arm_smmuv3_pmu.c                         | 19 ++++++++++++++++---
>   3 files changed, 29 insertions(+), 3 deletions(-)
> ---
> base-commit: f3e6330d7fe42b204af05a2dbc68b379e0ad179e
> change-id: 20260408-smmu-perf-754367fe66c8
> 
> Best regards,

