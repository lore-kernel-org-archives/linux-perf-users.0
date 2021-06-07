Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29B4EC47082
	for <linux-perf-users@archiver.kernel.org>; Mon,  7 Jun 2021 20:35:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0691C61153
	for <linux-perf-users@archiver.kernel.org>; Mon,  7 Jun 2021 20:35:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231236AbhFGUhC (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 7 Jun 2021 16:37:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230436AbhFGUhC (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 7 Jun 2021 16:37:02 -0400
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD151C061574
        for <linux-perf-users@vger.kernel.org>; Mon,  7 Jun 2021 13:35:10 -0700 (PDT)
Received: by mail-qv1-xf33.google.com with SMTP id u14so6724497qvq.6
        for <linux-perf-users@vger.kernel.org>; Mon, 07 Jun 2021 13:35:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZMWLwrT3tzkNROjejSZHkSJGqtLsxOXJijLmp+N+WUA=;
        b=UAeMsV9yT+XI9c0oZrU2PdwjsPV8qukzfoBfkKTnSO101uHR1/4EyiiyPkXZtUErQM
         3rWNQux76ijI9+CBDFUEfG5VMI0VnM5IxE3ZwutiGpuhujp4iZHBHDd4LKpU3jDi/VFo
         UEpjKLKfNzzk0hew56IaTQl3XJwkffgoMu1+M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZMWLwrT3tzkNROjejSZHkSJGqtLsxOXJijLmp+N+WUA=;
        b=HKqFwgBqMsBYw6dWjfJIoq27mq6RQOoBMMnxp9u3FYHcWe0vDms7013lDoYnth4HFs
         2MXta7pC+7fR+OAYM69gOIOqPBZba/G1oByKVx0Np89cnnJVeaGf14QzCCPux/bVWCht
         jWvBNdKIDUpHlDy6peBww7JqDwRvdVxCHICL2d5LU0iYxCKgHIgPjlPLTApHqydfCDQw
         aDfXFIvBhD9uQz4g3+tJr7QIaQ4m4gM13VX1FqSOSwjfDVWMt+PZgPklO6g3r1XRjZBP
         Ix5MySVVc3SBDAk/2dPWM7XbfqwmLEHI6FXZ7mS1mFX7pSlhHpnz8WZnK3tmAwyfajbX
         sWQQ==
X-Gm-Message-State: AOAM533/eI/n4KTGoZMU8BNgGd1qRvlfBY/9systj+u/9//R2Ah4MvDn
        TVXvMM2NiG2sKB+yzNfjReXc/bWFT7ucxw==
X-Google-Smtp-Source: ABdhPJzQQVMmui70IC7Nkg3ztMXQ5vcHyx1hty4E4/5QO4lN09yj3PPquGbPXOhTekd/NQwtP1vmxg==
X-Received: by 2002:ad4:4dcb:: with SMTP id cw11mr19475551qvb.54.1623098109435;
        Mon, 07 Jun 2021 13:35:09 -0700 (PDT)
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com. [209.85.219.176])
        by smtp.gmail.com with ESMTPSA id l25sm6250698qtr.32.2021.06.07.13.35.08
        for <linux-perf-users@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Jun 2021 13:35:08 -0700 (PDT)
Received: by mail-yb1-f176.google.com with SMTP id y2so26826559ybq.13
        for <linux-perf-users@vger.kernel.org>; Mon, 07 Jun 2021 13:35:08 -0700 (PDT)
X-Received: by 2002:a5b:54a:: with SMTP id r10mr26455324ybp.476.1623098107901;
 Mon, 07 Jun 2021 13:35:07 -0700 (PDT)
MIME-Version: 1.0
References: <20210507205513.640780-1-dianders@chromium.org> <20210602175559.GC31957@willie-the-truck>
In-Reply-To: <20210602175559.GC31957@willie-the-truck>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 7 Jun 2021 13:34:56 -0700
X-Gmail-Original-Message-ID: <CAD=FV=X1XjyfEG5H+OsCBZb_Acf1Z3PsSTUvO8sKcSD4BWsNbw@mail.gmail.com>
Message-ID: <CAD=FV=X1XjyfEG5H+OsCBZb_Acf1Z3PsSTUvO8sKcSD4BWsNbw@mail.gmail.com>
Subject: Re: [PATCH 0/3] arm64: perf: Make compat tracing better
To:     Will Deacon <will@kernel.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Seth LaForge <sethml@google.com>,
        Ricky Liang <jcliang@chromium.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Jiri Olsa <jolsa@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Hi,

On Wed, Jun 2, 2021 at 10:56 AM Will Deacon <will@kernel.org> wrote:
>
> Hi Doug,
>
> Thanks for posting this, and sorry for the delay in getting to it.
>
> On Fri, May 07, 2021 at 01:55:10PM -0700, Douglas Anderson wrote:
> > The goal for this series is to improve "perf" behavior when 32-bit
> > userspace code is involved. This turns out to be fairly important for
> > Chrome OS which still runs 32-bit userspace for the time being (long
> > story there).
>
> Watch out, your days are numbered! See [1].

Yeah, folks on the Chrome OS team are aware and we're trying our
darndest to move away. It's been an unfortunate set of circumstances
that has kept us on 32-bit this long. :( BTW: I like your suggestion
of "retirement" as a solution to dealing with this problem, but I'm
not quite ready to retire yet.


> > I won't repeat everything said in the individual patches since since
> > they are wordy enough as it is.
> >
> > Please enjoy and I hope this isn't too ugly/hacky for inclusion in
> > mainline.
> >
> > Thanks to Nick Desaulniers for his early review of these patches and
> > to Ricky for the super early prototype that some of this is based on.
>
> I can see that you've put a lot of effort into this, but I'm not thrilled
> with the prospect of maintaining these heuristics in the kernel. The
> callchain behaviour is directly visible to userspace, and all we'll be able
> to do is throw more heuristics at it if faced with any regression reports.
> Every assumption made about userspace behaviour results in diminishing
> returns where some set of programs no longer fall into the "supported"
> bucket and, on balance, I don't think the trade-off is worth it.
>
> If we were to do this in the kernel, then I'd like to see a spec for how
> frame-pointer based unwinding should work for Thumb and have it agreed
> upon and implemented by both GCC and LLVM. That way, we can implement
> the unwinder according to that spec and file bug reports against the
> compiler if it goes wrong.

Given how long this has been going on, I'd somewhat guess that getting
this implemented in GCC and LLVM is 1+ year out. Presumably Chrome OS
will be transitioned off 32-bit ARM by then.


> In lieu of that, I think we must defer to userspace to unwind using DWARF.
> Perf supports this via PERF_SAMPLE_STACK_USER and PERF_SAMPLE_REGS_USER,
> which allows libunwind to be used to create the callchain. You haven't
> mentioned that here, so I'd be interested to know why not.

Good point. So I guess I didn't mention it because:

a) I really know very little about perf. I got roped in this because I
understand stack unwinding, not because I know how to use perf well.
:-P So I personally have no idea how to set this up.

b) In the little bit of reading I did about this, people seemed to say
that using libunwind for perf sampling was just too slow / too much
overhead.


> Finally, you've probably noticed that our unwinding code for compat tasks
> is basically identical to the code in arch/arm/. If the functionality is
> going to be extended, it should be done there first and then we will follow
> to be compatible.

That's fair. I doubt that submitting patches to this area of code for
arm32 would be enjoyable, so I'll pass if it's all the same.

Given your feedback, I think it's fair to consider ${SUBJECT} patch
abandoned then. I'll see if people want to land it as a private patch
in the Chrome OS tree for the time being until we can more fully
abandon arm32 support or until the ARM teams working on gcc and clang
come up with a standard that we can support more properly.

In the meantime, if anyone cares to pick this patch up and move
forward, feel free to do so with my blessing.

-Doug
