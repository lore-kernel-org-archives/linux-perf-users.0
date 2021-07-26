Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEC7FC4338F
	for <linux-perf-users@archiver.kernel.org>; Mon, 26 Jul 2021 15:19:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C7CB260F51
	for <linux-perf-users@archiver.kernel.org>; Mon, 26 Jul 2021 15:19:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234990AbhGZOjB (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 26 Jul 2021 10:39:01 -0400
Received: from foss.arm.com ([217.140.110.172]:53590 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234725AbhGZOjB (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 26 Jul 2021 10:39:01 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D6F8A1042;
        Mon, 26 Jul 2021 08:19:29 -0700 (PDT)
Received: from [10.57.38.207] (unknown [10.57.38.207])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B5FBA3F66F;
        Mon, 26 Jul 2021 08:19:27 -0700 (PDT)
Subject: Re: [PATCH 2/2] perf annotate: Add error log in symbol__annotate()
To:     Li Huafei <lihuafei1@huawei.com>, acme@kernel.org, jolsa@kernel.org
Cc:     peterz@infradead.org, mark.rutland@arm.com, mingo@redhat.com,
        alexander.shishkin@linux.intel.com, namhyung@kernel.org,
        mliska@suse.cz, irogers@google.com, dzhu@wavecomp.com,
        rickyman7@gmail.com, yao.jin@linux.intel.com,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        zhangjinhao2@huawei.com
References: <20210726123854.13463-1-lihuafei1@huawei.com>
 <20210726123854.13463-2-lihuafei1@huawei.com>
From:   James Clark <james.clark@arm.com>
Message-ID: <7106d95c-2a97-cd8b-b361-7f498a1b0a5f@arm.com>
Date:   Mon, 26 Jul 2021 16:19:26 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210726123854.13463-2-lihuafei1@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org



On 26/07/2021 13:38, Li Huafei wrote:
> When users use the perf annotate feature on unsupported machines, error
> logs should be printed for user feedback.
> 
> Signed-off-by: Li Huafei <lihuafei1@huawei.com>
> ---
>  tools/perf/util/annotate.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
> index aa04a3655236..cb280de3369f 100644
> --- a/tools/perf/util/annotate.c
> +++ b/tools/perf/util/annotate.c
> @@ -2192,8 +2192,10 @@ int symbol__annotate(struct map_symbol *ms, struct evsel *evsel,
>  		return errno;
>  
>  	args.arch = arch = arch__find(arch_name);
> -	if (arch == NULL)
> +	if (arch == NULL) {
> +		pr_err("%s: unsupported arch %s\n", __func__, arch_name);
>  		return ENOTSUP;
> +	}
>  
>  	if (parch)
>  		*parch = arch;
> 

This one is missing the v2 in the summary so it doesn't work with tools like b4,
but I applied it manually and it works.

Reviewed-by: James Clark <james.clark@arm.com>
