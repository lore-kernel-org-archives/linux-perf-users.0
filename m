Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8F94C433EF
	for <linux-perf-users@archiver.kernel.org>; Fri, 24 Sep 2021 04:34:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 92EF061100
	for <linux-perf-users@archiver.kernel.org>; Fri, 24 Sep 2021 04:34:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229853AbhIXEgM (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 24 Sep 2021 00:36:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237144AbhIXEgL (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 24 Sep 2021 00:36:11 -0400
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A491C061574;
        Thu, 23 Sep 2021 21:34:39 -0700 (PDT)
Received: by mail-il1-x130.google.com with SMTP id v16so9006969ilg.3;
        Thu, 23 Sep 2021 21:34:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=2r3uHfiNTEeauI0qfOMLdIlPnnjW+o7oi9itFKgNNmo=;
        b=fdGPBfTIIKmH8Ik+1f3lUEUMb8jFS/BFVFKhiWWulXm5ZJhjP92WmTlype1RVSjDkV
         l5kt8t3VvnDaMlBZnXLB6iZDpokrW39ZZGfkursRajR8yyS12bOM9QCNSUpP0IQbrFkO
         qkr33cDNczNmXBKCas0BR0rg39eaNcBRW5/EQT2s0IkHgIU/pLnKlYChY3pSAebeEXvO
         LmRWvX5DTRNP268BNkKVoXSrxbHxCQ8dvD52hRpocR+dB4po7zOeNCRGqmEob85s5tdj
         eBiZGcYaD29G5rOCykoi/nO2/5o7Ud5GnS2qMDKI4MHKLb2U0d4FCk0qriKkW57uB/aM
         KgVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=2r3uHfiNTEeauI0qfOMLdIlPnnjW+o7oi9itFKgNNmo=;
        b=cTV0saUNLsQWyJdz+uOEoHdHPffCdUsBYUg1MasCSf2tdmOahnN5lmZthLedl6hUTa
         1B65SE6o+IMIlJl7jd45YGNAsAo/Ekz1KuXYGaXMQ/wUhdvpY73YuD0/RvvtGNyWlmTn
         7UgDfFZBcl430DhFlXeiT82XIWMYiIlyRkFNTdQSLJmda1fph55Gb+2orrRrVKMJzSbO
         U6hXO7rF0RSWKjlyixBo3pa2Gn8qFaFZxyOAdpfrTO4HhL9iGRTfjg2bF7HhIrPF4SnW
         6D3NXdIGRhpB/5G42yz0iIEp6xz+xvwHdwxPp3akmZaiIybMiMXBwBR1g+D0I2Eo2nsQ
         NrWQ==
X-Gm-Message-State: AOAM531pNhI4JbiNOfQS/Cupk38tXczcn0VjoLRohs9wv8tJbgUBxiYb
        /UTKwPNZ4YbA4adURrc/UzQK57Zw2C+UnYNpVuI=
X-Google-Smtp-Source: ABdhPJzEgBABW4mg2utXHmBrllZW9Z85DYLZ9jFrATnK8EeNSzpxxUEjhvDeaZruoslRCDJJpaNQGi/6Ll9SK8alKw8=
X-Received: by 2002:a05:6e02:1088:: with SMTP id r8mr6568454ilj.46.1632458078345;
 Thu, 23 Sep 2021 21:34:38 -0700 (PDT)
MIME-Version: 1.0
References: <20210917061040.2270822-1-alistair.francis@opensource.wdc.com>
 <20210917061040.2270822-2-alistair.francis@opensource.wdc.com> <72990864-5ec6-1f73-efd9-61b667a172dd@collabora.com>
In-Reply-To: <72990864-5ec6-1f73-efd9-61b667a172dd@collabora.com>
From:   Alistair Francis <alistair23@gmail.com>
Date:   Fri, 24 Sep 2021 14:34:12 +1000
Message-ID: <CAKmqyKM+VN-KST9-VMULZMC=2sNbjH2wiE-CZ1WRfVFj3WmpdQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] perf bench: Add support for 32-bit systems with
 64-bit time_t
To:     =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@collabora.com>
Cc:     Alistair Francis <alistair.francis@opensource.wdc.com>,
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
        Arnd Bergmann <arnd@arndb.de>,
        Alistair Francis <alistair.francis@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Tue, Sep 21, 2021 at 8:47 AM Andr=C3=A9 Almeida <andrealmeid@collabora.c=
om> wrote:
>
> Hi Alistair,
>
> =C3=80s 03:10 de 17/09/21, Alistair Francis escreveu:
> > From: Alistair Francis <alistair.francis@wdc.com>
> >
> > Some 32-bit architectures (such are 32-bit RISC-V) only have a 64-bit
> > time_t and as such don't have the SYS_futex syscall. This patch will
> > allow us to use the SYS_futex_time64 syscall on those platforms.
> >
>
> Thanks for your patch! However, I don't think that any futex operation
> at perf has timeout. Do you plan to implement a test that use it? Or the
> idea is to get this ready for it in case someone want to do so in the
> future?

I don't have plans to implement any new tests (although I'm happy to
add one if need be).

My goal was just to get this to build for RISC-V 32-bit. The timeout
was already exposed by the old futex macro, so I was just following
that.

>
>
> Also, I faced a similar problem with the new futex2 syscalls, that
> supports exclusively 64bit timespec. But I took a different approach: I
> called __NR_clock_gettime64 for 32bit architectures so it wouldn't
> require to convert the struct:
>
> #if defined(__i386__) || __TIMESIZE =3D=3D 32
> # define NR_gettime64 __NR_clock_gettime64
> #else
> # define NR_gettime64 __NR_clock_gettime
> #endif
>
> struct timespec64 {
>         long long tv_sec;       /* seconds */
>         long long tv_nsec;      /* nanoseconds */
> };
>
> int gettime64(clock_t clockid, struct timespec64 *tv)
> {
>         return syscall(NR_gettime64, clockid, tv);
> }
>
> Then we can just use &timeout at __NR_futex_time64 for 32bit arch and at
> __NR_futex for 64bit arch.

So the idea is to use 64-bit time_t everywhere and only work on 5.1+ kernel=
s.

If that's the favoured approach I can convert this series to your idea.

Alistair

>
> This might be a simpler solution to the problem that you are facing but
> I'm not entirely sure. Also, futex's selftests do use the timeout
> argument and I think that they also won't compile in 32-bit RISC-V, so
> maybe we can start from there so we can actually test the timeout
> argument and check if it's working.
>
> Thanks,
>         Andr=C3=A9
