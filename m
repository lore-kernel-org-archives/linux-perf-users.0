Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3AC8C6FD18
	for <linux-perf-users@archiver.kernel.org>; Tue, 18 Apr 2023 14:19:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231373AbjDROTl (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 18 Apr 2023 10:19:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231263AbjDROTl (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 18 Apr 2023 10:19:41 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FC9C12CB9
        for <linux-perf-users@vger.kernel.org>; Tue, 18 Apr 2023 07:18:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1681827529;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=RdQFurhc8g977rEvyt6mIZFP787lLkcIJf0Fatg7b/A=;
        b=MYQ6JGZG58lDSQxYkzu3446SjBkzFYCk/26x2IAazMKwbf70wu9TWzPBxsS5T0VgpbOBF8
        TgGm8jDiIio29eFpL2rOcnU4tqf64O5Z7/93HsgRiZsarXiBr9cO8fwHUDKCdmjFZqiIJw
        f3SIWM3BACKXBwfqCzRIjwZzk6/GMpk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-445-kiVNlW5jOPeyDDfSKmLpsw-1; Tue, 18 Apr 2023 10:18:43 -0400
X-MC-Unique: kiVNlW5jOPeyDDfSKmLpsw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 832EC185A7A2;
        Tue, 18 Apr 2023 14:18:35 +0000 (UTC)
Received: from fedora (unknown [10.22.9.76])
        by smtp.corp.redhat.com (Postfix) with SMTP id 277D7C159F2;
        Tue, 18 Apr 2023 14:18:27 +0000 (UTC)
Date:   Tue, 18 Apr 2023 11:18:26 -0300
From:   Wander Lairson Costa <wander@redhat.com>
To:     Waiman Long <longman@redhat.com>
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
        Boqun Feng <boqun.feng@gmail.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Kees Cook <keescook@chromium.org>,
        Christian Brauner <brauner@kernel.org>,
        Andrei Vagin <avagin@gmail.com>,
        Shakeel Butt <shakeelb@google.com>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:PERFORMANCE EVENTS SUBSYSTEM" 
        <linux-perf-users@vger.kernel.org>, Hu Chunyu <chuhu@redhat.com>,
        Paul McKenney <paulmck@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v6 2/3] sched/task: Add the put_task_struct_atomic_safe()
 function
Message-ID: <kx2lctgc4be4zeb7rzdbqpindufmqdjwnh63j75s4hsxspw4si@vva4gdgc5hq7>
References: <20230414125532.14958-1-wander@redhat.com>
 <20230414125532.14958-3-wander@redhat.com>
 <e197ad4d-a60b-f773-dd74-ba91ad66a617@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e197ad4d-a60b-f773-dd74-ba91ad66a617@redhat.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Mon, Apr 17, 2023 at 02:51:45PM -0400, Waiman Long wrote:
> 
> On 4/14/23 08:55, Wander Lairson Costa wrote:
> > Due to the possibility of indirectly acquiring sleeping locks, it is
> > unsafe to call put_task_struct() in atomic contexts when the kernel is
> > compiled with PREEMPT_RT.
> > 
> > To mitigate this issue, this commit introduces
> > put_task_struct_atomic_safe(), which schedules __put_task_struct()
> > through call_rcu() when PREEMPT_RT is enabled. While a workqueue would
> > be a more natural approach, we cannot allocate dynamic memory from
> > atomic context in PREEMPT_RT, making the code more complex.
> > 
> > This implementation ensures safe execution in atomic contexts and
> > avoids any potential issues that may arise from using the non-atomic
> > version.
> > 
> > Signed-off-by: Wander Lairson Costa <wander@redhat.com>
> > Reported-by: Hu Chunyu <chuhu@redhat.com>
> > Cc: Paul McKenney <paulmck@kernel.org>
> > Cc: Thomas Gleixner <tglx@linutronix.de>
> > ---
> >   include/linux/sched/task.h | 31 +++++++++++++++++++++++++++++++
> >   kernel/fork.c              |  8 ++++++++
> >   2 files changed, 39 insertions(+)
> > 
> > diff --git a/include/linux/sched/task.h b/include/linux/sched/task.h
> > index b597b97b1f8f..5c13b83d7008 100644
> > --- a/include/linux/sched/task.h
> > +++ b/include/linux/sched/task.h
> > @@ -141,6 +141,37 @@ static inline void put_task_struct_many(struct task_struct *t, int nr)
> >   void put_task_struct_rcu_user(struct task_struct *task);
> > +extern void __delayed_put_task_struct(struct rcu_head *rhp);
> > +
> > +static inline void put_task_struct_atomic_safe(struct task_struct *task)
> > +{
> > +	if (IS_ENABLED(CONFIG_PREEMPT_RT)) {
> > +		/*
> > +		 * Decrement the refcount explicitly to avoid unnecessarily
> > +		 * calling call_rcu.
> > +		 */
> > +		if (refcount_dec_and_test(&task->usage))
> > +			/*
> > +			 * under PREEMPT_RT, we can't call put_task_struct
> > +			 * in atomic context because it will indirectly
> > +			 * acquire sleeping locks.
> > +			 * call_rcu() will schedule delayed_put_task_struct_rcu()
> delayed_put_task_struct_rcu()?
> > +			 * to be called in process context.
> > +			 *
> > +			 * __put_task_struct() is called called when
> "called called"?
> > +			 * refcount_dec_and_test(&t->usage) succeeds.
> > +			 *
> > +			 * This means that it can't "conflict" with
> > +			 * put_task_struct_rcu_user() which abuses ->rcu the same
> > +			 * way; rcu_users has a reference so task->usage can't be
> > +			 * zero after rcu_users 1 -> 0 transition.
> 
> Note that put_task_struct_rcu_user() isn't the only user of task->rcu.
> delayed_free_task() in kernel/fork.c also uses it, though it is only called
> in the error case. Still you may need to take a look to make sure that there
> is no conflict.
> 

delayed_free_task() is called when a process fails to start. Therefore, AFAICT,
there is no way it can conflict with put_task_struct().

> Cheers,
> Longman
> 

