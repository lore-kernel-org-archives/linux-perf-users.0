Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F16B132BF24;
	Wed, 15 Apr 2026 18:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776277159; cv=none; b=RMXNTPsk3ksUKMCcvYnLJvr6ERcAvjxANrgHCNpsW/c/vJXOw2Tl3a8HI6c/ouYn/o2Uzj5bSbziCUXhiuleKtrr9yn7di1plo9+PsGiQIm6gqMetNZdIs1YoLP6IZ+mLJPW0T469QbEyoDQggxXSLnQwamKmvN17xz7n7AAQRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776277159; c=relaxed/simple;
	bh=T5wSEKNxd+WK6Gf12aNHbt22JqawJsPgYLmrIq9kvGo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rz9c1oOTynKV+A9WAYeTx9eBfG6/PKmby8gmMaqkFpdIDWjRbhU7Kfm1ZxC9y082jec4xiiD9ba+p0c0LJaiwgaQ7T70MGDzPULXuSJO0EWwbBwAPnblDEvoYgg5U6AUj8fa8WdWaK/VUSnCqV1TrHLY3DiCPwIColHHAzCO79E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=d6UUQyGb; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="d6UUQyGb"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B68BA2BC0;
	Wed, 15 Apr 2026 11:19:08 -0700 (PDT)
Received: from J2N7QTR9R3 (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 977123F7D8;
	Wed, 15 Apr 2026 11:19:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1776277154; bh=T5wSEKNxd+WK6Gf12aNHbt22JqawJsPgYLmrIq9kvGo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=d6UUQyGbDM+4d1xYsZHLm7gPViLNXhJiX2q68G5XuHafRIDjh8ZMJc5aP582JXxtM
	 LhKTA6OlAkHj3A+WUEf7VYl20ppC2Z7d26LDku2Y/1B+6Of6R7/SASqNriYcKfb6qD
	 U57viy9EAm2s3J+iHKUfW4sSGseR1g1YAwDy8MGM=
Date: Wed, 15 Apr 2026 19:19:06 +0100
From: Mark Rutland <mark.rutland@arm.com>
To: Guangshuo Li <lgs201920130244@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Will Deacon <will@kernel.org>,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] arm_pmu: acpi: fix reference leak on failed device
 registration
Message-ID: <ad_WmuauLJ3xDKqh@J2N7QTR9R3>
References: <20260415174159.3625777-1-lgs201920130244@gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260415174159.3625777-1-lgs201920130244@gmail.com>

Hi,

Thanks for the patch, but from a quick skim, I don't think this is the right
fix.

Greg, I think we might want to rework the core API here; question for
you at the end.

On Thu, Apr 16, 2026 at 01:41:59AM +0800, Guangshuo Li wrote:
> When platform_device_register() fails in arm_acpi_register_pmu_device(),
> the embedded struct device in pdev has already been initialized by
> device_initialize(), but the failure path only unregisters the GSI and
> does not drop the device reference for the current platform device:
> 
>   arm_acpi_register_pmu_device()
>     -> platform_device_register(pdev)
>        -> device_initialize(&pdev->dev)
>        -> setup_pdev_dma_masks(pdev)
>        -> platform_device_add(pdev)
> 
> This leads to a reference leak when platform_device_register() fails.

AFAICT you're saying that the reference was taken *within*
platform_device_register(), and then platform_device_register() itself
has failed. I think it's surprising that platform_device_register()
doesn't clean that up itself in the case of an error.

There are *tonnes* of calls to platform_device_register() throughout the
kernel that don't even bother to check the return value, and many that
just pass the return onto a caller that can't possibly know to call
platform_device_put().

Code in the same file as platform_device_register() expects it to clean up
after itself, e.g.

| int platform_add_devices(struct platform_device **devs, int num) 
| {
|         int i, ret = 0; 
| 
|         for (i = 0; i < num; i++) {
|                 ret = platform_device_register(devs[i]);
|                 if (ret) {
|                         while (--i >= 0)
|                                 platform_device_unregister(devs[i]);
|                         break;
|                 }    
|         }    
| 
|         return ret; 
| }

That's been there since the initial git commit, and back then,
platform_device_register() didn't mention that callers needed to perform
any cleanup.

I see a comment was added to platform_device_register() in commit:

  67e532a42cf4 ("driver core: platform: document registration-failure requirement")

... and that copied the commend added for device_register() in commit:

  5739411acbaa ("Driver core: Clarify device cleanup.")

... but the potential brokenness is so widespread, and the behaviour is
so surprising, that I'd argue the real but is that device_register()
doesn't clean up in case of error. I don't think it's worth changing
this single instance given the prevalance and churn fixing all of that
would involve.

I think it would be far better to fix the core driver API such that when
those functions return an error, they've already cleaned up for
themselves.

Greg, am I missing some functional reason why we can't rework
device_register() and friends to handle cleanup themselves? I appreciate
that'll involve churn for some callers, but AFAICT the majority of
callers don't have the required cleanup.

Mark.

> Fix this by calling platform_device_put() after unregistering the GSI.
> 
> The issue was identified by a static analysis tool I developed and
> confirmed by manual review.
> 
> Fixes: 81e5ee4716098 ("arm_pmu: acpi: Refactor arm_spe_acpi_register_device()")
> Cc: stable@vger.kernel.org
> Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
> ---
>  drivers/perf/arm_pmu_acpi.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/perf/arm_pmu_acpi.c b/drivers/perf/arm_pmu_acpi.c
> index e80f76d95e68..5ce382661e34 100644
> --- a/drivers/perf/arm_pmu_acpi.c
> +++ b/drivers/perf/arm_pmu_acpi.c
> @@ -119,8 +119,10 @@ arm_acpi_register_pmu_device(struct platform_device *pdev, u8 len,
>  
>  	pdev->resource[0].start = irq;
>  	ret = platform_device_register(pdev);
> -	if (ret)
> +	if (ret) {
>  		acpi_unregister_gsi(gsi);
> +		platform_device_put(pdev);
> +	}
>  
>  	return ret;
>  }
> -- 
> 2.43.0
> 
