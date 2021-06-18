Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A11AC48BE8
	for <linux-perf-users@archiver.kernel.org>; Fri, 18 Jun 2021 10:01:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F1D8F610CD
	for <linux-perf-users@archiver.kernel.org>; Fri, 18 Jun 2021 10:01:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231635AbhFRKDx (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 18 Jun 2021 06:03:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232792AbhFRKDq (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 18 Jun 2021 06:03:46 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 651D8C061574;
        Fri, 18 Jun 2021 03:01:32 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id i13so7834773edb.9;
        Fri, 18 Jun 2021 03:01:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=ZWdhnm5vDGxSTwGrEAnS5oQkzBaIx+HjqYEBbEhXdB4=;
        b=GuJplkfChAmI3RkGHuxkbjYR20jdrmahoJ7VjXV556/0O16AEz1DwguHfzTbsSi58+
         cA81CxgEWsohbp8gx8jPNpI8eXmvvx2MgZl3SxiKl1XbIjyeXgEVqHvKPVVI+MCzMAut
         Bnx1qUT/Uf582+qR3+HZGfRE8fsiEylLdgXLTLMi/sxzre9EJP8ofeL1UvForHvpmc12
         o+FwxS7BGyZmAMT3Pe5reI/HgyDlNmRua/NpzEPUmaWWE5bwaWe4xgFGE3xMyLDqdVOm
         HUSum0i/yLrCs2e0bdZA5zrrHKDpE60LRXPJiEMtv7BM+avYr9J8HqZdqVra61I1DqB9
         SljQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=ZWdhnm5vDGxSTwGrEAnS5oQkzBaIx+HjqYEBbEhXdB4=;
        b=Zi3b3fLI6qknlXEw8Ni7YJiolfZa3kMC9Nil1fiFcgeMPKupbnzsjlXiOuZWAzhmuq
         iWexJxu1qe5W7CInXf8Tk+s2v5CKiD6cnTaypba32j576o3S/6MnabHRvyeLryIuBTQz
         Z+K9JqIzyEToFfMUUPdGRlu6isnYkV85Bs71prROUu03ekNFmyKH+mFx0GE3P62NAKPD
         CzKwQeW0ESDUI1z77Ib+zDnbFoCuiIDDnIH83wsE7Rn4vid4kkFbpUJWYmqq6LrbSLlP
         iSIsGre2usgXpu11rYUukNFxSoHJz0wI6ziy+S2j2w1/UF9H/FzuNt2F4y8hFylX0jG0
         P1ew==
X-Gm-Message-State: AOAM53281YldytoKlWX1Hi2ZpwJgWmpocPQuLGa5yjgKCz4+H91G7Od1
        tdpGiu3Sqt6Prjkeog3cAXw=
X-Google-Smtp-Source: ABdhPJx5w1d1Yt+WgE6AqpaQ4JGs3nec/nsqxrUq/WDa/1qVhCe0xYRUPJ/2VlgP61+QbnLc5IwoUg==
X-Received: by 2002:a05:6402:22a1:: with SMTP id cx1mr1399725edb.338.1624010490862;
        Fri, 18 Jun 2021 03:01:30 -0700 (PDT)
Received: from [192.168.1.15] ([151.29.187.239])
        by smtp.gmail.com with ESMTPSA id m18sm842797ejx.56.2021.06.18.03.01.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Jun 2021 03:01:30 -0700 (PDT)
Message-ID: <da5b052d2c94db91c0bf8cb794c5cad299f19e57.camel@gmail.com>
Subject: Re: [PATCH] perf ksymbol: fix memory leak: decrease refcount of map
 and dso
From:   Riccardo Mancini <rickyman7@gmail.com>
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
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
Date:   Fri, 18 Jun 2021 12:01:28 +0200
In-Reply-To: <YLpxDf6+YOxYI5z3@kernel.org>
References: <20210602231052.317048-1-rickyman7@gmail.com>
         <CAP-5=fVxHUnwGoRypMjCsPSh_yo5PB8Hzbkx5ArA5b0=7S-67g@mail.gmail.com>
         <YLopMBgLWysdJbkm@kernel.org>
         <3b8c7c2c5de492c7fbf86df73c43cdb0fbb453df.camel@gmail.com>
         <YLpxDf6+YOxYI5z3@kernel.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.2 (3.40.2-1.fc34) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Hi, 

On Fri, 2021-06-04 at 15:29 -0300, Arnaldo Carvalho de Melo wrote:
<SNIP> 
> > > But looking at this code now I realize that maps__find() should grab a
> > > refcount for the map it returns, because in this
> > > machine__process_ksymbol_register() function we use reference that 'map'
> > > after the if block, i.e. we use it if it came from maps__find() or if we
> > > created it machine__process_ksymbol_register, so there is a possible
> > > race where other thread removes it from the list and map__put()s it
> > > ending up in map__delete() while we still use it in
> > > machine__process_ksymbol_register(), right?
> > 
> > Agree. It should be placed before up_read to avoid races, right?
> 
> Yes, we have to grab a refcount while we are sure its not going away,
> then return that as the lookup result, whoever receives that refcounted
> entry should use it and then drop the refcount.
> 
> > Then we would need to see where it's called and add the appropriate
> > map__put.
> 
> yes

This function has quite a number of callers (direct and indirect) so the the
patch is becoming huge. 

One of these callers is thread__find_map, which returns an addr_location
(actually it's an output argument). This addr_location holds references to map,
maps and thread without getting any refcnt (actually in one function it gets it
on the thread and a comment tells to put it once done). If I'm not wrong, this
addr_location is never malloced (always a local variable) and, is should be
present in parts of the code where there should be a refcnt on the thread.
Therefore, maybe it does not get the refcnts since it assumes that thread (upon
which depends maps and as a consequence map) is always refcnted in its context.
However, I think that it should get all refcnts anyways for clarity and to
prevent possible misuses (if I understood correctly, Ian is of the same
opinion).

My solution would be to add the refcnt grabbing for map, maps and thread in
thread__find_map, releasing them in addr_location__put, and then making sure all
callers call it when no longer in use.

Following the same reasoning, I added refcnt grabbing also to mem_info,
branch_info (map was already refcnted, I added it also to maps for coherency),
map_symbol (as in branch_info, I added it to maps), and in other places in which
I saw a pointer was passed without refcounting.

Most changes are quite trivial, however, the changelog is huge:
48 files changed, 472 insertions(+), 157 deletions(-)
Most of them are just returns converted to goto for calling the __put functions.

Doing so, I managed to remove memory leaks caused by refcounting also in perf-
report (I wanted to try also perf top but I encountered another memory-related
issue). However, the changelog is huge and testing all of it is challenging
(especially since I can test missing puts only with ASan's LeakSanitizer and its
reports are usually full of leaks, which I am trying to fix along the way, I
will send some patches in the following days). How would you go about it? Do you
have any suggestions?

>  
> > In addition, having a look at other possible concurrency issues in map.c:
> 
> Its good to have new eyes looking at this, exactly at a time we're
> discussing further parallelizing perf :-)
> 
> >  - maps__for_each_entry should always be called with either read or write
> > lock,
> > am I right? It looks like this is not done in certain parts of the code. If
> > such
> 
> Right.
> 
> > lock is taken, then grabbing the refcount on the looping variable is not
> > needed
> > unless we need to return it, right?
> 
> Right, returning an entry needs to take a refcount.
> 
> >  - maps__first and map__next do not grab a refcount and neither a lock. If
> > they're used through a lock-protected loop, it's not a problem, but maybe
> > it's
> 
> yes
> 
> > worth making explicit that they are not to be used directly (through either
> > a
> > comment or adding some underscores in their names).
> 
> yes, __ in front means, in kernel style, that it does less than the non
> __ prefixed, same name, function.
> 
> >  - maps__empty: should probably take a reader lock.
> 
> Indeed.
> 
> >  - maps__find_symbol: the returned symbol is not protected (the caller does
> > not
> > receive a refcount to neither map or dso, so if dso is deleted, his
> > reference to
> > the symbol gets invalidated). Depending on how it's being used it might not
> > be a
> > problem, but in the general scenario I think it's not thread-safe.
> 
> Yes, that function is also problematic.

This issue is easier to solve than expected since the map is returned as **mapp,
so it's just a matter of making sure that the caller always passes it and then
puts the refcnt.

Thanks,
Riccardo

> 
> Thanks for looking into this, please consider sending patches for these
> issues,
> 
> - Arnaldo


