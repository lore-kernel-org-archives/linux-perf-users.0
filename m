Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43831C77B60
	for <linux-perf-users@archiver.kernel.org>; Fri, 28 Apr 2023 16:18:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346196AbjD1QSM (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 28 Apr 2023 12:18:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346135AbjD1QSI (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 28 Apr 2023 12:18:08 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA06855AD;
        Fri, 28 Apr 2023 09:18:02 -0700 (PDT)
Date:   Fri, 28 Apr 2023 18:17:58 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1682698680;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mzS+nASlzJJ71hOUETyldjCAo0rPcFGVD/ziZrVHrC0=;
        b=XykYgAUDaIogjvrWDIlXmT35362xw49kmEHMI5mKG+jSKXgXguBBep5kaYcUDsm0GR0cCD
        GCz0K8a0/QNSq1N1BHd7uSaBCR3HfU+0mPLTiKDQbZEf6wfbvgpaNWozOpTQYaVOm2u7CC
        TimNLl+y5/Tl03z4hNzfSfkOJ2O17oJb/5uzCTRpAr1GLmTbDDFsiDSxvoh0cQNWlmI+E4
        C4h9/veUDUhg4RvscuVPhLBM03AeFGC0zmkNjGfhGK27rlkVoCrQ9uICa4HMr1vPm3gaL2
        YxtKtPYEETqJvpZubSYlymZDkJpXjLF4kO694WautuLAMiUOKZeAH8I9sRyn3Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1682698680;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mzS+nASlzJJ71hOUETyldjCAo0rPcFGVD/ziZrVHrC0=;
        b=vhS8VxmDgeTTyWX5t4uB6QfcMnbQuw8lhHiBw/mUtZyn1O9XvduAnqXvubA27PfIF7E/NI
        tgmxMxKul5pxV8BQ==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Wander Lairson Costa <wander@redhat.com>
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
Message-ID: <20230428161758.xN5vwuUq@linutronix.de>
References: <20230425114307.36889-1-wander@redhat.com>
 <20230425114307.36889-2-wander@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230425114307.36889-2-wander@redhat.com>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On 2023-04-25 08:43:01 [-0300], Wander Lairson Costa wrote:
> Under PREEMPT_RT, spinlocks become sleepable locks. put_task_struct()
> indirectly acquires a spinlock. Therefore, it can't be called in
> atomic/interrupt context in RT kernels.
> 
> To prevent such conditions, add a check for atomic/interrupt context
> before calling put_task_struct().
> 
> Signed-off-by: Wander Lairson Costa <wander@redhat.com>
> Suggested-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Been only CCed here.

I asked to not special case PREEMPT_RT but doing this (clean up via RCU)
unconditionally. I don't remember that someone said "this is a bad
because $reason".

Lockdep will complain about this on !RT.

The below open codes rtlock_might_resched() with no explanation on why
it works or where it comes from.

The function is named put_task_struct_atomic_safe() yet it behaves it
differently on PREEMPT_RT otherwise it remains put_task_struct().

Not good.

> ---
>  include/linux/sched/task.h | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/include/linux/sched/task.h b/include/linux/sched/task.h
> index 357e0068497c..b597b97b1f8f 100644
> --- a/include/linux/sched/task.h
> +++ b/include/linux/sched/task.h
> @@ -113,14 +113,28 @@ static inline struct task_struct *get_task_struct(struct task_struct *t)
>  
>  extern void __put_task_struct(struct task_struct *t);
>  
> +#define PUT_TASK_RESCHED_OFFSETS \
> +	(rcu_preempt_depth() << MIGHT_RESCHED_RCU_SHIFT)
> +
> +#define __put_task_might_resched() \
> +	__might_resched(__FILE__, __LINE__, PUT_TASK_RESCHED_OFFSETS)
> +
> +#define put_task_might_resched()			\
> +	do {						\
> +		if (IS_ENABLED(CONFIG_PREEMPT_RT))	\
> +			__put_task_might_resched();	\
> +	} while (0)
> +
>  static inline void put_task_struct(struct task_struct *t)
>  {
> +	put_task_might_resched();
>  	if (refcount_dec_and_test(&t->usage))
>  		__put_task_struct(t);
>  }
>  
>  static inline void put_task_struct_many(struct task_struct *t, int nr)
>  {
> +	put_task_might_resched();
>  	if (refcount_sub_and_test(nr, &t->usage))
>  		__put_task_struct(t);
>  }
> -- 
> 2.40.0
> 

Sebastian
