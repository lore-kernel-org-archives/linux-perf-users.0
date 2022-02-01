Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EC9AC433F5
	for <linux-perf-users@archiver.kernel.org>; Tue,  1 Feb 2022 07:33:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234008AbiBAHdj (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 1 Feb 2022 02:33:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234967AbiBAHdg (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 1 Feb 2022 02:33:36 -0500
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81311C06173D
        for <linux-perf-users@vger.kernel.org>; Mon, 31 Jan 2022 23:33:36 -0800 (PST)
Received: by mail-oi1-x235.google.com with SMTP id x193so31785628oix.0
        for <linux-perf-users@vger.kernel.org>; Mon, 31 Jan 2022 23:33:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=I8UdammtyVx5EZAt87tg0T0RNHOojMP8yJWvr7M56iQ=;
        b=haoGVsVQAzGG2SPFci3XpfbSPiur+S28MMUzpS69ADK382iF+H+IUehv+dLvTBxrrq
         H/D2k9krPqqnf2rJC+99Kf8glCUGOMSUMbAH/I2E2RzHiDs8Y4fEASgximwWzi11P5pg
         vB7TF/tVgQN6wPnbDMVk+EtxU5I7F3OXE6VVvPzGukA/hUaAaToUM3bHabj3+lweVQyh
         SOEKKWKCrxAsELqwIIcmtGNO8kA8BoBuaXg8VVCTA4JlPhVnbcJBtJ16nuJUWU6yQFCh
         LBJYPpClY6swn7+iIZoyH2WEY1VdI7kjpkf+vGdlvT9nhKs3feD0i1Pr2YNoj+mMA5bN
         dscg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=I8UdammtyVx5EZAt87tg0T0RNHOojMP8yJWvr7M56iQ=;
        b=ZzxaxqFoX0sQRNLv++z7ldYe0U3QbWMkxAUuwuUUB9E8YFaiYrthFA8A4FRtPs9QgP
         ej6QI/pXeLUaZCTetDJz7SXTcHtjR0Xqm6Fx/AKVVVDkOIhkxUiTPrzGduNV5uasPEin
         yYmD/AsUCjLEaEJGNOhF5CcaXNiCpb/dOfwFvAFlFIaT7GtwGupJIs+4ERpS50CpsKGE
         G+hi7B+A/zYTOfvrDZ07PdqaNWKGkSMkKDNjnSsIybKQYGwpoFtNKMlhWuERaoN7vkt4
         43/5r/MY3azTXlNJcpkU7eZmV9hIc3OwY47owwgWwXrhiMQzZhpiPLVx0kbgPSnvLjNa
         QSnA==
X-Gm-Message-State: AOAM532xCmfiQc1Vc6Xu1Nis8D6J65xz8Txi96oaKU0EiXrU4TehaPsx
        Q9gqbKLqPq1uuERX1bE4+ALxmXyOhHg8D6t3d8kxXg==
X-Google-Smtp-Source: ABdhPJy26D1ewz7OBehQImCy7Emi3FxJ0U1d3ccorWuiWoINBgO9zfb3ky9sHHioPq168bjuzVh+9mr6pljjfAkoCls=
X-Received: by 2002:a05:6808:1188:: with SMTP id j8mr395888oil.195.1643700815629;
 Mon, 31 Jan 2022 23:33:35 -0800 (PST)
MIME-Version: 1.0
References: <20220131103407.1971678-1-elver@google.com> <20220131103407.1971678-2-elver@google.com>
In-Reply-To: <20220131103407.1971678-2-elver@google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Tue, 1 Feb 2022 08:33:24 +0100
Message-ID: <CACT4Y+b3cpG_L+UO=vvRtPdBh7Np5U4AA5_WuK7s7FUazuBvwQ@mail.gmail.com>
Subject: Re: [PATCH 2/3] selftests/perf_events: Test modification of perf_event_attr::sig_data
To:     Marco Elver <elver@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org, kasan-dev@googlegroups.com,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Mon, 31 Jan 2022 at 11:34, Marco Elver <elver@google.com> wrote:
>
> Test that PERF_EVENT_IOC_MODIFY_ATTRIBUTES correctly modifies
> perf_event_attr::sig_data as well.
>
> Signed-off-by: Marco Elver <elver@google.com>

Reviewed-by: Dmitry Vyukov <dvyukov@google.com>


> ---
>  .../selftests/perf_events/sigtrap_threads.c     | 17 +++++++++--------
>  1 file changed, 9 insertions(+), 8 deletions(-)
>
> diff --git a/tools/testing/selftests/perf_events/sigtrap_threads.c b/tools/testing/selftests/perf_events/sigtrap_threads.c
> index 8e83cf91513a..6d849dc2bee0 100644
> --- a/tools/testing/selftests/perf_events/sigtrap_threads.c
> +++ b/tools/testing/selftests/perf_events/sigtrap_threads.c
> @@ -44,9 +44,10 @@ static struct {
>  } ctx;
>
>  /* Unique value to check si_perf_data is correctly set from perf_event_attr::sig_data. */
> -#define TEST_SIG_DATA(addr) (~(unsigned long)(addr))
> +#define TEST_SIG_DATA(addr, id) (~(unsigned long)(addr) + id)
>
> -static struct perf_event_attr make_event_attr(bool enabled, volatile void *addr)
> +static struct perf_event_attr make_event_attr(bool enabled, volatile void *addr,
> +                                             unsigned long id)
>  {
>         struct perf_event_attr attr = {
>                 .type           = PERF_TYPE_BREAKPOINT,
> @@ -60,7 +61,7 @@ static struct perf_event_attr make_event_attr(bool enabled, volatile void *addr)
>                 .inherit_thread = 1, /* ... but only cloned with CLONE_THREAD. */
>                 .remove_on_exec = 1, /* Required by sigtrap. */
>                 .sigtrap        = 1, /* Request synchronous SIGTRAP on event. */
> -               .sig_data       = TEST_SIG_DATA(addr),
> +               .sig_data       = TEST_SIG_DATA(addr, id),
>         };
>         return attr;
>  }
> @@ -110,7 +111,7 @@ FIXTURE(sigtrap_threads)
>
>  FIXTURE_SETUP(sigtrap_threads)
>  {
> -       struct perf_event_attr attr = make_event_attr(false, &ctx.iterate_on);
> +       struct perf_event_attr attr = make_event_attr(false, &ctx.iterate_on, 0);
>         struct sigaction action = {};
>         int i;
>
> @@ -165,7 +166,7 @@ TEST_F(sigtrap_threads, enable_event)
>         EXPECT_EQ(ctx.tids_want_signal, 0);
>         EXPECT_EQ(ctx.first_siginfo.si_addr, &ctx.iterate_on);
>         EXPECT_EQ(ctx.first_siginfo.si_perf_type, PERF_TYPE_BREAKPOINT);
> -       EXPECT_EQ(ctx.first_siginfo.si_perf_data, TEST_SIG_DATA(&ctx.iterate_on));
> +       EXPECT_EQ(ctx.first_siginfo.si_perf_data, TEST_SIG_DATA(&ctx.iterate_on, 0));
>
>         /* Check enabled for parent. */
>         ctx.iterate_on = 0;
> @@ -175,7 +176,7 @@ TEST_F(sigtrap_threads, enable_event)
>  /* Test that modification propagates to all inherited events. */
>  TEST_F(sigtrap_threads, modify_and_enable_event)
>  {
> -       struct perf_event_attr new_attr = make_event_attr(true, &ctx.iterate_on);
> +       struct perf_event_attr new_attr = make_event_attr(true, &ctx.iterate_on, 42);
>
>         EXPECT_EQ(ioctl(self->fd, PERF_EVENT_IOC_MODIFY_ATTRIBUTES, &new_attr), 0);
>         run_test_threads(_metadata, self);
> @@ -184,7 +185,7 @@ TEST_F(sigtrap_threads, modify_and_enable_event)
>         EXPECT_EQ(ctx.tids_want_signal, 0);
>         EXPECT_EQ(ctx.first_siginfo.si_addr, &ctx.iterate_on);
>         EXPECT_EQ(ctx.first_siginfo.si_perf_type, PERF_TYPE_BREAKPOINT);
> -       EXPECT_EQ(ctx.first_siginfo.si_perf_data, TEST_SIG_DATA(&ctx.iterate_on));
> +       EXPECT_EQ(ctx.first_siginfo.si_perf_data, TEST_SIG_DATA(&ctx.iterate_on, 42));
>
>         /* Check enabled for parent. */
>         ctx.iterate_on = 0;
> @@ -204,7 +205,7 @@ TEST_F(sigtrap_threads, signal_stress)
>         EXPECT_EQ(ctx.tids_want_signal, 0);
>         EXPECT_EQ(ctx.first_siginfo.si_addr, &ctx.iterate_on);
>         EXPECT_EQ(ctx.first_siginfo.si_perf_type, PERF_TYPE_BREAKPOINT);
> -       EXPECT_EQ(ctx.first_siginfo.si_perf_data, TEST_SIG_DATA(&ctx.iterate_on));
> +       EXPECT_EQ(ctx.first_siginfo.si_perf_data, TEST_SIG_DATA(&ctx.iterate_on, 0));
>  }
>
>  TEST_HARNESS_MAIN
> --
> 2.35.0.rc2.247.g8bbb082509-goog
>
