Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75E4BC4332F
	for <linux-perf-users@archiver.kernel.org>; Fri, 21 Oct 2022 10:00:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229695AbiJUKAH (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 21 Oct 2022 06:00:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbiJUKAE (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 21 Oct 2022 06:00:04 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5E1558064
        for <linux-perf-users@vger.kernel.org>; Fri, 21 Oct 2022 03:00:02 -0700 (PDT)
Received: from fraeml740-chm.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Mv0HG2Bwhz6J66d;
        Fri, 21 Oct 2022 17:56:42 +0800 (CST)
Received: from lhrpeml500003.china.huawei.com (7.191.162.67) by
 fraeml740-chm.china.huawei.com (10.206.15.221) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 21 Oct 2022 12:00:00 +0200
Received: from [10.126.168.107] (10.126.168.107) by
 lhrpeml500003.china.huawei.com (7.191.162.67) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 21 Oct 2022 10:59:58 +0100
Message-ID: <b3b814ef-50ed-52db-1b01-835234644264@huawei.com>
Date:   Fri, 21 Oct 2022 10:59:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH 1/3] perf vendor events arm64: Fix incorrect Hisi hip08 L3
 metrics
To:     Shang XiaoJing <shangxiaojing@huawei.com>, <will@kernel.org>,
        <james.clark@arm.com>, <mike.leach@linaro.org>,
        <leo.yan@linaro.org>, <peterz@infradead.org>, <mingo@redhat.com>,
        <acme@kernel.org>, <mark.rutland@arm.com>,
        <alexander.shishkin@linux.intel.com>, <jolsa@kernel.org>,
        <namhyung@kernel.org>, <kjain@linux.ibm.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-perf-users@vger.kernel.org>
References: <20221021085326.17139-1-shangxiaojing@huawei.com>
 <20221021085326.17139-2-shangxiaojing@huawei.com>
From:   John Garry <john.garry@huawei.com>
In-Reply-To: <20221021085326.17139-2-shangxiaojing@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.126.168.107]
X-ClientProxiedBy: lhrpeml100001.china.huawei.com (7.191.160.183) To
 lhrpeml500003.china.huawei.com (7.191.162.67)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On 21/10/2022 09:53, Shang XiaoJing wrote:
> Commit 0cc177cfc95d ("perf vendor events arm64: Add Hisi hip08 L3
> metrics") add L3 metrics of hip08, but some metrics (IF_BP_MISP_BR_RET,
> IF_BP_MISP_BR_RET, IF_BP_MISP_BR_BL) have incorrect event number, which
> caused incorrect result. Fix the incorrect metrics.

It would be proper to mention why they were wrong - that is, not a 
mistake by the original JSON author, but rather a mistake in the 
document which the events were transscribed from.
