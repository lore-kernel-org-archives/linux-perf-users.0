Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26C991591E3
	for <linux-perf-users@vger.kernel.org>; Wed,  5 Mar 2025 19:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741202586; cv=none; b=sdWnDriP3yjwZ7GZeFbUdApO4FLzEOVGiaUm3TV4L+SkJ7worMImh89ctV/eq9L4UVirfwEVByJI36ZM59MT64ASywdR/v1OrDk4kpufvhXK2RfcU6EOjEfjOaDOEuGo4gvFJJwPrHY+NuKbHIgleNb67x75VL36G/SQGsT0CS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741202586; c=relaxed/simple;
	bh=u9bmhx1yHi5hXoDwtEMkKLqFy6j05cYMYLINTzYnCnc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=J3LJqrlDrg94D3xZ3hl/WijJemk0Li8KhJSsK1WtktruwnAp9I6DudCizwgyhh5dJnMqeb3zx/wMP8zi4etmZww6X8dubOmOg6PCKAu15Z0s+E1jmq+3DXXHQr79Ux4DIzpbZJjGq3Hqwej/ngC1CCCNhGBZtKf4GmeyURDjAvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qopDXm1s; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qopDXm1s"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-223a0da61easo21825ad.0
        for <linux-perf-users@vger.kernel.org>; Wed, 05 Mar 2025 11:23:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741202584; x=1741807384; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LGyJKu/nD+Qnf5N+NTMUyE4lAVhr8I4DP7eKOo06iYc=;
        b=qopDXm1sX6qzmgDADFtyPi/SOhsNWG1SoI8FwQf1GD9UVS48qCYz4mAZKnIpejlOlD
         jMdRlyKYSNdSCHJ1iZw/lh1EX1ihxH7zOCYzMzsjMgQVqxDEWufasi3URP41V5kJd3kO
         jd8Xb1UgKNp9YNAUFuBx7J76G3r/PzmGG5EKi/Fi7t0Ob9zrhp2IQG2MdZwS7y5YVhQ3
         jYAn9iRP1sgpZrRX2MzcqUDSXIXKB7s6s5LHmZgN5iE5FOInTKdGCS9d/0KDmeHxnG1L
         GxUYYCKYUA0DVeSv8FA4v9YEVGqG04bQx4sYdFTzsW5RXcRmaBZ4Z40JdNK8gMky3OdS
         UUUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741202584; x=1741807384;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LGyJKu/nD+Qnf5N+NTMUyE4lAVhr8I4DP7eKOo06iYc=;
        b=cYPhKsc36brX/Xt/JPENo/nM5mtR7mOhAvSOGBpZf+DZyK7KC5WeMmaSpLhruFaUbi
         qAwl8hQeF8+mR5VGhJrbAcSFWm/c0Qe7yv04Q7hWg+Kl7+aS9zihx7ebQEF+M4Eutlm1
         aNzyA9UIXioYcJkgRPAHAy64kzqS2pQ+Ag+P55WYLrgjwPzOlcm2F9A9zIzsdA/CRm8x
         HDNoeI+jYIhsIiNy4lBj3Y77RjmXVjf1q6FL5OaMTzSSjAd6eXK6TylBoyHouip5hnOh
         i0UkxF5P+9hl9VXiuUjE0sIrOUywXhKLGfK+sx5S7jGMpHQDWXGQPQxxm89Puc0DrJWN
         XRjQ==
X-Forwarded-Encrypted: i=1; AJvYcCXq5Ri9fTTt26E8+Ew0TcPvbZiNTc44ln6+W1BqMflhe+IO+hQ6Z8W3bLUAgsWqG3d1JtvWFBLNbRWfByWORfWu@vger.kernel.org
X-Gm-Message-State: AOJu0YxNCuTV2vsDSRJbMV37FPd/V3wJrLkssD12lyliocIp4/7kinQS
	CVmPz0bpvRNyv0OZGRfyRfhH6YHIlnSnUoOKZkXf+NBiLgxIBJtWGW8YaRWDjNz4M0HNkonJUpN
	ZJnBQlaksLKBBDaCg1M/3W3gpNlHTXJ1yLYdh
X-Gm-Gg: ASbGnctoIERnk4uCIsU9OH+yGZdB8AVzauZNOhySq5xZVBkGKdMM3l3S6ATPCMYWfGH
	uyviqow4GyHRe4JUV6/+IoAA1LcNQDSpkhw6FX0usR2XXzBBW3SYJ4esB3vrSIGlJL9b5Ld8BWE
	P+qquOiWPTWyqkMOsFsMhLVadpjmEvoIsXp3O++bB64w9vuQjvG0Qi7mw=
X-Google-Smtp-Source: AGHT+IEO7wzY0By+C1nypMF3yAchYa0V90ZDe2pSWoIuySujENNQdXsNBn0UqC+ZNzGUmzLGqKsUMXJZ90xEb9bHD7c=
X-Received: by 2002:a17:902:d481:b0:220:c905:689f with SMTP id
 d9443c01a7336-2240b626059mr117635ad.25.1741202584090; Wed, 05 Mar 2025
 11:23:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250305163935.1605312-1-thomas.falcon@intel.com>
In-Reply-To: <20250305163935.1605312-1-thomas.falcon@intel.com>
From: Ian Rogers <irogers@google.com>
Date: Wed, 5 Mar 2025 11:22:53 -0800
X-Gm-Features: AQ5f1JohZr7JNZCeP4T_8zyJCiixX7hgqXkMKA_FZqWI4pdVtM_nR5v_7c5EuY0
Message-ID: <CAP-5=fUb0yhDHKxsMjqYTtJUfA-Me7kFHE66XRxQ+-OUSGsmLQ@mail.gmail.com>
Subject: Re: [PATCH v6] perf script: Fix output type for dynamically allocated
 core PMU's
To: Thomas Falcon <thomas.falcon@intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	Kan Liang <kan.liang@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 5, 2025 at 8:39=E2=80=AFAM Thomas Falcon <thomas.falcon@intel.c=
om> wrote:
>
> This patch was originally posted here:
>
> https://lore.kernel.org/all/20241213215421.661139-1-thomas.falcon@intel.c=
om/
>
> I have rebased on top of Arnaldo's patch here:
>
> https://lore.kernel.org/all/Z2XCi3PgstSrV0SE@x1/
>
> The original commit message:
> "
> perf script output may show different fields on different core PMU's
> that exist on heterogeneous platforms. For example,
>
> perf record -e "{cpu_core/mem-loads-aux/,cpu_core/event=3D0xcd,\
> umask=3D0x01,ldlat=3D3,name=3DMEM_UOPS_RETIRED.LOAD_LATENCY/}:upp"\
> -c10000 -W -d -a -- sleep 1
>
> perf script:
>
> chromium-browse   46572 [002] 544966.882384:      10000         cpu_core/=
MEM_UOPS_RETIRED.LOAD_LATENCY/: 7ffdf1391b0c     10268100142 \
>  |OP LOAD|LVL L1 hit|SNP None|TLB L1 or L2 hit|LCK No|BLK    N/A    5   7=
    0   7fad7c47425d [unknown] (/usr/lib64/libglib-2.0.so.0.8000.3)
>
> perf record -e cpu_atom/event=3D0xd0,umask=3D0x05,ldlat=3D3,\
> name=3DMEM_UOPS_RETIRED.LOAD_LATENCY/upp -c10000 -W -d -a -- sleep 1
>
> perf script:
>
> gnome-control-c  534224 [023] 544951.816227:      10000 cpu_atom/MEM_UOPS=
_RETIRED.LOAD_LATENCY/:   7f0aaaa0aae0  [unknown] (/usr/lib64/libglib-2.0.s=
o.0.8000.3)
>
> Some fields, such as data_src, are not included by default.
>
> The cause is that while one PMU may be assigned a type such as
> PERF_TYPE_RAW, other core PMU's are dynamically allocated at boot time.
> If this value does not match an existing PERF_TYPE_X value,
> output_type(perf_event_attr.type) will return OUTPUT_TYPE_OTHER.
>
> Instead search for a core PMU with a matching perf_event_attr type
> and, if one is found, return PERF_TYPE_RAW to match output of other
> core PMU's.
> "
>
> Suggested-by: Kan Liang <kan.liang@intel.com>
> Suggested-by: Ian Rogers <irogers@google.com>
> Signed-off-by: Thomas Falcon <thomas.falcon@intel.com>

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
> v2: restrict pmu lookup to platforms with more than one core pmu
> v3: only scan core pmu list
> v4: rebase on top of Arnaldo's patch
> v5: update based on Namhyung's feedback here
> https://lore.kernel.org/lkml/Z8YcOidenzGofq7R@google.com/
> v6: update based on Ian's feedback here
> https://lore.kernel.org/linux-perf-users/CAP-5=3DfVwrG5ZViysO7qKYUw0326WF=
fa7nOzwe70drYfHq=3DAXhA@mail.gmail.com/
> ---
>
>  tools/perf/builtin-script.c | 16 +++++++++++++---
>  1 file changed, 13 insertions(+), 3 deletions(-)
>
> diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
> index d797cec4f054..253c4ca395e1 100644
> --- a/tools/perf/builtin-script.c
> +++ b/tools/perf/builtin-script.c
> @@ -400,10 +400,20 @@ static inline int output_type(unsigned int type)
>
>  static inline int evsel__output_type(struct evsel *evsel)
>  {
> -       if (evsel->script_output_type =3D=3D OUTPUT_TYPE_UNSET)
> -               evsel->script_output_type =3D output_type(evsel->core.att=
r.type);
> +       int type =3D evsel->script_output_type;
>
> -       return evsel->script_output_type;
> +       if (type =3D=3D OUTPUT_TYPE_UNSET) {
> +               type =3D output_type(evsel->core.attr.type);
> +               if (type =3D=3D OUTPUT_TYPE_OTHER) {
> +                       struct perf_pmu *pmu =3D evsel__find_pmu(evsel);
> +
> +                       if (pmu && pmu->is_core)
> +                               type =3D PERF_TYPE_RAW;
> +               }
> +               evsel->script_output_type =3D type;
> +       }
> +
> +       return type;
>  }
>
>  static bool output_set_by_user(void)
> --
> 2.48.1
>
