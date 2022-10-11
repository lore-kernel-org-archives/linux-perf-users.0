Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C830C433FE
	for <linux-perf-users@archiver.kernel.org>; Tue, 11 Oct 2022 10:22:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229722AbiJKKWX (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 11 Oct 2022 06:22:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229665AbiJKKWU (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 11 Oct 2022 06:22:20 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 180397C1A1
        for <linux-perf-users@vger.kernel.org>; Tue, 11 Oct 2022 03:22:17 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id b2so12771992plc.7
        for <linux-perf-users@vger.kernel.org>; Tue, 11 Oct 2022 03:22:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=QUMoVWsAtMoav1G38Z0NBtICcSa4s5t0l3sQsGKy1zo=;
        b=sm2o1yqlseQc0qK6Rd57YP82oQAya806xt8R2Jvi60nVxCPCEuDviHLCgMf4UatxJy
         NLlzmwrqHL2OHxnMULqpPiAQ1GKdW/zZ8sMbONpvmYe/ExYAFL6NRaLHucUGNZSpaH0W
         mOSvOPEfSCzt+ZEiiFrN5GWajkxgTwZhAK0ffEYm6ps/UseqzWbW0miFJ2ql7PBhTrya
         hZP8tSXKD8MIjzMu+m+BoUD9BhTfevASxR13+jci+6B8h0DMLN7jt8XExJeDTb1ZKTwv
         G3IhvgpIDIgD+LrXlfbKU44X06huWQJNo/JuR5ex4pg+0kh5WfK1s8UDN5jWDLkJ5/oH
         kwNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QUMoVWsAtMoav1G38Z0NBtICcSa4s5t0l3sQsGKy1zo=;
        b=TyU6dM2nLmC2yFS+TGxMHseBeK8t8LInxsCSTEj6pV/5LIcD5QdwoGImQdwuxWuWJK
         eVt2T5BuXOWQpNty/PmvfDve2V7eUQHqzhHTMgtizzkSMukHw0/47APcfwsoZyUeg4pW
         ZIBsULrQlxNrDidqEwuSeTzETZNuPWju+aDbE0YrHTCH6/Yr6n7pdymBHUHBLc7QMqu/
         VX55chman5t0wCzvPt/WjiL0vzXcSEH4hOHJ24PKInf40cm1D2R17Ay9vEtWGRRr5riX
         7kByl3hhBLr1IBatS+t37ehP98JBqpnmW29pGLtbL3EULzyf13eCtTN0oFf6Vfi0M2a3
         rxbA==
X-Gm-Message-State: ACrzQf2M29epFChwd0jcTFthqKxrpcv510ZHLYDi/OW9DMShD/a0Cgla
        +UXZ/j1woFJ5ckOGvuQeDCp4eAftQ8dXLVDmnInZ7A==
X-Google-Smtp-Source: AMsMyM5SBiGHU9OPu+NDA4WXMhFRBdjOl6fZwXyoghXFl5obIgwyAXj1D4WQyAQdldcd4eksh93sDVG7IQLO4U2AF4A=
X-Received: by 2002:a17:90b:4c52:b0:20d:7917:4cb3 with SMTP id
 np18-20020a17090b4c5200b0020d79174cb3mr448313pjb.6.1665483736491; Tue, 11 Oct
 2022 03:22:16 -0700 (PDT)
MIME-Version: 1.0
References: <20220809223401.24599-1-mike.leach@linaro.org> <20220809223401.24599-2-mike.leach@linaro.org>
 <14411a02-5058-1c03-b98c-9a17975110cd@arm.com>
In-Reply-To: <14411a02-5058-1c03-b98c-9a17975110cd@arm.com>
From:   Mike Leach <mike.leach@linaro.org>
Date:   Tue, 11 Oct 2022 11:22:05 +0100
Message-ID: <CAJ9a7Vh+ywY2V_=HB7WS+KarHL+Ahy8BDF_0xeVqgAVKePHEfQ@mail.gmail.com>
Subject: Re: [PATCH v3 01/13] coresight: trace-id: Add API to dynamically
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

Hi Suzuki

On Mon, 3 Oct 2022 at 09:55, Suzuki K Poulose <suzuki.poulose@arm.com> wrote:
>
> On 09/08/2022 23:33, Mike Leach wrote:
> > The existing mechanism to assign Trace ID values to sources is limited
> > and does not scale for larger multicore / multi trace source systems.
> >
> > The API introduces functions that reserve IDs based on availabilty
> > represented by a coresight_trace_id_map structure. This records the
> > used and free IDs in a bitmap.
> >
> > CPU bound sources such as ETMs use the coresight_trace_id_get_cpu_id /
> > coresight_trace_id_put_cpu_id pair of functions. The API will record
> > the ID associated with the CPU. This ensures that the same ID will be
> > re-used while perf events are active on the CPU. The put_cpu_id function
> > will pend release of the ID until all perf cs_etm sessions are complete.
> >
> > Non-cpu sources, such as the STM can use coresight_trace_id_get_system_id /
> > coresight_trace_id_put_system_id.
> >
> > Signed-off-by: Mike Leach <mike.leach@linaro.org>
> > ---
> >   drivers/hwtracing/coresight/Makefile          |   2 +-
> >   drivers/hwtracing/coresight/coresight-core.c  |   4 +
> >   .../hwtracing/coresight/coresight-trace-id.c  | 230 ++++++++++++++++++
> >   .../hwtracing/coresight/coresight-trace-id.h  |  78 ++++++
> >   include/linux/coresight-pmu.h                 |  23 +-
> >   5 files changed, 324 insertions(+), 13 deletions(-)
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
> > diff --git a/drivers/hwtracing/coresight/coresight-core.c b/drivers/hwtracing/coresight/coresight-core.c
> > index 1edfec1e9d18..c7b7c518a0a3 100644
> > --- a/drivers/hwtracing/coresight/coresight-core.c
> > +++ b/drivers/hwtracing/coresight/coresight-core.c
> > @@ -22,6 +22,7 @@
> >   #include "coresight-etm-perf.h"
> >   #include "coresight-priv.h"
> >   #include "coresight-syscfg.h"
> > +#include "coresight-trace-id.h"
> >
> >   static DEFINE_MUTEX(coresight_mutex);
> >   static DEFINE_PER_CPU(struct coresight_device *, csdev_sink);
> > @@ -1775,6 +1776,9 @@ static int __init coresight_init(void)
> >       if (ret)
> >               goto exit_bus_unregister;
> >
> > +     /* initialise the trace ID allocator */
> > +     coresight_trace_id_init();
> > +
> >       /* initialise the coresight syscfg API */
> >       ret = cscfg_init();
> >       if (!ret)
> > diff --git a/drivers/hwtracing/coresight/coresight-trace-id.c b/drivers/hwtracing/coresight/coresight-trace-id.c
> > new file mode 100644
> > index 000000000000..ac9092896dec
> > --- /dev/null
> > +++ b/drivers/hwtracing/coresight/coresight-trace-id.c
> > @@ -0,0 +1,230 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Copyright (c) 2022, Linaro Limited, All rights reserved.
> > + * Author: Mike Leach <mike.leach@linaro.org>
> > + */
> > +#include <linux/coresight-pmu.h>
> > +#include <linux/kernel.h>
> > +#include <linux/spinlock.h>
> > +#include <linux/types.h>
> > +
> > +#include "coresight-trace-id.h"
> > +
> > +/* need to keep data on ids & association with cpus. */
> > +struct cpu_id_info {
> > +     atomic_t id;
> > +     bool pend_rel;
> > +};
> > +
> > +/* default trace ID map. Used for systems that do not require per sink mappings */
> > +static struct coresight_trace_id_map id_map_default;
> > +
> > +/* maintain a record of the current mapping of cpu IDs */
> > +static DEFINE_PER_CPU(struct cpu_id_info, cpu_ids);
> > +
> > +/* perf session active counter */
> > +static atomic_t perf_cs_etm_session_active = ATOMIC_INIT(0);
> > +
> > +/* lock to protect id_map and cpu data  */
> > +static DEFINE_SPINLOCK(id_map_lock);
> > +
> > +/*
> > + * allocate new ID and set in use
> > + * if @preferred_id is a valid id then try to use that value if available.
> > + */
> > +static int coresight_trace_id_alloc_new_id(struct coresight_trace_id_map *id_map,
> > +                                        int preferred_id)
> > +{
> > +     int id;
> > +
> > +     /* for backwards compatibility reasons, cpu Ids may have a preferred value */
> > +     if (IS_VALID_ID(preferred_id) && !test_bit(preferred_id, id_map->used_ids))
> > +             id = preferred_id;
> > +     else {
> > +             /* skip reserved bit 0, look from bit 1 to CORESIGHT_TRACE_ID_RES_TOP */
> > +             id = find_next_zero_bit(id_map->used_ids, 1, CORESIGHT_TRACE_ID_RES_TOP);
> > +             if (id >= CORESIGHT_TRACE_ID_RES_TOP)
> > +                     return -EINVAL;
> > +     }
> > +
> > +     /* mark as used */
> > +     set_bit(id, id_map->used_ids);
> > +     return id;
> > +}
> > +
> > +static void coresight_trace_id_free(int id, struct coresight_trace_id_map *id_map)
> > +{
> > +     if (WARN(!IS_VALID_ID(id), "%s: Invalid Trace ID %d\n", __func__, id))
> > +             return;
> > +     if (WARN(!test_bit(id, id_map->used_ids),
> > +              "%s: Freeing unused ID %d\n", __func__, id))
> > +             return;
> > +     clear_bit(id, id_map->used_ids);
> > +}
> > +
> > +static void coresight_trace_id_set_pend_rel(int id, struct coresight_trace_id_map *id_map)
> > +{
> > +     if (WARN(!IS_VALID_ID(id), "%s: Invalid Trace ID %d\n", __func__, id))
> > +             return;
> > +     set_bit(id, id_map->pend_rel_ids);
> > +}
> > +
> > +/* release all pending IDs for all current maps & clear CPU associations */
> > +static void coresight_trace_id_release_all_pending(void)
> > +{
> > +     struct coresight_trace_id_map *id_map = &id_map_default;
> > +     unsigned long flags;
> > +     int cpu, bit;
> > +
> > +     spin_lock_irqsave(&id_map_lock, flags);
> > +     for_each_set_bit(bit, id_map->pend_rel_ids, CORESIGHT_TRACE_ID_RES_TOP) {
> > +             clear_bit(bit, id_map->used_ids);
> > +             clear_bit(bit, id_map->pend_rel_ids);
> > +     }
>
>
> > +     for_each_possible_cpu(cpu) {
> > +             if (per_cpu(cpu_ids, cpu).pend_rel) {
> > +                     per_cpu(cpu_ids, cpu).pend_rel = false;
> > +                     atomic_set(&per_cpu(cpu_ids, cpu).id, 0);
> > +             }
> > +     }
>
> Could we use a bitmask for the pending CPUs and use that to track
> the pending CPUs ? Looping over the "possible" CPUs could be quite
> time consuming for large system with spin lock held.
>
> DECLARE_BITMAP(cpuid_release_pending, NR_CPUS);
>

We could do that yes -probably more efficient to scan a bitfield if
sparse traced cpus in play.

>
> > +     spin_unlock_irqrestore(&id_map_lock, flags);
> > +}
> > +
> > +static int coresight_trace_id_map_get_cpu_id(int cpu, struct coresight_trace_id_map *id_map)
> > +{
> > +     unsigned long flags;
> > +     int id;
> > +
> > +     spin_lock_irqsave(&id_map_lock, flags);
> > +
> > +     /* check for existing allocation for this CPU */
> > +     id = atomic_read(&per_cpu(cpu_ids, cpu).id);
> > +     if (id)
> > +             goto get_cpu_id_out;
> > +
> > +     /*
> > +      * Find a new ID.
> > +      *
> > +      * Use legacy values where possible in the dynamic trace ID allocator to
> > +      * allow tools like Android simpleperf to continue working if they are not
>
> I would rather not mention tools name in here. Could we say :
>
>          * keep as much backward compatibility as possible with the
>          * older userspace tools, by requesting the "legacy" traceid
>          * if available.
>

sure

> > +      * upgraded at the same time as the kernel drivers.
> > +      *
> > +      * If the generated legacy ID is invalid, or not available then the next
> > +      * available dynamic ID will be used.
> > +      */
> > +     id = coresight_trace_id_alloc_new_id(id_map, CORESIGHT_LEGACY_CPU_TRACE_ID(cpu));
> > +     if (IS_VALID_ID(id)) {
> > +             /* got a valid new ID - save details */
> > +             atomic_set(&per_cpu(cpu_ids, cpu).id, id);
> > +             per_cpu(cpu_ids, cpu).pend_rel = false;
>
>
> > +             clear_bit(id, id_map->pend_rel_ids);
>
> Couldn't this be moved to coresight_trace_id_alloc_new_id() ? For system
> pool this is ignored anyways and doesn't matter.
>
Actually this should always be cleared as we need to ensure an ID we
re-use is not also marked as pending.
New version will reflect this.

> > +     }
> > +
> > +get_cpu_id_out:
> > +     spin_unlock_irqrestore(&id_map_lock, flags);
> > +
> > +     return id;
> > +}
> > +
> > +static void coresight_trace_id_map_put_cpu_id(int cpu, struct coresight_trace_id_map *id_map)
> > +{
> > +     unsigned long flags;
> > +     int id;
> > +
> > +     /* check for existing allocation for this CPU */
> > +     id = atomic_read(&per_cpu(cpu_ids, cpu).id);
> > +     if (!id)
> > +             goto put_cpu_id_out;
>
> nit: return; ?
>
> > +
> > +     spin_lock_irqsave(&id_map_lock, flags);
> > +
> > +     if (atomic_read(&perf_cs_etm_session_active)) {
>
>
> > +             /* set release at pending if perf still active */
> > +             coresight_trace_id_set_pend_rel(id, id_map);
> > +             per_cpu(cpu_ids, cpu).pend_rel = true;
> > +     } else {
>
> What prevents another refcount on perf_cs_etm_session_active, after
> the above read and before we clear this out ? As far as I can see
> the spinlock doesn't prevent this situation.
>

It does not, and it does not matter.

The spinlock prevents IDs being simultaneously allocated and freed.
If a new perf session increments perf_cs_etm_session_active from 0->1
within this spinlock, then that perf session cannot start allocating
ids for CPUs in the session till the spinlock is released.
If a current perf session decrements perf_cs_etm_session_active from
1->0, within this spinlock, then the action in
coresight_trace_id_perf_stop() to call
coresight_trace_id_release_all_pending() cannot complete until the
spinlock is released.

Thanks and regards

Mike

> > +             /* otherwise clear id */
> > +             coresight_trace_id_free(id, id_map);
> > +             atomic_set(&per_cpu(cpu_ids, cpu).id, 0);
> > +     }
> > +
> > +     spin_unlock_irqrestore(&id_map_lock, flags);
>
> > +put_cpu_id_out:
>
> This can be removed ?
>
> > +}
> > +
>
> Suzuki



-- 
Mike Leach
Principal Engineer, ARM Ltd.
Manchester Design Centre. UK
