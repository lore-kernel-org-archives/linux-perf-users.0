Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20FB7C4321E
	for <linux-perf-users@archiver.kernel.org>; Wed, 30 Nov 2022 20:18:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230154AbiK3USC (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 30 Nov 2022 15:18:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230346AbiK3URU (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 30 Nov 2022 15:17:20 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4D47934CF
        for <linux-perf-users@vger.kernel.org>; Wed, 30 Nov 2022 12:13:24 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id h11so21651057wrw.13
        for <linux-perf-users@vger.kernel.org>; Wed, 30 Nov 2022 12:13:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=2AAz1p3amdjSsxmPSJU+uGZAdAbSjyxAbikHqGyzpmk=;
        b=nCNaAYb3XzkERXQkz2iPfkCS79RviSzmXslWPza+frd/CWKfVpYgJwneIY7uYo0TJE
         kTbxjGHIjrWKsDkbC77zJRHJIZY8KNuLnUwx/6LFHKUJ0Rj35SAew4DrxVajLXWcYNoW
         5+VTUZzEfuSwVKPFQK4L3hTKlZtN51Lpl0yL7hQ80XRYqz0ZZUMpdy+61UlN2IBdNAD+
         kje/YBR6vT4oA5Pw74sFZBmbBKnW8QtQtP4ngiGm3HefZOjiJ0OTB/tKpK6i943h0XvF
         SqljAkss+WFcGjsgETKJIo3dhnHpqwyKWI2GcEMp0dJSvYtIIePuC5E68lx1PbHNWYpQ
         qfGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2AAz1p3amdjSsxmPSJU+uGZAdAbSjyxAbikHqGyzpmk=;
        b=1th3aqWQ4DeqmUa1Bzu5wDRr52VZLjwJpkRLb0tB3skzmfRXZRYbnh8O57Vnrn9vL3
         u6uI4OpaQXhr4D6J+h7Az13JLXRHQBY3Vq/JeVq9qw7RBGqq7s/wdlDwNSV40q2CRVtf
         rlG0RV3rTwsoxt57Vq90qPhxuQT4QwAJ+wka35M7BaDKACIYvRdSUCIA76DB70Oh3rtc
         13YOeuviHWKQgQ9JDOsU9UBvcVG6yuHJRpLYBb2/xp+Q98ebjHanOWkjmjiOLnVk2nHf
         Skqkfis9AohMfXu4erVyXwooUNzmlb+O+aqlxM/7btBXWLZoUFtX94NnRWj3YpWermsY
         FvOw==
X-Gm-Message-State: ANoB5pn23sEaYDaIx4TAfEDmeFQ6z7o9Y5oYr7vxxvkztgb03k4Qsnj2
        8L/wxQJAodRCm+GDoidAHdV6XjqUwQmtCl2/OsI/0A==
X-Google-Smtp-Source: AA0mqf61KLGmp/Qm9g4FE973BvCOpu9OqNPOjOG4J5nE13JCMq7A8rvlH6yRlbfRF5bTYaCm/bglFAEjkAec+P1WlEc=
X-Received: by 2002:adf:e64f:0:b0:241:e2f1:8b44 with SMTP id
 b15-20020adfe64f000000b00241e2f18b44mr25818541wrn.300.1669839202034; Wed, 30
 Nov 2022 12:13:22 -0800 (PST)
MIME-Version: 1.0
References: <20221130062935.2219247-1-irogers@google.com> <20221130062935.2219247-4-irogers@google.com>
 <CAM9d7chrsLHoGe=RcU2e5hRL22j=813j3uuEHDOPZrkpWqnSsw@mail.gmail.com>
In-Reply-To: <CAM9d7chrsLHoGe=RcU2e5hRL22j=813j3uuEHDOPZrkpWqnSsw@mail.gmail.com>
From:   Ian Rogers <irogers@google.com>
Date:   Wed, 30 Nov 2022 12:13:10 -0800
Message-ID: <CAP-5=fWZVHN5tDG+eKRr7v_RXKYA_uUgY-dFH_g3Yc3mFgkXbA@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] perf build: Use libtraceevent from the system
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Leo Yan <leo.yan@linaro.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Wed, Nov 30, 2022 at 11:05 AM Namhyung Kim <namhyung@kernel.org> wrote:
>
> On Tue, Nov 29, 2022 at 10:30 PM Ian Rogers <irogers@google.com> wrote:
> >
> > Remove the LIBTRACEEVENT_DYNAMIC and LIBTRACEFS_DYNAMIC. If
> > libtraceevent isn't installed or NO_LIBTRACEEVENT=1 is passed to the
> > build, don't compile in libtraceevent and libtracefs support. This
> > also disables CONFIG_TRACE that controls "perf
> > trace". CONFIG_TRACEEVENT is used to control enablement in
> > Build/Makefiles, HAVE_LIBTRACEEVENT is used in C code. Without
> > HAVE_LIBTRACEEVENT tracepoints are disabled and as such the commands
> > kmem, kwork, lock, sched and timechart are removed. The majority of
> > commands continue to work including "perf test".
>
> Maybe we can have a different approach.  I guess the trace data
> access is isolated then we can make dummy interfaces when there's
> no libtraceevent.  This way we don't need to touch every command
> and let it fail when it's asked.

Sounds like a worthwhile refactor that can land on top of this change.

> The motivation is that we should be able to run the sub-commands
> as much as possible.  In fact, we could run 'record' part only on the
> target machine and pass the data to the host for analysis with a
> full-fledged perf.  Also some commands like 'perf lock contention'
> can run with or without libtraceevent (using BPF only).

The issue here is that perf lock contention will use evsel__new_tp and
internally that uses libtraceevent. As such it is removed without
HAVE_LIBTRACEEVENT. Without the evsel there's not much perf lock
contention can do, so rather than litter the code with
HAVE_LIBTRACEEVENT and for it to be broken, I made the choice just to
remove it from the no libtraceevent build for now.

I think it is worth pursuing these patches in the shape they are in so
that we can land the removal of tools/lib/traceevent and ensure the
migration away from an out-of-date version of that library.

Thanks,
Ian

> Thanks,
> Namhyung
