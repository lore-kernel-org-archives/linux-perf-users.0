Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF224C433F5
	for <linux-perf-users@archiver.kernel.org>; Mon,  9 May 2022 03:09:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229826AbiEIDMz (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Sun, 8 May 2022 23:12:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231338AbiEIDLE (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Sun, 8 May 2022 23:11:04 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7F838BE3C;
        Sun,  8 May 2022 20:07:11 -0700 (PDT)
Received: from canpemm500006.china.huawei.com (unknown [172.30.72.54])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4KxQvN4HggzXdqF;
        Mon,  9 May 2022 11:02:24 +0800 (CST)
Received: from [10.67.109.61] (10.67.109.61) by canpemm500006.china.huawei.com
 (7.192.105.130) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Mon, 9 May
 2022 11:07:09 +0800
Message-ID: <17be552a-ff87-0c9e-d963-fa00705e7a91@huawei.com>
Date:   Mon, 9 May 2022 11:07:09 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH -next] perf/x86/amd: Remove unused variable 'hwc'
From:   zhengzucheng <zhengzucheng@huawei.com>
To:     <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
        <mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
        <jolsa@kernel.org>, <namhyung@kernel.org>, <tglx@linutronix.de>,
        <bp@alien8.de>, <dave.hansen@linux.intel.com>, <hpa@zytor.com>
CC:     <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20220421111031.174698-1-zhengzucheng@huawei.com>
In-Reply-To: <20220421111031.174698-1-zhengzucheng@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.109.61]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 canpemm500006.china.huawei.com (7.192.105.130)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

ping...

Any suggestions for this problem？

在 2022/4/21 19:10, Zucheng Zheng 写道:
> 'hwc' is never used in amd_pmu_enable_all(), so remove it.
>
> -------------------------------
>
> Signed-off-by: Zucheng Zheng <zhengzucheng@huawei.com>
> ---
>   arch/x86/events/amd/core.c | 3 ---
>   1 file changed, 3 deletions(-)
>
> diff --git a/arch/x86/events/amd/core.c b/arch/x86/events/amd/core.c
> index 8e1e818f8195..d7f9500b876d 100644
> --- a/arch/x86/events/amd/core.c
> +++ b/arch/x86/events/amd/core.c
> @@ -714,14 +714,11 @@ static void amd_pmu_enable_event(struct perf_event *event)
>   static void amd_pmu_enable_all(int added)
>   {
>   	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
> -	struct hw_perf_event *hwc;
>   	int idx;
>   
>   	amd_brs_enable_all();
>   
>   	for (idx = 0; idx < x86_pmu.num_counters; idx++) {
> -		hwc = &cpuc->events[idx]->hw;
> -
>   		/* only activate events which are marked as active */
>   		if (!test_bit(idx, cpuc->active_mask))
>   			continue;
