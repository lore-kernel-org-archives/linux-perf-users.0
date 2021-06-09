Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C7D5C48BCF
	for <linux-perf-users@archiver.kernel.org>; Wed,  9 Jun 2021 14:16:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1D55B61351
	for <linux-perf-users@archiver.kernel.org>; Wed,  9 Jun 2021 14:16:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234537AbhFIOSD (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 9 Jun 2021 10:18:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232867AbhFIOSD (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 9 Jun 2021 10:18:03 -0400
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com [IPv6:2607:f8b0:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC3AEC061574
        for <linux-perf-users@vger.kernel.org>; Wed,  9 Jun 2021 07:16:08 -0700 (PDT)
Received: by mail-il1-x135.google.com with SMTP id i17so26281026ilj.11
        for <linux-perf-users@vger.kernel.org>; Wed, 09 Jun 2021 07:16:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eN8+eR8AJAlCzAe6aRKwBFZ94zTbqJRc3z44p4oPAck=;
        b=nKL1lZcdAIrnIUr94pyY8xPmYLDscVVSqjC8tPRaNT/Jdo0cIsYXYxdqeAm73Um5z+
         t1ksbwzZSDhNpd6vcguU9iWR6GAiRnzG/Df/hUwX1tWDG9n11vCbCLcvL4sSWqXl6yhc
         rbrY5TSxSTR7564S3VpN9AYicF17NrPXBkv20=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eN8+eR8AJAlCzAe6aRKwBFZ94zTbqJRc3z44p4oPAck=;
        b=YPA0cL5KLQk5EZyzdMS9/OiSAgpVi4c+wLcCyoG/posj088jZ0a1jfNjHk/JSry1vJ
         7HvhL3C6mhcjI5jra8Ud74jYIkzG7sGvDxoN4pScCyk/gWLfjyI243QyTmAuHVkXYCPN
         XKi/SsXqo8/Rnlzvy0S3NwkhGWlSMTloJ7v7wBG5KfQF46hf6HsmD63PjXOblhyRIHKA
         5V8AoFoQIEs7md3gSK3aP2ofb02LKophgmNTEaRvspgZPeMRzOv2WGb6guLJPrW2lIoP
         k43IEJa+pyHhGizREZwCGeq8f0hAZCNWMBuEBCP1Jglj0eNGLNShbC6uIxkfFeWKvNKi
         4rtw==
X-Gm-Message-State: AOAM531BosoL42T2yg3fWC5RT5GtrKs1P+Vo6qm2Ao1ofKEgg/N04TAP
        Hyt9Ao5xOlFaglGpdDH+yVE8N1sz06QCZQ==
X-Google-Smtp-Source: ABdhPJzI/bMUo1OG9hTRw64nvVibVCwdk93GW32nMU8k4vwJYJDHuzeJQ/N9U26396m9wzVrA4dJDw==
X-Received: by 2002:a5e:974d:: with SMTP id h13mr23088434ioq.150.1623248168017;
        Wed, 09 Jun 2021 07:16:08 -0700 (PDT)
Received: from mail-il1-f170.google.com (mail-il1-f170.google.com. [209.85.166.170])
        by smtp.gmail.com with ESMTPSA id s14sm90141iln.64.2021.06.09.07.16.07
        for <linux-perf-users@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Jun 2021 07:16:07 -0700 (PDT)
Received: by mail-il1-f170.google.com with SMTP id b14so26001739ilq.7
        for <linux-perf-users@vger.kernel.org>; Wed, 09 Jun 2021 07:16:07 -0700 (PDT)
X-Received: by 2002:a05:6638:27a:: with SMTP id x26mr204405jaq.144.1623248166593;
 Wed, 09 Jun 2021 07:16:06 -0700 (PDT)
MIME-Version: 1.0
References: <20210604092638.985694-1-ribalda@chromium.org> <YLn0D+1R2QHZYRVV@hirez.programming.kicks-ass.net>
 <CANiDSCu4Brz7FZX5oa57kNLG9h_1EASX=bdQij4+apg0ZwW8QA@mail.gmail.com> <YL9UZzjqz8gHLbfo@hirez.programming.kicks-ass.net>
In-Reply-To: <YL9UZzjqz8gHLbfo@hirez.programming.kicks-ass.net>
From:   Ricardo Ribalda <ribalda@chromium.org>
Date:   Wed, 9 Jun 2021 16:15:55 +0200
X-Gmail-Original-Message-ID: <CANiDSCtYr3R79XPnFvMfLZYj=sTWGq+neHqrdNwXDN6JB25aMA@mail.gmail.com>
Message-ID: <CANiDSCtYr3R79XPnFvMfLZYj=sTWGq+neHqrdNwXDN6JB25aMA@mail.gmail.com>
Subject: Re: [PATCH] tools/perf: Do not set a variable unless it will be used
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Hi Peter

On Tue, 8 Jun 2021 at 13:29, Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Fri, Jun 04, 2021 at 09:24:23PM +0200, Ricardo Ribalda wrote:
> > Hi Peter
> >
> > On Fri, 4 Jun 2021 at 11:36, Peter Zijlstra <peterz@infradead.org> wrote:
> > >
> > > On Fri, Jun 04, 2021 at 11:26:38AM +0200, Ricardo Ribalda wrote:
> > > > clang-13 triggers the following warning:
> > > >
> > > > bench/inject-buildid.c:351:6: error: variable 'len' set but not used [-Werror,-Wunused-but-set-variable]
>                                                                          clue here: ^^^^^^^^^^^^^
>
> > > >         u64 len = 0;
> > > >
> > > > This patch sets the value to len only if it will be used afterwards.
> > >
> > > My vote would be to kill that warning, what absolute shite.
> >
> > My knowledge of llvm codebase is close to NULL, so it is much easier
> > for me to "fix" the code.
>
> That's what -Wno-unused-but-set-variable is for, which is trivial to add
> to the Makefile.

Yes, that is quite easy to add, the problem is that we might hide real
bugs.  I completely agree that this one is borderline :)



-- 
Ricardo Ribalda
