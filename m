Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78532475335;
	Thu, 10 Sep 2026 12:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789043854; cv=none; b=ntxV8Znpe48MI8tHlOkTVqOGyoZoGnuUUmBQoVb4yd+QH4Eicj3rw6/gpVxvFdmOVPppJUfQYJIQSm9emHsKYMGVMk305+LpIY0b5Avu/U5z0+j18CeZFX0Jzyh6gYhvi27qyB3eqXaAz1LTG6k558CyGAVhbqKYWQgPYH9SzmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789043854; c=relaxed/simple;
	bh=AZwDqHdBjqPCn/h9+VhDsgEtjNFCuMURPnIg3aiP66c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MCLi2FftkCtXi9SpO98jPWUDG0pYXtgNxhjbDn4yL58+mrHgKOdp7OMipO2WIaUAhsSc30IvuowMpF4UiuzS+JwC63B7C5WG2l5503lZB2OtvHNtAeNXC02096NpXWv8yPzj1ptMIccaeglUnu7LWnwtmkayY8DRr+hxLBRl5nY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=glwg5KbI; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="glwg5KbI"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4596F153B;
	Thu, 10 Sep 2026 05:37:28 -0700 (PDT)
Received: from [10.2.212.23] (e121345-lin.cambridge.arm.com [10.2.212.23])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 034B03F7B4;
	Thu, 10 Sep 2026 05:37:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1789043851; bh=AZwDqHdBjqPCn/h9+VhDsgEtjNFCuMURPnIg3aiP66c=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=glwg5KbI4A+6EtBbJdGrMmvmGDTyxTKM5xkPl2GjCRh4g6oOCojo0tG6Nvp/BsP5W
	 ppBt0z61poix3LIUOZVeyM697EZsNnDjwOJ4hujDmg4WZboVhhieMDl1ggKOj7h5At
	 vee/0D7kRuE8CZtW0DhOab3JKWwY/k4PBXOl3d3o=
Message-ID: <fca383e2-56bf-4c93-bd07-bc54a79235a3@arm.com>
Date: Thu, 10 Sep 2026 13:37:29 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] perf/arm-cmn: Fix wp_dev_sel2 setting for multi-DTM
 configurations
To: Shouping Wang <allen.wang@hj-micro.com>, will@kernel.org
Cc: mark.rutland@arm.com, linux-arm-kernel@lists.infradead.org,
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
 peter.du@hj-micro.com, andy.xu@hj-micro.com
References: <2fb3bda7-cd64-4dc0-99f8-c0fda8d42cf9@arm.com>
 <20260910114601.165237-1-allen.wang@hj-micro.com>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <20260910114601.165237-1-allen.wang@hj-micro.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/09/2026 12:46 pm, Shouping Wang wrote:
> When MXP_MULTIPLE_DTM_EN is TRUE, each DTM will monitor at most
> two device ports. In this case, {wp_dev_sel2, wp_dev_sel} will
> only use values 2'b00 and 2'b01 per DTM.

Poor documentation strikes again!

> Previously the setting allowed values beyond the supported range
> per DTM, which could cause each DTM to select invalid ports when
> MXP_MULTIPLE_DTM_EN is TRUE.
> 
> Fix this by only setting CMN_DTM_WPn_CONFIG_WP_DEV_SEL2 when
> !multi_dtm.

Reviewed-by: Robin Murphy <robin.murphy@arm.com>

Thanks for the fix!
Robin.

> Fixes: 60d1504070c2 ("perf/arm-cmn: Support new IP features")
> Signed-off-by: Shouping Wang <allen.wang@hj-micro.com>
> ---
> 
> Changes in v2:
> - Made the setting of CMN_DTM_WPn_CONFIG_WP_DEV_SEL2 conditional on
>    !multi_dtm, instead of clamping with dev %= 2.
> - Refactored is_cmn600 to use cmn->part directly.
> - Updated the commit message.
> 
> Link to v1: https://lore.kernel.org/lkml/20260819105443.668784-1-allen.wang@hj-micro.com/
> 
>   drivers/perf/arm-cmn.c | 10 +++++++---
>   1 file changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/perf/arm-cmn.c b/drivers/perf/arm-cmn.c
> index 6e5cc4086a9e..7e7590381171 100644
> --- a/drivers/perf/arm-cmn.c
> +++ b/drivers/perf/arm-cmn.c
> @@ -1393,13 +1393,14 @@ static void arm_cmn_claim_wp_idx(struct arm_cmn_dtm *dtm,
>   
>   static u32 arm_cmn_wp_config(struct perf_event *event, int wp_idx)
>   {
> +	struct arm_cmn *cmn = to_cmn(event->pmu);
>   	u32 config;
>   	u32 dev = CMN_EVENT_WP_DEV_SEL(event);
>   	u32 chn = CMN_EVENT_WP_CHN_SEL(event);
>   	u32 grp = CMN_EVENT_WP_GRP(event);
>   	u32 exc = CMN_EVENT_WP_EXCLUSIVE(event);
>   	u32 combine = CMN_EVENT_WP_COMBINE(event);
> -	bool is_cmn600 = to_cmn(event->pmu)->part == PART_CMN600;
> +	bool is_cmn600 = cmn->part == PART_CMN600;
>   
>   	/* CMN-600 supports only primary and secondary matching groups */
>   	if (is_cmn600)
> @@ -1407,8 +1408,11 @@ static u32 arm_cmn_wp_config(struct perf_event *event, int wp_idx)
>   
>   	config = FIELD_PREP(CMN_DTM_WPn_CONFIG_WP_DEV_SEL, dev) |
>   		 FIELD_PREP(CMN_DTM_WPn_CONFIG_WP_CHN_SEL, chn) |
> -		 FIELD_PREP(CMN_DTM_WPn_CONFIG_WP_GRP, grp) |
> -		 FIELD_PREP(CMN_DTM_WPn_CONFIG_WP_DEV_SEL2, dev >> 1);
> +		 FIELD_PREP(CMN_DTM_WPn_CONFIG_WP_GRP, grp);
> +
> +	if (!cmn->multi_dtm)
> +		config |= FIELD_PREP(CMN_DTM_WPn_CONFIG_WP_DEV_SEL2, dev >> 1);
> +
>   	if (exc)
>   		config |= is_cmn600 ? CMN600_WPn_CONFIG_WP_EXCLUSIVE :
>   				      CMN_DTM_WPn_CONFIG_WP_EXCLUSIVE;

