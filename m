Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C472FC54EE9
	for <linux-perf-users@archiver.kernel.org>; Wed,  7 Sep 2022 22:41:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229498AbiIGWlw (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 7 Sep 2022 18:41:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229653AbiIGWlg (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 7 Sep 2022 18:41:36 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F86F647F0
        for <linux-perf-users@vger.kernel.org>; Wed,  7 Sep 2022 15:41:33 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id bz13so19428918wrb.2
        for <linux-perf-users@vger.kernel.org>; Wed, 07 Sep 2022 15:41:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=YH4gAbT+oR/XTHxxly1yVDATtdpiees7bO5OLCaKPwY=;
        b=YlXSUUUmGnjsqPH9qZotOiPiwMkzhSEKyQR0uEVY076HW++qYanPJdJo29q9+PDOk8
         UVAtc7OJ/wDLEBEdrNDHQe5Sp8ND8zLeDV0h4BpVOeYz5RQr5Wpkwt3LpTFgHYCwTuw1
         ag4urK2VGhnppqkVCBZdUIz6794hrJAUdXwjQqsMCDsB1Carm7jsEaAgKXQom4T+6DCR
         IOvKTIxQgoN3M6AK5iDvBy/wKYcKjSXk8e+yYQdlaRrr7YGEot3bezUW/zCH/akKTCLP
         iAp+bC8hsKsvixINCk7H9pgoi0QbKOEjBjAzbaYsRjhC56SlaYWhMKszXAhSFZ/WtMwa
         pRLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=YH4gAbT+oR/XTHxxly1yVDATtdpiees7bO5OLCaKPwY=;
        b=n5U/BVJDRbIw/6UYwOxP0cmkBW1QxNw8TFvQfD5tJ2kiNzsKiYtwIgIuf1WZET0Brj
         R+sf6/BvH+wOTdg/mIFjU59KEVq/29M3fLJMH8EC3dulD7hsHIkOS0ykAYPlEBiHheVo
         V3rejz1bAZlkOJh0rZi/NyDAgf0oe6vvNZyo/k4VMBn0Uk+ttzi/DZFQHullg07YNzrI
         VQVnCXcK+kfOjRXB+wSQGypdHX+rXT72apUQ3jqU2b+1wIQfT2jWJKIFhiBSXgCIMjpL
         9boOU1tPVzpgfhGkCxv02NAfPZbcQI1zfagjzwGidouOYG777PyKfmXGUhdkIFqJ5sOg
         TtfA==
X-Gm-Message-State: ACgBeo1pteOfU27oKLWk4cOCdlc2+boQLtNYh6TwQM8JSiv0Y/P7xHEY
        YwR69Du2zJfFHsfJrB0uGVPgONF3wE63+kz4mk2f8w==
X-Google-Smtp-Source: AA6agR4s9n0rZWwC0Jokan10uATNxTlZgQDh/BU11g7JTUk7e1DId0idNPdXqxT0GUVDPpxC5gjMPKQpPOMTsDSjW0M=
X-Received: by 2002:adf:bc13:0:b0:228:6d28:d2cb with SMTP id
 s19-20020adfbc13000000b002286d28d2cbmr3356293wrg.375.1662590491453; Wed, 07
 Sep 2022 15:41:31 -0700 (PDT)
MIME-Version: 1.0
References: <20220614143353.1559597-1-irogers@google.com> <20220614143353.1559597-7-irogers@google.com>
 <YuZ4CEnken8U4HO5@krava> <CAP-5=fVczMiasS15UovH8kzOaNw=TC_adeqjC+xBzv8jVJ3DTQ@mail.gmail.com>
In-Reply-To: <CAP-5=fVczMiasS15UovH8kzOaNw=TC_adeqjC+xBzv8jVJ3DTQ@mail.gmail.com>
From:   Ian Rogers <irogers@google.com>
Date:   Wed, 7 Sep 2022 15:41:19 -0700
Message-ID: <CAP-5=fWVN4Fig5GEwyWwwUc9_iZyZ5rObTFkyNcuFp1GApy4tg@mail.gmail.com>
Subject: Re: [PATCH v2 6/6] perf cpumap: Add range data encoding
To:     Jiri Olsa <olsajiri@gmail.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        James Clark <james.clark@arm.com>,
        Kees Cook <keescook@chromium.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Riccardo Mancini <rickyman7@gmail.com>,
        German Gomez <german.gomez@arm.com>,
        Colin Ian King <colin.king@intel.com>,
        Song Liu <songliubraving@fb.com>,
        Dave Marchevsky <davemarchevsky@fb.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>,
        Leo Yan <leo.yan@linaro.org>, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org, Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Thu, Aug 4, 2022 at 12:30 PM Ian Rogers <irogers@google.com> wrote:
>
> On Sun, Jul 31, 2022 at 5:39 AM Jiri Olsa <olsajiri@gmail.com> wrote:
> >
> > On Tue, Jun 14, 2022 at 07:33:53AM -0700, Ian Rogers wrote:
> >
> > SNIP
> >
> > > +     event = cpu_map_data__alloc(&syn_data, sizeof(struct perf_event_header));
> > >       if (!event)
> > >               return NULL;
> > >
> > > +     syn_data.data = &event->data;
> > >       event->header.type = PERF_RECORD_CPU_MAP;
> > > -     event->header.size = size;
> > > -     event->data.type   = type;
> > > -
> > > -     cpu_map_data__synthesize(&event->data, map, type, max);
> > > +     event->header.size = syn_data.size;
> > > +     cpu_map_data__synthesize(&syn_data);
> > >       return event;
> > >  }
> > >
> > > +
> > >  int perf_event__synthesize_cpu_map(struct perf_tool *tool,
> > >                                  const struct perf_cpu_map *map,
> > >                                  perf_event__handler_t process,
> > > @@ -1891,24 +1894,20 @@ int perf_event__synthesize_event_update_name(struct perf_tool *tool, struct evse
> > >  int perf_event__synthesize_event_update_cpus(struct perf_tool *tool, struct evsel *evsel,
> > >                                            perf_event__handler_t process)
> > >  {
> > > -     size_t size = sizeof(struct perf_event_header) + sizeof(u64) + sizeof(u64);
> > > +     struct synthesize_cpu_map_data syn_data = { .map = evsel->core.own_cpus };
> > >       struct perf_record_event_update *ev;
> > > -     int max, err;
> > > -     u16 type;
> > > -
> > > -     if (!evsel->core.own_cpus)
> > > -             return 0;
> >
> > all seems fine, just looks like we no longer do this check,
> > might not be needed anymore, as that changed in past
>
> This function is called in a test and in this file. The caller already
> does this test and so the check is redundant plus a little confusing:
> https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git/tree/tools/perf/util/synthetic-events.c?h=perf/core#n2062
> As you say, it wasn't needed any more and so I removed it.
>
> Thanks,
> Ian

Would be nice to land this imo. Anything outstanding?

Thanks,
Ian

> > thanks,
> > jirka
> >
> > > +     int err;
> > >
> > > -     ev = cpu_map_data__alloc(evsel->core.own_cpus, &size, &type, &max);
> > > +     ev = cpu_map_data__alloc(&syn_data, sizeof(struct perf_event_header) + 2 * sizeof(u64));
> > >       if (!ev)
> > >               return -ENOMEM;
> > >
> > > +     syn_data.data = &ev->cpus.cpus;
> > >       ev->header.type = PERF_RECORD_EVENT_UPDATE;
> > > -     ev->header.size = (u16)size;
> > > +     ev->header.size = (u16)syn_data.size;
> > >       ev->type        = PERF_EVENT_UPDATE__CPUS;
> > >       ev->id          = evsel->core.id[0];
> > > -
> > > -     cpu_map_data__synthesize(&ev->cpus.cpus, evsel->core.own_cpus, type, max);
> > > +     cpu_map_data__synthesize(&syn_data);
> > >
> > >       err = process(tool, (union perf_event *)ev, NULL, NULL);
> > >       free(ev);
> > > --
> > > 2.36.1.476.g0c4daa206d-goog
> > >
