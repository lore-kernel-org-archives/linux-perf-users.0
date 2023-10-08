Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2288246AA
	for <linux-perf-users@vger.kernel.org>; Sun,  8 Oct 2023 05:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qBuEEuHd"
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54373BD
	for <linux-perf-users@vger.kernel.org>; Sat,  7 Oct 2023 22:49:39 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id 2adb3069b0e04-5068b69f4aeso3614e87.0
        for <linux-perf-users@vger.kernel.org>; Sat, 07 Oct 2023 22:49:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696744177; x=1697348977; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qmckUo2kxmgR0QPkcDBpxhLAcGtDz//RWcNxyOELw/4=;
        b=qBuEEuHds1Ed7ADQIKclf8weFscpwvbZFDM9mpzXxeqOxZs790btWhn0dzCnE2OJdc
         t84wDNFMmFs7m8JnKO0kExkk+9+ciIFc8qlLnK2/ck5dEUgp8qGmS+RNER0eO0HUiDcQ
         Q8gkI7rdu/QXAPIB+zjaDv5U4Iz0NaUIQeNjmdueQIGNPae0TKFjN/5SkLCRpOY+ocFr
         hSJdEt1KlM6xj2fPJPeIsXw9HSLTSQnTjmXZs/RkMRVAUUwFVW3tmEIkRkYDeM2ckJTV
         5guTs++qywO340yKAgMRJmvP6r2u+T24K3FpO4sbO12/9Fc8NPz1PZVXzzN+m1XUUCAy
         SR7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696744177; x=1697348977;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qmckUo2kxmgR0QPkcDBpxhLAcGtDz//RWcNxyOELw/4=;
        b=niG8EiObRJmqeIHRAoie+VExK+xDbMA4uc1z/7V+S03DhKKT2IfbhTMjOVMXWRqHdM
         RfX0h89udyud47/QAgTubqLkWu6kIE+wAXbeulkmMImYuSay+omULVtKBrUIaEzloh+4
         AivJpvvaRGyhbqM8bWoe32d8m1Ku+fQpuG9JQpBToGZUi9DgxTdXFRz2G1e5VYr0bj0n
         77ZpwVuD9p8Ek1stvWSIzOzfcVY9xKqFruAWzZVg/DGxPzOMB7SPGNdnY6mLAovCPsix
         QSiPN9ocACUqj8rAnMIh2jxm6VoImayq6wT93Teoey81SSZuvZeshqLkyL6u5X7H62u9
         ToxQ==
X-Gm-Message-State: AOJu0YwnvvEqQjGziRMkfSd+J/10++oKlJXH6xPSFPBSBN4O02gW+x+b
	hhUAxuK3bbz+oWta2qsqi1vHPIZEj5nin+gaTEc3cg==
X-Google-Smtp-Source: AGHT+IE1q3NMtFd6oEoPBUC48LILHIAG/9NOxKlZi59fObq97bvSh3ewl7oZa3Iw5vXA4zROltBkQJON2OLoxbDJQoM=
X-Received: by 2002:a05:6512:484:b0:4fe:ffbc:ac98 with SMTP id
 v4-20020a056512048400b004feffbcac98mr191130lfq.4.1696744176773; Sat, 07 Oct
 2023 22:49:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231007021326.4156714-1-irogers@google.com> <20231007021326.4156714-7-irogers@google.com>
 <39b28ad5-8086-76ed-a4c6-bfc8271d226b@huawei.com>
In-Reply-To: <39b28ad5-8086-76ed-a4c6-bfc8271d226b@huawei.com>
From: Ian Rogers <irogers@google.com>
Date: Sat, 7 Oct 2023 22:49:25 -0700
Message-ID: <CAP-5=fV3NO-3Q=7YQ0S6RNJUX1dWfszX-paFSPwniNhSokYRew@mail.gmail.com>
Subject: Re: [PATCH v1 6/7] perf pmu-events: Remember the events and metrics table
To: Yang Jihong <yangjihong1@huawei.com>
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>, Mike Leach <mike.leach@linaro.org>, 
	James Clark <james.clark@arm.com>, Leo Yan <leo.yan@linaro.org>, 
	John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	Thomas Richter <tmricht@linux.ibm.com>, Ravi Bangoria <ravi.bangoria@amd.com>, 
	Kajol Jain <kjain@linux.ibm.com>, Jing Zhang <renyu.zj@linux.alibaba.com>, 
	Kan Liang <kan.liang@linux.intel.com>, coresight@lists.linaro.org, 
	linux-arm-kernel@lists.infradead.org, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Sat, Oct 7, 2023 at 8:39=E2=80=AFPM Yang Jihong <yangjihong1@huawei.com>=
 wrote:
>
> Hello,
>
> On 2023/10/7 10:13, Ian Rogers wrote:
> > strcmp_cpuid_str performs regular expression comparisons. Avoid
> > repeated computation of the table by remembering the table in a
> > static.
> >
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >   tools/perf/pmu-events/jevents.py | 48 +++++++++++++++++++------------=
-
> >   1 file changed, 28 insertions(+), 20 deletions(-)
> >
> > diff --git a/tools/perf/pmu-events/jevents.py b/tools/perf/pmu-events/j=
events.py
> > index fd009752b427..8d8d5088c53c 100755
> > --- a/tools/perf/pmu-events/jevents.py
> > +++ b/tools/perf/pmu-events/jevents.py
> > @@ -978,28 +978,32 @@ int pmu_metrics_table__for_each_metric(const stru=
ct pmu_metrics_table *table,
> >
> >   const struct pmu_events_table *perf_pmu__find_events_table(struct per=
f_pmu *pmu)
> >   {
> > -        const struct pmu_events_table *table =3D NULL;
> > -        char *cpuid =3D perf_pmu__getcpuid(pmu);
> > +        static const struct pmu_events_table *table;
> >           size_t i;
> >
> > -        /* on some platforms which uses cpus map, cpuid can be NULL fo=
r
> > -         * PMUs other than CORE PMUs.
> > -         */
> > -        if (!cpuid)
> > -                return NULL;
> > -
> > -        i =3D 0;
> > -        for (;;) {
> > -                const struct pmu_events_map *map =3D &pmu_events_map[i=
++];
> > -                if (!map->arch)
> > -                        break;
> > -
> > -                if (!strcmp_cpuid_str(map->cpuid, cpuid)) {
> > -                        table =3D &map->event_table;
> > -                        break;
> > +        if (!table) {
> If there is no matched table in pmu_events_map,
> perf_pmu__find_events_table() will enter this branch for repeated search
> each time.
> Or do we need to use another variable to indicate whether the search has
> been performed?

Agreed, the behavior will match the existing behavior. Longer term I
want to remove this code. Do you have a scenario we should optimize
for here?

Thanks,
Ian

> Thanks,
> Yang
