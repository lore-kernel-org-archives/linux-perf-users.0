Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CD86C433F5
	for <linux-perf-users@archiver.kernel.org>; Fri, 22 Oct 2021 00:35:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2AB7161213
	for <linux-perf-users@archiver.kernel.org>; Fri, 22 Oct 2021 00:35:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231921AbhJVAhw (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 21 Oct 2021 20:37:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbhJVAhw (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 21 Oct 2021 20:37:52 -0400
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A78C7C061766;
        Thu, 21 Oct 2021 17:35:35 -0700 (PDT)
Received: by mail-il1-x133.google.com with SMTP id 3so51921ilq.7;
        Thu, 21 Oct 2021 17:35:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=4wOTzbqLNYqxGFNwDAYixOtsIL9GISPycQH+77EFemU=;
        b=YvozeOiT87sbTM6nN+buHxQFa8IoQ0P7Qvwpv7KUJ5Ky1YPYaLuj72DBTC2cVLlHXM
         2ST6sUvojU1p1+OqgucRhIW4uMAzCVq5Hj9PXhoNxAX+4lsplb/oyFajDXzOTtg8frvw
         cypbq0e0BAYThQB9tL/0dNqdlibBbDPSEAOJMjjXYBXTHnLn2Gk5ULramCYQGB22q1SB
         cfG9NdEkCnzH50BMY8vKG/68eNqbO/nvngZdFLQwxwfYxeyYM3pqA88+zGPpWa3/SgTA
         wcZykSIuI8sc1Ocbe1Bx4xDYSxbF1MsEKDTxYbv4kENmmhkfs+XD2LjMNDGepDtzVAt7
         2eYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=4wOTzbqLNYqxGFNwDAYixOtsIL9GISPycQH+77EFemU=;
        b=NPvzjTs/O7hyzgSk8E1V/zT9n1bhuBMlXuE5i8JrDJp5CYDjdE7UtzaXlCvHPsIsp3
         gNZNJ7wUQy3ShIj6uDTPML5W8mQZtp1sh7i+kdzlVZli/ssh191zYWUUCrk2Q4O+dhG1
         0zuPcs2Lw9JhrF/ZAT9OBdQNVWpoq5pQTrZmzvP6F85zdApiSB50EXp31hxyfuBqvUPE
         /+M1Yy8Y94vPo4Ocusc3g3ClyHK8kE4vRaHfGBVbv91jDZ/gogb3WHsS+9ukY+oZ9xAz
         +7T1aSNpjrPTr0Yyl0ABj7iAnbUm2B9coF81FRVYPBYbNk+0GfnHtG/3ztqRZZ2AHq4a
         f7dA==
X-Gm-Message-State: AOAM532cfPgfpYwr213F1+kN81KB3u5VxhpfL1x+BTH+nhsdm4IBMAn0
        pylScZOU+AZdoYHjtnILwbm+feWrHXtYhkeDc+o=
X-Google-Smtp-Source: ABdhPJwUjjD774ZWmkk3Y98Gmg1kYsj+1guRPYqrCm+yYij8RTzuNK7ayek3KPpOyip8e4cEna5y6Kqmrl1lWOD0pl0=
X-Received: by 2002:a05:6e02:1bab:: with SMTP id n11mr157789ili.290.1634862935056;
 Thu, 21 Oct 2021 17:35:35 -0700 (PDT)
MIME-Version: 1.0
References: <20211020223920.2810727-1-alistair.francis@opensource.wdc.com> <YXFqYJsPYA4c4Fqw@kernel.org>
In-Reply-To: <YXFqYJsPYA4c4Fqw@kernel.org>
From:   Alistair Francis <alistair23@gmail.com>
Date:   Fri, 22 Oct 2021 10:35:08 +1000
Message-ID: <CAKmqyKMMQ7UaUTaCBHWrrtT-W+s5-ERAx6H97oOdNyCoXG7ngg@mail.gmail.com>
Subject: Re: [PATCH v4 1/4] perf bench futex: Call the futex syscall from a function
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
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
        Alistair Francis <alistair.francis@wdc.com>,
        Davidlohr Bueso <dbueso@suse.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Thu, Oct 21, 2021 at 11:25 PM Arnaldo Carvalho de Melo
<arnaldo.melo@gmail.com> wrote:
>
> Em Thu, Oct 21, 2021 at 08:39:17AM +1000, Alistair Francis escreveu:
> > From: Alistair Francis <alistair.francis@wdc.com>
> >
> > In preparation for a more complex futex() function let's convert the
> > current macro into two functions. We need two functions to avoid
> > compiler failures as the macro is overloaded.
> >
> > This will allow us to include pre-processor conditionals in the futex
> > syscall functions.
> >
> > Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> > Acked-by: Davidlohr Bueso <dbueso@suse.de>
> > ---
> >  tools/perf/bench/futex.h | 43 ++++++++++++++++++++++++----------------
> >  1 file changed, 26 insertions(+), 17 deletions(-)
>
> Right after applying this one:
>
> In file included from bench/futex-hash.c:29:
> bench/futex.h: In function =E2=80=98futex_syscall=E2=80=99:
> bench/futex.h:52:61: error: =E2=80=98ts32=E2=80=99 undeclared (first use =
in this function); did you mean =E2=80=98s32=E2=80=99?
>    52 |         return syscall(SYS_futex, uaddr, op | opflags, val, ts32,=
 uaddr2, val3);
>       |                                                             ^~~~
>       |                                                             s32

Sorry about that. There is a copy and paste error here. I have fixed this p=
atch.

Alistair

> bench/futex.h:52:61: note: each undeclared identifier is reported only on=
ce for each function it appears in
> bench/futex.h:49:82: error: unused parameter =E2=80=98timeout=E2=80=99 [-=
Werror=3Dunused-parameter]
>    49 | futex_syscall(volatile u_int32_t *uaddr, int op, u_int32_t val, s=
truct timespec *timeout,
>       |                                                                 ~=
~~~~~~~~~~~~~~~~^~~~~~~
> bench/futex.h:53:1: error: control reaches end of non-void function [-Wer=
ror=3Dreturn-type]
>    53 | }
>       | ^
> cc1: all warnings being treated as errors
> make[4]: *** [/var/home/acme/git/perf/tools/build/Makefile.build:96: /tmp=
/build/perf/bench/futex-hash.o] Error 1
> make[4]: *** Waiting for unfinished jobs....
> In file included from bench/futex-wake-parallel.c:31:
> bench/futex.h: In function =E2=80=98futex_syscall=E2=80=99:
> bench/futex.h:52:61: error: =E2=80=98ts32=E2=80=99 undeclared (first use =
in this function); did you mean =E2=80=98s32=E2=80=99?
>    52 |         return syscall(SYS_futex, uaddr, op | opflags, val, ts32,=
 uaddr2, val3);
>       |                                                             ^~~~
>       |                                                             s32
> bench/futex.h:52:61: note: each undeclared identifier is reported only on=
ce for each function it appears in
> bench/futex.h:49:82: error: unused parameter =E2=80=98timeout=E2=80=99 [-=
Werror=3Dunused-parameter]
>    49 | futex_syscall(volatile u_int32_t *uaddr, int op, u_int32_t val, s=
truct timespec *timeout,
>       |                                                                 ~=
~~~~~~~~~~~~~~~~^~~~~~~
> bench/futex.h:53:1: error: control reaches end of non-void function [-Wer=
ror=3Dreturn-type]
>    53 | }
>       | ^
> cc1: all warnings being treated as errors
> make[4]: *** [/var/home/acme/git/perf/tools/build/Makefile.build:96: /tmp=
/build/perf/bench/futex-wake-parallel.o] Error 1
> In file included from bench/futex-requeue.c:26:
> bench/futex.h: In function =E2=80=98futex_syscall=E2=80=99:
> bench/futex.h:52:61: error: =E2=80=98ts32=E2=80=99 undeclared (first use =
in this function); did you mean =E2=80=98s32=E2=80=99?
>    52 |         return syscall(SYS_futex, uaddr, op | opflags, val, ts32,=
 uaddr2, val3);
>       |                                                             ^~~~
>       |                                                             s32
> bench/futex.h:52:61: note: each undeclared identifier is reported only on=
ce for each function it appears in
> bench/futex.h:49:82: error: unused parameter =E2=80=98timeout=E2=80=99 [-=
Werror=3Dunused-parameter]
>    49 | futex_syscall(volatile u_int32_t *uaddr, int op, u_int32_t val, s=
truct timespec *timeout,
>       |                                                                 ~=
~~~~~~~~~~~~~~~~^~~~~~~
> bench/futex.h:53:1: error: control reaches end of non-void function [-Wer=
ror=3Dreturn-type]
>    53 | }
>       | ^
> cc1: all warnings being treated as errors
> In file included from bench/futex-lock-pi.c:19:
> bench/futex.h: In function =E2=80=98futex_syscall=E2=80=99:
> bench/futex.h:52:61: error: =E2=80=98ts32=E2=80=99 undeclared (first use =
in this function); did you mean =E2=80=98s32=E2=80=99?
>    52 |         return syscall(SYS_futex, uaddr, op | opflags, val, ts32,=
 uaddr2, val3);
>       |                                                             ^~~~
>       |                                                             s32
> bench/futex.h:52:61: note: each undeclared identifier is reported only on=
ce for each function it appears in
> bench/futex.h:49:82: error: unused parameter =E2=80=98timeout=E2=80=99 [-=
Werror=3Dunused-parameter]
>    49 | futex_syscall(volatile u_int32_t *uaddr, int op, u_int32_t val, s=
truct timespec *timeout,
>       |                                                                 ~=
~~~~~~~~~~~~~~~~^~~~~~~
> bench/futex.h:53:1: error: control reaches end of non-void function [-Wer=
ror=3Dreturn-type]
>    53 | }
>       | ^
> cc1: all warnings being treated as errors
> make[4]: *** [/var/home/acme/git/perf/tools/build/Makefile.build:96: /tmp=
/build/perf/bench/futex-requeue.o] Error 1
> make[4]: *** [/var/home/acme/git/perf/tools/build/Makefile.build:96: /tmp=
/build/perf/bench/futex-lock-pi.o] Error 1
> In file included from bench/futex-wake.c:25:
> bench/futex.h: In function =E2=80=98futex_syscall=E2=80=99:
> bench/futex.h:52:61: error: =E2=80=98ts32=E2=80=99 undeclared (first use =
in this function); did you mean =E2=80=98s32=E2=80=99?
>    52 |         return syscall(SYS_futex, uaddr, op | opflags, val, ts32,=
 uaddr2, val3);
>       |                                                             ^~~~
>       |                                                             s32
> bench/futex.h:52:61: note: each undeclared identifier is reported only on=
ce for each function it appears in
> bench/futex.h:49:82: error: unused parameter =E2=80=98timeout=E2=80=99 [-=
Werror=3Dunused-parameter]
>    49 | futex_syscall(volatile u_int32_t *uaddr, int op, u_int32_t val, s=
truct timespec *timeout,
>       |                                                                 ~=
~~~~~~~~~~~~~~~~^~~~~~~
> bench/futex.h:53:1: error: control reaches end of non-void function [-Wer=
ror=3Dreturn-type]
>    53 | }
>       | ^
> cc1: all warnings being treated as errors
> make[4]: *** [/var/home/acme/git/perf/tools/build/Makefile.build:96: /tmp=
/build/perf/bench/futex-wake.o] Error 1
> make[3]: *** [/var/home/acme/git/perf/tools/build/Makefile.build:139: ben=
ch] Error 2
> make[3]: *** Waiting for unfinished jobs....
> make[2]: *** [Makefile.perf:660: /tmp/build/perf/perf-in.o] Error 2
> make[1]: *** [Makefile.perf:240: sub-make] Error 2
> make: *** [Makefile:113: install-bin] Error 2
> make: Leaving directory '/var/home/acme/git/perf/tools/perf'
>
>  Performance counter stats for 'make -k BUILD_BPF_SKEL=3D1 CORESIGHT=3D1 =
PYTHON=3Dpython3 O=3D/tmp/build/perf -C tools/perf install-bin':
>
>           2,467.00 msec task-clock:u              #    1.263 CPUs utilize=
d
>           2,457.82 msec cpu-clock:u               #    1.259 CPUs utilize=
d
>
>        1.952573032 seconds time elapsed
>
>        1.444401000 seconds user
>        1.111434000 seconds sys
>
>
> =E2=AC=A2[acme@toolbox perf]$
>
>
