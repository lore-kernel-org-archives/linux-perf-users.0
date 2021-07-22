Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-23.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F03D6C4338F
	for <linux-perf-users@archiver.kernel.org>; Thu, 22 Jul 2021 23:31:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D477460E9B
	for <linux-perf-users@archiver.kernel.org>; Thu, 22 Jul 2021 23:31:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232654AbhGVWvU (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 22 Jul 2021 18:51:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232505AbhGVWvT (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 22 Jul 2021 18:51:19 -0400
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F426C061575
        for <linux-perf-users@vger.kernel.org>; Thu, 22 Jul 2021 16:31:53 -0700 (PDT)
Received: by mail-io1-xd30.google.com with SMTP id l18so457847ioh.11
        for <linux-perf-users@vger.kernel.org>; Thu, 22 Jul 2021 16:31:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1Ah3hxIEkxG4Tfj2BhFU2Ycu/VLeQs8pazhZDcOSRuI=;
        b=L/jbABCG0hw5gPUITvGkMBLiNMiW1P2E9lQr8zCrJyrrAmkBZkoncrILNrhXpXV8/s
         B6TZiGk6/iEGHBPe2Ms4FDKZ7mr8Heh9xbs5Me1P+fUcBV3yU8W6Nawg0qszuz5ZHpsu
         OpPv1zmMkN/1oVxJvt6W4ghM0WswFxQM47ZyEpUpAjgUkeouihsQPL0iXjZxplzXsrJp
         6RS2Ul5ad0cGtFvMpASk5q74qpeb+JDBVZfGqn+5sdWemP2Kx43rG2nFJZS4Flc3EoAC
         Jh1Jw9+UX3Mn7Zc02rjGSXcO3EmjkvDqCZbUQNznlyqjPkP9qL/4mSlmpveMOSsUE2t0
         zXoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1Ah3hxIEkxG4Tfj2BhFU2Ycu/VLeQs8pazhZDcOSRuI=;
        b=mxeTkHS3C6Fykvhd1s+rkHmC/rd/Fu7fEbCGr2kEJTLmS1tVkN6Q0u5qzty/60rrIM
         Da/bGI9p+qEhmWVsfEYdN7KzDy1pKt/fBDJ68r4SXTXibDudu4LF5eZuB01YRg0on5cD
         OOQDQettQU8xdPiYgMYRgsV886wVatwu+S/NxNMrrDIjJK9eF9VpZhgWSwMKkbfMTN9L
         73WiO+Vvwsr6mHphz34Wb5TnPtMMxsrRw+zX1CzM5MUm2fo4Rdv3cuHDceWnKpDiVOld
         OPFRSJ2TM6avWGYVIfnS/BHcvkdcIEY+B+VKthg/X9w55Jkmg0G8s2ONQLWEmlf4AfBW
         /X/Q==
X-Gm-Message-State: AOAM532sChZHrGaYkbA9o+1p70px8Oo+F+QhtB2u4poduBqkD7vMFf0Q
        dy2UxZOC3IeCzmNUsQrYyrIH7Xzc5YEUieJhYEDIsA==
X-Google-Smtp-Source: ABdhPJxQDTtZ1I9K905D80K8OFIlnniKJQhcYDu31zNPQKLJxskE8hli0iKE8HJVoeO2yxuZcT1y+DrjRYxA9WvxSBI=
X-Received: by 2002:a6b:4f16:: with SMTP id d22mr1644492iob.15.1626996712569;
 Thu, 22 Jul 2021 16:31:52 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1626966805.git.rickyman7@gmail.com>
In-Reply-To: <cover.1626966805.git.rickyman7@gmail.com>
From:   Ian Rogers <irogers@google.com>
Date:   Thu, 22 Jul 2021 16:31:40 -0700
Message-ID: <CAP-5=fWxuGkJdFPNt7B=t3bc81jP8YWOUdyvfFcntStGqUxuag@mail.gmail.com>
Subject: Re: [PATCH 0/3] tools: add gettid to libc_compat.h
To:     Riccardo Mancini <rickyman7@gmail.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Thu, Jul 22, 2021 at 8:34 AM Riccardo Mancini <rickyman7@gmail.com> wrote:
>
> Hi Arnaldo,
>
> following our previous discussion on workqueue RFC patchset, I'm sending
> this patchet to add gettid to tools/include/tools/libc_compat.h.
> This new definition will replace existing uses and will be used by the
> workqueue code.
>
> Thanks,
> Riccardo
>
> Riccardo Mancini (3):
>   tools libc_compat: add gettid
>   perf jvmti: use gettid from libc_compat
>   perf test: mmap-thread-lookup: use gettid
>
>  tools/include/tools/libc_compat.h     | 7 +++++++
>  tools/perf/jvmti/jvmti_agent.c        | 9 +--------
>  tools/perf/tests/mmap-thread-lookup.c | 4 ++--
>  3 files changed, 10 insertions(+), 10 deletions(-)

All 3 patches look like great cleanup, thanks!

Acked-by: Ian Rogers <irogers@google.com>

Thanks,
Ian
