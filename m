Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12FF7C433F5
	for <linux-perf-users@archiver.kernel.org>; Fri, 10 Sep 2021 01:11:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E464760F45
	for <linux-perf-users@archiver.kernel.org>; Fri, 10 Sep 2021 01:11:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233050AbhIJBMt (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 9 Sep 2021 21:12:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230454AbhIJBMN (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 9 Sep 2021 21:12:13 -0400
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13060C0698DA;
        Thu,  9 Sep 2021 17:45:50 -0700 (PDT)
Received: by mail-io1-xd29.google.com with SMTP id m11so231966ioo.6;
        Thu, 09 Sep 2021 17:45:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=H9y8H6QOl79WQKF3o6TMJOZw1Wb4+/uT/dZLumITW4A=;
        b=Nh2OuGStj34DcE5wDIX/unXlXbeq8oW6E+c7X7QlPGDMGLbg2mFT+xeu3eWmddsnBo
         AnDW7/w48XY/1fC8rZ4GcABgXQDdrHofdgfGOjH22Lb7cqkDMJTQ8O5qGY8c0n7qYyW+
         ZGklISa8lfV8tRiEa/bW1Cjv50VKIvO2PTVkKcVYy61GT859uVrLVUJvOIgWyRX0uyvZ
         0rTeR1CdWHZrohWHZ04+jlShW6SUPPOktciMTF21fmBeb51w3ZxTwLsGEcZ9VPluTJuI
         NYQtCT7tL3kUl2/1XbzDJKoHi5Yp4tXIQJWr0s2Of7iFTelNGAnRBobRI9lhCsg1LnaI
         wRdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=H9y8H6QOl79WQKF3o6TMJOZw1Wb4+/uT/dZLumITW4A=;
        b=7uiGig03c1JDS3eBtUIU8h0Oyl59/IM24VbCXc4HhfPZS9TL4U84m4x+o9Q1l4/yG/
         r3EqVY3KjMDjZ2IJ/P1cW/hsAvxdiVizwIqfNZQXmAXbVbIGOfafrf21irSsGRhm1eR2
         yqGfs7BqGbkWKrAJXqbxAz718LN5OH7xfu8JVOYVkEM6LMAvYrqe51BbXmmTP/ORwR21
         4nPQ4GwsOpHjDKRRNHrs62CBNqNwN1sWVUiQ80OLdsPxTW17zXTTsbRFhIKCqMPvfnJh
         Nzsg90mEZ8X/6meHu1uG1cYRHOMkYyTob4b+AMYGNDyPohyB8I9fuSIinwWR1NgchWEs
         5eaw==
X-Gm-Message-State: AOAM530paR2W0BISN+tLEkG6+oFhLY3ahjEmhUyNVpcXDzaevYWm2RCq
        8V+8hBoiLM28+11MPekP+BcgZcZTyck7nS7TgByMG7ZaJ0Q=
X-Google-Smtp-Source: ABdhPJxgh40885LGDF1Y8duB3BiiIUqjNpckUI4hV0vDw+Mlj+oFyNHDNb8BneWrcWkFLiU3nhSWVC+1uQToqlxoKKU=
X-Received: by 2002:a05:6638:e8f:: with SMTP id p15mr2196917jas.114.1631234749514;
 Thu, 09 Sep 2021 17:45:49 -0700 (PDT)
MIME-Version: 1.0
References: <20210909042543.1982893-1-alistair.francis@opensource.wdc.com> <CAK8P3a1Udjzy=M4Vs8pGCKdedwtv-vPRjxbTcvTL6kP=yXSs0A@mail.gmail.com>
In-Reply-To: <CAK8P3a1Udjzy=M4Vs8pGCKdedwtv-vPRjxbTcvTL6kP=yXSs0A@mail.gmail.com>
From:   Alistair Francis <alistair23@gmail.com>
Date:   Fri, 10 Sep 2021 10:45:23 +1000
Message-ID: <CAKmqyKOO5DiEBUJRY_2Be97LfqoSyatHDB_iCeZqw0toTsrkXw@mail.gmail.com>
Subject: Re: [PATCH] perf bench: Add support for 32-bit systems with 64-bit time_t
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Alistair Francis <alistair.francis@opensource.wdc.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        linux-perf-users@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
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
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Thu, Sep 9, 2021 at 6:20 PM Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Thu, Sep 9, 2021 at 6:25 AM Alistair Francis
> <alistair.francis@opensource.wdc.com> wrote:
> >
> > From: Alistair Francis <alistair.francis@wdc.com>
> >
> > Some 32-bit architectures (such are 32-bit RISC-V) only have a 64-bit
> > time_t and as such don't have the SYS_futex syscall. This patch will
> > allow us to use the SYS_futex_time64 syscall on those platforms.
> >
> > This patch does not attempt to gracefully allow 32-bit architectures
> > with both SYS_futex and SYS_futex_time64 to support a 64-bit time_t.
> > This patch only applies to 32-bit architectures with a 64-bit time_t.
> >
> > Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
>
> Hi Alistair,
>
> I know you've made this mistake before and I've pointed it out
> several times. Please don't do this again, and try to fix up the
> ones you already broke!
>
> > +/**
> > + * Some newer 32-bit architectures (such as RISC-V 32-bit) don't have
> > + * the SYS_futex syscall and instead only have the SYS_futex_time64 call.
> > + * Let's ensure that those still compile and run by just using the
> > + * SYS_futex_time64 syscall. On these systems `struct timespec` will use a
> > + * 64-bit time_t so the SYS_futex_time64 call will work.
> > + */
> > +#if !defined(SYS_futex) && defined(SYS_futex_time64)
> > + #define SYS_futex SYS_futex_time64
> > +#endif
>
> This cannot work, as two system calls take different arguments: futex() takes
> a __kernel_old_timespec and futex_time64() takes a __kernel_timespec.
>
> You cannot derive anything about the ABI of the C library based on whether
> the macros are defined or not. Either you convert the arguments passed into
> the system call into the format expected by the kernel, or you pick the
> correct system call based on sizeof(struct timespec).

Thanks Arnd. Sorry I hadn't looked at this in a while and forgot that
it's more complex.

I have some patches to fix this up. I'll send them later today.

Alistair

>
>        Arnd
