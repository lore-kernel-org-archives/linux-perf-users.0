Received: from mail-il1-f173.google.com (mail-il1-f173.google.com [209.85.166.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DB491CC158
	for <linux-perf-users@vger.kernel.org>; Tue,  1 Oct 2024 17:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727804645; cv=none; b=efd4xk2WTqda56YNBWLxCdEQJDYhM3KAwbvcs8D1G4tZQ8259mGlSWe3II+wTcEwilkxOp+eUHC9+X+N4YdbqeAxkuElWo2yf7Kt+96cTGaJQ4PLr/TIVQL3gZuBIebUhMnvgRYU+hZc5F9OUHQoavLAu4Y0lL91/ZM9iQKSDGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727804645; c=relaxed/simple;
	bh=jLqnl25KVFvryb3D32XATKscp2ZYj1uA505YduUlVXs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mqOyjwz0cSHhfWe516ez09HuyjZgTFf8oChVC4iLzh0rabNMh1EjlYq2C0pw47kHSNd+xG9xA8ncm+3oPnRTjZIlOJDwxHLJrBxTJgZdjCldf5kRc7owHGN4lDYMIzjOSjxgpfMjJhG6ctQ1ZZXIn+jPveGKBMElXERxw+oTsfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eCp3Io6F; arc=none smtp.client-ip=209.85.166.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eCp3Io6F"
Received: by mail-il1-f173.google.com with SMTP id e9e14a558f8ab-3a0cb892c6aso18505ab.0
        for <linux-perf-users@vger.kernel.org>; Tue, 01 Oct 2024 10:44:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727804642; x=1728409442; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ifytoyouFq0dXDDs/pw0H3bHSrehEwG37oFTdZ1vphQ=;
        b=eCp3Io6FIdd/xnvubXOjdedHazbhwwfgpkZHU8FY/FW7NYcBNR4oylxvreDgTiGn/6
         hTpuI0+m3s7+LTCWzx0Jxcb/Vgx4WI/atw3bgp2IITHQCWs2VFcL/GN7wfNhPe11MI8Y
         p3p9y2JZkLfmiwIF5LdEISlwdHP/SSTGYDR0LFvyYNj5jjm+lloZbo63yXZNN0MSb1tL
         PewIGmVvsoPSKRcB9o9TMwtzFS0mfAkZw6juRIgHyPzc9yya4m+yp4uVRieBWofHS0sb
         3Km4I7FniX4GXckB8VfS86ceHPgCKvlo2idEuS6RSal300cFN+fVw4ab2zMANndpkzQy
         2aQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727804642; x=1728409442;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ifytoyouFq0dXDDs/pw0H3bHSrehEwG37oFTdZ1vphQ=;
        b=Ld06wiMeOzWyhehMCWQfBLxRgXlaOjS5uUxDvrz5eJAweWP+uwADe77XW9x3ZdDFMC
         XosX8IkU9rqFB91Od8bhcmr0x9wN1x5TuCYUAmBPQYAXICH+wk24GrrURgsBRwCncaM7
         XKYOSaCXZCIO2XNx0piOiG84I9t6Z5paBUVm8kGXQBUsVGdeNl2AFTJqPD/jbgQja3SA
         y5KsGlIcNJgnS5NnTr2ZO28gJTFwaSI4I6kZqzPNgH/UlhFpIstGarLFLZEJeCR3z6jv
         yyFw5GzMP2QcSSvWcQBEwDJYXE6KE+U3uzjyAV61hNrPJjaPFiJ50c0XLmVxmknh2Y/M
         zCQw==
X-Forwarded-Encrypted: i=1; AJvYcCV1yAPkyvyOlEnXBiqjR5fYAch0aegGCapQ9Xx0cBjazZq5dd+T3DLT5DMKhlLAIfVdUab8SqbM1B3YsVsDD5Ap@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0wCq+nrXWgMc0q34o8Sduw4JJeN8seb5XyNTbSvIAqHgN9qik
	N+Ch2+Kjgdk96XgO7qkHXjA53KZWr96RrlEePD7q01t5AH0tjrdx0Vo5VQwFQfpVIF7uUHumDBI
	wFx4bLdoBFuDD67snOySKBo7rEuqOUfcMLBCP
X-Google-Smtp-Source: AGHT+IFl1MO95mo++7bm7EQB3yyco8vJCaaprs0H8ILf/rO7st5tAfl8GXG6z0gpyqldYXl0lK6dAEU59ZQz8L0vZVE=
X-Received: by 2002:a05:6e02:1a22:b0:3a0:9e83:21ea with SMTP id
 e9e14a558f8ab-3a36083362dmr4763855ab.17.1727804641985; Tue, 01 Oct 2024
 10:44:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241001002027.1272889-1-namhyung@kernel.org> <20241001002027.1272889-3-namhyung@kernel.org>
In-Reply-To: <20241001002027.1272889-3-namhyung@kernel.org>
From: Ian Rogers <irogers@google.com>
Date: Tue, 1 Oct 2024 10:43:50 -0700
Message-ID: <CAP-5=fVrMjZv+JNRk0_H0GjK5c+FgxbRCkQt2uCQRF-sbYdkkQ@mail.gmail.com>
Subject: Re: [PATCH 2/8] perf tools: Don't set attr.exclude_guest by default
To: Namhyung Kim <namhyung@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Kan Liang <kan.liang@linux.intel.com>, 
	Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org, 
	Ravi Bangoria <ravi.bangoria@amd.com>, Mark Rutland <mark.rutland@arm.com>, 
	James Clark <james.clark@arm.com>, Kajol Jain <kjain@linux.ibm.com>, 
	Thomas Richter <tmricht@linux.ibm.com>, Atish Patra <atishp@atishpatra.org>, 
	Palmer Dabbelt <palmer@rivosinc.com>, Mingwei Zhang <mizhang@google.com>, 
	James Clark <james.clark@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 30, 2024 at 5:20=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> The exclude_guest in the event attribute is to limit profiling in the
> host environment.  But I'm not sure why we want to set it by default
> cause we don't care about it in most cases and I feel like it just
> makes new PMU implementation complicated.
>
> Of course it's useful for perf kvm command so I added the
> exclude_GH_default variable to preserve the old behavior for perf kvm
> and other commands like perf record and stat won't set the exclude bit.
> This is helpful for AMD IBS case since having exclude_guest bit will
> clear new feature bit due to the missing feature check logic.
>
>   $ sysctl kernel.perf_event_paranoid
>   kernel.perf_event_paranoid =3D 0
>
>   $ perf record -W -e ibs_op// -vv true 2>&1 | grep switching
>   switching off PERF_FORMAT_LOST support
>   switching off weight struct support
>   switching off bpf_event
>   switching off ksymbol
>   switching off cloexec flag
>   switching off mmap2
>   switching off exclude_guest, exclude_host
>
> Intestingly, I found it sets the exclude_bit if "u" modifier is used.
> I don't know why but it's neither intuitive nor consistent.  Let's
> remove the bit there too.
>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: James Clark <james.clark@linaro.org>
> Cc: Ravi Bangoria <ravi.bangoria@amd.com>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/builtin-kvm.c                   |  1 +
>  tools/perf/tests/attr/test-record-dummy-C0 |  2 +-
>  tools/perf/tests/parse-events.c            | 18 +++++++++---------
>  tools/perf/util/parse-events.c             |  2 +-
>  tools/perf/util/util.c                     | 10 ++++++++--
>  tools/perf/util/util.h                     |  3 +++
>  6 files changed, 23 insertions(+), 13 deletions(-)
>
> diff --git a/tools/perf/builtin-kvm.c b/tools/perf/builtin-kvm.c
> index 55ea17c5ff02acf7..099ce3ebf67ce6ee 100644
> --- a/tools/perf/builtin-kvm.c
> +++ b/tools/perf/builtin-kvm.c
> @@ -2147,6 +2147,7 @@ int cmd_kvm(int argc, const char **argv)
>                                                 "buildid-list", "stat", N=
ULL };
>         const char *kvm_usage[] =3D { NULL, NULL };
>
> +       exclude_GH_default =3D true;
>         perf_host  =3D 0;
>         perf_guest =3D 1;
>
> diff --git a/tools/perf/tests/attr/test-record-dummy-C0 b/tools/perf/test=
s/attr/test-record-dummy-C0
> index 576ec48b3aafaa6a..8ce6f0a5df5b7013 100644
> --- a/tools/perf/tests/attr/test-record-dummy-C0
> +++ b/tools/perf/tests/attr/test-record-dummy-C0
> @@ -37,7 +37,7 @@ precise_ip=3D0
>  mmap_data=3D0
>  sample_id_all=3D1
>  exclude_host=3D0
> -exclude_guest=3D1
> +exclude_guest=3D0
>  exclude_callchain_kernel=3D0
>  exclude_callchain_user=3D0
>  mmap2=3D1
> diff --git a/tools/perf/tests/parse-events.c b/tools/perf/tests/parse-eve=
nts.c
> index 78e999f03d2d75f4..727683f249f66f5a 100644
> --- a/tools/perf/tests/parse-events.c
> +++ b/tools/perf/tests/parse-events.c
> @@ -932,7 +932,7 @@ static int test__group2(struct evlist *evlist)
>                         TEST_ASSERT_VAL("wrong exclude_user", !evsel->cor=
e.attr.exclude_user);
>                         TEST_ASSERT_VAL("wrong exclude_kernel", !evsel->c=
ore.attr.exclude_kernel);
>                         TEST_ASSERT_VAL("wrong exclude_hv", evsel->core.a=
ttr.exclude_hv);
> -                       TEST_ASSERT_VAL("wrong exclude guest", evsel->cor=
e.attr.exclude_guest);
> +                       TEST_ASSERT_VAL("wrong exclude guest", !evsel->co=
re.attr.exclude_guest);
>                         TEST_ASSERT_VAL("wrong exclude host", !evsel->cor=
e.attr.exclude_host);
>                         TEST_ASSERT_VAL("wrong precise_ip", !evsel->core.=
attr.precise_ip);
>                         TEST_ASSERT_VAL("wrong leader", evsel__is_group_l=
eader(evsel));
> @@ -947,7 +947,7 @@ static int test__group2(struct evlist *evlist)
>                         TEST_ASSERT_VAL("wrong exclude_user", !evsel->cor=
e.attr.exclude_user);
>                         TEST_ASSERT_VAL("wrong exclude_kernel", evsel->co=
re.attr.exclude_kernel);
>                         TEST_ASSERT_VAL("wrong exclude_hv", evsel->core.a=
ttr.exclude_hv);
> -                       TEST_ASSERT_VAL("wrong exclude guest", evsel->cor=
e.attr.exclude_guest);
> +                       TEST_ASSERT_VAL("wrong exclude guest", !evsel->co=
re.attr.exclude_guest);
>                         TEST_ASSERT_VAL("wrong exclude host", !evsel->cor=
e.attr.exclude_host);
>                         TEST_ASSERT_VAL("wrong precise_ip", !evsel->core.=
attr.precise_ip);
>                         if (evsel__has_leader(evsel, leader))
> @@ -1072,7 +1072,7 @@ static int test__group3(struct evlist *evlist __may=
be_unused)
>                 TEST_ASSERT_VAL("wrong exclude_user", !evsel->core.attr.e=
xclude_user);
>                 TEST_ASSERT_VAL("wrong exclude_kernel", evsel->core.attr.=
exclude_kernel);
>                 TEST_ASSERT_VAL("wrong exclude_hv", evsel->core.attr.excl=
ude_hv);
> -               TEST_ASSERT_VAL("wrong exclude guest", evsel->core.attr.e=
xclude_guest);
> +               TEST_ASSERT_VAL("wrong exclude guest", !evsel->core.attr.=
exclude_guest);
>                 TEST_ASSERT_VAL("wrong exclude host", !evsel->core.attr.e=
xclude_host);
>                 TEST_ASSERT_VAL("wrong precise_ip", !evsel->core.attr.pre=
cise_ip);
>                 TEST_ASSERT_VAL("wrong leader", evsel__is_group_leader(ev=
sel));
> @@ -1222,7 +1222,7 @@ static int test__group5(struct evlist *evlist __may=
be_unused)
>                 TEST_ASSERT_VAL("wrong exclude_user", !evsel->core.attr.e=
xclude_user);
>                 TEST_ASSERT_VAL("wrong exclude_kernel", !evsel->core.attr=
.exclude_kernel);
>                 TEST_ASSERT_VAL("wrong exclude_hv", !evsel->core.attr.exc=
lude_hv);
> -               TEST_ASSERT_VAL("wrong exclude guest", evsel->core.attr.e=
xclude_guest);
> +               TEST_ASSERT_VAL("wrong exclude guest", !evsel->core.attr.=
exclude_guest);
>                 TEST_ASSERT_VAL("wrong exclude host", !evsel->core.attr.e=
xclude_host);
>                 TEST_ASSERT_VAL("wrong precise_ip", !evsel->core.attr.pre=
cise_ip);
>                 TEST_ASSERT_VAL("wrong leader", evsel__is_group_leader(ev=
sel));
> @@ -1437,7 +1437,7 @@ static int test__leader_sample1(struct evlist *evli=
st)
>                 TEST_ASSERT_VAL("wrong exclude_user", !evsel->core.attr.e=
xclude_user);
>                 TEST_ASSERT_VAL("wrong exclude_kernel", !evsel->core.attr=
.exclude_kernel);
>                 TEST_ASSERT_VAL("wrong exclude_hv", !evsel->core.attr.exc=
lude_hv);
> -               TEST_ASSERT_VAL("wrong exclude guest", evsel->core.attr.e=
xclude_guest);
> +               TEST_ASSERT_VAL("wrong exclude guest", !evsel->core.attr.=
exclude_guest);
>                 TEST_ASSERT_VAL("wrong exclude host", !evsel->core.attr.e=
xclude_host);
>                 TEST_ASSERT_VAL("wrong precise_ip", !evsel->core.attr.pre=
cise_ip);
>                 TEST_ASSERT_VAL("wrong group name", !evsel->group_name);
> @@ -1453,7 +1453,7 @@ static int test__leader_sample1(struct evlist *evli=
st)
>                 TEST_ASSERT_VAL("wrong exclude_user", !evsel->core.attr.e=
xclude_user);
>                 TEST_ASSERT_VAL("wrong exclude_kernel", !evsel->core.attr=
.exclude_kernel);
>                 TEST_ASSERT_VAL("wrong exclude_hv", !evsel->core.attr.exc=
lude_hv);
> -               TEST_ASSERT_VAL("wrong exclude guest", evsel->core.attr.e=
xclude_guest);
> +               TEST_ASSERT_VAL("wrong exclude guest", !evsel->core.attr.=
exclude_guest);
>                 TEST_ASSERT_VAL("wrong exclude host", !evsel->core.attr.e=
xclude_host);
>                 TEST_ASSERT_VAL("wrong precise_ip", !evsel->core.attr.pre=
cise_ip);
>                 TEST_ASSERT_VAL("wrong leader", evsel__has_leader(evsel, =
leader));
> @@ -1468,7 +1468,7 @@ static int test__leader_sample1(struct evlist *evli=
st)
>                 TEST_ASSERT_VAL("wrong exclude_user", !evsel->core.attr.e=
xclude_user);
>                 TEST_ASSERT_VAL("wrong exclude_kernel", !evsel->core.attr=
.exclude_kernel);
>                 TEST_ASSERT_VAL("wrong exclude_hv", !evsel->core.attr.exc=
lude_hv);
> -               TEST_ASSERT_VAL("wrong exclude guest", evsel->core.attr.e=
xclude_guest);
> +               TEST_ASSERT_VAL("wrong exclude guest", !evsel->core.attr.=
exclude_guest);
>                 TEST_ASSERT_VAL("wrong exclude host", !evsel->core.attr.e=
xclude_host);
>                 TEST_ASSERT_VAL("wrong precise_ip", !evsel->core.attr.pre=
cise_ip);
>                 TEST_ASSERT_VAL("wrong group name", !evsel->group_name);
> @@ -1497,7 +1497,7 @@ static int test__leader_sample2(struct evlist *evli=
st __maybe_unused)
>                 TEST_ASSERT_VAL("wrong exclude_user", !evsel->core.attr.e=
xclude_user);
>                 TEST_ASSERT_VAL("wrong exclude_kernel", evsel->core.attr.=
exclude_kernel);
>                 TEST_ASSERT_VAL("wrong exclude_hv", evsel->core.attr.excl=
ude_hv);
> -               TEST_ASSERT_VAL("wrong exclude guest", evsel->core.attr.e=
xclude_guest);
> +               TEST_ASSERT_VAL("wrong exclude guest", !evsel->core.attr.=
exclude_guest);
>                 TEST_ASSERT_VAL("wrong exclude host", !evsel->core.attr.e=
xclude_host);
>                 TEST_ASSERT_VAL("wrong precise_ip", !evsel->core.attr.pre=
cise_ip);
>                 TEST_ASSERT_VAL("wrong group name", !evsel->group_name);
> @@ -1513,7 +1513,7 @@ static int test__leader_sample2(struct evlist *evli=
st __maybe_unused)
>                 TEST_ASSERT_VAL("wrong exclude_user", !evsel->core.attr.e=
xclude_user);
>                 TEST_ASSERT_VAL("wrong exclude_kernel", evsel->core.attr.=
exclude_kernel);
>                 TEST_ASSERT_VAL("wrong exclude_hv", evsel->core.attr.excl=
ude_hv);
> -               TEST_ASSERT_VAL("wrong exclude guest", evsel->core.attr.e=
xclude_guest);
> +               TEST_ASSERT_VAL("wrong exclude guest", !evsel->core.attr.=
exclude_guest);
>                 TEST_ASSERT_VAL("wrong exclude host", !evsel->core.attr.e=
xclude_host);
>                 TEST_ASSERT_VAL("wrong precise_ip", !evsel->core.attr.pre=
cise_ip);
>                 TEST_ASSERT_VAL("wrong group name", !evsel->group_name);
> diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-event=
s.c
> index e96cf13dc396193f..ff67213d6e887169 100644
> --- a/tools/perf/util/parse-events.c
> +++ b/tools/perf/util/parse-events.c
> @@ -1776,7 +1776,7 @@ static int parse_events__modifier_list(struct parse=
_events_state *parse_state,
>                 if (mod.user) {
>                         if (!exclude)
>                                 exclude =3D eu =3D ek =3D eh =3D 1;
> -                       if (!exclude_GH && !perf_guest)
> +                       if (!exclude_GH && !perf_guest && exclude_GH_defa=
ult)
>                                 eG =3D 1;
>                         eu =3D 0;
>                 }
> diff --git a/tools/perf/util/util.c b/tools/perf/util/util.c
> index 9d55a13787ce3c05..280c86d61d8a7956 100644
> --- a/tools/perf/util/util.c
> +++ b/tools/perf/util/util.c
> @@ -78,17 +78,23 @@ bool sysctl__nmi_watchdog_enabled(void)
>
>  bool test_attr__enabled;
>
> +bool exclude_GH_default;
> +
>  bool perf_host  =3D true;
>  bool perf_guest =3D false;
>
>  void event_attr_init(struct perf_event_attr *attr)
>  {
> +       /* to capture ABI version */
> +       attr->size =3D sizeof(*attr);
> +
> +       if (!exclude_GH_default)
> +               return;
> +
>         if (!perf_host)
>                 attr->exclude_host  =3D 1;
>         if (!perf_guest)
>                 attr->exclude_guest =3D 1;
> -       /* to capture ABI version */
> -       attr->size =3D sizeof(*attr);
>  }
>
>  int mkdir_p(char *path, mode_t mode)
> diff --git a/tools/perf/util/util.h b/tools/perf/util/util.h
> index 9966c21aaf048479..4920e102ff54879a 100644
> --- a/tools/perf/util/util.h
> +++ b/tools/perf/util/util.h
> @@ -21,6 +21,9 @@ extern const char perf_more_info_string[];
>
>  extern const char *input_name;
>
> +/* This will control if perf_{host,guest} will set attr.exclude_{host,gu=
est}. */
> +extern bool exclude_GH_default;
> +
>  extern bool perf_host;
>  extern bool perf_guest;
>
> --
> 2.46.1.824.gd892dcdcdd-goog
>
