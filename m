Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26CCD2FD1B6
	for <linux-perf-users@vger.kernel.org>; Fri, 27 Mar 2026 04:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774587089; cv=pass; b=c7I3gfGw7K0rkJp0u3CMha/0lu0LjedDlyb+jICFiRQT+FAUNQbd+WLITzIU31lbM4raUGbwThzUo+Q1crxLQQxniwa44v+Xm/Suzl3V9xZ8/g3p+UxGlTQNrCFlalEMvoYPA04tCQ42FykPbzPklpCJdS1KPSetNhIJIsZxKlE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774587089; c=relaxed/simple;
	bh=54mvcUBb49XV0Cjm3g/nnjYBLh7pIbUqLB8uwLCtM1I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Yq1Zip54M4RIk5es1OfKR++Dxi5vCrFY7o+krwyf+33/QsW4W+r0kGy+1saFj1QC6wLhgetpukdfHzlip31xmLFe2XRmWSyMk+YLJBB3YJiD3oYHErSnDJGWiVsRSo48+snSdEQBQiHCaIwAHWsztS/h5GvBJHYxQNg/NcoYuSQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aANlqKQa; arc=pass smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aANlqKQa"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2b0c12be0ecso59425ad.0
        for <linux-perf-users@vger.kernel.org>; Thu, 26 Mar 2026 21:51:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774587087; cv=none;
        d=google.com; s=arc-20240605;
        b=DlUVuuwKKRh7X4SF8GJxRkR6VNNL6ssZwb6f5MPXPBOjqJgdJHGG4iquvO17IjjeKU
         30FiE95d1z/wZR67BPDx+ymGj9nITv+ElRswfpxlMVuS/1qeGnr7cHEzC+dBUbb6/J9F
         7tp6IYr6HKEyusbcttlGfpX3es2oeDNj71cpVuhSB+rSYHvfVMNFmjsdDfiwA0wX8M1U
         jgzgvHrx6eal2relQIFKbe+RQD6Ikg4kJqZV0hgjqczECfvS3b3DqbnTpgNqKI3IstLe
         c1S1nGY9bUqw0zcOe/zQ0hx+ZtydzhUVfnfMsp94RLupyGCvqrxbZaXORAaNCjeKuggN
         83kQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Qq6Q7MtlgFflrtMc8Gc16/NXq1SYHiWM3pdiFTYkC/8=;
        fh=/IWSL+5m7/eTmTWNgxmt14NnmFgCBctHwXWajqGuoi4=;
        b=FwMC5RwWFnDAEiW7XvtrL6XLWMplRQFS6uKwx1+l8fsDameFutm1dFoAuuoNulhV/N
         2Q7FG0Rg5Hkc6v7EfHCP5++Gv95mmgoEp4UGFXCMEHFKkQqQTzHV+hxUXNTALF+mxirM
         rogGB2JU/1qsrYWGIPHNAZOUZqAvBDxpm0GX7McAezLKA281Nv8YnSpbjPU9EwUJ4D7w
         uvUQQICL5Yzce2YKBV1oN8yXVF92Lvh8riaPXNdCm5rt26bWY/yQ0TGCFVYo5w9jaTeZ
         7sCdPsaQolKBKPSr7n4X4iAbGJeN/TIH2PCj2bs/1x9yv+uOr56sBC5wxwr50iUQZFHJ
         LSig==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774587087; x=1775191887; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qq6Q7MtlgFflrtMc8Gc16/NXq1SYHiWM3pdiFTYkC/8=;
        b=aANlqKQalYtD48UYfVSZ6yzsP5fCMlRlJ+ZSqpRyt0xcaibVE8CYBFevaSkf+1FVhz
         C3KF0ou/isDldxrifThqu3e18nqhgUxfX3GJ8zfIRQdCEZGyW/yhIJBBoZ/H/0Lb4nC0
         4Ywicz1vAo9un8lgsDTqp426K5ptGK/WYPU0aJ1v5ytkyejIAXysegD01lpoaNAOyOum
         8HSueenBdM7ILPy5/6SBfNij1zRw+s6H2OFqxcSuNhhYfxiazt/ag6AoZYcocHbhORI2
         rF/fI/erdL984tOFFedxRiZTACfxEsVZOjADeB/0BBLoNGfWylHC7wSojBeHjAXT//vO
         wo9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774587087; x=1775191887;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Qq6Q7MtlgFflrtMc8Gc16/NXq1SYHiWM3pdiFTYkC/8=;
        b=FzQpbMQjWFWQHm+Cft2lqi0rC2aY6cBmIGgVBIeOG5UIb9gNptUb3i+0TRC/gtIKAN
         umNzJgU4Mz/v1AwhGjXDeKJu4gQVpcEb/DU20eAIz6Vhs2YXC1NOQALTr82QdqJwo5vF
         9YxdMRQIaPky0SYhKi0Zuk0Ki+kY5y2N6nR5dD+HwK4e8SE4OSSW39D+/mS4ogMMoB+Z
         UprG7vavtTfO50mybpPk6u55KvDTVptYfxC/gXS97niS94dLAZlUeaO2TO56PDEwgBmd
         0Dfwaae4RnHMpvkgCUIl1l9vxhWBZd/dHW/FLPA5J44DNXP0B25GCgD5fep9UrFlob5E
         pcQQ==
X-Gm-Message-State: AOJu0YzMeg+hE9rSK4WkPNi2yAP+VLeIpYXfoWavyR1cXS/WVVfivpnr
	qKZUg9PhyoMcWs0qjKsfHUve5VjfPjngBLeL8eKUUqGauiM8S3qLhL4jxzR+v0kd7wo9pGV4j4W
	fYTzzAULdgJuAhTB3LoiGAyHwzGeF1AuPlwGicCyL
X-Gm-Gg: ATEYQzw7JY/azio0SLv+HYtAS+aofqSLwg5uA9Z0jTUJvPZigrgvIVjct0eCGLHTcyn
	INte+mMdgsVEJQH1SBXAqwX8OdTIthmK9c/0LRbou5Sc/pwIS6gR8bswUeW21LNN7ovsACs8W/C
	+BV+VL6ADB/BKv8bhofgRo02tyxk8AaadPWmJforUGIEAn4/BH00YOwiNyODwKkmoL6OoRdnfxE
	A7bU83YD9pj7bqWM7Vo2xF8p6w19786iT9LapbYbtfrHJ07TOIaiNahXfqkrwg8HKK0A3rgFn7I
	gkVMdfyk
X-Received: by 2002:a17:903:4b4c:b0:2b0:5ba3:2416 with SMTP id
 d9443c01a7336-2b0cd36e585mr1287265ad.7.1774587086695; Thu, 26 Mar 2026
 21:51:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAP-5=fUFGevUhRROdybtDCXZgWgxYzfLrq_0f8r5_Yv_VfxP+A@mail.gmail.com>
 <20260327015927.223999-1-thomas.falcon@intel.com>
In-Reply-To: <20260327015927.223999-1-thomas.falcon@intel.com>
From: Ian Rogers <irogers@google.com>
Date: Thu, 26 Mar 2026 21:51:15 -0700
X-Gm-Features: AQROBzDIH1t9Uky97r23IFE8ZD6pQvorV1X6-uqG54wgtfz7R9utBN_JcKkEdUk
Message-ID: <CAP-5=fXCUB3Hqwi1M7gpEZLrGw_H2DgH5Us=ez6PE2Nmb_3efA@mail.gmail.com>
Subject: Re: [PATCH v3] tools/perf: Fix ratio_to_prev event parsing test
To: Thomas Falcon <thomas.falcon@intel.com>
Cc: linux-perf-users@vger.kernel.org, Dapeng Mi <dapeng1.mi@linux.intel.com>, 
	linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 26, 2026 at 7:01=E2=80=AFPM Thomas Falcon <thomas.falcon@intel.=
com> wrote:
>
> test__ratio_to_prev() assumed the first event in a group is the leader,
> which is not the case when the event is expanded into two event groups
> on hybrid PMU's with auto counter reload support. Instead, iterate over t=
he
> event group generated for each core PMU. Also update "wrong leader" test =
to
> check that the subordinate event has the correct leader instead of checki=
ng
> that it is not the group leader. Finally, do not exit immediately if a PM=
U
> without auto counter reload support is found.
>
> Signed-off-by: Thomas Falcon <thomas.falcon@intel.com>
> Fixes: 56be0fe5f62c ("perf record: Add auto counter reload parse and regr=
ession tests")

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks!
Ian

> ---
> v3: Fixed early loop termination if PMU without auto counter reload suppo=
rt is
>     encountered first, suggested by Ian Rogers
> https://lore.kernel.org/all/CAP-5=3DfUFGevUhRROdybtDCXZgWgxYzfLrq_0f8r5_Y=
v_VfxP+A@mail.gmail.com/
>
> v2: made changes suggested by Dapeng Mi
> https://lore.kernel.org/all/997b6291-7429-4eaa-8467-1fd88e100616@linux.in=
tel.com/
> ---
>
>  tools/perf/tests/parse-events.c | 49 +++++++++++++++++++--------------
>  1 file changed, 28 insertions(+), 21 deletions(-)
>
> diff --git a/tools/perf/tests/parse-events.c b/tools/perf/tests/parse-eve=
nts.c
> index 1d3cc224f..05c3e899b 100644
> --- a/tools/perf/tests/parse-events.c
> +++ b/tools/perf/tests/parse-events.c
> @@ -1796,31 +1796,38 @@ static bool test__acr_valid(void)
>
>  static int test__ratio_to_prev(struct evlist *evlist)
>  {
> -       struct evsel *evsel;
> +       struct evsel *evsel, *leader;
>
>         TEST_ASSERT_VAL("wrong number of entries", 2 * perf_pmus__num_cor=
e_pmus() =3D=3D evlist->core.nr_entries);
>
> -        evlist__for_each_entry(evlist, evsel) {
> -               if (!perf_pmu__has_format(evsel->pmu, "acr_mask"))
> -                       return TEST_OK;
> -
> -               if (evsel =3D=3D evlist__first(evlist)) {
> -                       TEST_ASSERT_VAL("wrong config2", 0 =3D=3D evsel->=
core.attr.config2);
> -                       TEST_ASSERT_VAL("wrong leader", evsel__is_group_l=
eader(evsel));
> -                       TEST_ASSERT_VAL("wrong core.nr_members", evsel->c=
ore.nr_members =3D=3D 2);
> -                       TEST_ASSERT_VAL("wrong group_idx", evsel__group_i=
dx(evsel) =3D=3D 0);
> -                       TEST_ASSERT_EVSEL("unexpected event",
> -                                       evsel__match(evsel, HARDWARE, HW_=
CPU_CYCLES),
> -                                       evsel);
> -               } else {
> -                       TEST_ASSERT_VAL("wrong config2", 0 =3D=3D evsel->=
core.attr.config2);
> -                       TEST_ASSERT_VAL("wrong leader", !evsel__is_group_=
leader(evsel));
> -                       TEST_ASSERT_VAL("wrong core.nr_members", evsel->c=
ore.nr_members =3D=3D 0);
> -                       TEST_ASSERT_VAL("wrong group_idx", evsel__group_i=
dx(evsel) =3D=3D 1);
> -                       TEST_ASSERT_EVSEL("unexpected event",
> -                                       evsel__match(evsel, HARDWARE, HW_=
INSTRUCTIONS),
> -                                       evsel);
> +       evlist__for_each_entry(evlist, evsel) {
> +               if (evsel !=3D evsel__leader(evsel) ||
> +                   !perf_pmu__has_format(evsel->pmu, "acr_mask")) {
> +                       continue;
>                 }
> +               leader =3D evsel;
> +               /* cycles */
> +               TEST_ASSERT_VAL("wrong config2", 0 =3D=3D leader->core.at=
tr.config2);
> +               TEST_ASSERT_VAL("wrong core.nr_members", leader->core.nr_=
members =3D=3D 2);
> +               TEST_ASSERT_VAL("wrong group_idx", evsel__group_idx(leade=
r) =3D=3D 0);
> +               TEST_ASSERT_EVSEL("unexpected event",
> +                                 evsel__match(leader, HARDWARE, HW_CPU_C=
YCLES),
> +                                 leader);
> +               /*
> +                * The period value gets configured within evlist__config=
,
> +                * while this test executes only parse events method.
> +                */
> +               TEST_ASSERT_VAL("wrong period", 0 =3D=3D leader->core.att=
r.sample_period);
> +
> +                /* instructions/period=3D200000,ratio-to-prev=3D2.0/ */
> +               evsel =3D evsel__next(evsel);
> +               TEST_ASSERT_VAL("wrong config2", 0 =3D=3D evsel->core.att=
r.config2);
> +               TEST_ASSERT_VAL("wrong leader", evsel__has_leader(evsel, =
leader));
> +               TEST_ASSERT_VAL("wrong core.nr_members", evsel->core.nr_m=
embers =3D=3D 0);
> +               TEST_ASSERT_VAL("wrong group_idx", evsel__group_idx(evsel=
) =3D=3D 1);
> +               TEST_ASSERT_EVSEL("unexpected event",
> +                                 evsel__match(evsel, HARDWARE, HW_INSTRU=
CTIONS),
> +                                 evsel);
>                 /*
>                  * The period value gets configured within evlist__config=
,
>                  * while this test executes only parse events method.
> --
> 2.51.0
>
