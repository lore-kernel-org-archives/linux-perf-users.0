Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 868ACC25B4E
	for <linux-perf-users@archiver.kernel.org>; Tue, 24 Jan 2023 17:40:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234335AbjAXRkA (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 24 Jan 2023 12:40:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234822AbjAXRjy (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 24 Jan 2023 12:39:54 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 335DC12F2F
        for <linux-perf-users@vger.kernel.org>; Tue, 24 Jan 2023 09:39:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674581952;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=TUFX/ihG7QOchKS91zj68SgSYoUAWVYImfpGQQSUmhc=;
        b=gn6Eh0MfRU77imPoFW/ju/CqaJM37RxtJd/nQ8jm+7jYG+WGccdTCEg43DUl4ai1coO0En
        cBmvXww9x60bwntiMjNv28I8VkAmpQ2ZWtxdhhtQpyTqEHsvFqg27TsDoE56g1cZ5GQoKh
        68PSuXSn2skNTnBzFJ9uziODC4hheuQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-314-hYWGsztMN3K3edKtoq9Jjg-1; Tue, 24 Jan 2023 12:39:10 -0500
X-MC-Unique: hYWGsztMN3K3edKtoq9Jjg-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D1A9E811E9C;
        Tue, 24 Jan 2023 17:39:09 +0000 (UTC)
Received: from Diego (unknown [10.39.208.17])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 61AB6492B00;
        Tue, 24 Jan 2023 17:39:07 +0000 (UTC)
Date:   Tue, 24 Jan 2023 18:39:04 +0100 (CET)
From:   Michael Petlan <mpetlan@redhat.com>
X-X-Sender: Michael@Diego
To:     Ian Rogers <irogers@google.com>
cc:     Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org, acme@kernel.org, acme@redhat.com,
        qzhao@redhat.com, cjense@google.com
Subject: Re: [PATCH 0/2] perf test: Fix JSON linter
In-Reply-To: <CAP-5=fXuNW2XYomrxViwzQThVQpwF5Cvo+UuQ_da3QiUESwAmw@mail.gmail.com>
Message-ID: <alpine.LRH.2.20.2301241751180.5281@Diego>
References: <20230120134039.17788-1-mpetlan@redhat.com> <CAP-5=fXuNW2XYomrxViwzQThVQpwF5Cvo+UuQ_da3QiUESwAmw@mail.gmail.com>
User-Agent: Alpine 2.20 (LRH 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Fri, 20 Jan 2023, Ian Rogers wrote:
> On Fri, Jan 20, 2023 at 5:41 AM Michael Petlan <mpetlan@redhat.com> wrote:
> >
> > Hello all.
> >
> > We have observed issues with the 'perf stat JSON output linter' testcase
> > on systems that allow topdown metrics.
> >
> > =========================
> >
[...]
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
> 
> Pragmatically in the short term we could land your changes, but I
> worry they are more of the whac-a-mole and something somewhere else
> will break. Which is why we have a test, and so I'm not overly
> worried. I can download and test too.
> 
> Anyway, sorry for the issue and let me know what you think. Thanks,
> Ian

Hello.

I think that applying the patchset won't make things worse, eventhough
we know it would deserve a better solution for the whole print engine.

Yes, we have a test, but maybe that's what should be improved first,
since it does not actually verify the format correctness. I have hit
the problem because of failing test, but the fail cause was that there
were too many commas, but strings like

  "Heavy Operations"}"metric-value"

are still OK according to the linter.

Proper JSON linter might be in some library, but we don't want to add
too many dependencies I guess.

Maybe some simple JSON linter I used when preparing the patchset would
be enough for our perf-stat output... I'll convert it to Python and
post it to see.

=============================

Finally, speaking of tests, I think that thinking of integrating the
external perf testsuite [1] might be a better approach than adding
new shell-based tests such as "perf stat tests", etc. Tests like that
have been already written, see [1].

Some years ago, I was trying to add it to perf-test, however it was
unsuccessful, but since then, many shell-based tests were added
instead and I think they slightly duplicate the work already done.

Thoughts?
Michael

[1] https://github.com/rfmvh/perftool-testsuite

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
> 
> 

