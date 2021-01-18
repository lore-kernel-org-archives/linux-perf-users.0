Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32021C433E6
	for <linux-perf-users@archiver.kernel.org>; Mon, 18 Jan 2021 15:46:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EA25122C7E
	for <linux-perf-users@archiver.kernel.org>; Mon, 18 Jan 2021 15:46:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406005AbhARPer (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 18 Jan 2021 10:34:47 -0500
Received: from mail-ed1-f47.google.com ([209.85.208.47]:41092 "EHLO
        mail-ed1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405992AbhARPeT (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 18 Jan 2021 10:34:19 -0500
Received: by mail-ed1-f47.google.com with SMTP id bx12so4030615edb.8
        for <linux-perf-users@vger.kernel.org>; Mon, 18 Jan 2021 07:34:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=rR9roZIqrLGag/PtFNc1IIMQg0OQPGVvI2efiyqTDEw=;
        b=YMq7kXsantuIqdzpPafCATZHJgfUtEe9dVXWCoj89BSP9HSwahpt4rvGj+FdbeRgtw
         bzvGj4mEnBneM1LxvrE1chmKik3F8qmRyaEV/hptnNdAND565mBOikWhMt2ALUwEaG9v
         kuPzgRseUqMA6FtToZAUjqWZLPUZQIF28k/jHecHp7nPC4o8qqgs9fAjH5oTl7dJSzcX
         cqHZyYM47uSMoljGHntqTpHz17/IO69F/T6HYKB+/WC6Si90fB0ydSzpF9sCQ+JkL9Vp
         BSBaKLWEwsLhyU3AWVxYyCkIx620/HoCcPlqITNO+dT5mEI6Yfao1DP8l1aERqFWLjqy
         VKBw==
X-Gm-Message-State: AOAM530lu6ENnWWMtt4iBJqxWkUeXhdEITraqX5goWuM9cxNCdb6oYGp
        q1nLzweK7p4MZUoOd45oddegEWOnvsYJNJKO
X-Google-Smtp-Source: ABdhPJypeB+3/kIpsdPrKXLa2tZNphIY88uTWvgcGxp9zTCIkIMMVA403rs6ZVAmzDpdQV4ndGRYRw==
X-Received: by 2002:a50:8b61:: with SMTP id l88mr37909edl.250.1610984014461;
        Mon, 18 Jan 2021 07:33:34 -0800 (PST)
Received: from ingrassia.epigenesys.com ([2.236.81.180])
        by smtp.gmail.com with ESMTPSA id c24sm8536677edt.74.2021.01.18.07.33.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Jan 2021 07:33:33 -0800 (PST)
Date:   Mon, 18 Jan 2021 16:33:31 +0100
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
Message-ID: <YAWqS9YZ0rpXPoSN@ingrassia.epigenesys.com>
References: <CAK8P3a0dJnKiX5minsUNdAcNnxPvZkyK363f1ibj_x0L2MQiPQ@mail.gmail.com>
 <YAVynNqAwBt5GzQT@ingrassia.epigenesys.com>
 <CAK8P3a33i2r0xx==3hTW32pc_Sm33EMDXYAS4PtEaEV8DX4s_A@mail.gmail.com>
 <YAWaQVBM84CaY1B2@ingrassia.epigenesys.com>
 <YAWg6KQt6hAtIR6O@ingrassia.epigenesys.com>
 <CAK8P3a3Vc4wrLvrfwkHd6HCMohk07Yi6P_jKaC_5AybCMBNjPA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a3Vc4wrLvrfwkHd6HCMohk07Yi6P_jKaC_5AybCMBNjPA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Hi Arnd,

On Mon, Jan 18, 2021 at 04:19:47PM +0100, Arnd Bergmann wrote:
> On Mon, Jan 18, 2021 at 3:53 PM Emiliano Ingrassia
> <ingrassia@epigenesys.com> wrote:
> >
> > Hi,
> >
> > after some searching I found this patch from Yocto project:
> >
> > https://www.mail-archive.com/linux-yocto@lists.yoctoproject.org/msg01004.html.
> >
> > I don't know if it's ever been proposed as mainline patch.
> >
> > What do you think about it? Could it be the right solution?
>
> No. While this makes it work on rv32, it does not fix it in a
> way that makes it work on other architectures with a time64
> libc. If you fix it, please do it in a way that works on all architectures.

Ok, I totally agree with you on this point.

So, it is right to conclude that the problem is not in perf
implementation but in the libc implementation?
That is, for example, glibc should define SYS_futex as SYS_futex_time64
in case of riscv 32 bit because of its support to 64 bit time_t?

>
> I had really expected both Alistair and Khem to know better.
>
>       Arnd

Thank you, best regards.

Emiliano
