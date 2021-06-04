Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC926C4743D
	for <linux-perf-users@archiver.kernel.org>; Fri,  4 Jun 2021 18:29:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9D217613FE
	for <linux-perf-users@archiver.kernel.org>; Fri,  4 Jun 2021 18:29:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229791AbhFDSbX (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 4 Jun 2021 14:31:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:57764 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229769AbhFDSbW (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 4 Jun 2021 14:31:22 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id F2062613FA;
        Fri,  4 Jun 2021 18:29:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622831376;
        bh=we8fWgEe67FojIj+5WfjBTSZXani/RwjERkgUbkEnUc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Dro/RhMQZfJqTIL+HEOt8f6OiP0EXrDy8ltcTxAjjF/O9Zyb2o2vTH6McAuSC9ElA
         XGWyoIvQ/88CFlGSSlN7ru8xplzmCxTTbJe7WVAPoJlsZY+hX0/ov7Y/LrgaE2AJYl
         qCmwsS6nIKSrbQnwkf/ajYRbZEFX1vdAHaDmTBw57FljfjHxHoHxtVyiQFQbHXEnjh
         8StwHHdizgNCjmqi+SIPu7c4rWWLzhZz8COrRVMjo6UeAUfJYRwBS/lDvqlwCF/IJi
         3mcCh6PkmzAam5rdHandzD5eaBIN5sJkExhukIMNGeLcomY5sObe8kTZG9xq2Clybi
         e4x7maplQy0Sg==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 0F1F540EFC; Fri,  4 Jun 2021 15:29:33 -0300 (-03)
Date:   Fri, 4 Jun 2021 15:29:33 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Riccardo Mancini <rickyman7@gmail.com>
Cc:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        Ian Rogers <irogers@google.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Tommi Rantala <tommi.t.rantala@nokia.com>,
        linux-perf-users <linux-perf-users@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] perf ksymbol: fix memory leak: decrease refcount of map
 and dso
Message-ID: <YLpxDf6+YOxYI5z3@kernel.org>
References: <20210602231052.317048-1-rickyman7@gmail.com>
 <CAP-5=fVxHUnwGoRypMjCsPSh_yo5PB8Hzbkx5ArA5b0=7S-67g@mail.gmail.com>
 <YLopMBgLWysdJbkm@kernel.org>
 <3b8c7c2c5de492c7fbf86df73c43cdb0fbb453df.camel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3b8c7c2c5de492c7fbf86df73c43cdb0fbb453df.camel@gmail.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Fri, Jun 04, 2021 at 05:16:39PM +0200, Riccardo Mancini escreveu:
> Hi,
> 
> On Fri, 2021-06-04 at 10:22 -0300, Arnaldo Carvalho de Melo wrote:
> > Em Thu, Jun 03, 2021 at 09:26:40PM -0700, Ian Rogers escreveu:
> > > On Wed, Jun 2, 2021 at 4:15 PM Riccardo Mancini <rickyman7@gmail.com> wrote:
> > > > +++ b/tools/perf/util/machine.c
> > > > @@ -776,6 +776,7 @@ static int machine__process_ksymbol_register(struct
> > > > machine *machine,
> > > >                 if (dso) {
> > > >                         dso->kernel = DSO_SPACE__KERNEL;
> > > >                         map = map__new2(0, dso);
> > > > +                       dso__put(dso);
> > 
> > > Will this cause 2 puts if the map allocation fails? Perhaps this
> > > should be "if (map) dso__put(dso);".
> > 
> > I think its just a matter of removing the put in the error path, i.e.
> > the patch becomes what is at the end of this message.
> > 
> > I.e. if map__new2() fails, we want to drop the dso reference, and if it
> > works, we already have a reference to it, obtained in map__new2().
> 
> Agree.
> I'm sorry for this stupid oversight.
> Should we make it a series including the fix to the issue you pointed out below,
> or should I send you a v2 and fix the other issue in a subsequent patch?

Please send a v2 patch, and then consider starting a new series with the
issues below.
 
> > But looking at this code now I realize that maps__find() should grab a
> > refcount for the map it returns, because in this
> > machine__process_ksymbol_register() function we use reference that 'map'
> > after the if block, i.e. we use it if it came from maps__find() or if we
> > created it machine__process_ksymbol_register, so there is a possible
> > race where other thread removes it from the list and map__put()s it
> > ending up in map__delete() while we still use it in
> > machine__process_ksymbol_register(), right?
> 
> Agree. It should be placed before up_read to avoid races, right?

Yes, we have to grab a refcount while we are sure its not going away,
then return that as the lookup result, whoever receives that refcounted
entry should use it and then drop the refcount.

> Then we would need to see where it's called and add the appropriate map__put.

yes
 
> In addition, having a look at other possible concurrency issues in map.c:

Its good to have new eyes looking at this, exactly at a time we're
discussing further parallelizing perf :-)

>  - maps__for_each_entry should always be called with either read or write lock,
> am I right? It looks like this is not done in certain parts of the code. If such

Right.

> lock is taken, then grabbing the refcount on the looping variable is not needed
> unless we need to return it, right?

Right, returning an entry needs to take a refcount.

>  - maps__first and map__next do not grab a refcount and neither a lock. If
> they're used through a lock-protected loop, it's not a problem, but maybe it's

yes

> worth making explicit that they are not to be used directly (through either a
> comment or adding some underscores in their names).

yes, __ in front means, in kernel style, that it does less than the non
__ prefixed, same name, function.

>  - maps__empty: should probably take a reader lock.

Indeed.

>  - maps__find_symbol: the returned symbol is not protected (the caller does not
> receive a refcount to neither map or dso, so if dso is deleted, his reference to
> the symbol gets invalidated). Depending on how it's being used it might not be a
> problem, but in the general scenario I think it's not thread-safe.

Yes, that function is also problematic.

Thanks for looking into this, please consider sending patches for these
issues,

- Arnaldo
