Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFAF2347C7
	for <linux-perf-users@vger.kernel.org>; Thu, 26 Mar 2026 21:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774560771; cv=pass; b=GbHrNV6tKM+jRd0dAJiUOPkspwHQCt7kKOKs1tGTnqkuUNZevkOm6yW5xq428Fz90h8myMYEC/9FoylbVtAPA3S29CXswG1/uxvBgHZb/NkuZM5tS9KVXPADM76Quh5sfvUxlSaLX5caviuHIpGyD8jUrhWhUJX/2UNmFld4G+o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774560771; c=relaxed/simple;
	bh=BRdnOj1skffZBZ9eqkqnTSC7MKsYAeiyYvZQPCm5hDU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nIPHOPYzb0G44DwwcOwlbHK8qz+1MQMU+QEjyQNUQSf7iTPTJI5+ntdrs/jijrOcc2zhpAqWCV/LQQPy1bYE0HsqIpwxylTHEMxnEMyP5DIFutGM+J79rtWoElhY6WDanFKMJ/YS/JpUAfGQctlFqzh9/PjJkAUgvPojRaYopo0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=oOMo5oZx; arc=pass smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oOMo5oZx"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2b052562254so33035ad.0
        for <linux-perf-users@vger.kernel.org>; Thu, 26 Mar 2026 14:32:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774560769; cv=none;
        d=google.com; s=arc-20240605;
        b=L05yU/DcJWNbRRt9UlsMCPnVdG0z4kG0co7LbYMR8by0pyvJkOufJ1/WHiYJp+8coG
         Jdv9vFKn+itYR6aSZKMsX4nZlyosuYIbOppwF1nsAHuN+V56QMnnfoQdXklPcjd7hqko
         T0yEuAoWiP3AnMA79LsacsNCmhAfNIhmKz0KAvXDmkOp6rEDLky4gNhAeXC4a5WJPUsf
         3xsd7xvOrGI4jn2W6RJL6MwVYx50BGA9aNTBOSvNs4tRAlOJScFOdp6xwK50b69Ds1eO
         taAsKWw2FO7po8qkGhqciTPkGUrrTO13wL1//KetgJWBGmc40Ycw8NaVZy7IbgT/2tJn
         ud9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=XQVWwOiHgzOpvok3jXEkPaAAGTJXqeaKefQ9e9m8M60=;
        fh=/IWSL+5m7/eTmTWNgxmt14NnmFgCBctHwXWajqGuoi4=;
        b=MyXDUVM7LxdWnHpRTNEafflQJMA0LfB3JalG9lxTTPkt/9Hqxt0RB3fBOqmIdWa9Au
         Crh63hbZd5GBekkrmZgRwz9fqNqjXOthDHvZ7GNalVzN0ROH5X94Cg4TaABU/GZentSG
         CrrlYx7otZ8YM5AIcTGOXH95/N/6lOdcg59UmF4xKpA/z46bLCphN2RBu47ExyAlxjVS
         vMlNEUShkPDWubBH1d+0HThAcgL+D0HflbEZDeTS7lWxTeq3dA3iKvyEiekBXc0tecFf
         RqgREKLl1+JTqq4wuVrdrV0m89R9SB6dpStIrmELloI7JcaJcC0cUFXFUMM49gtuGVRk
         ngKg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774560769; x=1775165569; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XQVWwOiHgzOpvok3jXEkPaAAGTJXqeaKefQ9e9m8M60=;
        b=oOMo5oZxImwE/5aXIrgKqcdGNRFA2+5Ow7kfLtsN/s9XnDiDS5152c/UiYQJvPnpPh
         e17cdOMPRTb7koLWq6AdK/nwn/7kWr1zwwvoDGdSSOcxS9J68QPeWPvrEoNa2ot0AnXv
         MCqwG6nUZM3/QLZTVUkL6Ut2odrztpAYhOmtqKDmM6udRm645+xGe0bkrQxr/lq3l9qY
         a5Tnrr9rx2+QpvdsfYD4CZzM0+Pyhfs8kOqDETKSt6/4FGPUTRIXSKBRNO7jwuDWo3WX
         xgodWLZrU5kLpwG0p5EuOpey+/P8JhHYPP4aw1PtOtiQ2PAyewNB3aDw3+KzrGkBY/jM
         0QXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774560769; x=1775165569;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=XQVWwOiHgzOpvok3jXEkPaAAGTJXqeaKefQ9e9m8M60=;
        b=BB6p6njG3vHCcJw+h9oaLe4DzcFSteeOfoDZ2oShyictPwK2R2rMc/hdQMP0zhxria
         U+vPhkpZ1QF+rVeWsgvgS+S7rFnVSpKrJsNgi1VLkk3WOrsBlc7XZJoY7LucdwvdEpPg
         lH+uWfhpiWpz/u92DaY3faAqPS5u5X+f72Q72R6LT6tclnhZ22+ifyvyzgG6vFBUDYxW
         DmA7vcX6teaU1RDl26CNMo6fnuuGRCVlv4jhJCS//EKV4je5dKfDovbziwCA//1U6w3w
         SbxKGXxKMgcUfTtU/EGZ2yt20kIwZNRB3EEpSIVuV64YvHViIqNWSDAC4Tu1fZ1QAMct
         IZoA==
X-Gm-Message-State: AOJu0Yyw1aFUYiicFZ2zQiRkHM5LwxdXB7LOGUDUoOjgNr+FMfrF8VOA
	4JoYo3x0g2nOjBCRb4+gYVZwNN6c5SZyRjI2WyitC7mbRPPJlruF1btF817yQx/AFz652K/6Idh
	8AnqRy9bRJCu4jST4mPPz0ywIV/TGlD0nPoOK0cd1
X-Gm-Gg: ATEYQzzxo+jW+YLlwjRoYNKvXHIy+2Jubw+Ld103IeZnXBtoSFdurKbcuAcB2vCXB8i
	k4lIJkGXcljaFH6XGWjPHd2zRY0TlGZU8ogGoB7GXN9CsongWNhmsCa34pdAYw+sXzzj5c5dKY2
	EUKG6SJa+W3TOVeb+Ho2VHJJnCss6UfQ6fgCh6MVTHqp9PGtRr1FlAH5a1fnDSR0MXJDHAFW83Z
	chgXr/e9NQiVyWPhClufD8ajcCbN5YVFKFkrZ81u2RiHacmn2I1a69MJySFw06cZkJ+lfNw/D6s
	EjRP4ExyXyyF6w1zvIFujSOTiMF1oW5Hv7eH
X-Received: by 2002:a17:902:ef46:b0:2b0:5193:1212 with SMTP id
 d9443c01a7336-2b0cc23f103mr1088335ad.4.1774560768573; Thu, 26 Mar 2026
 14:32:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260326180125.168536-1-thomas.falcon@intel.com>
In-Reply-To: <20260326180125.168536-1-thomas.falcon@intel.com>
From: Ian Rogers <irogers@google.com>
Date: Thu, 26 Mar 2026 14:32:37 -0700
X-Gm-Features: AQROBzDLYlS8FqKHU-z7YpBW3OsGOSQmLNytDuAKUeqHkGTFtOKqZOIKCYaz6BM
Message-ID: <CAP-5=fUFGevUhRROdybtDCXZgWgxYzfLrq_0f8r5_Yv_VfxP+A@mail.gmail.com>
Subject: Re: [PATCH v2] tools/perf: Fix ratio_to_prev event parsing test
To: Thomas Falcon <thomas.falcon@intel.com>
Cc: linux-perf-users@vger.kernel.org, Dapeng Mi <dapeng1.mi@linux.intel.com>, 
	linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 26, 2026 at 11:01=E2=80=AFAM Thomas Falcon <thomas.falcon@intel=
.com> wrote:
>
> test__ratio_to_prev() assumed the first event in a group is the leader,
> which is not the case when the event is expanded into two event groups
> on hybrid PMU's with auto counter reload support. This patch updates the
> test to iterate over the event group generated for each core PMU. Also
> update "wrong leader" test to check that the subordinate event has the
> correct leader instead of checking that it is not the group leader.
>
> Signed-off-by: Thomas Falcon <thomas.falcon@intel.com>
> Fixes: 56be0fe5f62c ("perf record: Add auto counter reload parse and regr=
ession tests")
> ---
> v2: made changes suggested by Dapeng Mi
> https://lore.kernel.org/all/997b6291-7429-4eaa-8467-1fd88e100616@linux.in=
tel.com/
> ---
>  tools/perf/tests/parse-events.c | 47 +++++++++++++++++++--------------
>  1 file changed, 27 insertions(+), 20 deletions(-)
>
> diff --git a/tools/perf/tests/parse-events.c b/tools/perf/tests/parse-eve=
nts.c
> index 1d3cc224fbc2..4487508c5658 100644
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
> +       for (int i =3D 0; i < num_core_entries(evlist); i++) {
> +               leader =3D (i =3D=3D 0 ? evlist__first(evlist) : evsel__n=
ext(evsel));
> +               if (!perf_pmu__has_format(leader->pmu, "acr_mask"))

If the p-core non-ACR supporting events are first, won't this mean the
loop immediately terminates? I wonder the loop should be:
```
evlist__for_each_entry(evlist, evsel) {
               if (evsel !=3D evsel__leader(evsel) ||
!perf_pmu__has_format(evsel->pmu, "acr_mask"))
                    continue; /* Not a group leader or the event is
for a non-ACR supporting PMU. */
```
then the regular tests on the config2, etc. Then evsel__next to get
the instructions event, etc.

Thanks,
Ian


>                         return TEST_OK;
>
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
> -               }
> +               /* cycles */
> +               TEST_ASSERT_VAL("wrong config2", 0 =3D=3D leader->core.at=
tr.config2);
> +               TEST_ASSERT_VAL("wrong leader", evsel__is_group_leader(le=
ader));
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
> +               evsel =3D evsel__next(leader);
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
> 2.43.0
>
