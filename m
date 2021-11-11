Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4877AC433F5
	for <linux-perf-users@archiver.kernel.org>; Thu, 11 Nov 2021 08:30:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2D73361215
	for <linux-perf-users@archiver.kernel.org>; Thu, 11 Nov 2021 08:30:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232283AbhKKIdD (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 11 Nov 2021 03:33:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231675AbhKKIdA (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 11 Nov 2021 03:33:00 -0500
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC77DC061766
        for <linux-perf-users@vger.kernel.org>; Thu, 11 Nov 2021 00:30:11 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id k4so5164535plx.8
        for <linux-perf-users@vger.kernel.org>; Thu, 11 Nov 2021 00:30:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=5GRE1AC8ySaNxlQTII1kzbZOaFXJN0vLmd4wnvl9WkE=;
        b=byjBiInJMD5yeLnojx9Ahs1+IQkN/NLJjnQd0k7llQZEYdgbMYityInN7eZ079+S1q
         GfcvDwhAv2pKPr1hOwn1n//MOdA0T5H0jElXnZY/ZzcVyt9Gxvx8UUu3+vx+mZzHDX7C
         9zYHJtZuaiFXqeBcfiFE+oNA9ZucwqFmZgE12sMfp8MvW33VLxJdMvQxG/Ru6mW2PoI+
         glrIgSISIG1zGg+LcoH2IsOOuig4dX69zOxS30uwC+A85xzXpCAzEkTkgezRl4JmCcEn
         sJQ7qx2suTPtFyudvaGzTcjGcJ5u43CoLfqiTtp4Oo+bSheVJsPDAQsLxISc2aoFnAfm
         KfVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=5GRE1AC8ySaNxlQTII1kzbZOaFXJN0vLmd4wnvl9WkE=;
        b=xJcT8uMa5s4+hQ2AJnUjHNEGSkgxgpXJl1twm50Bjv2TGxilXZGpkZ4WnzJ6M+EPJl
         /OY7Ek3LYUL4bc8mRdpu7RxqDJPDziqPFsYHOOBPzpLnT9Yzn83eWX6Ex94smt8wD2pG
         To7a6e1R3Q9Ws/qzJrgBdCpR37qmcVs57GysEZQ++ICOs6s5vD5f3Elpq//C6aLy8yoG
         Oy7QudT2XOD+i+b5TUYkXjMJ+tuh1/iKiNvRef7HcbTZkOB0dBHDv1tJ5kl4nRoaknRe
         SKZPVg/oM+p3g4VPqoJxNUFKQtxeb6krXjFnP5NsN6orylls/807zZB+2FkyCEwe2XDW
         fn0Q==
X-Gm-Message-State: AOAM530YPd7fMPqNCad2u909fFQl70ntL1JUnM5dvCSiHM4Oh2/2CYUq
        u5KiRMLXxehlKM/MrvbbNjZcWg==
X-Google-Smtp-Source: ABdhPJx2D+UMoAhMUaW307dh+HtPDmNoWmh3lg9fYfO3S8DtmRKuYvu2XMw9/wZfHmMGZyt5P6KMnw==
X-Received: by 2002:a17:90b:4b04:: with SMTP id lx4mr6454193pjb.11.1636619411324;
        Thu, 11 Nov 2021 00:30:11 -0800 (PST)
Received: from leoy-ThinkPad-X240s ([148.163.172.147])
        by smtp.gmail.com with ESMTPSA id i76sm1579434pgd.69.2021.11.11.00.30.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Nov 2021 00:30:10 -0800 (PST)
Date:   Thu, 11 Nov 2021 16:30:02 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Namhyung Kim <namhyung@kernel.org>
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
Subject: Re: [PATCH v2 4/4] perf arm-spe: Support hardware-based PID tracing
Message-ID: <20211111083002.GA106401@leoy-ThinkPad-X240s>
References: <20211109115020.31623-1-german.gomez@arm.com>
 <20211109115020.31623-5-german.gomez@arm.com>
 <CAM9d7cg7Lp49xOc3BOhM4O9fqs7i+v6cNd=eaKWjDbREiE3Pvg@mail.gmail.com>
 <20211111074148.GC102075@leoy-ThinkPad-X240s>
 <CAM9d7cjW_=hDkHVWchNFDyqZXbbBwMb224hbZTMsCe34MLL-4Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAM9d7cjW_=hDkHVWchNFDyqZXbbBwMb224hbZTMsCe34MLL-4Q@mail.gmail.com>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Hi Namhyung,

On Wed, Nov 10, 2021 at 11:59:05PM -0800, Namhyung Kim wrote:

[...]

> > > > +static void arm_spe_set_pid_tid_cpu(struct arm_spe *spe,
> > > > +                                   struct auxtrace_queue *queue)
> > > > +{
> > > > +       struct arm_spe_queue *speq = queue->priv;
> > > > +       pid_t tid;
> > > > +
> > > > +       tid = machine__get_current_tid(spe->machine, speq->cpu);
> > > > +       if (tid != -1) {
> > > > +               speq->tid = tid;
> > > > +               thread__zput(speq->thread);
> > > > +       } else
> > > > +               speq->tid = queue->tid;
> > > > +
> > > > +       if ((!speq->thread) && (speq->tid != -1)) {
> > > > +               speq->thread = machine__find_thread(spe->machine, -1,
> > > > +                                                   speq->tid);
> > > > +       }
> > > > +
> > > > +       if (speq->thread) {
> > > > +               speq->pid = speq->thread->pid_;
> > > > +               if (queue->cpu == -1)
> > > > +                       speq->cpu = speq->thread->cpu;
> > > > +       }
> > > > +}
> > > > +
> > > > +static int arm_spe_set_tid(struct arm_spe_queue *speq, pid_t tid)
> > > > +{
> > > > +       struct arm_spe *spe = speq->spe;
> > > > +       int err = machine__set_current_tid(spe->machine, speq->cpu, tid, tid);
> > >
> > > I think we should pass -1 as pid as we don't know the real pid.
> >
> > AFAICT, I observe one case for machine__set_current_tid() returning error
> > is 'speq->cpu' is -1 (this is the case for per-thread tracing).  In
> > this case, if pass '-1' for pid/tid, it still will return failure.
> >
> > So here should return the error as it is.  Am I missing anything?
> 
> I'm not saying about the error.  It's about thread status.
> In the machine__set_current_tid(), it calls
> machine__findnew_thread() with given pid and tid.
> 
> I suspect it can set pid to a wrong value if the thread has
> no pid value at the moment.

Here we should avoid to write pid '-1' with
machine__set_current_tid().

The function arm_spe_set_tid() is invoked when SPE trace data contains
context packet and it passes pid coming from the context packet.  On
the other hand, when SPE trace data doesn't contain context packet, we
relies on context switch event to set pid value.  So if we pass pid
'-1' in arm_spe_set_tid(), it will overwrite the pid value which has
been set by context switch event.

Simply say, if SPE trace data contains context packet with valid pid,
perf invokes arm_spe_set_tid() to set the pid value.  Otherwise, it
should skip this operation and roll back to use the pid value from
the context switch event.

Thanks,
Leo
