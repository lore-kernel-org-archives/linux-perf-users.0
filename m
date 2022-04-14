Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AC5DC433F5
	for <linux-perf-users@archiver.kernel.org>; Thu, 14 Apr 2022 16:59:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240613AbiDNRCT (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 14 Apr 2022 13:02:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242755AbiDNRCL (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 14 Apr 2022 13:02:11 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7C52F8EDD
        for <linux-perf-users@vger.kernel.org>; Thu, 14 Apr 2022 09:36:45 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id b19so7667231wrh.11
        for <linux-perf-users@vger.kernel.org>; Thu, 14 Apr 2022 09:36:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=96fPVlK1lXCKBQ9aNMxEudacOmbrFnF0Sxztpz1AWoU=;
        b=EPw8JEdoNFQdsqEx7a7hmQ08Cs1rfhEj7w+ySyqPbuSO1S5mV8ukQraAaasWq0v8lP
         aK08wFxpPBwxUi4O0pBmL0nfnE0a7gF/xgbNGXth5IyIZsSjIKeoGCSJRLduP8XsPCIc
         4O1ogodaUb4b0xhYtL+g0KDF7i0524YPvQlsAyEwx94+s/Oscu49ssE9Y6v3DDZUa4Ht
         bMz6qLb9SDffuASIalPuP0vz6nQwNWCFz/c4giXJHUucdlEimILTHs81OzCe0VZDKeRN
         osMIY9ybQ0ZOW02ob9V7BN8eFJVLHPu2+EsjP/idFrcz+wQga4AF5TW9oUWOcQdTCejq
         loPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=96fPVlK1lXCKBQ9aNMxEudacOmbrFnF0Sxztpz1AWoU=;
        b=0GHLSBRP3IqYPdLKQZHyUbBgY4gcE40IXRF+9Z3dJPeTTusycpBEJ0Sr7lUgviI+9b
         Y5Wwzcm92S18C7sxhNL6o4vN7LvGb1rCal9iJtifBMO/TjX9UmBV6tXQOAWcyakPcf2W
         k0jnnlbAu4F/25Rs4JVcfXZb2OT5c6g393ilNQ+3nd1pSwIWnF7cJe5BoHnmbU0FR5kp
         ctO+4Dt9PkDdrGkEPmMRZO38hhn7f8GS+tR48v/7Fq7BYRrjAmtwKOtbYJ8IKKu7gAzu
         +z0uHOlJSpENJDIYvRFHBcbnYSmQGU6HL2FPQIVFrJMNNFVvYgHUpM5olhuCxgluuxTf
         5F8Q==
X-Gm-Message-State: AOAM532vlC3DLHN+wGexI5fywBKiRAfF7PHXD6iP4pf8Dkc/Av3Ua1iR
        yYSNSFxMmP9r8DqAmBIrw/ExHbb0dW4Lep23KZh7BQ==
X-Google-Smtp-Source: ABdhPJxEk+6D4NBT2CYxRaGZ7sXfhIacfcv8utIq7A/mgOQxSO2+t7qGxwQcsrTbLSwHEmAgkbMvs8agbLDYyVZAt0Y=
X-Received: by 2002:a5d:6350:0:b0:207:98d5:9bcf with SMTP id
 b16-20020a5d6350000000b0020798d59bcfmr2735752wrw.40.1649954204199; Thu, 14
 Apr 2022 09:36:44 -0700 (PDT)
MIME-Version: 1.0
References: <20220413210503.3256922-1-irogers@google.com> <20220413210503.3256922-3-irogers@google.com>
 <368c5b92-f035-41cc-96a8-4908f1325462@linux.intel.com>
In-Reply-To: <368c5b92-f035-41cc-96a8-4908f1325462@linux.intel.com>
From:   Ian Rogers <irogers@google.com>
Date:   Thu, 14 Apr 2022 09:36:31 -0700
Message-ID: <CAP-5=fWpECOtC8jc6up4LRFon1v0DBN1Y6LJsimEtuPfXcvJuA@mail.gmail.com>
Subject: Re: [PATCH 03/14] perf vendor events intel: Add sapphirerapids events
To:     "Liang, Kan" <kan.liang@linux.intel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Xing Zhengjun <zhengjun.xing@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        John Garry <john.garry@huawei.com>,
        James Clark <james.clark@arm.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Thu, Apr 14, 2022 at 8:03 AM Liang, Kan <kan.liang@linux.intel.com> wrote:
>
>
>
> On 4/13/2022 5:04 PM, Ian Rogers wrote:
> > Events were generated from 01.org using:
> > https://github.com/intel/event-converter-for-linux-perf
> >
> > Signed-off-by: Ian Rogers<irogers@google.com>
> > ---
> >   tools/perf/pmu-events/arch/x86/mapfile.csv    |    1 +
> >   .../arch/x86/sapphirerapids/cache.json        | 1083 ++++++++++++++
> >   .../x86/sapphirerapids/floating-point.json    |  218 +++
> >   .../arch/x86/sapphirerapids/frontend.json     |  471 ++++++
> >   .../arch/x86/sapphirerapids/memory.json       |  415 ++++++
> >   .../arch/x86/sapphirerapids/other.json        |  329 +++++
> >   .../arch/x86/sapphirerapids/pipeline.json     | 1271 +++++++++++++++++
> >   .../x86/sapphirerapids/virtual-memory.json    |  225 +++
>
> Thank you very much Ian for the patches. They all looks good to me.
>
>      Reviewed-by: Kan Liang <kan.liang@linux.intel.com>
>
> BTW: I think the uncore events for SPR are also published in 01.org.
> Do you have plan to add them later?

Thanks Kan, we need to add the csv file to the github project to make
this work. I can make a basic one if that works?

Thanks,
Ian

> Thanks,
> Kan
