Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEA80C433F5
	for <linux-perf-users@archiver.kernel.org>; Wed, 25 May 2022 07:50:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230225AbiEYHud (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 25 May 2022 03:50:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235342AbiEYHuc (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 25 May 2022 03:50:32 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 732547980C
        for <linux-perf-users@vger.kernel.org>; Wed, 25 May 2022 00:50:30 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id f2so28946629wrc.0
        for <linux-perf-users@vger.kernel.org>; Wed, 25 May 2022 00:50:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=59NLRoZULW61KCEVnGJApVSMg5OsU3+y5kY+JbX8BXk=;
        b=Gmlw65lHdvt4npH9gYXdkRvBzXVKw/5xK1+242Z5zvF8V9HYznsOFki6L0yAh7ooBA
         gC4JZTy5AhVv8m5v7V+4Z1fuU4aAaXWsrIkYF/SiMowIsaZTuWN5Wg4d+2lKDS8eKfx+
         wF7wIm6oGEN7O7T7+ZDSnqvNX7J2j+ONXz48ZlWUKv15mCpl9xjtP2Vv2JIey4JGDFhy
         tyOCLl5Pk019UffxU0taZMFL36Lek/IbDPKdaUPAyomhanxyeLJN1YGA3WG+sFfZyAGn
         kM45yz+SOyw9rqfvrw8ZoWt+vtaf2PeQMEgkHhj8olvSUdiZbyc/B0QPw/FmvC2Nxvq7
         74pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=59NLRoZULW61KCEVnGJApVSMg5OsU3+y5kY+JbX8BXk=;
        b=g0nknhXeLU1VZxsVgYAWS7E9Mo/q7J8707EQvU154IqzegmMJo8i013r9Ty94b3DwU
         kt3RkpIkx5+2SlxTj1YtraPoqXg3BRTJ76a5Z7qEXWRBJFCjUCXVz+YF50Q5ZwzdBdNB
         DMsCkRWfEAq3qs74eEW8kLIOCfxAmoE3ZAiUc5rJ3O9lGEqOJ7ei1tsLGzJ64nfZP8kq
         kyewQaiZ7iMvcAr1Ver4OLDbM/LoPE4oEv9lax4r84QYpm0f67r5eZY4fTvn0Qh9o+1I
         xqPVMNkbuTmOTYJ28beiSgGf+iJk6jpkG6Q7LnW4ktI5jS8CO9XqUTpRkp2JwYDpmGN7
         0T8g==
X-Gm-Message-State: AOAM531mx5oor2ihloXLDpzN5qyBs3eHelL+OXz1iQpWpvk1My/rtAW+
        h3KXxSQBcHhjKMqayw6y3HhfHy4aUBd4RYEelG5nhA==
X-Google-Smtp-Source: ABdhPJxjfZhsSwgfMlQJDAxPE0b+FASNIT8Vvh4wC8JWL0jFzwZQxiiru8qwUN/uul2B3VWupTB2Ynu4/kcZB158VaM=
X-Received: by 2002:a5d:598f:0:b0:20c:83c9:b05b with SMTP id
 n15-20020a5d598f000000b0020c83c9b05bmr26135485wri.343.1653465028700; Wed, 25
 May 2022 00:50:28 -0700 (PDT)
MIME-Version: 1.0
References: <CAOBGo4zjkcX=ZQm1uYRDe9EjYqsTCyZY-Gf1C4XqMNYGFCcF+Q@mail.gmail.com>
In-Reply-To: <CAOBGo4zjkcX=ZQm1uYRDe9EjYqsTCyZY-Gf1C4XqMNYGFCcF+Q@mail.gmail.com>
From:   Ian Rogers <irogers@google.com>
Date:   Wed, 25 May 2022 00:50:16 -0700
Message-ID: <CAP-5=fUobnt9anqeTaUt_EJVuMOpsxGR-Sa_e7qX=ZxqPDr+sA@mail.gmail.com>
Subject: Re: Call graph dwarf unwinding fails with lld
To:     Travis Downs <travis.downs@gmail.com>
Cc:     linux-perf-users@vger.kernel.org, Fangrui Song <maskray@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Tue, May 24, 2022 at 1:50 PM Travis Downs <travis.downs@gmail.com> wrote:
>
> I have been tracking down an issue locally where `perf record
> --call-graph=dwarf` stopped working in the sense that unwinding always
> failed.
>
> Turns out it was related to `lld` - binaries linked with `lld` don't
> seem to unwind correctly with `--call-graph=dwarf`. I've confirmed
> that the `.eh_frame` sections are there, but I guess they are
> different after using this linker.
>
> Has anyone run into this?

I was unaware but thanks for filing the bug!

> There's an open LLVM issue at https://github.com/llvm/llvm-project/issues/53156
>
> ... but no activity since it was filed, though it is not clear if the
> problem is really with lld or the unwinders.
>
> In a related question: perf supports more than one DWARF unwinding
> implementation, depending on what libraries are available at build
> time, right? Is there a way to select which unwinder is used at
> runtime?

I don't think so. There are two build options NO_LIBUNWIND=1 and
NO_LIBDW_DWARF_UNWIND=1. I played around with the example from the
bug, confirmed no difference with the eh_frames and hand verified
them, I also added -fno-omit-frame-pointer -O0 and -static. I've not
got a good handle on the issue but my suspicion is that the
eh_frame_hdr is broken - it is at least something that lld generates.
If I change the eh_frame_hdr finding to some findable but unexpected
offset like eh_frame here:
https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git/tree/tools/perf/util/unwind-libunwind-local.c?h=perf/core#n286
and then test with a working linker the unwinding is broken similarly
to with lld. I was looking for a useful tool (objdump, llvm-objdump,
readelf, dwarfdump) to look at the eh_frame_hdr but I didn't see one.
Perhaps someone has a suggestion or maybe pahole can do it. Hopefully
this gives a lead for you to dig into for the bug.

Thanks,
Ian
