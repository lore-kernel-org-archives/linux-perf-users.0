Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B94F2EEE9D;
	Mon,  3 Aug 2026 12:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785758678; cv=none; b=dYdZxAegq/IZwSiVmwPJrVqmNPPmzYh3KXwV+5ZRQz/OAdvBHeQ1EkGXqqoXd5GjD/J/lHdl1twjfYWqc9R2jalnZIkTDymj8MuVWHQfkkEhJELIUNrGG87XziY3kAYxmEsTKei2Oeb+eyz/4WA1MyDsM1SuRzPaC9isyGTG9XE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785758678; c=relaxed/simple;
	bh=nb6caUVzJDgIDllZO2UI73x8UTtB508wfhnB9z+8GkA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=a4V2gJyXLjE5C57PdsKqOXUFA3aeR/2XvRH9nzpT2/6mUF84WeTLaUC9bE8+qQmgnY1q3Keoi9A7PsbZjBW3AgZulbikdeKiMfs+6tnNvJ10zSKbLfmv9Zy+n7NM6Db3yVkuwg0G4HebHJtGBBF0JO1+Mas6BBTv0ZHP4qBv8JM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=WIuZPVSB; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="WIuZPVSB"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C9370143D;
	Mon,  3 Aug 2026 05:04:31 -0700 (PDT)
Received: from [10.2.212.23] (e121345-lin.cambridge.arm.com [10.2.212.23])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D419F3F66F;
	Mon,  3 Aug 2026 05:04:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1785758675; bh=nb6caUVzJDgIDllZO2UI73x8UTtB508wfhnB9z+8GkA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=WIuZPVSBjHW1yzZxcyQx5Tkm5xmSb+pKRI+efAiiXAoVWYD+hjUqnUMr0A0k+m3J5
	 c64HBGNA5geKVv4qwbk+oW5Q9i5+RyQVR+1FYmyBjY99Qai8qlvhfb4LRz1Pp54X+g
	 UkoHYA3EyQHeQXkzna2/hkRVIwtz8jdCpr6C6WUI=
Message-ID: <a4a807e6-b477-40c3-ac42-2bef8dd82d7e@arm.com>
Date: Mon, 3 Aug 2026 13:04:33 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/9] perf/cxl: Split the MSI vector out of info->irq
To: Dave Jiang <dave.jiang@intel.com>, linux-cxl@vger.kernel.org,
 linux-perf-users@vger.kernel.org
Cc: jic23@kernel.org, will@kernel.org, mark.rutland@arm.com, dave@stgolabs.net
References: <20260731232827.401447-1-dave.jiang@intel.com>
 <20260731232827.401447-5-dave.jiang@intel.com>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <20260731232827.401447-5-dave.jiang@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 01/08/2026 12:28 am, Dave Jiang wrote:
> info->irq means two different things depending on how far probe has got.
> cxl_pmu_parse_caps() sets it to the MSI/MSI-X message number from the CPMU
> Capability register. cxl_pmu_probe() passes that to pci_irq_vector() and
> then overwrites it with the Linux virq, which is what the hotplug callbacks
> hand to irq_set_affinity().
> 
> Give the message number its own field. No functional change.

Thanks, this makes it much less confusing;

Reviewed-by: Robin Murphy <robin.murphy@arm.com>

If the fix itself was just the comparison operator then I'd suggest 
folding it in so as to avoid extra backporting dependencies/conflicts, 
but it sounds like we might have a corner case where 0 may still mean 
"no IRQ", so maybe sort that first then put this refactoring on top?

Cheers,
Robin.

> Assisted-by: Claude:claude-opus-4-8
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> ---
> v3:
> - New patch
> ---
>   drivers/perf/cxl_pmu.c | 9 +++++----
>   1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/perf/cxl_pmu.c b/drivers/perf/cxl_pmu.c
> index 3511d049aea4..56e6ae7bebf7 100644
> --- a/drivers/perf/cxl_pmu.c
> +++ b/drivers/perf/cxl_pmu.c
> @@ -106,6 +106,7 @@ struct cxl_pmu_info {
>   	int on_cpu;
>   	struct hlist_node node;
>   	bool filter_hdm;
> +	int msi_vec;
>   	int irq;
>   };
>   
> @@ -143,9 +144,9 @@ static int cxl_pmu_parse_caps(struct device *dev, struct cxl_pmu_info *info)
>   
>   	info->filter_hdm = FIELD_GET(CXL_PMU_CAP_FILTERS_SUP_MSK, val) & CXL_PMU_FILTER_HDM;
>   	if (FIELD_GET(CXL_PMU_CAP_INT, val))
> -		info->irq = FIELD_GET(CXL_PMU_CAP_MSI_N_MSK, val);
> +		info->msi_vec = FIELD_GET(CXL_PMU_CAP_MSI_N_MSK, val);
>   	else
> -		info->irq = -1;
> +		info->msi_vec = -1;
>   
>   	/* First handle fixed function counters; note if configurable counters found */
>   	for (i = 0; i < info->num_counters; i++) {
> @@ -874,10 +875,10 @@ static int cxl_pmu_probe(struct device *dev)
>   		.capabilities = PERF_PMU_CAP_NO_EXCLUDE,
>   	};
>   
> -	if (info->irq <= 0)
> +	if (info->msi_vec <= 0)
>   		return -EINVAL;
>   
> -	rc = pci_irq_vector(pdev, info->irq);
> +	rc = pci_irq_vector(pdev, info->msi_vec);
>   	if (rc < 0)
>   		return rc;
>   	irq = rc;

