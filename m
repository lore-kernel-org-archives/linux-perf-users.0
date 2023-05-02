Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 466AFC77B7E
	for <linux-perf-users@archiver.kernel.org>; Tue,  2 May 2023 14:47:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234139AbjEBOrs (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 2 May 2023 10:47:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233548AbjEBOrr (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 2 May 2023 10:47:47 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AAE019A7
        for <linux-perf-users@vger.kernel.org>; Tue,  2 May 2023 07:46:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1683038817;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3/MisJ0r9lk6XuaK9G1g+m+rF0L+ZZkk+9xiBOA2qzI=;
        b=KPAMhyVj0/uHfRH4tY+N6asNbTERGVUAgWpEQjezKTs6TFmXU1IFo5yJPWfm1ByYxJ50so
        tvx+FRxjBPP13hlbWTkP9Diw/Arr15UsNTmSzQiorr3f5JQuD5CxFBdVI5P9kdCZXMu+KP
        kDVda31zunFByxqakv8nKjorvHoU/pE=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-643-vlidix4NM2evF95D2jdyrA-1; Tue, 02 May 2023 10:46:53 -0400
X-MC-Unique: vlidix4NM2evF95D2jdyrA-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4C1773C23946;
        Tue,  2 May 2023 14:46:52 +0000 (UTC)
Received: from fedora (unknown [10.22.18.117])
        by smtp.corp.redhat.com (Postfix) with SMTP id 1C337492B03;
        Tue,  2 May 2023 14:46:43 +0000 (UTC)
Date:   Tue, 2 May 2023 11:46:42 -0300
From:   Wander Lairson Costa <wander@redhat.com>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Oleg Nesterov <oleg@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Christian Brauner <brauner@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Andrei Vagin <avagin@gmail.com>,
        Shakeel Butt <shakeelb@google.com>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:PERFORMANCE EVENTS SUBSYSTEM" 
        <linux-perf-users@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v7 1/3] sched/core: warn on call put_task_struct in
 invalid context
Message-ID: <62q45o4f7s67lnbaunozcmkt4qjlpkh36aan7n2iktqgfl3aw3@ufjjmfxilb2k>
References: <20230425114307.36889-1-wander@redhat.com>
 <20230425114307.36889-2-wander@redhat.com>
 <20230428161758.xN5vwuUq@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230428161758.xN5vwuUq@linutronix.de>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Fri, Apr 28, 2023 at 06:17:58PM +0200, Sebastian Andrzej Siewior wrote:
> On 2023-04-25 08:43:01 [-0300], Wander Lairson Costa wrote:
> > Under PREEMPT_RT, spinlocks become sleepable locks. put_task_struct()
> > indirectly acquires a spinlock. Therefore, it can't be called in
> > atomic/interrupt context in RT kernels.
> > 
> > To prevent such conditions, add a check for atomic/interrupt context
> > before calling put_task_struct().
> > 
> > Signed-off-by: Wander Lairson Costa <wander@redhat.com>
> > Suggested-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> 
> Been only CCed here.
> 

I relied on the get_maintainer script to generate the recipient list for
me. I will explicity add you to the CC list next time.

> I asked to not special case PREEMPT_RT but doing this (clean up via RCU)
> unconditionally. I don't remember that someone said "this is a bad
> because $reason".
> 

Yes, I can do it. Although I would prefer to do it in a follow up patch.
This way, if something goes wrong, it is easier to revert.

> Lockdep will complain about this on !RT.
> 

In my tests, it didn't.

> The below open codes rtlock_might_resched() with no explanation on why
> it works or where it comes from.
> 

I will add some comments on the next patch version.

> The function is named put_task_struct_atomic_safe() yet it behaves it
> differently on PREEMPT_RT otherwise it remains put_task_struct().
> 
> Not good.

That's intentional. We only need to do the cleanup under RT, but for !RT
we don't need it. Anyway, in the end we will endup with an
unconditional call_rcu().

> 
> > ---
> >  include/linux/sched/task.h | 14 ++++++++++++++
> >  1 file changed, 14 insertions(+)
> > 
> > diff --git a/include/linux/sched/task.h b/include/linux/sched/task.h
> > index 357e0068497c..b597b97b1f8f 100644
> > --- a/include/linux/sched/task.h
> > +++ b/include/linux/sched/task.h
> > @@ -113,14 +113,28 @@ static inline struct task_struct *get_task_struct(struct task_struct *t)
> >  
> >  extern void __put_task_struct(struct task_struct *t);
> >  
> > +#define PUT_TASK_RESCHED_OFFSETS \
> > +	(rcu_preempt_depth() << MIGHT_RESCHED_RCU_SHIFT)
> > +
> > +#define __put_task_might_resched() \
> > +	__might_resched(__FILE__, __LINE__, PUT_TASK_RESCHED_OFFSETS)
> > +
> > +#define put_task_might_resched()			\
> > +	do {						\
> > +		if (IS_ENABLED(CONFIG_PREEMPT_RT))	\
> > +			__put_task_might_resched();	\
> > +	} while (0)
> > +
> >  static inline void put_task_struct(struct task_struct *t)
> >  {
> > +	put_task_might_resched();
> >  	if (refcount_dec_and_test(&t->usage))
> >  		__put_task_struct(t);
> >  }
> >  
> >  static inline void put_task_struct_many(struct task_struct *t, int nr)
> >  {
> > +	put_task_might_resched();
> >  	if (refcount_sub_and_test(nr, &t->usage))
> >  		__put_task_struct(t);
> >  }
> > -- 
> > 2.40.0
> > 
> 
> Sebastian
> 

