Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57738EB64DC
	for <linux-perf-users@archiver.kernel.org>; Mon, 17 Jul 2023 13:37:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229559AbjGQNhx (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 17 Jul 2023 09:37:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231246AbjGQNhk (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 17 Jul 2023 09:37:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9869413E
        for <linux-perf-users@vger.kernel.org>; Mon, 17 Jul 2023 06:37:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3610661050
        for <linux-perf-users@vger.kernel.org>; Mon, 17 Jul 2023 13:37:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33721C433C7;
        Mon, 17 Jul 2023 13:37:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689601058;
        bh=+X89mHiW5o9VUH1OMc5U6tHBl2LHZQrfl/4HB/nD7hY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=I2hp0Z7UH08DYcPrMPySSjpDXG9kn3+uPsRfGE3Ny8jX20MaTyQB3x4AUK9ABlwUW
         8zqI13Y76MSwfCXdv/Iww2AeVGIQamqzfYPryU1vI02Vf8l7idklb3S4jo95tI9EhZ
         zGg/JE7mBoXSnhgA+ER66RUx870ZImLGv04+Ad/fxDW/DBcHVkVev3HJn8WSlynesn
         rIWPpd9s0QoeYNs73FuUtYErT1TfbO2N8dGjP4yxCrwTk/1BEMA4MwjMeJz9mccrRA
         0REZWNNT5TdBOoGL66iKO0YaCtYiQMaNkxtKSX0e48WBBXoFjfpIZyzI3e2PotlsSr
         DeaICXyQmRaaQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 7FEC440516; Mon, 17 Jul 2023 10:37:35 -0300 (-03)
Date:   Mon, 17 Jul 2023 10:37:35 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Andi Kleen <ak@linux.intel.com>
Cc:     Ian Rogers <irogers@google.com>, namhyung@kernel.org,
        linux-perf-users@vger.kernel.org
Subject: Re: Event reordering regression for software events
Message-ID: <ZLVEHz0uzq79eto5@kernel.org>
References: <ZLBgbHkbrfGygM/u@tassilo>
 <ZLBjI4a3wIMs75lA@kernel.org>
 <CAP-5=fU5Y95G2FsFdwxwPk=kLe=kka7CkD7ZDrzSU+Xv-Ks=Qg@mail.gmail.com>
 <ZLCOEOtJOQiN+8VB@tassilo>
 <CAP-5=fWjDeXZfgLu8hiavtkRGmWsZnwt3g+Ms5YPL12PxUaCgg@mail.gmail.com>
 <ZLC8AIEfUJMQFOEn@tassilo>
 <CAP-5=fVWyrmRHCmNGRrME-YSSwbJV90-_dcC=LyNAXjk9baMGA@mail.gmail.com>
 <ZLSgzJsom0avu/hX@tassilo>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZLSgzJsom0avu/hX@tassilo>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Sun, Jul 16, 2023 at 07:00:44PM -0700, Andi Kleen escreveu:
> On Thu, Jul 13, 2023 at 08:56:55PM -0700, Ian Rogers wrote:
> > Yes I disagree. We can't always force perf metric events in a group
> > because weak groups don't always work. When we place the perf metric
> > events outside of a group they are broken. So now we don't group the
> > events and fix the topdown events to be in a group, in arch specific
> > code. It is a complete pain brought about by the Intel core PMU
> > driver.
> 
> Was that the old topdown slots have to be first issue, or something
> else?
> 
> If it's so painful I guess could revisit the kernel part, although
> I suspect anything that the kernel could do the perf tool could do too.
> 
> > 
> > > So why does the perf tool need to fix it? Just pass it to the kernel
> > > and it won't schedule and the user has to fix it.
> > 
> > Because in some cases, and the cases I have happened to care about,
> > the groups of events come from metrics.
> 
> That's fine, but can't you just fix it for the metrics only.
> 
> Also even for metrics if you freely reorder them they might become
> unparseable.  But the events inside the metrics should be freely

Don't we have a JSON output? My expectation is that after the work that
Ian has been doing we will settle down, but even then downstreamers
should try to use JSON as input as that would avoid the problems we are
having?

You mentioned that it was difficult to add entries to 'perf test' but
that we could try running toplev's regression test, right? I can add it
to my set of tests but perhaps the best thing would be to wire it up to
one of the CIs out there?

- Arnaldo

> reorderable (well technically someone could have a dependency on that
> too, but at least in my mind that's much less likely than their
> dependency just being on the metric) 
> 
> So what it really needs is a sort only insight the metric.
> 
> That shouldn't be too hard to implement, right?
> 
> Also I guess we could add some test cases on avoiding reordering,
> although I'm optimistic that once it is established that reordering
> should be minimized/avoided it is unlikely to be something 
> that breask frequently.
> 
> Would it be possible to revert the global sort patch until that 
> is sorted out? Otherwise I'm afraid I'll end up with perf releases
> that are absolutely incompatible to toplev, and I'll get problems
> with my user base who often cannot easily update perf.
> 
> Arnaldo, can you please comment on this, what is your policy 
> on regressions here?

 
> > But things like wildcard group expansion and regrouping is a metric
> > problem too. So why would there be a parse events for metrics and a
> > separate one for events? Doing it this way would make metric group
> > testing significantly more hard too, as we can't just try the events
> > without the metric.
> 
> Hmm, perhaps add some kind of debug flag to handle this case?
> As long as it's not default I don't have any issues with that.
> 
> > > How about replacing the sorting commit with a warning and ask
> > > the user to do the reordering? Would that work for you?
> > 
> > No.
> 
> Well I hope we can get to some compromise here. Right now 
> this arbitary unpredictable reordering is a show stopper for me,
> and I suspect it will be for any other perf stat users that do some kind
> of post processing.
> 
> As long as we find a solution like above that works for the metrics
> it should be ok right?
> 
> > > The platform is SKX.
> > >
> > > >
> > > > > > would seem unfortunate. Tbh, the mistake here is the assumptions that
> > > > > > toplev is making.
> > > > >
> > > > > It's not an random assumption, it's the only way to parse perf output uniquely.
> > > > >
> > > > > Please make it an option. But this cannot stay this way unconditionally
> > > > > if perf stat is supposed to stay a tool which can be used from other programs.
> > > >
> > > > You should be using the json or CSV outputs. These are intended for
> > >
> > > This is the CSV output that is reordered! (see the example you just
> > > quoted)
> > >
> > > I haven't tested JSON, but I assume that is reordered too.
> > 
> > The output of the JSON is a dictionary and inherently unordered.
> 
> I haven't tried to use it, but if you have something like
> perf stat --json -e '{cycles,branches},{cycles,cache-misses}' how would you
> distinguish the two different cycles without order? 
> 
> > crashes vs having the complete TopdownL1 working on both PMUs, testing
> > parity with non-hybrid. We also fixed all address and leak sanitizer
> > bugs. 
> 
> > Perf in Linux 6.5 even without the awesome new features like
> > lock contention analysis, is the best perf tool we've ever had.
> 
> Sure and without arbitrary reordering and unparseable output it would be
> even better ...
> 
> > Does SKX have uncore? Yes, so you need to reorder events and this
> > change didn't start it.
> 
> Yes of course it has an uncore.
> 
> You only need to reorder if you create broken groups.  At least my tool
> doesn't generate them.
> 
> > NO_GROUP_EVENTS is used to avoid a group being used, an important use
> > being avoiding PMU driver bugs.
> > 
> 
> Hmm, not sure what that is refering to, but ok.
> 
> -Andi

-- 

- Arnaldo
