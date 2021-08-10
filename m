Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 044B8C4338F
	for <linux-perf-users@archiver.kernel.org>; Tue, 10 Aug 2021 14:07:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D9A3860E52
	for <linux-perf-users@archiver.kernel.org>; Tue, 10 Aug 2021 14:07:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241698AbhHJOIL (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 10 Aug 2021 10:08:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:41536 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238554AbhHJOIL (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 10 Aug 2021 10:08:11 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0F87A60F41;
        Tue, 10 Aug 2021 14:07:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628604469;
        bh=fuZaM92NMwEjwHL4v3wyfLCUEczcXE1BVry4drvjgIY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eW02T+ZPCQk0NsOoyktfO5bMfoj75bUx9IhvAD4fzIO8RWh/kaztN3D4L41WrJUt4
         TdRDBaxbWcRGKFiLdyYSqUHiYtrkdDjZ7fsUpz4g2c761oH3DgPEFNb2zhfwPwpt8Q
         MtIFwGWvX/gHQv4AS3Rqjr1REqQLT+cPwSff0D6TD/hRq94oRonbEIudTsxkTJekCk
         IXMQySE/gKtM7NDKIGXnQfifcrIa5b7/cQzT3OvJq4lDVHMD7utSqgUBIbHsVfyOBC
         misMURDErIbit1Sau0xB1JBvZB97hdJZfHSgSzhvgE/JQ9wjcH3dKpDy30S0OiI1pR
         CRYqDMlhLdtPQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 75BEC403F2; Tue, 10 Aug 2021 11:07:46 -0300 (-03)
Date:   Tue, 10 Aug 2021 11:07:46 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Riccardo Mancini <rickyman7@gmail.com>
Cc:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        Ian Rogers <irogers@google.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org
Subject: Re: [PATCH] perf bench: add benchmark for evlist open/close
 operations
Message-ID: <YRKIMtH0mgKtFGPH@kernel.org>
References: <20210809201101.277594-1-rickyman7@gmail.com>
 <YRGOwx3xlPRxNAXM@kernel.org>
 <YRGP3DR8f6ZEvn/P@kernel.org>
 <aa2e93cdaf636b0cd9df05d759661363b2a59d3f.camel@gmail.com>
 <YRKHKiHMSaYZWwQv@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YRKHKiHMSaYZWwQv@kernel.org>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Tue, Aug 10, 2021 at 11:03:22AM -0300, Arnaldo Carvalho de Melo escreveu:
> Em Tue, Aug 10, 2021 at 12:31:55PM +0200, Riccardo Mancini escreveu:
> > Unrelated to this small issue, I noticed I forgot to check the return of
> > bench__create_evlist. Would you like me to send a v2 fixing both issues or are
> > you able to apply this other small change yourself?
 
> Nah, as this is the HEAD right now in my local branch, I'll apply it
> myself, thanks!

Also you forgot another check for this same function
(bench__create_evlist()), before that loop. I'm fixing that as well.
 
> - Arnaldo
>  
> > diff --git a/tools/perf/bench/evlist-open-close.c b/tools/perf/bench/evlist-open-close.c
> > index 40bce06f5ca7bef3..f0b9c330f34f2984 100644
> > --- a/tools/perf/bench/evlist-open-close.c
> > +++ b/tools/perf/bench/evlist-open-close.c
> > @@ -168,7 +168,11 @@ static int bench_evlist_open_close__run(char *evstr)
> >  
> >         for (i = 0; i < iterations; i++) {
> >                 pr_debug("Started iteration %d\n", i);
> > +
> >                 evlist = bench__create_evlist(evstr);
> > +               if (!evlist)
> > +                       return -ENOMEM;
> > +
> >                 gettimeofday(&start, NULL);
> >                 err = bench__do_evlist_open_close(evlist);
