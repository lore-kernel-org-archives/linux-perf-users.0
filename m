Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23F1FC46467
	for <linux-perf-users@archiver.kernel.org>; Tue, 10 Jan 2023 19:55:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233014AbjAJTzb (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 10 Jan 2023 14:55:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233719AbjAJTzO (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 10 Jan 2023 14:55:14 -0500
Received: from mail-ua1-x930.google.com (mail-ua1-x930.google.com [IPv6:2607:f8b0:4864:20::930])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58A2A6144D
        for <linux-perf-users@vger.kernel.org>; Tue, 10 Jan 2023 11:55:12 -0800 (PST)
Received: by mail-ua1-x930.google.com with SMTP id j14so3117749ual.10
        for <linux-perf-users@vger.kernel.org>; Tue, 10 Jan 2023 11:55:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=sWBEBP027jXHEOv42rUgQvSGJQYUen22iKr19l7Fb5c=;
        b=ZvDn4oLes/zIvHZnvm9rOYT4nRMF641r1zUUek8ObygdZBRDlKXPXaR3O73c5Z8N5c
         yTZU8haKKw2Jt9Lu0nZ9R4wxDLJiZKc8zL6SJZelSJ3Mys0++GiEgBPYJVnjdny49Ubz
         WueFGuXhgejNTzvxG72WVDyXzk+P8OFy+E26WcowRGQpDNirYzuw/jxjTUjPzKdNzODT
         1IIFTQHLQiOGsAvACd/P1TqMk0IR67cFhcN5QGkcHANIBKYcF6oklKsEGh/toH9rc+hj
         tx7SGz92SYR751/wWpPsA5k1SXEkz+euWt//srFjU3rruVzzEo0po4rbYqq6gVaq3BtZ
         COGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sWBEBP027jXHEOv42rUgQvSGJQYUen22iKr19l7Fb5c=;
        b=yz4GdNArixldRdFmojsiXX3U3DMEjbnrbkbhobOfBQ++/9gsgzUePzfthlLnpzxZRe
         aeYFHpYoErBIxxSrKT0R3qz3/AzAfXl+e+pbUHusDTdjblHx0q1t4DrVjmZmbVywG7sd
         iBNB54rdGk4OQm4bMCWLxIbTeIL3Et579HvdnVe5d2xaq0f0zc/IU7BcsgX6QPTmDkuz
         E/YkbBS5sMWWBnc93NHBuNOxR8oOY2e7vHFkiwCPrnndNS2O6OyMf76bofLa/AQ0ahgh
         S9fAjNa9nEmzYAc4TvaGUz6WHR7MNFN2wGGiSzwZRAqxhCoUZhaiDIRPWfvPPaKHjro7
         Bz1g==
X-Gm-Message-State: AFqh2kqthdcHD6dLyCKmxPiGyO4W0kFODs/quyxhr+AmuDXUcUpLo1OT
        lvIxM/6LG+cWwDazb8OdEOoWfWrUs0mzGp5GwSbgzw==
X-Google-Smtp-Source: AMrXdXsKJ3C7aDvSUwLwevuHQJ81rHrWDmF5y8Qk9LmQIOGF4k3ZXY44O3j2EAQ2+FM0Kkw8jiVd4jC9tH4xM8gmIWg=
X-Received: by 2002:ab0:152b:0:b0:418:620e:6794 with SMTP id
 o40-20020ab0152b000000b00418620e6794mr7714686uae.59.1673380511203; Tue, 10
 Jan 2023 11:55:11 -0800 (PST)
MIME-Version: 1.0
References: <20230109223110.1201541-1-irogers@google.com> <CAM9d7cgGq=+MC+qwRNxO=0Bn_ZMOucEzh_WWH95Lq8fsYHMb4A@mail.gmail.com>
 <CAP-5=fXniy80Jpc2Hu=-GF7yDNUNHjs0=B2iqkUkMb6zArPukg@mail.gmail.com> <CAM9d7chS+91Nep8FtsJsOdTvMJ0HhkSD1_Fn70=hWPi7a1JpfQ@mail.gmail.com>
In-Reply-To: <CAM9d7chS+91Nep8FtsJsOdTvMJ0HhkSD1_Fn70=hWPi7a1JpfQ@mail.gmail.com>
From:   Ian Rogers <irogers@google.com>
Date:   Tue, 10 Jan 2023 11:54:58 -0800
Message-ID: <CAP-5=fUXoOFueaeSD2D9H+xoH5tKXRHK1164yPSX8_m_Nx_AeQ@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] perf tools: Remove HAVE_LIBTRACEEVENT_TEP_FIELD_IS_RELATIVE
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Yang Jihong <yangjihong1@huawei.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Kim Phillips <kim.phillips@amd.com>,
        German Gomez <german.gomez@arm.com>,
        Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Eelco Chaudron <echaudro@redhat.com>,
        Leo Yan <leo.yan@linaro.org>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        Stephane Eranian <eranian@google.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Tue, Jan 10, 2023 at 11:09 AM Namhyung Kim <namhyung@kernel.org> wrote:
>
> On Mon, Jan 9, 2023 at 3:38 PM Ian Rogers <irogers@google.com> wrote:
> >
> > On Mon, Jan 9, 2023 at 2:57 PM Namhyung Kim <namhyung@kernel.org> wrote:
> > >
> > > Hi Ian,
> > >
> > > On Mon, Jan 9, 2023 at 2:31 PM Ian Rogers <irogers@google.com> wrote:
> > > > diff --git a/tools/perf/util/sort.c b/tools/perf/util/sort.c
> > > > index e188f74698dd..cfcc253239f0 100644
> > > > --- a/tools/perf/util/sort.c
> > > > +++ b/tools/perf/util/sort.c
> > > > @@ -28,6 +28,7 @@
> > > >  #include "time-utils.h"
> > > >  #include "cgroup.h"
> > > >  #include "machine.h"
> > > > +#include "trace-event.h"
> > > >  #include <linux/kernel.h>
> > > >  #include <linux/string.h>
> > > >
> > > > @@ -2667,7 +2668,7 @@ static int64_t __sort__hde_cmp(struct perf_hpp_fmt *fmt,
> > > >                 tep_read_number_field(field, a->raw_data, &dyn);
> > > >                 offset = dyn & 0xffff;
> > > >                 size = (dyn >> 16) & 0xffff;
> > > > -#ifdef HAVE_LIBTRACEEVENT_TEP_FIELD_IS_RELATIVE
> > > > +#if LIBTRACEEVENT_VERSION >= MAKE_LIBTRACEEVENT_VERSION(1, 5, 0)
> > > >                 if (field->flags & TEP_FIELD_IS_RELATIVE)
> > > >                         offset += field->offset + field->size;
> > >
> > > Maybe I missed the previous discussion.
> > >
> > > As it's only used in the bit test, can we have something like this
> > > in the header file?
> > >
> > > #if LIBTRACE_EVENT_VERSION < ...(1, 5, 0)
> > > # define TEP_FIELD_IS_RELATIVE  0
> > > #endif
> > >
> > > Thanks,
> > > Namhyung
> >
> > We could but I think we lose some of the intention revealing-ness that
> > TEP_FIELD_IS_RELATIVE is only present with libtraceevent 1.5.0 or
> > newer.
>
> I'm not sure how important it is to reveal the intention.
> I think we wanted to minimize #ifdef-ery in the .c file and
> moved the conditionals to the header.  Maybe we can add
> a wrapper like this.
>
> #if LIBTRACEEVENT_VERSION >= ...(1, 5, 0)
> static inline bool is_relative_field(field)
> {
>     return field->flags & TEP_FIELD_IS_RELATIVE;
> }
> #else
> static inline bool is_relative_field(field)
> {
>     return false;
> }
> #endif
>
> Thanks,
> Namhyung

Sounds good. Should the change be part of this one or a follow up
patch? A follow up patch seems cleanest, I can add it to v2.

Thanks,
Ian
