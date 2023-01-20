Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88004C25B4E
	for <linux-perf-users@archiver.kernel.org>; Fri, 20 Jan 2023 17:37:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229727AbjATRhz (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 20 Jan 2023 12:37:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbjATRhz (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 20 Jan 2023 12:37:55 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49B6F6FD07
        for <linux-perf-users@vger.kernel.org>; Fri, 20 Jan 2023 09:37:46 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id q8so4640706wmo.5
        for <linux-perf-users@vger.kernel.org>; Fri, 20 Jan 2023 09:37:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=y1lWz+BlPgiimJpS2PC8hXxGRBmlG/i5xVJ0n8RryUo=;
        b=gsfQ1Py0BpYwbadbxWqNucgL6zciLXY91LhqWWMauAdo730qEPEyU5XqwA+6vp1m8b
         BXe16oRs6Rw/rWHlUVOrJ0YcsEn1BWASM6BrvPB+xYZHsQ7A50ZwU/zPMGBG9YbwlHqk
         i9W1+pcym+Qgk4NtafxuzA/3cM0Dg7lGa/J+66JeQEWiANPGirRjunp7SCLZYL/eX0Bu
         zh+J1nn099z8zsA+KUOblXDp/TA3qlJJF116vSduaM9RL8+3D+3cpKVyLYqFRKomCQS1
         EFMvFxsywBlav6QAf3clYl4+V2aGROFkDW+L8/g5DhKeH0XM/32GX/pD5kcyMN/8a0Bo
         Yv9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=y1lWz+BlPgiimJpS2PC8hXxGRBmlG/i5xVJ0n8RryUo=;
        b=t8h0JNQCuH9d2t2Da2X9GHNGiProjzoo223q4oax4yxCwTK/NAz2mOV/upNMfg4Ljl
         IQ/um62AhhiUzr+fx0tX7EJtbVLKcBKR+gA844upyFYwGe7MHM6SeFDlJRbAuPS/rz7O
         gs4mQW/77ROAFOkFsG/X4cmLxJSsk/Rlui0DcU0eNL8baA+L7AR6g7yaYxJZzVnEVIlo
         fPwk2SBnuU8nQ2tTw73GMox6kq5NlDSRlODoXqOgU6YegwScmOGTps7WsD4vyuwzgiaa
         OiVsMGxCh7g4vS2nZlNiXuQxzxhNfLj3x8bVbKUQfY+L4+Hv6m9v8tT5Hw9fzq7/tbIc
         rbFQ==
X-Gm-Message-State: AFqh2kqSisXSHK99CBMPiXiTTdE17fSsJ9pSNZLoJVFovVq4p7pHHwxi
        w0sFHC81+BPDBzqmkZTtZ/iXTvNPz6r2yNvtf14pKZbesvORK9zQL2A=
X-Google-Smtp-Source: AMrXdXsF9BBHIkP1YHcORX/IWqpnvLHDOVFz1QS7Dm4M0HgcXKWYARHlTvbMAnkbR/aXzAetlduO4QcbJRD9aM1h7g4=
X-Received: by 2002:a05:600c:1c9a:b0:3d9:ee45:8a9e with SMTP id
 k26-20020a05600c1c9a00b003d9ee458a9emr737147wms.174.1674236265240; Fri, 20
 Jan 2023 09:37:45 -0800 (PST)
MIME-Version: 1.0
References: <20230120134039.17788-1-mpetlan@redhat.com>
In-Reply-To: <20230120134039.17788-1-mpetlan@redhat.com>
From:   Ian Rogers <irogers@google.com>
Date:   Fri, 20 Jan 2023 09:37:33 -0800
Message-ID: <CAP-5=fXuNW2XYomrxViwzQThVQpwF5Cvo+UuQ_da3QiUESwAmw@mail.gmail.com>
Subject: Re: [PATCH 0/2] perf test: Fix JSON linter
To:     Michael Petlan <mpetlan@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>
Cc:     linux-perf-users@vger.kernel.org, acme@kernel.org, acme@redhat.com,
        qzhao@redhat.com, cjense@google.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Fri, Jan 20, 2023 at 5:41 AM Michael Petlan <mpetlan@redhat.com> wrote:
>
> Hello all.
>
> We have observed issues with the 'perf stat JSON output linter' testcase
> on systems that allow topdown metrics.
>
> =========================
>
> 1) The topdown metrics handling hardcodes printing more than one metric
> per line (refer to util/stat-shadow.c):
>
>     if (retiring > 0.7 && heavy_ops > 0.1)
>         color = PERF_COLOR_GREEN;
>     print_metric(config, ctxp, color, "%8.1f%%", "Heavy Operations",
>             heavy_ops * 100.);
>     if (retiring > 0.7 && light_ops > 0.6)
>         color = PERF_COLOR_GREEN;
>     else
>         color = NULL;
>     print_metric(config, ctxp, color, "%8.1f%%", "Light Operations",
>             light_ops * 100.);
>
> Thus, the test cannot rely on the fact that there will be only one
> metric per line.

Right, these implicit metrics are also an issue with --metric-only. It
isn't clear from the command line flags when implicit and listed
metrics should be generated. The topdown events (Icelake+) made the
implicit metric problem worse, and they likely didn't exist or weren't
tested at the time of the json output.

> 2) Since the JSON printing engine thinks that one and only one metric
> is printed, it always closes the line by adding '}'. This is not true,
> so I have fixed the comma printing and adjusted the engine to be
> capable of printing 1-N metrics and then close the line.

So the current printing code is messy. For example, there is a newline
callback function, but that has little meaning for json where
everything is on a newline. For CSV mode, adding a summary used to
cause a column to suddenly appear on the left for the row containing
the summary. I believe the right thing to do is a refactor and
recently I did a similar refactor for 'perf list':
https://lore.kernel.org/lkml/20221114210723.2749751-11-irogers@google.com/
So it is strange that metrics are "shadows" of events, but whatever
the point is to think about the printing API. In the change linked
above you can see that everytime something is printed the print
handling code is given all the information and the print handling code
has state. Based on the state and callback's information, the print
handling code can do nothing, properly format for CSV, json, etc. This
gets completely away from the kind of madness of branches and
whac-a-mole the code currently has.

I'm happy to look at doing the refactor to be similar to 'perf
list'/builtin-list.c. Namhyung I thought might have gotten to it with
his recent work on improving aggregation. If I hear silence then I'll
assume that is a request I do it :-)

Pragmatically in the short term we could land your changes, but I
worry they are more of the whac-a-mole and something somewhere else
will break. Which is why we have a test, and so I'm not overly
worried. I can download and test too.

Anyway, sorry for the issue and let me know what you think. Thanks,
Ian


> =========================
>
> On machines that don't support topdown, the problem can be shown by
> doubling the following line in util/stat-shadow.c, so that the simple
> 'insn per cycle' metric is printed twice:
>
>   print_metric(config, ctxp, NULL, "%7.2f ", "insn per cycle", ratio);
>
> The worst problem is that the JSON line is broken, such as:
>
> ... "pcnt-running" : 100.00, "metric-value" : 3.501931, "metric-unit"
>     : "Heavy Operations"}"metric-value" : 14.007787, "metric-unit" : ...
>                   here ^^^^^
>
> =========================
>
> The first patch solves the JSON output correctness, the second tries
> to adjust the testcase to some extent, so that it should work on the
> topdown-capable machines.
>
> However, it's highly possible that the testcase will have to be fixed
> or maybe rewritten in future. First, it has quite naive evaluation of
> what's expected/correct/etc. Second, it does no JSON format validation
> at all. As a linter it should do so though.
>
>  ***
>
> For further discussion: What about removing the check for number of
> expected elements in the line and just check for the keywords, such
> as "metric-value", "counter-value", "event", etc. and for some values
> that should be numeric. And, do proper JSON format sanity check?
>
>
> Thank you for inputs!
>
> Michael
>
>
>
>
> Michael Petlan (2):
>   perf stat: Fix JSON metric printout for multiple metrics per line
>   perf test: Fix JSON format linter test checks
>
>  .../tests/shell/lib/perf_json_output_lint.py  | 16 +++++------
>  tools/perf/util/stat-display.c                | 28 +++++++++++--------
>  2 files changed, 24 insertions(+), 20 deletions(-)
>
> --
> 2.18.4
>
