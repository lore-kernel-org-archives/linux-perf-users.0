Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51787C77B7F
	for <linux-perf-users@archiver.kernel.org>; Mon,  8 May 2023 12:30:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233456AbjEHM36 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 8 May 2023 08:29:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234671AbjEHM3v (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 8 May 2023 08:29:51 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 151D03C481
        for <linux-perf-users@vger.kernel.org>; Mon,  8 May 2023 05:28:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1683548910;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lgrzGxAxmI/spviOHV2b8UBBldlWDCIioMic8trwoYg=;
        b=Bw8+57xoqvf0lgYZQLr/DQ2Rw3DUDO2q0+A546LDsHoAd7rEhypYHaFyi1C+NyEeSVpWEv
        2Bz7SlHWc//je2PC33bnEckBWpGI8pZBLRkqIWzOrub6mNyxY5OCPBLiORoEGrCCjgd/NI
        jy5eMPC6uU+i+kbcGNSrbRfylbMF2R0=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-651-ePxTKBiHPa6Jvb76wfoBkg-1; Mon, 08 May 2023 08:28:29 -0400
X-MC-Unique: ePxTKBiHPa6Jvb76wfoBkg-1
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-643fdfb437aso8936218b3a.0
        for <linux-perf-users@vger.kernel.org>; Mon, 08 May 2023 05:28:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683548908; x=1686140908;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lgrzGxAxmI/spviOHV2b8UBBldlWDCIioMic8trwoYg=;
        b=SvOTEybemq0pSgLo1gFAAg6brL9NMBziCla9IrxmQDYKpVuZogezTyBI2rthMrDAix
         HOJARIrIZwgB1LI/b9zUqFxI0N/ounA3xJBMYGLXtwta/jihtQS+NjtWfCVsjgrL7EeM
         QIJUF436R8T9ppkA/fRYSwAZVPuGmy6Px+AFsPyVoOCH7N2YBVxF8oT4MS2yIn+jIvF9
         ejtmrHJkudhzIvGKhfICOgVmH2iSP0KC3TBx4ZIwSMRXOMg6pXcyoZLBVIeImvJcetnZ
         SRSFcAAmgQ/qH8fqeXEH0rZKGyDKcazieYmFpRYLhg5EIfCWwqqMt0cpk9U44BKCGj/j
         SFvA==
X-Gm-Message-State: AC+VfDxp33Kwtw6qNWeXFh+ddkOVyV2VC/81UNT9ByUM/Sc6Wu0zKC6h
        rz/E8iXXWLEGxFui+ND7+5CMz/x7073A/SNsG0jgVS/u9ujI+eWwj3P5gISyDMJWlElo8gx2MHq
        aS7iEW3gFla43AST1ZQSHAf/3i+JmZxd6/0RcqbJNLePf4Q==
X-Received: by 2002:a17:902:c943:b0:1a9:2a9e:30a8 with SMTP id i3-20020a170902c94300b001a92a9e30a8mr19852485pla.9.1683548908011;
        Mon, 08 May 2023 05:28:28 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5wJMx1jBWrcarhM+oA6VC9s/ptiRs+n09mKMApsO+ZT6dRWxKFOpP7kv6qviLo30TspCsRD9iNCrTW20+sv0M=
X-Received: by 2002:a17:902:c943:b0:1a9:2a9e:30a8 with SMTP id
 i3-20020a170902c94300b001a92a9e30a8mr19852446pla.9.1683548907634; Mon, 08 May
 2023 05:28:27 -0700 (PDT)
MIME-Version: 1.0
References: <20230425114307.36889-1-wander@redhat.com> <20230425114307.36889-3-wander@redhat.com>
 <20230504084229.GI1734100@hirez.programming.kicks-ass.net>
 <20230504122945.GA28757@redhat.com> <20230504143303.GA1744142@hirez.programming.kicks-ass.net>
 <CAAq0SUmYrQbS1k9NNKGQP7hQRQJ308dk9NCiUimEiLeBJUavgA@mail.gmail.com>
 <20230504152424.GG1744258@hirez.programming.kicks-ass.net>
 <cjhvb72qrqggom5gxdjz6mtz3bntlmznx7r52adz72z2t2edzr@hwcog2pltfaq> <20230505133235.GG4253@hirez.programming.kicks-ass.net>
In-Reply-To: <20230505133235.GG4253@hirez.programming.kicks-ass.net>
From:   Wander Lairson Costa <wander@redhat.com>
Date:   Mon, 8 May 2023 09:28:16 -0300
Message-ID: <CAAq0SUmf_q5UFMKrBb+JtqUF3cFchSZhiiRM4YbVmYO_dyDRGg@mail.gmail.com>
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

On Fri, May 5, 2023 at 10:33=E2=80=AFAM Peter Zijlstra <peterz@infradead.or=
g> wrote:
>
> On Thu, May 04, 2023 at 03:21:11PM -0300, Wander Lairson Costa wrote:
> > On Thu, May 04, 2023 at 05:24:24PM +0200, Peter Zijlstra wrote:
> > > On Thu, May 04, 2023 at 11:55:15AM -0300, Wander Lairson Costa wrote:
> > >
> > > > > Then I'm thinking something trivial like so:
> > > > >
> > > > > static inline void put_task_struct(struct task_struct *t)
> > > > > {
> > > > >         if (!refcount_dec_and_test(&t->usage))
> > > > >                 return;
> > > > >
> > > > >         if (IS_ENABLED(CONFIG_PREEMPT_RT) && !preemptible())
> > > > >                 call_rcu(&t->rcu, __put_task_struct_rcu);
> > > > >
> > > > >         __put_task_struct(t);
> > > > > }
> > > > >
> > > >
> > > > That's what v5 [1] does. What would be the path in this case? Shoul=
d I
> > > > resend it as v8?
> > >
> > > It's almost what v5 does. v5 also has a !in_task() thing. v5 also
> > > violates codingstyle :-)
> >
> > IIRC, the in_task() is there because preemptible() doesn't check if it
> > is running in interrupt context.
>
> #define preemptible()   (preempt_count() =3D=3D 0 && !irqs_disabled())
>
> When in interrupt context preempt_count() will have a non-zero value in
> HARDIRQ_MASK and IRQs must be disabled, so preemptible() evaluates to
> (false && false), last time I checked that ends up being false.
>

When I first tested, I started with in_irq(), then I saw some warnings
and added preemptible().
Never tested with preemptible() alone. Thanks, I will change that and test =
it.

