Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73822EB64DD
	for <linux-perf-users@archiver.kernel.org>; Fri, 14 Jul 2023 03:07:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232823AbjGNDHw (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 13 Jul 2023 23:07:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233207AbjGNDHu (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 13 Jul 2023 23:07:50 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7EB52D79
        for <linux-perf-users@vger.kernel.org>; Thu, 13 Jul 2023 20:07:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689304066; x=1720840066;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=rou1IB30FynuBlvWAl4I7YyzAEIHCxdUvZnlaGhIWi8=;
  b=C/msT+Xn0JRjBxuwGOrZlkqzt2HuusAaIetv7YoMhs6AzKJaQfMMuZsR
   LPW8mhOQgpwy7di0A3iEKVE6/zCf6mzZwaTCAPQ4d7tVMBeuaYfPZ+R5k
   ZQRFpVNQvxfrHruj15hP6/02ReZWHp9na9c+PVfXDj/zR80vDqkzp0n6d
   KvAD5/Zl/NFRC0S/ooqo34cdYb/y5kZ4Br+KPheRkGVOgRNFbPmC5GenU
   PweHrpIqdpel0kn4tGp1nC567oF8fb+J5hASSp+qXLP96CmNzjSky7ohr
   oq9RnrpB+nKwXlsIq+1BvZV5ZFj3o5RTIs4R7+MOWCfpURU7DHdHNcnvt
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10770"; a="368017338"
X-IronPort-AV: E=Sophos;i="6.01,204,1684825200"; 
   d="scan'208";a="368017338"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2023 20:07:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10770"; a="751875519"
X-IronPort-AV: E=Sophos;i="6.01,204,1684825200"; 
   d="scan'208";a="751875519"
Received: from tassilo.jf.intel.com (HELO tassilo) ([10.54.38.190])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2023 20:07:45 -0700
Date:   Thu, 13 Jul 2023 20:07:44 -0700
From:   Andi Kleen <ak@linux.intel.com>
To:     Ian Rogers <irogers@google.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>, namhyung@kernel.org,
        linux-perf-users@vger.kernel.org
Subject: Re: Event reordering regression for software events
Message-ID: <ZLC8AIEfUJMQFOEn@tassilo>
References: <ZLBgbHkbrfGygM/u@tassilo>
 <ZLBjI4a3wIMs75lA@kernel.org>
 <CAP-5=fU5Y95G2FsFdwxwPk=kLe=kka7CkD7ZDrzSU+Xv-Ks=Qg@mail.gmail.com>
 <ZLCOEOtJOQiN+8VB@tassilo>
 <CAP-5=fWjDeXZfgLu8hiavtkRGmWsZnwt3g+Ms5YPL12PxUaCgg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fWjDeXZfgLu8hiavtkRGmWsZnwt3g+Ms5YPL12PxUaCgg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Thu, Jul 13, 2023 at 06:14:16PM -0700, Ian Rogers wrote:
> On Thu, Jul 13, 2023 at 4:52 PM Andi Kleen <ak@linux.intel.com> wrote:
> >
> >
> > On Thu, Jul 13, 2023 at 02:24:22PM -0700, Ian Rogers wrote:
> > > On Thu, Jul 13, 2023 at 1:48 PM Arnaldo Carvalho de Melo
> > > <acme@kernel.org> wrote:
> > > >
> > > > Em Thu, Jul 13, 2023 at 01:37:00PM -0700, Andi Kleen escreveu:
> > > > > Hi Ian,
> > > > >
> > > > > The current post 6.3 linux-perf-next causes some fairly drastic
> > > > > reordering in output for some event combinations. I bisected it down to
> > > > > your patch:
> > > > >
> > > > > commit 347c2f0a0988c59c402148054ef54648853fa669
> > > > > Author: Ian Rogers <irogers@google.com>
> > > > > Date:   Sat Mar 11 18:15:40 2023 -0800
> > > > >
> > > > >     perf parse-events: Sort and group parsed events
> > > > >
> > > > >     This change is intended to be a no-op for most current cases, the
> > > > >     default sort order is the order the events were parsed. Where it
> > > > >     varies is in how groups are handled. Previously an uncore and core
> > > > >     event that are grouped would most often cause the group to be removed:
> > > > >
> > >
> > > So this is a no-op for most current cases where event groups aren't
> > > used. The default order for events is the order they were inserted in.
> >
> > This doesn't seem to be what happens because the patch reorders
> > top-level events outside group. (like all the top level "dummy"ies)
> >
> > But this commit broke things that are completely unrelated to hybrid and uncore,
> > just plain software events not being in a group. There's no reason
> > to reorder those.
> >
> > Basically anything you do for hybrid and topdown shouldn't affect
> > anything else. That's the basic rule.
> 
> It is not clear that modifying the order of events in the evlist
> qualifies as a breakage, 

I don't know what to say here. 

> and it is necessary because of complex kernel
> APIs that particularly in the case of perf metric events, Intel were
> responsible for.

But my example has no perf metrics.

Also taking a step back: 

You're saying reordering is needed for perf metrics because slots
has to come first in the group. 

But the expectation here was always that the user would specify
the groups this way, otherwise it doesn't work.  Do you disagree with
that?

So why does the perf tool need to fix it? Just pass it to the kernel
and it won't schedule and the user has to fix it.

Perhaps perf can give warnings to make it clearer.

I understand that the metrics code has to make sure to not generate
such groups, but that's a different problem that shouldn't affect how
non metrics events are handled.

Also I reviewed the commit in question and at least the example
doesn't even have perf metrics ?!? It's trying to fix some uncore issue.

So it seems what we're talking about here has nothing to do with 
perf metrics.

How about replacing the sorting commit with a warning and ask 
the user to do the reordering? Would that work for you?

> > > > > wrong place, instead of the expected order.
> > > > >
> > > > > good:
> > > > >
> > > > > ...
> > > > > 986476553;ns;duration_time;986476553;100.00;;
> > > > > 0;;dummy;983952237;100.00;;
> > > > > 0;;cs:u;983952237;100.00;;
> > > > > 16532;;minor-faults:u;983952237;100.00;;
> > > > > 0;;major-faults:u;983952237;100.00;;
> > > > > 0;;migrations:u;983952237;100.00;;
> > > > > 3532509496;;cycles:u;23999092;2.00;;
> > > > > ....
> > > > >
> > > > > bad:
> > > > >
> > > > > 1010119571;ns;duration_time;1010119571;100.00;;
> > > > > 0;;dummy [software];1007748753;100.00;;
> > > > > 0;;cs:u [software];1007748753;100.00;;
> > > > > 16496;;minor-faults:u [software];1007748753;100.00;;
> > > > > 0;;major-faults:u [software];1007748753;100.00;;
> > > > > 0;;migrations:u [software];1007748753;100.00;;
> > > > > 0;;dummy [software];1007748753;100.00;;
> > > > > 0;;dummy [software];1007748753;100.00;;
> > > > > 0;;dummy [software];1007748753;100.00;;
> > > > > 0;;dummy [software];1007748753;100.00;;
> > > > > 0;;emulation-faults [software];1007748753;100.00;;
> > > > > 0;;dummy [software];1007748753;100.00;;
> > > > > 0;;dummy [software];1007748753;100.00;;
> > > > > 0;;emulation-faults [software];1007748753;100.00;;
> > > > > 0;;emulation-faults [software];1007748753;100.00;;
> >
> > Please explain how this insane order can make sense even with hybrid
> > or metrics.
> 
> Tbh, I'm not sure what you are doing. linux-next is on 6.5 but you
> mention 6.3. You don't list a platform for testing on. I'm not even

6.3 was my original reference point, but since I bisected the issue
it's not 6.3 but exactly just this one commit that changes behavior.

The platform is SKX.

> 
> > > would seem unfortunate. Tbh, the mistake here is the assumptions that
> > > toplev is making.
> >
> > It's not an random assumption, it's the only way to parse perf output uniquely.
> >
> > Please make it an option. But this cannot stay this way unconditionally
> > if perf stat is supposed to stay a tool which can be used from other programs.
> 
> You should be using the json or CSV outputs. These are intended for

This is the CSV output that is reordered! (see the example you just
quoted)

I haven't tested JSON, but I assume that is reordered too.

> 
> For hybrid the problem of regrouping events still isn't properly
> solved. Consider:


Yes I understand that hybrid has issues. But the first step to solving
them is to not break existing platforms.

> 
> perf stat -e '{cycles,faults}' ...
> 
> On a hybrid system we get the cycles event for the cpu_atom and
> cpu_core PMUs, but faults as a software event will exist once and be
> grouped on only 1 of the PMUs. This behavior is clearly silly, faults
> should measure both on cpu_atom and cpu_core PMUs, as it would appear
> on a non-hybrid system, and we should fix this. But what you're
> arguing is that we can't and shouldn't as Hyrum's law tells us that
> someone is depending on the 1 PMU behavior.

TBH i don't have a strong opinion on keeping hybrid the same
As you say it is somewhat broken, so I guess there are less 
existing users and some change there is acceptable, as long
as it doesn't affect the more mature platforms.

As for your example it seems somewhat obscure and I would probably
consider it user error. The non PMU qualified support was really only intended to
keep existing perf record/stat default working, for everything else
it should be discouraged. Trying to fix every corner case
here automatically is unlikely to be productive.

So perhaps just print a warning in this case? 

> explicitly list the groups and PMUs. We need to make the tool behave
> properly for increasingly complex kernel PMU event requirements.

I agree, but reordering the complete event list with a huge impact
on non hybrid is not the way to do it.


> This issue is often made substantially more complex as fixing Intel's
> kernel PMU driver is pushed back upon - for example, we can't rely on
> weak groups,

I thought they still work most of the time?

-Andi
