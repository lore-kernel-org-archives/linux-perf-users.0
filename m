Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F211C77B61
	for <linux-perf-users@archiver.kernel.org>; Mon, 24 Apr 2023 20:35:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232569AbjDXUff (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 24 Apr 2023 16:35:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232565AbjDXUfd (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 24 Apr 2023 16:35:33 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5884855AF
        for <linux-perf-users@vger.kernel.org>; Mon, 24 Apr 2023 13:34:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1682368483;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JN1IGL/TaESrMi+upCkUrmzEl8WBGHXt7c8jLIqZUK4=;
        b=c3URa2zASgz7rI5eQ148w7rq07zcVbWQuzZOP1ozCFihp5lsBs5CTsULIca5Qyv8PFQyRT
        ZuTYbpycUdr7AbJ9K2MPVFcHONqStQCdNmnfLvY3uTIkwxYDmnnmDt7zI62ZXJR8DZl0jJ
        F63v5qKIWzyAOERUl1rHhzirJAi4+sU=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-624-uAo3F41xPv2a9qAenzdSGg-1; Mon, 24 Apr 2023 16:34:41 -0400
X-MC-Unique: uAo3F41xPv2a9qAenzdSGg-1
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-2473661358eso4860184a91.1
        for <linux-perf-users@vger.kernel.org>; Mon, 24 Apr 2023 13:34:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682368481; x=1684960481;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JN1IGL/TaESrMi+upCkUrmzEl8WBGHXt7c8jLIqZUK4=;
        b=P7lCtnVYiQF/AXZaSVQGNkE2vLkuGIgAuGXIt0cjdGwTFJjdMtge6Coyeh83+tyhUh
         seRoot2mwG1npOVq+c/XDNqLnA4KXJwm2QSEpZ6nkCfQWKVpUuIgwP3YFVFQzT/GhKz1
         sKtdcLOvTEbGv9C0E2Pb42RIn3h1QgA0KV+yrHJEeG1ZwvW+DU3jUks5j6kAPcfQx5ku
         uCGHujTJ16kcfkcHiUIY7/bEJ7CFP/IhpyT6qgF3u5zH625r9eoDSJZ4++kOj4ZCwtj0
         /Zm6g9HIe323H4+itxTjKQsbQSBJshaAaVkjYr25X+Y8RET3vNvXkqq94Jz7uN6OO5eG
         V8VQ==
X-Gm-Message-State: AAQBX9fJiSuLzn04xgyTgqHZbEDeh1s3j7gQOhEwbjESFWN2XxJqgiRK
        rt5dZr9Ml7Z4TUU/pTSHe0NkMnrBvLISyDS3in9t+WC+ti7e0LdZ47AcArc8kkxdVtGsoucdhcp
        Afa5bGwJ6uQjbyN74c88qeg/FOl5234+NdR6sdE+cFI3U/g==
X-Received: by 2002:a17:90b:1957:b0:23d:376a:c2bc with SMTP id nk23-20020a17090b195700b0023d376ac2bcmr14048429pjb.5.1682368480745;
        Mon, 24 Apr 2023 13:34:40 -0700 (PDT)
X-Google-Smtp-Source: AKy350Y6F7Wy3ZTaIemiiFddkpMr0+bZ/PTNM6b7RU8b78z+au5DlrI/36+Ow5jv/PW/Zgt6p+FD39n2PLobojWfK3Q=
X-Received: by 2002:a17:90b:1957:b0:23d:376a:c2bc with SMTP id
 nk23-20020a17090b195700b0023d376ac2bcmr14048395pjb.5.1682368480486; Mon, 24
 Apr 2023 13:34:40 -0700 (PDT)
MIME-Version: 1.0
References: <20230414125532.14958-1-wander@redhat.com> <20230414125532.14958-3-wander@redhat.com>
 <9ff7ea3a-b48b-4cff-851e-179713393531@paulmck-laptop> <CAAq0SUk_-yNgKTyY47+n2oKQ3KF1VYgp2zdScF9fJ5jWP5wKpQ@mail.gmail.com>
 <105084b0-9d65-4896-97e4-35ef3c6f1fae@paulmck-laptop>
In-Reply-To: <105084b0-9d65-4896-97e4-35ef3c6f1fae@paulmck-laptop>
From:   Wander Lairson Costa <wander@redhat.com>
Date:   Mon, 24 Apr 2023 17:34:29 -0300
Message-ID: <CAAq0SUkJQtBzhrTiHEHH3LnL8nM7j7ebh_OsRhNUr9mNfrbROA@mail.gmail.com>
Subject: Re: [PATCH v6 2/3] sched/task: Add the put_task_struct_atomic_safe() function
To:     paulmck@kernel.org
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
        Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Mon, Apr 24, 2023 at 3:52=E2=80=AFPM Paul E. McKenney <paulmck@kernel.or=
g> wrote:
>
> On Mon, Apr 24, 2023 at 03:43:09PM -0300, Wander Lairson Costa wrote:
> > On Mon, Apr 24, 2023 at 3:09=E2=80=AFPM Paul E. McKenney <paulmck@kerne=
l.org> wrote:
> > >
> > > On Fri, Apr 14, 2023 at 09:55:28AM -0300, Wander Lairson Costa wrote:
> > > > Due to the possibility of indirectly acquiring sleeping locks, it i=
s
> > > > unsafe to call put_task_struct() in atomic contexts when the kernel=
 is
> > > > compiled with PREEMPT_RT.
> > > >
> > > > To mitigate this issue, this commit introduces
> > > > put_task_struct_atomic_safe(), which schedules __put_task_struct()
> > > > through call_rcu() when PREEMPT_RT is enabled. While a workqueue wo=
uld
> > > > be a more natural approach, we cannot allocate dynamic memory from
> > > > atomic context in PREEMPT_RT, making the code more complex.
> > > >
> > > > This implementation ensures safe execution in atomic contexts and
> > > > avoids any potential issues that may arise from using the non-atomi=
c
> > > > version.
> > > >
> > > > Signed-off-by: Wander Lairson Costa <wander@redhat.com>
> > > > Reported-by: Hu Chunyu <chuhu@redhat.com>
> > > > Cc: Paul McKenney <paulmck@kernel.org>
> > > > Cc: Thomas Gleixner <tglx@linutronix.de>
> > > > ---
> > > >  include/linux/sched/task.h | 31 +++++++++++++++++++++++++++++++
> > > >  kernel/fork.c              |  8 ++++++++
> > > >  2 files changed, 39 insertions(+)
> > > >
> > > > diff --git a/include/linux/sched/task.h b/include/linux/sched/task.=
h
> > > > index b597b97b1f8f..5c13b83d7008 100644
> > > > --- a/include/linux/sched/task.h
> > > > +++ b/include/linux/sched/task.h
> > > > @@ -141,6 +141,37 @@ static inline void put_task_struct_many(struct=
 task_struct *t, int nr)
> > > >
> > > >  void put_task_struct_rcu_user(struct task_struct *task);
> > > >
> > > > +extern void __delayed_put_task_struct(struct rcu_head *rhp);
> > > > +
> > > > +static inline void put_task_struct_atomic_safe(struct task_struct =
*task)
> > > > +{
> > > > +     if (IS_ENABLED(CONFIG_PREEMPT_RT)) {
> > > > +             /*
> > > > +              * Decrement the refcount explicitly to avoid unneces=
sarily
> > > > +              * calling call_rcu.
> > > > +              */
> > > > +             if (refcount_dec_and_test(&task->usage))
> > > > +                     /*
> > > > +                      * under PREEMPT_RT, we can't call put_task_s=
truct
> > > > +                      * in atomic context because it will indirect=
ly
> > > > +                      * acquire sleeping locks.
> > > > +                      * call_rcu() will schedule delayed_put_task_=
struct_rcu()
> > > > +                      * to be called in process context.
> > > > +                      *
> > > > +                      * __put_task_struct() is called called when
> > > > +                      * refcount_dec_and_test(&t->usage) succeeds.
> > > > +                      *
> > > > +                      * This means that it can't "conflict" with
> > > > +                      * put_task_struct_rcu_user() which abuses ->=
rcu the same
> > > > +                      * way; rcu_users has a reference so task->us=
age can't be
> > > > +                      * zero after rcu_users 1 -> 0 transition.
> > > > +                      */
> > > > +                     call_rcu(&task->rcu, __delayed_put_task_struc=
t);
> > >
> > > This will invoke __delayed_put_task_struct() with softirqs disabled.
> > > Or do softirq-disabled contexts count as non-atomic in PREEMPT_RT?
> >
> > softirqs execute in thread context in PREEMPT_RT. We are good here.
>
> So the sleeping lock is a spinlock rather than (say) a mutex?
>

Yes, under PREEMPT_RT, spinlocks are implemented in terms of rtmutex.

>                                                         Thanx, Paul
>
> > > > +     } else {
> > > > +             put_task_struct(task);
> > > > +     }
> > > > +}
> > > > +
> > > >  /* Free all architecture-specific resources held by a thread. */
> > > >  void release_thread(struct task_struct *dead_task);
> > > >
> > > > diff --git a/kernel/fork.c b/kernel/fork.c
> > > > index 0c92f224c68c..9884794fe4b8 100644
> > > > --- a/kernel/fork.c
> > > > +++ b/kernel/fork.c
> > > > @@ -854,6 +854,14 @@ void __put_task_struct(struct task_struct *tsk=
)
> > > >  }
> > > >  EXPORT_SYMBOL_GPL(__put_task_struct);
> > > >
> > > > +void __delayed_put_task_struct(struct rcu_head *rhp)
> > > > +{
> > > > +     struct task_struct *task =3D container_of(rhp, struct task_st=
ruct, rcu);
> > > > +
> > > > +     __put_task_struct(task);
> > > > +}
> > > > +EXPORT_SYMBOL_GPL(__delayed_put_task_struct);
> > > > +
> > > >  void __init __weak arch_task_cache_init(void) { }
> > > >
> > > >  /*
> > > > --
> > > > 2.39.2
> > > >
> > >
> >
>

