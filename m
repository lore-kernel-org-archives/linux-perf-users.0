Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 463AFEB64DA
	for <linux-perf-users@archiver.kernel.org>; Thu,  6 Jul 2023 01:39:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229882AbjGFBje (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 5 Jul 2023 21:39:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229700AbjGFBjd (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 5 Jul 2023 21:39:33 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC9F8E5;
        Wed,  5 Jul 2023 18:39:31 -0700 (PDT)
Received: from kwepemm600003.china.huawei.com (unknown [172.30.72.56])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4QxJzw04XtzPjwV;
        Thu,  6 Jul 2023 09:37:15 +0800 (CST)
Received: from [10.67.111.205] (10.67.111.205) by
 kwepemm600003.china.huawei.com (7.193.23.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 6 Jul 2023 09:39:28 +0800
Subject: Re: [PATCH 3/5] perf record: Tracking side-band events for all CPUs
 when tracing selected CPUs
To:     Namhyung Kim <namhyung@kernel.org>
CC:     <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
        <mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
        <jolsa@kernel.org>, <irogers@google.com>,
        <adrian.hunter@intel.com>, <kan.liang@linux.intel.com>,
        <linux-kernel@vger.kernel.org>, <linux-perf-users@vger.kernel.org>
References: <20230704074217.240939-1-yangjihong1@huawei.com>
 <20230704074217.240939-4-yangjihong1@huawei.com>
 <CAM9d7cjSTqE+rEJiSkAwmg5+XSxrgFFZC3B94fo4rbA9MH9dQg@mail.gmail.com>
From:   Yang Jihong <yangjihong1@huawei.com>
Message-ID: <dba16f45-c303-6600-6102-f78cc90ead6c@huawei.com>
Date:   Thu, 6 Jul 2023 09:39:28 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <CAM9d7cjSTqE+rEJiSkAwmg5+XSxrgFFZC3B94fo4rbA9MH9dQg@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.111.205]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemm600003.china.huawei.com (7.193.23.202)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Hello,

On 2023/7/6 5:09, Namhyung Kim wrote:
> On Tue, Jul 4, 2023 at 12:44 AM Yang Jihong <yangjihong1@huawei.com> wrote:
>>
>> User space tasks can migrate between CPUs, we need to track side-band
>> events for all CPUs.
>>
>> The specific scenarios are as follows:
>>
>>           CPU0                                 CPU1
>>    perf record -C 0 start
>>                                taskA starts to be created and executed
>>                                  -> PERF_RECORD_COMM and PERF_RECORD_MMAP
>>                                     events only deliver to CPU1
>>                                ......
>>                                  |
>>                            migrate to CPU0
>>                                  |
>>    Running on CPU0    <----------/
>>    ...
>>
>>    perf record -C 0 stop
> 
> But I'm curious why you don't limit the task to run on the
> specified CPUs only (using taskset).
> 
> Also, as you may know, you don't need to specify -C if you
> want to profile specific tasks only.  It'll open per-cpu, per-task
> events and they will have all necessary info.
> 
The actual application scenario is to perform perf records only for 
specified cores. However, during sampling, the system may create new 
processes and then migrate the processes between cores due to 
scheduling. If the processes run on the selected core, In this case, the 
perf report cannot parse symbols for these processes.
>>
>> Now perf samples the PC of taskA. However, perf does not record the
>> PERF_RECORD_COMM and PERF_RECORD_COMM events of taskA.
> 
> _COMM and _MMAP right?
> 
Yes, PERF_RECORD_COMM and PERF_RECORD_MMAP. There's a clerical error here...

Thanks,
Yang
