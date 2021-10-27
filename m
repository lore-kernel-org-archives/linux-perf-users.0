Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0D9AC433F5
	for <linux-perf-users@archiver.kernel.org>; Wed, 27 Oct 2021 12:31:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7FDDC6103C
	for <linux-perf-users@archiver.kernel.org>; Wed, 27 Oct 2021 12:31:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236079AbhJ0Mdn (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 27 Oct 2021 08:33:43 -0400
Received: from szxga08-in.huawei.com ([45.249.212.255]:26128 "EHLO
        szxga08-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231497AbhJ0Mdm (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 27 Oct 2021 08:33:42 -0400
Received: from dggeme762-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4HfSg15f6dz1DHtb;
        Wed, 27 Oct 2021 20:29:17 +0800 (CST)
Received: from huawei.com (10.67.189.2) by dggeme762-chm.china.huawei.com
 (10.3.19.108) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.15; Wed, 27
 Oct 2021 20:31:13 +0800
From:   Lexi Shao <shaolexi@huawei.com>
To:     <james.clark@arm.com>
CC:     <acme@kernel.org>, <alexander.shishkin@linux.intel.com>,
        <jolsa@redhat.com>, <linux-kernel@vger.kernel.org>,
        <linux-perf-users@vger.kernel.org>, <mark.rutland@arm.com>,
        <mingo@redhat.com>, <namhyung@kernel.org>, <nixiaoming@huawei.com>,
        <peterz@infradead.org>, <qiuxi1@huawei.com>, <shaolexi@huawei.com>,
        <wangbing6@huawei.com>
Subject: Re: [PATCH] perf symbol: ignore $a/$d symbols for ARM modules
Date:   Wed, 27 Oct 2021 20:31:08 +0800
Message-ID: <20211027123108.126944-1-shaolexi@huawei.com>
X-Mailer: git-send-email 2.12.3
In-Reply-To: <1b7fa65a-7587-b7c4-2dc0-d0f389200671@arm.com>
References: <1b7fa65a-7587-b7c4-2dc0-d0f389200671@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.189.2]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggeme762-chm.china.huawei.com (10.3.19.108)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On 27/10/2021 18:24, James Clark wrote:
>On 27/10/2021 10:52, Lexi Shao wrote:
>> On ARM machine, kernel symbols from modules can be resolved to $a
>> instead of printing the actual symbol name. Ignore symbols starting with
>> "$" when building kallsyms rbtree.
>> 
>> A sample stacktrace is shown as follows:
>> 
>> c0f2e39c schedule_hrtimeout+0x14 ([kernel.kallsyms])
>> bf4a66d8 $a+0x78 ([test_module])
>> c0a4f5f4 kthread+0x15c ([kernel.kallsyms])
>> c0a001f8 ret_from_fork+0x14 ([kernel.kallsyms])
>> 
>> On ARM machine, $a/$d symbols are used by the compiler to mark the
>> beginning of code/data part in code section. These symbols are filtered
>> out when linking vmlinux(see scripts/kallsyms.c ignored_prefixes), but
>> are left on modules. So there are $a symbols in /proc/kallsyms which
>> share the same addresses with the actual module symbols and confuses perf
>> when resolving symbols.
>
>Hi Lexi,
>
>Is it worth using or re-implementing the entire is_ignored_symbol() function
>from scripts/kallsyms.c? It seems like this change only fixes one occurrence,
>but is_ignored_symbol() has a big list of other cases.
>
>Unless those cases are different?
>
>Thanks
>James

Hi James,

I don't think it's necessary to cover all the cases listed in
is_ignored_symbol(). As long as the symbols are unique and not overlapping
with each other, they should't cause problems in resolving symbols. So most
of the cases in is_ignored_symbol() should be irrelevant.

Lexi

>
>> 
>> After this patch, the module symbol name is printed:
>> 
>> c0f2e39c schedule_hrtimeout+0x14 ([kernel.kallsyms])
>> bf4a66d8 test_func+0x78 ([test_module])
>> c0a4f5f4 kthread+0x15c ([kernel.kallsyms])
>> c0a001f8 ret_from_fork+0x14 ([kernel.kallsyms])
>> 
>> Signed-off-by: Lexi Shao <shaolexi@huawei.com>
>> ---
>>  tools/perf/util/symbol.c | 4 ++++
>>  1 file changed, 4 insertions(+)
>> 
>> diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
>> index 0fc9a5410739..35116aed74eb 100644
>> --- a/tools/perf/util/symbol.c
>> +++ b/tools/perf/util/symbol.c
>> @@ -702,6 +702,10 @@ static int map__process_kallsym_symbol(void *arg, const char *name,
>>  	if (!symbol_type__filter(type))
>>  		return 0;
>>  
>> +	/* Ignore local symbols for ARM modules */
>> +	if (name[0] == '$')
>> +		return 0;
>> +
>>  	/*
>>  	 * module symbols are not sorted so we add all
>>  	 * symbols, setting length to 0, and rely on
>>
>
