Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7737C433EF
	for <linux-perf-users@archiver.kernel.org>; Thu, 26 May 2022 14:39:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242566AbiEZOjp (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 26 May 2022 10:39:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347720AbiEZOjV (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 26 May 2022 10:39:21 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0C71CFE00
        for <linux-perf-users@vger.kernel.org>; Thu, 26 May 2022 07:39:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3D076B81B24
        for <linux-perf-users@vger.kernel.org>; Thu, 26 May 2022 14:39:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 927C7C34116;
        Thu, 26 May 2022 14:39:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653575954;
        bh=tkFr4iPq11JZDYdXXnwdtpbmQ+4dzE7OxukIImn7/7U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Fr9SujQhyc0P9NEkBhhp9/KU26K0aBCw2wW7ced1lmRaKxSaK1ttuQgs2Cjm36r/F
         KKq2xmFwvCaohPnvO7NKHdOuvWfkI9wx3j48a5BtFuJZhSxoiX+OgnbHyZlLCHEtz9
         lUQC82hs7mCyVQPDlUxUXOy7mt4puNFNngKYDpHfwJv+nJGxC7pZvqTTnKtIYytSKG
         S+exnqDI+leh7/mrM/m9lvOhihBcMmIpuHvxpLAh2dA/PUyxvZLUvIqjb2HFdhUUF/
         VC4mfhH7Yi1Smmwz6+2czAz3AwXGD68rQlTLMERBgaG636NryTFHxVkoPq45wS4Duc
         UDMmPrzjsI/bw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id A2ACB4036D; Thu, 26 May 2022 11:39:10 -0300 (-03)
Date:   Thu, 26 May 2022 11:39:10 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ian Rogers <irogers@google.com>
Cc:     Fangrui Song <maskray@google.com>,
        Travis Downs <travis.downs@gmail.com>,
        linux-perf-users@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: Call graph dwarf unwinding fails with lld
Message-ID: <Yo+RDn9om2Eiwjym@kernel.org>
References: <CAOBGo4zjkcX=ZQm1uYRDe9EjYqsTCyZY-Gf1C4XqMNYGFCcF+Q@mail.gmail.com>
 <CAP-5=fUobnt9anqeTaUt_EJVuMOpsxGR-Sa_e7qX=ZxqPDr+sA@mail.gmail.com>
 <20220526041650.esbcujaihdv5jqxm@google.com>
 <CAP-5=fVbCNg=wGbN3dK1yP_cu_eL3h-sPDZ1hC2BgVM8nmHZ_w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP-5=fVbCNg=wGbN3dK1yP_cu_eL3h-sPDZ1hC2BgVM8nmHZ_w@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Wed, May 25, 2022 at 09:25:39PM -0700, Ian Rogers escreveu:
> On Wed, May 25, 2022 at 9:16 PM Fangrui Song <maskray@google.com> wrote:
> >
> > On 2022-05-25, Ian Rogers wrote:
> > >On Tue, May 24, 2022 at 1:50 PM Travis Downs <travis.downs@gmail.com> wrote:
> > >>
> > >> I have been tracking down an issue locally where `perf record
> > >> --call-graph=dwarf` stopped working in the sense that unwinding always
> > >> failed.
> > >>
> > >> Turns out it was related to `lld` - binaries linked with `lld` don't
> > >> seem to unwind correctly with `--call-graph=dwarf`. I've confirmed
> > >> that the `.eh_frame` sections are there, but I guess they are
> > >> different after using this linker.
> > >>
> > >> Has anyone run into this?
> > >
> > >I was unaware but thanks for filing the bug!
> > >
> > >> There's an open LLVM issue at https://github.com/llvm/llvm-project/issues/53156
> > >>
> > >> ... but no activity since it was filed, though it is not clear if the
> > >> problem is really with lld or the unwinders.
> > >>
> > >> In a related question: perf supports more than one DWARF unwinding
> > >> implementation, depending on what libraries are available at build
> > >> time, right? Is there a way to select which unwinder is used at
> > >> runtime?
> > >
> > >I don't think so. There are two build options NO_LIBUNWIND=1 and
> > >NO_LIBDW_DWARF_UNWIND=1. I played around with the example from the
> > >bug, confirmed no difference with the eh_frames and hand verified
> > >them, I also added -fno-omit-frame-pointer -O0 and -static. I've not
> > >got a good handle on the issue but my suspicion is that the
> > >eh_frame_hdr is broken - it is at least something that lld generates.
> > >If I change the eh_frame_hdr finding to some findable but unexpected
> > >offset like eh_frame here:
> > >https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git/tree/tools/perf/util/unwind-libunwind-local.c?h=perf/core#n286
> > >and then test with a working linker the unwinding is broken similarly
> > >to with lld. I was looking for a useful tool (objdump, llvm-objdump,
> > >readelf, dwarfdump) to look at the eh_frame_hdr but I didn't see one.
> > >Perhaps someone has a suggestion or maybe pahole can do it. Hopefully
> > >this gives a lead for you to dig into for the bug.
> > >
> > >Thanks,
> > >Ian
> >
> > I am very familiar with lld and have read some nongnu libunwind code, so I guess I
> > may be an appropriate one debugging the issue, but I am puzzled about how to build tools/perf:
> >
> > /tmp/out/custom1 has needed llvm-project tools, built from origin/main
> > ninja -C /tmp/out/custom1 clang lld llvm-{nm,size,strings,objcopy,objdump,readelf,ar,strip}
> >
> > ```
> > % git checkout master  # torvalds/linux
> > % PATH=/tmp/out/custom1/bin:$PATH make O=/tmp/linux/x86_64 ARCH=x86_64 -j60 defconfig all
> > % PATH=/tmp/out/custom1/bin:$PATH make O=/tmp/linux/x86_64 ARCH=x86_64 -j60 -C tools/perf

I never tried build both Linux and perf on the same O= directory, can
you please building perf on a separate directory to see if this changes
anything?

Also you don't need to build Linux proper to test these problems, right?

- Arnaldo

> > ...
> > In file included from bench/../../arch/x86/lib/memcpy_64.S:8,
> >                   from bench/mem-memcpy-x86-64-asm.S:14:
> > /tmp/linux/x86_64/arch/x86/include/generated/asm/export.h:1:10: fatal error: asm-generic/export.h: No such file or directory
> >      1 | #include <asm-generic/export.h>
> >        |          ^~~~~~~~~~~~~~~~~~~~~~
> > ```
> >
> > I am running a 5.16 kernel so I have tried `git checkout v5.16`, no luck as well.
> > I cannot find useful information about "asm-generic/export.h: no such file or directory" on www:(
> 
> Arnaldo, can the tools/include headers be made hermetic?
> 
> You may have better luck with the development tree:
> https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git/
> branch perf/core. The perf tool is backward compatible with old
> kernels, unfortunately Debian packages it wrong which causes issues
> everywhere.
> 
> Thanks,
> Ian

-- 

- Arnaldo
