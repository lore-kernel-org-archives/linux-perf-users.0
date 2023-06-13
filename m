Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C729EB64D7
	for <linux-perf-users@archiver.kernel.org>; Tue, 13 Jun 2023 19:45:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231972AbjFMTpZ (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 13 Jun 2023 15:45:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239293AbjFMTpY (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 13 Jun 2023 15:45:24 -0400
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08250171A
        for <linux-perf-users@vger.kernel.org>; Tue, 13 Jun 2023 12:45:23 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id d75a77b69052e-3f9b7de94e7so55011cf.0
        for <linux-perf-users@vger.kernel.org>; Tue, 13 Jun 2023 12:45:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686685522; x=1689277522;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hmyWnHr478kYv9A2E6MzDTgvctIiVRO7z+aWX4EXIy4=;
        b=MncMug4N0Idcw5+ZCgvfzOMK+Xx26hXaad3kmnCMgsyQKw4EkIoPOombtZ57tmOe8p
         5Jkf0GwvI59WrclSQKUQka1ReHsFgIiMa3DuRhAoTmmyh3wOl+mVyOyI3vMJkao0VFTh
         YVszYfvJS+6QQnxO4GQxyzjW9+GomF9mp5G3/Si8Bzh8N8ku3YAbkTZ+5ZZy4cDbD/0m
         dMg1/Z7oPTOIp6H85NdxW1VFqjdIeo8MdGGRjyEjkKD/yFdIJ6pmeNrzZTEDABMgr4fn
         Gsbn1UsiN8bG16Dex9sw0inifdL2eRM71c/MaGB88S/RJyN3106PlKNrKxs5hZYvLgWo
         ZxNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686685522; x=1689277522;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hmyWnHr478kYv9A2E6MzDTgvctIiVRO7z+aWX4EXIy4=;
        b=lxA/i/FvO/uP1Dt5WJD2U8qyFWrXlk2BmgpN8AVzffqZ7r7p/1u5hcItFQulOmOlqJ
         0x4WQzAx9LQ+0wCR78/14ghrYzLqG+GBWEeXot0kedj/mQCYcc6yj/jxnCZWtmzJQcrA
         yPFvGwpa34eH8ir7UUPOeKJyGl86ChqrG1TTR0ixOhAb+9v2dmyFd4Rx/0ZJh7PxDefC
         0RL4DNpphfsf7KmOcdbleuJxeMaWAlr5oKhmC3/07AayLuXpz1RBs0izAdmLNGzhSA+3
         1uxWxT35VP17nCTS8Y/Ligm5ndsMBRilQjQIACJsib3W/AnaeUzAFbERgZ+QUlzmitg/
         X9Mw==
X-Gm-Message-State: AC+VfDyQ+VuoQq1yAGQDxrb8s/q51Kq6DYNK7MwY9K/1rqKhJSeGMDn7
        cuOeFwtweoIwSGnRk26/siTKbiZWR84c/RlGRWgKCA==
X-Google-Smtp-Source: ACHHUZ5S8CxYc8LAkpxgN/jbH8hhhSouA4lfLNPZxwQ5A0oOUNWfjeDnxtwTn1h7b6vfIgZ4Td2kRBEyNz52HrD5c8U=
X-Received: by 2002:a05:622a:54b:b0:3fd:aaef:3807 with SMTP id
 m11-20020a05622a054b00b003fdaaef3807mr40916qtx.16.1686685521994; Tue, 13 Jun
 2023 12:45:21 -0700 (PDT)
MIME-Version: 1.0
References: <20230607162700.3234712-1-kan.liang@linux.intel.com> <20230607162700.3234712-5-kan.liang@linux.intel.com>
In-Reply-To: <20230607162700.3234712-5-kan.liang@linux.intel.com>
From:   Ian Rogers <irogers@google.com>
Date:   Tue, 13 Jun 2023 12:45:10 -0700
Message-ID: <CAP-5=fXjR_yhFqob_Kzsh3+dQ5N6zXzu-FJO5b4-qgYULth=eQ@mail.gmail.com>
Subject: Re: [PATCH 4/8] perf vendor events arm64: Add default tags into
 topdown L1 metrics
To:     kan.liang@linux.intel.com
Cc:     acme@kernel.org, mingo@redhat.com, peterz@infradead.org,
        namhyung@kernel.org, jolsa@kernel.org, adrian.hunter@intel.com,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        ak@linux.intel.com, eranian@google.com, ahmad.yasin@intel.com,
        Jing Zhang <renyu.zj@linux.alibaba.com>,
        John Garry <john.g.garry@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Wed, Jun 7, 2023 at 9:27=E2=80=AFAM <kan.liang@linux.intel.com> wrote:
>
> From: Kan Liang <kan.liang@linux.intel.com>
>
> Add the default tags for ARM as well.
>
> Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
> Cc: Jing Zhang <renyu.zj@linux.alibaba.com>
> Cc: John Garry <john.g.garry@oracle.com>

Acked-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/pmu-events/arch/arm64/sbsa.json | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
>
> diff --git a/tools/perf/pmu-events/arch/arm64/sbsa.json b/tools/perf/pmu-=
events/arch/arm64/sbsa.json
> index f678c37ea9c3..f90b338261ac 100644
> --- a/tools/perf/pmu-events/arch/arm64/sbsa.json
> +++ b/tools/perf/pmu-events/arch/arm64/sbsa.json
> @@ -2,28 +2,32 @@
>      {
>          "MetricExpr": "stall_slot_frontend / (#slots * cpu_cycles)",
>          "BriefDescription": "Frontend bound L1 topdown metric",
> -        "MetricGroup": "TopdownL1",
> +        "DefaultMetricgroupName": "TopdownL1",
> +        "MetricGroup": "Default;TopdownL1",
>          "MetricName": "frontend_bound",
>          "ScaleUnit": "100%"
>      },
>      {
>          "MetricExpr": "(1 - op_retired / op_spec) * (1 - stall_slot / (#=
slots * cpu_cycles))",
>          "BriefDescription": "Bad speculation L1 topdown metric",
> -        "MetricGroup": "TopdownL1",
> +        "DefaultMetricgroupName": "TopdownL1",
> +        "MetricGroup": "Default;TopdownL1",
>          "MetricName": "bad_speculation",
>          "ScaleUnit": "100%"
>      },
>      {
>          "MetricExpr": "(op_retired / op_spec) * (1 - stall_slot / (#slot=
s * cpu_cycles))",
>          "BriefDescription": "Retiring L1 topdown metric",
> -        "MetricGroup": "TopdownL1",
> +        "DefaultMetricgroupName": "TopdownL1",
> +        "MetricGroup": "Default;TopdownL1",
>          "MetricName": "retiring",
>          "ScaleUnit": "100%"
>      },
>      {
>          "MetricExpr": "stall_slot_backend / (#slots * cpu_cycles)",
>          "BriefDescription": "Backend Bound L1 topdown metric",
> -        "MetricGroup": "TopdownL1",
> +        "DefaultMetricgroupName": "TopdownL1",
> +        "MetricGroup": "Default;TopdownL1",
>          "MetricName": "backend_bound",
>          "ScaleUnit": "100%"
>      }
> --
> 2.35.1
>
