Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D632C433FE
	for <linux-perf-users@archiver.kernel.org>; Wed, 26 Oct 2022 09:07:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230327AbiJZJHx (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 26 Oct 2022 05:07:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232540AbiJZJHw (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 26 Oct 2022 05:07:52 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 555D89B851
        for <linux-perf-users@vger.kernel.org>; Wed, 26 Oct 2022 02:07:51 -0700 (PDT)
Received: from frapeml500008.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4My2tM4Qlzz6H6px;
        Wed, 26 Oct 2022 17:04:11 +0800 (CST)
Received: from lhrpeml500003.china.huawei.com (7.191.162.67) by
 frapeml500008.china.huawei.com (7.182.85.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 26 Oct 2022 11:07:44 +0200
Received: from [10.202.227.197] (10.202.227.197) by
 lhrpeml500003.china.huawei.com (7.191.162.67) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 26 Oct 2022 10:07:44 +0100
Message-ID: <c84fa985-7c86-880a-a10b-088120fb2b06@huawei.com>
Date:   Wed, 26 Oct 2022 10:07:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH v2 1/3] perf vendor events arm64: Fix incorrect Hisi hip08
 L3 metrics
To:     Shang XiaoJing <shangxiaojing@huawei.com>, <will@kernel.org>,
        <james.clark@arm.com>, <mike.leach@linaro.org>,
        <leo.yan@linaro.org>, <peterz@infradead.org>, <mingo@redhat.com>,
        <acme@kernel.org>, <mark.rutland@arm.com>,
        <alexander.shishkin@linux.intel.com>, <jolsa@kernel.org>,
        <namhyung@kernel.org>, <kjain@linux.ibm.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-perf-users@vger.kernel.org>
References: <20221021105035.10000-1-shangxiaojing@huawei.com>
 <20221021105035.10000-2-shangxiaojing@huawei.com>
From:   John Garry <john.garry@huawei.com>
In-Reply-To: <20221021105035.10000-2-shangxiaojing@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.197]
X-ClientProxiedBy: lhrpeml100004.china.huawei.com (7.191.162.219) To
 lhrpeml500003.china.huawei.com (7.191.162.67)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On 21/10/2022 11:50, Shang XiaoJing wrote:
> Commit 0cc177cfc95d ("perf vendor events arm64: Add Hisi hip08 L3
> metrics") add L3 metrics of hip08, but some metrics (IF_BP_MISP_BR_RET,
> IF_BP_MISP_BR_RET, IF_BP_MISP_BR_BL) have incorrect event number due to
> the mistakes in document, which caused incorrect result. Fix the
> incorrect metrics.
> 
> before:
> 65,811,214,308	armv8_pmuv3_0/event=0x1014/	# 18.87 push_branch
> 						# -40.19 other_branch
> 3,564,316,780	BR_MIS_PRED			# 0.51 indirect_branch
> 						# 21.81 pop_branch
> 
> after:
> 6,537,146,245	BR_MIS_PRED			# 0.48 indirect_branch
> 						# 0.47 pop_branch
> 						# 0.00 push_branch
> 						# 0.05 other_branch
> 
> Fixes: 0cc177cfc95d ("perf vendor events arm64: Add Hisi hip08 L3 metrics")
> Signed-off-by: Shang XiaoJing<shangxiaojing@huawei.com>
> Cc: John Garry<john.garry@huawei.com>
> Acked-by: James Clark<james.clark@arm.com>

Reviewed-by: John Garry <john.garry@huawei.com>

> ---

