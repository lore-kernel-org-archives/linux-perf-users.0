Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CF0FC07E96
	for <linux-perf-users@archiver.kernel.org>; Thu, 15 Jul 2021 11:41:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 73A67613BF
	for <linux-perf-users@archiver.kernel.org>; Thu, 15 Jul 2021 11:41:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229566AbhGOLnz (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 15 Jul 2021 07:43:55 -0400
Received: from szxga08-in.huawei.com ([45.249.212.255]:11282 "EHLO
        szxga08-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbhGOLnz (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 15 Jul 2021 07:43:55 -0400
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4GQXNl2fTHz1CK4j;
        Thu, 15 Jul 2021 19:35:19 +0800 (CST)
Received: from dggpemm000003.china.huawei.com (7.185.36.128) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 15 Jul 2021 19:40:58 +0800
Received: from [10.67.102.248] (10.67.102.248) by
 dggpemm000003.china.huawei.com (7.185.36.128) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 15 Jul 2021 19:40:58 +0800
Subject: Re: [PATCH v2] perf probe: Fix add event failed when 32-bit perf
 running in 64-bit kernel
To:     Masami Hiramatsu <mhiramat@kernel.org>
CC:     <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
        <mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
        <jolsa@redhat.com>, <namhyung@kernel.org>, <irogers@google.com>,
        <fche@redhat.com>, <ravi.bangoria@linux.ibm.com>,
        <yao.jin@linux.intel.com>, <srikar@linux.vnet.ibm.com>,
        <Jianlin.Lv@arm.com>, <lihuafei1@huawei.com>,
        <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20210715063723.11926-1-yangjihong1@huawei.com>
 <20210715180505.11d1209c91d37c239abe65d7@kernel.org>
From:   Yang Jihong <yangjihong1@huawei.com>
Message-ID: <de8ee605-4376-fc9d-e842-c3f488d673a7@huawei.com>
Date:   Thu, 15 Jul 2021 19:40:57 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20210715180505.11d1209c91d37c239abe65d7@kernel.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.102.248]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemm000003.china.huawei.com (7.185.36.128)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Hello Hiramatsu,

On 2021/7/15 17:05, Masami Hiramatsu wrote:
> On Thu, 15 Jul 2021 14:37:23 +0800
> Yang Jihong <yangjihong1@huawei.com> wrote:
> 
>> The "address" member  of "struct probe_trace_point" uses long data type.
>> If kernel is 64-bit and perf program is 32-bit, size of "address" variable is
>> 32 bits. As a result, upper 32 bits of address read from kernel are truncated,
>> An error occurs during address comparison in kprobe_warn_out_range function.
>>
>> Before:
>>
>>    # perf probe -a schedule
>>    schedule is out of .text, skip it.
>>      Error: Failed to add events.
>>
>> Solution:
>>    Change data type of "address" variable to u64 and change corresponding
>> address printing and value assignment.
>>
>> After:
>>
>>    # perf.new.new probe -a schedule
>>    Added new event:
>>      probe:schedule       (on schedule)
>>
>>    You can now use it in all perf tools, such as:
>>
>>            perf record -e probe:schedule -aR sleep 1
>>
>>    # perf probe -l
>>      probe:schedule       (on schedule@kernel/sched/core.c)
>>    # perf record -e probe:schedule -aR sleep 1
>>    [ perf record: Woken up 1 times to write data ]
>>    [ perf record: Captured and wrote 0.156 MB perf.data (1366 samples) ]
>>    # perf report --stdio
>>    # To display the perf.data header info, please use --header/--header-only options.
>>    #
>>    #
>>    # Total Lost Samples: 0
>>    #
>>    # Samples: 1K of event 'probe:schedule'
>>    # Event count (approx.): 1366
>>    #
>>    # Overhead  Command          Shared Object      Symbol
>>    # ........  ...............  .................  ............
>>    #
>>         6.22%  migration/0      [kernel.kallsyms]  [k] schedule
>>         6.22%  migration/1      [kernel.kallsyms]  [k] schedule
>>         6.22%  migration/2      [kernel.kallsyms]  [k] schedule
>>         6.22%  migration/3      [kernel.kallsyms]  [k] schedule
>>         6.15%  migration/10     [kernel.kallsyms]  [k] schedule
>>         6.15%  migration/11     [kernel.kallsyms]  [k] schedule
>>         6.15%  migration/12     [kernel.kallsyms]  [k] schedule
>>         6.15%  migration/13     [kernel.kallsyms]  [k] schedule
>>         6.15%  migration/14     [kernel.kallsyms]  [k] schedule
>>         6.15%  migration/15     [kernel.kallsyms]  [k] schedule
>>         6.15%  migration/4      [kernel.kallsyms]  [k] schedule
>>         6.15%  migration/5      [kernel.kallsyms]  [k] schedule
>>         6.15%  migration/6      [kernel.kallsyms]  [k] schedule
>>         6.15%  migration/7      [kernel.kallsyms]  [k] schedule
>>         6.15%  migration/8      [kernel.kallsyms]  [k] schedule
>>         6.15%  migration/9      [kernel.kallsyms]  [k] schedule
>>         0.22%  rcu_sched        [kernel.kallsyms]  [k] schedule
>>    ...
>>    #
>>    # (Cannot load tips.txt file, please install perf!)
>>    #
>>
> 
> OK, this looks good to me :)
> 
> Acked-by: Masami Hiramatsu <mhiramat@kernel.org>
> 
Thanks for the Acked :)

Jihong
