Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65DF0C433FE
	for <linux-perf-users@archiver.kernel.org>; Wed, 25 May 2022 08:11:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232542AbiEYILE (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 25 May 2022 04:11:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236258AbiEYILB (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 25 May 2022 04:11:01 -0400
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 056FE7C155
        for <linux-perf-users@vger.kernel.org>; Wed, 25 May 2022 01:10:43 -0700 (PDT)
Received: by mail-yb1-xb2d.google.com with SMTP id y141so7528452ybe.13
        for <linux-perf-users@vger.kernel.org>; Wed, 25 May 2022 01:10:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=2zpuY/wO36c8I+0wUUJ24yYa5D2xjUB7WFj2uHXNkbM=;
        b=jT5S0TYc0sG+UAq/xfMs9Es16+CAiwIjvSSJ3odwUwyHq9PO2DfyLso8cLhXnryNlD
         gkChPQvxXXMkh5gSIFHmFY+3KyuvGJ/Bv2yb7GBwLULo27zl3j7JW/0qDPoTMY3O4teA
         gvFAIuM3+X4aYkuuUnSMn4aD+s9aqjXNi9dOf4+GHxdCdDZFZTSK3sGikMTxBjNTfMzc
         vU0NfsIE4Ddd0lXqvzd6q+ylUJHGQikgRLxx9MxC910rUAje0YQhMINt2MZEUqRHusYi
         DHwamTwLmQaE7frCgvY3oDoPi0I49z222h+hg866BrJjpQ2oyNsJOvERnpmQ/xRhGhme
         ro2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=2zpuY/wO36c8I+0wUUJ24yYa5D2xjUB7WFj2uHXNkbM=;
        b=LBLP1/VyT+zB/lS4ZiRI9Kiq+ZtzZvk9BvyXp4cBLxV15rcRbQ093ML2Sso/c1J6Eq
         s7rbh62TWm/LE95jPmUd0+lN3pHSZVpr3+IGB6hYPAoTbGJZhzOnGNv0sQ5d5cM+bLgM
         KFp/bjXg15OHTLk9vpyYj+7/MGiI0szTitXE7xhJ6bJTm6f3jOzQdXzYHTTWB9CG/XWY
         G/1CU3grtfyz1hUER4sJKUQSMInoaXZPG/gh6KK6tTxkIVX0byO3SS/lbyhzoFiQJvP7
         Lckr00NMR/3UeG3RTAMmukrasaM6gVPxU23IQu4XRd6S73p5D9D9mAMK/+fh/lLqfqgn
         x+4Q==
X-Gm-Message-State: AOAM530BbiuvZsudBgNoSJZGDpsX1+y6MMyXX0kSYzdC/YdClxQiWwdB
        EqGzsltM/Po0a8Ub4iecPYGssJbYgzQcDpQvuYzbJzYjxpV+UQ==
X-Google-Smtp-Source: ABdhPJyKYBmN+2FHZJFXmuEZGtNG9gv8k9hiZFCPJUa/gt9UKeLWiNjp9DruyFJzzmrqnQpQaABVnKATj0CE7qWW1jc=
X-Received: by 2002:a05:6902:1004:b0:64f:4748:e8be with SMTP id
 w4-20020a056902100400b0064f4748e8bemr27993100ybt.537.1653466242100; Wed, 25
 May 2022 01:10:42 -0700 (PDT)
MIME-Version: 1.0
References: <CAOBGo4zjkcX=ZQm1uYRDe9EjYqsTCyZY-Gf1C4XqMNYGFCcF+Q@mail.gmail.com>
 <CAP-5=fUobnt9anqeTaUt_EJVuMOpsxGR-Sa_e7qX=ZxqPDr+sA@mail.gmail.com>
In-Reply-To: <CAP-5=fUobnt9anqeTaUt_EJVuMOpsxGR-Sa_e7qX=ZxqPDr+sA@mail.gmail.com>
From:   =?UTF-8?B?RsSBbmctcnXDrCBTw7JuZw==?= <maskray@google.com>
Date:   Wed, 25 May 2022 01:10:30 -0700
Message-ID: <CAFP8O3+KNmZsiiReXXtsWk682Dozs4=QL67k4KbqbX003u37Fg@mail.gmail.com>
Subject: Re: Call graph dwarf unwinding fails with lld
To:     Ian Rogers <irogers@google.com>
Cc:     Travis Downs <travis.downs@gmail.com>,
        linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Wed, May 25, 2022 at 12:50 AM Ian Rogers <irogers@google.com> wrote:
>
> On Tue, May 24, 2022 at 1:50 PM Travis Downs <travis.downs@gmail.com> wro=
te:
> >
> > I have been tracking down an issue locally where `perf record
> > --call-graph=3Ddwarf` stopped working in the sense that unwinding alway=
s
> > failed.
> >
> > Turns out it was related to `lld` - binaries linked with `lld` don't
> > seem to unwind correctly with `--call-graph=3Ddwarf`. I've confirmed
> > that the `.eh_frame` sections are there, but I guess they are
> > different after using this linker.
> >
> > Has anyone run into this?
>
> I was unaware but thanks for filing the bug!
>
> > There's an open LLVM issue at https://github.com/llvm/llvm-project/issu=
es/53156
> >
> > ... but no activity since it was filed, though it is not clear if the
> > problem is really with lld or the unwinders.
> >
> > In a related question: perf supports more than one DWARF unwinding
> > implementation, depending on what libraries are available at build
> > time, right? Is there a way to select which unwinder is used at
> > runtime?
>
> I don't think so. There are two build options NO_LIBUNWIND=3D1 and
> NO_LIBDW_DWARF_UNWIND=3D1. I played around with the example from the
> bug, confirmed no difference with the eh_frames and hand verified
> them, I also added -fno-omit-frame-pointer -O0 and -static. I've not
> got a good handle on the issue but my suspicion is that the
> eh_frame_hdr is broken - it is at least something that lld generates.
> If I change the eh_frame_hdr finding to some findable but unexpected
> offset like eh_frame here:
> https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git/tree/tools=
/perf/util/unwind-libunwind-local.c?h=3Dperf/core#n286
> and then test with a working linker the unwinding is broken similarly
> to with lld. I was looking for a useful tool (objdump, llvm-objdump,
> readelf, dwarfdump) to look at the eh_frame_hdr but I didn't see one.
> Perhaps someone has a suggestion or maybe pahole can do it. Hopefully
> this gives a lead for you to dig into for the bug.
>
> Thanks,
> Ian

I left a comment on
https://github.com/llvm/llvm-project/issues/53156#issuecomment-1136777149
that the perf issue is related to unsupported `ld.lld --rosegments`
and `ld.bfd -z separate-code` layouts.

--=20
=E5=AE=8B=E6=96=B9=E7=9D=BF
