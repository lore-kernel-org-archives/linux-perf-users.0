Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE11AC4361B
	for <linux-perf-users@archiver.kernel.org>; Tue, 15 Dec 2020 13:33:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7313D223D6
	for <linux-perf-users@archiver.kernel.org>; Tue, 15 Dec 2020 13:33:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726266AbgLONdr (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 15 Dec 2020 08:33:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:53438 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726861AbgLONdh (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 15 Dec 2020 08:33:37 -0500
Date:   Tue, 15 Dec 2020 10:33:07 -0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1608039174;
        bh=08Ht/Ta5+Dg2pqKm7AilgXrZxrvrjBxvd2Hv3Z/7W7E=;
        h=From:To:Cc:Subject:References:In-Reply-To:From;
        b=fxZWh0+o/hafqho46ammiZUn73U2gZPxqgLTrnAKlF2uStHjxGJavb13XeFkwwjfR
         hUOj7o9S5pBG6Lfw4e074cq3I48Iwx+3v0LgYbt+TUAlJsK4adCE2bJ/7pyGMwot4P
         JooMCLtSbelDiKZBnlnPza0fJsP55vmKRW2QwMn2q7UKMsWBQvUOHUSPzwyqFimb5o
         ITRxLQTQLZT1yrz8WOxWsWbM+BAnJJoAFVQitvU6ILlMfsEBGbMBuM2yCIOPNGlKLX
         xVxWOFZWrhI4bZ1VAPEG17fNw/T2i9cmcZBYWqdvESKv8nHfzTpCyd6HM7VBoptQnN
         ZVDIT6hr9LHyA==
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Al Grant <al.grant@foss.arm.com>
Cc:     Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        linux-perf-users <linux-perf-users@vger.kernel.org>
Subject: Re: [PATCH] perf inject corrupts file by deleting event
Message-ID: <20201215133307.GB252952@kernel.org>
References: <83633eb2-04dc-4a13-3ad7-abd3a7459ac1@foss.arm.com>
 <b9cf5611-daae-2390-3439-6617f8f0a34b@foss.arm.com>
 <CAM9d7cgmQ552DFpPo6b8kCwq4B9faSPxGE3tTBW6jfJd1xMVwA@mail.gmail.com>
 <20201116164533.GC509215@kernel.org>
 <20201116164839.GD509215@kernel.org>
 <20201116165946.GE509215@kernel.org>
 <5d085d2a-7f76-88ab-25c4-1370f7e1589e@foss.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5d085d2a-7f76-88ab-25c4-1370f7e1589e@foss.arm.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Tue, Dec 15, 2020 at 09:48:32AM +0000, Al Grant escreveu:
> On 16/11/2020 16:59, Arnaldo Carvalho de Melo wrote:
> > Em Mon, Nov 16, 2020 at 01:48:39PM -0300, Arnaldo Carvalho de Melo escreveu:
> > > Em Mon, Nov 16, 2020 at 01:45:33PM -0300, Arnaldo Carvalho de Melo escreveu:
> > > > Em Tue, Nov 17, 2020 at 01:25:09AM +0900, Namhyung Kim escreveu:
> > > > > On Sat, Nov 14, 2020 at 5:38 AM Al Grant <al.grant@foss.arm.com> wrote:
> > > > > > Mismatching sample_types are seen with "perf record -e cs_etm//",
> > > > > > where the AUX event has TID|TIME|CPU|IDENTIFIER and the dummy
> > > > > > event has TID|TIME|IDENTIFIER. Perhaps they could be the same,
> > > > > > but it isn't normally a problem if they aren't - perf has
> > > > > > no problems reading the file. The sample_types have to agree on
> > > > > > the position of IDENTIFIER, because that's how perf finds the
> > > > > > right event descriptor in the first place, but they don't normally
> > > > > > have to agree on other fields, and perf doesn't check that they do.
> > > > > > The problem is specific to the way "perf inject" reorganizes the
> > > > > > events and the way synthetic MMAP events are recorded with a zero
> > > > > > identifier. A simple solution is to stop "perf inject" deleting
> > > > > > the tracing event.
> > > 
> > > > > > Signed-off-by: Al Grant <al.grant@arm.com>
> > > > > > Acked-by: Adrian Hunter <adrian.hunter@intel.com>
> > > 
> > > > > While I'm ok with this change,
> > > > 
> > > > So, to make progress, I'll take your phrase as an Acked-by, as described
> > > > in Documentation/process/submitting-patches.rst, ok?
> > > 
> > > But I'll have to apply by hand:
> > > 
> > > [acme@five perf]$ am /wb/1.patch
> > > warning: Patch sent with format=flowed; space at the end of lines might be lost.
> > > Applying: perf inject corrupts file by deleting event
> > > error: patch failed: tools/perf/builtin-inject.c:791
> > > error: tools/perf/builtin-inject.c: patch does not apply
> > > Patch failed at 0001 perf inject corrupts file by deleting event
> > > hint: Use 'git am --show-current-patch=diff' to see the failed patch
> > > When you have resolved this problem, run "git am --continue".
> > > If you prefer to skip this patch, run "git am --skip" instead.
> > > To restore the original branch and stop patching, run "git am --abort".
> > > [acme@five perf]$
> > 
> > And you also forgot to update the comment and to remove the now unused
> > 'evsel' variable, find the updated patch below, please check.
> 
> Thanks for tidying it up, it looks good to me. Do you need me to resubmit
> or can you take it as it is now with your changes?
> 
> Al


Its already in v5.10:

[acme@five perf]$ git log --oneline -1 1c756cd429d8f3da33d31f2a970284b9d5260534
1c756cd429d8f3da perf inject: Fix file corruption due to event deletion
[acme@five perf]$ git tag --contains 1c756cd429d8f3da33d31f2a970284b9d5260534 | grep ^v
v5.10
v5.10-rc5
v5.10-rc6
v5.10-rc7
[acme@five perf]$

Thanks for checking,

- Arnaldo
