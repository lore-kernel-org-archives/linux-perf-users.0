Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C1A7C433EF
	for <linux-perf-users@archiver.kernel.org>; Mon, 15 Nov 2021 16:57:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3420061BD2
	for <linux-perf-users@archiver.kernel.org>; Mon, 15 Nov 2021 16:57:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230254AbhKORAo (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 15 Nov 2021 12:00:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:45746 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230064AbhKORAn (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 15 Nov 2021 12:00:43 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id BFFEE61BF8;
        Mon, 15 Nov 2021 16:57:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636995467;
        bh=4bVno0PjpfrfSnwQAaZEWQwixpdNy3DNLVHa9F8Wq6g=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=rIQ2BSq8jHOJM5XVbFf/1uC3+yhOBa2VifZ5WA+tRSM43wh9mALDX5LhbTeN266nR
         GvNpJ2ciYHzdleNbkgIUY//9lkS+PMHKXeb/gMEbE7yipywg0NwemZd0o6E308I4J8
         JmGt2+CCPaZ9b/Y+mT21hg64Zqexnw2Wd8vcc02fWG7wv5uwECJjMl3HIpKDfO6U7r
         SaqiMrhsRMpGNwXSPoynd06Id8KqOlRaGYhFkIzn6xDk/7cILKPgP1jpUEobiPE8h1
         opNIe74tK6NtbtYDBNAgcqLSJ9hg7tkIYrkQT00zujTHea6tF+1XDfxVhRZF/aNzK4
         Yv9ajKpaXQD3A==
Received: by mail-ed1-f44.google.com with SMTP id w1so8818432edc.6;
        Mon, 15 Nov 2021 08:57:47 -0800 (PST)
X-Gm-Message-State: AOAM531rvesygieW6k/So04feq3ux86kQsULC3vbyHONm4xfPBwU5fS7
        qSlZXvxgA45hwszTxjsgdPezy73zsnGrG85/9g==
X-Google-Smtp-Source: ABdhPJy1O/ce8l/lik8mXrf1OhNbM4MtGgXw4HHiFZGekV6nYw5sOspC0PPppMdHhPy3xu+wczN+2vcF3Tz/raxSqpE=
X-Received: by 2002:a05:6402:350e:: with SMTP id b14mr146542edd.271.1636995466259;
 Mon, 15 Nov 2021 08:57:46 -0800 (PST)
MIME-Version: 1.0
References: <20211027201641.2076427-1-robh@kernel.org>
In-Reply-To: <20211027201641.2076427-1-robh@kernel.org>
From:   Rob Herring <robh@kernel.org>
Date:   Mon, 15 Nov 2021 10:57:34 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLQWYNHRyNNNeP5VvWJXxp1mmeMvz1DA3ZdyyqZkKzG3A@mail.gmail.com>
Message-ID: <CAL_JsqLQWYNHRyNNNeP5VvWJXxp1mmeMvz1DA3ZdyyqZkKzG3A@mail.gmail.com>
Subject: Re: [PATCH v12 0/5] Another version of arm64 userspace counter access support.
To:     Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Catalin Marinas <catalin.marinas@arm.com>,
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

On Wed, Oct 27, 2021 at 3:16 PM Rob Herring <robh@kernel.org> wrote:
>
> The arm64 support departs from the x86 implementation by requiring the user
> to explicitly request user access (via attr.config1) and only enables access
> for task bound events. Since usage is explicitly requested, access is
> enabled at perf_event_open() rather than on mmap() as that greatly
> simplifies the implementation. Rather than trying to lock down the access
> as the x86 implementation has been doing, we can start with only a limited
> use case enabled and later expand it if needed.
>
> I've run this version thru Vince's perf tests[14] with arm64 support added.
> I wish I'd found these tests sooner...
>
> This originally resurrected Raphael's series[1] to enable userspace counter
> access on arm64. My previous versions are here
> [2][3][4][5][6][7][8][9][10][11][12].
> A git branch is here[13].
>
> Changes in v12:
>  - Zero PMSELR_EL0 when userspace access is enabled
>  - Return -EOPNOTSUPP for if h/w doesn't support 64-bit counters

Will, the series rebases cleanly on v5.16-rc1. Please let me know if
you want me to resend.

Peter, Will is waiting on an ack on the core/x86 bits from you.

Rob
