Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD7A22CCB9;
	Thu, 30 Jul 2026 12:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785413934; cv=none; b=u/yvznA2pms3e/qHpG9vHzJUE2eYJInJ3lG4eZjxhPXxSojgCYjXcYbF4+Set5Nh33i3OqCeS7ZXNewTvaPRZNGjtULusG7/I3fweVqcmT6n2AR+nn6eZ71px76RPswgBUMNvs6F5RlJd+Qcc3/B7bXUAT7oKv/DswlvXXL628I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785413934; c=relaxed/simple;
	bh=7o8X9+FhnoQC+4+arrsGf8hYd7muiTjQ0XO2z3+Wlc4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=N+MXTnIAKioNpVBtwcMj783YEypCdb8+sMh/m1hZHu/fbujpPgxv2DsOsykU/Ibw+3/uRcqKan/LBOXzv/rXxDU8U7X4B2O7tEoYO6hlRBzh6eO3xkA1usz7sFK1JmqoYIyBRamitjGG26THaV3j4iJDIzhtrhugb7G6mvAKMdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=YCKvCnda; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="YCKvCnda"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 04C4F1684;
	Thu, 30 Jul 2026 05:18:48 -0700 (PDT)
Received: from [10.2.212.23] (e121345-lin.cambridge.arm.com [10.2.212.23])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0B8A63F86F;
	Thu, 30 Jul 2026 05:18:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1785413932; bh=7o8X9+FhnoQC+4+arrsGf8hYd7muiTjQ0XO2z3+Wlc4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=YCKvCndaZxIV5bnAD2+WcOEcJVvA0JazA8jCz6PQZQU+GIUKTx2IECEDpeKUXINtZ
	 mtkEf0cnAG4KOgy490KK1Q4lvQMvgPJfigAgcmgFgTkq9nm87bwW/VExXZYX1s0R9A
	 ybHp2MkTCRW+LcFzgROxcIRDzVkTo/OdfkEZn/3U=
Message-ID: <5196c172-9ef3-43ae-98df-57a95427a00a@arm.com>
Date: Thu, 30 Jul 2026 13:18:42 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/9] perf/cxl: Accept an overflow interrupt on MSI
 message number 0
To: Dave Jiang <dave.jiang@intel.com>, linux-cxl@vger.kernel.org,
 linux-perf-users@vger.kernel.org
Cc: jic23@kernel.org, will@kernel.org, mark.rutland@arm.com,
 dave@stgolabs.net, sashiko-bot@kernel.org
References: <20260729145555.3919550-1-dave.jiang@intel.com>
 <20260729145555.3919550-5-dave.jiang@intel.com>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <20260729145555.3919550-5-dave.jiang@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 29/07/2026 3:55 pm, Dave Jiang wrote:
> cxl_pmu_probe() rejects the PMU with -EINVAL when info->irq <= 0, but
> info->irq holds the MSI/MSI-X message number the device signals overflow
> on (CXL_PMU_CAP_MSI_N_MSK, a 0-based 4-bit field), with -1 meaning "no
> interrupt support". Message number 0 is valid and pci_irq_vector() takes
> a 0-based index, so a compliant device signalling on the first vector is
> wrongly refused and fails to probe.

If info->irq is a PCI MSI vector index, not the Linux vIRQ number, then 
surely that means the irq_set_affinity() calls are wrong as well?

Thanks,
Robin.

> Reject only the no-interrupt case (info->irq < 0), matching the sibling
> CXL mailbox and event IRQ handling.
> 
> Fixes: 5d7107c72796 ("perf: CXL Performance Monitoring Unit driver")
> Reported-by: sashiko-bot@kernel.org
> Closes: https://sashiko.dev/#/patchset/20260715191454.459673-1-dave@stgolabs.net?part=1
> Assisted-by: Claude:claude-opus-4-8
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> ---
>   drivers/perf/cxl_pmu.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/perf/cxl_pmu.c b/drivers/perf/cxl_pmu.c
> index 956da8202551..d1e810601e36 100644
> --- a/drivers/perf/cxl_pmu.c
> +++ b/drivers/perf/cxl_pmu.c
> @@ -876,7 +876,7 @@ static int cxl_pmu_probe(struct device *dev)
>   		.capabilities = PERF_PMU_CAP_NO_EXCLUDE,
>   	};
>   
> -	if (info->irq <= 0)
> +	if (info->irq < 0)
>   		return -EINVAL;
>   
>   	rc = pci_irq_vector(pdev, info->irq);

