Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE5F8C00140
	for <linux-perf-users@archiver.kernel.org>; Sun, 31 Jul 2022 12:37:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232548AbiGaMhN (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Sun, 31 Jul 2022 08:37:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236863AbiGaMhM (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Sun, 31 Jul 2022 08:37:12 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E55ACDFA4
        for <linux-perf-users@vger.kernel.org>; Sun, 31 Jul 2022 05:37:10 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id 8-20020a05600c024800b003a2fe343db1so4415217wmj.1
        for <linux-perf-users@vger.kernel.org>; Sun, 31 Jul 2022 05:37:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=zxVdgJ1vux8TImW4FL6YxoljQySxzKuzGy0keBd2VZs=;
        b=hrxQFkCZKXjrqETbsKn775YJhevjC8fXOkPKFmvJIwughHVOAc0Va5Ye54CexdAbjU
         NhRt1YEQDznNumcmFp+UjMxYVDOd404Js2SfF+oFtYKBQ6e3hYH3OBK4n9xTE3fhv98R
         lZkK6e+f0bQT3XIG/Gy7kuPsY5HPUKvXcyx/xBlGA4cKrnNLhPeYY4Xurza93Y05b39F
         RP6aSFjh+LEzSrMZNZ+Y2TvrVZwiB8bkiKs7Q2c+mBODFvezaRUw8S51st6XhCRQF5t2
         uQn90+eK9GQQP4KDnBO102rdeHEXrvk98b4fp9W6BJ3vK+/7lVVolXTt5vGCjMTW6s5w
         QO2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=zxVdgJ1vux8TImW4FL6YxoljQySxzKuzGy0keBd2VZs=;
        b=BzJ2TnFiVmFSKmcWkvNUhk0RuoisUJANxXC3T3oNZLFBjJAHUcj0m8ETHj6kWTgkEn
         7ALG1JdHOt9dHuS5lFaPPySq51IUJISIw6JhMTqzj/ocUB6g+4rUnVBMaNtwQrEMqNVw
         IqmJaRLReY98AQicAoev9VtrMC3s0GTSrVgwkjQHBPHgZxz8O8hwWa2G1vMjavRj0Frl
         SBHK5H6wPY4wJEpIz9aZRQltQzc+oyrHvKrsSng0CFLWVCLVK7E4SjDKKgvWTPl0eL3N
         Csqau1NzV5Pqip9XJcvtVk9HEaxtikb6yyVtWTvfNjKyKa5LDaKOgtQPGz9tCv1dTcH2
         ohYA==
X-Gm-Message-State: AJIora+s/3b90K1dmvzmAuNnSYNd97gRx2fKbDHHLhPAjdjm70DYQ7KZ
        D1JE1Q/RWOIWBTeUm37d8CtVqw==
X-Google-Smtp-Source: AGRyM1uiZQBU3njm4/rwDhMvt2ByyGuE7PQ1bFjwUy9QZiIxSdge1D+P60ZNqQre1WQneMtuWhlx4A==
X-Received: by 2002:a05:600c:2652:b0:3a3:2a3e:a2de with SMTP id 18-20020a05600c265200b003a32a3ea2demr8460316wmy.174.1659271029326;
        Sun, 31 Jul 2022 05:37:09 -0700 (PDT)
Received: from leoy-ThinkPad-X240s ([167.71.129.183])
        by smtp.gmail.com with ESMTPSA id n186-20020a1ca4c3000000b003a2d87aea57sm15175048wme.10.2022.07.31.05.37.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 Jul 2022 05:37:08 -0700 (PDT)
Date:   Sun, 31 Jul 2022 20:37:02 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Ian Rogers <irogers@google.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Fangrui Song <maskray@google.com>,
        Chang Rui <changruinj@gmail.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] perf symbol: Correct address for bss symbols
Message-ID: <20220731123702.GA205142@leoy-ThinkPad-X240s>
References: <20220724060013.171050-1-leo.yan@linaro.org>
 <20220724060013.171050-2-leo.yan@linaro.org>
 <CAP-5=fVY=_WUpke0sRMpvbJFu9JuYwqiwAmKdCS+=u7vEG-2uA@mail.gmail.com>
 <20220730093819.GA574473@leoy-ThinkPad-X240s>
 <CAP-5=fWA8R9Ee5L9xgPtva9dvQ12uKqC1o4zgzPs0B9XWSMxhQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP-5=fWA8R9Ee5L9xgPtva9dvQ12uKqC1o4zgzPs0B9XWSMxhQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Sat, Jul 30, 2022 at 08:21:10AM -0700, Ian Rogers wrote:

[...]

> > On the other hand, I can accept to simply change pr_warning() to
> > pr_debug4() to avoid warning flood, the log still can help us to find
> > potential symbol parsing issue, so far they are not false-positive
> > reporting.
> 
> Thanks, I suspect the ELF that the Java agent has created isn't good.
> The Java agent is part of perf as and so is the ELF file generation
> code:
> https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git/tree/tools/perf/util/genelf.c?h=perf/core#n367

I think it's no need to change the function jit_write_elf(), please see
below comment.

> I took a quick look but most of the logic is in libelf - it seems less
> obvious the bug would be there rather than perf. Could you take a
> look? Ideally there'd be a quick fix that keeps all the benefits of
> your change and the jvmti code working.

A bit more finding for java JIT symbols.  Let's see below two samples:

     6.72%  java             /home/leoy/.debug/jit/java-jit-20220731.XXKRpgmR/jitted-214330-29.so    0x5b54             B [.] Interpreter
     0.90%  java             /home/leoy/.debug/jit/java-jit-20220731.XXKRpgmR/jitted-214330-3475.so  0x4fc              B [.] jdk.internal.math.FloatingDecimal$BinaryToASCIIBuffer.dtoa(int, long, int, boolean)

I can see the DSO "jitted-214330-29.so" only contains a java JIT symbol
"Interpreter", and I also observed the same behavior for other JIT
symbols, e.g. jitted-214330-3475.so only contains the symbol
"jdk.internal.math.FloatingDecimal$BinaryToASCIIBuffer.dtoa(int, long,
int, boolean)".

We always see these JIT symbols always have the consistent start file
address, but this would not introduce conflit since every JIT symbol has
its own DSO rather than share the same DSO.

I think now I understand your meaning, and your below change is fine for
me, I tested it and confirmed it can show up java JIT symbols properly.
Just a comment, it would be better to add a comment for why we need to
add symbols when failed to find program header, like:

  if (elf_read_program_header(syms_ss->elf,
                            (u64)sym.st_value, &phdr)) {
        pr_debug4("%s: failed to find program header for "
                  "symbol: %s\n", __func__, elf_name);
        pr_debug4("%s: adjusting symbol: st_value: %#" PRIx64 " "
                  "sh_addr: %#" PRIx64 " sh_offset: %#" PRIx64 "\n",
                  __func__, (u64)sym.st_value, (u64)shdr.sh_addr,
                  (u64)shdr.sh_offset);
        /*
         * Fail to find program header, let's rollback to use shdr.sh_addr
         * and shdr.sh_offset to calibrate symbol's file address, though
         * this is not necessary for normal C ELF file, we still need to
         * handle java JIT symbols in this case.
         */
        sym.st_value -= shdr.sh_addr - shdr.sh_offset;
  } else {
        ...
  }

Could you send a formal patch for this?  Thanks!

Leo

> > Thanks,
> > Leo
> >
> > > ```
> > > --- a/tools/perf/util/symbol-elf.c
> > > +++ b/tools/perf/util/symbol-elf.c
> > > @@ -1305,16 +1305,21 @@ dso__load_sym_internal(struct dso *dso, struct
> > > map *map, struct symsrc *syms
> > > _ss,
> > >
> > >                        if (elf_read_program_header(syms_ss->elf,
> > >                                                    (u64)sym.st_value, &phdr)) {
> > > -                               pr_warning("%s: failed to find program
> > > header for "
> > > +                               pr_debug4("%s: failed to find program
> > > header for "
> > >                                           "symbol: %s st_value: %#" PRIx64 "\n",
> > >                                           __func__, elf_name,
> > > (u64)sym.st_value);
> > > -                               continue;
> > > +                               pr_debug4("%s: adjusting symbol:
> > > st_value: %#" PRIx64 " "
> > > +                                       "sh_addr: %#" PRIx64 "
> > > sh_offset: %#" PRIx64 "\n",
> > > +                                       __func__, (u64)sym.st_value,
> > > (u64)shdr.sh_addr,
> > > +                                       (u64)shdr.sh_offset);
> > > +                               sym.st_value -= shdr.sh_addr - shdr.sh_offset;
> > > +                       } else {
> > > +                               pr_debug4("%s: adjusting symbol:
> > > st_value: %#" PRIx64 " "
> > > +                                       "p_vaddr: %#" PRIx64 "
> > > p_offset: %#" PRIx64 "\n",
> > > +                                       __func__, (u64)sym.st_value,
> > > (u64)phdr.p_vaddr,
> > > +                                       (u64)phdr.p_offset);
> > > +                               sym.st_value -= phdr.p_vaddr - phdr.p_offset;
> > >                        }
> > > -                       pr_debug4("%s: adjusting symbol: st_value: %#"
> > > PRIx64 " "
> > > -                                 "p_vaddr: %#" PRIx64 " p_offset: %#"
> > > PRIx64 "\n",
> > > -                                 __func__, (u64)sym.st_value,
> > > (u64)phdr.p_vaddr,
> > > -                                 (u64)phdr.p_offset);
> > > -                       sym.st_value -= phdr.p_vaddr - phdr.p_offset;
> > >                }
> > >
> > >                demangled = demangle_sym(dso, kmodule, elf_name);
> > > ```
> > >
> > > Thanks,
> > > Ian
> > >
> > > >
> > > >                 demangled = demangle_sym(dso, kmodule, elf_name);
> > > > --
> > > > 2.25.1
> > > >
