Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F2E1C433F5
	for <linux-perf-users@archiver.kernel.org>; Sun,  5 Sep 2021 21:24:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 53AD160E52
	for <linux-perf-users@archiver.kernel.org>; Sun,  5 Sep 2021 21:24:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238222AbhIEVZk (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Sun, 5 Sep 2021 17:25:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231968AbhIEVZj (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Sun, 5 Sep 2021 17:25:39 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D2BCC061575
        for <linux-perf-users@vger.kernel.org>; Sun,  5 Sep 2021 14:24:35 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id v20-20020a1cf714000000b002e71f4d2026so2679061wmh.1
        for <linux-perf-users@vger.kernel.org>; Sun, 05 Sep 2021 14:24:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=saO2PLp8tH6FyRu31V4/jVR5ahw84Vxja4MZDC54Af0=;
        b=HuGLq9krOAyeDLV8Id9e23NIi1mJ+xi7hLyyoim9gjVlzT3rl1OnPjr7somRcCbXZA
         gTHmhNMWe81BFhBXEvxvrs1TCLqlsu2cDioqfIyjc//U5y6+DhOLrIiJbuca+NIE/O0C
         mx5DVlxoi3plKYC1mshL5LTLh2NI1uXxPCAkguAn7h3tmzxW0/9mWkTi+DFUW01ZgSWs
         9KAu0H/D9BBaY3pHZEkD61ph5P1fshXNt6k9c+9MzKnoOTccC9Gk3BcCJp4uctgo0gGw
         y55iGlT9w7VGEmjyXR9g6E1MVhf29Y8kNK572S03dLoepRsY+dwTwB5UB4vxHfkie7Ob
         e/7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=saO2PLp8tH6FyRu31V4/jVR5ahw84Vxja4MZDC54Af0=;
        b=CMT5m6mZWxTSped8N5y7SQ5f0VyzooVu0i+PXF8wBQEwZEUJ9ItJqOdkuZ4hRXvd3J
         DV/2pDVqr8IYoRm2zLDCjf00Pz+DzU+GePYTIW9MobsILCqs96cH4KI4ATn6lfqLOd3l
         LIsIQ9vfxe7o1iTsiQL/dCsaq6Q7l0hOEM5uMV7g2wl+xv+RBvTP8tEMYSWbs4rR1NJK
         f/BNab7wF/F9wFPq+3oTcdfkkO2GCsdoL/85z6qc7sV3DroAlsTArC0Bnt/R+zReHokQ
         P/gads+5aMD7rzWh4p4cIYsfPSoyoWUJwtW61LcIKusQHbqUlzvcZS9OiHKpjwhJAtf6
         UeEw==
X-Gm-Message-State: AOAM532wFspLmimPVYQmKo4Kf1BpHw3QaPB3SIPMeZLZm1GHIcTYLFEq
        tgFjRQl2vDZ8itnFTQb0x7NGT+iJYSkoQtN4YR0fhg==
X-Google-Smtp-Source: ABdhPJzhDU211jqNtf99d4ch91XmC2+g1ndKtKy3gMf9afmnU8co4OtbBjLSdnPFybOWMwelWwCfAkTng1vDItm0TKI=
X-Received: by 2002:a7b:c387:: with SMTP id s7mr8454749wmj.26.1630877074069;
 Sun, 05 Sep 2021 14:24:34 -0700 (PDT)
MIME-Version: 1.0
References: <20210806134109.1182235-1-james.clark@arm.com> <20210806134109.1182235-3-james.clark@arm.com>
 <d2379e72-a285-c63f-8c32-806e412458a3@arm.com> <YTIB7aNBErDCK+sf@kernel.org>
In-Reply-To: <YTIB7aNBErDCK+sf@kernel.org>
From:   Mike Leach <mike.leach@linaro.org>
Date:   Sun, 5 Sep 2021 22:24:23 +0100
Message-ID: <CAJ9a7VjdFM+w0p-tJbkx2MDQPwetrau1amasa4ju2_3iLrXLfg@mail.gmail.com>
Subject: Re: [PATCH v2 2/9] perf cs-etm: Initialise architecture based on TRCIDR1
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Suzuki K Poulose <suzuki.poulose@arm.com>,
        James Clark <james.clark@arm.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Coresight ML <coresight@lists.linaro.org>,
        linux-perf-users@vger.kernel.org,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Fri, 3 Sept 2021 at 12:07, Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
>
> Em Fri, Sep 03, 2021 at 09:55:37AM +0100, Suzuki K Poulose escreveu:
> > On 06/08/2021 14:41, James Clark wrote:
> > > Currently the architecture is hard coded as ARCH_V8, but from ETMv4.4
> > > onwards this should be ARCH_AA64.
> > >
> > > Signed-off-by: James Clark <james.clark@arm.com>
> > > ---
> > >   tools/perf/util/cs-etm-decoder/cs-etm-decoder.c | 16 +++++++++++++++-
> > >   1 file changed, 15 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
> > > index 187c038caa19..787b19642e78 100644
> > > --- a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
> > > +++ b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
> > > @@ -126,6 +126,20 @@ static int cs_etm_decoder__gen_etmv3_config(struct cs_etm_trace_params *params,
> > >     return 0;
> > >   }
> > > +#define TRCIDR1_TRCARCHMIN_SHIFT 4
> > > +#define TRCIDR1_TRCARCHMIN_MASK  GENMASK(7, 4)
> > > +#define TRCIDR1_TRCARCHMIN(x)    (((x) & TRCIDR1_TRCARCHMIN_MASK) >> TRCIDR1_TRCARCHMIN_SHIFT)
> >
> > minor nit: Please add a blank line here
>
> Fixed it
>
> > > +static enum _ocsd_arch_version cs_etm_decoder__get_etmv4_arch_ver(u32 reg_idr1)
> > > +{
> > > +   /*
> > > +    * For ETMv4 if the trace minor version is 4 or more then we can assume
> > > +    * the architecture is ARCH_AA64 rather than just V8.
> > > +    * ARCH_V8 = V8 architecture
> > > +    * ARCH_AA64 = Min v8r3 plus additional AA64 PE features
> >
> > Does this need to be >= 3 then, to be accurate ?
> >
> > The comment "reads", minimum v8.3 and any additional features.
> >
> > Otherwise looks good to me.
>

Behaviour correctly matches OpenCSD decoder requirements.

Reviewed-by: Mike Leach <mike.leach@linaro.org>



> Didn't have enough coffee, I think, can you please provide this as a
> patch? :)
>
> - Arnaldo



--
Mike Leach
Principal Engineer, ARM Ltd.
Manchester Design Centre. UK
