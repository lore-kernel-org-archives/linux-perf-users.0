Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D8C2C4338F
	for <linux-perf-users@archiver.kernel.org>; Tue, 27 Jul 2021 10:33:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 04C57617E5
	for <linux-perf-users@archiver.kernel.org>; Tue, 27 Jul 2021 10:33:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236325AbhG0KdX (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 27 Jul 2021 06:33:23 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:3500 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231745AbhG0KdR (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 27 Jul 2021 06:33:17 -0400
Received: from fraeml743-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4GYt9z3sY4z6L9mJ;
        Tue, 27 Jul 2021 18:21:27 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml743-chm.china.huawei.com (10.206.15.224) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 27 Jul 2021 12:33:16 +0200
Received: from [10.47.80.220] (10.47.80.220) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Tue, 27 Jul
 2021 11:33:15 +0100
Subject: Re: [PATCH] perf pmu: Fix alias matching
To:     "Jin, Yao" <yao.jin@linux.intel.com>, <peterz@infradead.org>,
        <mingo@redhat.com>, <acme@kernel.org>, <mark.rutland@arm.com>,
        <jolsa@redhat.com>, <namhyung@kernel.org>, <kjain@linux.ibm.com>,
        <alexander.shishkin@linux.intel.com>, <irogers@google.com>
CC:     <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <1626793819-79090-1-git-send-email-john.garry@huawei.com>
 <0b57fa9b-fba4-8143-bef6-b7c4f2987635@linux.intel.com>
From:   John Garry <john.garry@huawei.com>
Message-ID: <df5e5893-08ba-1fb5-b92a-921b32ed3b2f@huawei.com>
Date:   Tue, 27 Jul 2021 11:32:55 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <0b57fa9b-fba4-8143-bef6-b7c4f2987635@linux.intel.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.80.220]
X-ClientProxiedBy: lhreml752-chm.china.huawei.com (10.201.108.202) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On 21/07/2021 04:07, Jin, Yao wrote:
>>

Hi Arnaldo,

Can you kindly consider picking up this patch?

Thanks

>> Fixes: c47a5599eda3 ("perf tools: Fix pattern matching for same 
>> substring in different PMU type")
>> Signed-off-by: John Garry <john.garry@huawei.com>
>> ---
>> @Jin Yao, please test for your scenarios
>>
> 
> For x86, the form uncore_pmu_{digits} or the uncore_pmu itself are 
> supported. We don't have more complex case such as the name in the form 
> aaa_bbbX_cccY. So my test didn't cover that complex form.
> 
> For my test, your patch works, thanks! :)

Can we take this as a tested-by?


