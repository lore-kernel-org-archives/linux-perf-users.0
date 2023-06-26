Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73982EB64D7
	for <linux-perf-users@archiver.kernel.org>; Mon, 26 Jun 2023 16:38:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229638AbjFZQib (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 26 Jun 2023 12:38:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjFZQia (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 26 Jun 2023 12:38:30 -0400
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DA7783
        for <linux-perf-users@vger.kernel.org>; Mon, 26 Jun 2023 09:38:29 -0700 (PDT)
Received: by mail-qt1-x830.google.com with SMTP id d75a77b69052e-401d1d967beso4041cf.0
        for <linux-perf-users@vger.kernel.org>; Mon, 26 Jun 2023 09:38:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687797508; x=1690389508;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DdnlJZSXW5PwKmUgpPMGFTsKOOAqLa+rJ2YTia9KdGM=;
        b=LuTHwz5zxUE1jwKl7521XwqpYDku8bBx6vygKSLQOpjZbQkvNBIAHqatxw8QS7czB9
         oeBWofS8UqPS8GxWH06bJSqDGJBIhkHB9vqEymQWOdLUAtFZ26W2+/WFP8ENAmjqj6kN
         YoowWp4/8yQT+qZ+PRKHIjBc8rZqNUV+PVx0w6xo4W+//9rYeEpO3EvR0C/QI5Pmx0oJ
         IzWnL01L5b2uhOIaQZFgWR1rbPRosggeWcbk0rn1nLHchnf9+BnS3gz4kBxHM/mtIgaP
         q49ahWbGfAuTlSg/1WS2vxkUiFvv2g3OrmqzGGhep/7GEpXmYtNZZhY+YTvnqRaVV5wM
         lrsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687797508; x=1690389508;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DdnlJZSXW5PwKmUgpPMGFTsKOOAqLa+rJ2YTia9KdGM=;
        b=aZUzJuoa4lRuTPI9bUILQYOOdZY383NpYXlAkHfCiy6BixM01TLWn9n5n3J1Z3e8SL
         1wfpi7Z87j9RhFalwMhz8Bbop3Oh9kB/G3PY1nT1o/xvMAT9U16jWtW9qbQVZJ5H0oW2
         wrN07OE89i5KGBA8jsrk7QF1dP+gWVwfXIOPcKszkoQnj4yTj4bTr2Or5+tpy3gdvTyk
         9FRWXhgOjjVN41dOLWsmrgTLyU+fwk2qpFfam8/rWKPv0u9ZgOieFAdJpWbk5YzBzCgM
         2W+lIosdCbRIN3nyRncZCwrmio4+YCzoy+apH/CBA8K/6YMivsGxA6SC6IWlON5avP7u
         QDpg==
X-Gm-Message-State: AC+VfDypleb8lhtdeuS73U1tb1l1BkNqH2NYCLgb/G1T2FYQwYNNoLq2
        lXEyoqoBOJk+hUPcu+4qT139ldMcWoZ0hr56bM+0xg==
X-Google-Smtp-Source: ACHHUZ5CBGGKaMIKkNz3aZA5nkPZYuue/90sL4zOip+IPc83LbAJRuFnPL/jd+cJ5It0gjasi7W7ESmGAfFfxl5ztiA=
X-Received: by 2002:a05:622a:1826:b0:3f9:a986:f3a4 with SMTP id
 t38-20020a05622a182600b003f9a986f3a4mr435591qtc.25.1687797508477; Mon, 26 Jun
 2023 09:38:28 -0700 (PDT)
MIME-Version: 1.0
References: <151a8677-3259-0586-03f3-fb751782daa9@oracle.com>
 <CAP-5=fXDVUToBbS6z8YY9K0vh5Z=PHh83RZXX3=NugTEqFeXzQ@mail.gmail.com> <5bebf78f-15ce-7aaa-eaed-41cd49f53d68@oracle.com>
In-Reply-To: <5bebf78f-15ce-7aaa-eaed-41cd49f53d68@oracle.com>
From:   Ian Rogers <irogers@google.com>
Date:   Mon, 26 Jun 2023 09:38:16 -0700
Message-ID: <CAP-5=fUjPAmisSkfPJUzorrev2FwWMeMHBBXF1Sh2WfAg8KHzA@mail.gmail.com>
Subject: Re: perf test pmu-events question
To:     John Garry <john.g.garry@oracle.com>
Cc:     acme@kernel.org, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Mon, Jun 26, 2023 at 6:33=E2=80=AFAM John Garry <john.g.garry@oracle.com=
> wrote:
>
> On 23/06/2023 16:48, Ian Rogers wrote:
> > On Fri, Jun 23, 2023 at 8:20=E2=80=AFAM John Garry <john.g.garry@oracle=
.com> wrote:
> >>
> >> Hi Ian,
> >>
> >> I was doing some re-write for pmu sys events metric support and I want
> >> to add more testcases - we don't really have any.
> >>
> >> So I noticed that tests/pmu-events.c::test__parsing() can pick up on a=
n
> >> invalid metric for the test CPU, like M3 as it references itself.
> >> However we can't detect whether event aliases referenced in the metric
> >> exist for the CPU. Is it worth testing for this? Would it be sane to
> >> scan the associated CPU event tables to see if we can find the event
> >> there? Or do we already have some per-non-test-CPU metric validator
> >> already in the testcases (I could not see it)?
> >
>
> Hi Ian,
>
> Thanks for getting back to me.
>
> >
> > Hi John,
> >
> > we always need more tests :-)
>
> Sure
>
> > For Intel there has historically been a
> > problem that the names in metrics and the event data will get out of
> > alignment. There is a best effort test during the metric generation
> > that this doesn't happen any more here:
> > https://urldefense.com/v3/__https://github.com/intel/perfmon/blob/main/=
scripts/create_perf_json.py*L1171-L1188__;Iw!!ACWV5N9M2RV99hQ!OKyD56aIReczg=
aPkGD3MZ0yZ-WFe7qXps1aFyF6pibEN8nk0r4N5Y87MgV0twed_V8E8l7kjJd88_AjTGW8$
>
> Does that validate alias event support for the CPU? It seems that the
> specific lines mentioned are just checking for keywords.

So we filter out all of the keywords and then assert the named thing
is either an event or an auxiliary metric:
assert v in events or v.upper() in events or v in infoname or v in aux,

I agree, the weight of the code is toward skipping the keywords.

> > But still things get messed up, such as PMU names being mismatched -
> > when this happens the JSON events just don't appear at runtime. We
> > could try to replicate the event matching logic at creation time in
> > jevents.py and that should do what you mention and be
> > multi-architecture.
>
> OK, that could work. It is limited to testing just aliases, which I
> suppose has some value.

Note, I'm going to try avoid using the name aliases as it is
overloaded in the tool whereas we tend to just mean event. It is
likely the code/comments in the tool will slowly migrate to my
preference :-)

> However I am not sure how well this would suit testing sys event metric
> support, where I want to ensure that a specific event alias is chosen
> for a metric in the same pmu_sys_events struct.

Are you specifying the PMU? If not there is a danger the event will
match >1 PMU.

> > The metric test tests every metric produces an
> > output, and this fails when event parsing fails, so this has
> > traditionally been the way to find bad metrics.
> >We do have build time
> > tests like:
> > https://urldefense.com/v3/__https://git.kernel.org/pub/scm/linux/kernel=
/git/perf/perf-tools-next.git/tree/tools/perf/pmu-events/Build?h=3Dperf-too=
ls-next*n30__;Iw!!ACWV5N9M2RV99hQ!OKyD56aIReczgaPkGD3MZ0yZ-WFe7qXps1aFyF6pi=
bEN8nk0r4N5Y87MgV0twed_V8E8l7kjJd882X6fEUE$
>
> This just tests invalid metric format, right?

So this specific test is checking the metric code passes some unit
tests. When we parse metrics from json, in jevents.py, we use this
code and it will throw exceptions if the json metric is badly formed.
You probably remember seeing patches fixes parentheses.

> >
> > Intel don't have JSON encodings for the TSX events and so they use
> > sysfs events and this is what motivated the has_event test:
> > https://urldefense.com/v3/__https://lore.kernel.org/linux-perf-users/20=
230623151016.4193660-1-irogers@google.com/__;!!ACWV5N9M2RV99hQ!OKyD56aIRecz=
gaPkGD3MZ0yZ-WFe7qXps1aFyF6pibEN8nk0r4N5Y87MgV0twed_V8E8l7kjJd88rRd1z5c$
> >
> > Some other thoughts in this area:
> > 1) I'd like to get sysfs snapshots so that we can get things like
> > parse-events coverage of heterogeneous PMUs without needing such a
> > system.
>
> That idea would seem good to testing other sort of uncore PMUs - for
> example, since I don't have access to a system which supports sys
> events, I need to bodge the kernel to support some fake PMU kernel
> driver for things like smmu pmcg.

My thoughts too. I lack a lot of heterogeneous systems for testing.

> > 2) The largest part of the perf binary is the json data.
>
> oh
>
> > I'd like to
> > convert the json data to a sysfs style, then compress it in a way
> > where we benefit from duplication between files (zip can't do this,
> > but tgz or 7zip can). libarchive can load these formats from memory.
> > The current json data on x86 converts to about 7MB of read-only data,
> > but the same json files compress down to about 1.5MB. The perf binary
> > is about 3MB of code, so doing the compression should hopefully make
> > the file size about half what it currently is and do something to stem
> > the problem of the binary slowly growing over time with new
> > architecture releases.
>
> ok, sounds reasonable if slow binary loading is really a problem.

The time for perf to parse events I will probably regress with
compression, because of the need to decompress. The file size is an
issue that comes up when the binary is installed at the scale Google
does (both devices and data centers). We're over 10MB and edging
slowly toward 11MB as Intel add models.

> > 3) I'm hoping we can do something like a unionfs with the in memory
> > sysfs, on disk sysfs tar balls and the like, and the machine's actual
> > sysfs so that we can just have one consistent view in the tool.
> > 4) I want to make PMUs lazier so that we don't need to eagerly load
> > all the events. The cycles event doesn't need json or sysfs data, but
> > it is all still loaded due to wanting the PMU. This faults in a lot of
> > JSON data on x86 that is then never used.
> >
> That should be pretty easy to do by only needing to setup event aliases
> et al when we have events which are not from known config terms, right?

Yeah, it feels low hanging. The code turns every json event and sysfs
event into a perf_pmu_alias when the PMU is created, the events are
sorted and then we search them at parse time. We can avoid doing this
and search the jevents.py created tables instead. This should turn
loading n events into log2(n) for the sake of the search. This will
change with the compressed version, and the behavior will depend on
the compression format. This is why I like the idea of punting the
problem to libarchive.

Thanks,
Ian

> Thanks,
> John
