Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9718DC433EF
	for <linux-perf-users@archiver.kernel.org>; Tue, 17 May 2022 03:57:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230274AbiEQD45 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 16 May 2022 23:56:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236957AbiEQD4t (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 16 May 2022 23:56:49 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 164E933E36;
        Mon, 16 May 2022 20:56:47 -0700 (PDT)
Received: from kwepemi500022.china.huawei.com (unknown [172.30.72.57])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4L2Mhs2tGsz1JCVx;
        Tue, 17 May 2022 11:55:25 +0800 (CST)
Received: from kwepemm600003.china.huawei.com (7.193.23.202) by
 kwepemi500022.china.huawei.com (7.221.188.64) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 17 May 2022 11:56:44 +0800
Received: from [10.67.101.67] (10.67.101.67) by kwepemm600003.china.huawei.com
 (7.193.23.202) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 17 May
 2022 11:56:44 +0800
Subject: Re: [PATCH 08/10] coresight: Remove legacy Trace ID allocation
 mechanism
To:     Mike Leach <mike.leach@linaro.org>, <suzuki.poulose@arm.com>,
        <coresight@lists.linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     <mathieu.poirier@linaro.org>, <peterz@infradead.org>,
        <mingo@redhat.com>, <acme@kernel.org>,
        <linux-perf-users@vger.kernel.org>, <leo.yan@linaro.org>
References: <20220308205000.27646-1-mike.leach@linaro.org>
 <20220308205000.27646-9-mike.leach@linaro.org>
From:   "liuqi (BA)" <liuqi115@huawei.com>
Message-ID: <71c11820-433d-755d-0eb4-797313d693f9@huawei.com>
Date:   Tue, 17 May 2022 11:56:44 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20220308205000.27646-9-mike.leach@linaro.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.101.67]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemm600003.china.huawei.com (7.193.23.202)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Hi Mike,

On 2022/3/9 4:49, Mike Leach wrote:
> This static 'cpu * 2 + seed' was outdated and broken for systems with high
> core counts (>46).
> 
> This has been replaced by a dynamic allocation system.
> 
> Signed-off-by: Mike Leach <mike.leach@linaro.org>
> ---
>   include/linux/coresight-pmu.h | 12 ------------
>   1 file changed, 12 deletions(-)

Seems coresight_get_trace_id() in tools/include/linux/coresight-pmu.h 
need to be deleted too.

Thanks,
Qi

> 
> diff --git a/include/linux/coresight-pmu.h b/include/linux/coresight-pmu.h
> index 4ac5c081af93..bb4eb4de3c77 100644
> --- a/include/linux/coresight-pmu.h
> +++ b/include/linux/coresight-pmu.h
> @@ -8,7 +8,6 @@
>   #define _LINUX_CORESIGHT_PMU_H
>   
>   #define CORESIGHT_ETM_PMU_NAME "cs_etm"
> -#define CORESIGHT_ETM_PMU_SEED  0x10
>   
>   /*
>    * Below are the definition of bit offsets for perf option, and works as
> @@ -32,15 +31,4 @@
>   #define ETM4_CFG_BIT_RETSTK	12
>   #define ETM4_CFG_BIT_VMID_OPT	15
>   
> -static inline int coresight_get_trace_id(int cpu)
> -{
> -	/*
> -	 * A trace ID of value 0 is invalid, so let's start at some
> -	 * random value that fits in 7 bits and go from there.  Since
> -	 * the common convention is to have data trace IDs be I(N) + 1,
> -	 * set instruction trace IDs as a function of the CPU number.
> -	 */
> -	return (CORESIGHT_ETM_PMU_SEED + (cpu * 2));
> -}
> -
>   #endif
> 
