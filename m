Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5860435A387;
	Thu, 26 Mar 2026 10:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774521621; cv=none; b=ehtMxz0zf6xA3GhNuwO3EDZgF/eoIIz9RK6NvbGL7MyG0ciabxlRQ5kE0BJvB3f37+oXovLsOxfh9ec4EYNu1TlyiqP/y9FuJWsdCooDZ53rp4/IDuuQuW+KOx0XWA4dICV8Xfbg6G2b7nhvUpvg+xrQU/wOmbaH0NNfJrRuMr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774521621; c=relaxed/simple;
	bh=jCgA5Qoq0F1Yxd79EMxK5dXZ+XK/jWruv7LJw+fK3S0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qUbp0tajQAX8tZtyBXTAWIGi4uh8auDOYvmqjdDewjfZK8Yxwgk6t/G2XCgUPPbLUgjJYp0hMU+R1d4a4LWtXmG0zMf9topkdBxgEHmSHO1Tc+QAxmhoDg5daIT+VMDwghjJX4xZ7+y71vg47ZjT5L88nfuxr5S/Eg4+a/+P2Js=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=K3WnHrRd; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="K3WnHrRd"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DF361175A;
	Thu, 26 Mar 2026 03:40:12 -0700 (PDT)
Received: from [10.57.76.165] (unknown [10.57.76.165])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9DC6E3FB90;
	Thu, 26 Mar 2026 03:40:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1774521618; bh=jCgA5Qoq0F1Yxd79EMxK5dXZ+XK/jWruv7LJw+fK3S0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=K3WnHrRdamLykfPTlVFokk/Uvzgsnhp0B4vw5wO2j37T78seG4zPV/MPjo/0tN2JX
	 TuJsRxhTv+sulyeAiSQq/dHHvQLPu0UE895yM16X98AHocoqdK9OoMwVsTw2PXhTmt
	 7B+kEnefTxcsOOoQEgl5pJYyNitQs7yHSW7eY4HM=
Message-ID: <45fbd3d2-4c46-49ce-9d19-38b247ad7388@arm.com>
Date: Thu, 26 Mar 2026 10:40:15 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf/arm-cmn: Fix resource_size_t printk specifier in
 arm_cmn_init_dtc()
To: Nathan Chancellor <nathan@kernel.org>, Will Deacon <will@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Ilkka Koskinen <ilkka@os.amperecomputing.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260325-perf-arm-cmn-fix-resource_size_t-format-v1-1-e84d52ee3e81@kernel.org>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <20260325-perf-arm-cmn-fix-resource_size_t-format-v1-1-e84d52ee3e81@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2026-03-26 2:19 am, Nathan Chancellor wrote:
> When building for 32-bit ARM, there is a warning when using the %llx
> specifier to print a resource_size_t variable:
> 
>    drivers/perf/arm-cmn.c: In function 'arm_cmn_init_dtc':
>    drivers/perf/arm-cmn.c:2149:73: error: format '%llx' expects argument of type 'long long unsigned int', but argument 4 has type 'resource_size_t' {aka 'unsigned int'} [-Werror=format=]
>     2149 |                                      "Failed to request DTC region 0x%llx\n", base);
>          |                                                                      ~~~^     ~~~~
>          |                                                                         |     |
>          |                                                                         |     resource_size_t {aka unsigned int}
>          |                                                                         long long unsigned int
>          |                                                                      %x
> 
> Use the %pa specifier to handle the possible sizes of phys_addr_t
> properly. This requires passing the variable by reference.

Cheers Nathan! I had seen the kbuild robot reports last night, and was 
going to get to this today, but I'm more than happy to be beaten to it!

Reviewed-by: Robin murphy <robin.murphy@arm.com>

> Fixes: 5394396ff548 ("perf/arm-cmn: Stop claiming entire iomem region")
> Signed-off-by: Nathan Chancellor <nathan@kernel.org>
> ---
>   drivers/perf/arm-cmn.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/perf/arm-cmn.c b/drivers/perf/arm-cmn.c
> index 1ac91cda6780..5c727c2abaf0 100644
> --- a/drivers/perf/arm-cmn.c
> +++ b/drivers/perf/arm-cmn.c
> @@ -2146,7 +2146,7 @@ static int arm_cmn_init_dtc(struct arm_cmn *cmn, struct arm_cmn_node *dn, int id
>   	size = cmn->part == PART_CMN600 ? SZ_16K : SZ_64K;
>   	if (!devm_request_mem_region(cmn->dev, base, size, dev_name(cmn->dev)))
>   		return dev_err_probe(cmn->dev, -EBUSY,
> -				     "Failed to request DTC region 0x%llx\n", base);
> +				     "Failed to request DTC region 0x%pa\n", &base);
>   
>   	writel_relaxed(CMN_DT_DTC_CTL_DT_EN, dtc->base + CMN_DT_DTC_CTL);
>   	writel_relaxed(CMN_DT_PMCR_PMU_EN | CMN_DT_PMCR_OVFL_INTR_EN, CMN_DT_PMCR(dtc));
> 
> ---
> base-commit: 2f89b7f78c50ca973ca035ceb30426f78d9e0996
> change-id: 20260325-perf-arm-cmn-fix-resource_size_t-format-b01795e36e60
> 
> Best regards,
> --
> Nathan Chancellor <nathan@kernel.org>
> 

