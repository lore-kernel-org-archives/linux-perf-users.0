Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9872DEB64DA
	for <linux-perf-users@archiver.kernel.org>; Fri, 14 Jul 2023 03:57:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234028AbjGND5L (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 13 Jul 2023 23:57:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232628AbjGND5K (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 13 Jul 2023 23:57:10 -0400
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE899172C
        for <linux-perf-users@vger.kernel.org>; Thu, 13 Jul 2023 20:57:08 -0700 (PDT)
Received: by mail-qt1-x829.google.com with SMTP id d75a77b69052e-401d1d967beso186281cf.0
        for <linux-perf-users@vger.kernel.org>; Thu, 13 Jul 2023 20:57:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689307027; x=1691899027;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=htegYZfgmpQ3v9m4bx9+Ki71xF3o4mVnRkDC0HI10ic=;
        b=uW42K/ScrlW9P77c118q+eqS+/4ihh3F5o7KdtqIq6uObZaCXbzxtUKS/vglFEYTX3
         2zWfxm8hCBCLO4InoTWWf/CsQiE6xRlCEhJh5sjMzMZNUHOuMwj9d9eEM2KzzzIDkuQe
         Dv/7onXF0zW/xtwhJz/iMeSaRZQ9jHeikoFKxWGehIe5O+OlzIGM6JKNlovscvvZtM6p
         yWEpuxz9K7M5bNHIzrEQO9amY3gEqDtgEycKoAnOl7KyaPCyU6gV00ArMxpy110/rZy+
         cZ5Ia6Jfa15PyVQkJiUNgBbRcIKOWZNbe/t8OZKgThBBLELj/vI7h5mG5W76u2Aj1A2l
         1+MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689307027; x=1691899027;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=htegYZfgmpQ3v9m4bx9+Ki71xF3o4mVnRkDC0HI10ic=;
        b=SZzIHaAhEJLztCFvdSPbtXTv85eksPvW0tFvoYL9h5Isfx0AgstzWo+mQ6NcEar0Xe
         0YllfTzKobMLEfh015A/qY+5kpECOawA3wKymgsAAZ9nUv9ZahMymWPr1j0sWKDX8EjP
         4nZent+uZ+zRggYVUfv7Zf4hRdfhef+JDnlfjEevQmEvHw7i4qVrGzRneNfUsdDO8o19
         lidtr6Gq3hwRDvw8/sNQ6XrZ7XTVbj3NWEps1w0y2YQEal3/Wjx0yepWXk0Z/OaGUcNR
         NHWJp7m0mtknpbVYyIEq+iSWrrpflUPZ/SvVQDIJ6aAs9YWWcQTPhm706XbGhpdzDjud
         RBEg==
X-Gm-Message-State: ABy/qLabJ0Ashj9lxRrap4yC5lZQwG8p5S3WpxRZlYxNfwjPLat1PjNs
        1R0tGeohPAFFooGxgZf+VUYSUslKRn28vHEBytPdbnvtt2Iln3W7fd6nYA==
X-Google-Smtp-Source: APBJJlGbTO3UqtFlj0g4AT2BDaK2PPV3BPft5rhOydzLJ5msA4soFwWcjf5lqowVlv8sHSmAflBzukhDqBN/zXj8yzE=
X-Received: by 2002:a05:622a:1009:b0:403:b3ab:393e with SMTP id
 d9-20020a05622a100900b00403b3ab393emr729567qte.18.1689307027436; Thu, 13 Jul
 2023 20:57:07 -0700 (PDT)
MIME-Version: 1.0
References: <ZLBgbHkbrfGygM/u@tassilo> <ZLBjI4a3wIMs75lA@kernel.org>
 <CAP-5=fU5Y95G2FsFdwxwPk=kLe=kka7CkD7ZDrzSU+Xv-Ks=Qg@mail.gmail.com>
 <ZLCOEOtJOQiN+8VB@tassilo> <CAP-5=fWjDeXZfgLu8hiavtkRGmWsZnwt3g+Ms5YPL12PxUaCgg@mail.gmail.com>
 <ZLC8AIEfUJMQFOEn@tassilo>
In-Reply-To: <ZLC8AIEfUJMQFOEn@tassilo>
From:   Ian Rogers <irogers@google.com>
Date:   Thu, 13 Jul 2023 20:56:55 -0700
Message-ID: <CAP-5=fVWyrmRHCmNGRrME-YSSwbJV90-_dcC=LyNAXjk9baMGA@mail.gmail.com>
Subject: Re: Event reordering regression for software events
To:     Andi Kleen <ak@linux.intel.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>, namhyung@kernel.org,
        linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Thu, Jul 13, 2023 at 8:07=E2=80=AFPM Andi Kleen <ak@linux.intel.com> wro=
te:
>
> On Thu, Jul 13, 2023 at 06:14:16PM -0700, Ian Rogers wrote:
> > On Thu, Jul 13, 2023 at 4:52=E2=80=AFPM Andi Kleen <ak@linux.intel.com>=
 wrote:
> > >
> > >
> > > On Thu, Jul 13, 2023 at 02:24:22PM -0700, Ian Rogers wrote:
> > > > On Thu, Jul 13, 2023 at 1:48=E2=80=AFPM Arnaldo Carvalho de Melo
> > > > <acme@kernel.org> wrote:
> > > > >
> > > > > Em Thu, Jul 13, 2023 at 01:37:00PM -0700, Andi Kleen escreveu:
> > > > > > Hi Ian,
> > > > > >
> > > > > > The current post 6.3 linux-perf-next causes some fairly drastic
> > > > > > reordering in output for some event combinations. I bisected it=
 down to
> > > > > > your patch:
> > > > > >
> > > > > > commit 347c2f0a0988c59c402148054ef54648853fa669
> > > > > > Author: Ian Rogers <irogers@google.com>
> > > > > > Date:   Sat Mar 11 18:15:40 2023 -0800
> > > > > >
> > > > > >     perf parse-events: Sort and group parsed events
> > > > > >
> > > > > >     This change is intended to be a no-op for most current case=
s, the
> > > > > >     default sort order is the order the events were parsed. Whe=
re it
> > > > > >     varies is in how groups are handled. Previously an uncore a=
nd core
> > > > > >     event that are grouped would most often cause the group to =
be removed:
> > > > > >
> > > >
> > > > So this is a no-op for most current cases where event groups aren't
> > > > used. The default order for events is the order they were inserted =
in.
> > >
> > > This doesn't seem to be what happens because the patch reorders
> > > top-level events outside group. (like all the top level "dummy"ies)
> > >
> > > But this commit broke things that are completely unrelated to hybrid =
and uncore,
> > > just plain software events not being in a group. There's no reason
> > > to reorder those.
> > >
> > > Basically anything you do for hybrid and topdown shouldn't affect
> > > anything else. That's the basic rule.
> >
> > It is not clear that modifying the order of events in the evlist
> > qualifies as a breakage,
>
> I don't know what to say here.

We do wildcard expansion of the PMUs, which leads to the evlist order
being unstable. Fwiw this will change with:
https://lore.kernel.org/lkml/20230711055859.1242497-1-irogers@google.com/

> > and it is necessary because of complex kernel
> > APIs that particularly in the case of perf metric events, Intel were
> > responsible for.
>
> But my example has no perf metrics.
>
> Also taking a step back:
>
> You're saying reordering is needed for perf metrics because slots
> has to come first in the group.
>
> But the expectation here was always that the user would specify
> the groups this way, otherwise it doesn't work.  Do you disagree with
> that?

Yes I disagree. We can't always force perf metric events in a group
because weak groups don't always work. When we place the perf metric
events outside of a group they are broken. So now we don't group the
events and fix the topdown events to be in a group, in arch specific
code. It is a complete pain brought about by the Intel core PMU
driver.

> So why does the perf tool need to fix it? Just pass it to the kernel
> and it won't schedule and the user has to fix it.

Because in some cases, and the cases I have happened to care about,
the groups of events come from metrics.

> Perhaps perf can give warnings to make it clearer.

We do warn when we reorder the events.

> I understand that the metrics code has to make sure to not generate
> such groups, but that's a different problem that shouldn't affect how
> non metrics events are handled.

But things like wildcard group expansion and regrouping is a metric
problem too. So why would there be a parse events for metrics and a
separate one for events? Doing it this way would make metric group
testing significantly more hard too, as we can't just try the events
without the metric.

> Also I reviewed the commit in question and at least the example
> doesn't even have perf metrics ?!? It's trying to fix some uncore issue.

The uncore issue has been long standing, however, the fix used to be
in a separate "fix uncore" function. Then there was a similar "fix
hybrid" function. What is different now is that there is a single fix
function that isn't hard coded to Intel PMU names, etc.

> So it seems what we're talking about here has nothing to do with
> perf metrics.
>
> How about replacing the sorting commit with a warning and ask
> the user to do the reordering? Would that work for you?

No.

> > > > > > wrong place, instead of the expected order.
> > > > > >
> > > > > > good:
> > > > > >
> > > > > > ...
> > > > > > 986476553;ns;duration_time;986476553;100.00;;
> > > > > > 0;;dummy;983952237;100.00;;
> > > > > > 0;;cs:u;983952237;100.00;;
> > > > > > 16532;;minor-faults:u;983952237;100.00;;
> > > > > > 0;;major-faults:u;983952237;100.00;;
> > > > > > 0;;migrations:u;983952237;100.00;;
> > > > > > 3532509496;;cycles:u;23999092;2.00;;
> > > > > > ....
> > > > > >
> > > > > > bad:
> > > > > >
> > > > > > 1010119571;ns;duration_time;1010119571;100.00;;
> > > > > > 0;;dummy [software];1007748753;100.00;;
> > > > > > 0;;cs:u [software];1007748753;100.00;;
> > > > > > 16496;;minor-faults:u [software];1007748753;100.00;;
> > > > > > 0;;major-faults:u [software];1007748753;100.00;;
> > > > > > 0;;migrations:u [software];1007748753;100.00;;
> > > > > > 0;;dummy [software];1007748753;100.00;;
> > > > > > 0;;dummy [software];1007748753;100.00;;
> > > > > > 0;;dummy [software];1007748753;100.00;;
> > > > > > 0;;dummy [software];1007748753;100.00;;
> > > > > > 0;;emulation-faults [software];1007748753;100.00;;
> > > > > > 0;;dummy [software];1007748753;100.00;;
> > > > > > 0;;dummy [software];1007748753;100.00;;
> > > > > > 0;;emulation-faults [software];1007748753;100.00;;
> > > > > > 0;;emulation-faults [software];1007748753;100.00;;
> > >
> > > Please explain how this insane order can make sense even with hybrid
> > > or metrics.
> >
> > Tbh, I'm not sure what you are doing. linux-next is on 6.5 but you
> > mention 6.3. You don't list a platform for testing on. I'm not even
>
> 6.3 was my original reference point, but since I bisected the issue
> it's not 6.3 but exactly just this one commit that changes behavior.
>
> The platform is SKX.
>
> >
> > > > would seem unfortunate. Tbh, the mistake here is the assumptions th=
at
> > > > toplev is making.
> > >
> > > It's not an random assumption, it's the only way to parse perf output=
 uniquely.
> > >
> > > Please make it an option. But this cannot stay this way unconditional=
ly
> > > if perf stat is supposed to stay a tool which can be used from other =
programs.
> >
> > You should be using the json or CSV outputs. These are intended for
>
> This is the CSV output that is reordered! (see the example you just
> quoted)
>
> I haven't tested JSON, but I assume that is reordered too.

The output of the JSON is a dictionary and inherently unordered.

> >
> > For hybrid the problem of regrouping events still isn't properly
> > solved. Consider:
>
>
> Yes I understand that hybrid has issues. But the first step to solving
> them is to not break existing platforms.

This is a false assertion. Coverage testing is up about 10%, we have
more tests and more tests passing on more platforms. Objectively the
code base has improved. On hybrid the behavior is night and day -
crashes vs having the complete TopdownL1 working on both PMUs, testing
parity with non-hybrid. We also fixed all address and leak sanitizer
bugs. Perf in Linux 6.5 even without the awesome new features like
lock contention analysis, is the best perf tool we've ever had.

> >
> > perf stat -e '{cycles,faults}' ...
> >
> > On a hybrid system we get the cycles event for the cpu_atom and
> > cpu_core PMUs, but faults as a software event will exist once and be
> > grouped on only 1 of the PMUs. This behavior is clearly silly, faults
> > should measure both on cpu_atom and cpu_core PMUs, as it would appear
> > on a non-hybrid system, and we should fix this. But what you're
> > arguing is that we can't and shouldn't as Hyrum's law tells us that
> > someone is depending on the 1 PMU behavior.
>
> TBH i don't have a strong opinion on keeping hybrid the same
> As you say it is somewhat broken, so I guess there are less
> existing users and some change there is acceptable, as long
> as it doesn't affect the more mature platforms.
>
> As for your example it seems somewhat obscure and I would probably
> consider it user error. The non PMU qualified support was really only int=
ended to
> keep existing perf record/stat default working, for everything else
> it should be discouraged. Trying to fix every corner case
> here automatically is unlikely to be productive.
>
> So perhaps just print a warning in this case?
>
> > explicitly list the groups and PMUs. We need to make the tool behave
> > properly for increasingly complex kernel PMU event requirements.
>
> I agree, but reordering the complete event list with a huge impact
> on non hybrid is not the way to do it.

Does SKX have uncore? Yes, so you need to reorder events and this
change didn't start it.

>
> > This issue is often made substantially more complex as fixing Intel's
> > kernel PMU driver is pushed back upon - for example, we can't rely on
> > weak groups,
>
> I thought they still work most of the time?

$ for i in `ls tools/perf/pmu-events/arch/x86/*/*-metrics.json`; do
echo -n "$i "; grep NO_GROUP_EVENTS $i|wc -l; done
tools/perf/pmu-events/arch/x86/alderlake/adl-metrics.json 21
tools/perf/pmu-events/arch/x86/alderlaken/adln-metrics.json 2
tools/perf/pmu-events/arch/x86/broadwell/bdw-metrics.json 20
tools/perf/pmu-events/arch/x86/broadwellde/bdwde-metrics.json 20
tools/perf/pmu-events/arch/x86/broadwellx/bdx-metrics.json 23
tools/perf/pmu-events/arch/x86/cascadelakex/clx-metrics.json 32
tools/perf/pmu-events/arch/x86/elkhartlake/ehl-metrics.json 0
tools/perf/pmu-events/arch/x86/haswell/hsw-metrics.json 20
tools/perf/pmu-events/arch/x86/haswellx/hsx-metrics.json 23
tools/perf/pmu-events/arch/x86/icelake/icl-metrics.json 19
tools/perf/pmu-events/arch/x86/icelakex/icx-metrics.json 19
tools/perf/pmu-events/arch/x86/ivybridge/ivb-metrics.json 20
tools/perf/pmu-events/arch/x86/ivytown/ivt-metrics.json 23
tools/perf/pmu-events/arch/x86/jaketown/jkt-metrics.json 8
tools/perf/pmu-events/arch/x86/rocketlake/rkl-metrics.json 19
tools/perf/pmu-events/arch/x86/sandybridge/snb-metrics.json 8
tools/perf/pmu-events/arch/x86/sapphirerapids/spr-metrics.json 19
tools/perf/pmu-events/arch/x86/skylake/skl-metrics.json 30
tools/perf/pmu-events/arch/x86/skylakex/skx-metrics.json 31
tools/perf/pmu-events/arch/x86/tigerlake/tgl-metrics.json 19

NO_GROUP_EVENTS is used to avoid a group being used, an important use
being avoiding PMU driver bugs.

Thanks,
Ian

> -Andi
