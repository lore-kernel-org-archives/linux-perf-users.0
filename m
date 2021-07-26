Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23BE1C4338F
	for <linux-perf-users@archiver.kernel.org>; Mon, 26 Jul 2021 15:18:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 00F9A60F59
	for <linux-perf-users@archiver.kernel.org>; Mon, 26 Jul 2021 15:18:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234423AbhGZOhx (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 26 Jul 2021 10:37:53 -0400
Received: from foss.arm.com ([217.140.110.172]:53552 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234925AbhGZOhw (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 26 Jul 2021 10:37:52 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 346121042;
        Mon, 26 Jul 2021 08:18:21 -0700 (PDT)
Received: from [10.57.38.207] (unknown [10.57.38.207])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 156AB3F66F;
        Mon, 26 Jul 2021 08:18:18 -0700 (PDT)
Subject: Re: [PATCH v2 1/2] perf env: Normalize aarch64.* and arm64.* to arm64
 in normalize_arch()
To:     Li Huafei <lihuafei1@huawei.com>, acme@kernel.org, jolsa@kernel.org
Cc:     peterz@infradead.org, mark.rutland@arm.com, mingo@redhat.com,
        alexander.shishkin@linux.intel.com, namhyung@kernel.org,
        mliska@suse.cz, irogers@google.com, dzhu@wavecomp.com,
        rickyman7@gmail.com, yao.jin@linux.intel.com,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        zhangjinhao2@huawei.com
References: <20210726123854.13463-1-lihuafei1@huawei.com>
From:   James Clark <james.clark@arm.com>
Message-ID: <9530d369-cf59-ee80-69e9-b8d4ae24182f@arm.com>
Date:   Mon, 26 Jul 2021 16:18:17 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210726123854.13463-1-lihuafei1@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org



On 26/07/2021 13:38, Li Huafei wrote:
> On my aarch64 big endian machine, the perf annotate does not work.
> 
>  # perf annotate
>   Percent |      Source code & Disassembly of [kernel.kallsyms] for cycles (253 samples, percent: local period)
>  --------------------------------------------------------------------------------------------------------------
>   Percent |      Source code & Disassembly of [kernel.kallsyms] for cycles (1 samples, percent: local period)
>  ------------------------------------------------------------------------------------------------------------
>   Percent |      Source code & Disassembly of [kernel.kallsyms] for cycles (47 samples, percent: local period)
>  -------------------------------------------------------------------------------------------------------------
>  ...
> 
> This is because the arch_find() function uses the normalized architecture
> name provided by normalize_arch(), and my machine's architecture name
> aarch64_be is not normalized to arm64.  Like other architectures such as
> arm and powerpc, we can fuzzy match the architecture names associated with
> aarch64.* and normalize them.
> 
> It seems that there is also arm64_be architecture name, which we also
> normalize to arm64.
> 
> Signed-off-by: Li Huafei <lihuafei1@huawei.com>
> ---
> Changes in v2:
>  - The error log added in symbol__annotate() is put into a single patch
>  - Remove the "Fixes" tag
>  - According to James' suggestion, "arm64_be" is also normalized to
>    "arm64"
> 
>  tools/perf/util/env.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/perf/util/env.c b/tools/perf/util/env.c
> index cec2e6cad8aa..ab341050be46 100644
> --- a/tools/perf/util/env.c
> +++ b/tools/perf/util/env.c
> @@ -349,7 +349,7 @@ static const char *normalize_arch(char *arch)
>  		return "x86";
>  	if (!strcmp(arch, "sun4u") || !strncmp(arch, "sparc", 5))
>  		return "sparc";
> -	if (!strcmp(arch, "aarch64") || !strcmp(arch, "arm64"))
> +	if (!strncmp(arch, "aarch64", 7) || !strncmp(arch, "arm64", 5))
>  		return "arm64";
>  	if (!strncmp(arch, "arm", 3) || !strcmp(arch, "sa110"))
>  		return "arm";
> 

Reviewed-by: James Clark <james.clark@arm.com>

