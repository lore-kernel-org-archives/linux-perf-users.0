Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A721C4320A
	for <linux-perf-users@archiver.kernel.org>; Mon, 26 Jul 2021 10:04:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D825360F11
	for <linux-perf-users@archiver.kernel.org>; Mon, 26 Jul 2021 10:04:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232699AbhGZJXp (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 26 Jul 2021 05:23:45 -0400
Received: from foss.arm.com ([217.140.110.172]:49216 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232617AbhGZJXm (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 26 Jul 2021 05:23:42 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 22441106F;
        Mon, 26 Jul 2021 03:04:11 -0700 (PDT)
Received: from [10.57.36.95] (unknown [10.57.36.95])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CCDFC3F70D;
        Mon, 26 Jul 2021 03:04:07 -0700 (PDT)
Subject: Re: [PATCH] perf env: Normalize aarch64.* to arm64 in
 normalize_arch()
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Li Huafei <lihuafei1@huawei.com>
Cc:     jolsa@kernel.org, peterz@infradead.org, mark.rutland@arm.com,
        mingo@redhat.com, alexander.shishkin@linux.intel.com,
        namhyung@kernel.org, mliska@suse.cz, irogers@google.com,
        dzhu@wavecomp.com, rickyman7@gmail.com, yao.jin@linux.intel.com,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        zhangjinhao2@huawei.com
References: <20210723014944.214887-1-lihuafei1@huawei.com>
 <YPsXSRi+8z5ozc/U@kernel.org>
From:   James Clark <james.clark@arm.com>
Message-ID: <d4db6cdd-1cb5-5ce9-47b3-41f438f379af@arm.com>
Date:   Mon, 26 Jul 2021 11:04:10 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <YPsXSRi+8z5ozc/U@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org



On 23/07/2021 20:23, Arnaldo Carvalho de Melo wrote:
> Em Fri, Jul 23, 2021 at 09:49:44AM +0800, Li Huafei escreveu:
>> On my aarch64 big endian machine, the perf annotate does not work.
>>
>>  # perf annotate
>>   Percent |      Source code & Disassembly of [kernel.kallsyms] for cycles (253 samples, percent: local period)
>>  --------------------------------------------------------------------------------------------------------------
>>   Percent |      Source code & Disassembly of [kernel.kallsyms] for cycles (1 samples, percent: local period)
>>  ------------------------------------------------------------------------------------------------------------
>>   Percent |      Source code & Disassembly of [kernel.kallsyms] for cycles (47 samples, percent: local period)
>>  -------------------------------------------------------------------------------------------------------------
>>  ...
>>
>> This is because the arch_find() function uses the normalized architecture
>> name provided by normalize_arch(), and my machine's architecture name
>> aarch64_be is not normalized to arm64.  Like other architectures such as
>> arm and powerpc, we can fuzzy match the architecture names associated with
>> aarch64.* and normalize them.
> 
> This looks ok modulo fixing the problem and adding that extra pr_err()
> in a single patch, please split this into two.
> 
> Also I fail to see why c34df25b40c2 introduced this problem :-\

I checked the parent commit of c34df25b40c2 and set the architecture to "aarch64_be"
but it doesn't work either, so I also don't see any regressions.

> 
> Can some ARM person ack/review this, please?
> 
> - Arnaldo
>  
>> Fixes: c34df25b40c2 ("perf annotate: Add symbol__annotate function")
>> Signed-off-by: Li Huafei <lihuafei1@huawei.com>
>> ---
>>  tools/perf/util/annotate.c | 4 +++-
>>  tools/perf/util/env.c      | 2 +-
>>  2 files changed, 4 insertions(+), 2 deletions(-)
>>
>> diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
>> index aa04a3655236..cb280de3369f 100644
>> --- a/tools/perf/util/annotate.c
>> +++ b/tools/perf/util/annotate.c
>> @@ -2192,8 +2192,10 @@ int symbol__annotate(struct map_symbol *ms, struct evsel *evsel,
>>  		return errno;
>>  
>>  	args.arch = arch = arch__find(arch_name);
>> -	if (arch == NULL)
>> +	if (arch == NULL) {
>> +		pr_err("%s: unsupported arch %s\n", __func__, arch_name);
>>  		return ENOTSUP;
>> +	}
>>  
>>  	if (parch)
>>  		*parch = arch;
>> diff --git a/tools/perf/util/env.c b/tools/perf/util/env.c
>> index cec2e6cad8aa..a91da1e9b201 100644
>> --- a/tools/perf/util/env.c
>> +++ b/tools/perf/util/env.c
>> @@ -349,7 +349,7 @@ static const char *normalize_arch(char *arch)
>>  		return "x86";
>>  	if (!strcmp(arch, "sun4u") || !strncmp(arch, "sparc", 5))
>>  		return "sparc";
>> -	if (!strcmp(arch, "aarch64") || !strcmp(arch, "arm64"))
>> +	if (!strncmp(arch, "aarch64", 7) || !strcmp(arch, "arm64"))

This seems ok to me, but a quick google shows some references to "arm64_be".
I don't know if this could ever get into perf, but most of the other ones
search for prefixes, so it probably doesn't hurt to do strcmp(arch, "arm64", 5)
as well.

Thanks
James

>>  		return "arm64";
>>  	if (!strncmp(arch, "arm", 3) || !strcmp(arch, "sa110"))
>>  		return "arm";
>> -- 
>> 2.17.1
>>
> 
