Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 483F6C77B7E
	for <linux-perf-users@archiver.kernel.org>; Thu,  1 Jun 2023 20:04:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229610AbjFAUEp convert rfc822-to-8bit (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 1 Jun 2023 16:04:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbjFAUEo (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 1 Jun 2023 16:04:44 -0400
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D116133;
        Thu,  1 Jun 2023 13:04:43 -0700 (PDT)
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-ba8cd61ee2dso3866019276.1;
        Thu, 01 Jun 2023 13:04:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685649882; x=1688241882;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FguUd56ef6WXjLNVVs6lDvHHxF9RVKCHVqjpWMTKE2A=;
        b=EZaICIueclHV0AI0ZDPo73aQJ5qM+53q4VtvMby9s6W1dbFZCtXQHG/XBchBrZAReQ
         BpyBq1H7yxNIe7xlVFaDo8+MH+WfvJigLu5pPP3Ju6cQbxSx18qiyc6zuPI5LTLOSZIZ
         t3dNWxG3BwG3UVRcc/h6NSDMPb+n6Rd7yYmZ4jTHeR9n9S7O+0s8zkJmLqqBEZPuKh2T
         CHmT8FnpmkTs4dfGC8EiVjthiY6LhHmAr2rIBRSr+u4Zp+g7fMm2xuJS+lpHpogWsKCm
         tmjGwoVFrNwwT9M/4hyazDmJtEj8RDtaUpJfkpvuafJm+rWFsVGWI78RiLC8Tp4hsxk7
         D68g==
X-Gm-Message-State: AC+VfDy60aYdv49z2EARBa9hHg0z7w43PX58BAVqTauCWg+YPDx676Pl
        a6TPoF0Z7Kpd37jjFEjtf+dbH4o726dO5m5RZsI=
X-Google-Smtp-Source: ACHHUZ6G3LEe/cUo0zmoU4ZxQRdUtJiic3PK2B4jWE+07O9IsEzrpg2bUwDQ8KBwPM9N1D+E7J8AvKjLDp2OdxxQ2ME=
X-Received: by 2002:a25:69c5:0:b0:b8f:3990:636d with SMTP id
 e188-20020a2569c5000000b00b8f3990636dmr1144526ybc.23.1685649882238; Thu, 01
 Jun 2023 13:04:42 -0700 (PDT)
MIME-Version: 1.0
References: <20230601023644.587584-1-irogers@google.com>
In-Reply-To: <20230601023644.587584-1-irogers@google.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Thu, 1 Jun 2023 13:04:30 -0700
Message-ID: <CAM9d7ciz744BuEkjKRpRov4VsfASJHxskwzzE_L8mmekE6HuZA@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] perf pmu: Only warn about unsupported configs once
To:     Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Rob Herring <robh@kernel.org>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        James Clark <james.clark@arm.com>,
        Suzuki Poulouse <suzuki.poulose@arm.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Wed, May 31, 2023 at 7:36 PM Ian Rogers <irogers@google.com> wrote:
>
> Avoid scanning format list for each event parsed.

Maybe it's better to change the subject that it's about format..
Other than that,

Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks,
Namhyung


>
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/util/pmu.c | 5 +++++
>  tools/perf/util/pmu.h | 5 +++++
>  2 files changed, 10 insertions(+)
>
> diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
> index 0520aa9fe991..204ce3f02e63 100644
> --- a/tools/perf/util/pmu.c
> +++ b/tools/perf/util/pmu.c
> @@ -934,6 +934,11 @@ void perf_pmu__warn_invalid_formats(struct perf_pmu *pmu)
>  {
>         struct perf_pmu_format *format;
>
> +       if (pmu->formats_checked)
> +               return;
> +
> +       pmu->formats_checked = true;
> +
>         /* fake pmu doesn't have format list */
>         if (pmu == &perf_pmu__fake)
>                 return;
> diff --git a/tools/perf/util/pmu.h b/tools/perf/util/pmu.h
> index 287f593b15c7..7a1535dc1f12 100644
> --- a/tools/perf/util/pmu.h
> +++ b/tools/perf/util/pmu.h
> @@ -76,6 +76,11 @@ struct perf_pmu {
>          * specific code.
>          */
>         bool auxtrace;
> +       /**
> +        * @formats_checked: Only check PMU's formats are valid for
> +        * perf_event_attr once.
> +        */
> +       bool formats_checked;
>         /**
>          * @max_precise: Number of levels of :ppp precision supported by the
>          * PMU, read from
> --
> 2.41.0.rc0.172.g3f132b7071-goog
>
