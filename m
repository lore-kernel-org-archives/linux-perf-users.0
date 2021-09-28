Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63264C433EF
	for <linux-perf-users@archiver.kernel.org>; Tue, 28 Sep 2021 18:01:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4050460FF2
	for <linux-perf-users@archiver.kernel.org>; Tue, 28 Sep 2021 18:01:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230238AbhI1SCp (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 28 Sep 2021 14:02:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241965AbhI1SCn (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 28 Sep 2021 14:02:43 -0400
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com [IPv6:2607:f8b0:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7C79C06161C
        for <linux-perf-users@vger.kernel.org>; Tue, 28 Sep 2021 11:01:03 -0700 (PDT)
Received: by mail-il1-x136.google.com with SMTP id b12so12532089ilf.11
        for <linux-perf-users@vger.kernel.org>; Tue, 28 Sep 2021 11:01:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9pIAVmKduZgRWLe5UowP642oGT2BOJEs4BGi2pkF7gI=;
        b=ABsYvrJOpHL5K/R/0K2WbzjkbN2er/hWQO4aSKf4pLOFEgBwQ0ITQX7Qmb8V6D/6jD
         +fRe2tjw4jywsoQIiSgDRKH5DNEjARBv3T8NMGZPJ34z0jKZCr263DdBTQcPwOrix1LJ
         c+/fgFJWjcfMDguMk2WMqaBMef74+jlqy24qvGdXxM1YEQPi2jny9buLM3B5o6S+qFMA
         XQveCzsEYa/4TqUvQT/8fTdn/giuIypRI2z4NDNcfus2HkiJg1IdAb+/HAUU+BVlrmnt
         6IvccW50PGsKc3VbIaDTeBxiIi2GoQPSC0j2B1YlPoaJVhhCugzoYM1GI6chKdu2c6k/
         tLSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9pIAVmKduZgRWLe5UowP642oGT2BOJEs4BGi2pkF7gI=;
        b=oYyN5STMQVhncu3jLvjY9gyRM3fqUiqeQBQc5WYXj+gh4itehmk9d0X2SYjz6jco+U
         849tyXc5Dye/X308TZoBiWmgnIsSLPcUuH5zTeqUGW8Xtm1ZMzHNxxCVaWFZjsf+whI6
         ZsYdbSXvwPTWBS+jKkQ9J3wKVuMawi9mAx1GRP1LiblRo9lZMs5NlwiPJjoLIf4IkSIw
         ETssv72ENofr1y0pHlDh09M/NONTriNhgetqnZYksT8LwcBdnzxJtuEZ4pjoFKv3nVVL
         RBIAyqi6EwBL6qWK6fI7vL1a2YDa+dyySRExHRyEJ2qzQiyLJB22zWUUHyRhP3hgtjRG
         eRGw==
X-Gm-Message-State: AOAM531v0ZNYYUSv9fI4SOKRNZoRhleq4ZBkdcKlD2nRh94+kTCwlqUC
        DRsx9wSAyPqOo/jtrF9hY4x3TEn3e6xIjsc0qu6BeQ==
X-Google-Smtp-Source: ABdhPJzKmZtv7UlFF9wsX/z7IY9Q6X5zJ6CdJeOGa0JK7EWUFnPEAiI1ytvPflWCpdVBcP3PdRk7GUo9NfLNtdN86oI=
X-Received: by 2002:a05:6e02:1c2d:: with SMTP id m13mr5254327ilh.2.1632852062669;
 Tue, 28 Sep 2021 11:01:02 -0700 (PDT)
MIME-Version: 1.0
References: <1631795665-240946-1-git-send-email-john.garry@huawei.com> <1631795665-240946-3-git-send-email-john.garry@huawei.com>
In-Reply-To: <1631795665-240946-3-git-send-email-john.garry@huawei.com>
From:   Ian Rogers <irogers@google.com>
Date:   Tue, 28 Sep 2021 11:00:47 -0700
Message-ID: <CAP-5=fVzcQCUA611byVn47Fyt0mWLfQ2q_619zqYwJB=7ckPtw@mail.gmail.com>
Subject: Re: [PATCH 2/5] perf jevents: Support ConfigCode
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
> Some PMUs use "config=XXX" for eventcodes, like:
>
> more /sys/bus/event_source/devices/hisi_sccl1_ddrc3/events/act_cmd
> config=0x5
>
> However jevents would give an alias with .event field "event=0x5" for this
> event. This is handled without issue by the parse events code, but the pmu
> alias code gets a bit confused, as it warns about assigning "event=0x5"
> over "config=0x5" in perf_pmu_assign_str() when merging aliases:
> ./perf stat -v -e act_cmd
> ...
> alias act_cmd differs in field 'value'
> ...
>
> To make things a bit more straightforward, allow jevents to support
> "config=XXX" as well, by supporting a "ConfigCode" field.
>
> Signed-off-by: John Garry <john.garry@huawei.com>

Acked-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/pmu-events/jevents.c | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)
>
> diff --git a/tools/perf/pmu-events/jevents.c b/tools/perf/pmu-events/jevents.c
> index 6731b3cf0c2f..ef92c2fdd45d 100644
> --- a/tools/perf/pmu-events/jevents.c
> +++ b/tools/perf/pmu-events/jevents.c
> @@ -575,10 +575,12 @@ static int json_events(const char *fn,
>                 struct json_event je = {};
>                 char *arch_std = NULL;
>                 unsigned long long eventcode = 0;
> +               unsigned long long configcode = 0;
>                 struct msrmap *msr = NULL;
>                 jsmntok_t *msrval = NULL;
>                 jsmntok_t *precise = NULL;
>                 jsmntok_t *obj = tok++;
> +               bool configcode_present = false;
>
>                 EXPECT(obj->type == JSMN_OBJECT, obj, "expected object");
>                 for (j = 0; j < obj->size; j += 2) {
> @@ -601,6 +603,12 @@ static int json_events(const char *fn,
>                                 addfield(map, &code, "", "", val);
>                                 eventcode |= strtoul(code, NULL, 0);
>                                 free(code);
> +                       } else if (json_streq(map, field, "ConfigCode")) {
> +                               char *code = NULL;
> +                               addfield(map, &code, "", "", val);
> +                               configcode |= strtoul(code, NULL, 0);
> +                               free(code);
> +                               configcode_present = true;
>                         } else if (json_streq(map, field, "ExtSel")) {
>                                 char *code = NULL;
>                                 addfield(map, &code, "", "", val);
> @@ -682,7 +690,10 @@ static int json_events(const char *fn,
>                                 addfield(map, &extra_desc, " ",
>                                                 "(Precise event)", NULL);
>                 }
> -               snprintf(buf, sizeof buf, "event=%#llx", eventcode);
> +               if (configcode_present)
> +                       snprintf(buf, sizeof buf, "config=%#llx", configcode);
> +               else
> +                       snprintf(buf, sizeof buf, "event=%#llx", eventcode);
>                 addfield(map, &event, ",", buf, NULL);
>                 if (je.desc && extra_desc)
>                         addfield(map, &je.desc, " ", extra_desc, NULL);
> --
> 2.26.2
>
