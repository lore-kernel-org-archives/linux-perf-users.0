Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5B82C433E0
	for <linux-perf-users@archiver.kernel.org>; Mon, 18 Jan 2021 17:01:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A59A4222BB
	for <linux-perf-users@archiver.kernel.org>; Mon, 18 Jan 2021 17:01:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406286AbhARRBm (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 18 Jan 2021 12:01:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:60884 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2406843AbhARRBK (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 18 Jan 2021 12:01:10 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id A78ED222BB
        for <linux-perf-users@vger.kernel.org>; Mon, 18 Jan 2021 17:00:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610989229;
        bh=W6mdYXgoZxt7noeEV0ncPzuXdqYtCI5gVI08G1G+tNg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ZzJoQAJqQPK7GvFwnQV24J8F4n5XA8eCw3xwd8UZ2KUU1vp6WkxcBO0/sbi9K47pg
         iPi9LUVu7CaqDHT6fZjfFZ4Mm3OjlHQrjT6xyodU0ogj+eXLuQv0QHMEF8c3TB6GcH
         M99Xizqy1d6NO3ecb10rR2pPl3r8ah3l/eQLJGfNClMnZYmWyMhPXUcNylomp3tW58
         yDiNBDpO+fjR8MIYlrU4q4d7gjUTvjOolCYac0bnG7Yqd13ooVBb9hz2+69hWprh6L
         Iskyj8rS0pozMLQL6NTJiqhy7NF5rDQvKuwv2YT2jHwjALqov3OmA9tgN0EJ4sgtUe
         O6RimsvymXQ4w==
Received: by mail-ot1-f44.google.com with SMTP id w3so16869785otp.13
        for <linux-perf-users@vger.kernel.org>; Mon, 18 Jan 2021 09:00:29 -0800 (PST)
X-Gm-Message-State: AOAM530XgJupVlEN0N9GAwdXnvQuvSghwiaY0CdkMiJf+MtqvX7jmoEi
        0df9lCwS4g2NoYnuiXngSJi4NgQ6MUmeucbMm6w=
X-Google-Smtp-Source: ABdhPJwi51y8ByGtH5HHM2C1zoKJOoMnFIUP4ltOb3+ZG0kCMsRwjxKKPy+W0xbjXLhDBR68BgPIksv9oLWsenN0Af8=
X-Received: by 2002:a9d:741a:: with SMTP id n26mr324009otk.210.1610989229061;
 Mon, 18 Jan 2021 09:00:29 -0800 (PST)
MIME-Version: 1.0
References: <CAK8P3a0dJnKiX5minsUNdAcNnxPvZkyK363f1ibj_x0L2MQiPQ@mail.gmail.com>
 <YAVynNqAwBt5GzQT@ingrassia.epigenesys.com> <CAK8P3a33i2r0xx==3hTW32pc_Sm33EMDXYAS4PtEaEV8DX4s_A@mail.gmail.com>
 <YAWaQVBM84CaY1B2@ingrassia.epigenesys.com> <YAWg6KQt6hAtIR6O@ingrassia.epigenesys.com>
 <CAK8P3a3Vc4wrLvrfwkHd6HCMohk07Yi6P_jKaC_5AybCMBNjPA@mail.gmail.com>
 <YAWqS9YZ0rpXPoSN@ingrassia.epigenesys.com> <CAK8P3a0kOi55Dg-P-v+GcKdoLY6VOvv5Lj63X1=vL9LDR=Fe9A@mail.gmail.com>
 <YAW4gmkJzlG8kNf6@ingrassia.epigenesys.com>
In-Reply-To: <YAW4gmkJzlG8kNf6@ingrassia.epigenesys.com>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Mon, 18 Jan 2021 18:00:12 +0100
X-Gmail-Original-Message-ID: <CAK8P3a1O8-DuyF1nk08qqvv1Grf0FB_y9p-Kc6iFG3vp74Jd=Q@mail.gmail.com>
Message-ID: <CAK8P3a1O8-DuyF1nk08qqvv1Grf0FB_y9p-Kc6iFG3vp74Jd=Q@mail.gmail.com>
Subject: Re: perf tools build broken for RISCV 32 bit
To:     Emiliano Ingrassia <ingrassia@epigenesys.com>
Cc:     Arnaldo Carvalho de Melo <acme@redhat.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Bruce Ashfield <bruce.ashfield@gmail.com>,
        Khem Raj <raj.khem@gmail.com>,
        Richard Purdie <richard.purdie@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Mon, Jan 18, 2021 at 5:34 PM Emiliano Ingrassia
<ingrassia@epigenesys.com> wrote:
>
> in a simple user space app which calls futex (I changed do_futex with
> SYS_futex):
>
> #include <stdlib.h>
> #include <stdint.h>
> #include <unistd.h>
> #include <sys/syscall.h>
> #include <linux/futex.h>
> #include <sys/time.h>
>
> #ifdef __NR_futex
> #define SYS_futex (sizeof(time_t) =3D=3D sizeof(__kernel_long_t)) ? \
>                                            __NR_futex : __NR_futex_time64
> #else
> #define SYS_futex __NR_futex
> #endif

Note that SYS_futex will clash with a libc defined macro of the same name,
so better avoid that.

I guess you also need a third path

#ifndef __NR_futex /* using time64/__kernel_timespec */
...
#elif !defined(__NR_futex64) /* using __kernel_old_timespec */
...
#else /* libc dependent */
...
#endif

> static int
> futex(uint32_t *uaddr, int futex_op, uint32_t val,
>       const struct timespec *timeout, uint32_t *uaddr2, uint32_t val3)
> {
>         return syscall(SYS_futex, uaddr, futex_op, val, timeout, uaddr2, =
val3);
> }
>
> int main(void)
> {
>         return futex(NULL, FUTEX_WAKE, 0, NULL, NULL, 0);
> }
>
> But what I get is:
>
> error: =E2=80=98__NR_futex=E2=80=99 undeclared (first use in this functio=
n)
>    12 | #define SYS_futex __NR_futex
>
>
> The problem is that if __NR_futex is not defined it will not work anyway.

Right, sorry about that, see above.

> So the only viable solution to correctly compile and use perf on riscv
> 32 bit is the implementation of time32 syscall for that architecture?

You only need a time32 syscall if your libc defines the time32
version of 'struct timespec'.

> And this is true for all 32 bit applications that want to call futex
> syscall with a non NULL timer parameter, right?

Also the ones that pass a NULL parameter, as the kernel does
not necessarily implement both.

         Arnd
