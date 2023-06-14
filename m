Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6626BEB64D8
	for <linux-perf-users@archiver.kernel.org>; Wed, 14 Jun 2023 18:39:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232203AbjFNSjK (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 14 Jun 2023 14:39:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236019AbjFNSik (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 14 Jun 2023 14:38:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92D381BF9;
        Wed, 14 Jun 2023 11:38:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2E7DF645B8;
        Wed, 14 Jun 2023 18:38:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68B54C433C8;
        Wed, 14 Jun 2023 18:38:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686767918;
        bh=o4sh2tsX5J57t9SnUteVSlnPxszriuzVR4JOPvCpFdM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WGxU0N9YpzWhMCTaxGafbrjwTcpS0AYFJvxzsifVtvQlQ225wCpyUKAvtMwYWGVzN
         UYPLDT/vyPj8cQWGl/UfWBfp5IydOni+gSqXOdd4ROpSToNH9x0WWuA6kMJRrZ+W3V
         XEBsxRuxlbJU1dBxEvai658xpzWPhnafo2DtQnID9fhxebnEu0YbZ3k0QEZ/+TTRgx
         iLpfsQ2fWb0n+BmUVQLReb+brhOEKN2+CTubJfohcIt4Kb0AwrCnDYv/zpyuD4pT5r
         NbWrJtl0kpQ1ECFnI9+w6Yo8XaaRmmjx56z/q+3rjVj2xGN/KHVYn65bVJ8FRjCwdU
         kKiMVr3tisYuQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id E419240692; Wed, 14 Jun 2023 15:38:35 -0300 (-03)
Date:   Wed, 14 Jun 2023 15:38:35 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Artem Savkov <asavkov@redhat.com>
Cc:     Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/2] perf tools: annotation browser from c2c tui
Message-ID: <ZIoJK66ZrKZblkJN@kernel.org>
References: <20230608084407.140323-1-asavkov@redhat.com>
 <CAM9d7cgvtuqMeQx8ehLCLw_Ur9Ju-VzDrakzFJxnxvFjdsWk_g@mail.gmail.com>
 <20230609083731.GA168559@samus.usersys.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230609083731.GA168559@samus.usersys.redhat.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Fri, Jun 09, 2023 at 10:37:31AM +0200, Artem Savkov escreveu:
> On Thu, Jun 08, 2023 at 02:09:06PM -0700, Namhyung Kim wrote:
> > Hello,
> > 
> > On Thu, Jun 8, 2023 at 1:44 AM Artem Savkov <asavkov@redhat.com> wrote:
> > >
> > > These patches add ability to start annotation browser from c2c report
> > > tui. The idea comes from Arnaldo's "Profiling Data Structures" talk [1].
> > 
> > I was thinking about how it works and realized that it didn't collect
> > samples by symbol.  Then I'm not sure if the result is meaningful.
> > I think it'd show a random symbol that touched the cache line
> > first.  The same cache line can be accessed from other locations
> > but it cannot know where they are.
> > 
> > Also different instructions in a function (symbol) would access a
> > different cache line.  The annotate output just shows any memory
> > access.  So it might be good to check the instruction at the point
> > but others should not be considered related.
> > 
> > Hmm.. I suspect even the same instruction will hit the different
> > cache lines at different times.  Then probably the annotation
> > won't work well in terms of correlating cache lines.
> 
> The annotation hotkey is only added to the cacheline detailed view where
> we do have symbol instruction information. The idea is to give the user
> ability to quickly jump to source code/disassembly directly from c2c
> TUI.
> 
> The hit percentages in annotation view don't make much sense in this
> case though, so maybe it is better to use dummy evsel so that none are
> shown.

Yes, the point is just to reuse the source browser, if there is no
annotation data applicable, don't use any.

- Arnaldo
 
> > Thanks,
> > Namhyung
> > 
> > >
> > > [1]: http://vger.kernel.org/~acme/prez/linux-plumbers-2022/
> > >
> > > v1->v2: Addressed comments from Namhyung Kim
> > > - No longer saving evsel for each hist entry, using evlist__first
> > >   instead.
> > > - Factored out preparations to call annotation browser to do_annotate()
> > >   function
> > > - Other small fixes and adjustments.
> > >
> > > Artem Savkov (2):
> > >   perf util: move symbol__new_unresolved() to util/symbol.c
> > >   perf tools: allow running annotation browser from c2c-report
> > >
> > >  tools/perf/builtin-c2c.c       | 73 +++++++++++++++++++++++++++++++---
> > >  tools/perf/ui/browsers/hists.c | 22 ----------
> > >  tools/perf/util/symbol.c       | 22 ++++++++++
> > >  tools/perf/util/symbol.h       |  1 +
> > >  4 files changed, 91 insertions(+), 27 deletions(-)
> > >
> > > --
> > > 2.40.1
> > >
> > 
> 
> -- 
>  Artem
> 

-- 

- Arnaldo
