Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 206DAC0015E
	for <linux-perf-users@archiver.kernel.org>; Mon, 17 Jul 2023 02:00:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229710AbjGQCAx (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Sun, 16 Jul 2023 22:00:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229579AbjGQCAw (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Sun, 16 Jul 2023 22:00:52 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32488E52
        for <linux-perf-users@vger.kernel.org>; Sun, 16 Jul 2023 19:00:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689559251; x=1721095251;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=K8iC/yI9RrgOEd9KerVAcww4jivp5QHyk8MbfNPLFpk=;
  b=cd85cAOYJpIlj/TWKlv5lYDJJpGJJsMmCNPn+XovWP9RvC9IHD3YFH9C
   6qu/Pfc4HYruOEL/kvsdpgaKwd1Em0Jxwh9XEOJysJwLuNuSP0EutC49Y
   hNT+foAVNb7HOzh8R7tAWMjR+w6T2LPUY6wZFua2WLPn60cU5IHVS1dka
   evax/eu7U8Dt3dbEKJ66VaS8wFbAqAbwldOgviyfaRd0W8oMCnypDfndV
   CwBgXaVigbqLt2Hzkh7YlqaIH/NB4jam00FF6TrKUcQurqjKSin0Tr3PB
   QYJaVNaCQYj6yq757CfnTlAzfy3hgTuyHAZm6l5rq/3xy/AukikXIHupL
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10773"; a="345415028"
X-IronPort-AV: E=Sophos;i="6.01,211,1684825200"; 
   d="scan'208";a="345415028"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2023 19:00:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10773"; a="897032599"
X-IronPort-AV: E=Sophos;i="6.01,211,1684825200"; 
   d="scan'208";a="897032599"
Received: from tassilo.jf.intel.com (HELO tassilo) ([10.54.38.190])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2023 19:00:45 -0700
Date:   Sun, 16 Jul 2023 19:00:44 -0700
From:   Andi Kleen <ak@linux.intel.com>
To:     Ian Rogers <irogers@google.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>, namhyung@kernel.org,
        linux-perf-users@vger.kernel.org
Subject: Re: Event reordering regression for software events
Message-ID: <ZLSgzJsom0avu/hX@tassilo>
References: <ZLBgbHkbrfGygM/u@tassilo>
 <ZLBjI4a3wIMs75lA@kernel.org>
 <CAP-5=fU5Y95G2FsFdwxwPk=kLe=kka7CkD7ZDrzSU+Xv-Ks=Qg@mail.gmail.com>
 <ZLCOEOtJOQiN+8VB@tassilo>
 <CAP-5=fWjDeXZfgLu8hiavtkRGmWsZnwt3g+Ms5YPL12PxUaCgg@mail.gmail.com>
 <ZLC8AIEfUJMQFOEn@tassilo>
 <CAP-5=fVWyrmRHCmNGRrME-YSSwbJV90-_dcC=LyNAXjk9baMGA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP-5=fVWyrmRHCmNGRrME-YSSwbJV90-_dcC=LyNAXjk9baMGA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Thu, Jul 13, 2023 at 08:56:55PM -0700, Ian Rogers wrote:
> Yes I disagree. We can't always force perf metric events in a group
> because weak groups don't always work. When we place the perf metric
> events outside of a group they are broken. So now we don't group the
> events and fix the topdown events to be in a group, in arch specific
> code. It is a complete pain brought about by the Intel core PMU
> driver.

Was that the old topdown slots have to be first issue, or something
else?

If it's so painful I guess could revisit the kernel part, although
I suspect anything that the kernel could do the perf tool could do too.

> 
> > So why does the perf tool need to fix it? Just pass it to the kernel
> > and it won't schedule and the user has to fix it.
> 
> Because in some cases, and the cases I have happened to care about,
> the groups of events come from metrics.

That's fine, but can't you just fix it for the metrics only.

Also even for metrics if you freely reorder them they might become
unparseable.  But the events inside the metrics should be freely
reorderable (well technically someone could have a dependency on that
too, but at least in my mind that's much less likely than their
dependency just being on the metric) 

So what it really needs is a sort only insight the metric.

That shouldn't be too hard to implement, right?

Also I guess we could add some test cases on avoiding reordering,
although I'm optimistic that once it is established that reordering
should be minimized/avoided it is unlikely to be something 
that breask frequently.

Would it be possible to revert the global sort patch until that 
is sorted out? Otherwise I'm afraid I'll end up with perf releases
that are absolutely incompatible to toplev, and I'll get problems
with my user base who often cannot easily update perf.

Arnaldo, can you please comment on this, what is your policy 
on regressions here?

> But things like wildcard group expansion and regrouping is a metric
> problem too. So why would there be a parse events for metrics and a
> separate one for events? Doing it this way would make metric group
> testing significantly more hard too, as we can't just try the events
> without the metric.

Hmm, perhaps add some kind of debug flag to handle this case?
As long as it's not default I don't have any issues with that.

> > How about replacing the sorting commit with a warning and ask
> > the user to do the reordering? Would that work for you?
> 
> No.

Well I hope we can get to some compromise here. Right now 
this arbitary unpredictable reordering is a show stopper for me,
and I suspect it will be for any other perf stat users that do some kind
of post processing.

As long as we find a solution like above that works for the metrics
it should be ok right?

> > The platform is SKX.
> >
> > >
> > > > > would seem unfortunate. Tbh, the mistake here is the assumptions that
> > > > > toplev is making.
> > > >
> > > > It's not an random assumption, it's the only way to parse perf output uniquely.
> > > >
> > > > Please make it an option. But this cannot stay this way unconditionally
> > > > if perf stat is supposed to stay a tool which can be used from other programs.
> > >
> > > You should be using the json or CSV outputs. These are intended for
> >
> > This is the CSV output that is reordered! (see the example you just
> > quoted)
> >
> > I haven't tested JSON, but I assume that is reordered too.
> 
> The output of the JSON is a dictionary and inherently unordered.

I haven't tried to use it, but if you have something like
perf stat --json -e '{cycles,branches},{cycles,cache-misses}' how would you
distinguish the two different cycles without order? 

> crashes vs having the complete TopdownL1 working on both PMUs, testing
> parity with non-hybrid. We also fixed all address and leak sanitizer
> bugs. 

> Perf in Linux 6.5 even without the awesome new features like
> lock contention analysis, is the best perf tool we've ever had.

Sure and without arbitrary reordering and unparseable output it would be
even better ...

> Does SKX have uncore? Yes, so you need to reorder events and this
> change didn't start it.

Yes of course it has an uncore.

You only need to reorder if you create broken groups.  At least my tool
doesn't generate them.

> NO_GROUP_EVENTS is used to avoid a group being used, an important use
> being avoiding PMU driver bugs.
> 

Hmm, not sure what that is refering to, but ok.

-Andi
