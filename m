Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31EF6C28B2B
	for <linux-perf-users@archiver.kernel.org>; Wed, 17 Aug 2022 13:16:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239915AbiHQNQU (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 17 Aug 2022 09:16:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239220AbiHQNP5 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 17 Aug 2022 09:15:57 -0400
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com [IPv6:2607:f8b0:4864:20::1135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFF028C016
        for <linux-perf-users@vger.kernel.org>; Wed, 17 Aug 2022 06:15:31 -0700 (PDT)
Received: by mail-yw1-x1135.google.com with SMTP id 00721157ae682-3321c2a8d4cso176942207b3.5
        for <linux-perf-users@vger.kernel.org>; Wed, 17 Aug 2022 06:15:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=4x9/R2mHqDBSBsINZoYzu53n4+/x9xPXewr5G0XEr34=;
        b=Ta7vQAWfgNwLeo8X+pcdJ6JyCnUcaqj1Ews44KLWjJGhgXZv20jGydY8asVvhmMfNz
         b5Fzq6C/S2NXkgfMPJzpJcfXtNp/XsSJDaSorCNhL1D/nzqkMFU7Du+YXm0LpKulY9IK
         /76nM6mT8xUUP8UaTC1eN5M2TkbrsohpqC0/E8YxXYpbdWBeaceJ/x8g5odhImXtyrc1
         qOyIpz90N1Ejyl+l9w55WOS+8npqTm4TRnzX3bA4a2avvsii63eJWYfy6fWyxSZaHQWM
         Qo0/XLJ6ZGGdQy6n6h+9ZeH4bseaOSQZpSngSXr1oW9GbmtitbnwZya8r8OT9qqDsOW5
         Pddg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=4x9/R2mHqDBSBsINZoYzu53n4+/x9xPXewr5G0XEr34=;
        b=i5x/1hd5FNzTxqkpSQWnOUlY5CBCQGlQQ4snR90VB9dUay298IWy2+PxVIuoMAiKOf
         4VYeBpcc4oX2DE72T0tEAFyftfVxfIdP/pe9THBOmaUbpaeinoaIhHxJ9ND5Ow7SEVNt
         OlI4lly9///gJIDgn9Px9lJmskZDxTCLAaRHya3M+QLPGnoewUhWtWgHW2haUKaLjdg+
         wMx9ckzHL1Ysa/Zz8aoMIyVGmu+5amz/w8Yfv9QRykZlYjeMxguhhJHu+vdsMxJEyqms
         Ypmq9xLnXK7ITHtQjPf8g0jAvBw5RC1yySAiJ7AcKVkoUxJvtYOeNX5pJ0ZhP40SM+us
         PBVg==
X-Gm-Message-State: ACgBeo2rZQFwH0ztqmifQ6kT9THkIZWysUnXRNiGFl6U/aZHp76Ri543
        uNUt6cpwuo0muOWK20kkSTNPGKlILJNhDFI5Ex5Cmg==
X-Google-Smtp-Source: AA6agR4J3cyIT0SWBYaiCeztXduj+LhF+ocuDdNtn7hGLnqyHtxrllFHNLPRhY47QfH++sCFFlwAFNLyvGB5+UaJKNI=
X-Received: by 2002:a5b:c8b:0:b0:688:ebe9:3d05 with SMTP id
 i11-20020a5b0c8b000000b00688ebe93d05mr12303544ybq.553.1660742130329; Wed, 17
 Aug 2022 06:15:30 -0700 (PDT)
MIME-Version: 1.0
References: <20220704150514.48816-1-elver@google.com> <20220704150514.48816-12-elver@google.com>
 <YvznKYgRKjDRSMkT@worktop.programming.kicks-ass.net>
In-Reply-To: <YvznKYgRKjDRSMkT@worktop.programming.kicks-ass.net>
From:   Marco Elver <elver@google.com>
Date:   Wed, 17 Aug 2022 15:14:54 +0200
Message-ID: <CANpmjNN1vv9oDpm1_c99tQKgWVVtXza++u1xcBVeb5mhx5eUHw@mail.gmail.com>
Subject: Re: [PATCH v3 11/14] perf/hw_breakpoint: Reduce contention with large
 number of tasks
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev@lists.ozlabs.org, linux-perf-users@vger.kernel.org,
        x86@kernel.org, linux-sh@vger.kernel.org,
        kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Wed, 17 Aug 2022 at 15:03, Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Mon, Jul 04, 2022 at 05:05:11PM +0200, Marco Elver wrote:
> > +static bool bp_constraints_is_locked(struct perf_event *bp)
> > +{
> > +     struct mutex *tsk_mtx = get_task_bps_mutex(bp);
> > +
> > +     return percpu_is_write_locked(&bp_cpuinfo_sem) ||
> > +            (tsk_mtx ? mutex_is_locked(tsk_mtx) :
> > +                       percpu_is_read_locked(&bp_cpuinfo_sem));
> > +}
>
> > @@ -426,18 +521,28 @@ static int modify_bp_slot(struct perf_event *bp, u64 old_type, u64 new_type)
> >   */
> >  int dbg_reserve_bp_slot(struct perf_event *bp)
> >  {
> > -     if (mutex_is_locked(&nr_bp_mutex))
> > +     int ret;
> > +
> > +     if (bp_constraints_is_locked(bp))
> >               return -1;
> >
> > -     return __reserve_bp_slot(bp, bp->attr.bp_type);
> > +     /* Locks aren't held; disable lockdep assert checking. */
> > +     lockdep_off();
> > +     ret = __reserve_bp_slot(bp, bp->attr.bp_type);
> > +     lockdep_on();
> > +
> > +     return ret;
> >  }
> >
> >  int dbg_release_bp_slot(struct perf_event *bp)
> >  {
> > -     if (mutex_is_locked(&nr_bp_mutex))
> > +     if (bp_constraints_is_locked(bp))
> >               return -1;
> >
> > +     /* Locks aren't held; disable lockdep assert checking. */
> > +     lockdep_off();
> >       __release_bp_slot(bp, bp->attr.bp_type);
> > +     lockdep_on();
> >
> >       return 0;
> >  }
>
> Urggghhhh... this is horrible crap. That is, the current code is that
> and this makes it worse :/

Heh, yes and when I looked at it I really wanted to see if it can
change. But from what I can tell, when the kernel debugger is being
attached, the kernel does stop everything it does and we need the
horrible thing above to not deadlock. And these dbg_ functions are not
normally used, so I decided to leave it as-is. Suggestions?
