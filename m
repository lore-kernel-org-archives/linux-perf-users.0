Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3F19C433EF
	for <linux-perf-users@archiver.kernel.org>; Thu, 11 Nov 2021 07:59:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CD07261354
	for <linux-perf-users@archiver.kernel.org>; Thu, 11 Nov 2021 07:59:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231667AbhKKICH (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 11 Nov 2021 03:02:07 -0500
Received: from mail-lj1-f181.google.com ([209.85.208.181]:36752 "EHLO
        mail-lj1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbhKKICH (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 11 Nov 2021 03:02:07 -0500
Received: by mail-lj1-f181.google.com with SMTP id i63so10342858lji.3;
        Wed, 10 Nov 2021 23:59:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=H108gW+yRd1GrkbrthXO1LTMnXJJAVrBlEIMC3WNV5g=;
        b=kdVtA1NvGD9Q55sQ3fE0tZ6CCga+AHuNRGGa/AJAl6c9FQvJsiSF8YgZ1jnZl30sK1
         lRcNHA2KO1gOzi0WiwjUt20z7nG9YSuH33Q4X6vkYdVVJIgjUx3+IcuzJAdVryuC/K2i
         a0rEo0Bbb+vjuz+Y4jbrp9ZWjRYufKFY6Ycx5ua/Cu38IeWoRoBYomWSu0n6D8Rag0qK
         l/ZQaZtbEN3WPksbog7JOqRz45OvPaueJEi+r78QrbhTjZ4MYRaVkCXeVAd5D4I+gUQi
         1zCZjO7dAz+ug4VmmGrYLhvu3shIfh/sL7NP8LvHGVz0RXY+zjZhUjQMgOO7GTGrqv+g
         ZCmA==
X-Gm-Message-State: AOAM531bVZgtTklsosRBXSl5y+cD75NhNOwE+WpYqxUDjaWtCloiWCt3
        c7NQo8JnrniM4PXxTXv6McnCTkjx0eYNo058jTE=
X-Google-Smtp-Source: ABdhPJxjnX7OG9xCZeLFl4gyUSh5Zc1sF5G75nmcc03ldL+JgcY8Z78jv6JyCNVe0nnNBtrrbDDavdcHiSxa+QeDHck=
X-Received: by 2002:a05:651c:545:: with SMTP id q5mr5113565ljp.202.1636617557049;
 Wed, 10 Nov 2021 23:59:17 -0800 (PST)
MIME-Version: 1.0
References: <20211109115020.31623-1-german.gomez@arm.com> <20211109115020.31623-5-german.gomez@arm.com>
 <CAM9d7cg7Lp49xOc3BOhM4O9fqs7i+v6cNd=eaKWjDbREiE3Pvg@mail.gmail.com> <20211111074148.GC102075@leoy-ThinkPad-X240s>
In-Reply-To: <20211111074148.GC102075@leoy-ThinkPad-X240s>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Wed, 10 Nov 2021 23:59:05 -0800
Message-ID: <CAM9d7cjW_=hDkHVWchNFDyqZXbbBwMb224hbZTMsCe34MLL-4Q@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] perf arm-spe: Support hardware-based PID tracing
To:     Leo Yan <leo.yan@linaro.org>
Cc:     German Gomez <german.gomez@arm.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-perf-users <linux-perf-users@vger.kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Hi Leo,

On Wed, Nov 10, 2021 at 11:41 PM Leo Yan <leo.yan@linaro.org> wrote:
>
> On Wed, Nov 10, 2021 at 11:28:48PM -0800, Namhyung Kim wrote:
>
> [...]
>
> > > +static void arm_spe_set_pid_tid_cpu(struct arm_spe *spe,
> > > +                                   struct auxtrace_queue *queue)
> > > +{
> > > +       struct arm_spe_queue *speq = queue->priv;
> > > +       pid_t tid;
> > > +
> > > +       tid = machine__get_current_tid(spe->machine, speq->cpu);
> > > +       if (tid != -1) {
> > > +               speq->tid = tid;
> > > +               thread__zput(speq->thread);
> > > +       } else
> > > +               speq->tid = queue->tid;
> > > +
> > > +       if ((!speq->thread) && (speq->tid != -1)) {
> > > +               speq->thread = machine__find_thread(spe->machine, -1,
> > > +                                                   speq->tid);
> > > +       }
> > > +
> > > +       if (speq->thread) {
> > > +               speq->pid = speq->thread->pid_;
> > > +               if (queue->cpu == -1)
> > > +                       speq->cpu = speq->thread->cpu;
> > > +       }
> > > +}
> > > +
> > > +static int arm_spe_set_tid(struct arm_spe_queue *speq, pid_t tid)
> > > +{
> > > +       struct arm_spe *spe = speq->spe;
> > > +       int err = machine__set_current_tid(spe->machine, speq->cpu, tid, tid);
> >
> > I think we should pass -1 as pid as we don't know the real pid.
>
> AFAICT, I observe one case for machine__set_current_tid() returning error
> is 'speq->cpu' is -1 (this is the case for per-thread tracing).  In
> this case, if pass '-1' for pid/tid, it still will return failure.
>
> So here should return the error as it is.  Am I missing anything?

I'm not saying about the error.  It's about thread status.
In the machine__set_current_tid(), it calls
machine__findnew_thread() with given pid and tid.

I suspect it can set pid to a wrong value if the thread has
no pid value at the moment.

Thanks,
Namhyung
