Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16EF1C433EF
	for <linux-perf-users@archiver.kernel.org>; Thu, 26 May 2022 04:25:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234261AbiEZEZ4 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 26 May 2022 00:25:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbiEZEZz (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 26 May 2022 00:25:55 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AAB4DEC6
        for <linux-perf-users@vger.kernel.org>; Wed, 25 May 2022 21:25:54 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id i9so597789wrc.13
        for <linux-perf-users@vger.kernel.org>; Wed, 25 May 2022 21:25:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2SipPpIt3Uy45y73d1Z2qzdhwEBd/+w29uEixsKZKTE=;
        b=fdm6HvBXsl1Oe84zJlp6wX8Gcj9UvtPfdjFfSAuwJAugaAZtCN1Z04eT3IXmhQ1n+P
         SI1FTeysi5aYDJe8hZiAwUVjPk4gYJvZfC1xrT5wiGSwJqn2jXp9pFQ3C2eKIiz7Tqcb
         ne0r3xTfFQ3eziEx/ZNdNS+c70q/XJSqsI1bjQDAALGNfy66BQRFa1gLMlpf3qO3kaIL
         Y0X0rYcZPyQYLnh0J6B0GJ30xro5ujJX46S1748eE4PTq/Raph2/Dc6deQ7X8lnf0Att
         xV53eLtqDI+pi5SBsBmC426q8WU+sAWAIIMP1cYBLhH4jSDUYzkhbBm35g8S12Ia4ovF
         pogA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2SipPpIt3Uy45y73d1Z2qzdhwEBd/+w29uEixsKZKTE=;
        b=fEIUBoovhDcbCfn+owcjQpeYDQkMqyl0mK3NEnrqdUteI557qyQN2y+rBwhbOt69n9
         kvCwY6JSg4iHV671HyixHYMIwg2dfYF3ESXclylJn5zVcEQ+frMTCU0vlecW0q4xrHIl
         yI/4k0cSLJFDUVTntlip6B7yxMtb/onVN2XIGalQaiA4YLdtOkhxAFRCt8c/YlaqpzHA
         CfkwLvmpQLHhUz4Tyr1B9t6Sytqcs8DhtdDSsQucT4DY51mSHFMDYIW90wrVuyMLeZWZ
         smBzxTon01c82qqyGLTx477lRICAMTeiBkrOfhz6+bMDGQk2bZZvGmvnqsyRBQA9DgAb
         y8CQ==
X-Gm-Message-State: AOAM530J9nZXjOT9l8feD1QChUl5Q+bQFjgJFQi65PM0sTZYT7Whn+rm
        MoEcG0Wmf1hynebyaidpnZIPw1T8N6u3RdMaVDfdGA==
X-Google-Smtp-Source: ABdhPJwlWKE/HfKV7f4/IYJn8/YPGykFm4Opsc32Enj5I+qGMDk79Fe0iBz1g5yfPxuA17MsbMFhyvOFVOHVJZX170s=
X-Received: by 2002:a05:6000:1acc:b0:20f:f12a:a535 with SMTP id
 i12-20020a0560001acc00b0020ff12aa535mr9329316wry.375.1653539152699; Wed, 25
 May 2022 21:25:52 -0700 (PDT)
MIME-Version: 1.0
References: <CAOBGo4zjkcX=ZQm1uYRDe9EjYqsTCyZY-Gf1C4XqMNYGFCcF+Q@mail.gmail.com>
 <CAP-5=fUobnt9anqeTaUt_EJVuMOpsxGR-Sa_e7qX=ZxqPDr+sA@mail.gmail.com> <20220526041650.esbcujaihdv5jqxm@google.com>
In-Reply-To: <20220526041650.esbcujaihdv5jqxm@google.com>
From:   Ian Rogers <irogers@google.com>
Date:   Wed, 25 May 2022 21:25:39 -0700
Message-ID: <CAP-5=fVbCNg=wGbN3dK1yP_cu_eL3h-sPDZ1hC2BgVM8nmHZ_w@mail.gmail.com>
Subject: Re: Call graph dwarf unwinding fails with lld
To:     Fangrui Song <maskray@google.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Travis Downs <travis.downs@gmail.com>,
        linux-perf-users@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Wed, May 25, 2022 at 9:16 PM Fangrui Song <maskray@google.com> wrote:
>
> On 2022-05-25, Ian Rogers wrote:
> >On Tue, May 24, 2022 at 1:50 PM Travis Downs <travis.downs@gmail.com> wrote:
> >>
> >> I have been tracking down an issue locally where `perf record
> >> --call-graph=dwarf` stopped working in the sense that unwinding always
> >> failed.
> >>
> >> Turns out it was related to `lld` - binaries linked with `lld` don't
> >> seem to unwind correctly with `--call-graph=dwarf`. I've confirmed
> >> that the `.eh_frame` sections are there, but I guess they are
> >> different after using this linker.
> >>
> >> Has anyone run into this?
> >
> >I was unaware but thanks for filing the bug!
> >
> >> There's an open LLVM issue at https://github.com/llvm/llvm-project/issues/53156
> >>
> >> ... but no activity since it was filed, though it is not clear if the
> >> problem is really with lld or the unwinders.
> >>
> >> In a related question: perf supports more than one DWARF unwinding
> >> implementation, depending on what libraries are available at build
> >> time, right? Is there a way to select which unwinder is used at
> >> runtime?
> >
> >I don't think so. There are two build options NO_LIBUNWIND=1 and
> >NO_LIBDW_DWARF_UNWIND=1. I played around with the example from the
> >bug, confirmed no difference with the eh_frames and hand verified
> >them, I also added -fno-omit-frame-pointer -O0 and -static. I've not
> >got a good handle on the issue but my suspicion is that the
> >eh_frame_hdr is broken - it is at least something that lld generates.
> >If I change the eh_frame_hdr finding to some findable but unexpected
> >offset like eh_frame here:
> >https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git/tree/tools/perf/util/unwind-libunwind-local.c?h=perf/core#n286
> >and then test with a working linker the unwinding is broken similarly
> >to with lld. I was looking for a useful tool (objdump, llvm-objdump,
> >readelf, dwarfdump) to look at the eh_frame_hdr but I didn't see one.
> >Perhaps someone has a suggestion or maybe pahole can do it. Hopefully
> >this gives a lead for you to dig into for the bug.
> >
> >Thanks,
> >Ian
>
> I am very familiar with lld and have read some nongnu libunwind code, so I guess I
> may be an appropriate one debugging the issue, but I am puzzled about how to build tools/perf:
>
> /tmp/out/custom1 has needed llvm-project tools, built from origin/main
> ninja -C /tmp/out/custom1 clang lld llvm-{nm,size,strings,objcopy,objdump,readelf,ar,strip}
>
> ```
> % git checkout master  # torvalds/linux
> % PATH=/tmp/out/custom1/bin:$PATH make O=/tmp/linux/x86_64 ARCH=x86_64 -j60 defconfig all
> % PATH=/tmp/out/custom1/bin:$PATH make O=/tmp/linux/x86_64 ARCH=x86_64 -j60 -C tools/perf
> ...
> In file included from bench/../../arch/x86/lib/memcpy_64.S:8,
>                   from bench/mem-memcpy-x86-64-asm.S:14:
> /tmp/linux/x86_64/arch/x86/include/generated/asm/export.h:1:10: fatal error: asm-generic/export.h: No such file or directory
>      1 | #include <asm-generic/export.h>
>        |          ^~~~~~~~~~~~~~~~~~~~~~
> ```
>
> I am running a 5.16 kernel so I have tried `git checkout v5.16`, no luck as well.
> I cannot find useful information about "asm-generic/export.h: no such file or directory" on www:(

Arnaldo, can the tools/include headers be made hermetic?

You may have better luck with the development tree:
https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git/
branch perf/core. The perf tool is backward compatible with old
kernels, unfortunately Debian packages it wrong which causes issues
everywhere.

Thanks,
Ian
