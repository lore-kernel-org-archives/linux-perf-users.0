Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1A17C433EF
	for <linux-perf-users@archiver.kernel.org>; Wed, 18 May 2022 00:09:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232308AbiERAJN (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 17 May 2022 20:09:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232239AbiERAJL (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 17 May 2022 20:09:11 -0400
Received: from mail-vs1-xe34.google.com (mail-vs1-xe34.google.com [IPv6:2607:f8b0:4864:20::e34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF8AC45799
        for <linux-perf-users@vger.kernel.org>; Tue, 17 May 2022 17:09:10 -0700 (PDT)
Received: by mail-vs1-xe34.google.com with SMTP id y74so390121vsy.7
        for <linux-perf-users@vger.kernel.org>; Tue, 17 May 2022 17:09:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pqp1MkO8s5Q/fWvI1J1RmXv6S9bzNtcu8DiXX3zt1gw=;
        b=A9lwE2CvTnmNhVd7OXASzUSBNwUY7FVWhMDUPV5Y094VfJtedUz1F37weVWeQ4a9hV
         P3RdUprYgW3hKrYiUZCi+lNJr8ATqszNcCZ8MVv4t0v2RQ+eXShI2ntest3dJOJiwPaT
         vutWW0S0A5jTkvd4GnLGev1vVYXkKrmJL8GpXSZYuNeXrSDWQAGsIGNiV3Gr481cDvaW
         1EpMKVYblyh75+nim4Im9NBevYz97tZwA4UxOMDmPiH3eYrgPs1UhyN0u1VeJv7MdUxy
         UujTUbEvIDLbY5GzvEIZv6gvJHPj6d44FDgjFxDiy+Gox2rFeE7oatb2h7uRwKrgXq0+
         tPAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pqp1MkO8s5Q/fWvI1J1RmXv6S9bzNtcu8DiXX3zt1gw=;
        b=rsaM7qbZcC+vtPWwYoMDd8NNZHCp31i8RTYqFPbyMrUc9AOu98a4LSQdISYDCsWyj/
         m2s8C/uj66RK+bAAG3HNGbExJwcWjElZe89wBCRObGaEe9lc+ne+A+nCfBOpmSiXfO25
         7ECqQAIcOzV9rR8cg15pVqCKvlqnwfFTgpE+jbzLwMJrfNxNIELEx7NTJ+2y7G72CgZ2
         4p4wxk2zJPSVIUHTUp5fJk/ZN5JL5vYSxSx1IEWfmKxYgp9+FNQdPp5tWb8F6cFA8K0o
         WIbqoOaKwVwav56Qg/WW6RAvfbbEnV4Q4RKZSc/1Dc2YZ4nmzCODCMaPFGpqFJapC4Mk
         byeQ==
X-Gm-Message-State: AOAM532k83DUa0PTPX9laMUcLPpeEfteRCSFpiEDF810HbJqMYz29g//
        xY8yXyBVHyQkgnegr3ZnjxOhklwAOw3veKufKf4yOQ==
X-Google-Smtp-Source: ABdhPJwV4GUJWd82mo0ieKCaoxkqe7NgiyddUADRIYl7A+OVnrUKD2V/HxWM0z8nN+0mHD8DPqz4E0imXY+nmrQaVWk=
X-Received: by 2002:a05:6102:2929:b0:32d:6662:72e2 with SMTP id
 cz41-20020a056102292900b0032d666272e2mr10546186vsb.56.1652832549602; Tue, 17
 May 2022 17:09:09 -0700 (PDT)
MIME-Version: 1.0
References: <20220507053410.3798748-1-irogers@google.com> <20220507053410.3798748-2-irogers@google.com>
 <YnkTIwiVBEGUJRKn@kernel.org> <b01a66c4-ec4d-ccb7-8ca7-130d93855177@linux.intel.com>
 <708fab8f-b5c5-8f34-4322-3e337c56b869@linux.intel.com> <CAM9d7cgEc9o9y-fH==avzucigmMVw0AwooGw0eufb2+D568-_g@mail.gmail.com>
In-Reply-To: <CAM9d7cgEc9o9y-fH==avzucigmMVw0AwooGw0eufb2+D568-_g@mail.gmail.com>
From:   Ian Rogers <irogers@google.com>
Date:   Tue, 17 May 2022 17:08:56 -0700
Message-ID: <CAP-5=fXM41WooXuzhToLQhfYN2OSmoLEHRZqP2v2yowQWbySig@mail.gmail.com>
Subject: Re: [PATCH 1/5] Revert "perf stat: Support metrics with hybrid events"
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Xing Zhengjun <zhengjun.xing@linux.intel.com>,
        "Liang, Kan" <kan.liang@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Riccardo Mancini <rickyman7@gmail.com>,
        Kim Phillips <kim.phillips@amd.com>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Shunsuke Nakamura <nakamura.shun@fujitsu.com>,
        Florian Fischer <florian.fischer@muhq.space>,
        Andi Kleen <ak@linux.intel.com>,
        John Garry <john.garry@huawei.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        James Clark <james.clark@arm.com>,
        linux-perf-users <linux-perf-users@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Tue, May 17, 2022 at 3:58 PM Namhyung Kim <namhyung@kernel.org> wrote:
>
> Hello,
>
> On Tue, May 10, 2022 at 2:31 AM Xing Zhengjun
> <zhengjun.xing@linux.intel.com> wrote:
> >
> >
> >
> > On 5/10/2022 5:55 AM, Liang, Kan wrote:
> > >
> > >
> > > On 5/9/2022 9:12 AM, Arnaldo Carvalho de Melo wrote:
> > >> Em Fri, May 06, 2022 at 10:34:06PM -0700, Ian Rogers escreveu:
> > >>> This reverts commit 60344f1a9a597f2e0efcd57df5dad0b42da15e21.
> > >>
> > >> I picked this from the cover letter and added to this revert, to justify
> > >> it:
> > >>
> > >> "Hybrid metrics place a PMU at the end of the parse string. This is
> > >> also where tool events are placed. The behavior of the parse string
> > >> isn't clear and so revert the change for now."
> > >>
> > >
> > > I think the original patch used a "#" to indicate the PMU name, which
> > > can be used to distinguish between the tool events and the PMU name.
> > > To be honest, I'm not sure what's unclear here. Could you please clarify?
> > >
> > > With this revert, the issue mentioned in the original patch must be
> > > broken on ADL. I don't see a replacement fix in this patch series.
> > > Could you please propose a solution for the issue to replace the #PMU
> > > name solution?
> > >
> > > Thanks,
> > > Kan
> >
> > I am surprised the origin patch is reverted during discussion and though
> > the discussion still has no conclusion.
> > Let me introduce the purpose of the origin patch.
> > For a hybrid system such as ADL, if both the metrics and the formula are
> > different for the different PMUs, without this patch, the metric and
> > event parser should work ok, nothing should be special for the hybrid.
> > In fact, both "cpu_core" and "cpu_atom" may have the same metrics--the
> > same metric name, even the same formula for the metrics. For example,
> > both "cpu_core" and "cpu_atom" have metrics "IpBranch" and "IPC", For
> > "IpBranch", both "cpu_core" and "cpu_atom" has the same metric name and
> > their formula also is the same, the event name is the same though they
> > belong to different PMUs. The old metric and event parser can not handle
> > this kind of metric, that's why we need this patch.
> >
> >      "MetricExpr": "INST_RETIRED.ANY / BR_INST_RETIRED.ALL_BRANCHES",
> >      "MetricName": "IpBranch",
> >      "Unit": "cpu_core"
> >
> >      "MetricExpr": "INST_RETIRED.ANY / BR_INST_RETIRED.ALL_BRANCHES",
> >      "MetricName": "IpBranch",
> >      "Unit": "cpu_atom"
> >
> >
> >     "MetricExpr": "INST_RETIRED.ANY / CPU_CLK_UNHALTED.THREAD",
> >     "MetricName": "IPC",
> >     "Unit": "cpu_core"
> >
> >     "MetricExpr": "INST_RETIRED.ANY / CPU_CLK_UNHALTED.CORE",
> >     "MetricName": "IPC",
> >     "Unit": "cpu_atom"
> >
> > Except for the above two metrics, there are still a lot of similar
> > metrics, "CPU_Utilization"...
> >
> > The original patch expanded the metric group string by adding
> > "#PMU_name" to indicate the PMU name, which can be used to distinguish
> > between the tool events and the PMU name, then the metric and event
> > parser can parse the right PMU for the events.
> >
> > With the patch all the ADL metrics can pass, without the patch, a lot of
> > metrics will fail. I don't think it's a good idea to revert it before
> > the new solution is proposed.
>
> Just an idea.  Can we add a pmu prefix when it resolves the event
> for a metric if it has the "Unit"?  It seems we can support something
> like "cpu_core@INST_RETIRED.ANY@" already..
>
> Or could it be done when creating JSON files?

Yep. The format for the events in the metric is the same as for
parse-events, we copy+paste the strings from one to the other. The @
in the json is used in place of slash (/) as slash is used in metrics
for division.

Thanks,
Ian

> Thanks,
> Namhyung
