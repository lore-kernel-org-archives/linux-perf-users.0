Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83663318EDF;
	Thu,  9 Jul 2026 15:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783611754; cv=none; b=iFmuTltyfqyE4B+C48g99FcrGbTJZnb3KxPitWP5nktkM15VI8CamNVSTVQVcA6Gao9lGaJKm9aSxIDSpjq3PaEeYN606K6h4AqKZb6OIiQ8JKtyqnxkU1kTJ8LPeKs2y3n561qPXsPX4BIFnp6UPAq0kQL4VJhOI8O1IIOOdnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783611754; c=relaxed/simple;
	bh=YAA2fx5zFRsVlrkwp8UcykQVkYGpFM2+T2lzZKGQWJ4=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=iL9onM0uytBWVPMvFKXiBlQGJclUFiY3K3RH7fhni8T3njXkOe+QZwkr80xtUL9HUE26aLOZA5G0/W/M0HPGtGPPBxk/ExVZffmiZXDVQa1FiUnamd2woYtdK9q88C98y6VyYJfXRMu1XliZk0iSepDniXuELtyq1SDtdvF5uKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=Psx/7OA2; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="Psx/7OA2"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8E78D16A3;
	Thu,  9 Jul 2026 08:42:27 -0700 (PDT)
Received: from [10.2.212.23] (e121345-lin.cambridge.arm.com [10.2.212.23])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E67543FC81;
	Thu,  9 Jul 2026 08:42:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1783611751; bh=YAA2fx5zFRsVlrkwp8UcykQVkYGpFM2+T2lzZKGQWJ4=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=Psx/7OA2vD3b1mJyLdBpmulT0bfo2nFfbLBgurMuzyvXeu+1uJHmqbCPBwIgt3FHq
	 G+KGmCP6lN5yu7TNZM4GQojbR3u5s2KieIlpKmbibIklq8YskTDDOKsZzaCQq25yUN
	 Uy/Y11eLb+eN+DR1cmxTbw9ifnmb3iA6cE8uO684=
Message-ID: <1fa139a6-fa41-4c25-aaf8-b781d695f476@arm.com>
Date: Thu, 9 Jul 2026 16:42:29 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] perf/arm_cspmu: Improve APMT-based PMU naming
From: Robin Murphy <robin.murphy@arm.com>
To: will@kernel.org, mark.rutland@arm.com, catalin.marinas@arm.com
Cc: ilkka@os.amperecomputing.com, bwicaksono@nvidia.com,
 linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-perf-users@vger.kernel.org
References: <cover.1783605641.git.robin.murphy@arm.com>
 <74b46977582689be3ec7ba456809db89aad92bfe.1783605641.git.robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <74b46977582689be3ec7ba456809db89aad92bfe.1783605641.git.robin.murphy@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 09/07/2026 3:39 pm, Robin Murphy wrote:
> On ACPI systems, it has not actually been possible for userspace to
> reliably tell which PMU corresponds to which APMT entry for types
> other than "ACPI device" - the evidence trail only leads from the
> arbitrarily-numbered PMU device to its arbitrarily-numbered parent
> platform device that has no distinguishing features either.
> 
> While we've now improved the platform device creation to associate the
> actual APMT unique ID, we may as well also tweak the PMU devices to
> substitute the arbitrary number with a different arbitrary number that
> might be more directly meaningful based on the APMT definitions.
> 
> We don't have an equivalent for Devicetree, but in that case the
> platform devices are at least identifiable via their sysfs-visible
> of_node.
> 
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> ---
>   drivers/perf/arm_cspmu/arm_cspmu.c | 36 +++++++++++++++++-------------
>   1 file changed, 21 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/perf/arm_cspmu/arm_cspmu.c b/drivers/perf/arm_cspmu/arm_cspmu.c
> index 80fb314d5135..0570be74d11f 100644
> --- a/drivers/perf/arm_cspmu/arm_cspmu.c
> +++ b/drivers/perf/arm_cspmu/arm_cspmu.c
> @@ -250,38 +250,44 @@ static const char *arm_cspmu_get_name(const struct arm_cspmu *cspmu)
>   	struct device *dev;
>   	struct acpi_apmt_node *apmt_node;
>   	u8 pmu_type;
> -	char *name;
>   	char acpi_hid_string[ACPI_ID_LEN] = { 0 };
> -	static atomic_t pmu_idx[ACPI_APMT_NODE_TYPE_COUNT] = { 0 };
> +	static atomic_t pmu_idx;
> +	u32 id;
>   
>   	dev = cspmu->dev;
>   	apmt_node = arm_cspmu_apmt_node(dev);
>   	if (!apmt_node)
>   		return devm_kasprintf(dev, GFP_KERNEL, PMUNAME "_%u",
> -				      atomic_fetch_inc(&pmu_idx[0]));
> +				      atomic_fetch_inc(&pmu_idx));
>   
>   	pmu_type = apmt_node->type;
> -
> -	if (pmu_type >= ACPI_APMT_NODE_TYPE_COUNT) {
> +	switch (pmu_type) {
> +	default:
>   		dev_err(dev, "unsupported PMU type-%u\n", pmu_type);
>   		return NULL;
> -	}
> -
> -	if (pmu_type == ACPI_APMT_NODE_TYPE_ACPI) {
> +	case ACPI_APMT_NODE_TYPE_ACPI:
>   		memcpy(acpi_hid_string,
>   			&apmt_node->inst_primary,
>   			sizeof(apmt_node->inst_primary));
> -		name = devm_kasprintf(dev, GFP_KERNEL, "%s_%s_%s_%u", PMUNAME,
> +		return devm_kasprintf(dev, GFP_KERNEL, "%s_%s_%s_%u", PMUNAME,
>   				      arm_cspmu_type_str[pmu_type],
>   				      acpi_hid_string,
>   				      apmt_node->inst_secondary);
> -	} else {
> -		name = devm_kasprintf(dev, GFP_KERNEL, "%s_%s_%d", PMUNAME,
> -				      arm_cspmu_type_str[pmu_type],
> -				      atomic_fetch_inc(&pmu_idx[pmu_type]));
> -	}
> +	case ACPI_APMT_NODE_TYPE_MC:
> +		id = apmt_node->id;
> +		break;
> +	case ACPI_APMT_NODE_TYPE_SMMU:
> +	case ACPI_APMT_NODE_TYPE_PCIE_ROOT:
> +		id = apmt_node->inst_primary;
> +		break;
> +	case ACPI_APMT_NODE_TYPE_CACHE:
> +		id = apmt_node->inst_secondary;
> +		break;
> +	};
>   
> -	return name;
> +	return devm_kasprintf(dev, GFP_KERNEL, "%s_%s_%u", PMUNAME,
> +			      arm_cspmu_type_str[pmu_type],
> +			      apmt_node->id);

Seems I did forget this when I realised the instance fields could be 
useful and added the local "id" variable. The rest of the Sashiko noise 
is mostly nonsense.

Cheers,
Robin.

>   }
>   
>   static ssize_t arm_cspmu_cpumask_show(struct device *dev,

