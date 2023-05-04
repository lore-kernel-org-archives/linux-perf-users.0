Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90008C7EE23
	for <linux-perf-users@archiver.kernel.org>; Thu,  4 May 2023 14:58:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230183AbjEDO63 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 4 May 2023 10:58:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230204AbjEDO62 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 4 May 2023 10:58:28 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F9BB271F
        for <linux-perf-users@vger.kernel.org>; Thu,  4 May 2023 07:56:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1683212131;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6YsQ8xdo0ytXa7ybkhxOH7pGSLqmfAjZ1BIJ079PuAc=;
        b=VOl7fQhU/aY10LFztL64XzRbnj9vEpyK3Gu4u+4dEEss6R9IKprQiArfIAo++Vwf8Bu9/L
        0zplgcB+WXp74u1MM9Vw8gN7S7B1ERqX5aitKaxkCvxhEIrLG0sejGOHf4rhDCGq7dWo3E
        IbtapOrSdIKN2B9QArhkL99stezXqks=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-207-xNdMARWBN0izDKjZ3qnJQg-1; Thu, 04 May 2023 10:55:29 -0400
X-MC-Unique: xNdMARWBN0izDKjZ3qnJQg-1
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-1aaeaa1ad2dso2769615ad.0
        for <linux-perf-users@vger.kernel.org>; Thu, 04 May 2023 07:55:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683212128; x=1685804128;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6YsQ8xdo0ytXa7ybkhxOH7pGSLqmfAjZ1BIJ079PuAc=;
        b=Kh6q8TEJ2ziU+c/UisocgmmS8NwadZeQLRNA+6QiL1lq4vg6mW7saBh4hV+7Jlof82
         /V8PMBvzyVaRr8mG2iXXPi/KJfqIJUsl/hcFcdKrO+jFcSfG7Uvclcs5oUVTX0gAZ7vq
         y8dGSKbplglmJdhCb0KB9u7w/QX3SJ3ttRsPaPAxnwGVCkd3PE6CvxLfbvZVWZhOLlcW
         BtDuswi+CZk6RZJ5p3ZpF4oXWi8ESoxnKRt00RLHSRarKdHYohuykEwrzTFSLUuLARHn
         u8LfAshXCWZXAg8Urmr4tHMmNb81wI9syjyUdEvze8s2RBPHI2iPK7Bm2odUzfjvYYvA
         hjug==
X-Gm-Message-State: AC+VfDwk/ORQBbTgkg+t25kDQEIKN1GXER7hmiq++D4QRo7em6ZqHwS+
        KefevFEwdTjeHyxWzsQfS54vpHYMRk4zHSOyoxUhKc8pUF4Pwa68SdaoxfetVe/JQbVoenSsKnf
        PBIdri4y4gKCuYOsohdFC76+rl1KeDXLb4Lwf0qZSFUa4Hw==
X-Received: by 2002:a17:902:9f87:b0:1a9:7e26:d72 with SMTP id g7-20020a1709029f8700b001a97e260d72mr3982884plq.9.1683212127803;
        Thu, 04 May 2023 07:55:27 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6a+ZmUXqeCZBEWqfB9F07VH3ROswrjPipQTUEnGnxpTdKFHOdNu+aNGSSJQ2n7wz+LO4rj5Dj540V1lyM3Hbg=
X-Received: by 2002:a17:902:9f87:b0:1a9:7e26:d72 with SMTP id
 g7-20020a1709029f8700b001a97e260d72mr3982863plq.9.1683212127419; Thu, 04 May
 2023 07:55:27 -0700 (PDT)
MIME-Version: 1.0
References: <20230425114307.36889-1-wander@redhat.com> <20230425114307.36889-3-wander@redhat.com>
 <20230504084229.GI1734100@hirez.programming.kicks-ass.net>
 <20230504122945.GA28757@redhat.com> <20230504143303.GA1744142@hirez.programming.kicks-ass.net>
In-Reply-To: <20230504143303.GA1744142@hirez.programming.kicks-ass.net>
From:   Wander Lairson Costa <wander@redhat.com>
Date:   Thu, 4 May 2023 11:55:15 -0300
Message-ID: <CAAq0SUmYrQbS1k9NNKGQP7hQRQJ308dk9NCiUimEiLeBJUavgA@mail.gmail.com>
Subject: Re: [PATCH v7 2/3] sched/task: Add the put_task_struct_atomic_safe() function
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Oleg Nesterov <oleg@redhat.com>, Ingo Molnar <mingo@redhat.com>,
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

On Thu, May 4, 2023 at 11:34=E2=80=AFAM Peter Zijlstra <peterz@infradead.or=
g> wrote:
>
> On Thu, May 04, 2023 at 02:29:45PM +0200, Oleg Nesterov wrote:
> > On 05/04, Peter Zijlstra wrote:
> > >
> > > Urgh.. that's plenty horrible. And I'm sure everybody plus kitchen si=
nk
> > > has already asked why can't we just rcu free the thing unconditionall=
y.
> > >
> > > Google only found me an earlier version of this same patch set, but I=
'm
> > > sure we've had that discussion many times over the past several years=
.
> >
> > Yes... see for example
> >
> > https://lore.kernel.org/lkml/CAHk-=3Dwhtj+aSYftniMRG4xvFE8dmmYyrqcJyPmz=
Stsfj5w9r=3Dw@mail.gmail.com/
> >
> > We already have an rcu pass before put_task_struct(zombie), see
> > put_task_struct_rcu_user(), another one look unfortunate.
>
> Ah indeed, it got mentioned there as well. And Linus seems to be arguing
> against doing an rcu free there. So humm..
>
> Then I'm thinking something trivial like so:
>
> static inline void put_task_struct(struct task_struct *t)
> {
>         if (!refcount_dec_and_test(&t->usage))
>                 return;
>
>         if (IS_ENABLED(CONFIG_PREEMPT_RT) && !preemptible())
>                 call_rcu(&t->rcu, __put_task_struct_rcu);
>
>         __put_task_struct(t);
> }
>

That's what v5 [1] does. What would be the path in this case? Should I
resend it as v8?

> should do, or alternatively use irq_work, which has a much lower
> latency, but meh..
>

Initially, I did that. I switched to call_rcu because the code got much sim=
pler.

[1] https://lore.kernel.org/all/20230210161323.37400-1-wander@redhat.com/

