Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AADEC433EF
	for <linux-perf-users@archiver.kernel.org>; Wed, 20 Oct 2021 01:56:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 61A1861156
	for <linux-perf-users@archiver.kernel.org>; Wed, 20 Oct 2021 01:56:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230005AbhJTB6y (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 19 Oct 2021 21:58:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230061AbhJTB6w (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 19 Oct 2021 21:58:52 -0400
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74F7BC06174E;
        Tue, 19 Oct 2021 18:56:39 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id e144so22711337iof.3;
        Tue, 19 Oct 2021 18:56:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=DFVDY1TJPfx7Pv2rJU4HCu/PwzjdV9E9KpImILjaAsk=;
        b=NUcLe5roZ29vnvGWcS+csTcdd3v6W8cSjAFujWc8dr4t1VqRmtvSmPRpV8mWXKdued
         tXexRLFSyJ51ctf76vfQ41AAymfkz7iT1AVmSrAonT2b2xqtN+q7qFVxEdwTDPGyE/QK
         xtAsa2N8Co0Xs9WUYEYXm80WFhq7exVuUvorFmWYYISBWRaSrh8CtlA+jVSSoZ8xwVql
         WltprzlDWEtoy/Ci1nCvndvwENwo6eYCUJn5GWICtiEcNDFttXzc07B7r7m4DTrIz6ni
         Q+PxbAiccUIdApujy66OZcfc0zvRPVwQO9G3ayAwTEJgAxaUbyjHcHRrrOeobnzh/YaP
         o8wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=DFVDY1TJPfx7Pv2rJU4HCu/PwzjdV9E9KpImILjaAsk=;
        b=4hW5ZbPyMuzramVoPcsMlovzgs2B6T5T8dsRVAULtENhPFNAGf0L/s+4d2mn49JFue
         0X4wOaSa7r02+uyMvbqAji9/rqmp5Bclewrozzb48x68LnScXdMjC7YTzE7VcmUd7Cvo
         T/LV3tUynSWG5GJmgBO4HP6t/7lGm43bLkIrdR6K4k7f3Ql1ODEi/N38c8tmMqCCSfAP
         Jj4G3/1G5msCY4hjWyCSZw0sOvptLsbvYJrQ7Gg5Jk+JqpG0ehA+R3PkN6VSl0d9xc4f
         C5MCpA0nmyuWUEO+rtahjd3ZwWfLE7zBsblxPQtEFX/t8dP8fDVvVQ4B2etmZtM/Gjot
         buFQ==
X-Gm-Message-State: AOAM533ro2M6cvkZKTYrOHl5HxjKAfO8DHGH/nRmLIUw8Fak9VuUskHG
        mbHnL6nYP1Ai5x/RqwY3rAnnRczbAoHu0afkQMg=
X-Google-Smtp-Source: ABdhPJwDNbtfj+34pBOJjmx8T8tmETtM9BhtTtPAPHE6GTvRprbadPwkvaoiHNh3AW9RvFjv0nA4rZLRKD2BUN7a3PY=
X-Received: by 2002:a05:6638:1192:: with SMTP id f18mr6661747jas.114.1634694998856;
 Tue, 19 Oct 2021 18:56:38 -0700 (PDT)
MIME-Version: 1.0
References: <20211015005634.2658470-1-alistair.francis@opensource.wdc.com>
 <YW74wK03ibOS3jVZ@kernel.org> <CAKmqyKP6AU-9tcYOp-ERvYFP7t6DMp4kbQgDmJxD6wb0WTUy+w@mail.gmail.com>
 <0d55b0a0-dd8c-0494-a200-7acb1976e32a@collabora.com>
In-Reply-To: <0d55b0a0-dd8c-0494-a200-7acb1976e32a@collabora.com>
From:   Alistair Francis <alistair23@gmail.com>
Date:   Wed, 20 Oct 2021 11:56:12 +1000
Message-ID: <CAKmqyKNZAkxO_QQ2oTYp1JK0q0GxZ1iQdsmKW==mkOHbacPE1g@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] perf bench futex: Use a 64-bit time_t
To:     =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@collabora.com>
Cc:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        Alistair Francis <alistair.francis@opensource.wdc.com>,
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

On Wed, Oct 20, 2021 at 10:01 AM Andr=C3=A9 Almeida
<andrealmeid@collabora.com> wrote:
>
> =C3=80s 20:17 de 19/10/21, Alistair Francis escreveu:
> > On Wed, Oct 20, 2021 at 2:56 AM Arnaldo Carvalho de Melo
> > <arnaldo.melo@gmail.com> wrote:
> >>
> >> Em Fri, Oct 15, 2021 at 10:56:33AM +1000, Alistair Francis escreveu:
> >>> From: Alistair Francis <alistair.francis@wdc.com>
> >>>
> >>> Convert tools/perf to only use a 64-bit time_t. On 64-bit architectur=
es
> >>> this isn't a functional change. On 32-bit architectures we now only
> >>> perform 64-bit time_t syscalls (__NR_futex_time64) and use a struct
> >>> timespec64.
> >>>
> >>> This won't work on kernels before 5.1, but as perf is tied to the ker=
nel
> >>> that's ok.
> >>
> >> No, perf is not tied to the kernel, one can use a new perf tool on any
> >> previous kernel, and an old perf tool should work on new kernels as
> >> well.
> >
> > + Andr=C3=A9, I won't be doing this the way you requested
> >
>
> Ok, thanks anyway for your work and sorry for the trouble :)

No worries!

Alistair
