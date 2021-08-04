Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.4 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54A7DC4338F
	for <linux-perf-users@archiver.kernel.org>; Wed,  4 Aug 2021 09:11:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3235360EE7
	for <linux-perf-users@archiver.kernel.org>; Wed,  4 Aug 2021 09:11:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235791AbhHDJL6 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 4 Aug 2021 05:11:58 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:3575 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235831AbhHDJLz (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 4 Aug 2021 05:11:55 -0400
Received: from fraeml738-chm.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4GfmFX5zKfz6DKYv;
        Wed,  4 Aug 2021 17:11:28 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml738-chm.china.huawei.com (10.206.15.219) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 4 Aug 2021 11:11:41 +0200
Received: from [10.47.90.65] (10.47.90.65) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Wed, 4 Aug 2021
 10:11:40 +0100
Subject: Re: [PATCH] perf test: Make metric testing more robust.
To:     Ian Rogers <irogers@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        "Namhyung Kim" <namhyung@kernel.org>,
        Kajol Jain <kjain@linux.ibm.com>,
        <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <eranian@google.com>
References: <20210804072547.1728924-1-irogers@google.com>
From:   John Garry <john.garry@huawei.com>
Message-ID: <74ddb02a-1cdc-24fc-781e-4c87feb638fa@huawei.com>
Date:   Wed, 4 Aug 2021 10:11:13 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <20210804072547.1728924-1-irogers@google.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.90.65]
X-ClientProxiedBy: lhreml751-chm.china.huawei.com (10.201.108.201) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On 04/08/2021 08:25, Ian Rogers wrote:
> When testing metric expressions we fake counter values from 1 going
> upward. For some metrics this can yield negative values that are clipped
> to zero, and then cause divide by zero failures. A workaround for this
> case is to try a second time with counter values going in the opposite
> direction.
> 
> This case was seen in a metric like:
>    event1 / max(event2 - event3, 0)

is this the standard method to make the metric evaluation fail when 
results are not as expected? In this example, event2 should be greater 
than event3 always. Dividing by max(x, 0) would seem a bit silly.

thanks,
John

> 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>   tools/perf/tests/pmu-events.c | 32 ++++++++++++++++++++++++++------
>   1 file changed, 26 insertions(+), 6 deletions(-)
> 
> diff --git a/tools/perf/tests/pmu-events.c b/tools/perf/tests/pmu-events.c
> index b8aff8fb50d8..6c1cd58605c1 100644
> --- a/tools/perf/tests/pmu-events.c
> +++ b/tools/perf/tests/pmu-events.c
> @@ -600,8 +600,18 @@ static int test_parsing(void)
>   			}
>   
>   			if (expr__parse(&result, &ctx, pe->metric_expr, 0)) {
> -				expr_failure("Parse failed", map, pe);
> -				ret++;
> +				/*
> +				 * Parsing failed, make numbers go from large to
> +				 * small which can resolve divide by zero
> +				 * issues.
> +				 */
> +				k = 1024;
> +				hashmap__for_each_entry((&ctx.ids), cur, bkt)
> +					expr__add_id_val(&ctx, strdup(cur->key), k--);
> +				if (expr__parse(&result, &ctx, pe->metric_expr, 0)) {
> +					expr_failure("Parse failed", map, pe);
> +					ret++;
> +				}
>   			}
>   			expr__ctx_clear(&ctx);
>   		}
> @@ -656,10 +666,20 @@ static int metric_parse_fake(const char *str)
>   		}
>   	}
>   
> -	if (expr__parse(&result, &ctx, str, 0))
> -		pr_err("expr__parse failed\n");
> -	else
> -		ret = 0;
> +	ret = 0;
> +	if (expr__parse(&result, &ctx, str, 0)) {
> +		/*
> +		 * Parsing failed, make numbers go from large to small which can
> +		 * resolve divide by zero issues.
> +		 */
> +		i = 1024;
> +		hashmap__for_each_entry((&ctx.ids), cur, bkt)
> +			expr__add_id_val(&ctx, strdup(cur->key), i--);
> +		if (expr__parse(&result, &ctx, str, 0)) {
> +			pr_err("expr__parse failed\n");
> +			ret = -1;
> +		}
> +	}
>   
>   out:
>   	expr__ctx_clear(&ctx);
> 

