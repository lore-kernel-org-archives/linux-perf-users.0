Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 286C3EB64D7
	for <linux-perf-users@archiver.kernel.org>; Fri, 16 Jun 2023 05:57:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232209AbjFPF5m (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 16 Jun 2023 01:57:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230378AbjFPF5l (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 16 Jun 2023 01:57:41 -0400
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7DD52D54
        for <linux-perf-users@vger.kernel.org>; Thu, 15 Jun 2023 22:57:40 -0700 (PDT)
Received: by mail-il1-x131.google.com with SMTP id e9e14a558f8ab-33d928a268eso115015ab.0
        for <linux-perf-users@vger.kernel.org>; Thu, 15 Jun 2023 22:57:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686895060; x=1689487060;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gjf/Q1AKMt/rmDqEwL5TkR67v9E2T5unrUGfsNy/w4U=;
        b=hmYAMLKXJ2DA3K1l6mvzogsKKGpz89kqxn0e3TWgyvQa4/fpVb4aXlPoqi5PABl0wV
         mpU3gZc5BEESftGWx+RbZVUd1XHp1wBvZGHQTGUPA8uEtJuq4GLwbmUJjsyFzEMRAIJx
         sDH47svL3GF0Eb3K2HuWCAFZaobHcqU8TE6qHIkuG0yd/DrmMzp+hd0/hxyKiLbLrvNe
         pKzFySLUZCm2FCnU65P73jIpBLaGXjntQ8fPlT83s1ig0o0VwIxnFFaNF5A1oNl1y//o
         ijyhTyFOIAL44cB7eoIEyIKYGiGyvGH7PrXdd+EqLtVANFbspGmP0K4hd+yaL+Lb0lg9
         f6DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686895060; x=1689487060;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gjf/Q1AKMt/rmDqEwL5TkR67v9E2T5unrUGfsNy/w4U=;
        b=IfHaF14/gCWKrf1DuXwwYe0eQXaS6vvc2wy/Gg96KU6ZTZIvP+iMESuh6SR9wm+7XY
         oGG1CCdQoTnwPm4Tz50QzBZyLkI+kxJfPVYJvzmTsN4Uiz1+SFVwuQ9TfoB5kQO36pwf
         2BStrGjkD8PAl6ds4WzBfUhmPmyiqLzdTsUwivsUPV8ldqO0Q73H9cHv/v2tCdhvlOCw
         8f+giOd9HeSIc6zH8yIPmGPLKmSsGv8aBpZpcTKjHBmDXKKVtsORJKKOnSy1ChCQLkvf
         koE49kUgXAfXOqHzcvIZEcJ79kLnhcR2sOkKl8PUolXduVy1/4+oJ0uIzUpuCFbkBfJu
         W3ow==
X-Gm-Message-State: AC+VfDwFWgGZ7ODW+flUUc7H+vVM+zZRtjLiLPJyTgZ6ChOSRWyazBLG
        LiHljBpq69dcNJIFrbhkProaCUpuB2Owywp69OObjw==
X-Google-Smtp-Source: ACHHUZ5Y+rc0/MZ5TWhNtqA4At8ZTfQhUStNiUIjF4uBVxA88uS4EsF+tlhHXBsKcPZ9TZXsIcw//YKTuR4aNhxPF1I=
X-Received: by 2002:a05:6e02:1bcc:b0:340:ccdd:5739 with SMTP id
 x12-20020a056e021bcc00b00340ccdd5739mr371453ilv.16.1686895060136; Thu, 15 Jun
 2023 22:57:40 -0700 (PDT)
MIME-Version: 1.0
References: <20230616031420.3751973-1-kan.liang@linux.intel.com> <20230616031420.3751973-6-kan.liang@linux.intel.com>
In-Reply-To: <20230616031420.3751973-6-kan.liang@linux.intel.com>
From:   Ian Rogers <irogers@google.com>
Date:   Thu, 15 Jun 2023 22:57:29 -0700
Message-ID: <CAP-5=fUOJFkV7Dtb973qOb0QLkg1EgoGKRqVDF23zUDwJTDvbg@mail.gmail.com>
Subject: Re: [PATCH V4 5/5] perf vendor events arm64: Add default tags for
 Hisi hip08 L1 metrics
To:     kan.liang@linux.intel.com
Cc:     acme@kernel.org, mingo@redhat.com, peterz@infradead.org,
        namhyung@kernel.org, jolsa@kernel.org, adrian.hunter@intel.com,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        ak@linux.intel.com, eranian@google.com, ahmad.yasin@intel.com,
        John Garry <john.g.garry@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Thu, Jun 15, 2023 at 8:15=E2=80=AFPM <kan.liang@linux.intel.com> wrote:
>
> From: Kan Liang <kan.liang@linux.intel.com>
>
> Add the default tags for Hisi hip08 as well.
>
> Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
> Cc: John Garry <john.g.garry@oracle.com>

Acked-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  .../arch/arm64/hisilicon/hip08/metrics.json          | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
>
> diff --git a/tools/perf/pmu-events/arch/arm64/hisilicon/hip08/metrics.jso=
n b/tools/perf/pmu-events/arch/arm64/hisilicon/hip08/metrics.json
> index 6443a061e22a..6463531b9941 100644
> --- a/tools/perf/pmu-events/arch/arm64/hisilicon/hip08/metrics.json
> +++ b/tools/perf/pmu-events/arch/arm64/hisilicon/hip08/metrics.json
> @@ -3,28 +3,32 @@
>          "MetricExpr": "FETCH_BUBBLE / (4 * CPU_CYCLES)",
>          "PublicDescription": "Frontend bound L1 topdown metric",
>          "BriefDescription": "Frontend bound L1 topdown metric",
> -        "MetricGroup": "TopDownL1",
> +        "DefaultMetricgroupName": "TopDownL1",
> +        "MetricGroup": "Default;TopDownL1",
>          "MetricName": "frontend_bound"
>      },
>      {
>          "MetricExpr": "(INST_SPEC - INST_RETIRED) / (4 * CPU_CYCLES)",
>          "PublicDescription": "Bad Speculation L1 topdown metric",
>          "BriefDescription": "Bad Speculation L1 topdown metric",
> -        "MetricGroup": "TopDownL1",
> +        "DefaultMetricgroupName": "TopDownL1",
> +        "MetricGroup": "Default;TopDownL1",
>          "MetricName": "bad_speculation"
>      },
>      {
>          "MetricExpr": "INST_RETIRED / (CPU_CYCLES * 4)",
>          "PublicDescription": "Retiring L1 topdown metric",
>          "BriefDescription": "Retiring L1 topdown metric",
> -        "MetricGroup": "TopDownL1",
> +        "DefaultMetricgroupName": "TopDownL1",
> +        "MetricGroup": "Default;TopDownL1",
>          "MetricName": "retiring"
>      },
>      {
>          "MetricExpr": "1 - (frontend_bound + bad_speculation + retiring)=
",
>          "PublicDescription": "Backend Bound L1 topdown metric",
>          "BriefDescription": "Backend Bound L1 topdown metric",
> -        "MetricGroup": "TopDownL1",
> +        "DefaultMetricgroupName": "TopDownL1",
> +        "MetricGroup": "Default;TopDownL1",
>          "MetricName": "backend_bound"
>      },
>      {
> --
> 2.35.1
>
