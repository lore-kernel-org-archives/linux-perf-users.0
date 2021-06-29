Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E83EC11F64
	for <linux-perf-users@archiver.kernel.org>; Tue, 29 Jun 2021 00:54:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7439761D07
	for <linux-perf-users@archiver.kernel.org>; Tue, 29 Jun 2021 00:54:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230100AbhF2A4f (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 28 Jun 2021 20:56:35 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:6017 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230090AbhF2A4f (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 28 Jun 2021 20:56:35 -0400
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4GDQp909VtzXmFc;
        Tue, 29 Jun 2021 08:48:49 +0800 (CST)
Received: from dggpemm000003.china.huawei.com (7.185.36.128) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 29 Jun 2021 08:54:06 +0800
Received: from [10.67.102.248] (10.67.102.248) by
 dggpemm000003.china.huawei.com (7.185.36.128) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 29 Jun 2021 08:54:06 +0800
Subject: Re: [PATCH] perf arm-spe: Fix incorrect sample timestamp in perf
 script
To:     Leo Yan <leo.yan@linaro.org>
CC:     <john.garry@huawei.com>, <will@kernel.org>,
        <mathieu.poirier@linaro.org>, <peterz@infradead.org>,
        <mingo@redhat.com>, <acme@kernel.org>, <mark.rutland@arm.com>,
        <alexander.shishkin@linux.intel.com>, <jolsa@redhat.com>,
        <namhyung@kernel.org>, <james.clark@arm.com>,
        <andre.przywara@arm.com>, <linux-arm-kernel@lists.infradead.org>,
        <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20210626032115.16742-1-yangjihong1@huawei.com>
 <20210628014953.GA163942@leoy-ThinkPad-X240s>
 <75dac5f8-9c82-0db1-d362-44289dcaa206@huawei.com>
 <20210628040716.GC163942@leoy-ThinkPad-X240s>
 <2af84c69-8528-9c4a-f666-2dd660bcd966@huawei.com>
 <20210628072905.GB200044@leoy-ThinkPad-X240s>
From:   Yang Jihong <yangjihong1@huawei.com>
Message-ID: <1bc5b36c-8138-4d14-c106-964682bf44dd@huawei.com>
Date:   Tue, 29 Jun 2021 08:53:55 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20210628072905.GB200044@leoy-ThinkPad-X240s>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.102.248]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemm000003.china.huawei.com (7.185.36.128)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Hello Leo,

On 2021/6/28 15:29, Leo Yan wrote:
> On Mon, Jun 28, 2021 at 02:30:56PM +0800, Yang Jihong wrote:
>> Hello Leo,
>>
>> On 2021/6/28 12:07, Leo Yan wrote:
>>> On Mon, Jun 28, 2021 at 11:45:07AM +0800, Yang Jihong wrote:
>>>
>>> [...]
>>>
>>>> The timestamp does not match. Each timestamp has a difference of
>>>> 213.98296702 seconds. Is the command I executed wrong?
>>>
>>> I don't understand what's your meaning "a difference of 213.98296702
>>> seconds".
>>>
>>> But let me give an explaination with your below examples.  You could
>>> the command "perf script" outputs the timestamp 314938.859071370 which
>>> is the kernel's timestamp, if using the command "perf script -D", it
>>> outputs the value 31515284203839 which is the Arch timer's raw counter
>>> value.
>>>
>>> In theory, the arch timer's counter is enabled at the very early
>>> time before kernel's booting (e.g. bootloaders, UEFI, etc...).  So for
>>> the kernel's timestamp, it should calibrate the timestamp and reduce
>>> the offset prior to the kernel's booting.  I think this is the reason
>>> why you observed 213.98296702 seconds difference (if compared with
>>> your own patch?)
>>>
>>> If still see any issue, please let me know.  Thanks a lot for the
>>> testing!
>>>
>> Thanks for the very detailed explanation.
>> To keep the correct relative time sequence between events in SPE and other
>> events, we should use kernel timestamp instead of arch time. Therefore, we
>> need to calibrate the time. Is this correct?
> 
> Yes, correct!
I see. Thank you for your answer.:)

Jihong
> .
> 
