Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 840FDC4332F
	for <linux-perf-users@archiver.kernel.org>; Fri, 21 Oct 2022 10:31:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229882AbiJUKb5 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 21 Oct 2022 06:31:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229994AbiJUKbz (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 21 Oct 2022 06:31:55 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EB073BC5F
        for <linux-perf-users@vger.kernel.org>; Fri, 21 Oct 2022 03:31:53 -0700 (PDT)
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Mv13f3bzZzHvD0;
        Fri, 21 Oct 2022 18:31:42 +0800 (CST)
Received: from kwepemm600008.china.huawei.com (7.193.23.88) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 21 Oct 2022 18:31:30 +0800
Received: from [10.174.176.230] (10.174.176.230) by
 kwepemm600008.china.huawei.com (7.193.23.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 21 Oct 2022 18:31:29 +0800
Message-ID: <df6b61dc-aeff-7602-d5d9-6d8b8f52541d@huawei.com>
Date:   Fri, 21 Oct 2022 18:31:28 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.0
Subject: Re: [PATCH 3/3] perf vendor events arm64: Use event name instead of
 event code
To:     James Clark <james.clark@arm.com>
CC:     <john.garry@huawei.com>, <will@kernel.org>,
        <mike.leach@linaro.org>, <leo.yan@linaro.org>,
        <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
        <mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
        <jolsa@kernel.org>, <namhyung@kernel.org>, <kjain@linux.ibm.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-perf-users@vger.kernel.org>
References: <20221021085326.17139-1-shangxiaojing@huawei.com>
 <20221021085326.17139-4-shangxiaojing@huawei.com>
 <bf6205a7-8d72-fabe-2633-a0d2282ce299@arm.com>
From:   shangxiaojing <shangxiaojing@huawei.com>
In-Reply-To: <bf6205a7-8d72-fabe-2633-a0d2282ce299@arm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.176.230]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemm600008.china.huawei.com (7.193.23.88)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org



On 2022/10/21 17:09, James Clark wrote:
> 
> 
>>       {
>> -        "MetricExpr": "armv8_pmuv3_0@event\\=0x7002@ / CPU_CYCLES",
>> +        "MetricExpr": "EXE_STALL_DIV / CPU_CYCLES",
>>           "PublicDescription": "Divider L3 topdown metric",
>>           "BriefDescription": "Divider L3 topdown metric",
>>           "MetricGroup": "TopDownL3",
>>           "MetricName": "divider"
>>       },
>>       {
>> -        "MetricExpr": "armv8_pmuv3_0@event\\=0x7003@ / CPU_CYCLES",
>> +        "MetricExpr": "FSU_STALL / CPU_CYCLES",
>>           "PublicDescription": "FSU stall L3 topdown metric",
>> -        "BriefDescription": "FSU stall L3 topdown metric",
>> +	"BriefDescription": "FSU stall L3 topdown metric",
> 
> There is a tab here, but it's probably not worth resubmitting over.
> 
> Otherwise for the whole set:
> 
> Acked-by: James Clark <james.clark@arm.com>

Thanks for the review, will fix in v2.

Thanks,
-- 
Shang XiaoJing
