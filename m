Received: from mail-il1-f175.google.com (mail-il1-f175.google.com [209.85.166.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7C1B2C9A
	for <linux-perf-users@vger.kernel.org>; Sat,  1 Feb 2025 07:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738393245; cv=none; b=ifV4+v4cPuqbA/E8XUo245u926KLalvWfBCBKvgEEYua6XGCnNW2uOgX5miA+Mg7BM3o25J5to5bgyV1HNL3fTsPvMbYoaOJMYqzcsV4bII2anS3VNhigoTk8JifLoqSEYtOrPi7CdKPSt7O8XoNyi+vgNWgQFGe5I7MUfup0Lc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738393245; c=relaxed/simple;
	bh=qMTNwUOqj6NbWVkC8zDJU6wWwxkM9OscN1Nwes7cuOw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eJescvNxZE/kg6P+JcUkwTEj03nc1rfZdkJxx7NIUBhIyNOGY25HvaCl27nIJm8wZaIErDyr2esaHEcvpYilW4II7vj5drutOGtIZxvMhRoZawF493C/jALjYvsGiZVHo7qU9sW7XhO7MvHs7zanRvcWX+95qNfb2Ekhh96gqXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mSUGGXKX; arc=none smtp.client-ip=209.85.166.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mSUGGXKX"
Received: by mail-il1-f175.google.com with SMTP id e9e14a558f8ab-3ce82195aa0so97555ab.0
        for <linux-perf-users@vger.kernel.org>; Fri, 31 Jan 2025 23:00:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738393242; x=1738998042; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NlUH0toT5TGu6PN1P+trJsIboeFtqEWlbpiNAeIZK94=;
        b=mSUGGXKXqsXdqu6Xn8jLbZH8MMCjXg+GoJcAzHYa/uoMhguS844SWUtBggHWId4e6A
         yo4KTeIJF/yyKsoat8kUeeKgiMRgoCkDSgneoYcB7majWwcwoCHr9l0K9a0k4V7YQ/C1
         jYOoRT2S1v85Qrtcq8vjwmX2GS4bo4d5DNJ4LV0L2b47ixSfT6WMOBWNVTy8+kEjW7l7
         Rbb02s0JyoSzuVJbUFbUCOosJht+6xIRLbI1IJRqwhIS5L9T1CZGiJk2OFbmd3kI/C95
         FsSzh1pA/Z1cy1kbclRtK8GW4KWwoF4Gi3Y/zgbJPYPMgRFggW/bHQRDlQBWutjp2Iv+
         ASYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738393242; x=1738998042;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NlUH0toT5TGu6PN1P+trJsIboeFtqEWlbpiNAeIZK94=;
        b=Q7WEyX2cJXqTDOf7NSBR7ryOcEH3WI9eFjM2InM9HVHBgj7csh0ZTvt7FfEJ6qkynq
         hCZHwI51NULjIbrbTCUt+ijlBIIEzYrJYuBD5kkBqyU9AEms/Nfk0qBl76nykBj0ZQ0z
         /FSBGtjySHaYntt1jc7kj7qQAqAEQCfCtUCTQjkK+hiEDlW/fhIFbKp44NlAYaBekhmH
         Llpb/9qlMqUDC/eTRp0j89FZs/bWVV2813YIqdvUy+y2a1G/L2qdMsnO9HBgdNmUyWmt
         JZDekuVrvqgAkeBAKnnl68x7z2TXnmQzj1aQUP8vAJV/8PVzXZf27lGpxP6CLG68wyrs
         zFsw==
X-Forwarded-Encrypted: i=1; AJvYcCUteshw+aK/swcg/5lTvHD7bwph02EX8AF5K3arkg0/hUSVZUMGgHdDOyulTO6AzyCqwVYct76yigxby2KFRPfS@vger.kernel.org
X-Gm-Message-State: AOJu0YzDhvoy0+XxZgGZMBAL0pBLcHKWTTmGxE2uDEX9s82jK0Q85o0O
	wkYOCU3dsXwfjYhy6cK2aZ3gwNeRBnSLhvNXLDMxVl/EQqtz+AL2rHLu+AEHc+tfkz3or6OQ/po
	fV5WR0OwqzuwueOTkQ4vTAjHsEsL2PjVPxJreY3kd3IjtIUZ0Anh7
X-Gm-Gg: ASbGncvhRSq+rZkN/f+sdXkBAiF/RlBQPBG5H/A0rsCdImKSNXxIKfsf+TfZkfGuKAO
	kExAS+7/nw8Co885gjfyOvcHnxf5zRriCvslgW6LtURyy7lNAluEa0ND/nJXwjsKECEOAe8kPGA
	==
X-Google-Smtp-Source: AGHT+IE4n3U84QUfbLQnJnUyA1TzpOEhS52Drot1jC3LRx5aT+dz+9D32y8IZ499NzvxMSVVZWdAyxrSFA/pZ+A83EM=
X-Received: by 2002:a05:6e02:1b05:b0:3a7:9ec6:2cff with SMTP id
 e9e14a558f8ab-3d0220232d4mr995145ab.25.1738393241506; Fri, 31 Jan 2025
 23:00:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250131112400.568975-1-tmricht@linux.ibm.com>
In-Reply-To: <20250131112400.568975-1-tmricht@linux.ibm.com>
From: Ian Rogers <irogers@google.com>
Date: Fri, 31 Jan 2025 23:00:30 -0800
X-Gm-Features: AWEUYZksCGBFTmtkS-T7mDYDAIodRX0c_XzFfccfrYYEjZvFBzXG_qUhoLkdVAE
Message-ID: <CAP-5=fU08m2nTzykWQ07cZY08j5rzSz7wZUYMBiTSabwVvPYMg@mail.gmail.com>
Subject: Re: [PATCH] perf test: Fix perf test 11 hwmon endianess issue
To: Thomas Richter <tmricht@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, acme@kernel.org, namhyung@kernel.org, 
	agordeev@linux.ibm.com, gor@linux.ibm.com, sumanthk@linux.ibm.com, 
	hca@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 31, 2025 at 3:24=E2=80=AFAM Thomas Richter <tmricht@linux.ibm.c=
om> wrote:
>
> perf test 11 hwmon fails on s390 with this error
>
>  # ./perf test -Fv 11
>  --- start ---
>  ---- end ----
>  11.1: Basic parsing test             : Ok
>  --- start ---
>  Testing 'temp_test_hwmon_event1'
>  Using CPUID IBM,3931,704,A01,3.7,002f
>  temp_test_hwmon_event1 -> hwmon_a_test_hwmon_pmu/temp_test_hwmon_event1/
>  FAILED tests/hwmon_pmu.c:189 Unexpected config for
>     'temp_test_hwmon_event1', 292470092988416 !=3D 655361
>  ---- end ----
>  11.2: Parsing without PMU name       : FAILED!
>  --- start ---
>  Testing 'hwmon_a_test_hwmon_pmu/temp_test_hwmon_event1/'
>  FAILED tests/hwmon_pmu.c:189 Unexpected config for
>     'hwmon_a_test_hwmon_pmu/temp_test_hwmon_event1/',
>     292470092988416 !=3D 655361
>  ---- end ----
>  11.3: Parsing with PMU name          : FAILED!
>  #
>
> The root cause is in member test_event::config which is initialized
> to 0xA0001 or 655361. During event parsing a long list event parsing
> functions are called and end up with this gdb call stack:
>
>  #0  hwmon_pmu__config_term (hwm=3D0x168dfd0, attr=3D0x3ffffff5ee8,
>         term=3D0x168db60, err=3D0x3ffffff81c8) at util/hwmon_pmu.c:623
>  #1  hwmon_pmu__config_terms (pmu=3D0x168dfd0, attr=3D0x3ffffff5ee8,
>         terms=3D0x3ffffff5ea8, err=3D0x3ffffff81c8) at util/hwmon_pmu.c:6=
62
>  #2  0x00000000012f870c in perf_pmu__config_terms (pmu=3D0x168dfd0,
>         attr=3D0x3ffffff5ee8, terms=3D0x3ffffff5ea8, zero=3Dfalse,
>         apply_hardcoded=3Dfalse, err=3D0x3ffffff81c8) at util/pmu.c:1519
>  #3  0x00000000012f88a4 in perf_pmu__config (pmu=3D0x168dfd0, attr=3D0x3f=
fffff5ee8,
>         head_terms=3D0x3ffffff5ea8, apply_hardcoded=3Dfalse, err=3D0x3fff=
fff81c8)
>         at util/pmu.c:1545
>  #4  0x00000000012680c4 in parse_events_add_pmu (parse_state=3D0x3ffffff7=
fb8,
>         list=3D0x168dc00, pmu=3D0x168dfd0, const_parsed_terms=3D0x3ffffff=
6090,
>         auto_merge_stats=3Dtrue, alternate_hw_config=3D10)
>         at util/parse-events.c:1508
>  #5  0x00000000012684c6 in parse_events_multi_pmu_add (parse_state=3D0x3f=
fffff7fb8,
>         event_name=3D0x168ec10 "temp_test_hwmon_event1", hw_config=3D10,
>         const_parsed_terms=3D0x0, listp=3D0x3ffffff6230, loc_=3D0x3ffffff=
70e0)
>         at util/parse-events.c:1592
>  #6  0x00000000012f0e4e in parse_events_parse (_parse_state=3D0x3ffffff7f=
b8,
>         scanner=3D0x16878c0) at util/parse-events.y:293
>  #7  0x00000000012695a0 in parse_events__scanner (str=3D0x3ffffff81d8
>         "temp_test_hwmon_event1", input=3D0x0, parse_state=3D0x3ffffff7fb=
8)
>         at util/parse-events.c:1867
>  #8  0x000000000126a1e8 in __parse_events (evlist=3D0x168b580,
>         str=3D0x3ffffff81d8 "temp_test_hwmon_event1", pmu_filter=3D0x0,
>         err=3D0x3ffffff81c8, fake_pmu=3Dfalse, warn_if_reordered=3Dtrue,
>         fake_tp=3Dfalse) at util/parse-events.c:2136
>  #9  0x00000000011e36aa in parse_events (evlist=3D0x168b580,
>         str=3D0x3ffffff81d8 "temp_test_hwmon_event1", err=3D0x3ffffff81c8=
)
>         at /root/linux/tools/perf/util/parse-events.h:41
>  #10 0x00000000011e3e64 in do_test (i=3D0, with_pmu=3Dfalse, with_alias=
=3Dfalse)
>         at tests/hwmon_pmu.c:164
>  #11 0x00000000011e422c in test__hwmon_pmu (with_pmu=3Dfalse)
>         at tests/hwmon_pmu.c:219
>  #12 0x00000000011e431c in test__hwmon_pmu_without_pmu (test=3D0x1610368
>         <suite.hwmon_pmu>, subtest=3D1) at tests/hwmon_pmu.c:23
>
> where the attr::config is set to value 292470092988416 or 0x10a0000000000
> in line 625 of file ./util/hwmon_pmu.c:
>
>    attr->config =3D key.type_and_num;
>
> However member key::type_and_num is defined as union and bit field:
>
>    union hwmon_pmu_event_key {
>         long type_and_num;
>         struct {
>                 int num :16;
>                 enum hwmon_type type :8;
>         };
>    };
>
> s390 is big endian and Intel is little endian architecture.
> The events for the hwmon dummy pmu have num =3D 1 or num =3D 2 and
> type is set to HWMON_TYPE_TEMP (which is 10).
> On s390 this assignes member key::type_and_num the value of
> 0x10a0000000000 (which is 292470092988416) as shown in above
> trace output.
>
> Fix this and export the structure/union hwmon_pmu_event_key
> so the test shares the same implementation as the event parsing
> functions for union and bit fields. This should avoid
> endianess issues on all platforms.
>
> Output after:
>  # ./perf test -F 11
>  11.1: Basic parsing test         : Ok
>  11.2: Parsing without PMU name   : Ok
>  11.3: Parsing with PMU name      : Ok
>  #
>
> Fixes: 531ee0fd4836 ("perf test: Add hwmon "PMU" test")
> Cc: Ian Rogers <irogers@google.com>
> Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks!
Ian

> ---
>  tools/perf/tests/hwmon_pmu.c | 16 +++++++++++-----
>  tools/perf/util/hwmon_pmu.c  | 14 --------------
>  tools/perf/util/hwmon_pmu.h  | 16 ++++++++++++++++
>  3 files changed, 27 insertions(+), 19 deletions(-)
>
> diff --git a/tools/perf/tests/hwmon_pmu.c b/tools/perf/tests/hwmon_pmu.c
> index d2b066a2b557..0837aca1cdfa 100644
> --- a/tools/perf/tests/hwmon_pmu.c
> +++ b/tools/perf/tests/hwmon_pmu.c
> @@ -13,17 +13,23 @@
>  static const struct test_event {
>         const char *name;
>         const char *alias;
> -       long config;
> +       union hwmon_pmu_event_key key;
>  } test_events[] =3D {
>         {
>                 "temp_test_hwmon_event1",
>                 "temp1",
> -               0xA0001,
> +               .key =3D {
> +                       .num =3D 1,
> +                       .type =3D 10
> +               },
>         },
>         {
>                 "temp_test_hwmon_event2",
>                 "temp2",
> -               0xA0002,
> +               .key =3D {
> +                       .num =3D 2,
> +                       .type =3D 10
> +               },
>         },
>  };
>
> @@ -183,11 +189,11 @@ static int do_test(size_t i, bool with_pmu, bool wi=
th_alias)
>                     strcmp(evsel->pmu->name, "hwmon_a_test_hwmon_pmu"))
>                         continue;
>
> -               if (evsel->core.attr.config !=3D (u64)test_events[i].conf=
ig) {
> +               if (evsel->core.attr.config !=3D (u64)test_events[i].key.=
type_and_num) {
>                         pr_debug("FAILED %s:%d Unexpected config for '%s'=
, %lld !=3D %ld\n",
>                                 __FILE__, __LINE__, str,
>                                 evsel->core.attr.config,
> -                               test_events[i].config);
> +                               test_events[i].key.type_and_num);
>                         ret =3D TEST_FAIL;
>                         goto out;
>                 }
> diff --git a/tools/perf/util/hwmon_pmu.c b/tools/perf/util/hwmon_pmu.c
> index 4acb9bb19b84..acd889b2462f 100644
> --- a/tools/perf/util/hwmon_pmu.c
> +++ b/tools/perf/util/hwmon_pmu.c
> @@ -107,20 +107,6 @@ struct hwmon_pmu {
>         int hwmon_dir_fd;
>  };
>
> -/**
> - * union hwmon_pmu_event_key: Key for hwmon_pmu->events as such each key
> - * represents an event.
> - *
> - * Related hwmon files start <type><number> that this key represents.
> - */
> -union hwmon_pmu_event_key {
> -       long type_and_num;
> -       struct {
> -               int num :16;
> -               enum hwmon_type type :8;
> -       };
> -};
> -
>  /**
>   * struct hwmon_pmu_event_value: Value in hwmon_pmu->events.
>   *
> diff --git a/tools/perf/util/hwmon_pmu.h b/tools/perf/util/hwmon_pmu.h
> index 882566846df4..b3329774d2b2 100644
> --- a/tools/perf/util/hwmon_pmu.h
> +++ b/tools/perf/util/hwmon_pmu.h
> @@ -91,6 +91,22 @@ enum hwmon_item {
>         HWMON_ITEM__MAX,
>  };
>
> +/**
> + * union hwmon_pmu_event_key: Key for hwmon_pmu->events as such each key
> + * represents an event.
> + * union is exposed for testing to ensure problems are avoided on big
> + * endian machines.
> + *
> + * Related hwmon files start <type><number> that this key represents.
> + */
> +union hwmon_pmu_event_key {
> +       long type_and_num;
> +       struct {
> +               int num :16;
> +               enum hwmon_type type :8;
> +       };
> +};
> +
>  bool perf_pmu__is_hwmon(const struct perf_pmu *pmu);
>  bool evsel__is_hwmon(const struct evsel *evsel);
>
> --
> 2.48.1
>
