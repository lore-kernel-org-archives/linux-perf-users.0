Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BA6FC38142
	for <linux-perf-users@archiver.kernel.org>; Mon, 23 Jan 2023 13:38:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231848AbjAWNi3 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 23 Jan 2023 08:38:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231852AbjAWNi2 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 23 Jan 2023 08:38:28 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A559822A0E
        for <linux-perf-users@vger.kernel.org>; Mon, 23 Jan 2023 05:38:24 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 18C8EB80D70
        for <linux-perf-users@vger.kernel.org>; Mon, 23 Jan 2023 13:38:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 670EBC4339C;
        Mon, 23 Jan 2023 13:38:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674481101;
        bh=iVTPu5o2+GTQBTYXbgoB5OgqTtwoF9QZUUwguQ6Ioac=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gyNIM5r1lUFo76JHe7cbL9wN3fgaOw/0m2EwTR6pZBC30jFY1wxUT6DToIuRb0v8M
         ZStV7t+Wy08UGzjzyKvdfqkMDh4YTifcy5aMh6YLdi3ZQJyTXXeTjIOnCsDdLw10PD
         ASGnhYjMQaWpCC7w9y5nIL5nsGJNkBrY2Nfy4MA/oNdcE04LO770uXBzB6rQp9/fG1
         KwTlASC40UhpB+4so9yU9Xg8bOas663rbBVKONhvBiVWWgxQXyVpUC6JywbmgVBxPE
         mu3cGMJnLxuuuGT7dbCtUq7wV8cjGy9yKb6XINfmMWuNKDyB+QPuJZj8KTH6rV7aBV
         fqvoRJgf7nFrA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id D9782405BE; Mon, 23 Jan 2023 10:38:18 -0300 (-03)
Date:   Mon, 23 Jan 2023 10:38:18 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ian Rogers <irogers@google.com>
Cc:     Michael Petlan <mpetlan@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org, acme@redhat.com,
        qzhao@redhat.com, cjense@google.com
Subject: Re: [PATCH 0/2] perf test: Fix JSON linter
Message-ID: <Y86NygSi+UdmmmTw@kernel.org>
References: <20230120134039.17788-1-mpetlan@redhat.com>
 <CAP-5=fXuNW2XYomrxViwzQThVQpwF5Cvo+UuQ_da3QiUESwAmw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP-5=fXuNW2XYomrxViwzQThVQpwF5Cvo+UuQ_da3QiUESwAmw@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Fri, Jan 20, 2023 at 09:37:33AM -0800, Ian Rogers escreveu:
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
> 
> I'm happy to look at doing the refactor to be similar to 'perf
> list'/builtin-list.c. Namhyung I thought might have gotten to it with
> his recent work on improving aggregation. If I hear silence then I'll
> assume that is a request I do it :-)

Yeah, go for it :-)
 
> Pragmatically in the short term we could land your changes, but I

Ok, I saw Namhyung's Ack and will apply both, we can go from there.

- Arnaldo

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

-- 

- Arnaldo
