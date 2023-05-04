Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 700E6C7EE21
	for <linux-perf-users@archiver.kernel.org>; Thu,  4 May 2023 19:39:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229706AbjEDTjS (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 4 May 2023 15:39:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbjEDTjR (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 4 May 2023 15:39:17 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DB5061AF
        for <linux-perf-users@vger.kernel.org>; Thu,  4 May 2023 12:38:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1683229110;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xVAk0B1QqY/UI3sXcpLYnSi0ySDnKl0NNcM0I1JlNjk=;
        b=cU94WEN3Zhd9srOppON/pB92MY2OcMBeTpk09f6Sm+S+ARcuQLfCtGMpGRzPebWTgoz/7h
        R7V03fsGbaJREgAFJVVXLvCGMaxBl4E8qssRKRa7hSSB5vvCCoxHtchOIEiC80aDi68oMz
        m7C12u2m+1EG9nqyKPXaVtBFpeNhXNM=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-67-Vp4iWJyFP3CrRk387qw07g-1; Thu, 04 May 2023 15:38:29 -0400
X-MC-Unique: Vp4iWJyFP3CrRk387qw07g-1
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-64115ef7234so10086188b3a.1
        for <linux-perf-users@vger.kernel.org>; Thu, 04 May 2023 12:38:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683229108; x=1685821108;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xVAk0B1QqY/UI3sXcpLYnSi0ySDnKl0NNcM0I1JlNjk=;
        b=JrmIPF91Gs6JEHa2qhnU2F6idTuc5CVnLsaaxbVgbcgIq/KHvSKoPRSbdlQQC7quun
         Zl5F5kvEVk7b1wuqBUhVGdPjZ7oy0b2c4EgWm7fEmhy7oXZytWMDrE93QmOwUkOU1RBA
         /VN2472IEJbT0oLNg/TWOojVDO1FgyqfnrTGDj+WJ6CwhUyGJz9FqCbhno8C+jVjS5r5
         qM9zynVXKB8PM5iaRFlah442UXlLoM/AV2qNBMt3Wfl4M4dAQIMwGwqNQq4Mfp60PkgL
         aJdTaA2PcaplVaLDZfpkoxHTx9OtGDPnRo6oQoMROi/+8aeKa+vXvXsTFjuLSWszh99t
         Ka2w==
X-Gm-Message-State: AC+VfDwF0ygJm1F0bnMgzSf7rT66ysdbA4GQkLaRCSkMKwyh/bfFwpvy
        3t/z9631WcFvHqwZoEIBuvNGi3i4VwtSyh96NkGvv0QEMMt3fyUc+AqAcySBXAdnJez+iaN3xOM
        kwxvDxo03os75xaxyJ0bmqs7aZqMo2TPeoS9g186q+bGLQQ==
X-Received: by 2002:a17:90b:38c2:b0:24d:f67d:7177 with SMTP id nn2-20020a17090b38c200b0024df67d7177mr3649813pjb.20.1683229108049;
        Thu, 04 May 2023 12:38:28 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6QFf9sqCL3Da0AB8FzBJJgX/71RAWq6l/veLikhvZrfzwgKF5/Scrc2BUNg8lpLteQf6+AOIz1M2OtAxDaAfw=
X-Received: by 2002:a17:90b:38c2:b0:24d:f67d:7177 with SMTP id
 nn2-20020a17090b38c200b0024df67d7177mr3649760pjb.20.1683229107692; Thu, 04
 May 2023 12:38:27 -0700 (PDT)
MIME-Version: 1.0
References: <20230425114307.36889-1-wander@redhat.com> <20230425114307.36889-3-wander@redhat.com>
 <20230504084229.GI1734100@hirez.programming.kicks-ass.net>
 <20230504122945.GA28757@redhat.com> <20230504143303.GA1744142@hirez.programming.kicks-ass.net>
 <CAAq0SUmYrQbS1k9NNKGQP7hQRQJ308dk9NCiUimEiLeBJUavgA@mail.gmail.com>
 <20230504152306.GA1135@redhat.com> <CAAq0SU=G0WQBLP77Wgm8MJRcVwUCj25WOowh_X8jiGiHTKAQEA@mail.gmail.com>
 <20230504192246.GA4164@redhat.com>
In-Reply-To: <20230504192246.GA4164@redhat.com>
From:   Wander Lairson Costa <wander@redhat.com>
Date:   Thu, 4 May 2023 16:38:16 -0300
Message-ID: <CAAq0SUkJ40OeS3cRzhK3voGquJ1AFahYoyQ1fgWS+N=DkOQpig@mail.gmail.com>
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

On Thu, May 4, 2023 at 4:23=E2=80=AFPM Oleg Nesterov <oleg@redhat.com> wrot=
e:
>
> On 05/04, Wander Lairson Costa wrote:
> >
> > On Thu, May 4, 2023 at 12:23=E2=80=AFPM Oleg Nesterov <oleg@redhat.com>=
 wrote:
> > >
> > > Yes, but as Sebastian explained CONFIG_PROVE_RAW_LOCK_NESTING won't l=
ike it.
> > >
> > >         https://lore.kernel.org/all/Y+zFNrCjBn53%2F+Q2@linutronix.de/
> > >
> >
> > I think that was my confusion in that thread. My understanding is that
> > CONFIG_PROVE_RAW_LOCK_NESTING will check lock ordering but not
> > context.
>
> Sorry, I don't understand... perhaps I missed something. But iiuc
> the problem is simple.
>
> So, this code
>
>         raw_spin_lock(one);
>         spin_lock(two);
>
> is obviously wrong if CONFIG_PREEMPT_RT.
>
> Without PREEMPT_RT this code is fine because raw_spinlock_t and spinlock_=
t
> are the same thing. Except they have different lockdep annotations if
> CONFIG_PROVE_RAW_LOCK_NESTING is true, LD_WAIT_SPIN and LD_WAIT_CONFIG.
>
> So if CONFIG_PROVE_RAW_LOCK_NESTING is set, lockdep will complain even
> on the !PREEMPT_RT kernel, iow it checks the nesting as if the code runs
> on with PREEMPT_RT.
>
> Cough... not sure my explanation can help ;) It looks very confusing when
> I read it.
>

Thanks for the explanation. That's my understanding too. The part I
don't get is why this would fail with a call_rcu() inside
put_task_struct().

> Oleg.
>

