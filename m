Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C01DB288510
	for <linux-perf-users@vger.kernel.org>; Fri, 14 Nov 2025 17:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763143196; cv=none; b=B6h9QpTASXk9WLCKqG+vHCDoFMKQgqCR1e2bfU0DzX6keHJnC5PtDyFmqvznT19XMSTvHYGg0teWY2GO2I0oDIQLVxe4iSXuStqYadERewiA+MEuAwBLSjAtvbXRAC5+B10NPRwvxEi0LupGNhJ5zdc+FUe8eVIH9XT658FbXLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763143196; c=relaxed/simple;
	bh=Cw6qxmczOBtjGx4DkVrvtjI/ghiH5sN9K487qsbXLAE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YugRQwVwjCWjm5G9/DdvA63Eg6xhRN3uP/GtS7XCTwUsVCWx+9CSVvR7fW3ZMqwSs3CC63VXJZuVnemFwXi7EmYxOS5hbQkuFnmJq5hPZkkq3NTYNxCbtUsCbJshEHvMZ6fy9ys98Im1QE7hE0aQOE3phBFL0hdg9tluoiRxgvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KJFoi7uG; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KJFoi7uG"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-29852dafa7dso5875ad.1
        for <linux-perf-users@vger.kernel.org>; Fri, 14 Nov 2025 09:59:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1763143194; x=1763747994; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rFs1Tgz7Om+YCRWu/Qc6dsqfHMLqNVyPGHU+20R041g=;
        b=KJFoi7uGFvVargq93enyDgjXbjRCdpwpcAc3c+rqdbgHtT1ZC41kOBfmJ4J+J3UYLw
         +1h3tXZYxVJuhAiHCo+mr70OwTPIm41Ji83xftzksWhDqE2eghCqqBIs/8FW3Q2T61h2
         hAQIpKkAq5hwC5VzOTOCVpZ7dsyOU39tZ5xIwUQMOCsxcBnDW52bb++/eS9G7fKAMvN5
         3ET6z/7uOIsnMGn9ipyfRJx/uhqBtAr2UHyuJypQnAhMEctM6LSeR1AfzTmMSx/FunBd
         FKH7NNxDP1dulz49wxEVK3CbTFxL5MBt4sc7Gwo1eobWtA4tLRfjw//T0JDbOejR4u0I
         RPFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763143194; x=1763747994;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rFs1Tgz7Om+YCRWu/Qc6dsqfHMLqNVyPGHU+20R041g=;
        b=BPvRh+AhMVlmGsAAOOyp1bY5D5bGMmEw1plMzWIyzIZ5Srwyiz30nGmQD06PrRTcj8
         btsIn/YWVTZSGB6IqRNOd9ToAVX/gYBKnmgXUwr/rXHBIsodc5ONOyiS/Z4emhIl4w5p
         vwTpTRGLx/djTrWmWCfXd41efaXD2DFBHWPtPPHbycMz/4PnJmvNXmMv/7gcy8bs6sst
         YRI42gjxBrPUCzKrapVQ37BdUoJvXsffKqiePpEgENBvPbMSJFhoG/Rb8FpjX32kHZqC
         WdgokmNHGCGSyj3fNlvCMkurOT8zgJVASCOewUA5rvHyMZkJv9exgEOgUtNENXoj4dtb
         VKkg==
X-Forwarded-Encrypted: i=1; AJvYcCV8y1SiCclQobZDiC7O8xsbS4GpT/bSEMGYpoGbJ++fd5bKjQoKdh229JMrszzyI5D1LLFor/SqJvCZrGIJN/ds@vger.kernel.org
X-Gm-Message-State: AOJu0Yws8Ko3pOi1PoHNZXVJBx6XunNf3Gz2rJkIXqefGnfT08fXwK1x
	4NvoNtf2S+3nGxI5fyQIt33zPmJNUg9IXwjw6+Eigj6OC0EcDlSiDa8WCFA/kJ7gh3Tt+ZiEe7V
	v5oNQF9R8Nrra7/Zq8OCBYpSlhNgL8hbD2nq12PC+
X-Gm-Gg: ASbGnctRLlhj4D2L4jCThNJqD2tLJ+tGMu2+yjwbMvBzhJRx6a2U5q9Q2WAMDiYAqEE
	JbNGTBGs6HToH/q/McboveC06ZleJdBCyisKLMNRrhWntcHxapu/JpYsgWyYc3q623B+E2iAP+3
	YXDnukz2lCU9GxHzLaNS84IWmZ5+sutb7ypPUWJV9/1c2vb24QV5BoXpOyp4zpBnNKXCwCKCglE
	9K4JfqcfGCDim1d0Yx6HheXdbFWy99xO5LONXygmjJDg8g/f7Qy/dklUBF6SSwMMZWSvSCZGBdu
	tRXhAT8ZTUrMqrHRwUN9zFdJ
X-Google-Smtp-Source: AGHT+IEzUeI+VY0zMEN7UcqbNHe0sK+H2r+ZKl8kVnLq3hYDiX4YBfgNtpLogWP2CnJapaXQ/GLpf8no1E8FDQrc1yM=
X-Received: by 2002:a17:902:c40f:b0:294:ecba:c8e with SMTP id
 d9443c01a7336-2986be9a2c4mr3844205ad.3.1763143193805; Fri, 14 Nov 2025
 09:59:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251114070018.160330-1-namhyung@kernel.org> <20251114070018.160330-4-namhyung@kernel.org>
In-Reply-To: <20251114070018.160330-4-namhyung@kernel.org>
From: Ian Rogers <irogers@google.com>
Date: Fri, 14 Nov 2025 09:59:42 -0800
X-Gm-Features: AWmQ_bkMk-AqZb_TlcD73ABbPpIWPPOwCEAI-lW9ktk0BGKzZy8t0GE3ILV86Ds
Message-ID: <CAP-5=fVEuYXw+P-+Z7bU7Z-+7dsHPPfABh5pdnPtfvH-23u4Qw@mail.gmail.com>
Subject: Re: [PATCH v3 3/5] perf record: Enable defer_callchain for user callchains
To: Namhyung Kim <namhyung@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, James Clark <james.clark@linaro.org>, 
	Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org, 
	Steven Rostedt <rostedt@goodmis.org>, Josh Poimboeuf <jpoimboe@kernel.org>, 
	Indu Bhagat <indu.bhagat@oracle.com>, Jens Remus <jremus@linux.ibm.com>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, linux-trace-kernel@vger.kernel.org, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 13, 2025 at 11:01=E2=80=AFPM Namhyung Kim <namhyung@kernel.org>=
 wrote:
>
> And add the missing feature detection logic to clear the flag on old
> kernels.
>
>   $ perf record -g -vv true
>   ...
>   ------------------------------------------------------------
>   perf_event_attr:
>     type                             0 (PERF_TYPE_HARDWARE)
>     size                             136
>     config                           0 (PERF_COUNT_HW_CPU_CYCLES)
>     { sample_period, sample_freq }   4000
>     sample_type                      IP|TID|TIME|CALLCHAIN|PERIOD
>     read_format                      ID|LOST
>     disabled                         1
>     inherit                          1
>     mmap                             1
>     comm                             1
>     freq                             1
>     enable_on_exec                   1
>     task                             1
>     sample_id_all                    1
>     mmap2                            1
>     comm_exec                        1
>     ksymbol                          1
>     bpf_event                        1
>     defer_callchain                  1
>     defer_output                     1
>   ------------------------------------------------------------
>   sys_perf_event_open: pid 162755  cpu 0  group_fd -1  flags 0x8
>   sys_perf_event_open failed, error -22
>   switching off deferred callchain support
>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---
>  tools/perf/util/evsel.c | 24 ++++++++++++++++++++++++
>  tools/perf/util/evsel.h |  1 +
>  2 files changed, 25 insertions(+)
>
> diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
> index 244b3e44d090d413..f5652d00b457d096 100644
> --- a/tools/perf/util/evsel.c
> +++ b/tools/perf/util/evsel.c
> @@ -1061,6 +1061,14 @@ static void __evsel__config_callchain(struct evsel=
 *evsel, struct record_opts *o
>                 }
>         }
>
> +       if (param->record_mode =3D=3D CALLCHAIN_FP && !attr->exclude_call=
chain_user) {
> +               /*
> +                * Enable deferred callchains optimistically.  It'll be s=
witched
> +                * off later if the kernel doesn't support it.
> +                */
> +               attr->defer_callchain =3D 1;
> +       }

If a user has requested frame pointer call chains why would they want
deferred call chains? The point of deferral to my understanding is to
allow the paging in of debug data, but frame pointers don't need that
as the stack should be in the page cache.

Is this being done for code coverage reasons so that deferral is known
to work for later addition of SFrames? In which case this should be an
opt-in not default behavior. When there is a record_mode of
CALLCHAIN_SFRAME then making deferral the default for that mode makes
sense, but not for frame pointers IMO.

Thanks,
Ian

> +
>         if (function) {
>                 pr_info("Disabling user space callchains for function tra=
ce event.\n");
>                 attr->exclude_callchain_user =3D 1;
> @@ -1511,6 +1519,7 @@ void evsel__config(struct evsel *evsel, struct reco=
rd_opts *opts,
>         attr->mmap2    =3D track && !perf_missing_features.mmap2;
>         attr->comm     =3D track;
>         attr->build_id =3D track && opts->build_id;
> +       attr->defer_output =3D track;
>
>         /*
>          * ksymbol is tracked separately with text poke because it needs =
to be
> @@ -2199,6 +2208,10 @@ static int __evsel__prepare_open(struct evsel *evs=
el, struct perf_cpu_map *cpus,
>
>  static void evsel__disable_missing_features(struct evsel *evsel)
>  {
> +       if (perf_missing_features.defer_callchain && evsel->core.attr.def=
er_callchain)
> +               evsel->core.attr.defer_callchain =3D 0;
> +       if (perf_missing_features.defer_callchain && evsel->core.attr.def=
er_output)
> +               evsel->core.attr.defer_output =3D 0;
>         if (perf_missing_features.inherit_sample_read && evsel->core.attr=
.inherit &&
>             (evsel->core.attr.sample_type & PERF_SAMPLE_READ))
>                 evsel->core.attr.inherit =3D 0;
> @@ -2473,6 +2486,13 @@ static bool evsel__detect_missing_features(struct =
evsel *evsel, struct perf_cpu
>
>         /* Please add new feature detection here. */
>
> +       attr.defer_callchain =3D true;
> +       if (has_attr_feature(&attr, /*flags=3D*/0))
> +               goto found;
> +       perf_missing_features.defer_callchain =3D true;
> +       pr_debug2("switching off deferred callchain support\n");
> +       attr.defer_callchain =3D false;
> +
>         attr.inherit =3D true;
>         attr.sample_type =3D PERF_SAMPLE_READ | PERF_SAMPLE_TID;
>         if (has_attr_feature(&attr, /*flags=3D*/0))
> @@ -2584,6 +2604,10 @@ static bool evsel__detect_missing_features(struct =
evsel *evsel, struct perf_cpu
>         errno =3D old_errno;
>
>  check:
> +       if ((evsel->core.attr.defer_callchain || evsel->core.attr.defer_o=
utput) &&
> +           perf_missing_features.defer_callchain)
> +               return true;
> +
>         if (evsel->core.attr.inherit &&
>             (evsel->core.attr.sample_type & PERF_SAMPLE_READ) &&
>             perf_missing_features.inherit_sample_read)
> diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
> index 3ae4ac8f9a37e009..a08130ff2e47a887 100644
> --- a/tools/perf/util/evsel.h
> +++ b/tools/perf/util/evsel.h
> @@ -221,6 +221,7 @@ struct perf_missing_features {
>         bool branch_counters;
>         bool aux_action;
>         bool inherit_sample_read;
> +       bool defer_callchain;
>  };
>
>  extern struct perf_missing_features perf_missing_features;
> --
> 2.52.0.rc1.455.g30608eb744-goog
>
>
