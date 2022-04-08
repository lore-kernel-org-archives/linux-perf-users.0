Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F224C433F5
	for <linux-perf-users@archiver.kernel.org>; Fri,  8 Apr 2022 18:13:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229822AbiDHSP2 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 8 Apr 2022 14:15:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230479AbiDHSP0 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 8 Apr 2022 14:15:26 -0400
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C46EC3A73F;
        Fri,  8 Apr 2022 11:13:21 -0700 (PDT)
Received: by mail-lj1-f177.google.com with SMTP id b43so12488129ljr.10;
        Fri, 08 Apr 2022 11:13:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UW/raEK33bMCD3gBOPjdzCnBvwCLiC4EtDuZoVDwoUo=;
        b=BEi6l/+AVzYTy+p+eOrjTHN6l78Hhs+F4Qo4JFeLD+usf2WppmkjKWQ/Af4zh4EiuO
         kvqzzObpjn1ilpB2QfF82MhfkPduuaMKlbc94Kv5W1tIrpzwvS8wUgWYHVVFXsIzM3zT
         nrRzo6II5Dbf3TDVV6tgVCDm+Vm+60odmTohe3AdJndSl296q5q84D5IDQxt1c2alR+g
         QtlmCenGdj1LQRxk894ERbXrvVtABM9RdiSAVi7dJ3gB/utBJNsbYOQX4WIeRnrnWvg7
         kgj/L3ZLSuzfyPtaQmhN8fvLYHvM8hlMxNf7fuVzW2B4f1lUwlPyaqu2yAYoPbPQcuJo
         v2lA==
X-Gm-Message-State: AOAM531cPDKRJ2DwlYyNJl1Xu0qzs1r6BxKZMTtyVVyHZEJFJo4Wyrun
        FhX0yq1fXPdWJeVpb9bcJgD0YYDKUGwy4fQCy6COC7Zq
X-Google-Smtp-Source: ABdhPJxZz2QW83b88KtmPfLvVm/xo/NWOAt+tfuxfy6sASdOaHHrjCgrRzI54XMME2ryEQkX3IzV9X2KZ6g4D9kfQlg=
X-Received: by 2002:a05:651c:248:b0:245:5b3d:9abb with SMTP id
 x8-20020a05651c024800b002455b3d9abbmr12436620ljn.366.1649441600116; Fri, 08
 Apr 2022 11:13:20 -0700 (PDT)
MIME-Version: 1.0
References: <20220408144056.1955535-1-james.clark@arm.com>
In-Reply-To: <20220408144056.1955535-1-james.clark@arm.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Fri, 8 Apr 2022 11:13:09 -0700
Message-ID: <CAM9d7cji=xSAy673sXGf2GXFsKKsR7=pNKJceLtHX1sFFUZcKg@mail.gmail.com>
Subject: Re: [PATCH] perf: arm-spe: Fix perf report --mem-mode
To:     James Clark <james.clark@arm.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        linux-perf-users <linux-perf-users@vger.kernel.org>,
        leo.yan@linaro.com, German Gomez <German.Gomez@arm.com>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Hello,

On Fri, Apr 8, 2022 at 7:41 AM James Clark <james.clark@arm.com> wrote:
>
> Since commit bb30acae4c4d ("perf report: Bail out --mem-mode if mem info
> is not available") "perf mem report" and "perf report --mem-mode" don't
> allow opening the file unless one of the events has PERF_SAMPLE_DATA_SRC
> set.
>
> SPE doesn't have this set even though synthetic memory data is generated
> after it is decoded. Fix this issue by setting DATA_SRC on SPE events.
> This has no effect on the data collected because the SPE driver doesn't
> do anything with that flag and doesn't generate samples.
>
> Fixes: bb30acae4c4d ("perf report: Bail out --mem-mode if mem info is not available")
> Signed-off-by: James Clark <james.clark@arm.com>

Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks,
Namhyung


> ---
>  tools/perf/arch/arm64/util/arm-spe.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/tools/perf/arch/arm64/util/arm-spe.c b/tools/perf/arch/arm64/util/arm-spe.c
> index 86e2e926aa0e..a1419e6341c0 100644
> --- a/tools/perf/arch/arm64/util/arm-spe.c
> +++ b/tools/perf/arch/arm64/util/arm-spe.c
> @@ -239,6 +239,12 @@ static int arm_spe_recording_options(struct auxtrace_record *itr,
>                 arm_spe_set_timestamp(itr, arm_spe_evsel);
>         }
>
> +       /*
> +        * Set this only so that perf report knows that SPE generates memory info. It has no effect
> +        * on the opening of the event or the SPE data produced.
> +        */
> +       evsel__set_sample_bit(arm_spe_evsel, DATA_SRC);
> +
>         /* Add dummy event to keep tracking */
>         err = parse_events(evlist, "dummy:u", NULL);
>         if (err)
> @@ -523,6 +529,5 @@ struct perf_event_attr
>
>         arm_spe_pmu->selectable = true;
>         arm_spe_pmu->is_uncore = false;
> -
>         return attr;
>  }
> --
> 2.28.0
>
