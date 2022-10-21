Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 852B3C4332F
	for <linux-perf-users@archiver.kernel.org>; Fri, 21 Oct 2022 10:32:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229902AbiJUKc5 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 21 Oct 2022 06:32:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229994AbiJUKcz (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 21 Oct 2022 06:32:55 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 201C325DAD5
        for <linux-perf-users@vger.kernel.org>; Fri, 21 Oct 2022 03:32:53 -0700 (PDT)
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.55])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4Mv11s5cH4zJn6C;
        Fri, 21 Oct 2022 18:30:09 +0800 (CST)
Received: from kwepemm600008.china.huawei.com (7.193.23.88) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 21 Oct 2022 18:32:38 +0800
Received: from [10.174.176.230] (10.174.176.230) by
 kwepemm600008.china.huawei.com (7.193.23.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 21 Oct 2022 18:32:37 +0800
Message-ID: <08505070-dd38-eff8-aaf2-7843e28f1166@huawei.com>
Date:   Fri, 21 Oct 2022 18:32:36 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.0
Subject: Re: [PATCH 1/3] perf vendor events arm64: Fix incorrect Hisi hip08 L3
 metrics
To:     John Garry <john.garry@huawei.com>, <will@kernel.org>,
        <james.clark@arm.com>, <mike.leach@linaro.org>,
        <leo.yan@linaro.org>, <peterz@infradead.org>, <mingo@redhat.com>,
        <acme@kernel.org>, <mark.rutland@arm.com>,
        <alexander.shishkin@linux.intel.com>, <jolsa@kernel.org>,
        <namhyung@kernel.org>, <kjain@linux.ibm.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-perf-users@vger.kernel.org>
References: <20221021085326.17139-1-shangxiaojing@huawei.com>
 <20221021085326.17139-2-shangxiaojing@huawei.com>
 <b3b814ef-50ed-52db-1b01-835234644264@huawei.com>
From:   shangxiaojing <shangxiaojing@huawei.com>
In-Reply-To: <b3b814ef-50ed-52db-1b01-835234644264@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.176.230]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemm600008.china.huawei.com (7.193.23.88)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org



On 2022/10/21 17:59, John Garry wrote:
> On 21/10/2022 09:53, Shang XiaoJing wrote:
>> Commit 0cc177cfc95d ("perf vendor events arm64: Add Hisi hip08 L3
>> metrics") add L3 metrics of hip08, but some metrics (IF_BP_MISP_BR_RET,
>> IF_BP_MISP_BR_RET, IF_BP_MISP_BR_BL) have incorrect event number, which
>> caused incorrect result. Fix the incorrect metrics.
> 
> It would be proper to mention why they were wrong - that is, not a 
> mistake by the original JSON author, but rather a mistake in the 
> document which the events were transscribed from.

Yes, will be adjusted in v2.

Thanks,
-- 
Shang XiaoJing
