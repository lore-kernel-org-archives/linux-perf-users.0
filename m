Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B27CC43334
	for <linux-perf-users@archiver.kernel.org>; Fri, 22 Jul 2022 09:32:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236488AbiGVJcD (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 22 Jul 2022 05:32:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236558AbiGVJbu (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 22 Jul 2022 05:31:50 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0C8E205E0
        for <linux-perf-users@vger.kernel.org>; Fri, 22 Jul 2022 02:20:39 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id y11so6668686lfs.6
        for <linux-perf-users@vger.kernel.org>; Fri, 22 Jul 2022 02:20:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QRgm1i6pUMaVa04XshAEZM9Qyu6OwRtZCN3cy0vmh7k=;
        b=HZso6ITt75EPvPclCh4fRlgn/FKlvidTHBNAiEwaLYawZzU+8afxHQMdKVfcUcGjQ9
         wOX426kD3sMN9oM24HVzrVmR5CTSbGmZA/DTnHvdOoW3aw4iUtBoeFUYOLRnOaoVLFOC
         RUgW167EZKC21EUVC8U0CsWc60xKQomB6I+xjh8XT11UyVUScPUiXKZpn/UVb4OYbM2w
         YfNFx77GRNAf6f4xHjRiP+I2RW0n2b6oS/dQT6YlLiv7O3ILc15ITwsoTggN6QBRS9qS
         Fbroi3gbhHU7D60r4xbEw0SzsUYDtfgHuCFtU6/byYYdxkEZiaWm2AenLqkFh0omyfEY
         GPCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QRgm1i6pUMaVa04XshAEZM9Qyu6OwRtZCN3cy0vmh7k=;
        b=awKqoK6o5pqX8/Q63Ye4oMehmE11hy1JaskMKW+xR42UaPKa1E/E00n5ix0iY8sRhf
         z2FfrWXE0ZRjo/pyoTHNnPlZ0m3nDaXyj8V618u+A8r7FuOI9A5PFKuQEpMWk19YZ318
         esAfs+PqOeHkbJmuNbLy/QvvSbVudJZsJMagJ7l7T4fWK6JfKiEXqp18g+WB42jwU3/y
         mokxP/CVkfB+5dgfXOVqxfDJx701X9+46REF7Agt08fcnkb0kvncvUppPueCMEtY8exY
         yXq/mQnRLxRUcEm2hcTtHkYB8ylb6dinvTh6xpyq1cTtdOgElGVRX6K8IzGkVRBkmSHP
         TTcg==
X-Gm-Message-State: AJIora9OnNQi6Z48GjYzjaNEfNraZPkJlJ6TvHIOB9SRGHRcg9CshVEW
        irLmJVNWKvd7fMhl3EDkOP+mbzS+IPZ9yMpnQNanww==
X-Google-Smtp-Source: AGRyM1u5re9izJgUD0ajuSTYF8GDBxWnjDfbTJE8M2xP5mYLaJrM7U2hH+ZezpTXnb3khj0IcVijjetLnS98rcuea3w=
X-Received: by 2002:a05:6512:1085:b0:48a:710:6a7b with SMTP id
 j5-20020a056512108500b0048a07106a7bmr930020lfg.417.1658481637244; Fri, 22 Jul
 2022 02:20:37 -0700 (PDT)
MIME-Version: 1.0
References: <20220704150514.48816-1-elver@google.com> <20220704150514.48816-2-elver@google.com>
 <Ytl9L0Zn1PVuL1cB@FVFF77S0Q05N.cambridge.arm.com> <20220722091044.GC18125@willie-the-truck>
In-Reply-To: <20220722091044.GC18125@willie-the-truck>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Fri, 22 Jul 2022 11:20:25 +0200
Message-ID: <CACT4Y+ZOXXqxhe4U3ZtQPCj2yrf6Qtjg1q0Kfq8+poAOxGgUew@mail.gmail.com>
Subject: Re: [PATCH v3 01/14] perf/hw_breakpoint: Add KUnit test for
 constraints accounting
To:     Will Deacon <will@kernel.org>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Marco Elver <elver@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev@lists.ozlabs.org, linux-perf-users@vger.kernel.org,
        x86@kernel.org, linux-sh@vger.kernel.org,
        kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Fri, 22 Jul 2022 at 11:10, Will Deacon <will@kernel.org> wrote:
> > [adding Will]
> >
> > On Mon, Jul 04, 2022 at 05:05:01PM +0200, Marco Elver wrote:
> > > Add KUnit test for hw_breakpoint constraints accounting, with various
> > > interesting mixes of breakpoint targets (some care was taken to catch
> > > interesting corner cases via bug-injection).
> > >
> > > The test cannot be built as a module because it requires access to
> > > hw_breakpoint_slots(), which is not inlinable or exported on all
> > > architectures.
> > >
> > > Signed-off-by: Marco Elver <elver@google.com>
> >
> > As mentioned on IRC, I'm seeing these tests fail on arm64 when applied atop
> > v5.19-rc7:
> >
> > | TAP version 14
> > | 1..1
> > |     # Subtest: hw_breakpoint
> > |     1..9
> > |     ok 1 - test_one_cpu
> > |     ok 2 - test_many_cpus
> > |     # test_one_task_on_all_cpus: ASSERTION FAILED at kernel/events/hw_breakpoint_test.c:70
> > |     Expected IS_ERR(bp) to be false, but is true
> > |     not ok 3 - test_one_task_on_all_cpus
> > |     # test_two_tasks_on_all_cpus: ASSERTION FAILED at kernel/events/hw_breakpoint_test.c:70
> > |     Expected IS_ERR(bp) to be false, but is true
> > |     not ok 4 - test_two_tasks_on_all_cpus
> > |     # test_one_task_on_one_cpu: ASSERTION FAILED at kernel/events/hw_breakpoint_test.c:70
> > |     Expected IS_ERR(bp) to be false, but is true
> > |     not ok 5 - test_one_task_on_one_cpu
> > |     # test_one_task_mixed: ASSERTION FAILED at kernel/events/hw_breakpoint_test.c:70
> > |     Expected IS_ERR(bp) to be false, but is true
> > |     not ok 6 - test_one_task_mixed
> > |     # test_two_tasks_on_one_cpu: ASSERTION FAILED at kernel/events/hw_breakpoint_test.c:70
> > |     Expected IS_ERR(bp) to be false, but is true
> > |     not ok 7 - test_two_tasks_on_one_cpu
> > |     # test_two_tasks_on_one_all_cpus: ASSERTION FAILED at kernel/events/hw_breakpoint_test.c:70
> > |     Expected IS_ERR(bp) to be false, but is true
> > |     not ok 8 - test_two_tasks_on_one_all_cpus
> > |     # test_task_on_all_and_one_cpu: ASSERTION FAILED at kernel/events/hw_breakpoint_test.c:70
> > |     Expected IS_ERR(bp) to be false, but is true
> > |     not ok 9 - test_task_on_all_and_one_cpu
> > | # hw_breakpoint: pass:2 fail:7 skip:0 total:9
> > | # Totals: pass:2 fail:7 skip:0 total:9
> >
> > ... which seems to be becasue arm64 currently forbids per-task
> > breakpoints/watchpoints in hw_breakpoint_arch_parse(), where we have:
> >
> >         /*
> >          * Disallow per-task kernel breakpoints since these would
> >          * complicate the stepping code.
> >          */
> >         if (hw->ctrl.privilege == AARCH64_BREAKPOINT_EL1 && bp->hw.target)
> >                 return -EINVAL;
> >
> > ... which has been the case since day one in commit:
> >
> >   478fcb2cdb2351dc ("arm64: Debugging support")
> >
> > I'm not immediately sure what would be necessary to support per-task kernel
> > breakpoints, but given a lot of that state is currently per-cpu, I imagine it's
> > invasive.
>
> I would actually like to remove HW_BREAKPOINT completely for arm64 as it
> doesn't really work and causes problems for other interfaces such as ptrace
> and kgdb.

Will it be a localized removal of code that will be easy to revert in
future? Or will it touch lots of code here and there?
Let's say we come up with a very important use case for HW_BREAKPOINT
and will need to make it work on arm64 as well in future.
