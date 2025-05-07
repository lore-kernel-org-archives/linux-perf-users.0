Received: from mail-il1-f182.google.com (mail-il1-f182.google.com [209.85.166.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0B4728B7C8
	for <linux-perf-users@vger.kernel.org>; Wed,  7 May 2025 15:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746632561; cv=none; b=Na9+btGstG9CpEGSOhDHJVBQZbQLIxMatYJAlPadeckFnYB5HxbEKYcRezCxtoNuSiNojJuvxDTQD8TOIv6QLVSZgkOTY+HrCQzhN6OavbP1DN17tKk3xifjh4rvzaluTZdXMVA7detk8q2QOOG6W3Az/wwdcVb5JiVRTNwFq14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746632561; c=relaxed/simple;
	bh=x+P+mSyCsqdybvF9FNMXVrb0hR5PY7/tsywTVL8r+B4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UUgK44ShePdLSvaFNc1WXKC6hTUKhIoOcDi7ZsD1/s93UDQgBqn3Q6l9g/j2fBC9QC9LNQYrCczdmsidFN+RlYHBASCscFO1C2nd4tkuuzVlJLkDsQK/NiOfl6KiU9WDJ7iBgK9MsSLq9SAQlAFcrbXysJpn39zH8kN1z6G3j4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RNQYaZUT; arc=none smtp.client-ip=209.85.166.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RNQYaZUT"
Received: by mail-il1-f182.google.com with SMTP id e9e14a558f8ab-3da73d35c11so180575ab.1
        for <linux-perf-users@vger.kernel.org>; Wed, 07 May 2025 08:42:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1746632559; x=1747237359; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vDxRXbqBwDv5Hl+NYnHumSA5lo4ZmV7LDaBP3Rm06RQ=;
        b=RNQYaZUT0HZ/5v8OaZ5P1i3yaZPsIa3+WwcTFfjsLmx5317HST7ci69i4MA69d/T0m
         vj8bqeDrYqDH3c9ZMajm/jpvvUcPbAHHP8w9FnhQqwPDgc3/wUE30xz9jniT/i4C+/dV
         HZiKRzcM7LP+mush4IeRU080tKOZvfE3XEy1yETl8aUIpOXXI7aOXNCohjfeIenciMnB
         e8px2/a3/ZI4EyBdxwMN4zFa0wGwu83flK0cwCG5e1B7hx/wflt9xm0aYvHpU5ynVM0+
         ei75sAhlChCGleuu7Dh5D16EYlqyor35dfxDTIrRH0SG2fD2U4g/sbtVq5AwqhIjDsZu
         6lXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746632559; x=1747237359;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vDxRXbqBwDv5Hl+NYnHumSA5lo4ZmV7LDaBP3Rm06RQ=;
        b=NSaGLSrQqe26xNWOQ+De9iuVlvefa8nOG4IEfLDJFmJ6jw6JXa0xC144KsySMDJDa6
         fYm4b/Nz6uX31kQrz262icQsKzPd5CMx23MyyMPgJTbrbmk32asVQefmZvcxKCVrK2mq
         iqOIk6fh84Qoi05pO9EI3RbWW45V8AbbIqubNwWQfSmbY/oVEJV9Z4mC0kDkyvhveg45
         UdVqMf4iwXS0UmGkhV3CUpyX8OfIhEi2rShNwKJvb2tiCDxc6/oLFOPHiH69WvVFlKtp
         XBLiboq7ywuy8iy8sriJPXZ062TYHJXtaHPxjGLOCHJR48B03y8PTtPwYFgueG1MFxON
         XF4Q==
X-Forwarded-Encrypted: i=1; AJvYcCW9ziAMkkXjGo+warLgo+Iw9xq0quJ8cyZhOUP2vErs9Ji8DoEBVau05f5U3atYM00zC50swLTrtk9Wd9HNHgQY@vger.kernel.org
X-Gm-Message-State: AOJu0YwFIQcwXeKOzgQcoOaiYK91BrB3JbCJwfgvU9dQQmXTAAiN2SuR
	u76SIKIZ4OnKkRDpPNFHt/G15FVXoWb/gRudZaZ6GDPVYG2nDSKaZIu4aAGsTZNElLIBw0ah1nm
	wou1iq7Kr1joe34BxM2yYRqfrokU6lO6/mnSylNYzHCurpJzDdBdAy90=
X-Gm-Gg: ASbGncsjdJY5/Td77fJd6UruclMkL2I9ndPFPxerT5NEkviBAbuYWoRvnC+pOaPgsul
	lsd11GPksaXVn2hn7gjLWAfU7BDIv4YnBaxQxNPDHy13YFqycHtsZ0aKEoW6R2AQjMXr7UgvHlF
	EheF9035i6GkroFoeZGA4aBQ/cDmyqHa0LUl7usVXULvUOLqk0J6nTVszFNrUvDA==
X-Google-Smtp-Source: AGHT+IGTypjRM/7ms+WuZpQigxlm/yFBEDRPIwGBX1nH/YGYbY7Jdvqu4d62IsDngl4ROr/SIaa731t7JOB9ZvYrVig=
X-Received: by 2002:a05:6e02:3808:b0:3a7:cd21:493f with SMTP id
 e9e14a558f8ab-3da7390c734mr3599225ab.26.1746632558521; Wed, 07 May 2025
 08:42:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250506222312.1125082-1-namhyung@kernel.org>
In-Reply-To: <20250506222312.1125082-1-namhyung@kernel.org>
From: Ian Rogers <irogers@google.com>
Date: Wed, 7 May 2025 08:42:27 -0700
X-Gm-Features: ATxdqUHOpYfEQYtVa6X7orww9lCxei4UarhBcNmcqY_ClU7-OjKy9fphUM-tYKA
Message-ID: <CAP-5=fVvth_HnfnPNxtHe=FzxT9hNNKKDLGCSvQfLqwTY4WpHg@mail.gmail.com>
Subject: Re: [PATCH] perf pmu: Consider raw events as legacy events
To: Namhyung Kim <namhyung@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Kan Liang <kan.liang@linux.intel.com>, 
	Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 6, 2025 at 3:23=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> w=
rote:
>
> When it finds a matching pmu for a legacy event, it should look for
> core pmus.  The raw events also refers to core events so it should be
> handled together.
>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---
>  tools/perf/util/pmus.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/tools/perf/util/pmus.c b/tools/perf/util/pmus.c
> index b99292de76693dbb..0134321fc520b1fc 100644
> --- a/tools/perf/util/pmus.c
> +++ b/tools/perf/util/pmus.c
> @@ -726,7 +726,8 @@ struct perf_pmu *evsel__find_pmu(const struct evsel *=
evsel)
>         pmu =3D perf_pmus__find_by_type(evsel->core.attr.type);
>         legacy_core_type =3D
>                 evsel->core.attr.type =3D=3D PERF_TYPE_HARDWARE ||
> -               evsel->core.attr.type =3D=3D PERF_TYPE_HW_CACHE;
> +               evsel->core.attr.type =3D=3D PERF_TYPE_HW_CACHE ||
> +               evsel->core.attr.type =3D=3D PERF_TYPE_RAW;

I don't think this is right. The PERF_TYPE_RAW isn't a legacy type as
we map sysfs/json names to the format encoding. More than this, the
extended type information will not be present for a raw type and so
this change could cause an invalid PMU to be looked up on
hybrid/BIG.little systems. On x86 the cpu or cpu_core PMU will have
type PERF_TYPE_RAW (4). As is common ARM decided to do things
differently, meaning there is no type 4 to a PMU mapping. I think we
need a change like:
```
diff --git a/tools/perf/util/pmus.c b/tools/perf/util/pmus.c
index b99292de7669..6632209c6664 100644
--- a/tools/perf/util/pmus.c
+++ b/tools/perf/util/pmus.c
@@ -727,14 +727,21 @@ struct perf_pmu *evsel__find_pmu(const struct
evsel *evsel)
       legacy_core_type =3D
               evsel->core.attr.type =3D=3D PERF_TYPE_HARDWARE ||
               evsel->core.attr.type =3D=3D PERF_TYPE_HW_CACHE;
-       if (!pmu && legacy_core_type) {
-               if (perf_pmus__supports_extended_type()) {
-                       u32 type =3D evsel->core.attr.config >>
PERF_PMU_TYPE_SHIFT;
+       if (!pmu && legacy_core_type && perf_pmus__supports_extended_type()=
) {
+               u32 type =3D evsel->core.attr.config >> PERF_PMU_TYPE_SHIFT=
;

-                       pmu =3D perf_pmus__find_by_type(type);
-               } else {
-                       pmu =3D perf_pmus__find_core_pmu();
-               }
+               pmu =3D perf_pmus__find_by_type(type);
+       }
+       if (!pmu && (legacy_core_type || evsel->core.attr.type =3D=3D
PERF_TYPE_RAW)) {
+               /*
+                * For legacy events, if there was no extended type info th=
en
+                * assume the PMU is the first core PMU.
+                *
+                * On architectures like ARM there is no sysfs PMU with typ=
e
+                * PERF_TYPE_RAW, assume the RAW events are going to be han=
dled
+                * by the first core PMU.
+                */
+               pmu =3D perf_pmus__find_core_pmu();
       }
       ((struct evsel *)evsel)->pmu =3D pmu;
       return pmu;
```
which handles both the case that the extended type was missing on
hybrid/BIG.little and the ARM raw type problem.

Thanks,
Ian

>         if (!pmu && legacy_core_type) {
>                 if (perf_pmus__supports_extended_type()) {
>                         u32 type =3D evsel->core.attr.config >> PERF_PMU_=
TYPE_SHIFT;
> --
> 2.49.0.987.g0cc8ee98dc-goog
>
