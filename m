Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2D31C3DA78
	for <linux-perf-users@archiver.kernel.org>; Tue, 17 Jan 2023 13:02:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236103AbjAQNC4 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 17 Jan 2023 08:02:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236788AbjAQNCm (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 17 Jan 2023 08:02:42 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE16F31E02
        for <linux-perf-users@vger.kernel.org>; Tue, 17 Jan 2023 05:02:41 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id x2-20020a17090a46c200b002295ca9855aso6104142pjg.2
        for <linux-perf-users@vger.kernel.org>; Tue, 17 Jan 2023 05:02:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=jmIfKKj7U8Bcy9yj2YgmEfLZDpCS32pWFxDGk4zOAmQ=;
        b=qASjWliaWCrKRQ9R7a3HdRD3wfjSMYeWigyGmwPIlQPT0evFxvqsL3mP4vjvxl0HXT
         Xfd9p7NjAA+SyYxihPlOXeX2/DPGibynkITo2FypiWhKjgFeOvj6oym18lwCv1uT6cUZ
         LRmlgXsoUGBbM39r6ME7ug1aSPsKzobn6azc7AXCppTSqSbFm+ITNXqZR3YWwz+0uFQ9
         bsKgGsZ8B2WQtxJ1qDZEzeuZztgdPLl8apVmzxtqEvVsIP70h25SLCd3gZaVSRCuYa9n
         OWmU9/YudYlAXzvGDv2cGUQE8j8ysK7Lk2seZ6V3a7BBzzdXFeMc/EPlwm3d8Faa9hIq
         oryA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jmIfKKj7U8Bcy9yj2YgmEfLZDpCS32pWFxDGk4zOAmQ=;
        b=M4SI4AAlq/CKB4ktkGmrgucMTBICzhFjge1eJRVsztRFaLcg528jYgd+J0BJyQ6AbB
         49hazPqh+xaDR0LoSZwrgChgQDPusKJAYRLM6YuHFhjB1kvFL30ndAODre4ZbQcfzzR7
         8ZfyxiS8a5XIpJhSwRaJoDed2THFR30BwgxArURzYO5guc9wjAgRWcK/hgwVJvVauCLW
         Ikq532xhDoI4AOnLydXnxS26lwZjgUTxld/1/nKWOdNxzFe2ZWcbWkl71KTSMuGVzN0v
         JxIBsJD6UGDsebSnkFKy6wC3dwpZjG8zW6DaTYpgSj/yGpmwG9vuSS+F/AxReCB641Ev
         8Wfw==
X-Gm-Message-State: AFqh2krtbhjDOf4YrUOLUnXk/GyftiLKX8ikeJacevDW8diD4ugZ7WqP
        DwFB4Q7xM8Xn9L5+kx+pRTDBsQuziNj1HJUI1X+yVg==
X-Google-Smtp-Source: AMrXdXv+i/hO3HrGWtPdleEamTrdv9t60Vx4JRXDr8oRauAlWP6HwqCLIuRipmrBsGIcaXtn+991HUpTrAVSyDKwif0=
X-Received: by 2002:a17:90a:9413:b0:229:81a7:c5a7 with SMTP id
 r19-20020a17090a941300b0022981a7c5a7mr309318pjo.76.1673960561097; Tue, 17 Jan
 2023 05:02:41 -0800 (PST)
MIME-Version: 1.0
References: <20230116124928.5440-1-mike.leach@linaro.org> <20230116124928.5440-2-mike.leach@linaro.org>
 <1896a73b-eb7b-7ffb-272d-115a10adeb71@arm.com>
In-Reply-To: <1896a73b-eb7b-7ffb-272d-115a10adeb71@arm.com>
From:   Mike Leach <mike.leach@linaro.org>
Date:   Tue, 17 Jan 2023 13:02:29 +0000
Message-ID: <CAJ9a7VixL9f2Cm7A780V311KH2G2giryeH9dG0p2e4zWBwA3iQ@mail.gmail.com>
Subject: Re: [PATCH v7 01/15] coresight: trace-id: Add API to dynamically
 assign Trace ID values
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

On Mon, 16 Jan 2023 at 14:16, Suzuki K Poulose <suzuki.poulose@arm.com> wrote:
>
> Hi Mike
>
> On 16/01/2023 12:49, Mike Leach wrote:
> > The existing mechanism to assign Trace ID values to sources is limited
> > and does not scale for larger multicore / multi trace source systems.
> >
> > The API introduces functions that reserve IDs based on availabilty
> > represented by a coresight_trace_id_map structure. This records the
> > used and free IDs in a bitmap.
> >
> > CPU bound sources such as ETMs use the coresight_trace_id_get_cpu_id
> > coresight_trace_id_put_cpu_id pair of functions. The API will record
> > the ID associated with the CPU. This ensures that the same ID will be
> > re-used while perf events are active on the CPU. The put_cpu_id function
> > will pend release of the ID until all perf cs_etm sessions are complete.
> >
> > For backward compatibility the functions will attempt to use the same
> > CPU IDs as the legacy system would have used if these are still available.
> >
> > Non-cpu sources, such as the STM can use coresight_trace_id_get_system_id /
> > coresight_trace_id_put_system_id.
> >
> > Signed-off-by: Mike Leach <mike.leach@linaro.org>
> > ---
> >   drivers/hwtracing/coresight/Makefile          |   2 +-
> >   .../hwtracing/coresight/coresight-trace-id.c  | 265 ++++++++++++++++++
> >   .../hwtracing/coresight/coresight-trace-id.h  | 156 +++++++++++
> >   include/linux/coresight-pmu.h                 |  10 +
> >   4 files changed, 432 insertions(+), 1 deletion(-)
> >   create mode 100644 drivers/hwtracing/coresight/coresight-trace-id.c
> >   create mode 100644 drivers/hwtracing/coresight/coresight-trace-id.h
> >
> > diff --git a/drivers/hwtracing/coresight/Makefile b/drivers/hwtracing/coresight/Makefile
> > index b6c4a48140ec..329a0c704b87 100644
> > --- a/drivers/hwtracing/coresight/Makefile
> > +++ b/drivers/hwtracing/coresight/Makefile
> > @@ -6,7 +6,7 @@ obj-$(CONFIG_CORESIGHT) += coresight.o
> >   coresight-y := coresight-core.o  coresight-etm-perf.o coresight-platform.o \
> >               coresight-sysfs.o coresight-syscfg.o coresight-config.o \
> >               coresight-cfg-preload.o coresight-cfg-afdo.o \
> > -             coresight-syscfg-configfs.o
> > +             coresight-syscfg-configfs.o coresight-trace-id.o
> >   obj-$(CONFIG_CORESIGHT_LINK_AND_SINK_TMC) += coresight-tmc.o
> >   coresight-tmc-y := coresight-tmc-core.o coresight-tmc-etf.o \
> >                     coresight-tmc-etr.o
> > diff --git a/drivers/hwtracing/coresight/coresight-trace-id.c b/drivers/hwtracing/coresight/coresight-trace-id.c
> > new file mode 100644
> > index 000000000000..9b85c376cb12
> > --- /dev/null
> > +++ b/drivers/hwtracing/coresight/coresight-trace-id.c
> > @@ -0,0 +1,265 @@
> > +// SPDX-License-Identifier: GPL-2.0
>
> ...
>
> > +int coresight_trace_id_read_cpu_id(int cpu)
> > +{
> > +     return _coresight_trace_id_read_cpu_id(cpu);
> > +}
> > +EXPORT_SYMBOL_GPL(coresight_trace_id_read_cpu_id);
> > +
> > +int coresight_trace_id_get_system_id(void)
> > +{
> > +     return coresight_trace_id_map_get_system_id(&id_map_default);
> > +}
> > +EXPORT_SYMBOL_GPL(coresight_trace_id_get_system_id);
> > +
> > +void coresight_trace_id_put_system_id(int id)
> > +{
> > +     coresight_trace_id_map_put_system_id(&id_map_default, id);
> > +}
> > +EXPORT_SYMBOL_GPL(coresight_trace_id_put_system_id);
> > +
> > +void coresight_trace_id_perf_start(void)
> > +{
> > +     atomic_inc(&perf_cs_etm_session_active);
> > +}
> > +EXPORT_SYMBOL_GPL(coresight_trace_id_perf_start);
> > +
> > +void coresight_trace_id_perf_stop(void)
> > +{
> > +     if (!atomic_dec_return(&perf_cs_etm_session_active))
> > +             coresight_trace_id_release_all_pending();
> > +}
> > +EXPORT_SYMBOL_GPL(coresight_trace_id_perf_stop);
> > +
>
> This blank new line at the end of the file generates a checkpatch
> warning for me. I have fixed it locally and applied it.
>
OK, thanks.

The only thing I get out of checkpatch.pl for this patch (and indeed
the entire set) is:

WARNING: added, moved or deleted file(s), does MAINTAINERS need updating?

Mike

> > diff --git a/drivers/hwtracing/coresight/coresight-trace-id.h b/drivers/hwtracing/coresight/coresight-trace-id.h
>
>


-- 
Mike Leach
Principal Engineer, ARM Ltd.
Manchester Design Centre. UK
