Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93D0EC433EF
	for <linux-perf-users@archiver.kernel.org>; Thu,  9 Jun 2022 13:29:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239478AbiFIN3l (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 9 Jun 2022 09:29:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234782AbiFIN3k (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 9 Jun 2022 09:29:40 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEE92FC80B
        for <linux-perf-users@vger.kernel.org>; Thu,  9 Jun 2022 06:29:38 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id m32-20020a05600c3b2000b0039756bb41f2so12597656wms.3
        for <linux-perf-users@vger.kernel.org>; Thu, 09 Jun 2022 06:29:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=rjMuIRUcb0cPQvXILDOIo+coVEcP/6ZTYygCO+zLwZI=;
        b=llsDjVZg+rOdu3CGzqkX32eaAVwdPsiU1VS8nnyvNRDE8sSblRFHTicWYkcfv1MHXu
         MdioVqNNs5cZ6VFBcG/BTh+RYCpb4wW/GsS0eXUaIy0clqjbpJSnR1ulbw/7zoIenBq5
         GrUbInpSMPpuI1FYSkYzT523tdWtskkHSqijsxWHddPhy9Ua2EDYEGOq/3ZraWyloBKi
         IYBEdx9YQRGK140dTUf06Mckk0WfQToxgONPNEvHd6As8zdXa28IdWZ5JxDGVqVLQktY
         jr1QPxVBWK0Kbx7LIDEtxfJ3aXBUuioiTK9kFPOUNXroue4i/t/PAPRtgUMUE5v9JXNw
         txhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=rjMuIRUcb0cPQvXILDOIo+coVEcP/6ZTYygCO+zLwZI=;
        b=NZWzBSeBVmVc6bm6DDwNzYsFb83MQK8fjVz6z7zLhel3EJ6TyNX/x2kMWCU83Cfkxl
         0RKH2Zy3scfWji61l3ioHQnX11lCXYXtNYSwR9oN7XXOI2r98GKjoS4d+fX/662OJorB
         kdE0Ubis9V7mGNCBW54BP6mB8eZrB9nqzgiR/wRJBkVh7fDCmaiziHYb8JGymBvqdX/b
         wETfZHBuLZu/eWq2w4c2ALpLvPuFKu9LIoBtxm37gU1v6V7APgzkxifxPRTsca1IDXSX
         Hp6DnGel43hl3J2VNl1aOVtyzV0RMkuhuJkRftz6L+ag5qVXHv2Jft+lNWt9SYH04gqI
         jgwA==
X-Gm-Message-State: AOAM532kBqpz4SU8Pf4mavaNODVsge6o9gMdFhO7ayidN2G9aNuCMKTA
        RjasPedZCDdQr65edK3IC48fDQ==
X-Google-Smtp-Source: ABdhPJyZ8W/NkcPXAC3pwT4egxuS2urSSW5AltvpWbSolwLujgLmjNCc1uFC8yzG/FYW9KPUrP/oOA==
X-Received: by 2002:a7b:c057:0:b0:39c:4579:42e1 with SMTP id u23-20020a7bc057000000b0039c457942e1mr3381516wmc.102.1654781377037;
        Thu, 09 Jun 2022 06:29:37 -0700 (PDT)
Received: from elver.google.com ([2a00:79e0:9c:201:dcf:e5ba:10a5:1ea5])
        by smtp.gmail.com with ESMTPSA id bg20-20020a05600c3c9400b0039c15861001sm26391486wmb.21.2022.06.09.06.29.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jun 2022 06:29:36 -0700 (PDT)
Date:   Thu, 9 Jun 2022 15:29:29 +0200
From:   Marco Elver <elver@google.com>
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org, x86@kernel.org,
        linux-sh@vger.kernel.org, kasan-dev@googlegroups.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/8] perf/hw_breakpoint: Reduce contention with large
 number of tasks
Message-ID: <YqH1uUtWHkFr/jDY@elver.google.com>
References: <20220609113046.780504-1-elver@google.com>
 <20220609113046.780504-7-elver@google.com>
 <CACT4Y+aHZ4RTsz_SY=U5NKRWR1M4f0cy1WdepJyBGkbYy7_=TA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACT4Y+aHZ4RTsz_SY=U5NKRWR1M4f0cy1WdepJyBGkbYy7_=TA@mail.gmail.com>
User-Agent: Mutt/2.1.4 (2021-12-11)
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Thu, Jun 09, 2022 at 03:03PM +0200, Dmitry Vyukov wrote:
[...]
> > -/* Serialize accesses to the above constraints */
> > -static DEFINE_MUTEX(nr_bp_mutex);
> > +/*
> > + * Synchronizes accesses to the per-CPU constraints; users of data in bp_cpuinfo
> > + * must acquire bp_cpuinfo_lock as writer to get a stable snapshot of all CPUs'
> > + * constraints. Modifications without use may only acquire bp_cpuinfo_lock as a
> > + * reader, but must otherwise ensure modifications are never lost.
> > + */
> 
> I can't understand this comment.
> Modifications need to acquire in read mode, while only users must
> acquire in write mode. Shouldn't it be the other way around? What is
> "Modifications without use"?

Right, maybe this comment needs tweaking.

The main rules are -- the obvious ones:

	 - plain reads are ok with just a read-lock (target is task,
	   reading 'cpu_pinned');

	 - plain writes need a write-lock (target is CPU, writing
	   'cpu_pinned');

the not so obvious one:

	- "modification without use" are the increment/decrement of
	  tsk_pinned done if the target is a task; in this case, we can
	  happily allow concurrent _atomic_ increments/decrements from
	  different tasks as long as there is no "use" i.e. read the
	  value and check it to make a decision if there is space or not
	  (this is only done by CPU targets).

So the main idea is that the rwlock when held as a reader permits these
"modifications without use" concurrently by task targets, but will block
a CPU target wishing to get a stable snapshot until that acquires the
rwlock as a writer.

The modifications done by task targets are done on atomic variables, so
we never loose any increments/decrements, but while these modifications
are going on, the global view of tsk_pinned may be inconsistent.
However, we know that once a CPU target acquires the rwlock as a writer,
there will be no more "readers" -- or rather any task targets that can
update tsk_pinned concurrently -- and therefore tsk_pinned must be
stable once we acquire the rwlock as a writer.

I'll have to think some more how to best update the comment...

> > +static DEFINE_RWLOCK(bp_cpuinfo_lock);
> > +
> > +/*
> > + * Synchronizes accesses to the per-task breakpoint list in task_bps_ht. Since
> > + * rhltable synchronizes concurrent insertions/deletions, independent tasks may
> > + * insert/delete concurrently; therefore, a mutex per task would be sufficient.
> > + *
> > + * To avoid bloating task_struct with infrequently used data, use a sharded
> > + * mutex that scales with number of CPUs.
> > + */
> > +static DEFINE_PER_CPU(struct mutex, task_sharded_mtx);
> > +
> > +static struct mutex *get_task_sharded_mtx(struct perf_event *bp)
> > +{
> > +       int shard;
> > +
> > +       if (!bp->hw.target)
> > +               return NULL;
> > +
> > +       /*
> > +        * Compute a valid shard index into per-CPU data.
> > +        */
> > +       shard = task_pid_nr(bp->hw.target) % nr_cpu_ids;
> > +       shard = cpumask_next(shard - 1, cpu_possible_mask);
> > +       if (shard >= nr_cpu_ids)
> > +               shard = cpumask_first(cpu_possible_mask);
> > +
> > +       return per_cpu_ptr(&task_sharded_mtx, shard);
> > +}
> > +
> > +static struct mutex *bp_constraints_lock(struct perf_event *bp)
> > +{
> > +       struct mutex *mtx = get_task_sharded_mtx(bp);
> > +
> > +       if (mtx) {
> > +               mutex_lock(mtx);
> > +               read_lock(&bp_cpuinfo_lock);
> 
> Is NR_CPUS == 1 case still important to optimize? I guess with small
> VMs it may be important again.
> If so, we could just write-lock bp_cpuinfo_lock always if NR_CPUS == 1.

Not sure, I guess it's easy to add the check for NR_CPUS==1.

[...]
> > @@ -397,12 +497,11 @@ static void __release_bp_slot(struct perf_event *bp, u64 bp_type)
> >
> >  void release_bp_slot(struct perf_event *bp)
> >  {
> > -       mutex_lock(&nr_bp_mutex);
> > +       struct mutex *mtx = bp_constraints_lock(bp);
> >
> >         arch_unregister_hw_breakpoint(bp);
> 
> If I understand this correctly, this can weaken protection for
> arch_unregister_hw_breakpoint() and __modify_bp_slot(). Previously
> they were globally serialized, but now several calls can run in
> parallel. Is it OK?

__modify_bp_slot() just calls __release_bp_slot() and
__reserve_bp_slot() which is related to constraints accounting, and is
all internal to hw_breakpoint.

Only ppc overrides some of the sea arch_ functions. In arch/powerpc:
arch_unregister_hw_breakpoint() looks like it only accesses
bp->ctx->task, so that looks ok; however, looks like
arch_release_bp_slot() might want its own lock because it mutates a
list, but that lock wants to be in powerpc code.
