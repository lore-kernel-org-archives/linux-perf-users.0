Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.4 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2818FC4338F
	for <linux-perf-users@archiver.kernel.org>; Wed,  4 Aug 2021 17:19:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 073A860FC4
	for <linux-perf-users@archiver.kernel.org>; Wed,  4 Aug 2021 17:19:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239835AbhHDRTm (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 4 Aug 2021 13:19:42 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:3583 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239832AbhHDRTl (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 4 Aug 2021 13:19:41 -0400
Received: from fraeml713-chm.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Gfz4K2sQmz6F80M;
        Thu,  5 Aug 2021 01:19:13 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml713-chm.china.huawei.com (10.206.15.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 4 Aug 2021 19:19:26 +0200
Received: from [10.47.90.65] (10.47.90.65) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Wed, 4 Aug 2021
 18:19:25 +0100
Subject: Re: [PATCH] perf test: Make metric testing more robust.
To:     Ian Rogers <irogers@google.com>
CC:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        "Namhyung Kim" <namhyung@kernel.org>,
        Kajol Jain <kjain@linux.ibm.com>,
        linux-perf-users <linux-perf-users@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Stephane Eranian <eranian@google.com>
References: <20210804072547.1728924-1-irogers@google.com>
 <74ddb02a-1cdc-24fc-781e-4c87feb638fa@huawei.com>
 <CAP-5=fWWvGi8gGfwGORF-4y7V6G_gCxY7=SX2zo_cyxKxTEf+A@mail.gmail.com>
From:   John Garry <john.garry@huawei.com>
Message-ID: <3e853906-f758-8ad6-2297-27e4f097591a@huawei.com>
Date:   Wed, 4 Aug 2021 18:18:56 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <CAP-5=fWWvGi8gGfwGORF-4y7V6G_gCxY7=SX2zo_cyxKxTEf+A@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.47.90.65]
X-ClientProxiedBy: lhreml751-chm.china.huawei.com (10.201.108.201) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On 04/08/2021 15:55, Ian Rogers wrote:
> 
> 
> On Wed, Aug 4, 2021, 2:11 AM John Garry <john.garry@huawei.com 
> <mailto:john.garry@huawei.com>> wrote:
> 
>     On 04/08/2021 08:25, Ian Rogers wrote:
>      > When testing metric expressions we fake counter values from 1 going
>      > upward. For some metrics this can yield negative values that are
>     clipped
>      > to zero, and then cause divide by zero failures. A workaround for
>     this
>      > case is to try a second time with counter values going in the
>     opposite
>      > direction.
>      >
>      > This case was seen in a metric like:
>      >    event1 / max(event2 - event3, 0)
> 
>     is this the standard method to make the metric evaluation fail when
>     results are not as expected? In this example, event2 should be greater
>     than event3 always. Dividing by max(x, 0) would seem a bit silly.
> 
> 
> I wouldn't say it was standard but it is in a metric a third party gave 
> us.

I agree that making it more robust is a good thing. But masking bogus 
expressions isn't great. After all, we're here to find them :)

 > It would be possible to get the same test failure on more standard
 > expressions, so it would be nice if these tests were more robust.

so something like this would fail also:
event1 / (event2 + event3 - 1 - event4)

assuming we have ascending values from 1 for event1. And this would seem 
a valid expression.

Anyway, it would be nice if we could reject max(0, x) and any divide by 
negative numbers, apart from your change.

Cheers,
john


>      >
>      > Signed-off-by: Ian Rogers <irogers@google.com
>     <mailto:irogers@google.com>>
>      > ---
>      >   tools/perf/tests/pmu-events.c | 32 ++++++++++++++++++++++++++------
>      >   1 file changed, 26 insertions(+), 6 deletions(-)
>      >
>      > diff --git a/tools/perf/tests/pmu-events.c
>     b/tools/perf/tests/pmu-events.c
>      > index b8aff8fb50d8..6c1cd58605c1 100644
>      > --- a/tools/perf/tests/pmu-events.c
>      > +++ b/tools/perf/tests/pmu-events.c
>      > @@ -600,8 +600,18 @@ static int test_parsing(void)
>      >                       }
>      >
>      >                       if (expr__parse(&result, &ctx,
>     pe->metric_expr, 0)) {
>      > -                             expr_failure("Parse failed", map, pe);
>      > -                             ret++;
>      > +                             /*
>      > +                              * Parsing failed, make numbers go
>     from large to
>      > +                              * small which can resolve divide
>     by zero
>      > +                              * issues.
>      > +                              */
>      > +                             k = 1024;
>      > +                             hashmap__for_each_entry((&ctx.ids),
>     cur, bkt)
>      > +                                     expr__add_id_val(&ctx,
>     strdup(cur->key), k--);
>      > +                             if (expr__parse(&result, &ctx,
>     pe->metric_expr, 0)) {
>      > +                                     expr_failure("Parse
>     failed", map, pe);
>      > +                                     ret++;
>      > +                             }
>      >                       }
>      >                       expr__ctx_clear(&ctx);
>      >               }
>      > @@ -656,10 +666,20 @@ static int metric_parse_fake(const char *str)
>      >               }
>      >       }
>      >
>      > -     if (expr__parse(&result, &ctx, str, 0))
>      > -             pr_err("expr__parse failed\n");
>      > -     else
>      > -             ret = 0;
>      > +     ret = 0;
>      > +     if (expr__parse(&result, &ctx, str, 0)) {
>      > +             /*
>      > +              * Parsing failed, make numbers go from large to
>     small which can
>      > +              * resolve divide by zero issues.
>      > +              */
>      > +             i = 1024;
>      > +             hashmap__for_each_entry((&ctx.ids), cur, bkt)
>      > +                     expr__add_id_val(&ctx, strdup(cur->key), i--);
>      > +             if (expr__parse(&result, &ctx, str, 0)) {
>      > +                     pr_err("expr__parse failed\n");
>      > +                     ret = -1;
>      > +             }
>      > +     }
>      >
>      >   out:
>      >       expr__ctx_clear(&ctx);
>      >
> 

