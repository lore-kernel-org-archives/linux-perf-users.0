Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA338C54E94
	for <linux-perf-users@archiver.kernel.org>; Wed, 25 Jan 2023 00:37:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230009AbjAYAhS (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 24 Jan 2023 19:37:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229953AbjAYAhS (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 24 Jan 2023 19:37:18 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E06983C282
        for <linux-perf-users@vger.kernel.org>; Tue, 24 Jan 2023 16:37:15 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id c10-20020a05600c0a4a00b003db0636ff84so229679wmq.0
        for <linux-perf-users@vger.kernel.org>; Tue, 24 Jan 2023 16:37:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=g4Wb+bpQZUnuTNyGXIvMs5HIWXZWGaHBxLMtrVvV/BE=;
        b=pjrFeepiiZUG2XtwxDkMyqR8/hvfkY9agqMqj27ha01EgmCKQeArZ1iEvDd3YiOXj+
         KXaZ66CsGBjoA03O9yR6cK61NTg7pVTc9VxIEjbv6ElsoVT4YmxSsek+s61OnmHO2U9b
         BJOWm4eEKvtMZRDzVGbzkzFXhWePYYPMPFbyagxYqfclFms8EeEKCrm2Q28h+zDIQHUF
         rpKuSyIx/mrhPq0unS1BIPEh3CRQnn8CxwCXjMLoqL+ifVyVP3bHmQ79/Fzdn/OD+WYA
         g6nvpu5Dsk2zTZlPbXiy6qz01+R7Q/nOCS5pXNZmnpfnXED34Gb0/Z0VR5FEQBEkE5dK
         wpXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=g4Wb+bpQZUnuTNyGXIvMs5HIWXZWGaHBxLMtrVvV/BE=;
        b=7KRmdzgCDuI2FuUy8VYR+iGU8WMf4qHgwQ5U4QrZwAZJ3TrdR7hm533yrtv4MWga/d
         pM0TZtQiG+kLnL3WbH+kYAcKBgLbP/AtfQwQHakD3yTEB6V83Doj4+TKVNw1Kz0Do0fP
         qcu/k/mftiMv0fQCWa/SErzy40aqf/etE1msQGxunInJ6F2cWnYJ6wkbp6qEcraVG4Y+
         P7CcxfpkCuc/qwh8wnpHS9o21SqKjvINFSJ5QFPJZjaVR3102VWF0DLP7LqxgzAoqdiL
         LyfetAOJgmXkSAp+kBtU/LpaFLC0LiG95coB9y/WqqvVGt+TuY5GcVK8GDSg03EksbfR
         KBxg==
X-Gm-Message-State: AFqh2kpFrXHbUYi4XxwdAVYeWaRfV30m49JJ46PcF5ctccg4LjtzCjUp
        a3s6GbtqmiIgjqcDRYBkbb+pvYwC79IoxKy+Tus0Gg==
X-Google-Smtp-Source: AMrXdXs4C5YzkW6c68HcuqU2D+OJbmnHxVKPIknKE7o2PXqO5Qu+JLIwyAIxHyWeBT6YXYD6JqIKtMvHID9i9asSFBg=
X-Received: by 2002:a05:600c:1c9a:b0:3d9:ee45:8a9e with SMTP id
 k26-20020a05600c1c9a00b003d9ee458a9emr1410146wms.174.1674607034233; Tue, 24
 Jan 2023 16:37:14 -0800 (PST)
MIME-Version: 1.0
References: <20230120134039.17788-1-mpetlan@redhat.com> <CAP-5=fXuNW2XYomrxViwzQThVQpwF5Cvo+UuQ_da3QiUESwAmw@mail.gmail.com>
 <alpine.LRH.2.20.2301241751180.5281@Diego>
In-Reply-To: <alpine.LRH.2.20.2301241751180.5281@Diego>
From:   Ian Rogers <irogers@google.com>
Date:   Tue, 24 Jan 2023 16:37:01 -0800
Message-ID: <CAP-5=fUr8KV1Q9qsQXqg7czbkG7Xh7GKBosx8ahtVuahSdJgVw@mail.gmail.com>
Subject: Re: [PATCH 0/2] perf test: Fix JSON linter
To:     Michael Petlan <mpetlan@redhat.com>
Cc:     Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org, acme@kernel.org, acme@redhat.com,
        qzhao@redhat.com, cjense@google.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Tue, Jan 24, 2023 at 9:39 AM Michael Petlan <mpetlan@redhat.com> wrote:
>
> On Fri, 20 Jan 2023, Ian Rogers wrote:
> > On Fri, Jan 20, 2023 at 5:41 AM Michael Petlan <mpetlan@redhat.com> wrote:
> > >
> > > Hello all.
> > >
> > > We have observed issues with the 'perf stat JSON output linter' testcase
> > > on systems that allow topdown metrics.
> > >
> > > =========================
> > >
> [...]
> > > 2) Since the JSON printing engine thinks that one and only one metric
> > > is printed, it always closes the line by adding '}'. This is not true,
> > > so I have fixed the comma printing and adjusted the engine to be
> > > capable of printing 1-N metrics and then close the line.
> >
> > So the current printing code is messy. For example, there is a newline
> > callback function, but that has little meaning for json where
> > everything is on a newline. For CSV mode, adding a summary used to
> > cause a column to suddenly appear on the left for the row containing
> > the summary. I believe the right thing to do is a refactor and
> > recently I did a similar refactor for 'perf list':
> > https://lore.kernel.org/lkml/20221114210723.2749751-11-irogers@google.com/
> > So it is strange that metrics are "shadows" of events, but whatever
> > the point is to think about the printing API. In the change linked
> > above you can see that everytime something is printed the print
> > handling code is given all the information and the print handling code
> > has state. Based on the state and callback's information, the print
> > handling code can do nothing, properly format for CSV, json, etc. This
> > gets completely away from the kind of madness of branches and
> > whac-a-mole the code currently has.
> >
> > I'm happy to look at doing the refactor to be similar to 'perf
> > list'/builtin-list.c. Namhyung I thought might have gotten to it with
> > his recent work on improving aggregation. If I hear silence then I'll
> > assume that is a request I do it :-)
> >
> > Pragmatically in the short term we could land your changes, but I
> > worry they are more of the whac-a-mole and something somewhere else
> > will break. Which is why we have a test, and so I'm not overly
> > worried. I can download and test too.
> >
> > Anyway, sorry for the issue and let me know what you think. Thanks,
> > Ian
>
> Hello.
>
> I think that applying the patchset won't make things worse, eventhough
> we know it would deserve a better solution for the whole print engine.
>
> Yes, we have a test, but maybe that's what should be improved first,
> since it does not actually verify the format correctness. I have hit
> the problem because of failing test, but the fail cause was that there
> were too many commas, but strings like
>
>   "Heavy Operations"}"metric-value"
>
> are still OK according to the linter.
>
> Proper JSON linter might be in some library, but we don't want to add
> too many dependencies I guess.
>
> Maybe some simple JSON linter I used when preparing the patchset would
> be enough for our perf-stat output... I'll convert it to Python and
> post it to see.

I've been trying to tidy up the libraries under tools/lib recently,
and their build. I'm hoping that with this we can have more statically
built in libraries rather than a big monolithic application. In part
for testing reasons, but also separation of concerns and the like.
Fwiw, we did have a json reader library from jsmn in the pmu-events
jevents.c code in the past. As it was never updated and had become
forked, I wasn't a huge fan of it.

> =============================
>
> Finally, speaking of tests, I think that thinking of integrating the
> external perf testsuite [1] might be a better approach than adding
> new shell-based tests such as "perf stat tests", etc. Tests like that
> have been already written, see [1].
>
> Some years ago, I was trying to add it to perf-test, however it was
> unsuccessful, but since then, many shell-based tests were added
> instead and I think they slightly duplicate the work already done.
>
> Thoughts?
> Michael
>
> [1] https://github.com/rfmvh/perftool-testsuite

As someone who maintains a build, I'd love to see all of the perf
testing in the kernel tree :-) What do you think would be the best
strategy to integrate the test suite? Perhaps create a new directory
under perf/tools/tests/shell, add the tests there and then add a
wrapper shell script that invokes them all as one large shell test.
From this we can work to have smaller tests, better output within perf
test, etc. I think it'd be best for you to do an initial push, but I'd
be willing to help from then on.

Thanks,
Ian

> >
> >
> > > =========================
> > >
> > > On machines that don't support topdown, the problem can be shown by
> > > doubling the following line in util/stat-shadow.c, so that the simple
> > > 'insn per cycle' metric is printed twice:
> > >
> > >   print_metric(config, ctxp, NULL, "%7.2f ", "insn per cycle", ratio);
> > >
> > > The worst problem is that the JSON line is broken, such as:
> > >
> > > ... "pcnt-running" : 100.00, "metric-value" : 3.501931, "metric-unit"
> > >     : "Heavy Operations"}"metric-value" : 14.007787, "metric-unit" : ...
> > >                   here ^^^^^
> > >
> > > =========================
> > >
> > > The first patch solves the JSON output correctness, the second tries
> > > to adjust the testcase to some extent, so that it should work on the
> > > topdown-capable machines.
> > >
> > > However, it's highly possible that the testcase will have to be fixed
> > > or maybe rewritten in future. First, it has quite naive evaluation of
> > > what's expected/correct/etc. Second, it does no JSON format validation
> > > at all. As a linter it should do so though.
> > >
> > >  ***
> > >
> > > For further discussion: What about removing the check for number of
> > > expected elements in the line and just check for the keywords, such
> > > as "metric-value", "counter-value", "event", etc. and for some values
> > > that should be numeric. And, do proper JSON format sanity check?
> > >
> > >
> > > Thank you for inputs!
> > >
> > > Michael
> > >
> > >
> > >
> > >
> > > Michael Petlan (2):
> > >   perf stat: Fix JSON metric printout for multiple metrics per line
> > >   perf test: Fix JSON format linter test checks
> > >
> > >  .../tests/shell/lib/perf_json_output_lint.py  | 16 +++++------
> > >  tools/perf/util/stat-display.c                | 28 +++++++++++--------
> > >  2 files changed, 24 insertions(+), 20 deletions(-)
> > >
> > > --
> > > 2.18.4
> > >
> >
> >
>
