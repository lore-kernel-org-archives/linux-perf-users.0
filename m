Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8E63C433F5
	for <linux-perf-users@archiver.kernel.org>; Tue, 28 Sep 2021 17:59:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AF8416120C
	for <linux-perf-users@archiver.kernel.org>; Tue, 28 Sep 2021 17:59:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242033AbhI1SBg (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 28 Sep 2021 14:01:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236453AbhI1SBg (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 28 Sep 2021 14:01:36 -0400
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com [IPv6:2607:f8b0:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D768C061745
        for <linux-perf-users@vger.kernel.org>; Tue, 28 Sep 2021 10:59:56 -0700 (PDT)
Received: by mail-il1-x135.google.com with SMTP id r9so2757346ile.5
        for <linux-perf-users@vger.kernel.org>; Tue, 28 Sep 2021 10:59:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2BniPafuDoFdlymopELQXkB/zQh7F6LVoUvjWNE/VRg=;
        b=glkMq8CqzAY65V+OfwsRWbZMfrbm5gk2blCTp6HIIduX5J0r1s9yNPz7ULbG20e6TW
         nwe2TsaMYxdv3YxGyKZZT+BqyhO+hIwkGFvXsYrRxwF/bZA8XvYQ95Ax1f3GmffZ2wzw
         QMKk7kYfUteYb7dtrXOW1iFNZ7lxxf/CNN6SayYgUF191WpLw8WXyuWz95lyCm4hNNio
         1O7cVUTfjZtzRriKK6cfo59a/Zwen6v6mHn5tdw8fibVHsu11wOAariYsIKNcXsZs9fj
         CCizVcbfKkS7PteVgyObIKXxeBZHnjKXaQxZsmw2SciE+7EwEHNKrH3LHLXs7SUVmsAo
         PWBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2BniPafuDoFdlymopELQXkB/zQh7F6LVoUvjWNE/VRg=;
        b=MFTDbhg7kGUJqJG/S1+YDntXVE/4mklqiUTRpENc1JZnyT3372wZGe+mTQB5jnR5SP
         PSnjqkRUyZdtwSKmtaWTdvNjYbs5tyFZcznD1sha6iDP02xywryfl2qLDPkvld5L9B1h
         sKr9Dz1fUXIYiS59qORUgPjgxQR/WaAAMl3R+YLeeRy/tVV1SnMAWWbCNfLh0V3DhT54
         /DkMpcBwVnbk2i/jr3XDufaOSTOd4cEBh0Adn34I5XQlGB1NL+CkCDtTlKgZ1844oQsf
         OGMrDN5As81Oepjq17/LLQttGSCSdPxhxusqQnG9QfD41mxC3xXGfo4ae1PAe1ZdwVjz
         sXxA==
X-Gm-Message-State: AOAM532ZdWIoNZQzl7JHLhwIb6Nsn3QCq5YdS74xSjrj+UHxw7FtUbRJ
        opEBnTN6woAd5Eshwv8s81pF0h4EgeB79cPK/UYhKg==
X-Google-Smtp-Source: ABdhPJzQriZBhaXa8Nz8rzqkeHFOVtzxDfH7dKuTTCQu8Bb7gYIbKnLCthu8TUtgv0Ac7wqnKtun73U9BkEpVpidxz0=
X-Received: by 2002:a05:6e02:b23:: with SMTP id e3mr5253595ilu.53.1632851995505;
 Tue, 28 Sep 2021 10:59:55 -0700 (PDT)
MIME-Version: 1.0
References: <1631795665-240946-1-git-send-email-john.garry@huawei.com> <1631795665-240946-2-git-send-email-john.garry@huawei.com>
In-Reply-To: <1631795665-240946-2-git-send-email-john.garry@huawei.com>
From:   Ian Rogers <irogers@google.com>
Date:   Tue, 28 Sep 2021 10:59:42 -0700
Message-ID: <CAP-5=fVG3_p3Xf3s6FnpSRFwt3+CxitPZwRK0fMbz2t8WZaSEw@mail.gmail.com>
Subject: Re: [PATCH 1/5] perf parse-events: Set numeric term config
To:     John Garry <john.garry@huawei.com>
Cc:     will@kernel.org, mathieu.poirier@linaro.org, leo.yan@linaro.org,
        peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, namhyung@kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        linuxarm@huawei.com, zhangshaokun@hisilicon.com,
        liuqi115@huawei.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Thu, Sep 16, 2021 at 5:39 AM John Garry <john.garry@huawei.com> wrote:
>
> For numeric terms, the config field may be NULL as it is not set from the
> l+y parsing.
>
> Fix by setting the term config from the term type name.
>
> Also fix up the pmu-events test to set the alias strings to set the period
> term properly, and fix up parse-events test to check the term config
> string.
>
> Signed-off-by: John Garry <john.garry@huawei.com>

Acked-by: Ian Rogers <irogers@google.com>

Having this would be very useful with an issue I'm looking into.

Thanks,
Ian

> ---
>  tools/perf/tests/parse-events.c | 8 ++++----
>  tools/perf/tests/pmu-events.c   | 6 +++---
>  tools/perf/util/parse-events.c  | 2 +-
>  3 files changed, 8 insertions(+), 8 deletions(-)
>
> diff --git a/tools/perf/tests/parse-events.c b/tools/perf/tests/parse-events.c
> index fd3556cc9ad4..8875e388563e 100644
> --- a/tools/perf/tests/parse-events.c
> +++ b/tools/perf/tests/parse-events.c
> @@ -605,7 +605,7 @@ static int test__checkterms_simple(struct list_head *terms)
>         TEST_ASSERT_VAL("wrong type val",
>                         term->type_val == PARSE_EVENTS__TERM_TYPE_NUM);
>         TEST_ASSERT_VAL("wrong val", term->val.num == 10);
> -       TEST_ASSERT_VAL("wrong config", !term->config);
> +       TEST_ASSERT_VAL("wrong config", !strcmp(term->config, "config"));
>
>         /* config1 */
>         term = list_entry(term->list.next, struct parse_events_term, list);
> @@ -614,7 +614,7 @@ static int test__checkterms_simple(struct list_head *terms)
>         TEST_ASSERT_VAL("wrong type val",
>                         term->type_val == PARSE_EVENTS__TERM_TYPE_NUM);
>         TEST_ASSERT_VAL("wrong val", term->val.num == 1);
> -       TEST_ASSERT_VAL("wrong config", !term->config);
> +       TEST_ASSERT_VAL("wrong config", !strcmp(term->config, "config1"));
>
>         /* config2=3 */
>         term = list_entry(term->list.next, struct parse_events_term, list);
> @@ -623,7 +623,7 @@ static int test__checkterms_simple(struct list_head *terms)
>         TEST_ASSERT_VAL("wrong type val",
>                         term->type_val == PARSE_EVENTS__TERM_TYPE_NUM);
>         TEST_ASSERT_VAL("wrong val", term->val.num == 3);
> -       TEST_ASSERT_VAL("wrong config", !term->config);
> +       TEST_ASSERT_VAL("wrong config", !strcmp(term->config, "config2"));
>
>         /* umask=1*/
>         term = list_entry(term->list.next, struct parse_events_term, list);
> @@ -661,7 +661,7 @@ static int test__checkterms_simple(struct list_head *terms)
>         TEST_ASSERT_VAL("wrong type val",
>                         term->type_val == PARSE_EVENTS__TERM_TYPE_NUM);
>         TEST_ASSERT_VAL("wrong val", term->val.num == 0xead);
> -       TEST_ASSERT_VAL("wrong config", !term->config);
> +       TEST_ASSERT_VAL("wrong config", !strcmp(term->config, "config"));
>         return 0;
>  }
>
> diff --git a/tools/perf/tests/pmu-events.c b/tools/perf/tests/pmu-events.c
> index 43743cf719ef..8c5a6ba1cb14 100644
> --- a/tools/perf/tests/pmu-events.c
> +++ b/tools/perf/tests/pmu-events.c
> @@ -67,7 +67,7 @@ static const struct perf_pmu_test_event segment_reg_loads_any = {
>                 .desc = "Number of segment register loads",
>                 .topic = "other",
>         },
> -       .alias_str = "umask=0x80,(null)=0x30d40,event=0x6",
> +       .alias_str = "umask=0x80,period=0x30d40,event=0x6",
>         .alias_long_desc = "Number of segment register loads",
>  };
>
> @@ -78,7 +78,7 @@ static const struct perf_pmu_test_event dispatch_blocked_any = {
>                 .desc = "Memory cluster signals to block micro-op dispatch for any reason",
>                 .topic = "other",
>         },
> -       .alias_str = "umask=0x20,(null)=0x30d40,event=0x9",
> +       .alias_str = "umask=0x20,period=0x30d40,event=0x9",
>         .alias_long_desc = "Memory cluster signals to block micro-op dispatch for any reason",
>  };
>
> @@ -89,7 +89,7 @@ static const struct perf_pmu_test_event eist_trans = {
>                 .desc = "Number of Enhanced Intel SpeedStep(R) Technology (EIST) transitions",
>                 .topic = "other",
>         },
> -       .alias_str = "umask=0,(null)=0x30d40,event=0x3a",
> +       .alias_str = "umask=0,period=0x30d40,event=0x3a",
>         .alias_long_desc = "Number of Enhanced Intel SpeedStep(R) Technology (EIST) transitions",
>  };
>
> diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
> index 51a2219df601..e10243454e8b 100644
> --- a/tools/perf/util/parse-events.c
> +++ b/tools/perf/util/parse-events.c
> @@ -3083,7 +3083,7 @@ int parse_events_term__num(struct parse_events_term **term,
>         struct parse_events_term temp = {
>                 .type_val  = PARSE_EVENTS__TERM_TYPE_NUM,
>                 .type_term = type_term,
> -               .config    = config,
> +               .config    = config ? : strdup(config_term_names[type_term]),
>                 .no_value  = no_value,
>                 .err_term  = loc_term ? loc_term->first_column : 0,
>                 .err_val   = loc_val  ? loc_val->first_column  : 0,
> --
> 2.26.2
>
