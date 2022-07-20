Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8821DCCA485
	for <linux-perf-users@archiver.kernel.org>; Wed, 20 Jul 2022 10:54:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240449AbiGTKyV (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 20 Jul 2022 06:54:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240174AbiGTKyM (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 20 Jul 2022 06:54:12 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C95146D2CF
        for <linux-perf-users@vger.kernel.org>; Wed, 20 Jul 2022 03:54:10 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id by8so17056157ljb.13
        for <linux-perf-users@vger.kernel.org>; Wed, 20 Jul 2022 03:54:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=H2liMUhwFLnqblQWVp0+sHkDyBEAsE7r1d29yfl1OwY=;
        b=ds4nGn7g1cZVWp7jhlV5N1NY02wW5Q8UnPUG1WHCgVhPAf+VFoLzeQ4k0u2FTPwbcW
         i4O0CJEQEAoYOMaJcLfraX6bLPS+DmXLx5KPuzYD5D5XQpCWE/J1EHv+H1zmrpVL7L1a
         O3OEacpE2rSGJ5m/IellUPzvnVg27yYOdwEaBSctJUo+44mttt4Jw72a35a0vrnSiap/
         /LW8/1QLxQwpgMVNiozRTO8xkTycDwXS21Ch+fInSdn98ATu6bx4JwDJbfjgSs1GS9fv
         icnTuX8QaOqVAWIy7NuQGyS+J1X+I8FgyVS8tpYRZt1/oslksKFbMw8gyMf/idr+CE4N
         Lj/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=H2liMUhwFLnqblQWVp0+sHkDyBEAsE7r1d29yfl1OwY=;
        b=j7+TJy44T2WwA6/LkEwRJhhThUk48q19Uanc3Ku+mHx+pzCrnSbZ0xGhf01CpLUTrg
         Rw9iBvfPBDCDfSdfRK+a4cppyCK3Nr6SG5H0780vDLHMngF5ouxlRyHKU4o+39BuCKbn
         V6f4chEhrA+WEZ645X5cnr3K+3NFV8uvfox+1HyMHPAvQULuqLvejU8xtLLyfN/v3bLe
         SmQEcJaVgCJsuheC8sU62oM/U62yUimT3+Jg/fz2OR0U86g1eaYGggNqcWOOI0XMium6
         CbT000/BWf6pQ1ybX05P3Gx9YcnD7PW7+mJTcujSlP229W7Miaj2KxsxBXnlI7A4DRWu
         lg6g==
X-Gm-Message-State: AJIora8TQXwcVlLjHTPScL4lpfdK0OmDdj6uFlfjSn4cEPbMzOe5XH/V
        MIRjDME7HkyKVInQxVaEil+6ptWbTpRMbaSwsxi1iQ==
X-Google-Smtp-Source: AGRyM1tZtNdan8cMpa7GNKg2eZfKn/Z8LOI40xG7Wuh6cnAsxGvaIZ5YS/kVzCd0qN7L2HqkbsksXCZorqEmzvUlK0c=
X-Received: by 2002:a05:651c:2102:b0:25a:42ee:49ae with SMTP id
 a2-20020a05651c210200b0025a42ee49aemr16476079ljq.200.1658314449047; Wed, 20
 Jul 2022 03:54:09 -0700 (PDT)
MIME-Version: 1.0
References: <20220704081149.16797-1-mike.leach@linaro.org> <20220704081149.16797-13-mike.leach@linaro.org>
 <312bce37-8201-e0a7-0122-77ec1ebef556@arm.com>
In-Reply-To: <312bce37-8201-e0a7-0122-77ec1ebef556@arm.com>
From:   Mike Leach <mike.leach@linaro.org>
Date:   Wed, 20 Jul 2022 11:53:58 +0100
Message-ID: <CAJ9a7VjG_dRdH63UnwEABoPQ4ofVKuvAU=TrQHcUrpt9gQa2bg@mail.gmail.com>
Subject: Re: [PATCH v2 12/13] coresight: events: PERF_RECORD_AUX_OUTPUT_HW_ID
 used for Trace ID
To:     Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, mathieu.poirier@linaro.org,
        peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        linux-perf-users@vger.kernel.org, leo.yan@linaro.org,
        quic_jinlmao@quicinc.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Hi Suzuki,

On Wed, 20 Jul 2022 at 10:30, Suzuki K Poulose <suzuki.poulose@arm.com> wrote:
>
> On 04/07/2022 09:11, Mike Leach wrote:
> > Use the perf_report_aux_output_id() call to output the CoreSight trace ID
> > and associated CPU as a PERF_RECORD_AUX_OUTPUT_HW_ID record in the
> > perf.data file.
> >
> > Signed-off-by: Mike Leach <mike.leach@linaro.org>
> > ---
> >   drivers/hwtracing/coresight/coresight-etm-perf.c | 10 ++++++++++
> >   include/linux/coresight-pmu.h                    | 14 ++++++++++++++
> >   2 files changed, 24 insertions(+)
> >
> > diff --git a/drivers/hwtracing/coresight/coresight-etm-perf.c b/drivers/hwtracing/coresight/coresight-etm-perf.c
> > index ad3fdc07c60b..531f5d42272b 100644
> > --- a/drivers/hwtracing/coresight/coresight-etm-perf.c
> > +++ b/drivers/hwtracing/coresight/coresight-etm-perf.c
> > @@ -4,6 +4,7 @@
> >    * Author: Mathieu Poirier <mathieu.poirier@linaro.org>
> >    */
> >
> > +#include <linux/bitfield.h>
> >   #include <linux/coresight.h>
> >   #include <linux/coresight-pmu.h>
> >   #include <linux/cpumask.h>
> > @@ -437,6 +438,7 @@ static void etm_event_start(struct perf_event *event, int flags)
> >       struct perf_output_handle *handle = &ctxt->handle;
> >       struct coresight_device *sink, *csdev = per_cpu(csdev_src, cpu);
> >       struct list_head *path;
> > +     u64 hw_id;
> >
> >       if (!csdev)
> >               goto fail;
> > @@ -482,6 +484,11 @@ static void etm_event_start(struct perf_event *event, int flags)
> >       if (source_ops(csdev)->enable(csdev, event, CS_MODE_PERF))
> >               goto fail_disable_path;
> >
> > +     /* output cpu / trace ID in perf record */
> > +     hw_id = FIELD_PREP(CS_AUX_HW_ID_VERSION_MASK, CS_AUX_HW_ID_CURR_VERSION) |
> > +             FIELD_PREP(CS_AUX_HW_ID_TRACE_ID_MASK, coresight_trace_id_get_cpu_id(cpu));
> > +     perf_report_aux_output_id(event, hw_id);
> > +
> >   out:
> >       /* Tell the perf core the event is alive */
> >       event->hw.state = 0;
> > @@ -600,6 +607,9 @@ static void etm_event_stop(struct perf_event *event, int mode)
> >
> >       /* Disabling the path make its elements available to other sessions */
> >       coresight_disable_path(path);
> > +
> > +     /* release the trace ID we read on event start */
> > +     coresight_trace_id_put_cpu_id(cpu);
> >   }
> >
> >   static int etm_event_add(struct perf_event *event, int mode)
> > diff --git a/include/linux/coresight-pmu.h b/include/linux/coresight-pmu.h
> > index 9f7ee380266b..5572d0e10822 100644
> > --- a/include/linux/coresight-pmu.h
> > +++ b/include/linux/coresight-pmu.h
> > @@ -7,6 +7,8 @@
> >   #ifndef _LINUX_CORESIGHT_PMU_H
> >   #define _LINUX_CORESIGHT_PMU_H
> >
> > +#include <linux/bits.h>
> > +
> >   #define CORESIGHT_ETM_PMU_NAME "cs_etm"
> >
> >   /*
> > @@ -38,4 +40,16 @@
> >   #define ETM4_CFG_BIT_RETSTK 12
> >   #define ETM4_CFG_BIT_VMID_OPT       15
> >
> > +/*
> > + * Interpretation of the PERF_RECORD_AUX_OUTPUT_HW_ID payload.
> > + * Used to associate a CPU with the CoreSight Trace ID.
> > + * [63:16] - unused SBZ
> > + * [15:08] - Trace ID
> > + * [07:00] - Version
>
> Could we please re-arrange the fields, such that it is easier to
> comprehend the TraceID looking at the raw trace dump ? Also to
> accommodate the future changes.
>
> e.g,
>        [15:00] - Trace ID        /* For future expansion, if at all */
>        [59:16] - RES0
>        [63:60] - Trace_ID_Version
>
> I think we *might* (not sure yet) end up adding "sinkid" when we have
> sink specific allocation, so that we can associate the HW_ID of an event
> to the "AUXTRACE" record (i.e., trace buffer).
>

If we go to per sink trace ID maps, then I can't see how we could
avoid needing some sort of ID in here, unless we can determine some
other method of specifying which CPUs traced into which trace buffer.

> So if we need to do that we could:
>
>        [15:00] - Trace ID        /* For future expansion, if at all */
>        [47:16] - Trace Pool ID( == 0 if global, == sink_id if sink based)
>        [59:48] - RES0
>        [63:60] - Trace_ID_Version == 1
>
> Or we could adopt the above straight away.
>

I wouldn't want to commit to a size for the sink ID yet. And I would
leave trace ID at what it is for now (8 bits).
Make the fields represent what is and up-version and update when
changes are actually required.
I think this packet may be a candidate for delivering other trace
related info we may need in future - such as the timestamp source that
is being worked on?

Mike

> Thoughts ?
>
> Suzuki
>
> > + */
> > +#define CS_AUX_HW_ID_VERSION_MASK    GENMASK_ULL(7, 0)
> > +#define CS_AUX_HW_ID_TRACE_ID_MASK   GENMASK_ULL(15, 8)
> > +
> > +#define CS_AUX_HW_ID_CURR_VERSION 0
>
>
> > +
> >   #endif
>


-- 
Mike Leach
Principal Engineer, ARM Ltd.
Manchester Design Centre. UK
