Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D09CC001B0
	for <linux-perf-users@archiver.kernel.org>; Fri, 14 Jul 2023 01:14:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229905AbjGNBOc (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 13 Jul 2023 21:14:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229580AbjGNBOb (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 13 Jul 2023 21:14:31 -0400
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7B1B2D5D
        for <linux-perf-users@vger.kernel.org>; Thu, 13 Jul 2023 18:14:28 -0700 (PDT)
Received: by mail-qt1-x835.google.com with SMTP id d75a77b69052e-4036bd4fff1so161391cf.0
        for <linux-perf-users@vger.kernel.org>; Thu, 13 Jul 2023 18:14:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689297268; x=1691889268;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IEWZd+CmsG+Cqu9falG0N2+M4Jgy5s9Rc3vMXBG89AU=;
        b=CZNgsscP5uf+XlaEqy9vnUxst1j9rmchjTHKc3Iw2WUA5DGQD20O7G4XDQwUs8OwSE
         BggpyTEPbmLtw/WcO2+hj86xFdV4ZQqqNkE9fBtsz4s9aH9q6+QFVwh+grz07p1EN1Wm
         57u9iq4XipcB5Q6nofqTSnMuHX3eClNr0yk30f8UYpZGZLGN9KGdrXGGZ4bma9WIETXc
         P7OCy4MDMLHczB+NQ6hKwoC3VM/5YXTS0Z1q6b0S1QZQhhi0ybJKnYaJF8vVICYZTtd2
         8QB1r5OJPzqGnuRpuyFyEJscJ8FcCEXHDZzDZt5D8vqL6ouBMYR4g2yHWLlxpD8PC8mx
         rYaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689297268; x=1691889268;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IEWZd+CmsG+Cqu9falG0N2+M4Jgy5s9Rc3vMXBG89AU=;
        b=dBM/o1m6CLhQql3YMAHYqQSKp8HsSXKD7RmyifbugxGQAnXnDgHvfzQXYWayiYCOMH
         jtDpX2yRubLpFEvOcWMLJfQMqmHBa0OElg6ZZZhh6mxVxMkt1v3gu9H6IZczw2KopcCV
         SDobs1WC9UNUUwbDoDRgepdsAuGEXOOCelE72SQarOctXADs+ZUYnLHvEtRg9wPlqY6P
         7fN1LObHXh8axiCiTVZNFGxcsSdNFU7y0AD1cLMyNAbVXj6CVf+MauTWEO7K5ptTHLOM
         tB9Nk4zmJNuPAK42fn7KTFQKIjIplgQ0prY5Me7eRdp72J5Bn/sH3UY1Vm1UeY9QvE/q
         Bclw==
X-Gm-Message-State: ABy/qLZnWPf0EfjlWbKCyunP9dczddBaFrt9xT7+d4+pZpAouYQNStzE
        pC26jw6L5kGRLh3RwuSuqmMS0XKvSdIYwNhI0CVTwA==
X-Google-Smtp-Source: APBJJlHaR3nyILt3LcMfzLSqTztCMTgRv2xylXHrsh46KYDaoizlLjhw6lNVaGCBpN9McA94OrmztN4c9V4K2oyvGpY=
X-Received: by 2002:a05:622a:1311:b0:3fd:ad1b:4e8a with SMTP id
 v17-20020a05622a131100b003fdad1b4e8amr785466qtk.22.1689297267768; Thu, 13 Jul
 2023 18:14:27 -0700 (PDT)
MIME-Version: 1.0
References: <ZLBgbHkbrfGygM/u@tassilo> <ZLBjI4a3wIMs75lA@kernel.org>
 <CAP-5=fU5Y95G2FsFdwxwPk=kLe=kka7CkD7ZDrzSU+Xv-Ks=Qg@mail.gmail.com> <ZLCOEOtJOQiN+8VB@tassilo>
In-Reply-To: <ZLCOEOtJOQiN+8VB@tassilo>
From:   Ian Rogers <irogers@google.com>
Date:   Thu, 13 Jul 2023 18:14:16 -0700
Message-ID: <CAP-5=fWjDeXZfgLu8hiavtkRGmWsZnwt3g+Ms5YPL12PxUaCgg@mail.gmail.com>
Subject: Re: Event reordering regression for software events
To:     Andi Kleen <ak@linux.intel.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>, namhyung@kernel.org,
        linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Thu, Jul 13, 2023 at 4:52=E2=80=AFPM Andi Kleen <ak@linux.intel.com> wro=
te:
>
>
> On Thu, Jul 13, 2023 at 02:24:22PM -0700, Ian Rogers wrote:
> > On Thu, Jul 13, 2023 at 1:48=E2=80=AFPM Arnaldo Carvalho de Melo
> > <acme@kernel.org> wrote:
> > >
> > > Em Thu, Jul 13, 2023 at 01:37:00PM -0700, Andi Kleen escreveu:
> > > > Hi Ian,
> > > >
> > > > The current post 6.3 linux-perf-next causes some fairly drastic
> > > > reordering in output for some event combinations. I bisected it dow=
n to
> > > > your patch:
> > > >
> > > > commit 347c2f0a0988c59c402148054ef54648853fa669
> > > > Author: Ian Rogers <irogers@google.com>
> > > > Date:   Sat Mar 11 18:15:40 2023 -0800
> > > >
> > > >     perf parse-events: Sort and group parsed events
> > > >
> > > >     This change is intended to be a no-op for most current cases, t=
he
> > > >     default sort order is the order the events were parsed. Where i=
t
> > > >     varies is in how groups are handled. Previously an uncore and c=
ore
> > > >     event that are grouped would most often cause the group to be r=
emoved:
> > > >
> >
> > So this is a no-op for most current cases where event groups aren't
> > used. The default order for events is the order they were inserted in.
>
> This doesn't seem to be what happens because the patch reorders
> top-level events outside group. (like all the top level "dummy"ies)
>
> But this commit broke things that are completely unrelated to hybrid and =
uncore,
> just plain software events not being in a group. There's no reason
> to reorder those.
>
> Basically anything you do for hybrid and topdown shouldn't affect
> anything else. That's the basic rule.

It is not clear that modifying the order of events in the evlist
qualifies as a breakage, and it is necessary because of complex kernel
APIs that particularly in the case of perf metric events, Intel were
responsible for.

> > Perf metric events require being in a group with the slots event
> > first. There are assumptions in the perf code that sibling events are
> > adjacent in the evlist. To fix and maintain all the requirements on
> > the evlist we've gotten to where we are now. I've tried to make the
> > code as simple and transparent as possible, but still fulfilling the
> > requirements coming from perf metric events and hybrid. The logic is
> > in parse_events__sort_events_and_fix_groups:
>
> This random reordering approach is just not viable. I explained
> this before. If you have a tool which generates the same event in
> multiple instances (for which there are many valid reasons related
> to multiplexing accuracy), then it absolutely cannot handle random
> reordering. The tool doesn't know which instance of its event is where
> if it's not in the same position.
>
> If you find you need reordering for your purposes and you know
> you don't rely on ordering make it some kind of opt-in.
> But forcing it on all perf users doesn't work.

As I keep explaining, the necessity has come from Intel.

>
> > > > wrong place, instead of the expected order.
> > > >
> > > > good:
> > > >
> > > > ...
> > > > 986476553;ns;duration_time;986476553;100.00;;
> > > > 0;;dummy;983952237;100.00;;
> > > > 0;;cs:u;983952237;100.00;;
> > > > 16532;;minor-faults:u;983952237;100.00;;
> > > > 0;;major-faults:u;983952237;100.00;;
> > > > 0;;migrations:u;983952237;100.00;;
> > > > 3532509496;;cycles:u;23999092;2.00;;
> > > > ....
> > > >
> > > > bad:
> > > >
> > > > 1010119571;ns;duration_time;1010119571;100.00;;
> > > > 0;;dummy [software];1007748753;100.00;;
> > > > 0;;cs:u [software];1007748753;100.00;;
> > > > 16496;;minor-faults:u [software];1007748753;100.00;;
> > > > 0;;major-faults:u [software];1007748753;100.00;;
> > > > 0;;migrations:u [software];1007748753;100.00;;
> > > > 0;;dummy [software];1007748753;100.00;;
> > > > 0;;dummy [software];1007748753;100.00;;
> > > > 0;;dummy [software];1007748753;100.00;;
> > > > 0;;dummy [software];1007748753;100.00;;
> > > > 0;;emulation-faults [software];1007748753;100.00;;
> > > > 0;;dummy [software];1007748753;100.00;;
> > > > 0;;dummy [software];1007748753;100.00;;
> > > > 0;;emulation-faults [software];1007748753;100.00;;
> > > > 0;;emulation-faults [software];1007748753;100.00;;
>
> Please explain how this insane order can make sense even with hybrid
> or metrics.

Tbh, I'm not sure what you are doing. linux-next is on 6.5 but you
mention 6.3. You don't list a platform for testing on. I'm not even
sure if this is a sincere bug report or just a rant that things have
changed. I've hopefully motivated and explained why things changed,
pointing to the exact location in the code that the changes in the
evlist occur.

> > > > 3603193382;;cycles:u;23996241;2.00;;
> > > > 2277091922;;cpu/event=3D0x0,umask=3D0x3/u;23996241;2.00;;
> > > > 4182126406;;cpu/event=3D0xc2,umask=3D0x2/u;23996241;2.00;;
> > > > 4364677170;;cpu/event=3D0xc0,umask=3D0x0/u;23996241;2.00;;
> > > >
> > > >
> > > > Unfortunately this totally breaks toplev. It needs to have the dumm=
ies
> > > > in the right location.`
> > > >
> > > > Another problem is that it also now adds [software] to lots of soft=
ware
> > > > events, which of course also breaks any parsing tools. I haven't bi=
sected
> > > > that too, but it needs fixing too.
> >
> > There's nothing to bisect, the behavior has changed. We can revert the
> > behavior, break Intel hybrid and Intel perf metric events, but that
>
> I've been using perf metrics for many years without problems without this=
 patch.
>
> I know hybrid has some issues that need to be fixed, but that
> absolutely cannot break basic properties like having a parseable
> output format.

I think the last count I had hybrid was broken in about a dozen
different regards in Linux perf 6.4. It was a substantial undertaking
fixing in for 6.5, where fixes were making the tool not segv, produce
meaningful counts), etc. "some issues" is a complete
misclassification, the perf tool on a hybrid system is barely usable
in Linux 6.4. Running perf test is sufficient to confirm this.

> > would seem unfortunate. Tbh, the mistake here is the assumptions that
> > toplev is making.
>
> It's not an random assumption, it's the only way to parse perf output uni=
quely.
>
> Please make it an option. But this cannot stay this way unconditionally
> if perf stat is supposed to stay a tool which can be used from other prog=
rams.

You should be using the json or CSV outputs. These are intended for
tool consumption, but the formats could be better. The text output, as
argued to me by your colleagues, is for human consumption and so
should read well in preference to legacy compatibility.

> > > correctness, a necessary step to resume attempts at being multithread=
ed.
> > >
> > > We have seen a growing number of 'perf test' entries being submitted,
> > > with writing shell scripts that check if the output from various comm=
and
> > > lines produce expected results.
> > >
> > > It would really be great to have new entries that exercise what is
> > > expected by toplev so that we really are careful with compatibility.
> >
> > We are careful with compatibility, in fact we've written a number of
> > tests to ensure the json and CSV output doesn't regress. Kan recently
>
> The tests are super basic and don't seem to cover any even moderately
> complex cases. Yes it's great that you wrote tests, but given
> the poor coverage you really cannot rely on just a few basic unit
> tests here.
>
> Given that, and the wide usage of perf and the existence of Hyrum's law t=
he
> only safe way is to avoid changing default behaviors. If you want
> some behavior change make it opt-in.

Sure, can we reverse decisions relating to the perf metric events API
and its grouping requirements? No, so we're stuck with an imperfect
world where the tool has to do the best it can.

For hybrid the problem of regrouping events still isn't properly
solved. Consider:

perf stat -e '{cycles,faults}' ...

On a hybrid system we get the cycles event for the cpu_atom and
cpu_core PMUs, but faults as a software event will exist once and be
grouped on only 1 of the PMUs. This behavior is clearly silly, faults
should measure both on cpu_atom and cpu_core PMUs, as it would appear
on a non-hybrid system, and we should fix this. But what you're
arguing is that we can't and shouldn't as Hyrum's law tells us that
someone is depending on the 1 PMU behavior. I don't believe this, or
if they are depending on the behavior they are silly and should
explicitly list the groups and PMUs. We need to make the tool behave
properly for increasingly complex kernel PMU event requirements.
Changing the evlist to make things work for the complex kernel event
requirements isn't the same as saying we're willfully trying to break
users, we're trying to make users succeed even as the underlying CPUs,
PMUs, etc. become more complex.

This issue is often made substantially more complex as fixing Intel's
kernel PMU driver is pushed back upon - for example, we can't rely on
weak groups, or "perf stat -e 'slots,branches,slots' -I 1000" has the
branches event multiplexing for no reason.

> > Kan recently removed events and put metric names in the text output
> > instead, even hiding events that have been programmed.. basically
> > relying on text output is wrong and toplev is broken in this regard.
>
> I missed your explanation how toplev is supposed to parse the output
> then instead?

Use the json or CSV output formats, json should be more stable as
values are labelled.

> > Fixing hybrid and perf metric events weren't problems of my invention,
> > nor were they done with a casual disregard for perf users and no care
> > about breaking them. That said, testing can always be better so why
> > not add toplev's tests to tools/perf/tests/shell ? This way I can only
> > break things if I ignore a test regression.
>
> toplev generates the perf command lines dynamically and they are highly
> dependent on the current system.  I don't see a simple way to make
> independent tests, unless you want a big case statement for existing syst=
ems,
> or add most of toplev.

Some minimal tests could be:
 - tests that repeat examples from man pages
 - tests for bugs past and present
 - some form of maximal stress test
I don't know toplev and don't have time to set this up.

Thanks,
Ian

> I guess could add some script that is the equivalent of
>
> git clone https://github.com/andikleen/pmu-tools
> cd pmu-tools
> PERF=3D/point/to/new/perf/binary  ./tl-tester
>
> if that helps? The toplev test suite has reasonably good coverage.
>
>
> -Andi
