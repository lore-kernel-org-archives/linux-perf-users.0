Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BC2FC433EF
	for <linux-perf-users@archiver.kernel.org>; Thu, 26 May 2022 03:55:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344872AbiEZDzf (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 25 May 2022 23:55:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231989AbiEZDzb (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 25 May 2022 23:55:31 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA901BDA27
        for <linux-perf-users@vger.kernel.org>; Wed, 25 May 2022 20:55:29 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id l30so564711wrb.8
        for <linux-perf-users@vger.kernel.org>; Wed, 25 May 2022 20:55:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=0gvMaXQAVRePYvD04DHEqQXtqxtlYLRiPzH99sGX5nU=;
        b=QTDLonKxc+RU1XzhE3wvYqRBgnW6OlUmo/dunqd0+4/kjGkfDng7E+10TTfoYX93aV
         t3i/R2Ni+bF+i3d5lIeH8RpLvTw69Eg3Vv2I6vF1eH9UzKrDiutF4+t2NX87kj/ug7+N
         lFcgE3IGfv9Apoo7tBlMv+2lHInJuCsgTo7sPQuYDVhzLjL7sDqw9jDvoZUwDc72JzUF
         sjgfFN4rbgKlAwQKx+rk9Qin5dNlzSRfxJ4J6itbc88UWq0pUbRJmgDBK6EofCCWKiYE
         6mG6afyMKK3QZZZkIMQtR+Lx7kryRJSIQJhnX0kkqgfQXsd/2C6sGLB12XIxYUc8Njwr
         4QXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=0gvMaXQAVRePYvD04DHEqQXtqxtlYLRiPzH99sGX5nU=;
        b=uYMA01v3+0hdyDWmJCoZ0RHHMR/kmbj7J6KKE7SBrs6TntcJi6ju70pUCN1Dt/12kR
         Ak2K3Z+z86fUZOhCz4PEdpP/ja0Xe05EWM/UdDHiZotBs5qCmw4R5AKTjDso5CzNppNO
         SRR8TFo1leP0BrWu5rnzDujL1qU6fDSIg0fnrdw0qzhp6prshiQQP2N566UeVAaLIJeG
         ikm/7Ed0GzpRZX5XRhev5geGI3jpT/hcDYxikx4UG0sm/uhINC5C7l4WuEsMY8VDnJ2Z
         Wk5tYURYyuRsS8Z7+CoPdxo4LLD6Urs2/GcxkduJSMxGAhImS6vtZHNwDClkVsj48ydh
         8Ehg==
X-Gm-Message-State: AOAM5337gXsh65Cx/DXVpar6pBSGkEdioc9WMDJlrote1sn83vYqKz8D
        YnCUls+yJwANcXUr1VvGLUrGuvmxrM2ONHaFUGdojR0IDVw=
X-Google-Smtp-Source: ABdhPJy4Twh/jl/xs3SgbPLoHUFJlhB9mUqElhwuMyLdXCRL8WS93uEx4S78+vL+eme95Ch25qUvqVG8XGXlqdPz4xU=
X-Received: by 2002:a05:6000:1acc:b0:20f:f12a:a535 with SMTP id
 i12-20020a0560001acc00b0020ff12aa535mr9259674wry.375.1653537328171; Wed, 25
 May 2022 20:55:28 -0700 (PDT)
MIME-Version: 1.0
References: <CAOBGo4zjkcX=ZQm1uYRDe9EjYqsTCyZY-Gf1C4XqMNYGFCcF+Q@mail.gmail.com>
 <CAP-5=fUobnt9anqeTaUt_EJVuMOpsxGR-Sa_e7qX=ZxqPDr+sA@mail.gmail.com> <CAFP8O3+KNmZsiiReXXtsWk682Dozs4=QL67k4KbqbX003u37Fg@mail.gmail.com>
In-Reply-To: <CAFP8O3+KNmZsiiReXXtsWk682Dozs4=QL67k4KbqbX003u37Fg@mail.gmail.com>
From:   Ian Rogers <irogers@google.com>
Date:   Wed, 25 May 2022 20:55:15 -0700
Message-ID: <CAP-5=fWLH4S7FUrv1pWc0Wk3Amo0qkLOURm0nqQnA8+MhFbR_Q@mail.gmail.com>
Subject: Re: Call graph dwarf unwinding fails with lld
To:     =?UTF-8?B?RsSBbmctcnXDrCBTw7JuZw==?= <maskray@google.com>
Cc:     Travis Downs <travis.downs@gmail.com>,
        linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Wed, May 25, 2022 at 1:10 AM F=C4=81ng-ru=C3=AC S=C3=B2ng <maskray@googl=
e.com> wrote:
>
> On Wed, May 25, 2022 at 12:50 AM Ian Rogers <irogers@google.com> wrote:
> >
> > On Tue, May 24, 2022 at 1:50 PM Travis Downs <travis.downs@gmail.com> w=
rote:
> > >
> > > I have been tracking down an issue locally where `perf record
> > > --call-graph=3Ddwarf` stopped working in the sense that unwinding alw=
ays
> > > failed.
> > >
> > > Turns out it was related to `lld` - binaries linked with `lld` don't
> > > seem to unwind correctly with `--call-graph=3Ddwarf`. I've confirmed
> > > that the `.eh_frame` sections are there, but I guess they are
> > > different after using this linker.
> > >
> > > Has anyone run into this?
> >
> > I was unaware but thanks for filing the bug!
> >
> > > There's an open LLVM issue at https://github.com/llvm/llvm-project/is=
sues/53156
> > >
> > > ... but no activity since it was filed, though it is not clear if the
> > > problem is really with lld or the unwinders.
> > >
> > > In a related question: perf supports more than one DWARF unwinding
> > > implementation, depending on what libraries are available at build
> > > time, right? Is there a way to select which unwinder is used at
> > > runtime?
> >
> > I don't think so. There are two build options NO_LIBUNWIND=3D1 and
> > NO_LIBDW_DWARF_UNWIND=3D1. I played around with the example from the
> > bug, confirmed no difference with the eh_frames and hand verified
> > them, I also added -fno-omit-frame-pointer -O0 and -static. I've not
> > got a good handle on the issue but my suspicion is that the
> > eh_frame_hdr is broken - it is at least something that lld generates.
> > If I change the eh_frame_hdr finding to some findable but unexpected
> > offset like eh_frame here:
> > https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git/tree/too=
ls/perf/util/unwind-libunwind-local.c?h=3Dperf/core#n286
> > and then test with a working linker the unwinding is broken similarly
> > to with lld. I was looking for a useful tool (objdump, llvm-objdump,
> > readelf, dwarfdump) to look at the eh_frame_hdr but I didn't see one.
> > Perhaps someone has a suggestion or maybe pahole can do it. Hopefully
> > this gives a lead for you to dig into for the bug.
> >
> > Thanks,
> > Ian
>
> I left a comment on
> https://github.com/llvm/llvm-project/issues/53156#issuecomment-1136777149
> that the perf issue is related to unsupported `ld.lld --rosegments`
> and `ld.bfd -z separate-code` layouts.

Thanks Fangrui! I commented on the bug (thanks for the help!) and I
think the bug is with libunwind assuming that sections are consecutive
in memory, at different offsets, etc. lld is playing games to reduce
file size and ultimately that's broken the perf unwinding. Perhaps
someone can figure out how to better drive libunwind from perf, but I
think it is wrong in its offset assumptions. libdw based unwinding is
no better from my testing, overall this is a fairly major
bug/regression.

Thanks,
Ian

> --
> =E5=AE=8B=E6=96=B9=E7=9D=BF
