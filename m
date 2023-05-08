Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0AF3C77B7F
	for <linux-perf-users@archiver.kernel.org>; Mon,  8 May 2023 12:31:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232881AbjEHMbm (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 8 May 2023 08:31:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234029AbjEHMbl (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 8 May 2023 08:31:41 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDFC339BBE
        for <linux-perf-users@vger.kernel.org>; Mon,  8 May 2023 05:30:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1683549043;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4ahk7pg9sIQ0xJg4E79SX5MEbsNWbDbb49YKqgeiO0s=;
        b=VSBtWlTSjKJ6/FJzTjlamJpWHR18cNvCTtIugdtF7GBbhsVQz4x8MbXJtQmGrLm7rwDeW1
        3loM5khfIpFlL3bLk8UMmSgLhRS4YSeQajwIPSfrA9RXBprrDcUeJAD0zvDjUgUGklfLTI
        ZUfzaeps99DJ0EcjNrMFUNROJ7qjomY=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-594-LFuBPU4aPFCiVjqflHWa3Q-1; Mon, 08 May 2023 08:30:42 -0400
X-MC-Unique: LFuBPU4aPFCiVjqflHWa3Q-1
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-24e2b3c19e0so2282218a91.2
        for <linux-perf-users@vger.kernel.org>; Mon, 08 May 2023 05:30:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683549040; x=1686141040;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4ahk7pg9sIQ0xJg4E79SX5MEbsNWbDbb49YKqgeiO0s=;
        b=jQBx15JiyctxpXAE6DAsuSBISUcOGToQPZRLRmrdFNlVR5MM9qYDpu+EVHz9a0yNPL
         3GL1EC3oAch10nRuxyRJTmiY9nQCUenJztTn5EtJ9bDdLDS0wlxpUNTlqWC+/yralV5b
         79rzALV2bRsEcIMMJc6VqlzVivXdoavJQXXKXRI/kN2b9tIeQTmm4FIaclKhWj+8YTed
         ogIAk6RNRikLQfxgUhFdiuLkdBa5czwx4IczQIPwFZ73rO1XYxU8f91JrkFI8snJO/lY
         jJAu0NeONxSRjOq3OCfr70BzlnJWPIAVfkNBfIqZdH+D5iwVKr/JO6GrdYU42KzIiZgs
         HOvg==
X-Gm-Message-State: AC+VfDz+Gq6YNOY1ibIcNLZkG4in+g7MdndbxBvoiETuBMA9NtT8bIju
        uCATWPcw8hs3IfnSnHIZpEwX95SEps3ofjHpNPcTNbAUmzHq7pFZfnB/Hebsw8jzUjkYil54Kbt
        MJpza9FD5Q/XZBkollS0wZRLcbRcWK/DE2xtld0CrTijUaA==
X-Received: by 2002:a17:90a:6688:b0:24e:69d:3470 with SMTP id m8-20020a17090a668800b0024e069d3470mr10502280pjj.8.1683549040424;
        Mon, 08 May 2023 05:30:40 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5Di0lnN5kaZRDIBsskfBRlXT6qGyYKG5AlhJpf+4qjePW6fIzgMr5duhXeS1+pHa4JeeUf4lDXPuvmKhy2lnE=
X-Received: by 2002:a17:90a:6688:b0:24e:69d:3470 with SMTP id
 m8-20020a17090a668800b0024e069d3470mr10502226pjj.8.1683549040066; Mon, 08 May
 2023 05:30:40 -0700 (PDT)
MIME-Version: 1.0
References: <20230425114307.36889-1-wander@redhat.com> <20230425114307.36889-3-wander@redhat.com>
 <20230504084229.GI1734100@hirez.programming.kicks-ass.net>
 <20230504122945.GA28757@redhat.com> <20230504143303.GA1744142@hirez.programming.kicks-ass.net>
 <CAAq0SUmYrQbS1k9NNKGQP7hQRQJ308dk9NCiUimEiLeBJUavgA@mail.gmail.com>
 <20230504152306.GA1135@redhat.com> <CAAq0SU=G0WQBLP77Wgm8MJRcVwUCj25WOowh_X8jiGiHTKAQEA@mail.gmail.com>
 <20230504192246.GA4164@redhat.com> <CAAq0SUkJ40OeS3cRzhK3voGquJ1AFahYoyQ1fgWS+N=DkOQpig@mail.gmail.com>
 <20230504201614.GB4164@redhat.com>
In-Reply-To: <20230504201614.GB4164@redhat.com>
From:   Wander Lairson Costa <wander@redhat.com>
Date:   Mon, 8 May 2023 09:30:28 -0300
Message-ID: <CAAq0SUk5kSx0vr+OvxG3sm_XArnFm3GZWz0kec8nigZHLo-rZQ@mail.gmail.com>
Subject: Re: [PATCH v7 2/3] sched/task: Add the put_task_struct_atomic_safe() function
To:     Oleg Nesterov <oleg@redhat.com>
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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Thu, May 4, 2023 at 5:16=E2=80=AFPM Oleg Nesterov <oleg@redhat.com> wrot=
e:
>
> Hi Wander,
>
> I certainly missed something ;) plus I am already sleeping. but let me tr=
y to
> reply anyway.
>
> On 05/04, Wander Lairson Costa wrote:
> > On Thu, May 4, 2023 at 4:23=E2=80=AFPM Oleg Nesterov <oleg@redhat.com> =
wrote:
> > >
> > > On 05/04, Wander Lairson Costa wrote:
> > > >
> > > > On Thu, May 4, 2023 at 12:23=E2=80=AFPM Oleg Nesterov <oleg@redhat.=
com> wrote:
> > > > >
> > > > > Yes, but as Sebastian explained CONFIG_PROVE_RAW_LOCK_NESTING won=
't like it.
> > > > >
> > > > >         https://lore.kernel.org/all/Y+zFNrCjBn53%2F+Q2@linutronix=
.de/
> > > > >
> > > >
> > > > I think that was my confusion in that thread. My understanding is t=
hat
> > > > CONFIG_PROVE_RAW_LOCK_NESTING will check lock ordering but not
> > > > context.
> > >
> > > Sorry, I don't understand... perhaps I missed something. But iiuc
> > > the problem is simple.
> > >
> > > So, this code
> > >
> > >         raw_spin_lock(one);
> > >         spin_lock(two);
> > >
> > > is obviously wrong if CONFIG_PREEMPT_RT.
> > >
> > > Without PREEMPT_RT this code is fine because raw_spinlock_t and spinl=
ock_t
> > > are the same thing. Except they have different lockdep annotations if
> > > CONFIG_PROVE_RAW_LOCK_NESTING is true, LD_WAIT_SPIN and LD_WAIT_CONFI=
G.
> > >
> > > So if CONFIG_PROVE_RAW_LOCK_NESTING is set, lockdep will complain eve=
n
> > > on the !PREEMPT_RT kernel, iow it checks the nesting as if the code r=
uns
> > > on with PREEMPT_RT.
> > >
> > > Cough... not sure my explanation can help ;) It looks very confusing =
when
> > > I read it.
> > >
> >
> > Thanks for the explanation. That's my understanding too. The part I
> > don't get is why this would fail with a call_rcu() inside
> > put_task_struct().
>
> the problem is that call_rcu() won't be called if !IS_ENABLED(PREEMPT_RT)=
,
> ___put_task_struct() will be called.
>
> CONFIG_PROVE_RAW_LOCK_NESTING can't know this can't happen if PREEMPT_RT
> is set.
>
> IOW. To simplify, suppose we have
>
>         // can be called in atomic context, e.g. under
>         // raw_spin_lock() so it is wrong with PREEMPT_RT
>         void __put_task_struct(struct task_struct *tsk)
>         {
>                 spin_lock(some_lock);
>         }
>
> lets "fix" the code above, lets change __put_task_struct,
>
>         void __put_task_struct(struct task_struct *tsk)
>         {
>                 if (!IS_ENABLED(CONFIG_PREEMPT_RT))
>                         return;
>
>                 spin_lock(some_lock);
>         }
>
> Now, if CONFIG_PREEMPT_RT is true then __put_task_struct() is fine
> wrt lock nesting.
>
> But, if CONFIG_PREEMPT_RT is not set, then __put_task_struct() still
> does the same:
>
>         void __put_task_struct(struct task_struct *tsk)
>         {
>                 spin_lock(some_lock);
>         }
>
> and CONFIG_PROVE_RAW_LOCK_NESTING will complain. Because, once again,
> it checks the nesting as if CONFIG_PREEMPT_RT is true, and in this case
> __put_task_struct() if it is called under raw_spin_lock().
>

IIUC, this is a problem with the current implementation, isn't it?
Because the holder of raw_spin_lock is the put_task_struct() caller.

> Oleg.
>

