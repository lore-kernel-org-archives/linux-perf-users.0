Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EABB0340DA4;
	Mon, 26 Jan 2026 16:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769445269; cv=none; b=Hm693k8nCSZuSQE2GV3bw4rCSVN4/xLU9rkLrPoTm+tZ05wzjj8B5L2PF1APRevAJPcTxSaiMIebw6Fm8UsP59fFnDt6GhFc1g/dEaarBBFKxXKOZmVjuZ0szUagjEWbx95MKPi5lCVYdkNEL3x3sn9iPS914yOVwnJrrffwGeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769445269; c=relaxed/simple;
	bh=BPZ2o64ACc8rHB5MyAqAflouWLP2/Jgd/OtqX5i7PPw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=f/O4Q+WFmn1EkWvB0/kaeENpeQY7Niz1FIWvwbV34mrms3uJxhxYxcReg0Fe6sYrhTAPdQe/CJCUEo89NCq6vcEinosjguTVCYqFGWZOeRK2vhMUt3XDMj5jrQsn9fKVr8pWu2LJyhlE1rSi3kukIjzvydPgldIWm8CGxzLXRX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C1965339;
	Mon, 26 Jan 2026 08:34:20 -0800 (PST)
Received: from [10.57.51.176] (unknown [10.57.51.176])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 02A783F5CA;
	Mon, 26 Jan 2026 08:34:24 -0800 (PST)
Message-ID: <b5f268cb-f9b9-4880-9fb5-b5f3a8eb9251@arm.com>
Date: Mon, 26 Jan 2026 16:34:22 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] perf/arm-ni: Don't crash in probing clock domains
 without a PMU instance
To: Baisheng Gao <baisheng.gao@unisoc.com>, Will Deacon <will@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
Cc: cixi.geng@linux.dev, hao_hao.wang@unisoc.com,
 linux-arm-kernel@lists.infradead.org, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20260126033029.7923-1-baisheng.gao@unisoc.com>
 <20260126033029.7923-2-baisheng.gao@unisoc.com>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <20260126033029.7923-2-baisheng.gao@unisoc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2026-01-26 3:30 am, Baisheng Gao wrote:
> The NULL pmusela pointer implies that current clock domain doesn't have
> a PMU instance. Return 0 for probing the next clock domain. Otherwise a
> kernel crash will happen.

Sorry, this doesn't add up with the diff below. All of the documentation 
says that the PMU is in integral part of the clock domain, and I can 
find no mention of any configuration parameter allowing it to be 
omitted. It is possible for the PMU registers to be inaccessible because 
Non-Secure access has not been enabled, but we account for that already.

> Signed-off-by: Baisheng Gao <baisheng.gao@unisoc.com>
> ---
>   drivers/perf/arm-ni.c | 8 +++++++-
>   1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/perf/arm-ni.c b/drivers/perf/arm-ni.c
> index 66858c65215d..53b656983da1 100644
> --- a/drivers/perf/arm-ni.c
> +++ b/drivers/perf/arm-ni.c
> @@ -526,6 +526,7 @@ static int arm_ni_init_cd(struct arm_ni *ni, struct arm_ni_node *node, u64 res_s
>   {
>   	struct arm_ni_cd *cd = ni->cds + node->id;
>   	const char *name;
> +	static atomic_t id;
>   
>   	cd->id = node->id;
>   	cd->num_units = node->num_components;
> @@ -562,6 +563,11 @@ static int arm_ni_init_cd(struct arm_ni *ni, struct arm_ni_node *node, u64 res_s
>   		case NI_TMNI:
>   		case NI_CMNI:
>   			unit->pmusela = arm_ni_get_pmusel(ni, unit_base);
> +			if (!unit->pmusela) {

...However this is not about the PMU node anyway; this would represent 
the FCU at an interface node being missing. Again, it's possible for 
access to the FCU itself to be restricted, per the test below, but the 
subfeature ID registers should always be readable, and per the "Should 
be impossible" comment in arm_ni_get_pmusel(), the nodes that can 
generate PMU events should always include an FCU.

Could you please clarify some more details of what the exact situation 
is that you're trying to deal with here?

> +				dev_info(ni->dev, "No have PMU %d\n", cd->id);
> +				devm_kfree(ni->dev, cd->units);
> +				return 0;
> +			}
>   			writel_relaxed(1, unit->pmusela);
>   			if (readl_relaxed(unit->pmusela) != 1)
>   				dev_info(ni->dev, "No access to node 0x%04x%04x\n", unit->id, unit->type);
> @@ -591,7 +597,7 @@ static int arm_ni_init_cd(struct arm_ni *ni, struct arm_ni_node *node, u64 res_s
>   	writel_relaxed(U32_MAX, cd->pmu_base + NI_PMCNTENCLR);
>   	writel_relaxed(U32_MAX, cd->pmu_base + NI_PMOVSCLR);
>   
> -	cd->irq = platform_get_irq(to_platform_device(ni->dev), cd->id);
> +	cd->irq = platform_get_irq(to_platform_device(ni->dev), atomic_fetch_inc(&id));

This is clearly wrong. Disregarding how badly it would go with multiple 
NI instances, even within a single instance I don';t think there's any 
obvious guarantee of a stable order. The firmware bindings are already 
defined, and that definition is not "the order in which a particular 
version of the Linux driver happens to parse things".

Thanks,
Robin.

>   	if (cd->irq < 0)
>   		return cd->irq;
>   

