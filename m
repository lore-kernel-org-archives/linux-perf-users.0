Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CC10C433E0
	for <linux-perf-users@archiver.kernel.org>; Mon, 18 Jan 2021 14:54:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C80F722C9C
	for <linux-perf-users@archiver.kernel.org>; Mon, 18 Jan 2021 14:54:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405179AbhAROyY (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 18 Jan 2021 09:54:24 -0500
Received: from mail-ej1-f41.google.com ([209.85.218.41]:33264 "EHLO
        mail-ej1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405310AbhAROyN (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 18 Jan 2021 09:54:13 -0500
Received: by mail-ej1-f41.google.com with SMTP id by1so17663943ejc.0
        for <linux-perf-users@vger.kernel.org>; Mon, 18 Jan 2021 06:53:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=1xTRKse7osHgIKS25g76CTiBG9i3MeX+/FioK4cdoWE=;
        b=VwCwVmnRkgkucyDbaxWTLwFDn1QJF9kB/A3vsvANIyfLeIzJ3/JoSJTTdHmfGgsbOM
         j6LcfHbSlybtI4GHhFWo7F8smW5t1ibZhZgIB0qc+USE4UqacTPbDwCRFRfX2CTMH/8R
         +VJZIa+p2ba0UAbWm83sTUAXo1hnlKFIc+CDpvb1N9mfa+QqT+3Dus6X2IisIYTAHw49
         nkEMHcLe45gh8XIGVASMH80zNsAPjLRWvbWwW8gNAhffzMPEE37a6GVXybI74Dwvchey
         wyL5AhOGsOBVUVfzgunUKBrlmaHXkblsv39eIM12i++SdHJtopFuG3oBdTpY0MRyBLj3
         7Rjg==
X-Gm-Message-State: AOAM532hTlnQoayiwZDGK8F6GfymovsWmaozoOUNpB7JPt1Q2qWAxC2L
        KlyRLO2s/8iOmdI1Xwv4yk1+exVA9ZtzHs4J
X-Google-Smtp-Source: ABdhPJzC14YEWSfUq7eVgejD8YemgJXRPhQTquMgsQeEqmDax+/dDHZv2u+GxBjT7rrqvdU288u+ew==
X-Received: by 2002:a17:906:5e45:: with SMTP id b5mr48969eju.69.1610981611561;
        Mon, 18 Jan 2021 06:53:31 -0800 (PST)
Received: from ingrassia.epigenesys.com ([2.236.81.180])
        by smtp.gmail.com with ESMTPSA id b26sm5633344edy.57.2021.01.18.06.53.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Jan 2021 06:53:30 -0800 (PST)
Date:   Mon, 18 Jan 2021 15:53:28 +0100
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
Message-ID: <YAWg6KQt6hAtIR6O@ingrassia.epigenesys.com>
References: <CAK8P3a0dJnKiX5minsUNdAcNnxPvZkyK363f1ibj_x0L2MQiPQ@mail.gmail.com>
 <YAVynNqAwBt5GzQT@ingrassia.epigenesys.com>
 <CAK8P3a33i2r0xx==3hTW32pc_Sm33EMDXYAS4PtEaEV8DX4s_A@mail.gmail.com>
 <YAWaQVBM84CaY1B2@ingrassia.epigenesys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YAWaQVBM84CaY1B2@ingrassia.epigenesys.com>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Hi,

after some searching I found this patch from Yocto project:

https://www.mail-archive.com/linux-yocto@lists.yoctoproject.org/msg01004.html.

I don't know if it's ever been proposed as mainline patch.

What do you think about it? Could it be the right solution?

Thank you, best regards.

Emiliano

On Mon, Jan 18, 2021 at 03:25:05PM +0100, Emiliano Ingrassia wrote:
> Hi Arnd,
>
> thank you for the quick reply and support.
>
> On Mon, Jan 18, 2021 at 12:56:11PM +0100, Arnd Bergmann wrote:
> > On Mon, Jan 18, 2021 at 12:35 PM Emiliano Ingrassia
> > <ingrassia@epigenesys.com> wrote:
> > > |#if __WORDSIZE == 32
> > > |/* Workarounds for generic code needing to handle 64-bit time_t.
> > > |...
> > > |/* Fix sysdeps/nptl/lowlevellock-futex.h.  */
> > > |#define __NR_futex              __NR_futex_time64
> > >
> > > a possible solution to fix the build of perf tool on RISCV 32 bit could
> > > be the following patch to file tools/arch/riscv/include/uapi/asm/unistd.h:
> > > |+
> > > |+#ifndef __NR_futex
> > > |+#define __NR_futex __NR_futex_time64
> > > |+#endif
> > >
> > > What do you think about it? Could it be a correct solution?
> >
> > No, that would be much worse: __NR_futex must only ever point
> > to the system call that takes the old timespec argument. If you define
> > something like this, it breaks applications that try to do the right thing.
> >
> >        Arnd
>
> OK, but what should be the right solution for RISCV 32 bit in this case?
> Is it a problem in the libc implementation or in RISCV/perf implementation?
>
> Thank you, best regards.
>
> Emiliano
