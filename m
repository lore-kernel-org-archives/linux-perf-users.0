Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 100BBC433F5
	for <linux-perf-users@archiver.kernel.org>; Tue, 28 Sep 2021 18:02:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E8FDA61352
	for <linux-perf-users@archiver.kernel.org>; Tue, 28 Sep 2021 18:02:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242141AbhI1SEZ (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 28 Sep 2021 14:04:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242060AbhI1SEY (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 28 Sep 2021 14:04:24 -0400
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8321AC06161C
        for <linux-perf-users@vger.kernel.org>; Tue, 28 Sep 2021 11:02:44 -0700 (PDT)
Received: by mail-io1-xd29.google.com with SMTP id p80so28461463iod.10
        for <linux-perf-users@vger.kernel.org>; Tue, 28 Sep 2021 11:02:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iml/VgaExryQoFlabzYCAD3repwu8THYP0LEUo7RDw8=;
        b=ismr0qLIdlmhPy1VIB+ST7MXgGg5DQQWHEuIIKqi+mr0AVnVFJN8xOIDmgC+re0qNz
         lYZHi/ekOZ7ThK81qsIVWwnH0w6QYYGos//Knny6xi4yn4Al04WGtc1fYfwKNLYlSEVK
         mRNTGXRpta0XEtahbNknTx6LXkf0bfyTl47hP2/fftTWpfZw78XH/Q6WSmQT50aj0BC7
         GD9pKi7aYGcqv3fCZAWUTyOBnuisag5v+xQzL1NBAIGs2jk95o13AnygZ/SOyx99htBL
         DKAeuQlDk3VTKY9j+qWiUEFF6Fl6VlEitBT+OZviPMtWHatLtlAfRDq5tPllRuiexvTW
         3IxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iml/VgaExryQoFlabzYCAD3repwu8THYP0LEUo7RDw8=;
        b=69s1Cj2jb8AmYRBoEJVvHZHiKwTXC364bXoYCLCYmcmSyi8VbJHBvhV9PphEugIR3Q
         C85OCGU7ulO63R1VUAphj9n/+CKU3K/QKOOcTfKXDxCbnM1rnaIL8zyPZDlm4MeE//eA
         FkwBvKVf2EjEqtavSpj9G8kj7fnhzm6ty+BUJMzwGPcJioO2OOvIyMRGiIUH2DP0gL5o
         GlBbjg/fGtP1ox4zB5mbMCdBCBXNe7NA73dOlGFIt6uwJHXL+usE69H3OBfMFxv+cLu0
         /VSZUZf2cMYX9xlPf13cO7jS30v8aflQdBMfpx9r+NL7hvZwKuZoFxmdvcQQmExTxic3
         MQwQ==
X-Gm-Message-State: AOAM532gTop0CJ9EMURypE9EvydCeLtt19SDNhsed42YuGIoh7OvLfV+
        n+3h5lpSpwtVq97pMIrJ2yh9cbCD0c05CVCe2H6fMA==
X-Google-Smtp-Source: ABdhPJyIyz7HHcZ3wmbeY4d6vV9kn924GY9hfQmHZ07E9f42u2rOSKuyAquC7V6Go+MV0xcQZo1FXD9/xFrGOtXcDYA=
X-Received: by 2002:a6b:8f47:: with SMTP id r68mr4812581iod.18.1632852163595;
 Tue, 28 Sep 2021 11:02:43 -0700 (PDT)
MIME-Version: 1.0
References: <1631795665-240946-1-git-send-email-john.garry@huawei.com> <1631795665-240946-4-git-send-email-john.garry@huawei.com>
In-Reply-To: <1631795665-240946-4-git-send-email-john.garry@huawei.com>
From:   Ian Rogers <irogers@google.com>
Date:   Tue, 28 Sep 2021 11:02:29 -0700
Message-ID: <CAP-5=fVDmEmwwV=-THt6ppDGmGoBy9AYVMDT_eob=GW0saepJQ@mail.gmail.com>
Subject: Re: [PATCH 3/5] perf test: Verify more event members in pmu-events test
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
> Function compare_pmu_events() does not compare all struct pmu-events
> members, so add tests for missing members "name", "event", "aggr_mod",
> "event", "metric_constraint", and "metric_group", and re-order the tests
> to match current struct pmu-events member ordering.
>
> Also fix uncore_hisi_l3c_rd_hit_cpipe.event member, now that we're actually
> testing it.
>
> Signed-off-by: John Garry <john.garry@huawei.com>

Acked-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/tests/pmu-events.c | 50 ++++++++++++++++++++++++++++-------
>  1 file changed, 40 insertions(+), 10 deletions(-)
>
> diff --git a/tools/perf/tests/pmu-events.c b/tools/perf/tests/pmu-events.c
> index 8c5a6ba1cb14..adfc17f51c7b 100644
> --- a/tools/perf/tests/pmu-events.c
> +++ b/tools/perf/tests/pmu-events.c
> @@ -146,7 +146,7 @@ static const struct perf_pmu_test_event unc_cbo_xsnp_response_miss_eviction = {
>  static const struct perf_pmu_test_event uncore_hisi_l3c_rd_hit_cpipe = {
>         .event = {
>                 .name = "uncore_hisi_l3c.rd_hit_cpipe",
> -               .event = "event=0x2",
> +               .event = "event=0x7",
>                 .desc = "Total read hits. Unit: hisi_sccl,l3c ",
>                 .topic = "uncore",
>                 .long_desc = "Total read hits",
> @@ -255,6 +255,24 @@ static struct pmu_event *__test_pmu_get_sys_events_table(void)
>
>  static int compare_pmu_events(struct pmu_event *e1, const struct pmu_event *e2)
>  {
> +       if (!is_same(e1->name, e2->name)) {
> +               pr_debug2("testing event e1 %s: mismatched name string, %s vs %s\n",
> +                         e1->name, e1->name, e2->name);
> +               return -1;
> +       }
> +
> +       if (!is_same(e1->compat, e2->compat)) {
> +               pr_debug2("testing event e1 %s: mismatched compat string, %s vs %s\n",
> +                         e1->name, e1->compat, e2->compat);
> +               return -1;
> +       }
> +
> +       if (!is_same(e1->event, e2->event)) {
> +               pr_debug2("testing event e1 %s: mismatched event, %s vs %s\n",
> +                         e1->name, e1->event, e2->event);
> +               return -1;
> +       }
> +
>         if (!is_same(e1->desc, e2->desc)) {
>                 pr_debug2("testing event e1 %s: mismatched desc, %s vs %s\n",
>                           e1->name, e1->desc, e2->desc);
> @@ -273,6 +291,12 @@ static int compare_pmu_events(struct pmu_event *e1, const struct pmu_event *e2)
>                 return -1;
>         }
>
> +       if (!is_same(e1->pmu, e2->pmu)) {
> +               pr_debug2("testing event e1 %s: mismatched pmu string, %s vs %s\n",
> +                         e1->name, e1->pmu, e2->pmu);
> +               return -1;
> +       }
> +
>         if (!is_same(e1->unit, e2->unit)) {
>                 pr_debug2("testing event e1 %s: mismatched unit, %s vs %s\n",
>                           e1->name, e1->unit, e2->unit);
> @@ -285,6 +309,12 @@ static int compare_pmu_events(struct pmu_event *e1, const struct pmu_event *e2)
>                 return -1;
>         }
>
> +       if (!is_same(e1->aggr_mode, e2->aggr_mode)) {
> +               pr_debug2("testing event e1 %s: mismatched aggr_mode, %s vs %s\n",
> +                         e1->name, e1->aggr_mode, e2->aggr_mode);
> +               return -1;
> +       }
> +
>         if (!is_same(e1->metric_expr, e2->metric_expr)) {
>                 pr_debug2("testing event e1 %s: mismatched metric_expr, %s vs %s\n",
>                           e1->name, e1->metric_expr, e2->metric_expr);
> @@ -297,21 +327,21 @@ static int compare_pmu_events(struct pmu_event *e1, const struct pmu_event *e2)
>                 return -1;
>         }
>
> -       if (!is_same(e1->deprecated, e2->deprecated)) {
> -               pr_debug2("testing event e1 %s: mismatched deprecated, %s vs %s\n",
> -                         e1->name, e1->deprecated, e2->deprecated);
> +       if (!is_same(e1->metric_group, e2->metric_group)) {
> +               pr_debug2("testing event e1 %s: mismatched metric_group, %s vs %s\n",
> +                         e1->name, e1->metric_group, e2->metric_group);
>                 return -1;
>         }
>
> -       if (!is_same(e1->pmu, e2->pmu)) {
> -               pr_debug2("testing event e1 %s: mismatched pmu string, %s vs %s\n",
> -                         e1->name, e1->pmu, e2->pmu);
> +       if (!is_same(e1->deprecated, e2->deprecated)) {
> +               pr_debug2("testing event e1 %s: mismatched deprecated, %s vs %s\n",
> +                         e1->name, e1->deprecated, e2->deprecated);
>                 return -1;
>         }
>
> -       if (!is_same(e1->compat, e2->compat)) {
> -               pr_debug2("testing event e1 %s: mismatched compat string, %s vs %s\n",
> -                         e1->name, e1->compat, e2->compat);
> +       if (!is_same(e1->metric_constraint, e2->metric_constraint)) {
> +               pr_debug2("testing event e1 %s: mismatched metric_constant, %s vs %s\n",
> +                         e1->name, e1->metric_constraint, e2->metric_constraint);
>                 return -1;
>         }
>
> --
> 2.26.2
>
