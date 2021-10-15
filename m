Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAD42C433EF
	for <linux-perf-users@archiver.kernel.org>; Fri, 15 Oct 2021 15:53:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 89D24611C3
	for <linux-perf-users@archiver.kernel.org>; Fri, 15 Oct 2021 15:53:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237221AbhJOPzi (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 15 Oct 2021 11:55:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:40974 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241057AbhJOPzh (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 15 Oct 2021 11:55:37 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 84B47611C3;
        Fri, 15 Oct 2021 15:53:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634313210;
        bh=tS7FNEBnAqgSHdk65hsLK29FdzL2hDC78AqH8UwzefQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=OHrT4b+SXSuzTq0H9xDZZZmLV0zTtfVyFhvo0WO+8kDr+LNwOlJwZyu236ozwh1P1
         z1vxqAjo/G2GZMv/36ip5n1rnG/PrlIJ2DRS4cce8m/X2T+ppbftBvWLTmL+IcoJfO
         DdhmyBKbUoL/+En8EUTqYo8qKEY6rNc28nYOtMAxpXcI0/ELQaDQ18lojFFS+LggTO
         ja94yuGAkrgzF81MNoaBGitniK3CZr5Cy0ggPOKEaHXn78wEf+HmmtkLeKOCvIizyi
         sAQfqUyjIS50kyOm0VLdHCBQm/RE0zUDOfuU+/nPYxu4loQGJ/jebSivyV4SMfCO9w
         5fLI0WllxY6dg==
Received: by mail-ed1-f44.google.com with SMTP id 5so9652748edw.7;
        Fri, 15 Oct 2021 08:53:30 -0700 (PDT)
X-Gm-Message-State: AOAM531EvUv+o6Gx+uQAr0vaYzUTEIBEjqhszrOd09gfTQ9ACytKwQCy
        1cIAgsWkZC6Z1VwrQFGIE4CGNv2ZJ2kb9tnbSw==
X-Google-Smtp-Source: ABdhPJyunKq1cAJC1qKjKHXJiMRTFQMjgAl20IaC76YoHiF4Qkdg9DiyQSuuX7aMF23U9kNTRN7zoPQXaEPnO3vi8No=
X-Received: by 2002:a17:906:71d4:: with SMTP id i20mr7804418ejk.390.1634313206877;
 Fri, 15 Oct 2021 08:53:26 -0700 (PDT)
MIME-Version: 1.0
References: <20210914204800.3945732-1-robh@kernel.org> <20210914204800.3945732-5-robh@kernel.org>
 <20211014165810.GA39276@lakrids.cambridge.arm.com>
In-Reply-To: <20211014165810.GA39276@lakrids.cambridge.arm.com>
From:   Rob Herring <robh@kernel.org>
Date:   Fri, 15 Oct 2021 10:53:15 -0500
X-Gmail-Original-Message-ID: <CAL_JsqJHfpcvKekEFm-d7rMJ=UNc7dXwfaMMkUWZYsnPg=QNPQ@mail.gmail.com>
Message-ID: <CAL_JsqJHfpcvKekEFm-d7rMJ=UNc7dXwfaMMkUWZYsnPg=QNPQ@mail.gmail.com>
Subject: Re: [PATCH v10 4/5] arm64: perf: Enable PMU counter userspace access
 for perf event
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Ian Rogers <irogers@google.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Honnappa Nagarahalli <honnappa.nagarahalli@arm.com>,
        Zachary.Leaf@arm.com, Raphael Gault <raphael.gault@arm.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Itaru Kitayama <itaru.kitayama@gmail.com>,
        Vince Weaver <vincent.weaver@maine.edu>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Thu, Oct 14, 2021 at 11:58 AM Mark Rutland <mark.rutland@arm.com> wrote:
>
> Hi Rob,
>
> This looks pretty good!
>
> I have one largish query below, and otherwise only trivialities that I'm
> happy to fix up.
>
> On Tue, Sep 14, 2021 at 03:47:59PM -0500, Rob Herring wrote:

[...]

> >  static inline bool armv8pmu_event_is_chained(struct perf_event *event)
> >  {
> >       int idx = event->hw.idx;
> >       struct arm_pmu *cpu_pmu = to_arm_pmu(event->pmu);
> >
> > -     return !WARN_ON(idx < 0) &&
> > +     return !(event->hw.flags & PERF_EVENT_FLAG_USER_READ_CNT) &&
> >              armv8pmu_event_is_64bit(event) &&
> >              !armv8pmu_has_long_event(cpu_pmu) &&
> >              (idx != ARMV8_IDX_CYCLE_COUNTER);
> > @@ -720,6 +726,27 @@ static inline u32 armv8pmu_getreset_flags(void)
> >       return value;
>
> Above this, could we please add:
>
> | static inline bool armv8pmu_event_has_user_read(struct perf_event *event)
> | {
> |       return event->hw.flags & PERF_EVENT_FLAG_USER_READ_CNT;
> | }
>
> ... and use that where we look at PERF_EVENT_FLAG_USER_READ_CNT?

Sure, but as this is a common flag now, I should probably make that a
common function in linux/perf_event.h and have x86 code use it too.

Rob
