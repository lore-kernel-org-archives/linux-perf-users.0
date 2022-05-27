Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 414C5C433F5
	for <linux-perf-users@archiver.kernel.org>; Fri, 27 May 2022 06:05:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239042AbiE0GF0 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 27 May 2022 02:05:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236997AbiE0GFZ (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 27 May 2022 02:05:25 -0400
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com [IPv6:2607:f8b0:4864:20::112a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85117EBEB3
        for <linux-perf-users@vger.kernel.org>; Thu, 26 May 2022 23:05:24 -0700 (PDT)
Received: by mail-yw1-x112a.google.com with SMTP id 00721157ae682-2ef5380669cso36948457b3.9
        for <linux-perf-users@vger.kernel.org>; Thu, 26 May 2022 23:05:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7VHvjIfJq9D6lO+TpoQm0tnmjw/+FCIiWflb4wfyiis=;
        b=EVbTirZ2vrqAYHDnzMm5B3W6FGQZB1r/4vu2KijGst4r3mubDFHwxWtM6tTw7axbKa
         pCC6F47ItDOVU+AV2wu+0Xh0MFWukiuBHOWIruQlWYrLgzOM6jlwjeZEahtHvqroDOBE
         iC3LBxdlfM3Z6hJlIYTk2w5Yew2OVmF04h7Bv8fTr14bMln3jTd6S+l8vKUFp3U9IQ+s
         p8wbaSPJh0yxnSl60+RK/7J5MAr5xBxAWR2DhxO9X7PTN6KZHrdc1bnvJtuv84Ykb6ZX
         LNw/HUH0BJkZcIslZobcOkt3zEXU7np+FsjWIXfhyMEoB+zJDYGaKtNfcRduJMQpKBbP
         f3iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7VHvjIfJq9D6lO+TpoQm0tnmjw/+FCIiWflb4wfyiis=;
        b=sU2CQEKltpdbEZQNmu1m21WJOkpeolTKE6Ayj16BLIu4EKiDT3d+w82j3Q3vdR/H6o
         iLxgtHtt3REFW7m6aflAdeXZ6ejwgap7A1j+S/NO05pEG6olh0nkjTXPD8S5WlCLxhlr
         omrlEt/07ioLfMs7JF0zYLSw+TVX2C+sTOp3lcNaNYC1oNXlr7zFZLJAhAmEczf5vF3y
         Uv+SEyiG15wCg3Vyqguf/+7Q65YEyJdbRZGds52APN03VsPT0kbb5B3zaacAiYO/AGeT
         xw9DNRpyk+UrdIETdy0INQFbVFA4fq41/d3ZCXHkV/434S4aW1FrXJdhLRtqcSpPg7U0
         7ibA==
X-Gm-Message-State: AOAM530F2Zn8/WcbdAjuYFKrdcCwGZxYEasZEgqHc88AE7cwhkPuQ9wc
        5z33pjge3x07hEh0WaZZkqpx0c1L0Rud4Lx5Lr3gzg==
X-Google-Smtp-Source: ABdhPJzmqggwtA1y7Yx/fkUPb0VYhyt53XkbFW/YOv8U7jTTlx8hbfIWMLZOyIomdvlvIKNRQAdurZiLN3oGIAvuprM=
X-Received: by 2002:a81:7c45:0:b0:300:2f8c:7cf2 with SMTP id
 x66-20020a817c45000000b003002f8c7cf2mr15465005ywc.255.1653631523553; Thu, 26
 May 2022 23:05:23 -0700 (PDT)
MIME-Version: 1.0
References: <CAOBGo4zjkcX=ZQm1uYRDe9EjYqsTCyZY-Gf1C4XqMNYGFCcF+Q@mail.gmail.com>
 <CAP-5=fUobnt9anqeTaUt_EJVuMOpsxGR-Sa_e7qX=ZxqPDr+sA@mail.gmail.com>
 <20220526041650.esbcujaihdv5jqxm@google.com> <CAP-5=fVbCNg=wGbN3dK1yP_cu_eL3h-sPDZ1hC2BgVM8nmHZ_w@mail.gmail.com>
 <Yo+RDn9om2Eiwjym@kernel.org>
In-Reply-To: <Yo+RDn9om2Eiwjym@kernel.org>
From:   =?UTF-8?B?RsSBbmctcnXDrCBTw7JuZw==?= <maskray@google.com>
Date:   Thu, 26 May 2022 23:05:12 -0700
Message-ID: <CAFP8O3JreR7XD-OygwP6+wwrJoxEfAnZm9+U8Ti68fmAHKaKvg@mail.gmail.com>
Subject: Re: Call graph dwarf unwinding fails with lld
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Ian Rogers <irogers@google.com>,
        Travis Downs <travis.downs@gmail.com>,
        linux-perf-users@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Thu, May 26, 2022 at 7:39 AM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> Em Wed, May 25, 2022 at 09:25:39PM -0700, Ian Rogers escreveu:
> > On Wed, May 25, 2022 at 9:16 PM Fangrui Song <maskray@google.com> wrote:
> > >
> > > On 2022-05-25, Ian Rogers wrote:
> > > >On Tue, May 24, 2022 at 1:50 PM Travis Downs <travis.downs@gmail.com> wrote:
> > > >>
> > > >> I have been tracking down an issue locally where `perf record
> > > >> --call-graph=dwarf` stopped working in the sense that unwinding always
> > > >> failed.
> > > >>
> > > >> Turns out it was related to `lld` - binaries linked with `lld` don't
> > > >> seem to unwind correctly with `--call-graph=dwarf`. I've confirmed
> > > >> that the `.eh_frame` sections are there, but I guess they are
> > > >> different after using this linker.
> > > >>
> > > >> Has anyone run into this?
> > > >
> > > >I was unaware but thanks for filing the bug!
> > > >
> > > >> There's an open LLVM issue at https://github.com/llvm/llvm-project/issues/53156
> > > >>
> > > >> ... but no activity since it was filed, though it is not clear if the
> > > >> problem is really with lld or the unwinders.
> > > >>
> > > >> In a related question: perf supports more than one DWARF unwinding
> > > >> implementation, depending on what libraries are available at build
> > > >> time, right? Is there a way to select which unwinder is used at
> > > >> runtime?
> > > >
> > > >I don't think so. There are two build options NO_LIBUNWIND=1 and
> > > >NO_LIBDW_DWARF_UNWIND=1. I played around with the example from the
> > > >bug, confirmed no difference with the eh_frames and hand verified
> > > >them, I also added -fno-omit-frame-pointer -O0 and -static. I've not
> > > >got a good handle on the issue but my suspicion is that the
> > > >eh_frame_hdr is broken - it is at least something that lld generates.
> > > >If I change the eh_frame_hdr finding to some findable but unexpected
> > > >offset like eh_frame here:
> > > >https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git/tree/tools/perf/util/unwind-libunwind-local.c?h=perf/core#n286
> > > >and then test with a working linker the unwinding is broken similarly
> > > >to with lld. I was looking for a useful tool (objdump, llvm-objdump,
> > > >readelf, dwarfdump) to look at the eh_frame_hdr but I didn't see one.
> > > >Perhaps someone has a suggestion or maybe pahole can do it. Hopefully
> > > >this gives a lead for you to dig into for the bug.
> > > >
> > > >Thanks,
> > > >Ian
> > >
> > > I am very familiar with lld and have read some nongnu libunwind code, so I guess I
> > > may be an appropriate one debugging the issue, but I am puzzled about how to build tools/perf:
> > >
> > > /tmp/out/custom1 has needed llvm-project tools, built from origin/main
> > > ninja -C /tmp/out/custom1 clang lld llvm-{nm,size,strings,objcopy,objdump,readelf,ar,strip}
> > >
> > > ```
> > > % git checkout master  # torvalds/linux
> > > % PATH=/tmp/out/custom1/bin:$PATH make O=/tmp/linux/x86_64 ARCH=x86_64 -j60 defconfig all
> > > % PATH=/tmp/out/custom1/bin:$PATH make O=/tmp/linux/x86_64 ARCH=x86_64 -j60 -C tools/perf
>
> I never tried build both Linux and perf on the same O= directory, can
> you please building perf on a separate directory to see if this changes
> anything?
>
> Also you don't need to build Linux proper to test these problems, right?
>
> - Arnaldo

Thank you! Using an O= without the kernel build fixes my build problem...
Then I managed to craft a patch:)
https://lore.kernel.org/linux-perf-users/20220527055217.452307-1-maskray@google.com/
("perf: Fix segbase for ld.lld linked objects")
