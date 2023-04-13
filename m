Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24D98C77B6E
	for <linux-perf-users@archiver.kernel.org>; Thu, 13 Apr 2023 13:16:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230361AbjDMNQ0 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 13 Apr 2023 09:16:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229707AbjDMNQZ (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 13 Apr 2023 09:16:25 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C389D7
        for <linux-perf-users@vger.kernel.org>; Thu, 13 Apr 2023 06:16:23 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-3f04275b2bdso97695e9.1
        for <linux-perf-users@vger.kernel.org>; Thu, 13 Apr 2023 06:16:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1681391781; x=1683983781;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YFwzeqhtKiPoQ9tLiPgtHcNGjKjup/dMeqDQeE/P6/E=;
        b=DM9Sl05i/iZDX+wNP2OTjBJ/hKMdc9nbQ+h07EyiBmD9dNJBLMVmPbWP02ZG9BHQvP
         XpCUO46iBqLmyi0fie7CWfwyOMnysOB932nlwDIAXLcYza2UMRzwQJOAXPQ7jLnZSLKp
         rfzP35FsMGCJmJxSzhWpXB63ivKg5kApJhGWXL8+F8kLJu1OO5V3meHfmu2hbKGbnfw9
         U7yWxDrZ0RhnXJykMGWDdF4PotBDDlPITaQHhZ4M7nvIu+ILpN+59ehXesvCZMJmDRZi
         626Nj2c80J+AeBYVOvDsxtO0kfQH1hvQVd0rhAENkOY5oCXmsF/4CUGBbn2nljUIeJtN
         o3QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681391781; x=1683983781;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YFwzeqhtKiPoQ9tLiPgtHcNGjKjup/dMeqDQeE/P6/E=;
        b=mAdHvVTHFJzY85d3874P2cYHBsMb/7Jbnz8m8YBuHFfcL56HRadAPk8vRZ9incvem4
         Imv5yH7A8ShNW4igW9ZhPzUCmRbHYAxvvFG2pMOArVD0rCavd+1NVcSnIar08QWQtJQZ
         iiIRaATGvTqV1YwE054zdaDJmNrJHFLsC1uFLmj7R85FC/qObeCKhdK9SMK1za2i6WDq
         lK1zZx/HMoJ9/rzIGyvewQU9i7M4+3NuJwNdf62+WkDFJxFuSifTa8QZ0Jq1YoH33O28
         pUyYAnZNyawyLT4u3b0Doxw3LI/xBUFVwl/dZ24fkeq7Ob2tBUc+5kFWRUN6MGaoD+NF
         DgQQ==
X-Gm-Message-State: AAQBX9diP8Spm0CtdiOJJb38bEOq4hmtsZxGl/EpYF57GY078yhYTO1c
        QCJRtRuSjqVQssinSIovQ1h/jxmZXxyM2ztvNoTo3g==
X-Google-Smtp-Source: AKy350b2LBUUhp4OftQZi8YlhhoNkYkjYE75AQUeQmuEoNDAC7IlbmOuQ9VPo1d+vBuD1fKASogz7dCJ0Hi/MGEBTJo=
X-Received: by 2002:a05:600c:5125:b0:3f0:a122:93d9 with SMTP id
 o37-20020a05600c512500b003f0a12293d9mr275667wms.6.1681391781434; Thu, 13 Apr
 2023 06:16:21 -0700 (PDT)
MIME-Version: 1.0
References: <20230413051011.3440849-1-irogers@google.com> <ZDfsEwcqNl7tJm37@kernel.org>
 <ZDfstOf4UHxIJ+fq@kernel.org>
In-Reply-To: <ZDfstOf4UHxIJ+fq@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Thu, 13 Apr 2023 06:16:08 -0700
Message-ID: <CAP-5=fWjyvR-4X-UnWvfrGgGg2wnB3SgqNoaYs8JUOe-fOnU1A@mail.gmail.com>
Subject: Re: [PATCH v2 00/21] Update uncore topics, 3x event updates, 2x new archs.
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Edward Baker <edward.baker@intel.com>,
        Perry Taylor <perry.taylor@intel.com>,
        Caleb Biggers <caleb.biggers@intel.com>,
        Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Thu, Apr 13, 2023 at 4:51=E2=80=AFAM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> Em Thu, Apr 13, 2023 at 08:48:35AM -0300, Arnaldo Carvalho de Melo escrev=
eu:
> > Em Wed, Apr 12, 2023 at 10:09:50PM -0700, Ian Rogers escreveu:
> > > Update the uncore PMUs and topic classification as created by:
> > > https://github.com/intel/perfmon/pull/70
> > >
> > > Event updates stem from:
> > > https://github.com/intel/perfmon/pull/68
> > > impacting alderlake, icelakex and sapphirerapids.
> > >
> > > Grand Ridge and Sierra Forest events stem from:
> > > https://github.com/intel/perfmon/pull/69
> > >
> > > Changes generated by with PR70 in place:
> > > https://github.com/intel/perfmon/blob/main/scripts/create_perf_json.p=
y
> > >
> > > v2. Adds improvements to uncore topics, uncore PMU name fixes and
> > >     fixes a trigraph issue from ??? being in the json.
> >
> > Som problem with your mailer? Missing some patches, I'll try b4 +
> > manual...
>
> And it is failing on the first patch:
>
> [acme@toolbox perf-tools-next]$ b4 am -P1 -ctsl --cc-trailers 20230413051=
011.3440849-1-irogers@google.com
> Grabbing thread from lore.kernel.org/all/20230413051011.3440849-1-irogers=
%40google.com/t.mbox.gz
> Checking for newer revisions
> Grabbing search results from lore.kernel.org
> Analyzing 14 messages in the thread
> Checking attestation on all messages, may take a moment...
> ---
>   =E2=9C=93 [PATCH v2 1/21] perf vendor events intel: Update alderlake to=
 v1.20
>     =E2=9C=93 Signed: DKIM/google.com
>     + Link: https://lore.kernel.org/r/20230413051011.3440849-2-irogers@go=
ogle.com
>     + Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> ---
> Total patches: 1 (cherrypicked: 1)
> ---
> Cover: ./v2_20230412_irogers_update_uncore_topics_3x_event_updates_2x_new=
_archs.cover
>  Link: https://lore.kernel.org/r/20230413051011.3440849-1-irogers@google.=
com
>  Base: not specified
>        git am ./v2_20230412_irogers_update_uncore_topics_3x_event_updates=
_2x_new_archs.mbx
> =E2=AC=A2[acme@toolbox perf-tools-next]$        git am ./v2_20230412_irog=
ers_update_uncore_topics_3x_event_updates_2x_new_archs.mbx
> Applying: perf vendor events intel: Update alderlake to v1.20
> error: patch failed: tools/perf/pmu-events/arch/x86/alderlake/other.json:=
162
> error: tools/perf/pmu-events/arch/x86/alderlake/other.json: patch does no=
t apply
> error: patch failed: tools/perf/pmu-events/arch/x86/alderlake/pipeline.js=
on:31
> error: tools/perf/pmu-events/arch/x86/alderlake/pipeline.json: patch does=
 not apply
> error: patch failed: tools/perf/pmu-events/arch/x86/mapfile.csv:1
> error: tools/perf/pmu-events/arch/x86/mapfile.csv: patch does not apply
> Patch failed at 0001 perf vendor events intel: Update alderlake to v1.20
> hint: Use 'git am --show-current-patch=3Ddiff' to see the failed patch
> When you have resolved this problem, run "git am --continue".
> If you prefer to skip this patch, run "git am --skip" instead.
> To restore the original branch and stop patching, run "git am --abort".
> =E2=AC=A2[acme@toolbox perf-tools-next]$ git log --oneline -10
> 4453deacf44615b2 (HEAD -> perf-tools-next, quaco/perf-tools-next, acme/tm=
p.perf-tools-next, acme/perf-tools-next) perf sched: Fix sched latency anal=
ysis incorrection when using 'sched:sched_wakeup'
> 9efe423e43878934 (acme/perf/core) perf pmu: Use perf_cpu_map__set_nr() in=
 perf_pmu__cpus_match() to allow for refcnt checking
> b277851417e0149a libperf: Add a perf_cpu_map__set_nr() available as an in=
ternal function for tools/perf to use
> 1f94479edb4decdc libperf: Make perf_cpu_map__alloc() available as an inte=
rnal function for tools/perf to use
> 7bb1d048bdfe1c7d perf cpumap: Use perf_cpu_map__nr(cpus) to access cpus->=
nr
> 4e8db2d7520f780f perf map: Add map__refcnt() accessor to use in the maps =
test
> 984abd349d0f76d4 perf scripts python intel-pt-events: Delete unused 'even=
t_attr variable
> eab5051788f6111a perf top: Expand the range of multithreaded phase
> ed4da0d3de1e1781 tools headers: Remove s390 ptrace.h in check-headers.sh
> 57f14b5ae1a97537 perf pmu: zfree() expects a pointer to a pointer to zero=
 it after freeing its contents


Sorry, my fault. These two were already picked:
24 hours perf vendor events: Update icelakex to v1.20Ian Rogers2-2/+2
24 hours perf vendor events: Update alderlake to v1.20Ian Rogers3-4/+7

but in v2 the filename/topics changed. Let me rebase on top of the v1
version and resend as v3.

Thanks,
Ian
