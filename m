Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15F1A1E5714
	for <linux-perf-users@vger.kernel.org>; Wed, 19 Nov 2025 16:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763571023; cv=none; b=GGWSSXFx9yEiYN/AoA9DRHbnWaer4zYQOI5OO2/Nw7aq6ULE1tLxNDZiXOgL3R6q1eRDZtXX0GNTKW0tUSgbydwRWx9idjJuZlHuhCDnKo9hVfA48lb3Tz91etinDu7AHIH1D8Hzg53tSlQ9Qsc/eNBRtEi16cH1bnaMnoJmQ74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763571023; c=relaxed/simple;
	bh=O9JFz3qyS53bqmLU9nQY1FOT5EXxDiLOVx9MZNEHaA0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fVRGlRXl6J1ehqMcL7GVC4rPzSQzZl6Hi0HPX0tWebKAQOZJ+uFtS5XW/RVCp/+3RaN3tm/4cQJECWnVtkcNGl05bSMAYgrafUZMJo6e5EX1PJQ9kt1Rma4fW0sneoIqGglWt3VUzSrzgBdAyHv4u3oL6y2SwGdDPOCcsBlZ2sw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=f4Ntf/oO; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="f4Ntf/oO"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-295c64cb951so265235ad.0
        for <linux-perf-users@vger.kernel.org>; Wed, 19 Nov 2025 08:50:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1763571021; x=1764175821; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DQBnHYw0VSBBj4j2L4MqTo6j0WkJfPfTKwzmJoktb9M=;
        b=f4Ntf/oOxqQLW5CsePNSC6nzrd49ZoXGWU7eDGSMNhSLiWvTnXYvcq8cmuEO7SsGiO
         TYqcc7orlMcZea7SzeAaFdk/GDmX7EaA98Bbc6vU4cgTb1D8JGJu7YpwEkV/ZKBccuXf
         iKVzwuv7daIBnYZeMd3OitoHaxDQHPSXvsRN0bvM3PKnakP1vMA/4VC1MOd//PD/StUG
         BqSuFnzK6YlH3MPAuitoIKo7J8x3AAF8233vtrr3xYldyJCHD5IgS+6TrD3Qx2n+WiUY
         NhZSzzvCFTw3GPpPJuVAFuElfbf4fjLCDSXv8X1VxFOGDRp2WnEeEsYXyTKub8s8xmzr
         7OrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763571021; x=1764175821;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=DQBnHYw0VSBBj4j2L4MqTo6j0WkJfPfTKwzmJoktb9M=;
        b=L+jDTMT7c3vrD/rQvH7XepXDojURvh6+3Ye1o8XS9ZWML15LQaebOGlEZK3hoZya07
         hONZkyjbFDO20ykbxNwYpYnUTYHOpZODG+oYlnfDlMDL94THvaEQvH/XLG4gZwjvX2se
         f46Ec1mfuvc1O62B37UKzgtpJUbQ3DLDM4MNo4CFoU8N4VGjbRoZy9+ON13rKs+niQM6
         hoVfcA9PYEycTi564t6ZCyvupJVg4uI96Bw90cICdierOd3ki+mBtWghxsp16Q9/WA2Q
         XsE18HcWZ+0QkQRus7OnTC5B83vZZQdYUISebpiqZ1MElE1sziOhF8MbSklEup83jd0B
         HI4g==
X-Forwarded-Encrypted: i=1; AJvYcCUASUFwI+dVcen1Z+oDoquRf+rE1kTcS9hxY5ph0AAorC81XZVi5awzsk49y21BJ4PKirS+DEasgCjC9eB3CgyE@vger.kernel.org
X-Gm-Message-State: AOJu0Yyz1oHNa3S4tRbHhGaluilVGLEbZdMifllENpiBt3EnrhVMTgGw
	raQa+v5aM/Dt9v6IBeebxAzHkQ8K6t6UZaPgMgkk4rXeJDOTVlWnpOqBePccxR1JKdg/JM4DwPm
	gxsxq766lncPYmt/UB9MFeYO20qUnxenAzpaf+b4q
X-Gm-Gg: ASbGncsBw3k8OcpMZJ8XBwuHSOgtq7raxJqAQ4q/tFa0Ci5TO3r5OIGXAIaluMRIBLu
	3zVcQGgYxDfJqMxbS0rJQ0Mj8Yqq99q5bjavYq8ep7paBwAeqj6JR/CNtiRl4+MMsTjI9AUfdlS
	Laq1oqaWHR7eVRSxvm1M5dO33XMw0MqKtHLY1TfV0Kzs34MDvw0tug/cP47yKEL0QSJNvZFNJxt
	ygHpFuwqUknewl7PsvXYVjKQ4vTnbhPld21PUPTrRdMpIjIPSn8FqduYYFOJ3SPMuT4ulAg4Dyc
	dTpOhMnJg07ofDDuB6JzOfW4hw==
X-Google-Smtp-Source: AGHT+IEICHjk33fXEW+hyxHU8aTmZdnV/O+AHUpf/mOXU8tiARf5WeMbTWR+rSjeKJAnzTruCuAluI0+rTOTjLbj29U=
X-Received: by 2002:a05:7022:6b98:b0:119:e56b:c1dc with SMTP id
 a92af1059eb24-11c8dda9816mr145267c88.7.1763571020624; Wed, 19 Nov 2025
 08:50:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251115234106.348571-1-namhyung@kernel.org> <20251115234106.348571-4-namhyung@kernel.org>
In-Reply-To: <20251115234106.348571-4-namhyung@kernel.org>
From: Ian Rogers <irogers@google.com>
Date: Wed, 19 Nov 2025 08:50:08 -0800
X-Gm-Features: AWmQ_bly3STldTS6YUBz9binx1C6MJzkuz8EvLWSHaE9ZthT7K55gqE8MmJZAdI
Message-ID: <CAP-5=fXX_h8q=0uTGkU89Z_r6Rw30oMfxyJw5p-O45t0OSppJw@mail.gmail.com>
Subject: Re: [PATCH v4 3/5] perf record: Add --call-graph fp,defer option for
 deferred callchains
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

On Sat, Nov 15, 2025 at 3:41=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> Add a new callchain record mode option for deferred callchains.  For now
> it only works with FP (frame-pointer) mode.
>
> And add the missing feature detection logic to clear the flag on old
> kernels.
>
>   $ perf record --call-graph fp,defer -vv true
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

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/Documentation/perf-config.txt |  3 +++
>  tools/perf/Documentation/perf-record.txt |  4 ++++
>  tools/perf/util/callchain.c              | 16 +++++++++++++---
>  tools/perf/util/callchain.h              |  1 +
>  tools/perf/util/evsel.c                  | 19 +++++++++++++++++++
>  tools/perf/util/evsel.h                  |  1 +
>  6 files changed, 41 insertions(+), 3 deletions(-)
>
> diff --git a/tools/perf/Documentation/perf-config.txt b/tools/perf/Docume=
ntation/perf-config.txt
> index c6f33565966735fe..642d1c490d9e3bcd 100644
> --- a/tools/perf/Documentation/perf-config.txt
> +++ b/tools/perf/Documentation/perf-config.txt
> @@ -452,6 +452,9 @@ Variables
>                 kernel space is controlled not by this option but by the
>                 kernel config (CONFIG_UNWINDER_*).
>
> +               The 'defer' mode can be used with 'fp' mode to enable def=
erred
> +               user callchains (like 'fp,defer').
> +
>         call-graph.dump-size::
>                 The size of stack to dump in order to do post-unwinding. =
Default is 8192 (byte).
>                 When using dwarf into record-mode, the default size will =
be used if omitted.
> diff --git a/tools/perf/Documentation/perf-record.txt b/tools/perf/Docume=
ntation/perf-record.txt
> index 067891bd7da6edc8..e8b9aadbbfa50574 100644
> --- a/tools/perf/Documentation/perf-record.txt
> +++ b/tools/perf/Documentation/perf-record.txt
> @@ -325,6 +325,10 @@ OPTIONS
>         by default.  User can change the number by passing it after comma
>         like "--call-graph fp,32".
>
> +       Also "defer" can be used with "fp" (like "--call-graph fp,defer")=
 to
> +       enable deferred user callchain which will collect user-space call=
chains
> +       when the thread returns to the user space.
> +
>  -q::
>  --quiet::
>         Don't print any warnings or messages, useful for scripting.
> diff --git a/tools/perf/util/callchain.c b/tools/perf/util/callchain.c
> index d7b7eef740b9d6ed..2884187ccbbecfdc 100644
> --- a/tools/perf/util/callchain.c
> +++ b/tools/perf/util/callchain.c
> @@ -275,9 +275,13 @@ int parse_callchain_record(const char *arg, struct c=
allchain_param *param)
>                         if (tok) {
>                                 unsigned long size;
>
> -                               size =3D strtoul(tok, &name, 0);
> -                               if (size < (unsigned) sysctl__max_stack()=
)
> -                                       param->max_stack =3D size;
> +                               if (!strncmp(tok, "defer", sizeof("defer"=
))) {
> +                                       param->defer =3D true;
> +                               } else {
> +                                       size =3D strtoul(tok, &name, 0);
> +                                       if (size < (unsigned) sysctl__max=
_stack())
> +                                               param->max_stack =3D size=
;
> +                               }
>                         }
>                         break;
>
> @@ -314,6 +318,12 @@ int parse_callchain_record(const char *arg, struct c=
allchain_param *param)
>         } while (0);
>
>         free(buf);
> +
> +       if (param->defer && param->record_mode !=3D CALLCHAIN_FP) {
> +               pr_err("callchain: deferred callchain only works with FP\=
n");
> +               return -EINVAL;
> +       }
> +
>         return ret;
>  }
>
> diff --git a/tools/perf/util/callchain.h b/tools/perf/util/callchain.h
> index 86ed9e4d04f9ee7b..d5ae4fbb7ce5fa44 100644
> --- a/tools/perf/util/callchain.h
> +++ b/tools/perf/util/callchain.h
> @@ -98,6 +98,7 @@ extern bool dwarf_callchain_users;
>
>  struct callchain_param {
>         bool                    enabled;
> +       bool                    defer;
>         enum perf_call_graph_mode record_mode;
>         u32                     dump_size;
>         enum chain_mode         mode;
> diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
> index 5ee3e7dee93fbbcb..7772ee9cfe3ac1c7 100644
> --- a/tools/perf/util/evsel.c
> +++ b/tools/perf/util/evsel.c
> @@ -1065,6 +1065,9 @@ static void __evsel__config_callchain(struct evsel =
*evsel, struct record_opts *o
>                 pr_info("Disabling user space callchains for function tra=
ce event.\n");
>                 attr->exclude_callchain_user =3D 1;
>         }
> +
> +       if (param->defer && !attr->exclude_callchain_user)
> +               attr->defer_callchain =3D 1;
>  }
>
>  void evsel__config_callchain(struct evsel *evsel, struct record_opts *op=
ts,
> @@ -1511,6 +1514,7 @@ void evsel__config(struct evsel *evsel, struct reco=
rd_opts *opts,
>         attr->mmap2    =3D track && !perf_missing_features.mmap2;
>         attr->comm     =3D track;
>         attr->build_id =3D track && opts->build_id;
> +       attr->defer_output =3D track && callchain->defer;
>
>         /*
>          * ksymbol is tracked separately with text poke because it needs =
to be
> @@ -2199,6 +2203,10 @@ static int __evsel__prepare_open(struct evsel *evs=
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
> @@ -2473,6 +2481,13 @@ static bool evsel__detect_missing_features(struct =
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
> @@ -2584,6 +2599,10 @@ static bool evsel__detect_missing_features(struct =
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
