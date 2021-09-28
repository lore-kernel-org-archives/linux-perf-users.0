Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D28F7C433EF
	for <linux-perf-users@archiver.kernel.org>; Tue, 28 Sep 2021 18:03:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B389261352
	for <linux-perf-users@archiver.kernel.org>; Tue, 28 Sep 2021 18:03:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242186AbhI1SE7 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 28 Sep 2021 14:04:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242179AbhI1SE6 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 28 Sep 2021 14:04:58 -0400
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A81CC061746
        for <linux-perf-users@vger.kernel.org>; Tue, 28 Sep 2021 11:03:19 -0700 (PDT)
Received: by mail-il1-x12d.google.com with SMTP id w1so24366593ilv.1
        for <linux-perf-users@vger.kernel.org>; Tue, 28 Sep 2021 11:03:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0rMKGqfvpKADGijyzOO7wsz9YISYB+sEd0g/DKdxxfY=;
        b=rV8huODsmqtc+YwcERseBQLZTTiKFGJS1T3uRfmst8e/cu08T9WDo4yp4LkUHu00Xd
         4FT1ONxxQBjxyaEyGYd1Z1OJz+F9kiXBDHn06ekAn7Ro36twz630tRFyYMXC1+ITLbb+
         +J9SUZOdMvpselY7dL9Yb4/9Imlq4PAMeJ6sLknXGHOMN1S18FdfShaKG39qV58kRSAV
         nZ+em67fr1mVssALhS4EreOHa3JaMsmkIuSutPRigzrPKPkxdkbDKnJUKHbaOkPpnF71
         eiqaPZRKWJlCB+/Xy5/5nx99Vh7XaAJsN5ySvQ+uIr7tOidnK+pTiR43HspPOTevt0SZ
         d10g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0rMKGqfvpKADGijyzOO7wsz9YISYB+sEd0g/DKdxxfY=;
        b=wthFivnoefyCWzput3juLF5A1VVmB/gDqTHKgGWaIFJxgJ/1E3W8FzjhqVZZkL5W/o
         DCOmpOkirvmaERnKa67J09zyLDNrd6v7XX9O5H2n31kni0CXYJ58iORIEln+HzgbmKgo
         V2kAwx1A5DRYSJJBUrtNrw4uroEjL1nPmSYsstOelcQGlMh2isaCCMaIA4MoydgWZBEr
         6OsoLUMbCCnu13jMNpnYFph4zVnvICU0QPr8ORK5Pz4KFaOvfUlrufJfkydQP86yIn2n
         S3CnQW97GKHzKNV2M8pjma0kc3+Da6UAxKrOnA71uifO9g/bFEzjyBqQv0AHIrWQkOV2
         NekA==
X-Gm-Message-State: AOAM531U8nBDiUKPIzOh5IxSJ3j8A8ITBH48v5nuYKxZaIJdTOuRmrh+
        EM6x+qc1Ac66ObZ4UV1LJNb4FcYonvXmiOZ1xyIhtA==
X-Google-Smtp-Source: ABdhPJyGQcrfddYeDyjtTTdGT0OT2E+gKYLkheP4oVW6r3YkFTtPieXnNwPm5IgHSHsN0wYdQ1yzRQjf1MhLmn4lOZA=
X-Received: by 2002:a05:6e02:17ce:: with SMTP id z14mr5295608ilu.89.1632852198617;
 Tue, 28 Sep 2021 11:03:18 -0700 (PDT)
MIME-Version: 1.0
References: <1631795665-240946-1-git-send-email-john.garry@huawei.com> <1631795665-240946-5-git-send-email-john.garry@huawei.com>
In-Reply-To: <1631795665-240946-5-git-send-email-john.garry@huawei.com>
From:   Ian Rogers <irogers@google.com>
Date:   Tue, 28 Sep 2021 11:03:04 -0700
Message-ID: <CAP-5=fVTd5g4=o84Tmo8Y45JDSWOL_RVhwBFCVVzV5HykW=GaQ@mail.gmail.com>
Subject: Re: [PATCH 4/5] perf test: Add pmu-event test for event described as "config="
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
> Add a new test event for a system event whose event member is in form
> "config=".
>
> Signed-off-by: John Garry <john.garry@huawei.com>

Acked-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  .../arch/test/test_soc/sys/uncore.json        |  7 ++++++
>  tools/perf/tests/pmu-events.c                 | 25 +++++++++++++++++++
>  2 files changed, 32 insertions(+)
>
> diff --git a/tools/perf/pmu-events/arch/test/test_soc/sys/uncore.json b/tools/perf/pmu-events/arch/test/test_soc/sys/uncore.json
> index 0f681a6e10ea..c7e7528db315 100644
> --- a/tools/perf/pmu-events/arch/test/test_soc/sys/uncore.json
> +++ b/tools/perf/pmu-events/arch/test/test_soc/sys/uncore.json
> @@ -6,4 +6,11 @@
>             "Unit": "sys_ddr_pmu",
>             "Compat": "v8"
>     },
> +   {
> +           "BriefDescription": "ccn read-cycles event",
> +           "ConfigCode": "0x2c",
> +           "EventName": "sys_ccn_pmu.read_cycles",
> +           "Unit": "sys_ccn_pmu",
> +           "Compat": "0x01"
> +   }
>  ]
> diff --git a/tools/perf/tests/pmu-events.c b/tools/perf/tests/pmu-events.c
> index adfc17f51c7b..f14266a4c513 100644
> --- a/tools/perf/tests/pmu-events.c
> +++ b/tools/perf/tests/pmu-events.c
> @@ -208,8 +208,23 @@ static const struct perf_pmu_test_event sys_ddr_pmu_write_cycles = {
>         .matching_pmu = "uncore_sys_ddr_pmu",
>  };
>
> +static const struct perf_pmu_test_event sys_ccn_pmu_read_cycles = {
> +       .event = {
> +               .name = "sys_ccn_pmu.read_cycles",
> +               .event = "config=0x2c",
> +               .desc = "ccn read-cycles event. Unit: uncore_sys_ccn_pmu ",
> +               .topic = "uncore",
> +               .pmu = "uncore_sys_ccn_pmu",
> +               .compat = "0x01",
> +       },
> +       .alias_str = "config=0x2c",
> +       .alias_long_desc = "ccn read-cycles event. Unit: uncore_sys_ccn_pmu ",
> +       .matching_pmu = "uncore_sys_ccn_pmu",
> +};
> +
>  static const struct perf_pmu_test_event *sys_events[] = {
>         &sys_ddr_pmu_write_cycles,
> +       &sys_ccn_pmu_read_cycles,
>         NULL
>  };
>
> @@ -677,6 +692,16 @@ static struct perf_pmu_test_pmu test_pmus[] = {
>                         &sys_ddr_pmu_write_cycles,
>                 },
>         },
> +       {
> +               .pmu = {
> +                       .name = (char *)"uncore_sys_ccn_pmu4",
> +                       .is_uncore = 1,
> +                       .id = (char *)"0x01",
> +               },
> +               .aliases = {
> +                       &sys_ccn_pmu_read_cycles,
> +               },
> +       },
>  };
>
>  /* Test that aliases generated are as expected */
> --
> 2.26.2
>
