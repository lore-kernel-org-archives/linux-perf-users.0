Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49A24C433F5
	for <linux-perf-users@archiver.kernel.org>; Tue, 26 Oct 2021 13:36:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2202E603E9
	for <linux-perf-users@archiver.kernel.org>; Tue, 26 Oct 2021 13:36:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236207AbhJZNiW (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 26 Oct 2021 09:38:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:33482 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230285AbhJZNiW (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 26 Oct 2021 09:38:22 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 887F760EC0;
        Tue, 26 Oct 2021 13:35:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635255358;
        bh=GQ+yDzgA2vcbE0+K5hXW5DwWQFmuJ2lxO3v/1xD0kqY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=dmGr8/aDCCOrqqKw4knAZf8feV2W8qtoeZpRrNKwTlPOujTYd4cbxtZtLtV5OCCkQ
         VGYs6OUCNQeI969BVc1fVT6BVVlFAYjOBlWOoVVSbzV5tTVdDCcPvJW7M+zLlp3hjn
         uE7FfWony7cKnuHUAvz3ifsmL7WSJwfYzNibvpwn5661x1qQFjILBua2JrC/kbVpGU
         zoUFEkJVnEl3e/F5z/P3EwcQzL9HPO8zeHZKdGAD1+FIcO852pqTYi2jqCljn2TDEd
         qel2NaiNV7Tn/1sPXWO0GbobCpXBGGzAI7zixU67aLjKfTBHHhfJkLyzPtmLOEkYes
         cIhvLr+cG9NPQ==
Received: by mail-ed1-f53.google.com with SMTP id s1so13913051edd.3;
        Tue, 26 Oct 2021 06:35:58 -0700 (PDT)
X-Gm-Message-State: AOAM531GcCkxwJ6wh4wbBBj+jH6oLIxPFF7cu9y/130M6JPBDuZT4Nu8
        BM8sLjkvwr5Y76fXAtkuIjcGdeBwB/dMZyX32g==
X-Google-Smtp-Source: ABdhPJy26qFbzewnIKR+cGC5EF6zEzbM9xrEV2Eo10i80J/7NA0tKo3J7Uri4jQR0jAmeszts3tdQq9gGOYCEbG+vDo=
X-Received: by 2002:a17:906:6a0a:: with SMTP id qw10mr14828933ejc.466.1635255287180;
 Tue, 26 Oct 2021 06:34:47 -0700 (PDT)
MIME-Version: 1.0
References: <20211019231907.1009567-1-robh@kernel.org> <20211026131039.GC34073@C02TD0UTHF1T.local>
In-Reply-To: <20211026131039.GC34073@C02TD0UTHF1T.local>
From:   Rob Herring <robh@kernel.org>
Date:   Tue, 26 Oct 2021 08:34:35 -0500
X-Gmail-Original-Message-ID: <CAL_Jsq+JLcWESzGzjsmrir+gCFEO88YMYdj+FOBhjZgSBNOeVA@mail.gmail.com>
Message-ID: <CAL_Jsq+JLcWESzGzjsmrir+gCFEO88YMYdj+FOBhjZgSBNOeVA@mail.gmail.com>
Subject: Re: [PATCH v11 0/5] arm64 userspace counter support
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Vince Weaver <vincent.weaver@maine.edu>,
        Honnappa Nagarahalli <honnappa.nagarahalli@arm.com>,
        Zachary.Leaf@arm.com, Catalin Marinas <catalin.marinas@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>, X86 ML <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Tue, Oct 26, 2021 at 8:10 AM Mark Rutland <mark.rutland@arm.com> wrote:
>
> On Tue, Oct 19, 2021 at 06:19:02PM -0500, Rob Herring wrote:
> > Another version of arm64 userspace counter access support.
> >
> > The arm64 support departs from the x86 implementation by requiring the user
> > to explicitly request user access (via attr.config1) and only enables access
> > for task bound events. Since usage is explicitly requested, access is
> > enabled at perf_event_open() rather than on mmap() as that greatly
> > simplifies the implementation. Rather than trying to lock down the access
> > as the x86 implementation has been doing, we can start with only a limited
> > use case enabled and later expand it if needed.
> >
> > I've run this version thru Vince's perf tests[13] with arm64 support added.
> > I wish I'd found these tests sooner...
>
> When you say "with arm64 support added", do you mean with patches not
> yet upstreamed?

Correct.

> I took a look at the upstream repo, and there's some existing RDPMC
> support even though upstream never previously supported userspace
> access. That support code uses PMSELR_EL0, which this series adds no
> provisions for.
>
> Kernel-side, we'll need to either:
>
> * Document that PMSELR_EL0 is unreliable, and explcitly zero it within
>   the kernel such that it cnanot be used as a covert channel. Get the
>   tests updated to not rely on the never-previously-supported use of
>   PMSELR_EL0.
>
> * Context switch PMSELR_EL0 (which'll IIUC is unreliable for big.LITTLE,
>   even where the registers exist on each CPU).

Whether we support userspace using PMSELR_EL0 or not, we just need to
zero it when userspace access is enabled (like the dirty counters).
When there's a context switch, the read sequence is going to be
incremented and PMSELR_EL0 will need to be written to again.

Rob
