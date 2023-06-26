Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57E69EB64D9
	for <linux-perf-users@archiver.kernel.org>; Mon, 26 Jun 2023 18:07:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229806AbjFZSH3 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 26 Jun 2023 14:07:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbjFZSH2 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 26 Jun 2023 14:07:28 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9EF59F
        for <linux-perf-users@vger.kernel.org>; Mon, 26 Jun 2023 11:07:25 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-1b8161f564dso18185ad.1
        for <linux-perf-users@vger.kernel.org>; Mon, 26 Jun 2023 11:07:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687802845; x=1690394845;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cEQ+FuIQOYkWgCqc1YNSU1PGy8wBOlLZz0xAyQ9snSo=;
        b=AqSlE8AXRHg6pVCxFZvrVsikYcGvHRNa4aMXmGi7Whabrri//eErmSol+nQkjfzEWV
         hYFnB+Bf1ZBLQc2NbTsJ7JcZJ+CMxXRaHJRtqnWBuZF0mZ0xvQ/yfdAwsXdQbxNVIQOE
         GnoIMStepRMeWniOn+pkSmnbVis5u7PR1mZ4cyqP5DcfYY2RBay8dgyEeVUTYg3HsWB9
         SRQvT0M+Xl4YknhiXdkgKpIMqupMfWan7QsQxHVtQFVBeCsKmNPwAnXnxVtn4W/eFMUs
         ku4ryitFS5VPyF5jcYRyn6SA56UEd4AQ/r9k+ekHI5fLEbFLnE5/g9hKckgIbgH90EVW
         upnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687802845; x=1690394845;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cEQ+FuIQOYkWgCqc1YNSU1PGy8wBOlLZz0xAyQ9snSo=;
        b=P08KOx35KuiBp9jTTOw4FSyjpSISE8szaMOsRXaL9AFgLgJwdspEu9GayRwhyrrs0Q
         10u72qsiFU0/IH5mqwYc5jXcGyFSs8nS7cQL3t/cDRZjqoRczEy/HPdAyMF9y+E61yh+
         dfhpztPVXFNEwmft8sVaDZngzXv4//uWmjXtOZHPRg1dVOuzQObfq9gGZCvC6ez8QbNX
         flyu3/BAPYuof0bwHK2bQ3S++5A68GSTSgU99c/bFfWPzHBu82L3UX7MNmc4aZouuS6l
         ThEv2O7oC3KEBoVhQTSXMFT0ofM1w4S3Dg5cL2tAu3G/K0KM//tpYINejU0bCbnE9JIy
         l3FA==
X-Gm-Message-State: AC+VfDxDu71sev3q2+yjPNwQYQ76j6OvzW6E4XzeIPe/Rtu5+V3krxDz
        Iwz5Cq/5ro0z5WXhkJXSe2oYmM4j1NEU255p11XWtI1J7HrTfBbaPI6NPQ==
X-Google-Smtp-Source: ACHHUZ7tIBKmrplxXaourON1TxECHqfv27GBctBL109piyBcfk08q2JAWNEdpBwCw5gUaWCs8qmI2Vpb3dKpmWVU/QE=
X-Received: by 2002:a17:902:f54b:b0:1af:90ce:5266 with SMTP id
 h11-20020a170902f54b00b001af90ce5266mr1334847plf.29.1687802845052; Mon, 26
 Jun 2023 11:07:25 -0700 (PDT)
MIME-Version: 1.0
References: <151a8677-3259-0586-03f3-fb751782daa9@oracle.com>
 <CAP-5=fXDVUToBbS6z8YY9K0vh5Z=PHh83RZXX3=NugTEqFeXzQ@mail.gmail.com>
 <5bebf78f-15ce-7aaa-eaed-41cd49f53d68@oracle.com> <CAP-5=fUjPAmisSkfPJUzorrev2FwWMeMHBBXF1Sh2WfAg8KHzA@mail.gmail.com>
 <918d0318-59de-6423-3ead-5172c9870ca0@oracle.com>
In-Reply-To: <918d0318-59de-6423-3ead-5172c9870ca0@oracle.com>
From:   Ian Rogers <irogers@google.com>
Date:   Mon, 26 Jun 2023 11:07:13 -0700
Message-ID: <CAP-5=fVr6mW8_3eQo5=cXYewP01xn8+KbghHAZ=aeXDH1n4RJA@mail.gmail.com>
Subject: Re: perf test pmu-events question
To:     John Garry <john.g.garry@oracle.com>
Cc:     acme@kernel.org, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Mon, Jun 26, 2023 at 10:49=E2=80=AFAM John Garry <john.g.garry@oracle.co=
m> wrote:
>
> >
> >>> But still things get messed up, such as PMU names being mismatched -
> >>> when this happens the JSON events just don't appear at runtime. We
> >>> could try to replicate the event matching logic at creation time in
> >>> jevents.py and that should do what you mention and be
> >>> multi-architecture.
> >>
> >> OK, that could work. It is limited to testing just aliases, which I
> >> suppose has some value.
> >
> > Note, I'm going to try avoid using the name aliases as it is
> > overloaded in the tool whereas we tend to just mean event. It is
> > likely the code/comments in the tool will slowly migrate to my
> > preference :-)
> >
> >> However I am not sure how well this would suit testing sys event metri=
c
> >> support, where I want to ensure that a specific event alias is chosen
> >> for a metric in the same pmu_sys_events struct.
> >
> > Are you specifying the PMU?
>
> We specify the event, which obviously includes the PMU "unit" and
> "compat", which we can match against. When all the events match in the
> metric expr, then we know the metric is supported in the system.

So when an event is specified then we end up in this code:
https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tr=
ee/tools/perf/util/parse-events.y?h=3Dperf-tools-next#n335
that is we take the event name, add it to a term list, then try adding
the event (as a term) to every PMU. Were the same event to be on >1
PMU then we'd open an event for each PMU. We use this for opening
uncore and hybrid (multiple heterogeneous PMUs) events.

> I may send this series as an RFC and maybe you can kindly suggest what
> testcases to add ...

sure :-)

> > If not there is a danger the event will
> > match >1 PMU.
>
> Do you mean match 1> homogeneous PMU? Or events for heterogeneous PMUs
> may clash?
>
> If the former, then this is ok. If the latter, then this is always a
> problem.

So because the event is opened on every PMU, there could conceivably
be a PMU with the same named event and this may break the metric. We
do this all the time for Intel, so the danger isn't so great.

We should probably make cases like:
..
MetricName: "IPC",
MetrcExpr: "instructions / cycles",
..
work for heterogeneous systems (we don't currently match legacy
instructions and cycles events on anything other than core PMUs). I
believe the example above would open events like:
{pmu1/cycles/,pmu1/instructions/},{pmu2/cycles/,pmu2/instructions/}
but when we do the metric set up we'll only look at the first group of
events. For Intel hybrid metrics we're avoiding this by duplicating
metrics and each metric specifies the PMU with the event.

Anyway, looking forward to the RFC. Thanks,
Ian

> >
> >>> The metric test tests every metric produces an
> >>> output, and this fails when event parsing fails, so this has
> >>> traditionally been the way to find bad metrics.
> >>> We do have build time
> >>> tests like:
> >>> https://urldefense.com/v3/__https://git.kernel.org/pub/scm/linux/kern=
el/git/perf/perf-tools-next.git/tree/tools/perf/pmu-events/Build?h=3Dperf-t=
ools-next*n30__;Iw!!ACWV5N9M2RV99hQ!OKyD56aIReczgaPkGD3MZ0yZ-WFe7qXps1aFyF6=
pibEN8nk0r4N5Y87MgV0twed_V8E8l7kjJd882X6fEUE$
> >>
> >> This just tests invalid metric format, right?
> >
> > So this specific test is checking the metric code passes some unit
> > tests. When we parse metrics from json, in jevents.py, we use this
> > code and it will throw exceptions if the json metric is badly formed.
> > You probably remember seeing patches fixes parentheses.
>
> yes...
>
> >
> >>>
> >>> Intel don't have JSON encodings for the TSX events and so they use
> >>> sysfs events and this is what motivated the has_event test:
> >>> https://urldefense.com/v3/__https://lore.kernel.org/linux-perf-users/=
20230623151016.4193660-1-irogers@google.com/__;!!ACWV5N9M2RV99hQ!OKyD56aIRe=
czgaPkGD3MZ0yZ-WFe7qXps1aFyF6pibEN8nk0r4N5Y87MgV0twed_V8E8l7kjJd88rRd1z5c$
> >>>
> >>> Some other thoughts in this area:
> >>> 1) I'd like to get sysfs snapshots so that we can get things like
> >>> parse-events coverage of heterogeneous PMUs without needing such a
> >>> system.
> >>
> >> That idea would seem good to testing other sort of uncore PMUs - for
> >> example, since I don't have access to a system which supports sys
> >> events, I need to bodge the kernel to support some fake PMU kernel
> >> driver for things like smmu pmcg.
> >
> > My thoughts too. I lack a lot of heterogeneous systems for testing.
> >
> >>> 2) The largest part of the perf binary is the json data.
> >>
> >> oh
> >>
> >>> I'd like to
> >>> convert the json data to a sysfs style, then compress it in a way
> >>> where we benefit from duplication between files (zip can't do this,
> >>> but tgz or 7zip can). libarchive can load these formats from memory.
> >>> The current json data on x86 converts to about 7MB of read-only data,
> >>> but the same json files compress down to about 1.5MB. The perf binary
> >>> is about 3MB of code, so doing the compression should hopefully make
> >>> the file size about half what it currently is and do something to ste=
m
> >>> the problem of the binary slowly growing over time with new
> >>> architecture releases.
> >>
> >> ok, sounds reasonable if slow binary loading is really a problem.
> >
> > The time for perf to parse events I will probably regress with
> > compression, because of the need to decompress. The file size is an
> > issue that comes up when the binary is installed at the scale Google
> > does (both devices and data centers). We're over 10MB and edging
> > slowly toward 11MB as Intel add models.
>
> ok
>
> >
> >>> 3) I'm hoping we can do something like a unionfs with the in memory
> >>> sysfs, on disk sysfs tar balls and the like, and the machine's actual
> >>> sysfs so that we can just have one consistent view in the tool.
> >>> 4) I want to make PMUs lazier so that we don't need to eagerly load
> >>> all the events. The cycles event doesn't need json or sysfs data, but
> >>> it is all still loaded due to wanting the PMU. This faults in a lot o=
f
> >>> JSON data on x86 that is then never used.
> >>>
> >> That should be pretty easy to do by only needing to setup event aliase=
s
> >> et al when we have events which are not from known config terms, right=
?
> >
> > Yeah, it feels low hanging. The code turns every json event and sysfs
> > event into a perf_pmu_alias when the PMU is created, the events are
> > sorted and then we search them at parse time. We can avoid doing this
> > and search the jevents.py created tables instead. This should turn
> > loading n events into log2(n) for the sake of the search. This will
> > change with the compressed version, and the behavior will depend on
> > the compression format. This is why I like the idea of punting the
> > problem to libarchive.
> >
>
> ok
>
> Thanks,
> John
>
