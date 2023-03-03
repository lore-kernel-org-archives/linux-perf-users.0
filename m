Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FF19C6FA8E
	for <linux-perf-users@archiver.kernel.org>; Fri,  3 Mar 2023 01:42:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229659AbjCCBmF (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 2 Mar 2023 20:42:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229607AbjCCBmD (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 2 Mar 2023 20:42:03 -0500
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41D0E559C3
        for <linux-perf-users@vger.kernel.org>; Thu,  2 Mar 2023 17:41:46 -0800 (PST)
Received: by mail-il1-x12f.google.com with SMTP id x10so819342ill.12
        for <linux-perf-users@vger.kernel.org>; Thu, 02 Mar 2023 17:41:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1677807695;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Oa3IFNrapqdw55NbIdqz7TUk4no16Qpcm8BL00er4cg=;
        b=SYeugnBJMsCJtUISfQ/e4bAB0335/Ryv4aAmXz6iu1DZjCK2jigqAyYhWixA1YLA9Q
         0s3PYlYz/35NyMmCW6bi8GCGUQzuq4n9ftbSuAVCAKOrmWXDK/y5mDGeRLGFYsl3g9kW
         LDUWkzLQXwxmD+pqwKZmn5sjUSxcDtYXSlJHQZ+BORwT2UJuLLg7oqn9S3CKjUMnsxPT
         KehsqoOjyd6iWFa7wK0BVjOpSpAppoG2T2VKaMelyBqYnptbruNoFvbiv1CnRNN70SXP
         cQVD1A+8JLJMlhiK/BE/fY58+HI48LKOwUa7rAbGyg8VPdoXv6sN8T2jj2xKkd8cN9lH
         i/Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677807695;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Oa3IFNrapqdw55NbIdqz7TUk4no16Qpcm8BL00er4cg=;
        b=KHsR+X5JKzo2wUehdaq1YpCuiXABNKlf0pQouw7XfIcQ+9OZd0D5j8OwQOBsqztosk
         oCWcUTd9jAdRm6BUpsgenRAj7qe0fbTcGxjpzh2TNr2j+SOaFoBXygMshPGeFFRWSswx
         6J6evkWXimYGrxWwvIy67IJi9J81BNrfdytE6uyW5UfUPQb3Mz6bVJ4qtY0aSI1xr56P
         3SeV2FLGoWvh/w18a3zYnp4v5kFtfB4Zrn8O5VrdOcwYY7pzY0baWXcND0QAdPuGmXGd
         ApUoZT8MuaBW8+hBMVHHc9jCS+widU8xQjcGgAZP9Ps942WXXxElnIT3csAIMMVaPEry
         gIPA==
X-Gm-Message-State: AO0yUKUOAAZcH1UixIsqY/cNOLwGj59ROF/vYpqjhyiafqW6CFlDmB4w
        /A+T8C0TrIEb8Vksvc+huh1p+P5gbXsQ0dO99im5Eg==
X-Google-Smtp-Source: AK7set/imoQzCMNa/Xb7V4tRoKPwmFA4RsLyU5ZPbfZnxnR1UmpdAYFO0ZIPCMAdCqOn0udUJKX2sGzSnsbS9di+4BY=
X-Received: by 2002:a05:6e02:1111:b0:315:5d89:fb2c with SMTP id
 u17-20020a056e02111100b003155d89fb2cmr2048905ilk.2.1677807695316; Thu, 02 Mar
 2023 17:41:35 -0800 (PST)
MIME-Version: 1.0
References: <20230302212531.1043318-1-irogers@google.com> <20230302212531.1043318-7-irogers@google.com>
 <CAM9d7chd+fz6LCJWZHdFLmtRBYPyU-pxbtT8YzORhGGBjSCMzQ@mail.gmail.com>
In-Reply-To: <CAM9d7chd+fz6LCJWZHdFLmtRBYPyU-pxbtT8YzORhGGBjSCMzQ@mail.gmail.com>
From:   Ian Rogers <irogers@google.com>
Date:   Thu, 2 Mar 2023 17:41:24 -0800
Message-ID: <CAP-5=fWKPYTJ-Avjr=YJPU+qTDEEQmwTnQzkOLvUPo7WysVqfA@mail.gmail.com>
Subject: Re: [PATCH v2 06/10] perf evsel: Add function to compute pmu_name
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        "Steinar H. Gunderson" <sesse@google.com>,
        Kim Phillips <kim.phillips@amd.com>,
        Florian Fischer <florian.fischer@muhq.space>,
        James Clark <james.clark@arm.com>,
        Suzuki Poulouse <suzuki.poulose@arm.com>,
        Sean Christopherson <seanjc@google.com>,
        Leo Yan <leo.yan@linaro.org>,
        John Garry <john.g.garry@oracle.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Thu, Mar 2, 2023 at 4:19=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> w=
rote:
>
> On Thu, Mar 2, 2023 at 1:26 PM Ian Rogers <irogers@google.com> wrote:
> >
> > The computed pmu_name respects software events and aux event groups,
> > such that the pmu_name is changed to be that of the aux event leader
> > or group leader for software events. This is done as a later change
> > will split events that are in different PMUs into different groups.
> >
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >  tools/perf/util/evsel.c | 24 ++++++++++++++++++++++++
> >  tools/perf/util/evsel.h |  1 +
> >  2 files changed, 25 insertions(+)
> >
> > diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
> > index 2dc2c24252bb..9c6b486f8bd4 100644
> > --- a/tools/perf/util/evsel.c
> > +++ b/tools/perf/util/evsel.c
> > @@ -821,6 +821,30 @@ const char *evsel__name(struct evsel *evsel)
> >         return "unknown";
> >  }
> >
> > +const char *evsel__pmu_name(const struct evsel *evsel)
> > +{
> > +       const struct evsel *leader;
> > +
> > +       /* If the pmu_name is set use it. pmu_name isn't set for CPU an=
d software events. */
> > +       if (evsel->pmu_name)
> > +               return evsel->pmu_name;
>
> I'm wondering if we can just use evsel->pmu->name if it's set.

Agreed. I think that can be looked into in follow up work.

> > +       /*
> > +        * Software events may be in a group with other uncore PMU even=
ts. Use
> > +        * the pmu_name of the group leader to avoid breaking the softw=
are event
> > +        * out of the group.
> > +        *
> > +        * Aux event leaders, like intel_pt, expect a group with events=
 from
> > +        * other PMUs, so substitute the AUX event's PMU in this case.
> > +        */
>
> Looks like we need to rename this function as it doesn't simply return
> the pmu name in the above cases.  Maybe evsel__group_pmu_name() ?

Agreed, that is a better name. I'll add it in v3.

Thanks,
Ian

> Thanks,
> Namhyung
>
>
> > +       leader  =3D evsel__leader(evsel);
> > +       if ((evsel->core.attr.type =3D=3D PERF_TYPE_SOFTWARE || evsel__=
is_aux_event(leader)) &&
> > +           leader->pmu_name) {
> > +               return leader->pmu_name;
> > +       }
> > +
> > +       return "cpu";
> > +}
> > +
> >  const char *evsel__metric_id(const struct evsel *evsel)
> >  {
> >         if (evsel->metric_id)
> > diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
> > index 676c499323e9..72121194d3b1 100644
> > --- a/tools/perf/util/evsel.h
> > +++ b/tools/perf/util/evsel.h
> > @@ -280,6 +280,7 @@ int arch_evsel__hw_name(struct evsel *evsel, char *=
bf, size_t size);
> >
> >  int __evsel__hw_cache_type_op_res_name(u8 type, u8 op, u8 result, char=
 *bf, size_t size);
> >  const char *evsel__name(struct evsel *evsel);
> > +const char *evsel__pmu_name(const struct evsel *evsel);
> >  const char *evsel__metric_id(const struct evsel *evsel);
> >
> >  static inline bool evsel__is_tool(const struct evsel *evsel)
> > --
> > 2.40.0.rc0.216.gc4246ad0f0-goog
> >
