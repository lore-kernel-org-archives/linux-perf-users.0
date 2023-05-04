Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B640C77B78
	for <linux-perf-users@archiver.kernel.org>; Thu,  4 May 2023 12:25:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230007AbjEDMZz (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 4 May 2023 08:25:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229606AbjEDMZy (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 4 May 2023 08:25:54 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4616A6196
        for <linux-perf-users@vger.kernel.org>; Thu,  4 May 2023 05:25:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1683203112;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=cg/S6CffV/7p1WGKv2Maqy/rp1ZtmP3xYGneohx7AsI=;
        b=OHBwg9IhFTbI4W6q1QlfGhIp6/YZc/xecm7vOjU1b+27coYwfPrdj74Y3PTq0BBaPdCyXH
        V7u+uhB/d9YY+kh4J2AqIkMrOdOoGPsGbgoR9FNU3h0UdtHtUOt5PRII7uy/zqg95I11Fx
        Sc4c5MfDmwcchziB61dNLHLlVJSBndU=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-357-JdZLXvfJM6CqF1HsOnyd9Q-1; Thu, 04 May 2023 08:25:09 -0400
X-MC-Unique: JdZLXvfJM6CqF1HsOnyd9Q-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B06003C0D856;
        Thu,  4 May 2023 12:25:07 +0000 (UTC)
Received: from fedora (unknown [10.22.9.13])
        by smtp.corp.redhat.com (Postfix) with SMTP id 6B28C2026D16;
        Thu,  4 May 2023 12:25:00 +0000 (UTC)
Date:   Thu, 4 May 2023 09:24:59 -0300
From:   Wander Lairson Costa <wander@redhat.com>
To:     Valentin Schneider <vschneid@redhat.com>
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
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Brian Cain <bcain@quicinc.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Christian Brauner <brauner@kernel.org>,
        Andrei Vagin <avagin@gmail.com>,
        Shakeel Butt <shakeelb@google.com>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:PERFORMANCE EVENTS SUBSYSTEM" 
        <linux-perf-users@vger.kernel.org>, Hu Chunyu <chuhu@redhat.com>,
        Paul McKenney <paulmck@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v7 2/3] sched/task: Add the put_task_struct_atomic_safe()
 function
Message-ID: <kebf55dtj5ryzrainbmxmii6y37dcjjagx3wg6yr5j6jareogm@qosqkndpiwqc>
References: <20230425114307.36889-1-wander@redhat.com>
 <20230425114307.36889-3-wander@redhat.com>
 <20230504084229.GI1734100@hirez.programming.kicks-ass.net>
 <xhsmha5ykjvbk.mognet@vschneid.remote.csb>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xhsmha5ykjvbk.mognet@vschneid.remote.csb>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Thu, May 04, 2023 at 10:32:31AM +0100, Valentin Schneider wrote:
> On 04/05/23 10:42, Peter Zijlstra wrote:
> > On Tue, Apr 25, 2023 at 08:43:02AM -0300, Wander Lairson Costa wrote:
> >> diff --git a/include/linux/sched/task.h b/include/linux/sched/task.h
> >> index b597b97b1f8f..cf774b83b2ec 100644
> >> --- a/include/linux/sched/task.h
> >> +++ b/include/linux/sched/task.h
> >> @@ -141,6 +141,41 @@ static inline void put_task_struct_many(struct task_struct *t, int nr)
> >>
> >>  void put_task_struct_rcu_user(struct task_struct *task);
> >>
> >> +extern void __delayed_put_task_struct(struct rcu_head *rhp);
> >> +
> >> +static inline void put_task_struct_atomic_safe(struct task_struct *task)
> >> +{
> >> +	if (IS_ENABLED(CONFIG_PREEMPT_RT)) {
> >> +		/*
> >> +		 * Decrement the refcount explicitly to avoid unnecessarily
> >> +		 * calling call_rcu.
> >> +		 */
> >> +		if (refcount_dec_and_test(&task->usage))
> >> +			/*
> >> +			 * under PREEMPT_RT, we can't call put_task_struct
> >> +			 * in atomic context because it will indirectly
> >> +			 * acquire sleeping locks.
> >> +			 * call_rcu() will schedule __delayed_put_task_struct()
> >> +			 * to be called in process context.
> >> +			 *
> >> +			 * __put_task_struct() is called when
> >> +			 * refcount_dec_and_test(&t->usage) succeeds.
> >> +			 *
> >> +			 * This means that it can't conflict with
> >> +			 * put_task_struct_rcu_user() which abuses ->rcu the same
> >> +			 * way; rcu_users has a reference so task->usage can't be
> >> +			 * zero after rcu_users 1 -> 0 transition.
> >> +			 *
> >> +			 * delayed_free_task() also uses ->rcu, but it is only called
> >> +			 * when it fails to fork a process. Therefore, there is no
> >> +			 * way it can conflict with put_task_struct().
> >> +			 */
> >> +			call_rcu(&task->rcu, __delayed_put_task_struct);
> >> +	} else {
> >> +		put_task_struct(task);
> >> +	}
> >> +}
> >
> > Urgh.. that's plenty horrible. And I'm sure everybody plus kitchen sink
> > has already asked why can't we just rcu free the thing unconditionally.
> >
> > Google only found me an earlier version of this same patch set, but I'm
> > sure we've had that discussion many times over the past several years.
> > The above and your follow up patch is just horrible.
> >
> 
> So on v3/v4 we got to doing that unconditionally for PREEMPT_RT, but per
> [1] Wander went back to hand-fixing the problematic callsites.
> 
> Now that I'm looking at it again, I couldn't find a concrete argument from
> Oleg against doing this unconditionally - as Wander is pointing out in the
> changelog and comments, reusing task_struct.rcu for that purpose is safe
> (although not necessarily obviously so).
> 
> Is this just miscommunication, or is there a genuine issue with doing this
> unconditionally? As argued before, I'd also much rather have this be an
> unconditional call_rcu() (regardless of context or PREEMPT_RT).
> 

Yeah, I think it was a misunderstanding of mine.

