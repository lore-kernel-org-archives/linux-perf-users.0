Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD0682561D6
	for <linux-perf-users@vger.kernel.org>; Wed, 26 Feb 2025 20:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740603588; cv=none; b=rjs8unWyawz3RFb10Id+Z/Snp5LZcrOkCnSZGsIaRz9VSkbD1kc+SmfQy3U07aniZ2sqv+ooIgJOL9BiXUXUoYsf6upd/hEl8WxmgNj9uWk+LaMbeXJDkYYjbz7Z3YpliJfVFnSQ1UwOVPglnTQgi+2k4cfuixYbhVFHDvhQ37Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740603588; c=relaxed/simple;
	bh=N2Rf2FQCm+P8gqVxbHJ17gpvziMvAMEqa0WJiN63eFs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LGvqX+YXFVsQWGObvjaVAj97yie7CTkERHvEgw/LELS60ZILeBB8jXKBmnLRT26GlNuIWdCBqFkVfS9bxfsbOpc+QUSrKSOWRv6tLm8AaT4PrkqVpNxubnofVlH+m3rXYGglyCxbyg7zv/QL0Pvt/oiKhQUSas+BcDja2fMdsxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=viJwsSP/; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="viJwsSP/"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-22342c56242so41975ad.0
        for <linux-perf-users@vger.kernel.org>; Wed, 26 Feb 2025 12:59:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740603586; x=1741208386; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hpDfAIGhp1H1pQsE6PqmIBzS1xXtlGV1blracxJrRqE=;
        b=viJwsSP/d0gxPnvN6z3gaSH2M903gwLHTZyujZ6KwE8lA7GraT6rvqct5zE+rhmu0i
         b6E+iQxltNlqCUtWdBV+ZSsheSV0vdhGWsaYnQoHoIE8CtjUZamuLT74FofRD2YFC9B6
         ONgVmfsxeR3g6IaZ7YghAeRXwrV9wPiXwpaxfGNgb0QS3RGth/iAfT3V3lvhtafNPHIK
         BW5luR85VY665bd5vt3uGLw1FBrs3Gcbng4Kr1rp0bnjB4PuSfPjf9MNJboL0dCpe7qY
         W+96II0Z+MVyIHzqiLMkE0bHA7P1GaGN4vPypwKK/Nl+sTfMxQa+sCWN0eOH1ynDlZ2s
         4rrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740603586; x=1741208386;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hpDfAIGhp1H1pQsE6PqmIBzS1xXtlGV1blracxJrRqE=;
        b=h/mRnM0WNEqFLgvsKjzgF4lEt1b1LcXX6+9w/vQSvCJCltrjSiKxmXUqDf/MUQqheJ
         ZJOSexK/rL4G/yvPqSTYlMJU+vkUlM2p2H7aiM3WG31iIsymUHOnHs5D7/Va0PsdWiKZ
         I782qjCqeCMTjGaDt8h/xgqLhOM1tQebJNi6R/yveeC5FDWpsNa29FbWiUGLnwuh4WvG
         Lzv6AuXDszSxQGkgNTQGPoIGQEH57le4LxZXkvMHNI5tU6C33dZ9ymmjCgQ18TA/eEl7
         mVum6sUTJbQyxLj7s+qUZuJJjBsXF5ZsmF9+97SKe2M8NoUDUSrfWE6fMY66uUWWdDKG
         fG8Q==
X-Forwarded-Encrypted: i=1; AJvYcCVnJF3IjIcCjDIkhSvWX+PmOnng+uQ8YrrCwvVRxP2GPOD3i9WSLAIrJ96E+g5J+nw6uGSX/iIFl+WYap/5u9rS@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8WuMI644gUn2w5zcv+3oSTfbo+N7SiLrbFZY2h45704Sw0rib
	yKQ+aCI0oPCF40kJnRyoIPcu6kYE4Xr2Lcp+u5CRA+Vz/OjrYb0R7gdN2JcAZ6eMiKEMhs/GBv5
	gn6cC8WVnAtf0Joo/sdbhzu+P5l2zVA6X7zZ8
X-Gm-Gg: ASbGnctHpAgYbFZH5o2EsuyIvJXL5PCrig7qgTxQ6nzmq8lvOqsiXoXxmum2C7xGITv
	l1CFJ5vElkEusksy8SFXK44MQ5WYI+WcfydkV5Vvsb4CVn4Yhjy3POX0QwkXa3QEMEj6DTLoJAG
	zj0dh4aPWKzclliN7sQiNyz2PGRYUUMs4Nqos=
X-Google-Smtp-Source: AGHT+IErSMhbekrHYqaP1wrOlN6DjS+bvccnZmVDEJgXkfri8fufy+RUIPZMy2DNosH+Gy44rSU6iNaTrXz1wCUUORQ=
X-Received: by 2002:a17:903:2788:b0:215:367f:2967 with SMTP id
 d9443c01a7336-2234d5a097cmr564165ad.2.1740603585776; Wed, 26 Feb 2025
 12:59:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250226203039.1099131-1-namhyung@kernel.org>
In-Reply-To: <20250226203039.1099131-1-namhyung@kernel.org>
From: Ian Rogers <irogers@google.com>
Date: Wed, 26 Feb 2025 12:59:33 -0800
X-Gm-Features: AQ5f1Jr7nGn8m3ucAcU7Zv_Fe0QHxkl4_j87Hgs7zT3dRKWfSnQz01WeXzVqdU8
Message-ID: <CAP-5=fVh2tTD22sFrPt37OJAhOsggvt2AVwf45p_pxTa=pnVKA@mail.gmail.com>
Subject: Re: [PATCH] perf tools: Skip BPF sideband event for userspace profiling
To: Namhyung Kim <namhyung@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Kan Liang <kan.liang@linux.intel.com>, 
	Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org, 
	James Clark <james.clark@linaro.org>, Song Liu <song@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 26, 2025 at 12:30=E2=80=AFPM Namhyung Kim <namhyung@kernel.org>=
 wrote:
>
> The BPF sideband information is tracked using a separate thread and
> evlist.  But it's only useful for profiling kernel and we can skip it
> when users profile their application only.

nit: It may be worth noting that profiling an application implicitly
excludes the kernel samples.

> It seems it already fails to open the sideband event in that case.
> Let's remove the noise in the verbose output anyway.
>
> Cc: Song Liu <song@kernel.org>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>

Reviewed-by: Ian Rogers <irogers@google.com>

I wonder if the second evlist could be avoided similar to Howard's
off-CPU sample events?
I also wonder if we should make the evlist responsible for BPF and
dummy/sideband events. Having unnecessary events increases the list
size iterated over when creating sideband data, and so has a runtime
cost. Having the logic separated in places like builtin-top and
builtin-record feels suboptimal.

Thanks,
Ian

> ---
>  tools/perf/builtin-record.c |  3 +++
>  tools/perf/builtin-top.c    |  3 +++
>  tools/perf/util/evlist.c    | 14 ++++++++++++++
>  tools/perf/util/evlist.h    |  1 +
>  4 files changed, 21 insertions(+)
>
> diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
> index 0e45bd64185403ae..cc61f5d6c599039c 100644
> --- a/tools/perf/builtin-record.c
> +++ b/tools/perf/builtin-record.c
> @@ -2535,6 +2535,9 @@ static int __cmd_record(struct record *rec, int arg=
c, const char **argv)
>                 goto out_free_threads;
>         }
>
> +       if (!evlist__needs_bpf_sb_event(rec->evlist))
> +               opts->no_bpf_event =3D true;
> +
>         err =3D record__setup_sb_evlist(rec);
>         if (err)
>                 goto out_free_threads;
> diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
> index 6440b5c1757d92ce..c284a384542ff822 100644
> --- a/tools/perf/builtin-top.c
> +++ b/tools/perf/builtin-top.c
> @@ -1833,6 +1833,9 @@ int cmd_top(int argc, const char **argv)
>                 goto out_delete_evlist;
>         }
>
> +       if (!evlist__needs_bpf_sb_event(top.evlist))
> +               top.record_opts.no_bpf_event =3D true;
> +
>  #ifdef HAVE_LIBBPF_SUPPORT
>         if (!top.record_opts.no_bpf_event) {
>                 top.sb_evlist =3D evlist__new();
> diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
> index f0dd174e2debdbe8..43adf6b3d855771a 100644
> --- a/tools/perf/util/evlist.c
> +++ b/tools/perf/util/evlist.c
> @@ -2594,3 +2594,17 @@ bool evlist__has_bpf_output(struct evlist *evlist)
>
>         return false;
>  }
> +
> +bool evlist__needs_bpf_sb_event(struct evlist *evlist)
> +{
> +       struct evsel *evsel;
> +
> +       evlist__for_each_entry(evlist, evsel) {
> +               if (evsel__is_dummy_event(evsel))
> +                       continue;
> +               if (!evsel->core.attr.exclude_kernel)
> +                       return true;
> +       }
> +
> +       return false;
> +}
> diff --git a/tools/perf/util/evlist.h b/tools/perf/util/evlist.h
> index adddb1db1ad2b25d..edcbf1c10e92f0c4 100644
> --- a/tools/perf/util/evlist.h
> +++ b/tools/perf/util/evlist.h
> @@ -435,5 +435,6 @@ void evlist__check_mem_load_aux(struct evlist *evlist=
);
>  void evlist__warn_user_requested_cpus(struct evlist *evlist, const char =
*cpu_list);
>  void evlist__uniquify_name(struct evlist *evlist);
>  bool evlist__has_bpf_output(struct evlist *evlist);
> +bool evlist__needs_bpf_sb_event(struct evlist *evlist);
>
>  #endif /* __PERF_EVLIST_H */
> --
> 2.48.1.658.g4767266eb4-goog
>
