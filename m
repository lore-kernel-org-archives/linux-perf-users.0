Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9817C433F5
	for <linux-perf-users@archiver.kernel.org>; Fri, 24 Sep 2021 04:35:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9F34861107
	for <linux-perf-users@archiver.kernel.org>; Fri, 24 Sep 2021 04:35:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242223AbhIXEg4 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 24 Sep 2021 00:36:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237144AbhIXEgz (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 24 Sep 2021 00:36:55 -0400
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD713C061756;
        Thu, 23 Sep 2021 21:35:22 -0700 (PDT)
Received: by mail-io1-xd2a.google.com with SMTP id h129so11064216iof.1;
        Thu, 23 Sep 2021 21:35:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=xcH9wYSR91fpt+5IhR8QHq5X+wHLKfuvWgni3VmGpiU=;
        b=IwQPPQ10h/E5e/e7b49Tir8b5B9hgs/Wi9m4wHV/tEVRB3SijM3j5dbrNfI70GEMmU
         cRwjbjssjw6ODT3JN0RVWcjCh8cD0Y+CxXu3DS242Uo98NLw5U6yKDmaKI7w92iroixP
         FNFPWVZtRff9VniJ6HRtLlhtjP1A+XGYVlKmmehI+WDSy6N3Vhs8UeQdDjtQZonRdhi8
         NccqO+MnV+D0g4F3ZApPzqWM7HOzosTHlI2dmcTR6jmCvjmofQQJgJHaNMaP24vhKiM1
         tuejb39zHQw4ELgt9h8JAtObelmIa1RCFZ/C+W07FW94J8bAun/3aAZVQ5CkoS+Bfp+h
         hSGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=xcH9wYSR91fpt+5IhR8QHq5X+wHLKfuvWgni3VmGpiU=;
        b=KjlNPy0yesaK44qSP1YnU2cmfJfcsHWJd86BKd69e+M2whkZN1x8r6cMNSCeVnOLlW
         VM4Fmn8CmljUb9fIUO0Heeoy9qNBRLPArARCk7nXkrXm6GNcxm07VJYOLUGdhE6TuwAT
         x8G0e29eTZcbRQoIS17B9PKeKEC8bJhlCTSMd1m9SXkFiUoT7QPINwAcvxZc3f/W5mfc
         C+svIHS3/o50Z8Xwmt/aQt7yvK8EjRnuLpT1TIaOyibTKlffyAKozpYTh/scPqMpRron
         JY6onrWhXuZvYSxa6p7SNGd01gLc4FXGKd7FPC0MF+2WqhZ4VJa2qtmYoE4/6GoAZuwt
         7tig==
X-Gm-Message-State: AOAM5325IbH5CCw/+9yfTRGaaRyF0UNjpiEpD+oJUW8TATyUgBfzK76i
        ALdFQ1lsCgAHMewhVdSVWLGrWdsPM6paj4jVKB0=
X-Google-Smtp-Source: ABdhPJw0PKpy4KqW5zF42c4Or1B+70c7jdEyFtPXZxvh0z0enU/YbxlqfhfU5mkG+k5Ewtfp3z2GHTvrCk4/ot0G2y4=
X-Received: by 2002:a02:2124:: with SMTP id e36mr7336788jaa.35.1632458122367;
 Thu, 23 Sep 2021 21:35:22 -0700 (PDT)
MIME-Version: 1.0
References: <20210917061040.2270822-1-alistair.francis@opensource.wdc.com>
 <20210917061040.2270822-2-alistair.francis@opensource.wdc.com>
 <72990864-5ec6-1f73-efd9-61b667a172dd@collabora.com> <CAK8P3a3x_EyCiPDpMK54y=Rtm-Wb08ym2TNiuAZgXhYrThcWTw@mail.gmail.com>
In-Reply-To: <CAK8P3a3x_EyCiPDpMK54y=Rtm-Wb08ym2TNiuAZgXhYrThcWTw@mail.gmail.com>
From:   Alistair Francis <alistair23@gmail.com>
Date:   Fri, 24 Sep 2021 14:34:56 +1000
Message-ID: <CAKmqyKM3vy_Ob1a0=cEi_Efi6_VVAa8YfMb6+rOt3fQK_TTcmw@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] perf bench: Add support for 32-bit systems with
 64-bit time_t
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@collabora.com>,
        Alistair Francis <alistair.francis@opensource.wdc.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>, linux-perf-users@vger.kernel.org,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Darren Hart <dvhart@infradead.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Atish Patra <atish.patra@wdc.com>,
        Alistair Francis <alistair.francis@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Tue, Sep 21, 2021 at 6:08 PM Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Tue, Sep 21, 2021 at 12:47 AM Andr=C3=A9 Almeida
> <andrealmeid@collabora.com> wrote:
> >
> > #if defined(__i386__) || __TIMESIZE =3D=3D 32
> > # define NR_gettime64 __NR_clock_gettime64
> > #else
> > # define NR_gettime64 __NR_clock_gettime
> > #endif
> >
> > struct timespec64 {
> >         long long tv_sec;       /* seconds */
> >         long long tv_nsec;      /* nanoseconds */
> > };
> >
> > int gettime64(clock_t clockid, struct timespec64 *tv)
> > {
> >         return syscall(NR_gettime64, clockid, tv);
> > }
> >
> > Then we can just use &timeout at __NR_futex_time64 for 32bit arch and a=
t
> > __NR_futex for 64bit arch.
>
> This is still broken when you disable CONFIG_COMPAT_32BIT_TIME,
> which disables all system calls that take time32 arguments.
>
> > This might be a simpler solution to the problem that you are facing but
> > I'm not entirely sure. Also, futex's selftests do use the timeout
> > argument and I think that they also won't compile in 32-bit RISC-V, so
> > maybe we can start from there so we can actually test the timeout
> > argument and check if it's working.
>
> I would love to see the wrapper that Alistair wrote as part of some kerne=
l
> uapi header provided to user space. futex is used by tons of applications=
,
> and we never had a library abstraction for it, so everyone has to do thes=
e
> by hand, and they all get them slightly wrong in different ways.
>
> We normally don't do this in kernel headers, but I think the benefits
> would be far greater compared to today's situation.

I'm happy to prepare a patch, if others are on board with it being accepted=
.

Alistair

>
>       Arnd
