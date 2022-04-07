Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 273BAC433F5
	for <linux-perf-users@archiver.kernel.org>; Thu,  7 Apr 2022 17:46:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346569AbiDGRsg (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 7 Apr 2022 13:48:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346568AbiDGRsc (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 7 Apr 2022 13:48:32 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60BDA186FB
        for <linux-perf-users@vger.kernel.org>; Thu,  7 Apr 2022 10:46:31 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id 32so3436002pgl.4
        for <linux-perf-users@vger.kernel.org>; Thu, 07 Apr 2022 10:46:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=glYV/l98Ao73KMk9v/wcQMQsuIKB62MFE0MbECEB0bU=;
        b=HqOjqTdpUg8BZniBO/NW6yOtfh1s/xQNadFPrvtrh4cZEyz0PcnUnZHLcuc2NOLgZy
         65NawgWlhpko3+AdB6n4v64b2tK8ye4gOhdvV1dD0OFj3XGP19HTxJ1JgyLWm6P6k8+n
         hNpcW/A8zRCpIWDHw4Bh9nMkRX3vC7DVzrN83N0z1xs1f58zmSaOQvXMQ0oeRE5Ect/n
         VfLmm3q7xLyeb/MJZSrGjYFiBbCRvYQQGZSfPkuB6NhWjGAhawp5uuweYY8ESS8Ex8KD
         ZYz8zTlsyCc7DUgDYkGl17tNSOdKqxud95KTOJRehhHpUbDQmnX0PClssah+OnSxbH3N
         orCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=glYV/l98Ao73KMk9v/wcQMQsuIKB62MFE0MbECEB0bU=;
        b=3wx0TGjafEDEz6iuaE93WOn0uuViX+aaakU9r4tZ9FuTEzXXoMbJEMM6av1q1ngQiu
         p0iNsH2UGIB0EVeGmIW+FP/XsI2xs8XpMftGAFxGDCQxHpRoSWq4MaBzSx56TuSZE73Z
         8JQKCdH5MPUyT1o1e8QD8g/h2reeVon/SkbS58ZCnGn+4vuTd8LkFT9aA0uQSw1Kir49
         QPU3vKnNS2Fx9OznadNz2obVyxT9HSMQnQl3l8SP9Xq+flY9UnuiKalbBWBe+QbIBM0H
         eb8z6fdbGwFjyg12hlZYT95QE8DK4yDoK+K6hcoAogIRXIhoTP9A/1gZpoO0fOa5096W
         cGQA==
X-Gm-Message-State: AOAM53301DIrLk4fe0bL7z/VcT0uC71VBKG1gZEklOq9rFGTVuaq2MIo
        qwSVgC1Eyx/bPjAuTXuj1BD9Vg==
X-Google-Smtp-Source: ABdhPJwWzWTtKrbU/L85VXBDuYFm4dEdyrUa/oHetBMpYkSefD5/LRCLbjqFtOCTrMCYytD8j93sPQ==
X-Received: by 2002:a65:6a97:0:b0:398:ae2:d207 with SMTP id q23-20020a656a97000000b003980ae2d207mr11843101pgu.197.1649353590776;
        Thu, 07 Apr 2022 10:46:30 -0700 (PDT)
Received: from p14s (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id x6-20020a17090aa38600b001ca2f87d271sm9611813pjp.15.2022.04.07.10.46.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Apr 2022 10:46:29 -0700 (PDT)
Date:   Thu, 7 Apr 2022 11:46:27 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Mike Leach <mike.leach@linaro.org>
Cc:     suzuki.poulose@arm.com, coresight@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        linux-perf-users@vger.kernel.org, leo.yan@linaro.org
Subject: Re: [PATCH 06/10] coresight: perf: traceid: Add perf notifiers for
 trace ID
Message-ID: <20220407174627.GA102085@p14s>
References: <20220308205000.27646-1-mike.leach@linaro.org>
 <20220308205000.27646-7-mike.leach@linaro.org>
 <20220406171132.GA16110@p14s>
 <CAJ9a7Vjb0G4fSB6U33JruVWcBzpP459rYq+5CzMqxRcWeiJb0w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJ9a7Vjb0G4fSB6U33JruVWcBzpP459rYq+5CzMqxRcWeiJb0w@mail.gmail.com>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Good morning,

On Wed, Apr 06, 2022 at 08:38:08PM +0100, Mike Leach wrote:
> Hi Mathieu,
> 
> On Wed, 6 Apr 2022 at 18:11, Mathieu Poirier <mathieu.poirier@linaro.org> wrote:
> >
> > On Tue, Mar 08, 2022 at 08:49:56PM +0000, Mike Leach wrote:
> > > Adds in notifier calls to the trace ID allocator that perf
> > > events are starting and stopping.
> > >
> > > This ensures that Trace IDs associated with CPUs remain the same
> > > throughout the perf session, and are only release when all perf
> > > sessions are complete.
> > >
> > > Signed-off-by: Mike Leach <mike.leach@linaro.org>
> > > ---
> > >  drivers/hwtracing/coresight/coresight-etm-perf.c | 16 +++++++++++++++-
> > >  1 file changed, 15 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/hwtracing/coresight/coresight-etm-perf.c b/drivers/hwtracing/coresight/coresight-etm-perf.c
> > > index c039b6ae206f..008f9dac429d 100644
> > > --- a/drivers/hwtracing/coresight/coresight-etm-perf.c
> > > +++ b/drivers/hwtracing/coresight/coresight-etm-perf.c
> > > @@ -22,6 +22,7 @@
> > >  #include "coresight-etm-perf.h"
> > >  #include "coresight-priv.h"
> > >  #include "coresight-syscfg.h"
> > > +#include "coresight-trace-id.h"
> > >
> > >  static struct pmu etm_pmu;
> > >  static bool etm_perf_up;
> > > @@ -223,11 +224,21 @@ static void free_event_data(struct work_struct *work)
> > >               struct list_head **ppath;
> > >
> > >               ppath = etm_event_cpu_path_ptr(event_data, cpu);
> > > -             if (!(IS_ERR_OR_NULL(*ppath)))
> > > +             if (!(IS_ERR_OR_NULL(*ppath))) {
> > >                       coresight_release_path(*ppath);
> > > +                     /*
> > > +                      * perf may have read a trace id for a cpu, but never actually
> > > +                      * executed code on that cpu - which means the trace id would
> > > +                      * not release on disable. Re-release here to be sure.
> > > +                      */
> > > +                     coresight_trace_id_put_cpu_id(cpu, coresight_get_trace_id_map());
> >
> > A CPU gets a traceID in event_etm_start() when the event is installed for
> > running.  Do you see a scenario where etm_free_aux() is called without
> > previously calling event_etm_stop()?
> >
> 
> To ensure that IDs are obtained in a timely manner, they assign on
> read. Therefore when cs_etm.c::cs_etm_info_fill() is called,
> potentially the ID will be read for all CPUs - and dumped into the
> AUXINFO data at the top of the perf.data file.

Right, I realised that when I got to the perf tools part.  If we end up keeping
the current approach it would be nice to see this explanation in the comment.
Otherwise it will be very difficult for anyone new to the project to understand
what is going on.

> However, a --per-thread execution may actually only start the event on
> a subset of cpus, hence we ensure that all cpus are released.
> This was proven during testing when I ran both --per-thread and cpu
> wide tests with logging monitoring the ID assignments.
> 
> I have programmed this deliberately defensively - on the basis that
> the timings and orderings of the code/callbacks in todays perf may not
> necessarily be the same in tomorrows. perf.
> 
> In future we may be able to use Suzuki's idea of embedding the ID into
> an alternative packet in the perf.data file. but I think that should
> be a separate change as it affects decode in a big way.
>

I really like Suzuki's idea of using a PERF_RECORD_AUX_OUTPUT_HW_ID to convey
the traceID to user space for perf sessions.  At the very least it is worth
prototyping.

I generally prefer an incremental approach but in this case it might be better
to move forward the right way, right away.  We would also avoid having to
maintain the old way, the intermediate way and the new way.

Thanks,
Mathieu

> Regards
> 
> Mike
> 
> 
> > > +             }
> > >               *ppath = NULL;
> > >       }
> > >
> > > +     /* mark perf event as done for trace id allocator */
> > > +     coresight_trace_id_perf_stop();
> > > +
> > >       free_percpu(event_data->path);
> > >       kfree(event_data);
> > >  }
> > > @@ -314,6 +325,9 @@ static void *etm_setup_aux(struct perf_event *event, void **pages,
> > >               sink = user_sink = coresight_get_sink_by_id(id);
> > >       }
> > >
> > > +     /* tell the trace ID allocator that a perf event is starting up */
> > > +     coresight_trace_id_perf_start();
> > > +
> > >       /* check if user wants a coresight configuration selected */
> > >       cfg_hash = (u32)((event->attr.config2 & GENMASK_ULL(63, 32)) >> 32);
> > >       if (cfg_hash) {
> > > --
> > > 2.17.1
> > >
> 
> 
> 
> -- 
> Mike Leach
> Principal Engineer, ARM Ltd.
> Manchester Design Centre. UK
