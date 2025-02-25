Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0140B2AF1E
	for <linux-perf-users@vger.kernel.org>; Tue, 25 Feb 2025 17:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740504011; cv=none; b=uJL0wlgXM9cwZ3pp23n9N0DrNVe4vY5I3nCJJ841mVAIL2Z/5Kwsato3/ykuBI7Fb5wlrGkO9R3afnkxmRiVERuFs4u7Jr/wrIcEkUBHbwXLHHt7lzuQNgMI8zgRLfRzid+r5mtJ7ykCIOmkdrQr3mSnCUmG5l8pft6NZWjq7rQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740504011; c=relaxed/simple;
	bh=nYvvvyUkn/NQrJXuHQOgg478+Z6m4uibxctBKt7VFgw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HGOYKe+hBJONYbiTfzo72Iy+e3Oce8l6K7IA2KrSaaIdRT9begL5a90ddXWWydIY1bgBEL//UM2H++C9kVkLW3pmQVQoMG8LVd6p/fqob6eM50/mvHP1kaSMGn5q0CNdZLlrgoJKqbwbN57RqpshZJ/7Vyled+0UJpdx3IQrxgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XGg6yrSf; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XGg6yrSf"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-22117c396baso204965ad.1
        for <linux-perf-users@vger.kernel.org>; Tue, 25 Feb 2025 09:20:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740504009; x=1741108809; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7hb3C7FYdDqsPYEBoq2vFVVUt+W47wHJYO2+QU2YKUI=;
        b=XGg6yrSf1XFnff7d1MLBOdtGFNlqkjY65nJ1acePMU+/LwJjxWjc7IQZ/pIpylvdng
         7Scl1WQECEZw5c8g5EzpASnVxwVSZUy0Y2cMr7yWYcFucGXk2XT2D8rGY5RauCJla2Dj
         F5waNjKbm8E0VGk2XTsPtkL0MVRx9RiXbuZ6dRsyA6tVa/TjIL+IbLfqQcg8sCUcdr3R
         6SYwvAKa4vJFtVsqlVGDicH3QZO+qQPf2Y7D6TTZ5t7uks+0qLDpgmclEo2tyP1qsFM9
         5qLSBAv19l9qUik8+i9krmpjfONavgGJG2a6ZzJXKeA2oyKFgCnk3Sfb30oj4SGLUAYj
         C/Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740504009; x=1741108809;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7hb3C7FYdDqsPYEBoq2vFVVUt+W47wHJYO2+QU2YKUI=;
        b=U1s3Dc2/2niTGxVRdfXpsjCcQInb1pth0X1o3lwodso+n0y2Ok0QxBqxGV7aGJe+Bi
         SrDCWsHSJpKqwVJmf2JVc21XRUiRji38WuJ85by4hpKldRAVdNNhvEGVdCAq+7gfZRLm
         KefT+XYiTljk6Yt6qhBqi+tiLd2CaQnCNn+ZZF79dfLcx9g8R23/qs4KrkymdswgRdnZ
         y6p/yMRcCtk7GHYD3ew2bXmlAdUhxu/NnNUsTyRxIbiIEcJABmwluVqAvopAzZRi6aFu
         RDxNVa/aOQrwWkeT9EmHompyUKa9jUPXmGD3mxkPk8UT9nOfXBSHkJwBJYMgr7dBjF26
         1fFQ==
X-Gm-Message-State: AOJu0Yx/xvo4AXi2fSKAvROdzjW6+eVE7ezawzkI1iVtg34rYej40Ot1
	RN7PP526MkE68aQsI6WFebBxQ4VTa/taBjDc4VqnXkNFKBWRDc4xGukuW749FGd6fSIm663Q7JV
	+GhU7HKNp644KYl3XAJurEnKvi1IFHdTFWV3z
X-Gm-Gg: ASbGncuxcE+FQqx52BkGmPvaf611m5INrYlAmrdgTa/dLZMiWK/4YZuLMIo3DRetrL5
	VvBXIVMUOoKpijF7Mnjrpo5kprKkJAkFQPWKRa6GYK+Ddw616Kz3cRF/u5Zb5RtDLV+gyWJTuAW
	HlvIqJuGoVbnVtFHRryF/tMb4p7bCOmPLjky8=
X-Google-Smtp-Source: AGHT+IGpsu2gE6OHJh6wFHMikBC+V7A4sdMucnJSErx5tMIoel4ur2peTYL89qPCpXByYo8PvF55LuvZuIZemHPc5Wc=
X-Received: by 2002:a17:902:ce05:b0:21b:b3b3:ef5f with SMTP id
 d9443c01a7336-22307a973d5mr3609785ad.22.1740504008965; Tue, 25 Feb 2025
 09:20:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250225164639.522741-1-james.clark@linaro.org> <20250225164639.522741-2-james.clark@linaro.org>
In-Reply-To: <20250225164639.522741-2-james.clark@linaro.org>
From: Ian Rogers <irogers@google.com>
Date: Tue, 25 Feb 2025 09:19:57 -0800
X-Gm-Features: AWEUYZnYh0D9XwWJZPJZL4jHRJTeBa1LnRgouzF4MQP99jNCAKe6CUlFHsXbSU8
Message-ID: <CAP-5=fW1NkeZjBpNijV1oKNjZ_F480wahmUPfEN9vrxYjwD=9A@mail.gmail.com>
Subject: Re: [PATCH 1/3] perf pmu: Dynamically allocate tool PMU
To: James Clark <james.clark@linaro.org>
Cc: linux-perf-users@vger.kernel.org, namhyung@kernel.org, cyy@cyyself.name, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, "Liang, Kan" <kan.liang@linux.intel.com>, 
	Yoshihiro Furudera <fj5100bi@fujitsu.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Weilin Wang <weilin.wang@intel.com>, Junhao He <hejunhao3@huawei.com>, 
	Jean-Philippe Romain <jean-philippe.romain@foss.st.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 25, 2025 at 8:47=E2=80=AFAM James Clark <james.clark@linaro.org=
> wrote:
>
> perf_pmus__destroy() treats all PMUs as allocated and free's them so we
> can't have any static PMUs that are added to the PMU lists. Fix it by
> allocating the tool PMU in the same way as the others. Current users of
> the tool PMU already use find_pmu() and not perf_pmus__tool_pmu(), so
> rename the function to add 'new' to avoid it being misused in the
> future.
>
> perf_pmus__fake_pmu() can remain as static as it's not added to the
> PMU lists.
>
> Fixes the following error:
>
>   $ perf bench internals pmu-scan
>
>   # Running 'internals/pmu-scan' benchmark:
>   Computing performance of sysfs PMU event scan for 100 times
>   munmap_chunk(): invalid pointer
>   Aborted (core dumped)
>
> Fixes: 240505b2d0ad ("perf tool_pmu: Factor tool events into their own PM=
U")
> Signed-off-by: James Clark <james.clark@linaro.org>
> ---
>  tools/perf/util/pmus.c     |  2 +-
>  tools/perf/util/tool_pmu.c | 23 +++++++++++------------
>  tools/perf/util/tool_pmu.h |  2 +-
>  3 files changed, 13 insertions(+), 14 deletions(-)
>
> diff --git a/tools/perf/util/pmus.c b/tools/perf/util/pmus.c
> index 8a0a919415d4..c1815edaca37 100644
> --- a/tools/perf/util/pmus.c
> +++ b/tools/perf/util/pmus.c
> @@ -268,7 +268,7 @@ static void pmu_read_sysfs(unsigned int to_read_types=
)
>
>         if ((to_read_types & PERF_TOOL_PMU_TYPE_TOOL_MASK) !=3D 0 &&
>             (read_pmu_types & PERF_TOOL_PMU_TYPE_TOOL_MASK) =3D=3D 0) {
> -               tool_pmu =3D perf_pmus__tool_pmu();
> +               tool_pmu =3D perf_pmus__new_tool_pmu();
>                 list_add_tail(&tool_pmu->list, &other_pmus);
>         }
>         if ((to_read_types & PERF_TOOL_PMU_TYPE_HWMON_MASK) !=3D 0 &&
> diff --git a/tools/perf/util/tool_pmu.c b/tools/perf/util/tool_pmu.c
> index 3a68debe7143..45eae810b205 100644
> --- a/tools/perf/util/tool_pmu.c
> +++ b/tools/perf/util/tool_pmu.c
> @@ -490,17 +490,16 @@ int evsel__tool_pmu_read(struct evsel *evsel, int c=
pu_map_idx, int thread)
>         return 0;
>  }
>
> -struct perf_pmu *perf_pmus__tool_pmu(void)
> +struct perf_pmu *perf_pmus__new_tool_pmu(void)
>  {
> -       static struct perf_pmu tool =3D {
> -               .name =3D "tool",
> -               .type =3D PERF_PMU_TYPE_TOOL,
> -               .aliases =3D LIST_HEAD_INIT(tool.aliases),
> -               .caps =3D LIST_HEAD_INIT(tool.caps),
> -               .format =3D LIST_HEAD_INIT(tool.format),
> -       };
> -       if (!tool.events_table)
> -               tool.events_table =3D find_core_events_table("common", "c=
ommon");
> -
> -       return &tool;
> +       struct perf_pmu *tool =3D zalloc(sizeof(struct perf_pmu));
> +
> +       tool->name =3D strdup("tool");
> +       tool->type =3D PERF_PMU_TYPE_TOOL;
> +       INIT_LIST_HEAD(&tool->aliases);
> +       INIT_LIST_HEAD(&tool->caps);
> +       INIT_LIST_HEAD(&tool->format);
> +       tool->events_table =3D find_core_events_table("common", "common")=
;
> +
> +       return tool;
>  }
> diff --git a/tools/perf/util/tool_pmu.h b/tools/perf/util/tool_pmu.h
> index a60184859080..268f05064d03 100644
> --- a/tools/perf/util/tool_pmu.h
> +++ b/tools/perf/util/tool_pmu.h
> @@ -51,6 +51,6 @@ int evsel__tool_pmu_open(struct evsel *evsel,
>                          int start_cpu_map_idx, int end_cpu_map_idx);
>  int evsel__tool_pmu_read(struct evsel *evsel, int cpu_map_idx, int threa=
d);
>
> -struct perf_pmu *perf_pmus__tool_pmu(void);
> +struct perf_pmu *perf_pmus__new_tool_pmu(void);

I think for consistency this should be "tool_pmu__new" although pmus
have odd function names like "lookup" which is basically "new". I was
trying to be smart by avoiding the allocation, but I also don't think
it matters and correct is more important. Thanks for doing this.

Reviewed-by: Ian Rogers <irogers@google.com>

Ian

>
>  #endif /* __TOOL_PMU_H */
> --
> 2.34.1
>
