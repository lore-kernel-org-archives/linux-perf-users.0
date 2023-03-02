Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4864DC678D4
	for <linux-perf-users@archiver.kernel.org>; Thu,  2 Mar 2023 16:13:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229538AbjCBQNa (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 2 Mar 2023 11:13:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbjCBQN3 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 2 Mar 2023 11:13:29 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFBF62C647
        for <linux-perf-users@vger.kernel.org>; Thu,  2 Mar 2023 08:13:28 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id r18so17083308wrx.1
        for <linux-perf-users@vger.kernel.org>; Thu, 02 Mar 2023 08:13:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1677773607;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uGmvl0w1UaO+7YwbOGpW1Lh19XgfKEMnXjggTPBH7iw=;
        b=fI9i5jmEeBf8SzuDbY4cEXwiAtJKAJFRebLR5Z3AyLjhYbnuXR0IUs79WAWBqvZBMK
         UD3NMCJAyATMkilMmBy3zLRJ402cMm2WEYE2Ptr5d6xZw64Atcll6c5WAKMskM1mSOJA
         JdGX5Q3hTbaXgwR9Huwm0Z6OowSBxYdQ8wlVitWvi6AAU36zGm3ufT/V7m1mQ1cKO5sM
         RF5tqWF6Z5AU8XdQ7aJWIZEwOAUDQdLQldk6TaQOpHYFc2MXe2xvBaJU27vAXb0n83Qq
         8zm1p4zqqckQok4tAeCVY46Y4X9xCI26PshcqsZ+fAyjRV0rTglTvxNj2lg6MUO9+9YK
         w+sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677773607;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uGmvl0w1UaO+7YwbOGpW1Lh19XgfKEMnXjggTPBH7iw=;
        b=qqz0+96dwIjvHIHMs99g2gcmbIdOCK+AoTVnTAA3iMrPBKDGGKWu8FzQhkFIMBghso
         PYPEUehB1tgIxgolsnHxPGYVlIII39jIptZOsfAy3Q1XpLTyaMxw/7+NxkffohPGi45J
         sJBoAFxsezJ/5WLsbfBn2mxMpyVXWo9YmhDS5FwJrOkNpiVEOvAELvgnxvh6xdXU/QB4
         nFI9Ea/g/eMo7PX9CklSMeW+1sJ2mz12CVxfB7UAARUmf+Tm17y72f49QmLNq+Bua1F8
         PzqfHiDHlgRi6xszKlb/bx9neCnTaeF70ml/JjsVJdZOQ1qbKxwebnYv1AWXQmH3f5es
         fOzQ==
X-Gm-Message-State: AO0yUKW9PPil6Hf2gsaUZJZbCLRitp3UNkYXfgN0+Jq64KemJd0seslD
        dlcsJ0LUzMxFoqVT87oCzObL2ui5CBsEuwkMIJqDzQ==
X-Google-Smtp-Source: AK7set+tx+/oGn5fviTIibTvPRjFX79icV90Nm18T2byUVU/Fo0ImIBddLj8xkjHbzmqrXVqZPxX0cM9wNNEoBQ9jRU=
X-Received: by 2002:a5d:4dc3:0:b0:2c9:868e:91a with SMTP id
 f3-20020a5d4dc3000000b002c9868e091amr1801456wru.9.1677773607051; Thu, 02 Mar
 2023 08:13:27 -0800 (PST)
MIME-Version: 1.0
References: <20230302041211.852330-1-irogers@google.com> <20230302041211.852330-8-irogers@google.com>
 <ZAC1FK0EHA4reQid@kernel.org>
In-Reply-To: <ZAC1FK0EHA4reQid@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Thu, 2 Mar 2023 08:13:12 -0800
Message-ID: <CAP-5=fWRH3RzhMnjXOkw5-shwFDp-H+cGS=HYDDwjqETzyizxQ@mail.gmail.com>
Subject: Re: [PATCH v1 07/10] perf evsel: Add function to compute pmu_name
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        "Steinar H. Gunderson" <sesse@google.com>,
        Qi Liu <liuqi115@huawei.com>,
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

On Thu, Mar 2, 2023 at 6:39=E2=80=AFAM Arnaldo Carvalho de Melo <acme@kerne=
l.org> wrote:
>
> Em Wed, Mar 01, 2023 at 08:12:08PM -0800, Ian Rogers escreveu:
> > The computed pmu_name respects software events and aux event groups,
> > such that the pmu_name is changed to be that of the aux event leader
> > or group leader for software events. This is done as a later change
> > will split events that are in different PMUs into different groups.
>
> Adrian, can you please take a look and provide an Ack or Reviewed-by?
>
> - Arnaldo

Adrian's input would be greatly appreciated! The handling of aux
events/grouping was done to make sure the "Miscellaneous Intel PT
testing" was passing, so there is some confidence it is correct :-)

Thanks,
Ian

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
> >       return "unknown";
> >  }
> >
> > +const char *evsel__pmu_name(const struct evsel *evsel)
> > +{
> > +     const struct evsel *leader;
> > +
> > +     /* If the pmu_name is set use it. pmu_name isn't set for CPU and =
software events. */
> > +     if (evsel->pmu_name)
> > +             return evsel->pmu_name;
> > +     /*
> > +      * Software events may be in a group with other uncore PMU events=
. Use
> > +      * the pmu_name of the group leader to avoid breaking the softwar=
e event
> > +      * out of the group.
> > +      *
> > +      * Aux event leaders, like intel_pt, expect a group with events f=
rom
> > +      * other PMUs, so substitute the AUX event's PMU in this case.
> > +      */
> > +     leader  =3D evsel__leader(evsel);
> > +     if ((evsel->core.attr.type =3D=3D PERF_TYPE_SOFTWARE || evsel__is=
_aux_event(leader)) &&
> > +         leader->pmu_name) {
> > +             return leader->pmu_name;
> > +     }
> > +
> > +     return "cpu";
> > +}
> > +
> >  const char *evsel__metric_id(const struct evsel *evsel)
> >  {
> >       if (evsel->metric_id)
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
> > 2.39.2.722.g9855ee24e9-goog
> >
>
> --
>
> - Arnaldo
