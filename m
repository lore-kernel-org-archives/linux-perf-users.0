Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36146EB64DC
	for <linux-perf-users@archiver.kernel.org>; Tue, 18 Jul 2023 18:25:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229544AbjGRSZe (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 18 Jul 2023 14:25:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbjGRSZd (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 18 Jul 2023 14:25:33 -0400
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75779DD
        for <linux-perf-users@vger.kernel.org>; Tue, 18 Jul 2023 11:25:30 -0700 (PDT)
Received: by mail-qt1-x830.google.com with SMTP id d75a77b69052e-403f21d3c2dso350931cf.1
        for <linux-perf-users@vger.kernel.org>; Tue, 18 Jul 2023 11:25:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689704729; x=1692296729;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y/PxRwR3OTlH3pV//Xqln6mioB7cPnR2f/0ynVsnZ14=;
        b=jQcZhcEVxPypBJsUmxPlIJgj6I7DnrOpGXxKcJg71Y8DzY5AuqH2cZe1X3c4JybW7o
         N6S1EGbqPmGhHyOsiGL4NCdTEVp4Kpc0/sK82xounbbUtb64F3OEo+v6XCgptdB/DIV3
         jHqQgfQI22QkSqtJAMS6XY2oil9UDtCVspgvdTUREbF/9uOSqTYAfR0GqXqAhVC5wME8
         TQT/kstIisSGMRJUmzkErWqoyDcvdsF8aa/lXKhwzzJqI2scpsJYCLjIbisGjxUj4ZrG
         Ivq/qRGbk690E4J71bNHWQehs3HVQNANZjndIiRlF44XGjfT7pYCkLaqshBIiFr+B2Nd
         Bvhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689704729; x=1692296729;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y/PxRwR3OTlH3pV//Xqln6mioB7cPnR2f/0ynVsnZ14=;
        b=McnF4pYcKSLElJYaYPgzaptYT5k934WGkCWJ4DeyE68zeCsnlFf5hjTIq7mSCPaukg
         7btTPImavJDDtdZn+TobIF+atGp6rjIxjgo3Ub1e/OKrmMtX/RQCPDQSI3D3jeJZeH2G
         WH1pVCI385GfWfOmzyAdFUotcYDRkMM4RogdB8j5sN6fZwNvOZWNFBWswu2+08eaAAOy
         3+sSyyGST9j7++ZJC3JDdr2E7IDyHzx+nzUXqAi3NY/JYyh8T9UZkLI0rDbwejN7IYKU
         uzltqXj1kHF8gjclAquTGxTht7Kq9UyESTDB7MRWhB3Q5OlgmctfD/3prmqq/KTnj8jx
         m7GA==
X-Gm-Message-State: ABy/qLYOZ/Zjw6AdHWBaZoGDEW+/TosDUJlSfbCobtKWi6GR4d91q+6k
        h4nJDgM2+SSCgyxutBDT1S855QPE/j/J1MD4ejsNdGidOpVypW7EXKxy1A==
X-Google-Smtp-Source: APBJJlF+WJDXb2sbnDfQA6ZUIjTu5r93PNMqundlRfgqMS5Hv4Mo7cuhqYI0bSohurQxQGlBYlZGsX9gAdQzkptz+UU=
X-Received: by 2002:a05:622a:193:b0:3ef:5f97:258f with SMTP id
 s19-20020a05622a019300b003ef5f97258fmr344686qtw.16.1689704729310; Tue, 18 Jul
 2023 11:25:29 -0700 (PDT)
MIME-Version: 1.0
References: <ZLBgbHkbrfGygM/u@tassilo> <ZLBjI4a3wIMs75lA@kernel.org>
 <CAP-5=fU5Y95G2FsFdwxwPk=kLe=kka7CkD7ZDrzSU+Xv-Ks=Qg@mail.gmail.com>
 <ZLCOEOtJOQiN+8VB@tassilo> <CAP-5=fWjDeXZfgLu8hiavtkRGmWsZnwt3g+Ms5YPL12PxUaCgg@mail.gmail.com>
 <ZLC8AIEfUJMQFOEn@tassilo> <CAP-5=fVWyrmRHCmNGRrME-YSSwbJV90-_dcC=LyNAXjk9baMGA@mail.gmail.com>
 <ZLSgzJsom0avu/hX@tassilo>
In-Reply-To: <ZLSgzJsom0avu/hX@tassilo>
From:   Ian Rogers <irogers@google.com>
Date:   Tue, 18 Jul 2023 11:25:17 -0700
Message-ID: <CAP-5=fUJEzvq4GNfdk-FOXxM=MvQyDWYksPRNz_=W2+6UuVgrg@mail.gmail.com>
Subject: Re: Event reordering regression for software events
To:     Andi Kleen <ak@linux.intel.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>, namhyung@kernel.org,
        linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Sun, Jul 16, 2023 at 7:00=E2=80=AFPM Andi Kleen <ak@linux.intel.com> wro=
te:
>
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

Yes, the current ordering is defined here:
https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tr=
ee/tools/perf/arch/x86/util/evlist.c?h=3Dperf-tools-next#n79

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
> reorderable (well technically someone could have a dependency on that
> too, but at least in my mind that's much less likely than their
> dependency just being on the metric)
>
> So what it really needs is a sort only insight the metric.
>
> That shouldn't be too hard to implement, right?

I'll describe why this isn't a fix below.

> Also I guess we could add some test cases on avoiding reordering,
> although I'm optimistic that once it is established that reordering
> should be minimized/avoided it is unlikely to be something
> that breask frequently.
>
> Would it be possible to revert the global sort patch until that
> is sorted out? Otherwise I'm afraid I'll end up with perf releases
> that are absolutely incompatible to toplev, and I'll get problems
> with my user base who often cannot easily update perf.

This would break the majority of metrics from Icelake forward.

> Arnaldo, can you please comment on this, what is your policy
> on regressions here?
>
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

So you've resisted working through what your issue with the sorting
is. To call the sorting arbitrary is of course wrong, but you keep
wanting to say everything the perf tool is doing is wrong. Moving
forward...

What is happening in your example is straightforward. The sorting
code's goal is to keep events in their place but what to do about:
perf stat -e 'cycles,{uncore_imc_free_running/data_read/,uncore_imc_free_ru=
nning/data_write/}'
where there are 2 uncore_imc_free_running PMUs? After parsing the
evlist looks like:
cycles,{uncore_imc_free_running_0/data_read/,uncore_imc_free_running_1/data=
_read/,uncore_imc_free_running_0/data_write/,uncore_imc_free_running_1/data=
_write/}
We need to turn 1 group into 2, we need to reorder by the PMUs, this leads =
to:
cycles,{uncore_imc_free_running_0/data_read/,uncore_imc_free_running_0/data=
_write/},{uncore_imc_free_running_1/data_read/,uncore_imc_free_running_1/da=
ta_write/}
There is no regression here, it has always been perf's behavior to
reorder events and create groups globally.
When sorting groups the code uses the position in the original list of
the group's leader:
https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tr=
ee/tools/perf/util/parse-events.c?h=3Dperf-tools-next#n2124
For events within a group it sorts them by group PMU name (which is
normally just the PMU name), if the PMU names are the same it sorts
the events by their original position in the list possibly corrected
for perf metric events.

Okay, so now imagine the lack of grouping brought about by perf metric
(topdown) events and broken Intel PMUs that fail to break weak groups.
For a hypothetical example we create a list of events like:
perf stat -e 'topdown-fe-bound,cycles,instructions,slots'
As with the group case we need to reorder the events to have slots and
topdown-fe-bound together and grouped. The code achieves:
{slots,topdown-fe-bound},cycles,instructions
As grouped events need to be adjacent in the evlist, we need to sort
all the events without a group to be together and place the perf
metric events first. They are then placed in a group.
So that we best respect the order of ungrouped and grouped events, we
place the ungrouped events as if they are a group with a leader with
the index of the first ungrouped event.
https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tr=
ee/tools/perf/util/parse-events.c?h=3Dperf-tools-next#n2101
https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tr=
ee/tools/perf/util/parse-events.c?h=3Dperf-tools-next#n2170

So this then comes to your example where you have ungrouped events,
grouped events in a giant list. Well on Icelake+ we could have perf
metric events in those ungrouped events, this means we need to sort
the ungrouped events together, potentially moving perf metric events
to the front and grouping them.

Hey hey hey, you say. I'm on SkylakeX and don't have perf metric
events. Why should the tool be trying to sort events to fix issues on
a PMU I don't have?
The problem is that Icelake+ architectures all have this issue and I
keep trying to make the code simpler and do the same thing for
everybody. I got rid of hardcoded "cpu_atom" and "cpu_core", the
separate hybrid event parsing, ... I'm trying to make it that perf
isn't a concatenated group of architecture specific PMU drivers and
there is commonality in how everything is done.
Well you say, I still want my ungrouped events to be scattered around
my list and you better not move them as that is the world's largest
regression, is crazy arbitrary rubbish and please go dump all your
changes in the garbage.

I disagree, the sorting is doing its best to only fix what is
necessary and otherwise to rely on the command line. That said, it can
only fix:
perf stat -e 'slots,{uncore_imc_free_running_0/data_read/,uncore_imc_free_r=
unning_1/data_read/},topdown-fe-bound'
If it is able to move slots and topdown-fe-bound to be adjacent.

So how can I make you happy:
1) throw everything away.. well that would be a challenge, break stuff
and I don't want to fix the resultant mess.
2) we can sort only for metrics. This leads to metric event parsing
and event parsing, duplication, testing and other issues. I'm trying
to make metrics sit on top of event parsing and not fork them. This is
more true after the hybrid changes, where things like setting up a
default cycles event is done through event parsing to avoid
duplication of the wildcard logic. Plus we still need event sorting
and grouping logic without metrics for at least uncore events.
3) we can sort only on Icelake+ architectures. Well isn't that the
majority of what Intel cares about now-a-days? It also leads to having
2 code paths and testing problems. It also won't work as uncore events
won't be sorted, regrouped and fixed.
4) we add a special toplev flag that disables sorting and grouping.
Well that will break sorting and grouping of uncore events and so I
don't think this will make you happy.
5)  we add a special toplev flag that on detecting a core PMUs causes
sorting and regrouping to be disabled. This isn't much better than 4
and still unlikely to make you happy.

So what can we do?
1) change how perf metric (topdown) events are implemented in the PMU.
This strategy works best with a time machine and we're duty bound, in
that case, to fix other problems in history.
2) stop toplev being a PITA? Wouldn't that be nice.
3) we do some kind of ungrouped event sorting hack. Rather than make
every ungrouped event look like having a common leader index, we only
do that for events that need to be forced into a group (perf metric
events). This should mean ungrouped events are sorted wrt groups in
the place they are originally in the list. This should fix the
pre-Icelake problems but on Icelake+ we can still get the "arbitrary"
reordering issue you so despise for perf metric events.

I'm going to give (3) a go and mail it today.

> > > The platform is SKX.
> > >
> > > >
> > > > > > would seem unfortunate. Tbh, the mistake here is the assumption=
s that
> > > > > > toplev is making.
> > > > >
> > > > > It's not an random assumption, it's the only way to parse perf ou=
tput uniquely.
> > > > >
> > > > > Please make it an option. But this cannot stay this way unconditi=
onally
> > > > > if perf stat is supposed to stay a tool which can be used from ot=
her programs.
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
> perf stat --json -e '{cycles,branches},{cycles,cache-misses}' how would y=
ou
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

Ugh.. am I being motivated here to fix your toplev problem?

> > Does SKX have uncore? Yes, so you need to reorder events and this
> > change didn't start it.
>
> Yes of course it has an uncore.
>
> You only need to reorder if you create broken groups.  At least my tool
> doesn't generate them.

Zip-a-Dee-Doo-Dah.

> > NO_GROUP_EVENTS is used to avoid a group being used, an important use
> > being avoiding PMU driver bugs.
> >
>
> Hmm, not sure what that is refering to, but ok.

You can take the metrics and remove the NO_GROUP_EVENTS. The failure
mode is that the weak group fails to be broken. I believe the issues
to be some mix of errata, naivety in the fake PMU driver when
scheduling onto counters and not appreciating that not all counters
are created equal, possible bugs, etc. The issues may not just be on
the core PMU, it depends on the metric.

Given I'm fixing things for you, can you please fix:
$ perf stat -e 'slots,branches,slots' -a sleep 1
to not multiplex on Icelake+.

This can be achieved with:
```
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -2607,7 +2607,7 @@ static int group_can_go_on(struct perf_event
*event, int can_add_hw)
        * Otherwise, try to add it if all previous groups were able
        * to go on.
        */
-       return can_add_hw;
+       return 1;
}

static void add_event_to_ctx(struct perf_event *event,
```
That means we'll consider adding every hardware event just as we
consider adding every software event. A more complex fix would be to
make can_add_hw some kind of bitmap that indicates different counter
types are available, and to only stop searching only when all counter
types are exhausted. I'm perfectly happy getting rid of the can_add_hw
optimization and not worrying about the potential extra overhead. That
overhead is theoretic and under user control. The unnecessary
multiplexing is just silly and unavoidable.

Thanks,
Ian

> -Andi
