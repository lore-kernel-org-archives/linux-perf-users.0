Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 938FCC433EF
	for <linux-perf-users@archiver.kernel.org>; Fri, 15 Oct 2021 08:05:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7384560ED4
	for <linux-perf-users@archiver.kernel.org>; Fri, 15 Oct 2021 08:05:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234714AbhJOIHu (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 15 Oct 2021 04:07:50 -0400
Received: from mout.kundenserver.de ([212.227.126.131]:53719 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232537AbhJOIHu (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 15 Oct 2021 04:07:50 -0400
Received: from mail-wr1-f50.google.com ([209.85.221.50]) by
 mrelayeu.kundenserver.de (mreue011 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1MRC7g-1mPEyg3cJw-00NBOg; Fri, 15 Oct 2021 10:05:42 +0200
Received: by mail-wr1-f50.google.com with SMTP id g25so24882325wrb.2;
        Fri, 15 Oct 2021 01:05:42 -0700 (PDT)
X-Gm-Message-State: AOAM530YmS25Po28wfQMHJPNpkAcV5x3RrfefKyrR3mJ/NCRwI6Zmv2r
        vbN52gTe3yT6NzIys6TSorRupaY7w/+beRg5w4g=
X-Google-Smtp-Source: ABdhPJy9sZlQDrqD9m1U2kCsGr+NuqJq9GR+IhadW9NMvzLQSDS60WXLsc5ghfbjxyAdBhF+koA6oF3ct4kqTEH5fY8=
X-Received: by 2002:adf:a3da:: with SMTP id m26mr12221525wrb.336.1634285142440;
 Fri, 15 Oct 2021 01:05:42 -0700 (PDT)
MIME-Version: 1.0
References: <20211015005634.2658470-1-alistair.francis@opensource.wdc.com> <20211015005634.2658470-2-alistair.francis@opensource.wdc.com>
In-Reply-To: <20211015005634.2658470-2-alistair.francis@opensource.wdc.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 15 Oct 2021 10:05:26 +0200
X-Gmail-Original-Message-ID: <CAK8P3a2i-4Q8SPwO+3X_FDF_J=dr3cyuRTgF7zxjW4WKxY0tuA@mail.gmail.com>
Message-ID: <CAK8P3a2i-4Q8SPwO+3X_FDF_J=dr3cyuRTgF7zxjW4WKxY0tuA@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] selftests: futex: Use a 64-bit time_t
To:     Alistair Francis <alistair.francis@opensource.wdc.com>
Cc:     linux-riscv <linux-riscv@lists.infradead.org>,
        linux-perf-users@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alistair Francis <alistair23@gmail.com>,
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
        Arnd Bergmann <arnd@arndb.de>,
        Alistair Francis <alistair.francis@wdc.com>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:2QiHaZmcgG8KdrovqerTOtmxT24fe5r0TFvFfk2Cgy8jFVSFk+a
 4WdYRe0tpdckk5vWAU0osFNfVYGCaxBwYUjXaLHIsMvi59cFOCF2Hj5Ec/EafZtFZMa0bcS
 pGzrIHoTRPX/nWBJLQMi8/UuCsS5Np4wp0ApcqKu94uiB5WLpz4lC2njx9++IqHvfmx6b+6
 32OX+T7GQ93BLBIH002DQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:nnqrw5WsQIg=:QqwMh28coBxY3LSIG6y9Fq
 BB0CQyD3YaWUU1IPR57TfBsrEFbdHIa3gcnZgmrMXjibuzJ1m6j5L8vUHoLfaB1sN5GSD9/R9
 pf8BbjNbR1Wh6qI8r+58ujuhJe1MdH5mqatvy4l6C4yWyqSXrn9da40kiCNFfu7tKeDRZm/+h
 Ajpx3DBuv0fsSbz6kUUl6UNAwIZaBUXmVcoZ29m3QcJDusp4rk5trmn4Y/1TXgf1hBXw8zjZw
 gnQeFe8d/m2/jtQmlvrTXGH+CRWTvLJ99AJ9ZBbujQBVw7NrmDrl+EZrnMDE9pdXVPbdC4Pdu
 3oiTbZzF+dTxygVh53Qi4WFBoOTGnUy95CmZ74+NGqxicggQvmY1HBFCtezjvtMQsINtLCdKF
 kcsopx7wdhPZSfSmMHfSXCXpecMvLsJ0iqAbhEnVenNRWdxjSnZ3Ai2FdDgkq3LdPiTslXUyo
 7GT0XE0RjCrpJvjTEA14jlNRVZ4hOdsDyubu6D580Hy9JcmFeEBrPy//cbMKtdFqKlDaKkLTu
 IpzCWNaI3cWS78c46PTaiw2piANJPX0mdS5ra2rgh/9D61XkeS2eW0b4B+Ua6EGgAcqeQ5ptj
 SEFWViX0iQZtKEh3qNEFnEsXlAoLuHdHSvP4Z7in2EDww/xiEn6pLRiatOaPjRJmz1e2qU5h2
 kriBK0EZJNoJrsfR74J7DT4ZSz5S9S6sAGSza0F3EzLa3YIPBWfnMbVZ3ENyaQsNxfwH31osc
 J4kGAuZieWcrPVsptYBshh6u/ldR/gsmRI4Z4C8/p0slYkHX3XvtwoJWS2mEh/SOCaqycSXq3
 yada+h+S/KhqQRDNoueJNf1ka5ZaYJuet0YmdpOoj0r5oY30WIH5dX9+pf5eHR8iLg3eRipmw
 8mTNHksQK0HvivmBnlzw==
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Fri, Oct 15, 2021 at 2:56 AM Alistair Francis
<alistair.francis@opensource.wdc.com> wrote:
>
> From: Alistair Francis <alistair.francis@wdc.com>
>
> Convert the futex selftests to only use a 64-bit time_t. On 64-bit
> architectures this isn't a functional change. On 32-bit architectures
> we now only perform 64-bit time_t syscalls (__NR_futex_time64) and
> use a struct timespec64.
>
> This won't work on kernels before 5.1, but as perf is tied to the kernel
> that's ok.
>
> This allows the tests to run and pass on RISC-V 32-bit.
>
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>

Reviewed-by: Arnd Bergmann <arnd@arndb.de>
