Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F178C433E0
	for <linux-perf-users@archiver.kernel.org>; Mon, 18 Jan 2021 14:26:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4BAD122B39
	for <linux-perf-users@archiver.kernel.org>; Mon, 18 Jan 2021 14:26:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404948AbhAROZ6 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 18 Jan 2021 09:25:58 -0500
Received: from mail-ed1-f52.google.com ([209.85.208.52]:45153 "EHLO
        mail-ed1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405004AbhAROZu (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 18 Jan 2021 09:25:50 -0500
Received: by mail-ed1-f52.google.com with SMTP id f1so3666833edr.12
        for <linux-perf-users@vger.kernel.org>; Mon, 18 Jan 2021 06:25:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=tXeJJWsCyqK60w5Z6x+WKsWIdxKogluACLg9uk+9u/A=;
        b=s5H9ouDzTcnX/o6CQ+xLUsuUtTDvnxHao41/aQkfGKm5I1WjJdIxwfVjeb/8dFMLLu
         qlVl9t6wwc/MMt4LRiHVoVAuhEtKMw8GcfOVWt3dfqAfijld9qBB30kjYu7dAgqnA5M7
         FZUI4wl1xhJu0UB+hoU57uYyurjh5KP/zBh9jl8/A3DcO2kvque2/qvJyFjlhBP7fdtX
         BNORuJzGgsxUBUERMIRJPxjd8JOZYEVuITeO493Iv7lsOizsOCTSHQm3B64YpnA74BCo
         X2K5gCz1+kbIJEIKf+pN0piA/mYOOEePmbDteEctgiVAH4Bn0RqU8IKSgssKDpAl780z
         YaUQ==
X-Gm-Message-State: AOAM53173sK3s3xTxZiv9dl6yGKBJzxdOzWyPzrTfn7Lfi4MB/5zqmd2
        Wo3rw5awTJDisfkx8XdSVRY=
X-Google-Smtp-Source: ABdhPJyJonQfq4dR5p6Mj5Zgx9vm+yzqSYAxG3mTaVqSAanhZ3cDMtEixcbOExsA8BXA9NDfjUMqMA==
X-Received: by 2002:aa7:dd16:: with SMTP id i22mr1534456edv.215.1610979908177;
        Mon, 18 Jan 2021 06:25:08 -0800 (PST)
Received: from ingrassia.epigenesys.com ([2.236.81.180])
        by smtp.gmail.com with ESMTPSA id s22sm9293354ejd.106.2021.01.18.06.25.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Jan 2021 06:25:07 -0800 (PST)
Date:   Mon, 18 Jan 2021 15:25:05 +0100
From:   Emiliano Ingrassia <ingrassia@epigenesys.com>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv <linux-riscv@lists.infradead.org>
Subject: Re: perf tools build broken for RISCV 32 bit
Message-ID: <YAWaQVBM84CaY1B2@ingrassia.epigenesys.com>
References: <CAK8P3a0dJnKiX5minsUNdAcNnxPvZkyK363f1ibj_x0L2MQiPQ@mail.gmail.com>
 <YAVynNqAwBt5GzQT@ingrassia.epigenesys.com>
 <CAK8P3a33i2r0xx==3hTW32pc_Sm33EMDXYAS4PtEaEV8DX4s_A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a33i2r0xx==3hTW32pc_Sm33EMDXYAS4PtEaEV8DX4s_A@mail.gmail.com>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Hi Arnd,

thank you for the quick reply and support.

On Mon, Jan 18, 2021 at 12:56:11PM +0100, Arnd Bergmann wrote:
> On Mon, Jan 18, 2021 at 12:35 PM Emiliano Ingrassia
> <ingrassia@epigenesys.com> wrote:
> > |#if __WORDSIZE == 32
> > |/* Workarounds for generic code needing to handle 64-bit time_t.
> > |...
> > |/* Fix sysdeps/nptl/lowlevellock-futex.h.  */
> > |#define __NR_futex              __NR_futex_time64
> >
> > a possible solution to fix the build of perf tool on RISCV 32 bit could
> > be the following patch to file tools/arch/riscv/include/uapi/asm/unistd.h:
> > |+
> > |+#ifndef __NR_futex
> > |+#define __NR_futex __NR_futex_time64
> > |+#endif
> >
> > What do you think about it? Could it be a correct solution?
>
> No, that would be much worse: __NR_futex must only ever point
> to the system call that takes the old timespec argument. If you define
> something like this, it breaks applications that try to do the right thing.
>
>        Arnd

OK, but what should be the right solution for RISCV 32 bit in this case?
Is it a problem in the libc implementation or in RISCV/perf implementation?

Thank you, best regards.

Emiliano
