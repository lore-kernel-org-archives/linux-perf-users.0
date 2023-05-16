Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C337C77B75
	for <linux-perf-users@archiver.kernel.org>; Tue, 16 May 2023 18:19:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231895AbjEPSTj (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 16 May 2023 14:19:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231919AbjEPSTh (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 16 May 2023 14:19:37 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F551A26A
        for <linux-perf-users@vger.kernel.org>; Tue, 16 May 2023 11:19:32 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-1a950b982d4so14095ad.0
        for <linux-perf-users@vger.kernel.org>; Tue, 16 May 2023 11:19:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684261171; x=1686853171;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KP1jO/M+Q+XA59TkLd38dFwTlZWhAVoZVr2OOCZtzo4=;
        b=Lg3FNaJSm0M2goIDCcRn6df7eOI1vPvZjotgzQbg3hZY0AFugQ5Wvg6RmE4R1m1dA3
         5/YjJaoTp1pHHoKg4SRe6iuIJaalCKGKhOqby2dyU8fM3bJaLmJofSlm41Z9w8bikszA
         THr6hSuC80UYe/BWcv2YG15cdNgL+5H9kdSdvGRbWqPgLqNUBXKwyaV3U7FsYbyovLtF
         q3dbZrHRilv3/VqacFR+iB/Bc9jQkz/gxZJ+9leb5OtN0hbAH94DNy0GVC7QAJRJGgaF
         ywgiQj+35/sOaxA0MEPLQP60DQK/LQJAYIUpIMKNsK47cRQ7FzCm+dmLQS/9ojTqqRXm
         AQFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684261171; x=1686853171;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KP1jO/M+Q+XA59TkLd38dFwTlZWhAVoZVr2OOCZtzo4=;
        b=BywXjgshoVipdIhCVdFcMjwyEZfqzfV71QRFV/CDJo5ub8sOs/ZkRhrRmFsdT25Dko
         VdQiqfmNNnhvvkLB8qMIBL+zPXweWnHslVuZCXGGvijLV6737/Ajm2MvbS57zGdI32As
         GINPUYfx51YEuQh0JT3lHumQVZOP0psUrmBiZsDXjxyKJXTF7L2X+RRUOqRRlyxtufkQ
         JqgfvxZlpegJYa3Q5OjGW1pUhj3+tX+XMS85TfleeOofJ8O8ZLpCi6HVlPL+jy6WJs2q
         fdl6rPCdEkVv8DBdGIjGxpH8Kbaets7Gbk1g4qUXDgDwFFHFlwMKmXeen49aLCv3Ed1b
         2PDg==
X-Gm-Message-State: AC+VfDwPDNNGYwx9+lgciUl9Hn+og7CsTbjaOJlRASms45jmBu0AzpKz
        X+RuXAqw1qzM/j7NzaRE94fCilCC6QCwl8y0YQqGtA==
X-Google-Smtp-Source: ACHHUZ5pjJZIWqIH5OviGXHIPX+7bVbg4gG/m8HBeKJgp3nGx/juYH/JjzZGnA94EplG1ImGGWcq7/fBJrbT+wcZvxM=
X-Received: by 2002:a17:902:f542:b0:198:af4f:de07 with SMTP id
 h2-20020a170902f54200b00198af4fde07mr927plf.7.1684261171004; Tue, 16 May 2023
 11:19:31 -0700 (PDT)
MIME-Version: 1.0
References: <20230515215844.653610-1-irogers@google.com> <20230515215844.653610-16-irogers@google.com>
 <4f1e2e31-4efd-ba94-18e5-e53189429d9b@linux.intel.com>
In-Reply-To: <4f1e2e31-4efd-ba94-18e5-e53189429d9b@linux.intel.com>
From:   Ian Rogers <irogers@google.com>
Date:   Tue, 16 May 2023 11:19:19 -0700
Message-ID: <CAP-5=fWO6uPwdkuDMiHSJL53nQ_o6cXt9LG+vngiZtm=8zFbNA@mail.gmail.com>
Subject: Re: [PATCH v1 15/15] perf vendor events intel: Add metricgroup
 descriptions for all models
To:     "Liang, Kan" <kan.liang@linux.intel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        John Garry <john.garry@huawei.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Tue, May 16, 2023 at 10:54=E2=80=AFAM Liang, Kan <kan.liang@linux.intel.=
com> wrote:
>
>
>
> On 2023-05-15 5:58 p.m., Ian Rogers wrote:
> > Add metric group descriptions created by:
> > https://github.com/intel/perfmon/blob/main/scripts/create_perf_json.py
> > The descriptions add some additional detail in perf list.
> >
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >  .../arch/x86/alderlake/metricgroups.json      | 122 ++++++++++++++++++
> >  .../arch/x86/alderlaken/metricgroups.json     |  26 ++++
> >  .../arch/x86/broadwell/metricgroups.json      | 107 +++++++++++++++
> >  .../arch/x86/broadwellde/metricgroups.json    | 107 +++++++++++++++
> >  .../arch/x86/broadwellx/metricgroups.json     | 107 +++++++++++++++
> >  .../arch/x86/cascadelakex/metricgroups.json   | 114 ++++++++++++++++
> >  .../arch/x86/haswell/metricgroups.json        | 107 +++++++++++++++
> >  .../arch/x86/haswellx/metricgroups.json       | 107 +++++++++++++++
> >  .../arch/x86/icelake/metricgroups.json        | 113 ++++++++++++++++
> >  .../arch/x86/icelakex/metricgroups.json       | 114 ++++++++++++++++
> >  .../arch/x86/ivybridge/metricgroups.json      | 107 +++++++++++++++
> >  .../arch/x86/ivytown/metricgroups.json        | 107 +++++++++++++++
> >  .../arch/x86/jaketown/metricgroups.json       | 100 ++++++++++++++
> >  .../arch/x86/sandybridge/metricgroups.json    | 100 ++++++++++++++
> >  .../arch/x86/sapphirerapids/metricgroups.json | 118 +++++++++++++++++
> >  .../arch/x86/skylake/metricgroups.json        | 113 ++++++++++++++++
> >  .../arch/x86/skylakex/metricgroups.json       | 114 ++++++++++++++++
> >  .../arch/x86/tigerlake/metricgroups.json      | 113 ++++++++++++++++
> >  18 files changed, 1896 insertions(+)
> >  create mode 100644 tools/perf/pmu-events/arch/x86/alderlake/metricgrou=
ps.json
> >  create mode 100644 tools/perf/pmu-events/arch/x86/alderlaken/metricgro=
ups.json
> >  create mode 100644 tools/perf/pmu-events/arch/x86/broadwell/metricgrou=
ps.json
> >  create mode 100644 tools/perf/pmu-events/arch/x86/broadwellde/metricgr=
oups.json
> >  create mode 100644 tools/perf/pmu-events/arch/x86/broadwellx/metricgro=
ups.json
> >  create mode 100644 tools/perf/pmu-events/arch/x86/cascadelakex/metricg=
roups.json
> >  create mode 100644 tools/perf/pmu-events/arch/x86/haswell/metricgroups=
.json
> >  create mode 100644 tools/perf/pmu-events/arch/x86/haswellx/metricgroup=
s.json
> >  create mode 100644 tools/perf/pmu-events/arch/x86/icelake/metricgroups=
.json
> >  create mode 100644 tools/perf/pmu-events/arch/x86/icelakex/metricgroup=
s.json
> >  create mode 100644 tools/perf/pmu-events/arch/x86/ivybridge/metricgrou=
ps.json
> >  create mode 100644 tools/perf/pmu-events/arch/x86/ivytown/metricgroups=
.json
> >  create mode 100644 tools/perf/pmu-events/arch/x86/jaketown/metricgroup=
s.json
> >  create mode 100644 tools/perf/pmu-events/arch/x86/sandybridge/metricgr=
oups.json
> >  create mode 100644 tools/perf/pmu-events/arch/x86/sapphirerapids/metri=
cgroups.json
> >  create mode 100644 tools/perf/pmu-events/arch/x86/skylake/metricgroups=
.json
> >  create mode 100644 tools/perf/pmu-events/arch/x86/skylakex/metricgroup=
s.json
> >  create mode 100644 tools/perf/pmu-events/arch/x86/tigerlake/metricgrou=
ps.json
> >
> > diff --git a/tools/perf/pmu-events/arch/x86/alderlake/metricgroups.json=
 b/tools/perf/pmu-events/arch/x86/alderlake/metricgroups.json
> > new file mode 100644
> > index 000000000000..273ccfb0ed6f
> > --- /dev/null
> > +++ b/tools/perf/pmu-events/arch/x86/alderlake/metricgroups.json
> > @@ -0,0 +1,122 @@
> > +{
> > +    "Backend": "Grouping from metrics spreadsheet",
> > +    "Bad": "Grouping from metrics spreadsheet",
> > +    "BadSpec": "Grouping from metrics spreadsheet",
> > +    "BigFoot": "Grouping from metrics spreadsheet",
> > +    "BrMispredicts": "Grouping from metrics spreadsheet",
> > +    "Branches": "Grouping from metrics spreadsheet",
>
> The description "Grouping from metrics spreadsheet" seems meaningless,
> and may bring confusion information, e.g., what is metrics spreadsheet?
> I think it may be better to leave it empty if we don't have a proper
> description for the metricgroup.

Thanks Kan, the TMA spreadsheet has a column (AG in version 4.5-full)
called Metric Group. For the level 3 ICache_Misses metric the value of
the cell is "BigFoot;FetchLat;IcMiss". The converter will put these
groups alongside the groups derived by level, parent/child
relationship. A group like "BigFoot" could use some explanation. The
intent with saying "Grouping from metrics spreadsheet" is to at least
give the origin of the metric group which I think is at least a little
bit better than saying nothing and not knowing the origin of where the
grouping comes from. I'd like to do more, so I think we can iterate
and improve, but I think this first step has some value.

Thanks,
Ian

> Other descriptions look good to me.
>
> Thanks,
> Kan
