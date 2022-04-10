Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7350AC433F5
	for <linux-perf-users@archiver.kernel.org>; Sun, 10 Apr 2022 15:15:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236729AbiDJPRZ (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Sun, 10 Apr 2022 11:17:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232745AbiDJPRY (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Sun, 10 Apr 2022 11:17:24 -0400
Received: from mail-oa1-x2f.google.com (mail-oa1-x2f.google.com [IPv6:2001:4860:4864:20::2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4B7729807
        for <linux-perf-users@vger.kernel.org>; Sun, 10 Apr 2022 08:15:13 -0700 (PDT)
Received: by mail-oa1-x2f.google.com with SMTP id 586e51a60fabf-df02f7e2c9so14685930fac.10
        for <linux-perf-users@vger.kernel.org>; Sun, 10 Apr 2022 08:15:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AykdxVkfek06fjXsLB9I2IRHzCOJ6nIrMbEtU2HTEq0=;
        b=A/nT1N5myhjcL/iH9Bw8eSo2yqIZp8xF1pBJy3wtyHqPNG0WBG5cVpRDBWUYwMadtc
         b6qXuao0UknR6L+QodumzaDlSmugfdvmQP65aTADnopUAQXHTAOPV0n5bGv3V96CxbbR
         V7P3W3C0wdGHBaxOMjM5uS1J1SN5DIw0YcSgR7XqrtddyoBNzZgcTQBQvdE/DQxMLYn/
         up01o53v/D+e1NyNX24m3Ff3TVZxISLbThUtbw7CnWvIPL36ujBBVMqKm9CwPuNnMJbN
         SzW9907FEjhnSyXOfFmBNbSiD1OxjakTAJsNxqr6cE6JXGrwYQdSRcegbFqdhUXYJdyE
         YGJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AykdxVkfek06fjXsLB9I2IRHzCOJ6nIrMbEtU2HTEq0=;
        b=F+iwFpj2FXVdZRQSCszUmIR42D1lbjUrcF34SGJQ6CJ4vQq4IFcPrpQ0THyxXDt+eg
         DQeA0pP6GWrbObeZpalOqNU2ErldefGhjM3bcRbdtBAgwRL72BKSOVICPp175B52JgYI
         ZVdeC8nbpgn9veIh81UyUYzXwapadMC4XgeP1uv+0LQAppLcwI56RWexURiQwGO2JiHp
         jvDszPXAmZ7f6LZxGE5/ZRUhL0wGtat+bw/IkR6urWNLh67GbOaD6uDfnmW+kF9NmI+D
         T/lSXGnJN5PCCJGiw3J8lKNUEdkZpimwIteT0yTeisMNv5fxbijoKEREc62uetlosdB5
         +VZw==
X-Gm-Message-State: AOAM531nkfd4ibzg6u1aXt9zAvFyORnGn8qCnttJOAlUzsHsk1FfvuVq
        d3dKTIiQdeZLzYUfpQgwRcWz6awTUdAuOH4yu2fMgQ==
X-Google-Smtp-Source: ABdhPJw4JlX7XrQmjaKV9AkjsvEklgyp/+SYdmSxL3OSV1KqjDA84a+/qb1G0521cTO8XAEfbAt1IhBKhpUfEDvvMME=
X-Received: by 2002:a05:6870:b021:b0:e1:dc43:9000 with SMTP id
 y33-20020a056870b02100b000e1dc439000mr12076705oae.172.1649603713127; Sun, 10
 Apr 2022 08:15:13 -0700 (PDT)
MIME-Version: 1.0
References: <20220406142606.18464-1-eric.lin@sifive.com> <20220406142606.18464-2-eric.lin@sifive.com>
 <YlGgro3TupbOEnJC@kernel.org>
In-Reply-To: <YlGgro3TupbOEnJC@kernel.org>
From:   Eric Lin <eric.lin@sifive.com>
Date:   Sun, 10 Apr 2022 23:15:01 +0800
Message-ID: <CAPqJEFrh71h-UZF1=TQKWTrsL84R=nzoBTieAw6rtoyBbu7kRQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] perf jitdump: Add riscv64 support.
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        jolsa@kernel.org, Namhyung Kim <namhyung@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>, aou@eecs.berkeley.edu,
        iii@linux.ibm.com, linux-perf-users@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Greentime Hu <greentime.hu@sifive.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Hi Arnaldo,

On Sat, Apr 9, 2022 at 11:05 PM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> Em Wed, Apr 06, 2022 at 10:26:06PM +0800, Eric Lin escreveu:
> > Signed-off-by: Eric Lin <eric.lin@sifive.com>
>
> Can you plese provide some series of commands demonstrating the usage of
> this functionality on riscv?
>
> A dump, for instance.
>
> - Arnaldo
>

OK, I got it. I'll show the series of commands in the commit message
in v2 patch.
Thanks.

> > ---
> >  tools/perf/arch/riscv/Makefile | 1 +
> >  tools/perf/util/genelf.h       | 3 +++
> >  2 files changed, 4 insertions(+)
> >
> > diff --git a/tools/perf/arch/riscv/Makefile b/tools/perf/arch/riscv/Makefile
> > index 1aa9dd772489..a8d25d005207 100644
> > --- a/tools/perf/arch/riscv/Makefile
> > +++ b/tools/perf/arch/riscv/Makefile
> > @@ -2,3 +2,4 @@ ifndef NO_DWARF
> >  PERF_HAVE_DWARF_REGS := 1
> >  endif
> >  PERF_HAVE_ARCH_REGS_QUERY_REGISTER_OFFSET := 1
> > +PERF_HAVE_JITDUMP := 1
> > diff --git a/tools/perf/util/genelf.h b/tools/perf/util/genelf.h
> > index 3db3293213a9..ae138afe6c56 100644
> > --- a/tools/perf/util/genelf.h
> > +++ b/tools/perf/util/genelf.h
> > @@ -38,6 +38,9 @@ int jit_add_debug_info(Elf *e, uint64_t code_addr, void *debug, int nr_debug_ent
> >  #elif defined(__s390x__)
> >  #define GEN_ELF_ARCH EM_S390
> >  #define GEN_ELF_CLASS        ELFCLASS64
> > +#elif defined(__riscv) && __riscv_xlen == 64
> > +#define GEN_ELF_ARCH EM_RISCV
> > +#define GEN_ELF_CLASS        ELFCLASS64
> >  #else
> >  #error "unsupported architecture"
> >  #endif
> > --
> > 2.35.1
>
> --
>
> - Arnaldo
