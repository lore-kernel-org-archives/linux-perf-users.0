Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oMBJrDF6"
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BD47D53
	for <linux-perf-users@vger.kernel.org>; Wed,  6 Dec 2023 13:10:13 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-54c77d011acso558a12.1
        for <linux-perf-users@vger.kernel.org>; Wed, 06 Dec 2023 13:10:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701897011; x=1702501811; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rR6PmYpLoQQwd7Yn/K5AiEO5B6HQDzrP/5ZRahh2WQc=;
        b=oMBJrDF6jNfjny6Em5lqTsNIJjtcH0X+UjDYpgs91ZIQbZADkqAJoGIln7QvfM+hx9
         JQavmXMxrnumV3/0e2da/RlKY4ss2+JZuSQbPHAx1NZQGfJ7vZkI6uRoolXECFZVQKbA
         chHA0Ve+t5XcKA2uzJPn5VJjsjyp/9KYqsTF7WlkHhp6onJ8yaLTdWgXYko1P3U4JuSI
         0aSkK5waoGubJl48AqBQVV9mZAeIps+ynzKvemzOyng3P5FmayCvlEPXbOCUDzlzAvsS
         v4YcILSY2/E2hoixOIvGrH5fjImvKPTF0YGpKNkparfbfKATh/asm2wk5h6L3CT0oYn3
         ofEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701897011; x=1702501811;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rR6PmYpLoQQwd7Yn/K5AiEO5B6HQDzrP/5ZRahh2WQc=;
        b=jmchvuBxC6I+GtgJpBC/z/kVDonYXNGvfK8l9qPtLUdZrLxji3SozD/ANqhgzJSPyJ
         DCOrJme51wbeHsUiHb6hZhXbNVCMljM9Jj2GI0LBAjVeEg2UORNjJxMNmJJIZlOyneLa
         XOAdeIgdTYZ4gTRQWMBFSkvk7Vk2Kv4MvMDqcUBqA4ve+wU1OrjxC/RaMIJD89eh8RAW
         v7UJ4ZjWzofPNHydCuJ/dHrdvn65XDHVe/8TXNStnJv4Y3wHaFtXPKAN/j4ePaDBVlZM
         fOIIGGwCoPCbg2ZZFyXjvfPFoEhN6xFhR3QJX0LGBpnMZjhHftL0qWmenrv1niSwYAA9
         LSkA==
X-Gm-Message-State: AOJu0YzWDcuESlIa8iifGx1ZpD+ByfCmvsxrDtsWlgeI3BvF/5lI9kFj
	mOREoWfD/mDC73/WJlbakVCsvtHFNff6/B1xlfFxow==
X-Google-Smtp-Source: AGHT+IH/qqFgN7rzfKUUGpHROf4+3kCLyc+pplhikMj0x5yki0zwTjZwlNpMWdyGhWPWj5uDqyHfCkQR/ldLSOOMnQw=
X-Received: by 2002:a50:d744:0:b0:543:fb17:1a8 with SMTP id
 i4-20020a50d744000000b00543fb1701a8mr108621edj.3.1701897011428; Wed, 06 Dec
 2023 13:10:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231206201324.184059-1-kan.liang@linux.intel.com> <20231206201324.184059-6-kan.liang@linux.intel.com>
In-Reply-To: <20231206201324.184059-6-kan.liang@linux.intel.com>
From: Ian Rogers <irogers@google.com>
Date: Wed, 6 Dec 2023 13:10:00 -0800
Message-ID: <CAP-5=fXtAKnvnubkqTUPdY9P98FqE5B9m3N+hRzRvPkvK3WS2w@mail.gmail.com>
Subject: Re: [PATCH 5/6] perf mem: Clean up is_mem_loads_aux_event()
To: kan.liang@linux.intel.com
Cc: acme@kernel.org, peterz@infradead.org, mingo@redhat.com, 
	namhyung@kernel.org, jolsa@kernel.org, adrian.hunter@intel.com, 
	john.g.garry@oracle.com, will@kernel.org, james.clark@arm.com, 
	mike.leach@linaro.org, leo.yan@linaro.org, yuhaixin.yhx@linux.alibaba.com, 
	renyu.zj@linux.alibaba.com, tmricht@linux.ibm.com, ravi.bangoria@amd.com, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 6, 2023 at 12:13=E2=80=AFPM <kan.liang@linux.intel.com> wrote:
>
> From: Kan Liang <kan.liang@linux.intel.com>
>
> The aux_event can be retrieved from the perf_pmu now. Implement a
> generic support.
>
> Signed-off-by: Kan Liang <kan.liang@linux.intel.com>

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/arch/x86/util/mem-events.c | 13 -------------
>  tools/perf/util/mem-events.c          | 14 ++++++++++++--
>  2 files changed, 12 insertions(+), 15 deletions(-)
>
> diff --git a/tools/perf/arch/x86/util/mem-events.c b/tools/perf/arch/x86/=
util/mem-events.c
> index b776d849fc64..71ffe16de751 100644
> --- a/tools/perf/arch/x86/util/mem-events.c
> +++ b/tools/perf/arch/x86/util/mem-events.c
> @@ -28,16 +28,3 @@ struct perf_mem_event perf_mem_events_amd[PERF_MEM_EVE=
NTS__MAX] =3D {
>         E(NULL,         NULL,           NULL,   false,  0),
>         E("mem-ldst",   "%s//",         NULL,   false,  0),
>  };
> -
> -bool is_mem_loads_aux_event(struct evsel *leader)
> -{
> -       struct perf_pmu *pmu =3D perf_pmus__find("cpu");
> -
> -       if (!pmu)
> -               pmu =3D perf_pmus__find("cpu_core");
> -
> -       if (pmu && !perf_pmu__have_event(pmu, "mem-loads-aux"))
> -               return false;
> -
> -       return leader->core.attr.config =3D=3D MEM_LOADS_AUX;
> -}
> diff --git a/tools/perf/util/mem-events.c b/tools/perf/util/mem-events.c
> index 9ea9e9a868c4..336d1109b3a5 100644
> --- a/tools/perf/util/mem-events.c
> +++ b/tools/perf/util/mem-events.c
> @@ -103,9 +103,19 @@ static const char *perf_mem_events__name(int i, stru=
ct perf_pmu *pmu)
>         return NULL;
>  }
>
> -__weak bool is_mem_loads_aux_event(struct evsel *leader __maybe_unused)
> +bool is_mem_loads_aux_event(struct evsel *leader)
>  {
> -       return false;
> +       struct perf_pmu *pmu =3D leader->pmu;
> +       struct perf_mem_event *e;
> +
> +       if (!pmu || !pmu->mem_events)
> +               return false;
> +
> +       e =3D &pmu->mem_events[PERF_MEM_EVENTS__LOAD];
> +       if (!e->aux_event)
> +               return false;
> +
> +       return leader->core.attr.config =3D=3D e->aux_event;
>  }
>
>  int perf_mem_events__parse(struct perf_pmu *pmu, const char *str)
> --
> 2.35.1
>
