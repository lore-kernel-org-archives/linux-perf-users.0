Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60287C433F5
	for <linux-perf-users@archiver.kernel.org>; Tue, 19 Oct 2021 23:17:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3EC6D610D0
	for <linux-perf-users@archiver.kernel.org>; Tue, 19 Oct 2021 23:17:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229702AbhJSXUG (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 19 Oct 2021 19:20:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbhJSXUG (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 19 Oct 2021 19:20:06 -0400
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08E02C06161C;
        Tue, 19 Oct 2021 16:17:53 -0700 (PDT)
Received: by mail-io1-xd2b.google.com with SMTP id z69so19226700iof.9;
        Tue, 19 Oct 2021 16:17:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ujcgvnZnOlRivFcgptVkKE7tCIGAc0bhX8mb5ERfb2o=;
        b=hCd0PId7Pi/1Okkjq4FuvkjI8SuPmUJ9vwUPy7izIePElsqGvzMjDDU4mpVJ1j60oS
         cwgy8vfCdvp8PN+b4VEoi6/k3Owd7D5h2CzGvK++EYa2xX371YovNlitWNtdfxQivX5c
         ekp+EdmBNVuadwMzKYhZLSA29pJJFblxkUrpYhLSlxDTbAJ9GmO9R9iVydEQUKe1uCZb
         KRDQi4ZbWVWMp8Xu2zDrOj+roYTrn7gdoXkCjIXDgwEhZYWv1ha/gnrCEVQSeyRZz/sN
         CQPBJupy0VV5YwOe5WAHzJpmaPef2POWb4JlM0fb1V55l6uYQhFWRhZW/vHvW8+ywloR
         pSmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ujcgvnZnOlRivFcgptVkKE7tCIGAc0bhX8mb5ERfb2o=;
        b=yNa9k8S/zXLZWvElCy2B2LtzXBlRzRQP1F8GuJyCFr+wIroLR01m/IWjFLkkjEoE+L
         +st5IouTeXSB3hMOrE9EM2zkARJRnL8tFNLhX4rFQU280yFzOx8cfXbI4UxCAsPyud7C
         tqNrbp+uc8of4uypjOG9Mj1cvneaUxDSKIEquM0meGtRII/acvdbzG1Eo6SPb4tTXorZ
         IrCmRWMLFt20DlobcOunSqapz/86OFbLQfq8RJMOsNwHqs3tBIOs2UvAJUYbfGx4c0Nr
         T1xSZISwWZukamBcoferjPo8wuOfvwmC/TRQkg9I1NP43DUaU8iYcmsyucj997nDaUdb
         CEqQ==
X-Gm-Message-State: AOAM530vlUeM4hPHE+r+kTdKa3AzssMjW/FAGVbehXHiP6XfHEM+c0Vm
        Wjd2CReeRUhT9yJs2JP09YNZi1aPKHs7zbSeNEQ=
X-Google-Smtp-Source: ABdhPJzo0l0SGDsH8K9TH53sxx00B7fpowZN0SJiXLRlusVL3AsuTTtCMo59W07PmIf6LcW3LHYm1VlSEVbQZup0B6w=
X-Received: by 2002:a05:6638:1489:: with SMTP id j9mr4066740jak.18.1634685472336;
 Tue, 19 Oct 2021 16:17:52 -0700 (PDT)
MIME-Version: 1.0
References: <20211015005634.2658470-1-alistair.francis@opensource.wdc.com> <YW74wK03ibOS3jVZ@kernel.org>
In-Reply-To: <YW74wK03ibOS3jVZ@kernel.org>
From:   Alistair Francis <alistair23@gmail.com>
Date:   Wed, 20 Oct 2021 09:17:26 +1000
Message-ID: <CAKmqyKP6AU-9tcYOp-ERvYFP7t6DMp4kbQgDmJxD6wb0WTUy+w@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] perf bench futex: Use a 64-bit time_t
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@collabora.com>
Cc:     Alistair Francis <alistair.francis@opensource.wdc.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        linux-perf-users@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Darren Hart <dvhart@infradead.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Atish Patra <atish.patra@wdc.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Alistair Francis <alistair.francis@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Wed, Oct 20, 2021 at 2:56 AM Arnaldo Carvalho de Melo
<arnaldo.melo@gmail.com> wrote:
>
> Em Fri, Oct 15, 2021 at 10:56:33AM +1000, Alistair Francis escreveu:
> > From: Alistair Francis <alistair.francis@wdc.com>
> >
> > Convert tools/perf to only use a 64-bit time_t. On 64-bit architectures
> > this isn't a functional change. On 32-bit architectures we now only
> > perform 64-bit time_t syscalls (__NR_futex_time64) and use a struct
> > timespec64.
> >
> > This won't work on kernels before 5.1, but as perf is tied to the kerne=
l
> > that's ok.
>
> No, perf is not tied to the kernel, one can use a new perf tool on any
> previous kernel, and an old perf tool should work on new kernels as
> well.

+ Andr=C3=A9, I won't be doing this the way you requested

Ok, so back to the previous version then. I'll send the patches soon.

Alistair

>
> - Arnaldo
>
> > This allows us to build perf for 32-bit architectures with 64-bit time_=
t
> > like RISC-V 32-bit.
> >
> > Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> > ---
> >  tools/perf/bench/futex.h | 26 ++++++++++++++++++++------
> >  1 file changed, 20 insertions(+), 6 deletions(-)
> >
> > diff --git a/tools/perf/bench/futex.h b/tools/perf/bench/futex.h
> > index b3853aac3021c..b9665d43d2988 100644
> > --- a/tools/perf/bench/futex.h
> > +++ b/tools/perf/bench/futex.h
> > @@ -12,6 +12,7 @@
> >  #include <sys/syscall.h>
> >  #include <sys/types.h>
> >  #include <linux/futex.h>
> > +#include <linux/time_types.h>
> >
> >  struct bench_futex_parameters {
> >       bool silent;
> > @@ -27,12 +28,14 @@ struct bench_futex_parameters {
> >       unsigned int nrequeue;
> >  };
> >
> > +#define timespec64 __kernel_timespec
> > +
> >  /**
> >   * futex() - SYS_futex syscall wrapper
> >   * @uaddr:   address of first futex
> >   * @op:              futex op code
> >   * @val:     typically expected value of uaddr, but varies by op
> > - * @timeout: typically an absolute struct timespec (except where noted
> > + * @timeout: typically an absolute struct timespec64 (except where not=
ed
> >   *           otherwise). Overloaded by some ops
> >   * @uaddr2:  address of second futex for some ops
> >   * @val3:    varies by op
> > @@ -47,15 +50,26 @@ struct bench_futex_parameters {
> >   * These argument descriptions are the defaults for all
> >   * like-named arguments in the following wrappers except where noted b=
elow.
> >   */
> > -#define futex(uaddr, op, val, timeout, uaddr2, val3, opflags) \
> > -     syscall(SYS_futex, uaddr, op | opflags, val, timeout, uaddr2, val=
3)
> > +/**
> > + * We only support 64-bit time_t for the timeout.
> > + * On 64-bit architectures we can use __NR_futex
> > + * On 32-bit architectures we use __NR_futex_time64. This only works o=
n kernel
> > + * versions 5.1+.
> > + */
> > +#if __BITS_PER_LONG =3D=3D 64
> > +# define futex(uaddr, op, val, timeout, uaddr2, val3, opflags) \
> > +     syscall(__NR_futex, uaddr, op | opflags, val, timeout, uaddr2, va=
l3)
> > +#else
> > +# define futex(uaddr, op, val, timeout, uaddr2, val3, opflags) \
> > +     syscall(__NR_futex_time64, uaddr, op | opflags, val, timeout, uad=
dr2, val3)
> > +#endif
> >
> >  /**
> >   * futex_wait() - block on uaddr with optional timeout
> >   * @timeout: relative timeout
> >   */
> >  static inline int
> > -futex_wait(u_int32_t *uaddr, u_int32_t val, struct timespec *timeout, =
int opflags)
> > +futex_wait(u_int32_t *uaddr, u_int32_t val, struct timespec64 *timeout=
, int opflags)
> >  {
> >       return futex(uaddr, FUTEX_WAIT, val, timeout, NULL, 0, opflags);
> >  }
> > @@ -74,7 +88,7 @@ futex_wake(u_int32_t *uaddr, int nr_wake, int opflags=
)
> >   * futex_lock_pi() - block on uaddr as a PI mutex
> >   */
> >  static inline int
> > -futex_lock_pi(u_int32_t *uaddr, struct timespec *timeout, int opflags)
> > +futex_lock_pi(u_int32_t *uaddr, struct timespec64 *timeout, int opflag=
s)
> >  {
> >       return futex(uaddr, FUTEX_LOCK_PI, 0, timeout, NULL, 0, opflags);
> >  }
> > @@ -111,7 +125,7 @@ futex_cmp_requeue(u_int32_t *uaddr, u_int32_t val, =
u_int32_t *uaddr2, int nr_wak
> >   */
> >  static inline int
> >  futex_wait_requeue_pi(u_int32_t *uaddr, u_int32_t val, u_int32_t *uadd=
r2,
> > -                   struct timespec *timeout, int opflags)
> > +                   struct timespec64 *timeout, int opflags)
> >  {
> >       return futex(uaddr, FUTEX_WAIT_REQUEUE_PI, val, timeout, uaddr2, =
0,
> >                    opflags);
> > --
> > 2.31.1
>
> --
>
> - Arnaldo
