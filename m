Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CE80C433F5
	for <linux-perf-users@archiver.kernel.org>; Thu,  6 Oct 2022 13:47:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230493AbiJFNre (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 6 Oct 2022 09:47:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230124AbiJFNrd (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 6 Oct 2022 09:47:33 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10EBB754B8
        for <linux-perf-users@vger.kernel.org>; Thu,  6 Oct 2022 06:47:32 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id 70so1784928pjo.4
        for <linux-perf-users@vger.kernel.org>; Thu, 06 Oct 2022 06:47:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=0qrBCsffF+OzBtil4CiWgpjzAyR5Sm/F+e7aMlo+drk=;
        b=bcYNj7otG27a4HRY7t4puzZK/eY+V2ARox3OEhymv6DGtAtqCKglefyozcmY78vev4
         EJO4jIcQxPW3q95dWYR/7/6RcUrgHZyCF+FL6aR1ggPYUnJzqR9DSW2K/eY07l7lBTNu
         fYLlAi504D9YVqaZvqRjP+sQzanWx6h2ns4dSbdIgYz0WbUEyI+sKM+bugHupvVHapDU
         N3+TOsjHxSzMQIKOApA7r+PUjEvuD+M9hmKU0EASqHvGh8IrSXkfNB6pWqCoepFqIkYr
         myGtjdCIopvzGh5nuX4nHsxCCPoEAbSkLWpdh0ri5oHHyuBocorKM6wu5K/Yd+9k68AM
         YNDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=0qrBCsffF+OzBtil4CiWgpjzAyR5Sm/F+e7aMlo+drk=;
        b=QdyssNs8fX/0qAdOvUtkbQ5V773vor1y8pUxsR4X/ck+2bs0HdkcqoVC/AK6753HXl
         EZ53P6IHY6I33NHEFPoFmE3/HrHmVnejDcCOJ6uhcC1XMMiyr9AGlgZuuLdwuUELo6ey
         cFsVmPK2VSjnMIP1OBvTE92nBxEzJXScrAKVdwqzhzirNUFu5aarM6ASQZ0Siok6doWe
         99GUemEfvwVWux6T1K6UAQ3kGshOYhUrJm2oCF2mn3RksON4Hrnsux0s1SuEz8y/MVbn
         2ikZKZ+a0AtnxR9rG2lVY10xXoIeAjizZzwSgkSzUlM8Kgjy9v5pXT7nqHevhA6nFXHd
         E28Q==
X-Gm-Message-State: ACrzQf2FKDLTzU3aU7cUNFSYiRa9eeZZOTP4Q6heEj28gpAGGArmI0UD
        23XLntIZfTR5Ex7M+bEUOKAEjncpopvJvlg6/C7EJQ==
X-Google-Smtp-Source: AMsMyM4HBAe/Xqk1952wcPOElQxiQ4SQ1Lc696OuiOFggPiV/ZXqPqSH0CIuc/QdK2o2sbnwONphEJ+1RzUU6KubM10=
X-Received: by 2002:a17:902:dac4:b0:178:3037:680a with SMTP id
 q4-20020a170902dac400b001783037680amr4938961plx.37.1665064051364; Thu, 06 Oct
 2022 06:47:31 -0700 (PDT)
MIME-Version: 1.0
References: <20220809223401.24599-1-mike.leach@linaro.org> <20220809223401.24599-5-mike.leach@linaro.org>
 <01570ba2-81c9-e4b5-6669-0e4087a4bd1f@arm.com> <8f865045-aa95-46b6-a455-c3d9c6d26494@arm.com>
In-Reply-To: <8f865045-aa95-46b6-a455-c3d9c6d26494@arm.com>
From:   Mike Leach <mike.leach@linaro.org>
Date:   Thu, 6 Oct 2022 14:47:19 +0100
Message-ID: <CAJ9a7VhhmcbyrLZocqXHYXwWbbM_QAAd-zzLQ5_wOEzGAG2UoA@mail.gmail.com>
Subject: Re: [PATCH v3 04/13] coresight: etm4x: Update ETM4 driver to use
 Trace ID API
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

On Mon, 3 Oct 2022 at 10:37, Suzuki K Poulose <suzuki.poulose@arm.com> wrote:
>
> On 03/10/2022 10:31, Suzuki K Poulose wrote:
> > On 09/08/2022 23:33, Mike Leach wrote:
> >> The trace ID API is now used to allocate trace IDs for ETM4.x / ETE
> >> devices.
> >>
> >> For perf sessions, these will be allocated on enable, and released on
> >> disable.
> >>
> >> For sysfs sessions, these will be allocated on enable, but only released
> >> on reset. This allows the sysfs session to interrogate the Trace ID used
> >> after the session is over - maintaining functional consistency with the
> >> previous allocation scheme.
> >>
> >> The trace ID will also be allocated on read of the mgmt/trctraceid file.
> >> This ensures that if perf or sysfs read this before enabling trace, the
> >> value will be the one used for the trace session.
> >>
> >> Trace ID initialisation is removed from the _probe() function.
> >>
> >> Signed-off-by: Mike Leach <mike.leach@linaro.org>
> >> ---
> >>   .../coresight/coresight-etm4x-core.c          | 79 +++++++++++++++++--
> >>   .../coresight/coresight-etm4x-sysfs.c         | 27 ++++++-
> >>   drivers/hwtracing/coresight/coresight-etm4x.h |  3 +
> >>   3 files changed, 100 insertions(+), 9 deletions(-)
> >>
> >> diff --git a/drivers/hwtracing/coresight/coresight-etm4x-core.c
> >> b/drivers/hwtracing/coresight/coresight-etm4x-core.c
> >> index cf249ecad5a5..b4fb28ce89fd 100644
> >> --- a/drivers/hwtracing/coresight/coresight-etm4x-core.c
> >> +++ b/drivers/hwtracing/coresight/coresight-etm4x-core.c
> >> @@ -42,6 +42,7 @@
> >>   #include "coresight-etm4x-cfg.h"
> >>   #include "coresight-self-hosted-trace.h"
> >>   #include "coresight-syscfg.h"
> >> +#include "coresight-trace-id.h"
> >>   static int boot_enable;
> >>   module_param(boot_enable, int, 0444);
> >> @@ -234,6 +235,50 @@ static int etm4_trace_id(struct coresight_device
> >> *csdev)
> >>       return drvdata->trcid;
> >>   }
> >> +int etm4_read_alloc_trace_id(struct etmv4_drvdata *drvdata)
> >> +{
> >> +    int trace_id;
> >> +
> >> +    /*
> >> +     * This will allocate a trace ID to the cpu,
> >> +     * or return the one currently allocated.
> >> +     */
> >> +    /* trace id function has its own lock */
> >> +    trace_id = coresight_trace_id_get_cpu_id(drvdata->cpu);
> >> +    if (IS_VALID_ID(trace_id))
> >> +        drvdata->trcid = (u8)trace_id;
> >> +    else
> >> +        dev_err(&drvdata->csdev->dev,
> >> +            "Failed to allocate trace ID for %s on CPU%d\n",
> >> +            dev_name(&drvdata->csdev->dev), drvdata->cpu);
> >> +    return trace_id;
> >> +}
> >> +
> >> +static int etm4_set_current_trace_id(struct etmv4_drvdata *drvdata)
> >> +{
> >> +    int trace_id;
> >> +
> >> +    /*
> >> +     * Set the currently allocated trace ID - perf allocates IDs
> >> +     * as part of setup_aux for all CPUs it may use.
> >> +     */
> >> +    trace_id = coresight_trace_id_read_cpu_id(drvdata->cpu);
> >> +    if (IS_VALID_ID(trace_id)) {
> >> +        drvdata->trcid = (u8)trace_id;
> >> +        return 0;
> >> +    }
> >> +
> >> +    dev_err(&drvdata->csdev->dev, "Failed to set trace ID for %s on
> >> CPU%d\n",
> >> +        dev_name(&drvdata->csdev->dev), drvdata->cpu);
> >> +
> >> +    return -EINVAL;
> >> +}
> >
> >
> >> +
> >> +void etm4_release_trace_id(struct etmv4_drvdata *drvdata)
> >> +{
> >> +    coresight_trace_id_put_cpu_id(drvdata->cpu);
> >> +}
> >> +
> >>   struct etm4_enable_arg {
> >>       struct etmv4_drvdata *drvdata;
> >>       int rc;
> >> @@ -729,6 +774,15 @@ static int etm4_enable_perf(struct
> >> coresight_device *csdev,
> >>       ret = etm4_parse_event_config(csdev, event);
> >>       if (ret)
> >>           goto out;
> >> +
> >> +    /*
> >> +     * perf allocates cpu ids as part of setup - device needs to use
> >> +     * the allocated ID.
> >> +     */
> >> +    ret = etm4_set_current_trace_id(drvdata);
> >
> > So, when do we allocate an id in perf mode ? As far as I can see, this
> > should be the same as etm4_read_alloc_trace_id() ? Why are they any
> > different ?
> >

Trace IDs are allocated in etm_setup_aux(), then released in free_event_data().
This way the value are guaranteed to remain constant for the entire
session,. We cannot release an ID when a given ETM stops tracing, as
it may restart later for the same perf session.
In between these two events perf takes its own locks - for whatever
reason. If we use read_alloc trace id - which takes that allocation /
release lock in the ID system then we see at lot of
LOCKDEP issues at this point.

Hence we do a safe unlocked read of the value - perf will never
release the value till after the session is completed and the event is
released.

> >> +    if (ret < 0)
> >> +        goto out;
> >> +
> >>       /* And enable it */
> >>       ret = etm4_enable_hw(drvdata);
> >> @@ -753,6 +807,11 @@ static int etm4_enable_sysfs(struct
> >> coresight_device *csdev)
> >>       spin_lock(&drvdata->spinlock);
> >> +    /* sysfs needs to read and allocate a trace ID */
> >> +    ret = etm4_read_alloc_trace_id(drvdata);
> >> +    if (ret < 0)
> >> +        goto unlock_sysfs_enable;
> >> +
> >>       /*
> >>        * Executing etm4_enable_hw on the cpu whose ETM is being enabled
> >>        * ensures that register writes occur when cpu is powered.
> >> @@ -764,6 +823,11 @@ static int etm4_enable_sysfs(struct
> >> coresight_device *csdev)
> >>           ret = arg.rc;
> >>       if (!ret)
> >>           drvdata->sticky_enable = true;
> >> +
> >> +    if (ret)
> >> +        etm4_release_trace_id(drvdata);
> >> +
> >> +unlock_sysfs_enable:
> >>       spin_unlock(&drvdata->spinlock);
> >>       if (!ret)
> >> @@ -895,6 +959,8 @@ static int etm4_disable_perf(struct
> >> coresight_device *csdev,
> >>       /* TRCVICTLR::SSSTATUS, bit[9] */
> >>       filters->ssstatus = (control & BIT(9));
> >> +    /* The perf event will release trace ids when it is destroyed */
> >> +
> >
> > At this patch level, there is no release of trace id ? Is that missed in
> > this patch ? Or am I missing something ?
>

See above  - perf allocation is handled in coresight-etm-perf.c.


> I think the above change only comes in PATCH 7. May be that patch needs
> to be rearranged in order ? Otherwise git-bisect can break running a
> perf session on cs_etm, with missing traceid.
>

This is probably true - we can move the perf allocation to before the
ETM changes as the extended backward compatibility introduced this set
should permit it.


> Suzuki

Thanks for the review

Mike

-- 
Mike Leach
Principal Engineer, ARM Ltd.
Manchester Design Centre. UK
