Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C35E2C433E0
	for <linux-perf-users@archiver.kernel.org>; Mon, 18 Jan 2021 16:38:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 985CC206F7
	for <linux-perf-users@archiver.kernel.org>; Mon, 18 Jan 2021 16:38:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404100AbhARQhS (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 18 Jan 2021 11:37:18 -0500
Received: from mail-ed1-f48.google.com ([209.85.208.48]:33460 "EHLO
        mail-ed1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393192AbhARQe5 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 18 Jan 2021 11:34:57 -0500
Received: by mail-ed1-f48.google.com with SMTP id c6so11146793ede.0
        for <linux-perf-users@vger.kernel.org>; Mon, 18 Jan 2021 08:34:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=70JYencCI5GIK5ExOJUEk5bDZNHenGExsi/dk/7n5EI=;
        b=lmttl6U2qKmIG+vIiVTAX5HPR4rRTJeZRb7AiBrNKj1GLrpW+Laz3E6gbutiXdjphT
         JZc0d7h8e6kYXJYRjX4w05jCDmbP4s/TsnntgietjkJbQesp7B2Aweyu+NgUH0+xHh5u
         u5K/TmFarvtiuiaHq4e7HqwxDabrhbC2RyXuW0XcUS3Wv2szYMDssf/2o317QjUQWEG5
         hIOeV7pC2uOC1ZQiN9WM1EyLWxsUSkiAYVtTr3NP75ELS+vl60NwUZKKbPH/DhJNNarS
         WfxRGV3f/2KmX7L8yaxOskCEgZc1QIFJru1xHO8ftAmrwlHXBR+D+1lbdXdJTAubSwAV
         R9WQ==
X-Gm-Message-State: AOAM532SN5lyYaRscImr4b/oUrh5nO5Y/FISXaVD1YWHsgZLfWJ0ZKwm
        MaWKQnBAW82IMGiD0vEaGx0=
X-Google-Smtp-Source: ABdhPJwmKpzDTb/TeFkj4aNRdGRrIfBHfW9mR58fO5psARoWJDK4qKQnmnR9/Sn7rc9T7SLIL2NDXQ==
X-Received: by 2002:aa7:d39a:: with SMTP id x26mr222292edq.51.1610987655250;
        Mon, 18 Jan 2021 08:34:15 -0800 (PST)
Received: from ingrassia.epigenesys.com ([2.236.81.180])
        by smtp.gmail.com with ESMTPSA id cy13sm1644854edb.27.2021.01.18.08.34.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Jan 2021 08:34:14 -0800 (PST)
Date:   Mon, 18 Jan 2021 17:34:10 +0100
From:   Emiliano Ingrassia <ingrassia@epigenesys.com>
To:     Arnd Bergmann <arnd@kernel.org>
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
Subject: Re: perf tools build broken for RISCV 32 bit
Message-ID: <YAW4gmkJzlG8kNf6@ingrassia.epigenesys.com>
References: <CAK8P3a0dJnKiX5minsUNdAcNnxPvZkyK363f1ibj_x0L2MQiPQ@mail.gmail.com>
 <YAVynNqAwBt5GzQT@ingrassia.epigenesys.com>
 <CAK8P3a33i2r0xx==3hTW32pc_Sm33EMDXYAS4PtEaEV8DX4s_A@mail.gmail.com>
 <YAWaQVBM84CaY1B2@ingrassia.epigenesys.com>
 <YAWg6KQt6hAtIR6O@ingrassia.epigenesys.com>
 <CAK8P3a3Vc4wrLvrfwkHd6HCMohk07Yi6P_jKaC_5AybCMBNjPA@mail.gmail.com>
 <YAWqS9YZ0rpXPoSN@ingrassia.epigenesys.com>
 <CAK8P3a0kOi55Dg-P-v+GcKdoLY6VOvv5Lj63X1=vL9LDR=Fe9A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAK8P3a0kOi55Dg-P-v+GcKdoLY6VOvv5Lj63X1=vL9LDR=Fe9A@mail.gmail.com>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Hi Arnd,

On Mon, Jan 18, 2021 at 04:44:36PM +0100, Arnd Bergmann wrote:
> On Mon, Jan 18, 2021 at 4:33 PM Emiliano Ingrassia
> <ingrassia@epigenesys.com> wrote:
>
> > Ok, I totally agree with you on this point.
> >
> > So, it is right to conclude that the problem is not in perf
> > implementation but in the libc implementation?
>
> No, libc does not provide a futex abstraction, and the SYS_* macros
> just refer to the low-level interfaces that operate on kernel types rather
> than libc types. An application that uses them must pass the
> correct types.
>
> > That is, for example, glibc should define SYS_futex as SYS_futex_time64
> > in case of riscv 32 bit because of its support to 64 bit time_t?
>
> As I explained, SYS_futex would refer to the time32 syscall, which
> does not exist on rv32, redefining it to a different syscall would lead to
> data corruption as well.
>

I tried to apply the patch you proposed in your first reply:

> #ifdef __NR_futex
> #define do_futex (sizeof(time_t) == sizeof(__kernel_long_t)) ? \
>          __NR_futex : __NR_futex_time64
> #else
> #define do_futex __NR_futex
> #done

in a simple user space app which calls futex (I changed do_futex with
SYS_futex):

#include <stdlib.h>
#include <stdint.h>
#include <unistd.h>
#include <sys/syscall.h>
#include <linux/futex.h>
#include <sys/time.h>

#ifdef __NR_futex
#define SYS_futex (sizeof(time_t) == sizeof(__kernel_long_t)) ? \
				           __NR_futex : __NR_futex_time64
#else
#define SYS_futex __NR_futex
#endif

static int
futex(uint32_t *uaddr, int futex_op, uint32_t val,
      const struct timespec *timeout, uint32_t *uaddr2, uint32_t val3)
{
	return syscall(SYS_futex, uaddr, futex_op, val, timeout, uaddr2, val3);
}

int main(void)
{
	return futex(NULL, FUTEX_WAKE, 0, NULL, NULL, 0);
}

But what I get is:

error: ‘__NR_futex’ undeclared (first use in this function)
   12 | #define SYS_futex __NR_futex


The problem is that if __NR_futex is not defined it will not work anyway.


So the only viable solution to correctly compile and use perf on riscv
32 bit is the implementation of time32 syscall for that architecture?

And this is true for all 32 bit applications that want to call futex
syscall with a non NULL timer parameter, right?


> If you call futex_time64, you have to pass a __kernel_timespec structure,
> while the old futex call must take a __kernel_old_timespec structure.
> Depending on the architecture, only one of the two syscalls might be
> available, and if you pass a timespec defined by libc, you have to
> know which of the two syscalls that corresponds to, or convert
> the arguments when calling it.
>
>       Arnd

Thank you, best regards.

Emiliano
