Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCD55C3F6B0
	for <linux-perf-users@archiver.kernel.org>; Tue, 16 Aug 2022 14:12:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235830AbiHPOMu (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 16 Aug 2022 10:12:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234215AbiHPOMt (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 16 Aug 2022 10:12:49 -0400
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B670B75394
        for <linux-perf-users@vger.kernel.org>; Tue, 16 Aug 2022 07:12:47 -0700 (PDT)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-32868f43dd6so154293567b3.8
        for <linux-perf-users@vger.kernel.org>; Tue, 16 Aug 2022 07:12:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=Vyh7nX6aNSNUE119qdiIIT/EoXittiyqJ3KmpoRb3JU=;
        b=fDj6FoppCemEAwso3o7LaD74WUC1I9oEzmYzOiTRD1OOS+4Bh/MPtP7m5uo8mLYe8C
         zjiVBUaPQ3d7zM+BHkTObTgsVSBd9aM9wKIW8UUHuYI2CXJkxy+j0lvwAbiMhmbKWwl4
         a16VohoYwhqmH4juBAj0nl6EkhgDKPGuuylgPjsCBy90RROWdi4K+AERKW55Swmsat7e
         gnR7lOcShMaxofH2EhqaBVQcfGs2vhqk4kVv+35th/mz8bcupB5rEqa7i56L72oV8VbK
         VzJx+/RwAFTqDU3LqTCDymIJPC5R6KkqcOySUiJTzF/kKwXNS+QpJMPFKemJ/d79x23F
         eiQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=Vyh7nX6aNSNUE119qdiIIT/EoXittiyqJ3KmpoRb3JU=;
        b=YNKT++mRKqo3a6J86HaL+UHGABfd0/htUR9ifgy/hwkZ1j7oO0Af0yJ0Dt5Mq178Hu
         M8n4HYx55EaVUmi/rp1joTvw/yxaecCUwwkcvm4ZUbDC3Vr2+ZEby8a0v9/AMr3zgzxr
         auIKvuVySX7D0IlMCWTPSx+vXlAnFvc/44YP9x24Rar1zD1y36TwYjpX83rHyhEIxYSR
         MYQc7qp0AIknwdSCT2mHzMIv7MUPiL+0jCYBcXgaqBgdrMr/KY8m9yyR2a8sLP1c8VXM
         X6XvXEvE6/NZnzCUjGOYInhpxlqnPr4lkCNiaX5q231MddOwtkNC4FX3CgPcV66+fAnB
         1D1Q==
X-Gm-Message-State: ACgBeo2VjAA4tKUaDPQ7bkx+aqTtfLc9d5fx+kAzm+z9nLjGiW1m0k9J
        lO+nLStHbdLP6+O2vd0J8tc/d1X4a3iYTKiawlwIyg==
X-Google-Smtp-Source: AA6agR6Cj7c7hUVt8CtUfA7vQh2q4zez305SpvmX/WRPpgHJLs/Mntp/ap6raCDGqlCGO9HtoAnpVoiUF1QjmGuI+uU=
X-Received: by 2002:a25:490:0:b0:67c:22be:65db with SMTP id
 138-20020a250490000000b0067c22be65dbmr15094214ybe.16.1660659166737; Tue, 16
 Aug 2022 07:12:46 -0700 (PDT)
MIME-Version: 1.0
References: <20220704150514.48816-1-elver@google.com> <CANpmjNP0hPuhXmZmkX1ytCDh56LOAmxJjf7RyfxOvoaem=2d8Q@mail.gmail.com>
 <CAP-5=fXgYWuHKkfAxxTeAzTuq7PLwMd6UvBu+J+6tnqHwraSCA@mail.gmail.com>
In-Reply-To: <CAP-5=fXgYWuHKkfAxxTeAzTuq7PLwMd6UvBu+J+6tnqHwraSCA@mail.gmail.com>
From:   Marco Elver <elver@google.com>
Date:   Tue, 16 Aug 2022 16:12:10 +0200
Message-ID: <CANpmjNOnRNKUTeSB9+LBTjG=2+BC=ox20ain1F8T1krS+ah9HA@mail.gmail.com>
Subject: Re: [PATCH v3 00/14] perf/hw_breakpoint: Optimize for thousands of tasks
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ian Rogers <irogers@google.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev@lists.ozlabs.org, linux-perf-users@vger.kernel.org,
        x86@kernel.org, linux-sh@vger.kernel.org,
        kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Wed, 20 Jul 2022 at 17:47, Ian Rogers <irogers@google.com> wrote:
> On Tue, Jul 12, 2022 at 6:41 AM Marco Elver <elver@google.com> wrote:
> > On Mon, 4 Jul 2022 at 17:05, Marco Elver <elver@google.com> wrote:
> > > The hw_breakpoint subsystem's code has seen little change in over 10
> > > years. In that time, systems with >100s of CPUs have become common,
> > > along with improvements to the perf subsystem: using breakpoints on
> > > thousands of concurrent tasks should be a supported usecase.
> > [...]
> > > Marco Elver (14):
> > >   perf/hw_breakpoint: Add KUnit test for constraints accounting
> > >   perf/hw_breakpoint: Provide hw_breakpoint_is_used() and use in test
> > >   perf/hw_breakpoint: Clean up headers
> > >   perf/hw_breakpoint: Optimize list of per-task breakpoints
> > >   perf/hw_breakpoint: Mark data __ro_after_init
> > >   perf/hw_breakpoint: Optimize constant number of breakpoint slots
> > >   perf/hw_breakpoint: Make hw_breakpoint_weight() inlinable
> > >   perf/hw_breakpoint: Remove useless code related to flexible
> > >     breakpoints
> > >   powerpc/hw_breakpoint: Avoid relying on caller synchronization
> > >   locking/percpu-rwsem: Add percpu_is_write_locked() and
> > >     percpu_is_read_locked()
> > >   perf/hw_breakpoint: Reduce contention with large number of tasks
> > >   perf/hw_breakpoint: Introduce bp_slots_histogram
> > >   perf/hw_breakpoint: Optimize max_bp_pinned_slots() for CPU-independent
> > >     task targets
> > >   perf/hw_breakpoint: Optimize toggle_bp_slot() for CPU-independent task
> > >     targets
> > [...]
> >
> > This is ready from our side, and given the silence, assume it's ready
> > to pick up and/or have a maintainer take a look. Since this is mostly
> > kernel/events, would -tip/perf/core be appropriate?
>
> These are awesome improvements, I've added my acked-by to every
> change. I hope we can pull these changes, as you say, into tip.git
> perf/core and get them into 5.20.

These still apply cleanly to 6.0-rc1 and the test passes, but let me
know if I shall send a rebased version.

Thanks
-- Marco
