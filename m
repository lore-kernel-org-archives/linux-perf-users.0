Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36943C6FA82
	for <linux-perf-users@archiver.kernel.org>; Tue, 20 Sep 2022 18:31:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230176AbiITSbg (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 20 Sep 2022 14:31:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbiITSbf (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 20 Sep 2022 14:31:35 -0400
Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0A7D5C97C;
        Tue, 20 Sep 2022 11:31:34 -0700 (PDT)
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-12c8312131fso5537287fac.4;
        Tue, 20 Sep 2022 11:31:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=I/JfvoNxXRGwUjwmsGrmIv5Ml238tRphNCPJqlYEg1Q=;
        b=pY75707wvPeI3s3v0ocmWHwo/OeKcrzVEQlI27DFYIWWb1IAyHIrGgHvD2aD6JBoWr
         oWaQYcgReArB5yHfintP4AcTu8arrpOmH6a9GETWpISPprxqIk1w/eZkk1iO7Do3gdek
         sVWKMY1vxlara/PCbXHJNULx5A3Edo4q+U+/3sa7X5wgG3DOWMrV12XxZC5XOqox3Uue
         UBokkQ2Nra3TKlYkLLlsEY1sPx/I9E5Q51U4iN3Y4d0D7TgfWO7lmtifcOh19bZOsYIA
         ewGCV7vke6+/gdFfNBiwPD9unos4MfgXbeLrhHuBECpU7vxj/3vhBri6N6m/QGieegyg
         45dA==
X-Gm-Message-State: ACrzQf1jlZbVSe0z3a8Jp5rA8jHzuFWpkceUR3HKI4D3fEz84xwVGmzh
        gJ7W8Lm8l9NrC1vkgcdTjmzi6MBAYZreewjal24=
X-Google-Smtp-Source: AMsMyM6a5iemjvOUCYYn43gXObzlr02xv2lEqpbUwc3NAhah3zzGHGNaKsFo2LR8aAJhStDZcEQkLkydW04+2sbfk4s=
X-Received: by 2002:a05:6870:524b:b0:12c:cfd2:81c0 with SMTP id
 o11-20020a056870524b00b0012ccfd281c0mr2802232oai.209.1663698693918; Tue, 20
 Sep 2022 11:31:33 -0700 (PDT)
MIME-Version: 1.0
References: <20220916175902.1155177-1-namhyung@kernel.org> <20220916175902.1155177-5-namhyung@kernel.org>
 <a50941ad-ae74-933e-4d22-f4c67bafc0c1@intel.com>
In-Reply-To: <a50941ad-ae74-933e-4d22-f4c67bafc0c1@intel.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Tue, 20 Sep 2022 11:31:22 -0700
Message-ID: <CAM9d7cgXj=fuie=Tz3L+-fNmd=ZA1B+ia9-Myh49EDGc4yxJ0A@mail.gmail.com>
Subject: Re: [PATCH 4/4] perf tools: Honor namespace when synthesizing build-id
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ian Rogers <irogers@google.com>,
        linux-perf-users <linux-perf-users@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Tue, Sep 20, 2022 at 6:36 AM Adrian Hunter <adrian.hunter@intel.com> wrote:
>
> On 16/09/22 20:59, Namhyung Kim wrote:
> > It needs to go into a namespace before reading a file.
>
> This looks like a fix, in which case make it the first patch
> and add a fixes tag?

Good point, will do.

Thanks,
Namhyung


>
> >
> > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> > ---
> >  tools/perf/util/synthetic-events.c | 8 ++++++++
> >  1 file changed, 8 insertions(+)
> >
> > diff --git a/tools/perf/util/synthetic-events.c b/tools/perf/util/synthetic-events.c
> > index e6978b2dee8f..d0d540d09196 100644
> > --- a/tools/perf/util/synthetic-events.c
> > +++ b/tools/perf/util/synthetic-events.c
> > @@ -391,6 +391,8 @@ static void perf_record_mmap2__read_build_id(struct perf_record_mmap2 *event,
> >       struct build_id _bid, *bid = &_bid;
> >       struct dso *dso = NULL;
> >       struct dso_id id;
> > +     struct nsinfo *nsi;
> > +     struct nscookie nc;
> >       int rc;
> >
> >       if (is_kernel) {
> > @@ -410,8 +412,14 @@ static void perf_record_mmap2__read_build_id(struct perf_record_mmap2 *event,
> >               goto out;
> >       }
> >
> > +     nsi = nsinfo__new(event->pid);
> > +     nsinfo__mountns_enter(nsi, &nc);
> > +
> >       rc = filename__read_build_id(event->filename, bid) > 0 ? 0 : -1;
> >
> > +     nsinfo__mountns_exit(&nc);
> > +     nsinfo__put(nsi);
> > +
> >  out:
> >       if (rc == 0) {
> >               memcpy(event->build_id, bid->data, sizeof(bid->data));
>
