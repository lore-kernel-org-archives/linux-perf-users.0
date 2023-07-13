Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51CC6C0015E
	for <linux-perf-users@archiver.kernel.org>; Thu, 13 Jul 2023 23:52:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232245AbjGMXv7 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 13 Jul 2023 19:51:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232193AbjGMXv5 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 13 Jul 2023 19:51:57 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94A421FCD
        for <linux-perf-users@vger.kernel.org>; Thu, 13 Jul 2023 16:51:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689292316; x=1720828316;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=xjExe+LHfnsZvF/kmciec8GJHBQ4DLvW34cLUJJw/w8=;
  b=g4OcBkI7o+SEmTyb2qixAVIYIgm7Y1r06Ezb/79IZcZKs/Sei5Gu5l1S
   56vQqWD+BjP6oEcb52z+BYH5KibUtX+BCSo7BzrS7QPa8peAhc/t55Mkg
   gTcNqu747zUSJlSnzxz/U9/EZgeBcBmCl3SmXBHFml79QMBh03gjMaYvS
   Z3Th2JSQgIBomQyg63qwjgEQFsKsRiXhJUU4y/dWeALJa84S19AFlMZfH
   Ru2Anrf5h80ooJEnb1oSzY40cEE/RJ8bFI3dS7UYsaz7w23oIkrBLsW1F
   ZfLb09LPgpcSsBDa4IsS9ZDnGDYCTKquRMiDW5Oak9ljPwnqVduOh9V0d
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10770"; a="367986039"
X-IronPort-AV: E=Sophos;i="6.01,204,1684825200"; 
   d="scan'208";a="367986039"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2023 16:51:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10770"; a="699454624"
X-IronPort-AV: E=Sophos;i="6.01,204,1684825200"; 
   d="scan'208";a="699454624"
Received: from tassilo.jf.intel.com (HELO tassilo) ([10.54.38.190])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2023 16:51:45 -0700
Date:   Thu, 13 Jul 2023 16:51:44 -0700
From:   Andi Kleen <ak@linux.intel.com>
To:     Ian Rogers <irogers@google.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>, namhyung@kernel.org,
        linux-perf-users@vger.kernel.org
Subject: Re: Event reordering regression for software events
Message-ID: <ZLCOEOtJOQiN+8VB@tassilo>
References: <ZLBgbHkbrfGygM/u@tassilo>
 <ZLBjI4a3wIMs75lA@kernel.org>
 <CAP-5=fU5Y95G2FsFdwxwPk=kLe=kka7CkD7ZDrzSU+Xv-Ks=Qg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fU5Y95G2FsFdwxwPk=kLe=kka7CkD7ZDrzSU+Xv-Ks=Qg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org


On Thu, Jul 13, 2023 at 02:24:22PM -0700, Ian Rogers wrote:
> On Thu, Jul 13, 2023 at 1:48 PM Arnaldo Carvalho de Melo
> <acme@kernel.org> wrote:
> >
> > Em Thu, Jul 13, 2023 at 01:37:00PM -0700, Andi Kleen escreveu:
> > > Hi Ian,
> > >
> > > The current post 6.3 linux-perf-next causes some fairly drastic
> > > reordering in output for some event combinations. I bisected it down to
> > > your patch:
> > >
> > > commit 347c2f0a0988c59c402148054ef54648853fa669
> > > Author: Ian Rogers <irogers@google.com>
> > > Date:   Sat Mar 11 18:15:40 2023 -0800
> > >
> > >     perf parse-events: Sort and group parsed events
> > >
> > >     This change is intended to be a no-op for most current cases, the
> > >     default sort order is the order the events were parsed. Where it
> > >     varies is in how groups are handled. Previously an uncore and core
> > >     event that are grouped would most often cause the group to be removed:
> > >
> 
> So this is a no-op for most current cases where event groups aren't
> used. The default order for events is the order they were inserted in.

This doesn't seem to be what happens because the patch reorders
top-level events outside group. (like all the top level "dummy"ies)

But this commit broke things that are completely unrelated to hybrid and uncore,
just plain software events not being in a group. There's no reason 
to reorder those.

Basically anything you do for hybrid and topdown shouldn't affect
anything else. That's the basic rule.


> Perf metric events require being in a group with the slots event
> first. There are assumptions in the perf code that sibling events are
> adjacent in the evlist. To fix and maintain all the requirements on
> the evlist we've gotten to where we are now. I've tried to make the
> code as simple and transparent as possible, but still fulfilling the
> requirements coming from perf metric events and hybrid. The logic is
> in parse_events__sort_events_and_fix_groups:

This random reordering approach is just not viable. I explained
this before. If you have a tool which generates the same event in
multiple instances (for which there are many valid reasons related
to multiplexing accuracy), then it absolutely cannot handle random
reordering. The tool doesn't know which instance of its event is where
if it's not in the same position.

If you find you need reordering for your purposes and you know
you don't rely on ordering make it some kind of opt-in.
But forcing it on all perf users doesn't work.


> > > wrong place, instead of the expected order.
> > >
> > > good:
> > >
> > > ...
> > > 986476553;ns;duration_time;986476553;100.00;;
> > > 0;;dummy;983952237;100.00;;
> > > 0;;cs:u;983952237;100.00;;
> > > 16532;;minor-faults:u;983952237;100.00;;
> > > 0;;major-faults:u;983952237;100.00;;
> > > 0;;migrations:u;983952237;100.00;;
> > > 3532509496;;cycles:u;23999092;2.00;;
> > > ....
> > >
> > > bad:
> > >
> > > 1010119571;ns;duration_time;1010119571;100.00;;
> > > 0;;dummy [software];1007748753;100.00;;
> > > 0;;cs:u [software];1007748753;100.00;;
> > > 16496;;minor-faults:u [software];1007748753;100.00;;
> > > 0;;major-faults:u [software];1007748753;100.00;;
> > > 0;;migrations:u [software];1007748753;100.00;;
> > > 0;;dummy [software];1007748753;100.00;;
> > > 0;;dummy [software];1007748753;100.00;;
> > > 0;;dummy [software];1007748753;100.00;;
> > > 0;;dummy [software];1007748753;100.00;;
> > > 0;;emulation-faults [software];1007748753;100.00;;
> > > 0;;dummy [software];1007748753;100.00;;
> > > 0;;dummy [software];1007748753;100.00;;
> > > 0;;emulation-faults [software];1007748753;100.00;;
> > > 0;;emulation-faults [software];1007748753;100.00;;

Please explain how this insane order can make sense even with hybrid
or metrics. 

> > > 3603193382;;cycles:u;23996241;2.00;;
> > > 2277091922;;cpu/event=0x0,umask=0x3/u;23996241;2.00;;
> > > 4182126406;;cpu/event=0xc2,umask=0x2/u;23996241;2.00;;
> > > 4364677170;;cpu/event=0xc0,umask=0x0/u;23996241;2.00;;
> > >
> > >
> > > Unfortunately this totally breaks toplev. It needs to have the dummies
> > > in the right location.`
> > >
> > > Another problem is that it also now adds [software] to lots of software
> > > events, which of course also breaks any parsing tools. I haven't bisected
> > > that too, but it needs fixing too.
> 
> There's nothing to bisect, the behavior has changed. We can revert the
> behavior, break Intel hybrid and Intel perf metric events, but that

I've been using perf metrics for many years without problems without this patch.

I know hybrid has some issues that need to be fixed, but that
absolutely cannot break basic properties like having a parseable
output format.

> would seem unfortunate. Tbh, the mistake here is the assumptions that
> toplev is making.

It's not an random assumption, it's the only way to parse perf output uniquely.

Please make it an option. But this cannot stay this way unconditionally 
if perf stat is supposed to stay a tool which can be used from other programs.

> > correctness, a necessary step to resume attempts at being multithreaded.
> >
> > We have seen a growing number of 'perf test' entries being submitted,
> > with writing shell scripts that check if the output from various command
> > lines produce expected results.
> >
> > It would really be great to have new entries that exercise what is
> > expected by toplev so that we really are careful with compatibility.
> 
> We are careful with compatibility, in fact we've written a number of
> tests to ensure the json and CSV output doesn't regress. Kan recently

The tests are super basic and don't seem to cover any even moderately
complex cases. Yes it's great that you wrote tests, but given
the poor coverage you really cannot rely on just a few basic unit
tests here.

Given that, and the wide usage of perf and the existence of Hyrum's law the
only safe way is to avoid changing default behaviors. If you want
some behavior change make it opt-in.

> Kan recently removed events and put metric names in the text output
> instead, even hiding events that have been programmed.. basically
> relying on text output is wrong and toplev is broken in this regard.

I missed your explanation how toplev is supposed to parse the output
then instead?

> Fixing hybrid and perf metric events weren't problems of my invention,
> nor were they done with a casual disregard for perf users and no care
> about breaking them. That said, testing can always be better so why
> not add toplev's tests to tools/perf/tests/shell ? This way I can only
> break things if I ignore a test regression.

toplev generates the perf command lines dynamically and they are highly
dependent on the current system.  I don't see a simple way to make
independent tests, unless you want a big case statement for existing systems,
or add most of toplev.

I guess could add some script that is the equivalent of

git clone https://github.com/andikleen/pmu-tools
cd pmu-tools
PERF=/point/to/new/perf/binary  ./tl-tester

if that helps? The toplev test suite has reasonably good coverage.


-Andi
