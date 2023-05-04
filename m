Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8214C77B7C
	for <linux-perf-users@archiver.kernel.org>; Thu,  4 May 2023 18:29:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229718AbjEDS36 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 4 May 2023 14:29:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229700AbjEDS35 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 4 May 2023 14:29:57 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A45A49DC
        for <linux-perf-users@vger.kernel.org>; Thu,  4 May 2023 11:29:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1683224957;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+ahqT2qK2HP6aaU8/Xb1AjQNrt44RhqBn093YYa9pWY=;
        b=egspf4s2QR5Qj4h4UXCtntUg6D7Mfox3w7c/lzuDQp/1YbL50QVIOQ4Iox0/99gtbQfwHP
        aEX5dAhNazS/yJ9C9D0Sdp4HFDjmOj/dC95QyUE3nUu94Tqj/dmEeylIj6zMwjM6FbAigy
        BP0laOELjuoixNfkpgYutyfFOq5ElGY=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-426-6XyDNpBeP72GslfDl-utpg-1; Thu, 04 May 2023 14:29:16 -0400
X-MC-Unique: 6XyDNpBeP72GslfDl-utpg-1
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-64115e69e1eso9869151b3a.0
        for <linux-perf-users@vger.kernel.org>; Thu, 04 May 2023 11:29:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683224955; x=1685816955;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+ahqT2qK2HP6aaU8/Xb1AjQNrt44RhqBn093YYa9pWY=;
        b=l7qkHUEasHvtmxe+kCfbjYs9l59RIBKNt/0znVCf9IMYzCI5GbP7jAwq/q6yLCGryD
         hNT2yZ8x47bRbNu7yixUo/xnJvf0E84fm4smBpMNHfPS2F3L65wb42KLovs7WUUSMvd2
         db0MbCDDwNGhUW9K23al8cA38ZAybRP3bq8heQYJ8Cmxn3+QOUUApWUrWK09vQJrTTZP
         SSyT7hqRaXqv/1jHsXPFLs5S9XduOwr8BP3b068EpFeG6E5ZJjS58ivR4eJ3Vy6H28eC
         hWL3sZpqHDVwnVI2JtzrkXSTqS0NDL8O6A+R8A655vRZoIQhP896TYL1877MnqExo+bR
         0EhA==
X-Gm-Message-State: AC+VfDyOsldchiJyDYcjFeg0DGo9fzlb77eiokhny10fBZ/v/P07RXKc
        y9H4ZlR939Nqxf6VoUXItYiL8HimHH2qGn6j51vKYTyVzUP3cIsz7fIevRCY3iVKRfOQCXXGLjV
        zDAfeMf5/8xzyRgegBzV9svVGCyaXz4D9efXenHfCRIcg3g==
X-Received: by 2002:a17:90a:ec01:b0:24e:1ca6:2206 with SMTP id l1-20020a17090aec0100b0024e1ca62206mr3556591pjy.8.1683224955635;
        Thu, 04 May 2023 11:29:15 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6NTF2DQuSl05rS/B5VSXJyoSPcYtNXgF8BRV0bvbHIWPgn+iaD5CZPxNSNgLD/BC85xX2iOApLFLzBsNSVfHM=
X-Received: by 2002:a17:90a:ec01:b0:24e:1ca6:2206 with SMTP id
 l1-20020a17090aec0100b0024e1ca62206mr3556573pjy.8.1683224955310; Thu, 04 May
 2023 11:29:15 -0700 (PDT)
MIME-Version: 1.0
References: <20230425114307.36889-1-wander@redhat.com> <20230425114307.36889-3-wander@redhat.com>
 <20230504084229.GI1734100@hirez.programming.kicks-ass.net>
 <20230504122945.GA28757@redhat.com> <20230504143303.GA1744142@hirez.programming.kicks-ass.net>
 <CAAq0SUmYrQbS1k9NNKGQP7hQRQJ308dk9NCiUimEiLeBJUavgA@mail.gmail.com> <20230504152306.GA1135@redhat.com>
In-Reply-To: <20230504152306.GA1135@redhat.com>
From:   Wander Lairson Costa <wander@redhat.com>
Date:   Thu, 4 May 2023 15:29:04 -0300
Message-ID: <CAAq0SU=G0WQBLP77Wgm8MJRcVwUCj25WOowh_X8jiGiHTKAQEA@mail.gmail.com>
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

On Thu, May 4, 2023 at 12:23=E2=80=AFPM Oleg Nesterov <oleg@redhat.com> wro=
te:
>
> On 05/04, Wander Lairson Costa wrote:
> >
> > On Thu, May 4, 2023 at 11:34=E2=80=AFAM Peter Zijlstra <peterz@infradea=
d.org> wrote:
> > >
> > > static inline void put_task_struct(struct task_struct *t)
> > > {
> > >         if (!refcount_dec_and_test(&t->usage))
> > >                 return;
> > >
> > >         if (IS_ENABLED(CONFIG_PREEMPT_RT) && !preemptible())
> > >                 call_rcu(&t->rcu, __put_task_struct_rcu);
> > >
> > >         __put_task_struct(t);
> > > }
> > >
> >
> > That's what v5 [1] does.
>
> Yes, but as Sebastian explained CONFIG_PROVE_RAW_LOCK_NESTING won't like =
it.
>
>         https://lore.kernel.org/all/Y+zFNrCjBn53%2F+Q2@linutronix.de/
>

I think that was my confusion in that thread. My understanding is that
CONFIG_PROVE_RAW_LOCK_NESTING will check lock ordering but not
context. I feel my ignorance is blocking me from seeing something that
is obvious to everyone else :/

> Oleg.
>

