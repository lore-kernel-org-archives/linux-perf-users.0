Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A6C2C05027
	for <linux-perf-users@archiver.kernel.org>; Mon, 23 Jan 2023 06:48:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230106AbjAWGsx (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 23 Jan 2023 01:48:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbjAWGsw (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 23 Jan 2023 01:48:52 -0500
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56F911204A
        for <linux-perf-users@vger.kernel.org>; Sun, 22 Jan 2023 22:48:51 -0800 (PST)
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-4d59d518505so159504117b3.1
        for <linux-perf-users@vger.kernel.org>; Sun, 22 Jan 2023 22:48:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tCvFemEDKg4uFHgscFbWDBK/LbOfRLQaDJ94Ppnt7hs=;
        b=Yc598FRrkAOBrPcQLyesRDMZ1F8ydLWjqRrLlVkgCxC/GxM/UFlq3J3U1cLk8bM8Pp
         PtYdpsGQYZre4qE+EAcQtOqE9rXIMpeJksxLat1Vhw2UvgBJZB4jtwvE9tsBgu8zVL40
         94x4SW0Y1UgYthqN4Hiiv9RGafxfcXkgmPI+uTtVALy80ERvNLlgg9B8WN86/WKw6SEh
         tm43D4Rjeg/RgwrK+CGVwSHBsvZV2+B2DkQPRqmBuJGe+OkAuQmCPhPbv/sYdM5OK8FH
         Xd5rfKrTRLGpsgSntHgIScyvcbG74UMbebfYyX2UlIAxU6zOKYm51yFlKT7EfxLYOEXq
         dYaA==
X-Gm-Message-State: AFqh2krAtJXpQDZvOZ7uLlX0MJtzBKEG2+UPAPFMzTYJDChojWzMvj5U
        DW4M+9KLE95AGEoeHIRB0HSqQpNGGfEEC1PjiLg=
X-Google-Smtp-Source: AMrXdXsEvSzQP6wvqhA6KI3sM1kcHWcsL9AsT1cI8cFjNZx86n7NVrEfb7+yV58E9eBHWgV18tcdn/xcCtIMtrTFP6U=
X-Received: by 2002:a0d:dd41:0:b0:500:e6a3:a141 with SMTP id
 g62-20020a0ddd41000000b00500e6a3a141mr1183281ywe.470.1674456530410; Sun, 22
 Jan 2023 22:48:50 -0800 (PST)
MIME-Version: 1.0
References: <20230120134039.17788-1-mpetlan@redhat.com> <CAP-5=fXuNW2XYomrxViwzQThVQpwF5Cvo+UuQ_da3QiUESwAmw@mail.gmail.com>
In-Reply-To: <CAP-5=fXuNW2XYomrxViwzQThVQpwF5Cvo+UuQ_da3QiUESwAmw@mail.gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Sun, 22 Jan 2023 22:48:37 -0800
Message-ID: <CAM9d7cg76WWpvEthT_MHvvdfJUY6kjFV2RNMzCr_HDiaCz5Ofg@mail.gmail.com>
Subject: Re: [PATCH 0/2] perf test: Fix JSON linter
To:     Ian Rogers <irogers@google.com>
Cc:     Michael Petlan <mpetlan@redhat.com>,
        linux-perf-users@vger.kernel.org, acme@kernel.org, acme@redhat.com,
        qzhao@redhat.com, cjense@google.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Fri, Jan 20, 2023 at 9:37 AM Ian Rogers <irogers@google.com> wrote:
>
> On Fri, Jan 20, 2023 at 5:41 AM Michael Petlan <mpetlan@redhat.com> wrote:
> >
> > Hello all.
> >
> > We have observed issues with the 'perf stat JSON output linter' testcase
> > on systems that allow topdown metrics.
> >
> > =========================
> >
> > 1) The topdown metrics handling hardcodes printing more than one metric
> > per line (refer to util/stat-shadow.c):
> >
> >     if (retiring > 0.7 && heavy_ops > 0.1)
> >         color = PERF_COLOR_GREEN;
> >     print_metric(config, ctxp, color, "%8.1f%%", "Heavy Operations",
> >             heavy_ops * 100.);
> >     if (retiring > 0.7 && light_ops > 0.6)
> >         color = PERF_COLOR_GREEN;
> >     else
> >         color = NULL;
> >     print_metric(config, ctxp, color, "%8.1f%%", "Light Operations",
> >             light_ops * 100.);
> >
> > Thus, the test cannot rely on the fact that there will be only one
> > metric per line.
>
> Right, these implicit metrics are also an issue with --metric-only. It
> isn't clear from the command line flags when implicit and listed
> metrics should be generated. The topdown events (Icelake+) made the
> implicit metric problem worse, and they likely didn't exist or weren't
> tested at the time of the json output.
>
> > 2) Since the JSON printing engine thinks that one and only one metric
> > is printed, it always closes the line by adding '}'. This is not true,
> > so I have fixed the comma printing and adjusted the engine to be
> > capable of printing 1-N metrics and then close the line.
>
> So the current printing code is messy. For example, there is a newline
> callback function, but that has little meaning for json where
> everything is on a newline. For CSV mode, adding a summary used to
> cause a column to suddenly appear on the left for the row containing
> the summary. I believe the right thing to do is a refactor and
> recently I did a similar refactor for 'perf list':
> https://lore.kernel.org/lkml/20221114210723.2749751-11-irogers@google.com/
> So it is strange that metrics are "shadows" of events, but whatever
> the point is to think about the printing API. In the change linked
> above you can see that everytime something is printed the print
> handling code is given all the information and the print handling code
> has state. Based on the state and callback's information, the print
> handling code can do nothing, properly format for CSV, json, etc. This
> gets completely away from the kind of madness of branches and
> whac-a-mole the code currently has.

Maybe we could reuse the tools/bpf/bpftool/json_writer.[ch].
It'd be nice to think about it as objects and attributes.

Thanks,
Namhyung


>
> I'm happy to look at doing the refactor to be similar to 'perf
> list'/builtin-list.c. Namhyung I thought might have gotten to it with
> his recent work on improving aggregation. If I hear silence then I'll
> assume that is a request I do it :-)
>
> Pragmatically in the short term we could land your changes, but I
> worry they are more of the whac-a-mole and something somewhere else
> will break. Which is why we have a test, and so I'm not overly
> worried. I can download and test too.
>
> Anyway, sorry for the issue and let me know what you think. Thanks,
> Ian
>
>
> > =========================
> >
> > On machines that don't support topdown, the problem can be shown by
> > doubling the following line in util/stat-shadow.c, so that the simple
> > 'insn per cycle' metric is printed twice:
> >
> >   print_metric(config, ctxp, NULL, "%7.2f ", "insn per cycle", ratio);
> >
> > The worst problem is that the JSON line is broken, such as:
> >
> > ... "pcnt-running" : 100.00, "metric-value" : 3.501931, "metric-unit"
> >     : "Heavy Operations"}"metric-value" : 14.007787, "metric-unit" : ...
> >                   here ^^^^^
> >
> > =========================
> >
> > The first patch solves the JSON output correctness, the second tries
> > to adjust the testcase to some extent, so that it should work on the
> > topdown-capable machines.
> >
> > However, it's highly possible that the testcase will have to be fixed
> > or maybe rewritten in future. First, it has quite naive evaluation of
> > what's expected/correct/etc. Second, it does no JSON format validation
> > at all. As a linter it should do so though.
> >
> >  ***
> >
> > For further discussion: What about removing the check for number of
> > expected elements in the line and just check for the keywords, such
> > as "metric-value", "counter-value", "event", etc. and for some values
> > that should be numeric. And, do proper JSON format sanity check?
> >
> >
> > Thank you for inputs!
> >
> > Michael
> >
> >
> >
> >
> > Michael Petlan (2):
> >   perf stat: Fix JSON metric printout for multiple metrics per line
> >   perf test: Fix JSON format linter test checks
> >
> >  .../tests/shell/lib/perf_json_output_lint.py  | 16 +++++------
> >  tools/perf/util/stat-display.c                | 28 +++++++++++--------
> >  2 files changed, 24 insertions(+), 20 deletions(-)
> >
> > --
> > 2.18.4
> >
