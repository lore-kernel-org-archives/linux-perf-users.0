Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E11ACC4338F
	for <linux-perf-users@archiver.kernel.org>; Mon, 26 Jul 2021 13:04:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B4C0060F46
	for <linux-perf-users@archiver.kernel.org>; Mon, 26 Jul 2021 13:04:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233463AbhGZMYG (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 26 Jul 2021 08:24:06 -0400
Received: from szxga08-in.huawei.com ([45.249.212.255]:12265 "EHLO
        szxga08-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232702AbhGZMYC (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 26 Jul 2021 08:24:02 -0400
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4GYKjl5cF6z1CNvV;
        Mon, 26 Jul 2021 20:58:35 +0800 (CST)
Received: from dggema753-chm.china.huawei.com (10.1.198.195) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Mon, 26 Jul 2021 21:04:29 +0800
Received: from [10.67.110.237] (10.67.110.237) by
 dggema753-chm.china.huawei.com (10.1.198.195) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Mon, 26 Jul 2021 21:04:28 +0800
Subject: Re: [PATCH] perf env: Normalize aarch64.* to arm64 in
 normalize_arch()
To:     James Clark <james.clark@arm.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
CC:     <jolsa@kernel.org>, <peterz@infradead.org>, <mark.rutland@arm.com>,
        <mingo@redhat.com>, <alexander.shishkin@linux.intel.com>,
        <namhyung@kernel.org>, <mliska@suse.cz>, <irogers@google.com>,
        <dzhu@wavecomp.com>, <rickyman7@gmail.com>,
        <yao.jin@linux.intel.com>, <linux-perf-users@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <zhangjinhao2@huawei.com>
References: <20210723014944.214887-1-lihuafei1@huawei.com>
 <YPsXSRi+8z5ozc/U@kernel.org> <d4db6cdd-1cb5-5ce9-47b3-41f438f379af@arm.com>
From:   Li Huafei <lihuafei1@huawei.com>
Message-ID: <80131b44-ca47-b5ee-48e4-fed4bb2b66fa@huawei.com>
Date:   Mon, 26 Jul 2021 21:04:28 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <d4db6cdd-1cb5-5ce9-47b3-41f438f379af@arm.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.110.237]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggema753-chm.china.huawei.com (10.1.198.195)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org



On 2021/7/26 18:04, James Clark wrote:
> 
> 
> On 23/07/2021 20:23, Arnaldo Carvalho de Melo wrote:
>> Em Fri, Jul 23, 2021 at 09:49:44AM +0800, Li Huafei escreveu:
>>> On my aarch64 big endian machine, the perf annotate does not work.
>>>
>>>   # perf annotate
>>>    Percent |      Source code & Disassembly of [kernel.kallsyms] for cycles (253 samples, percent: local period)
>>>   --------------------------------------------------------------------------------------------------------------
>>>    Percent |      Source code & Disassembly of [kernel.kallsyms] for cycles (1 samples, percent: local period)
>>>   ------------------------------------------------------------------------------------------------------------
>>>    Percent |      Source code & Disassembly of [kernel.kallsyms] for cycles (47 samples, percent: local period)
>>>   -------------------------------------------------------------------------------------------------------------
>>>   ...
>>>
>>> This is because the arch_find() function uses the normalized architecture
>>> name provided by normalize_arch(), and my machine's architecture name
>>> aarch64_be is not normalized to arm64.  Like other architectures such as
>>> arm and powerpc, we can fuzzy match the architecture names associated with
>>> aarch64.* and normalize them.
>>
>> This looks ok modulo fixing the problem and adding that extra pr_err()
>> in a single patch, please split this into two.

OK, I've sent the patch set for v2, which puts pr_err() in a single patch:
https://lore.kernel.org/patchwork/patch/1467154/

>>
>> Also I fail to see why c34df25b40c2 introduced this problem :-\
> 
> I checked the parent commit of c34df25b40c2 and set the architecture to "aarch64_be"
> but it doesn't work either, so I also don't see any regressions.
> 

Sorry, this may be my mistake. It should be that perf annotate adds 
support for aarch64_be, not that there is a bug in the existing code. In 
v2, I've removed the "Fixes" tag.

>>
>> Can some ARM person ack/review this, please?
>>
>> - Arnaldo
>>   
>>> Fixes: c34df25b40c2 ("perf annotate: Add symbol__annotate function")
>>> Signed-off-by: Li Huafei <lihuafei1@huawei.com>
>>> ---
>>>   tools/perf/util/annotate.c | 4 +++-
>>>   tools/perf/util/env.c      | 2 +-
>>>   2 files changed, 4 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
>>> index aa04a3655236..cb280de3369f 100644
>>> --- a/tools/perf/util/annotate.c
>>> +++ b/tools/perf/util/annotate.c
>>> @@ -2192,8 +2192,10 @@ int symbol__annotate(struct map_symbol *ms, struct evsel *evsel,
>>>   		return errno;
>>>   
>>>   	args.arch = arch = arch__find(arch_name);
>>> -	if (arch == NULL)
>>> +	if (arch == NULL) {
>>> +		pr_err("%s: unsupported arch %s\n", __func__, arch_name);
>>>   		return ENOTSUP;
>>> +	}
>>>   
>>>   	if (parch)
>>>   		*parch = arch;
>>> diff --git a/tools/perf/util/env.c b/tools/perf/util/env.c
>>> index cec2e6cad8aa..a91da1e9b201 100644
>>> --- a/tools/perf/util/env.c
>>> +++ b/tools/perf/util/env.c
>>> @@ -349,7 +349,7 @@ static const char *normalize_arch(char *arch)
>>>   		return "x86";
>>>   	if (!strcmp(arch, "sun4u") || !strncmp(arch, "sparc", 5))
>>>   		return "sparc";
>>> -	if (!strcmp(arch, "aarch64") || !strcmp(arch, "arm64"))
>>> +	if (!strncmp(arch, "aarch64", 7) || !strcmp(arch, "arm64"))
> 
> This seems ok to me, but a quick google shows some references to "arm64_be".
> I don't know if this could ever get into perf, but most of the other ones
> search for prefixes, so it probably doesn't hurt to do strcmp(arch, "arm64", 5)
> as well.

In v2, I also added a normalization of "arm64_be". After this patch, 
perf annotate seems to work fine on my aarch64_be machine. And I checked 
other source files using perf_env__arch():

  - arch/common.c
  - builtin-trace.c
  - util/sample-raw.c
  - util/thread-stack.c
  - util/unwind-libunwind.c

Looks like it's OK.

Thank you Arnaldo and James for the review.

Huafei
> 
> Thanks
> James
> 
>>>   		return "arm64";
>>>   	if (!strncmp(arch, "arm", 3) || !strcmp(arch, "sa110"))
>>>   		return "arm";
>>> -- 
>>> 2.17.1
>>>
>>
> .
> 
