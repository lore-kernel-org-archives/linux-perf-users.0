Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53A40FC1D;
	Wed,  4 Sep 2024 15:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725464604; cv=none; b=GSnp1fV+vIq7GzGgqjkUTJt4dTRNQ6udmofRKz0qE8ZSkY4g9+qRc3JraWNBPHE+mjPTYQD5XmQ+BRxH+JnbFhH8KZHzJVkXv5nioUdea7hGnz/q6vBZsLpTOBt0Z4lp/QttWn+2fgMJ4195l8ldEJ8tGaW/bGBRd4XI7M1o2/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725464604; c=relaxed/simple;
	bh=JuhikK6YlOTJCuE4umO9tsg26DkuoTYryjao568QjcU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qfPGq3gfkhGWkmdpQDpnUFfBc7uEti6bPfhWh2ewiN82mhxiBmQNge0nFr+1oEL+AiN9YotRQiEvujE2S1Of544gdM0Tm9B3tHoZyzJ1VnpR9ee/ZIUftOalYoLe56RFh9Gih4k5xnF3RCf0+Oq1oXfi1iOCQnbbnyVyCGA1ej8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-2d87196ec9fso3727272a91.1;
        Wed, 04 Sep 2024 08:43:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725464602; x=1726069402;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UPizPzERB1UOxG7BM0zBm+Fllo0GJ6QGz/8StBpcrH8=;
        b=aiP5gx0GIzjxWR3RkBd+ZeiSf+IGRMvOgFo1UQaaCG+in+5kGeywjK6N4HMmRWGUQq
         a9gCOY7nvNPYtNFWYi4bI/RNDoM8nDrX6OEwjj0a3wqXmGJWGWh4ATQ+/Tm699pLjRR/
         igTuDhD9Sqx09YRjJ/KPlDKRL7K3D9X9KIri3vqe8STfjVwtdXya0TxBDP4YIPpUHpV6
         rHiP97mfucgdCiry/MlRd1nCCzfoUONOuXhWMUIg8cGMN3R3dDwfRRNA9COECnoHcFO/
         3VBUOHFk+VfUh6AQQn2l5uOgbw7Xk++Uw1+3O9JFQ5GAY//+lUJv3l7ldQ1LyVgI0tDY
         NlvQ==
X-Forwarded-Encrypted: i=1; AJvYcCVQ3LqcaxBTM9iLX5HCUAFz216eSbkdO+3yuUKqfQpt/JgTUsmISQZFRD0tR27Pp3zTw2vhkN/HpSb+n+Q=@vger.kernel.org, AJvYcCVQHSpOjsGrTwSNOa4KI5EzyOZT53U2XsCu0HiSuxwtgjepCKlbX3UIoTNNk1cdpDVMI5BJFRP8YDzN77BLfGHyzA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxUaRe91g+kGPDYoq/qTqNDV1wKhndnkr5I10Akxaaqwkak87uC
	KexgTvSpI/wypbrbFO/5ARRfdO3O3QPmPBDcGCN2NyRzY1G2FxVO+zPy1kppBmJZjsY3Hcin8D7
	xM1nylQT1C3tq00wINsiplLz4rtI=
X-Google-Smtp-Source: AGHT+IHDIrSDRbe2gBULfoa0ONgGgqVQXphU3cMVsWRtuJ04m4b0aQNpThV0q50s7gd7TdiCeCAQ9shi3rd2pWruSvM=
X-Received: by 2002:a17:90b:1042:b0:2d8:6f66:1ebf with SMTP id
 98e67ed59e1d1-2d8972c4aaamr13705291a91.20.1725464601367; Wed, 04 Sep 2024
 08:43:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240904064131.2377873-1-namhyung@kernel.org> <20240904064131.2377873-2-namhyung@kernel.org>
 <ZthbiKEi7BMr_Zuz@x1>
In-Reply-To: <ZthbiKEi7BMr_Zuz@x1>
From: Namhyung Kim <namhyung@kernel.org>
Date: Wed, 4 Sep 2024 08:43:08 -0700
Message-ID: <CAM9d7chw5ABt1qpnMV49JW8ZdHtzPR5GAJwHT1+sgzZe0Q9FLA@mail.gmail.com>
Subject: Re: [PATCH 1/8] perf tools: Don't set attr.exclude_guest by default
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Ian Rogers <irogers@google.com>, Kan Liang <kan.liang@linux.intel.com>, 
	Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org, 
	Ravi Bangoria <ravi.bangoria@amd.com>, Mark Rutland <mark.rutland@arm.com>, 
	James Clark <james.clark@arm.com>, Athira Rajeev <atrajeev@linux.vnet.ibm.com>, 
	Kajol Jain <kjain@linux.ibm.com>, Thomas Richter <tmricht@linux.ibm.com>, 
	Atish Patra <atishp@atishpatra.org>, Palmer Dabbelt <palmer@rivosinc.com>, 
	Mingwei Zhang <mizhang@google.com>, James Clark <james.clark@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Arnaldo,

On Wed, Sep 4, 2024 at 6:07=E2=80=AFAM Arnaldo Carvalho de Melo <acme@kerne=
l.org> wrote:
>
> On Tue, Sep 03, 2024 at 11:41:24PM -0700, Namhyung Kim wrote:
> > The exclude_guest in the event attribute is to limit profiling in the
> > host environment.  But I'm not sure why we want to set it by default
> > cause we don't care about it in most cases and I feel like it just
> > makes new PMU implementation complicated.
> >
> > Of course it's useful for perf kvm command so I added the
> > exclude_GH_default variable to preserve the old behavior for perf kvm
> > and other commands like perf record and stat won't set the exclude bit.
> > This is helpful for AMD IBS case since having exclude_guest bit will
> > clear new feature bit due to the missing feature check logic.
> >
> >   $ sysctl kernel.perf_event_paranoid
> >   kernel.perf_event_paranoid =3D 0
> >
> >   $ perf record -W -e ibs_op// -vv true 2>&1 | grep switching
> >   switching off PERF_FORMAT_LOST support
> >   switching off weight struct support
> >   switching off bpf_event
> >   switching off ksymbol
> >   switching off cloexec flag
> >   switching off mmap2
> >   switching off exclude_guest, exclude_host
> >
> > Maybe Apple M1 users will scream but actually the default event for
> > perf record was converted to "cycles:P" which doesn't set the
> > exclude_guest bit already.  So they need to specify the necessary
> > modifier manually like "cycles:PH" and I think it's ok.
>
> Would be really, really good to have a Tested-by: Someone # on an Apple M=
1

Yep, and other non-x86 platforms too.

>
> I'll reinstall my rk-3399-pc and try it on that hybrid aarch64 board.
>
> I have access to Ampere Altra systems, will try there as well.

Great, thanks!
Namhyung

>
> - Arnaldo
>
> > Intestingly, I found it sets the exclude_bit if "u" modifier is used.
> > I don't know why but it's neither intuitive nor consistent.  Let's
> > remove the bit there too.
> >
> > Cc: Mark Rutland <mark.rutland@arm.com>
> > Cc: James Clark <james.clark@linaro.org>
> > Cc: Ravi Bangoria <ravi.bangoria@amd.com>
> > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> > ---
> >  tools/perf/builtin-kvm.c                   |  1 +
> >  tools/perf/tests/attr/test-record-dummy-C0 |  2 +-
> >  tools/perf/tests/parse-events.c            | 18 +++++++++---------
> >  tools/perf/util/parse-events.c             |  2 +-
> >  tools/perf/util/util.c                     | 10 ++++++++--
> >  tools/perf/util/util.h                     |  3 +++
> >  6 files changed, 23 insertions(+), 13 deletions(-)
> >
> > diff --git a/tools/perf/builtin-kvm.c b/tools/perf/builtin-kvm.c
> > index 692267b1b7e8311f..ca94dd3de04d34a3 100644
> > --- a/tools/perf/builtin-kvm.c
> > +++ b/tools/perf/builtin-kvm.c
> > @@ -2147,6 +2147,7 @@ int cmd_kvm(int argc, const char **argv)
> >                                               "buildid-list", "stat", N=
ULL };
> >       const char *kvm_usage[] =3D { NULL, NULL };
> >
> > +     exclude_HG_default =3D true;
> >       perf_host  =3D 0;
> >       perf_guest =3D 1;
> >
> > diff --git a/tools/perf/tests/attr/test-record-dummy-C0 b/tools/perf/te=
sts/attr/test-record-dummy-C0
> > index 576ec48b3aafaa6a..8ce6f0a5df5b7013 100644
> > --- a/tools/perf/tests/attr/test-record-dummy-C0
> > +++ b/tools/perf/tests/attr/test-record-dummy-C0
> > @@ -37,7 +37,7 @@ precise_ip=3D0
> >  mmap_data=3D0
> >  sample_id_all=3D1
> >  exclude_host=3D0
> > -exclude_guest=3D1
> > +exclude_guest=3D0
> >  exclude_callchain_kernel=3D0
> >  exclude_callchain_user=3D0
> >  mmap2=3D1
> > diff --git a/tools/perf/tests/parse-events.c b/tools/perf/tests/parse-e=
vents.c
> > index edc2adcf1baed195..9179bf3084c302c1 100644
> > --- a/tools/perf/tests/parse-events.c
> > +++ b/tools/perf/tests/parse-events.c
> > @@ -932,7 +932,7 @@ static int test__group2(struct evlist *evlist)
> >                       TEST_ASSERT_VAL("wrong exclude_user", !evsel->cor=
e.attr.exclude_user);
> >                       TEST_ASSERT_VAL("wrong exclude_kernel", !evsel->c=
ore.attr.exclude_kernel);
> >                       TEST_ASSERT_VAL("wrong exclude_hv", evsel->core.a=
ttr.exclude_hv);
> > -                     TEST_ASSERT_VAL("wrong exclude guest", evsel->cor=
e.attr.exclude_guest);
> > +                     TEST_ASSERT_VAL("wrong exclude guest", !evsel->co=
re.attr.exclude_guest);
> >                       TEST_ASSERT_VAL("wrong exclude host", !evsel->cor=
e.attr.exclude_host);
> >                       TEST_ASSERT_VAL("wrong precise_ip", !evsel->core.=
attr.precise_ip);
> >                       TEST_ASSERT_VAL("wrong leader", evsel__is_group_l=
eader(evsel));
> > @@ -947,7 +947,7 @@ static int test__group2(struct evlist *evlist)
> >                       TEST_ASSERT_VAL("wrong exclude_user", !evsel->cor=
e.attr.exclude_user);
> >                       TEST_ASSERT_VAL("wrong exclude_kernel", evsel->co=
re.attr.exclude_kernel);
> >                       TEST_ASSERT_VAL("wrong exclude_hv", evsel->core.a=
ttr.exclude_hv);
> > -                     TEST_ASSERT_VAL("wrong exclude guest", evsel->cor=
e.attr.exclude_guest);
> > +                     TEST_ASSERT_VAL("wrong exclude guest", !evsel->co=
re.attr.exclude_guest);
> >                       TEST_ASSERT_VAL("wrong exclude host", !evsel->cor=
e.attr.exclude_host);
> >                       TEST_ASSERT_VAL("wrong precise_ip", !evsel->core.=
attr.precise_ip);
> >                       if (evsel__has_leader(evsel, leader))
> > @@ -1072,7 +1072,7 @@ static int test__group3(struct evlist *evlist __m=
aybe_unused)
> >               TEST_ASSERT_VAL("wrong exclude_user", !evsel->core.attr.e=
xclude_user);
> >               TEST_ASSERT_VAL("wrong exclude_kernel", evsel->core.attr.=
exclude_kernel);
> >               TEST_ASSERT_VAL("wrong exclude_hv", evsel->core.attr.excl=
ude_hv);
> > -             TEST_ASSERT_VAL("wrong exclude guest", evsel->core.attr.e=
xclude_guest);
> > +             TEST_ASSERT_VAL("wrong exclude guest", !evsel->core.attr.=
exclude_guest);
> >               TEST_ASSERT_VAL("wrong exclude host", !evsel->core.attr.e=
xclude_host);
> >               TEST_ASSERT_VAL("wrong precise_ip", !evsel->core.attr.pre=
cise_ip);
> >               TEST_ASSERT_VAL("wrong leader", evsel__is_group_leader(ev=
sel));
> > @@ -1222,7 +1222,7 @@ static int test__group5(struct evlist *evlist __m=
aybe_unused)
> >               TEST_ASSERT_VAL("wrong exclude_user", !evsel->core.attr.e=
xclude_user);
> >               TEST_ASSERT_VAL("wrong exclude_kernel", !evsel->core.attr=
.exclude_kernel);
> >               TEST_ASSERT_VAL("wrong exclude_hv", !evsel->core.attr.exc=
lude_hv);
> > -             TEST_ASSERT_VAL("wrong exclude guest", evsel->core.attr.e=
xclude_guest);
> > +             TEST_ASSERT_VAL("wrong exclude guest", !evsel->core.attr.=
exclude_guest);
> >               TEST_ASSERT_VAL("wrong exclude host", !evsel->core.attr.e=
xclude_host);
> >               TEST_ASSERT_VAL("wrong precise_ip", !evsel->core.attr.pre=
cise_ip);
> >               TEST_ASSERT_VAL("wrong leader", evsel__is_group_leader(ev=
sel));
> > @@ -1437,7 +1437,7 @@ static int test__leader_sample1(struct evlist *ev=
list)
> >               TEST_ASSERT_VAL("wrong exclude_user", !evsel->core.attr.e=
xclude_user);
> >               TEST_ASSERT_VAL("wrong exclude_kernel", !evsel->core.attr=
.exclude_kernel);
> >               TEST_ASSERT_VAL("wrong exclude_hv", !evsel->core.attr.exc=
lude_hv);
> > -             TEST_ASSERT_VAL("wrong exclude guest", evsel->core.attr.e=
xclude_guest);
> > +             TEST_ASSERT_VAL("wrong exclude guest", !evsel->core.attr.=
exclude_guest);
> >               TEST_ASSERT_VAL("wrong exclude host", !evsel->core.attr.e=
xclude_host);
> >               TEST_ASSERT_VAL("wrong precise_ip", !evsel->core.attr.pre=
cise_ip);
> >               TEST_ASSERT_VAL("wrong group name", !evsel->group_name);
> > @@ -1453,7 +1453,7 @@ static int test__leader_sample1(struct evlist *ev=
list)
> >               TEST_ASSERT_VAL("wrong exclude_user", !evsel->core.attr.e=
xclude_user);
> >               TEST_ASSERT_VAL("wrong exclude_kernel", !evsel->core.attr=
.exclude_kernel);
> >               TEST_ASSERT_VAL("wrong exclude_hv", !evsel->core.attr.exc=
lude_hv);
> > -             TEST_ASSERT_VAL("wrong exclude guest", evsel->core.attr.e=
xclude_guest);
> > +             TEST_ASSERT_VAL("wrong exclude guest", !evsel->core.attr.=
exclude_guest);
> >               TEST_ASSERT_VAL("wrong exclude host", !evsel->core.attr.e=
xclude_host);
> >               TEST_ASSERT_VAL("wrong precise_ip", !evsel->core.attr.pre=
cise_ip);
> >               TEST_ASSERT_VAL("wrong leader", evsel__has_leader(evsel, =
leader));
> > @@ -1468,7 +1468,7 @@ static int test__leader_sample1(struct evlist *ev=
list)
> >               TEST_ASSERT_VAL("wrong exclude_user", !evsel->core.attr.e=
xclude_user);
> >               TEST_ASSERT_VAL("wrong exclude_kernel", !evsel->core.attr=
.exclude_kernel);
> >               TEST_ASSERT_VAL("wrong exclude_hv", !evsel->core.attr.exc=
lude_hv);
> > -             TEST_ASSERT_VAL("wrong exclude guest", evsel->core.attr.e=
xclude_guest);
> > +             TEST_ASSERT_VAL("wrong exclude guest", !evsel->core.attr.=
exclude_guest);
> >               TEST_ASSERT_VAL("wrong exclude host", !evsel->core.attr.e=
xclude_host);
> >               TEST_ASSERT_VAL("wrong precise_ip", !evsel->core.attr.pre=
cise_ip);
> >               TEST_ASSERT_VAL("wrong group name", !evsel->group_name);
> > @@ -1497,7 +1497,7 @@ static int test__leader_sample2(struct evlist *ev=
list __maybe_unused)
> >               TEST_ASSERT_VAL("wrong exclude_user", !evsel->core.attr.e=
xclude_user);
> >               TEST_ASSERT_VAL("wrong exclude_kernel", evsel->core.attr.=
exclude_kernel);
> >               TEST_ASSERT_VAL("wrong exclude_hv", evsel->core.attr.excl=
ude_hv);
> > -             TEST_ASSERT_VAL("wrong exclude guest", evsel->core.attr.e=
xclude_guest);
> > +             TEST_ASSERT_VAL("wrong exclude guest", !evsel->core.attr.=
exclude_guest);
> >               TEST_ASSERT_VAL("wrong exclude host", !evsel->core.attr.e=
xclude_host);
> >               TEST_ASSERT_VAL("wrong precise_ip", !evsel->core.attr.pre=
cise_ip);
> >               TEST_ASSERT_VAL("wrong group name", !evsel->group_name);
> > @@ -1513,7 +1513,7 @@ static int test__leader_sample2(struct evlist *ev=
list __maybe_unused)
> >               TEST_ASSERT_VAL("wrong exclude_user", !evsel->core.attr.e=
xclude_user);
> >               TEST_ASSERT_VAL("wrong exclude_kernel", evsel->core.attr.=
exclude_kernel);
> >               TEST_ASSERT_VAL("wrong exclude_hv", evsel->core.attr.excl=
ude_hv);
> > -             TEST_ASSERT_VAL("wrong exclude guest", evsel->core.attr.e=
xclude_guest);
> > +             TEST_ASSERT_VAL("wrong exclude guest", !evsel->core.attr.=
exclude_guest);
> >               TEST_ASSERT_VAL("wrong exclude host", !evsel->core.attr.e=
xclude_host);
> >               TEST_ASSERT_VAL("wrong precise_ip", !evsel->core.attr.pre=
cise_ip);
> >               TEST_ASSERT_VAL("wrong group name", !evsel->group_name);
> > diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-eve=
nts.c
> > index fab01ba54e34da7d..ab73b3d45f0467f9 100644
> > --- a/tools/perf/util/parse-events.c
> > +++ b/tools/perf/util/parse-events.c
> > @@ -1739,7 +1739,7 @@ static int parse_events__modifier_list(struct par=
se_events_state *parse_state,
> >               if (mod.user) {
> >                       if (!exclude)
> >                               exclude =3D eu =3D ek =3D eh =3D 1;
> > -                     if (!exclude_GH && !perf_guest)
> > +                     if (!exclude_GH && !perf_guest && exclude_HG_defa=
ult)
> >                               eG =3D 1;
> >                       eu =3D 0;
> >               }
> > diff --git a/tools/perf/util/util.c b/tools/perf/util/util.c
> > index 9d55a13787ce3c05..7e3159faaa1991df 100644
> > --- a/tools/perf/util/util.c
> > +++ b/tools/perf/util/util.c
> > @@ -78,17 +78,23 @@ bool sysctl__nmi_watchdog_enabled(void)
> >
> >  bool test_attr__enabled;
> >
> > +bool exclude_HG_default;
> > +
> >  bool perf_host  =3D true;
> >  bool perf_guest =3D false;
> >
> >  void event_attr_init(struct perf_event_attr *attr)
> >  {
> > +     /* to capture ABI version */
> > +     attr->size =3D sizeof(*attr);
> > +
> > +     if (!exclude_HG_default)
> > +             return;
> > +
> >       if (!perf_host)
> >               attr->exclude_host  =3D 1;
> >       if (!perf_guest)
> >               attr->exclude_guest =3D 1;
> > -     /* to capture ABI version */
> > -     attr->size =3D sizeof(*attr);
> >  }
> >
> >  int mkdir_p(char *path, mode_t mode)
> > diff --git a/tools/perf/util/util.h b/tools/perf/util/util.h
> > index 9966c21aaf048479..d33ae883a54f2f2f 100644
> > --- a/tools/perf/util/util.h
> > +++ b/tools/perf/util/util.h
> > @@ -21,6 +21,9 @@ extern const char perf_more_info_string[];
> >
> >  extern const char *input_name;
> >
> > +/* This will control if perf_{host,guest} will set attr.exclude_{host,=
guest}. */
> > +extern bool exclude_HG_default;
> > +
> >  extern bool perf_host;
> >  extern bool perf_guest;
> >
> > --
> > 2.46.0.469.g59c65b2a67-goog
