Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92414C48BDF
	for <linux-perf-users@archiver.kernel.org>; Fri, 18 Jun 2021 13:25:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 70CCF613EC
	for <linux-perf-users@archiver.kernel.org>; Fri, 18 Jun 2021 13:25:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232164AbhFRN2C (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 18 Jun 2021 09:28:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:33950 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229877AbhFRN2C (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 18 Jun 2021 09:28:02 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9EF24613EB;
        Fri, 18 Jun 2021 13:25:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624022752;
        bh=Y1EXxYzR8V40448QkyPRUDs0dTVxn9wLZsNU8QqYQA4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=J6EUeCDDd5HoynS1rgyePkpn7anNR+xHc/kDkt7GuMlDcLa100JA1wSs26B00vCmn
         GEAQEFxrOvCSX+W12KXDY049EkCrG4vcwFHvwdnk/EXKe+M6aqOqOKxyyf2eELwr9R
         gw2q1EoWwulw/EPABdsss9RDbqn7wSSsTIwnV2mGEN8w7nR/ykZ3XK4AK0RfA7tEM7
         gIG8JuLUsG5Wjs4qhE+O58fj7CoQN/VbXnTtfBU5m0MtY21ewyX6IcdAdmOjZ/nm6f
         ofPbMqzKJzR1FghDlb6M0BBA800WeUqzIG6aKDmMekxLSBsldpUvnk6Chr0ns/kOu0
         28L5/iSsKO1Xw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id D6AF740B1A; Fri, 18 Jun 2021 10:25:49 -0300 (-03)
Date:   Fri, 18 Jun 2021 10:25:49 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Riccardo Mancini <rickyman7@gmail.com>
Cc:     Ian Rogers <irogers@google.com>,
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
Message-ID: <YMye3UVZWRh30L2a@kernel.org>
References: <20210602231052.317048-1-rickyman7@gmail.com>
 <CAP-5=fVxHUnwGoRypMjCsPSh_yo5PB8Hzbkx5ArA5b0=7S-67g@mail.gmail.com>
 <YLopMBgLWysdJbkm@kernel.org>
 <3b8c7c2c5de492c7fbf86df73c43cdb0fbb453df.camel@gmail.com>
 <YLpxDf6+YOxYI5z3@kernel.org>
 <da5b052d2c94db91c0bf8cb794c5cad299f19e57.camel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <da5b052d2c94db91c0bf8cb794c5cad299f19e57.camel@gmail.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Fri, Jun 18, 2021 at 12:01:28PM +0200, Riccardo Mancini escreveu:
> Hi, 
> 
> On Fri, 2021-06-04 at 15:29 -0300, Arnaldo Carvalho de Melo wrote:
> <SNIP> 
> > > > But looking at this code now I realize that maps__find() should grab a
> > > > refcount for the map it returns, because in this
> > > > machine__process_ksymbol_register() function we use reference that 'map'
> > > > after the if block, i.e. we use it if it came from maps__find() or if we
> > > > created it machine__process_ksymbol_register, so there is a possible
> > > > race where other thread removes it from the list and map__put()s it
> > > > ending up in map__delete() while we still use it in
> > > > machine__process_ksymbol_register(), right?
> > > 
> > > Agree. It should be placed before up_read to avoid races, right?
> > 
> > Yes, we have to grab a refcount while we are sure its not going away,
> > then return that as the lookup result, whoever receives that refcounted
> > entry should use it and then drop the refcount.
> > 
> > > Then we would need to see where it's called and add the appropriate
> > > map__put.
> > 
> > yes
> 
> This function has quite a number of callers (direct and indirect) so the the
> patch is becoming huge. 
> 
> One of these callers is thread__find_map, which returns an addr_location
> (actually it's an output argument). This addr_location holds references to map,
> maps and thread without getting any refcnt (actually in one function it gets it
> on the thread and a comment tells to put it once done). If I'm not wrong, this
> addr_location is never malloced (always a local variable) and, is should be
> present in parts of the code where there should be a refcnt on the thread.
> Therefore, maybe it does not get the refcnts since it assumes that thread (upon
> which depends maps and as a consequence map) is always refcnted in its context.
> However, I think that it should get all refcnts anyways for clarity and to
> prevent possible misuses (if I understood correctly, Ian is of the same
> opinion).

agreed, but this will incur extra costs, we should perhaos use perf to
measure how much it costs. :-)

> My solution would be to add the refcnt grabbing for map, maps and thread in
> thread__find_map, releasing them in addr_location__put, and then making sure all
> callers call it when no longer in use.

Ok
 
> Following the same reasoning, I added refcnt grabbing also to mem_info,
> branch_info (map was already refcnted, I added it also to maps for coherency),
> map_symbol (as in branch_info, I added it to maps), and in other places in which
> I saw a pointer was passed without refcounting.
> 
> Most changes are quite trivial, however, the changelog is huge:
> 48 files changed, 472 insertions(+), 157 deletions(-)
> Most of them are just returns converted to goto for calling the __put functions.

So you could first do a prep patch converting functions to have gotos,
which would be a no-logic change, and then do the rest?
 
> Doing so, I managed to remove memory leaks caused by refcounting also in perf-
> report (I wanted to try also perf top but I encountered another memory-related
> issue). However, the changelog is huge and testing all of it is challenging

So we should break it in as many small steps as possible, knowing that
each step is fixing just one of the problems, i.e. aSAN will continue
reporting problems, but less problems as you go on adding more fixes.

> (especially since I can test missing puts only with ASan's LeakSanitizer and its
> reports are usually full of leaks, which I am trying to fix along the way, I
> will send some patches in the following days). How would you go about it? Do you
> have any suggestions?

See above, thanks for working on this!

- Arnaldo
