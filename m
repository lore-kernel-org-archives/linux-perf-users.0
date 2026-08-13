Received: from va-2-30.ptr.blmpb.com (va-2-30.ptr.blmpb.com [209.127.231.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 004D83ED13E
	for <linux-perf-users@vger.kernel.org>; Thu, 13 Aug 2026 06:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.231.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786601720; cv=none; b=i1BtydumRCTZ11NAvDOjwadONjjv0Ul0QJVwQgJBCZAsIqtzZiTOUOWH7gHs57bEPVhsKUlLsJJhMtJTIkFdBPlTirn+1Grr5/eX+tYtGXnGPhp58/1Ma4xWCCKTlne+Ex0/ERBWEi5mrvAQdor4IZKWYYq6UdJBMHdt0fKKjwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786601720; c=relaxed/simple;
	bh=ICHD76bdSsEd8BXLkb1rH3Vn5EpxVbcsoC5VicspgaY=;
	h=In-Reply-To:References:Mime-Version:From:Subject:Date:Message-Id:
	 Content-Type:To:Cc; b=Xu1USUOKaECSS4YQlqzL/Pp+wnD9TrCfy5pdH2MfTfDRsGu6ISEJDY07UxMoypPbE4LljCid9nUlXKkTM0CZtZX5njDE04nqCze4QQVgnO8cTuO+ecxdHKcRBvc5drtHiOpXdpI1d0to7iMTvO76B+l0vfM2n0zHIiwnUnyiYkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=picoheart.com; spf=pass smtp.mailfrom=picoheart.com; dkim=pass (2048-bit key) header.d=picoheart.com header.i=@picoheart.com header.b=Zzfpty/p; arc=none smtp.client-ip=209.127.231.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=picoheart.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=picoheart.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=picoheart.com header.i=@picoheart.com header.b="Zzfpty/p"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=feishu2604151535; d=picoheart.com; t=1786601707; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=vowdvw8GuYYrcPAwUQGGmV9lD8e4hSjxfhhY5B11tpg=;
 b=Zzfpty/pUGJ+Ji5wGWLjOpXQijlPENg7gSlx19Q4s0JArPm12Ig/1vlv5Eoh64yXLCQ+ol
 ZSIcU834ktM9pSxCdOIENeVeakjEy1wDqbxp8NKBGXve/LaTvZLbyiui2aRCMJ0yuS8WeH
 5kuUL2AWbyB05px9fu4bEG+s3zLJ3Z4TBHqgNsvqU+ZYSMWFuOm0RJGAcZM3cO7w6FF8rR
 RgqTBG8g2Mkfei/lmn+SQ+yEIjbaqyEWbCpBKzkEZsOJ5n19G9QnNPUxsIZ9+zrzXxfw74
 pyqFxyQvMzhNc1seZyM2n5UUXMIGLrSYkVZ94PPS7dieWx2e+dqZheE2tzXdpQ==
Content-Transfer-Encoding: 7bit
X-Original-From: Yicong Yang <yang.yicong@picoheart.com>
Content-Language: en-US
In-Reply-To: <20260811160720.28580-1-zhangzhanpeng.jasper@bytedance.com>
References: <20260811131714.12779-1-zhangzhanpeng.jasper@bytedance.com> <20260811160720.28580-1-zhangzhanpeng.jasper@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Received: from [100.86.210.149] ([120.234.91.246]) by smtp.feishu.cn with ESMTPS; Thu, 13 Aug 2026 14:15:04 +0800
From: "Yicong Yang" <yang.yicong@picoheart.com>
Subject: Re: [PATCH v2 2/2] perf/dwc_pcie: Skip sibling walks for new group leaders
Date: Thu, 13 Aug 2026 14:15:01 +0800
Message-Id: <0e73e3fb-b7f1-474e-aaef-3c8f339638b1@picoheart.com>
X-Lms-Return-Path: <lba+26a7d60e9+e346e6+vger.kernel.org+yang.yicong@picoheart.com>
Content-Type: text/plain; charset=UTF-8
To: "Zhanpeng Zhang" <zhangzhanpeng.jasper@bytedance.com>
Cc: "Shuai Xue" <xueshuai@linux.alibaba.com>, 
	"Jing Zhang" <renyu.zj@linux.alibaba.com>, <yang.yicong@picoheart.com>, 
	"Will Deacon" <will@kernel.org>, "Mark Rutland" <mark.rutland@arm.com>, 
	"Yicong Yang" <yangyicong@hisilicon.com>, 
	"Baolin Wang" <baolin.wang@linux.alibaba.com>, 
	"Jonathan Cameron" <Jonathan.Cameron@huawei.com>, 
	<linux-arm-kernel@lists.infradead.org>, 
	<linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>
User-Agent: Mozilla Thunderbird

On 8/12/26 12:07 AM, Zhanpeng Zhang wrote:
> for_each_sibling_event() requires the event context lock to be held.
> perf_try_init_event() only takes that lock when initializing a group
> member.

newline here for a new paragraph.

> The DWC PCIe PMU walks the sibling list twice for every event, including a
> new group leader whose event_init() method runs without the lock. Although
> the leader cannot have siblings yet, the lock assertion is evaluated before
> the empty list is walked and produces two lockdep warnings.
> 
> Skip both sibling walks while initializing a group leader. Group member
> validation is unchanged and continues to run with the event context mutex
> held.
> 
> Fixes: af9597adc2f1 ("drivers/perf: add DesignWare PCIe PMU driver")
> Signed-off-by: Zhanpeng Zhang <zhangzhanpeng.jasper@bytedance.com>

looks good to me.

Reviewed-by: Yicong Yang <yang.yicong@picoheart.com>

> ---
> A system-wide DWC PCIe PMU perf stat completed successfully with the same
> debug configuration, without lockdep reports or kernel taint.
> 
>  drivers/perf/dwc_pcie_pmu.c | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/perf/dwc_pcie_pmu.c b/drivers/perf/dwc_pcie_pmu.c
> index 7b2e28aade73..a6667ac19a99 100644
> --- a/drivers/perf/dwc_pcie_pmu.c
> +++ b/drivers/perf/dwc_pcie_pmu.c
> @@ -417,6 +417,10 @@ static int dwc_pcie_pmu_validate_group(struct perf_event *event)
>  		if (dwc_pcie_pmu_validate_add_lane_event(leader, val_lane_events))
>  			return -ENOSPC;
>  
> +	/* A new group leader cannot have any siblings yet. */
> +	if (event == leader)
> +		return 0;
> +
>  	for_each_sibling_event(sibling, leader) {
>  		type = DWC_PCIE_EVENT_TYPE(sibling);
>  		if (type == DWC_PCIE_TIME_BASE_EVENT) {
> @@ -452,9 +456,11 @@ static int dwc_pcie_pmu_event_init(struct perf_event *event)
>  	if (event->cpu < 0 || event->attach_state & PERF_ATTACH_TASK)
>  		return -EINVAL;
>  
> -	for_each_sibling_event(sibling, event->group_leader) {
> -		if (sibling->pmu != event->pmu && !is_software_event(sibling))
> -			return -EINVAL;
> +	if (event != event->group_leader) {
> +		for_each_sibling_event(sibling, event->group_leader) {
> +			if (sibling->pmu != event->pmu && !is_software_event(sibling))
> +				return -EINVAL;
> +		}

personally feel better to make this check into dwc_pcie_pmu_validate_group().

thanks.
