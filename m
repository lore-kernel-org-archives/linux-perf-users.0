Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14AC319CD0A
	for <linux-perf-users@vger.kernel.org>; Wed,  9 Sep 2026 00:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788912179; cv=pass; b=Gx00fMpN8H5NDq7ju7eGm07uqhta2FP63riZU+H72ZLQpNRwZhF9Wp3L+Sj0Ti+1tVBRjNqj+aQ+pgcD6EGzXXD3lAIVA2SLbtz/M+EsLueHFw6gmHunKJi7qObK6UWKBoRN6pazxDCLMK8tBDSiP9KzfrhlRtLt1WR4qFFAc2E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788912179; c=relaxed/simple;
	bh=eXMluhjnvGc7fVhDkeouMnpvCPUxaqO2Vn4cIPTB3DU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oxWJQkRa0wDy6gYWLaH2d3GIFownsHACCFwlNoPy+qe5FWSiiEy2bymINXEyR34gj7CN5gLzXaGN+4Diwg0WmvK9m4lrqbuCpqk50dl5EIPPX52otgWLo/qQIw+wQ8ItjtIrP8ZVAgeXK3NbQUdouPc6WF3YaJqaFP1X00SmTbw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qRwvo7ut; arc=pass smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qRwvo7ut"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-38759bcd877so5527881a91.2
        for <linux-perf-users@vger.kernel.org>; Tue, 08 Sep 2026 17:02:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788912176; cv=none;
        d=google.com; s=arc-20260327;
        b=atK/BiU+K029GOPK5t4354npsNIikbLvCL4SvCkS8odWCmH58WCuxQs24XzEOWXZvn
         GQcffrJqnObUyESKqhNhGQp1oYEgfX1N32/8iDvu6kq2xvjhFGthhSb6W1Yho2+ph13h
         UrIXXcKpBFMqXDv5HjuZn0A8iUns+lrl66MAzSYcPyabvdw67eFTANLdwuy+CCSLaWdc
         g4y+Ls/nxBPHph3Q4cfbFoTd9a+n/9mbtJJ1ItJZAt3r461F9WeCBdmYHvAExY0jvJR2
         caIri69po4MlbQrKaivja6bD2zPS6K5JfqjzxmKZ15qCA6V01jOewoK8Qp7WmXf4XMsJ
         gknw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=KuPFodhgCBbZm2jHRVC44V/Q+1Z+/kVdeF95tt7cU/s=;
        fh=JR0co9BQJXGHvbpCB7hkBr7LkhaFvQ98cLBRH7Byg0M=;
        b=Fb/BYvXn64qbdKc+oHNRRnfkrjVtWfYaWrLJbSFT6AAwnR7lGwQkbKLTC0TbNe6OOD
         rHb4bmI8m9jzQguQpJplO4lq+nxmVVe2woAIi7Cw8WpEk8AhlGyTRGxyrtWAPLhs/mPi
         q+i5XIcaoOLNuLg8pGFDEz3uOiMWaHYd5ggt4NhH49N5k6OcCEbEaviAzfCzZd5iTA8G
         +eCWa0epXHwEvFvrLzrPFtV76V9QdWiuylbQy5/ay4zwx4o+0GSLmaeWqvZ4FRHUR38L
         AYULgTHHU5Mi278pDYOfgz6L0z5klU6+9VVSCH3d78E+rzLJUwa73EBY7C9/psa8Tz7l
         e6Cw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788912176; x=1789516976; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=KuPFodhgCBbZm2jHRVC44V/Q+1Z+/kVdeF95tt7cU/s=;
        b=qRwvo7ut8bh/XXDz2z9HmHKwOA6Tae6eqG/0CK6+XLGxeU/cfrcXnG9mIgEFExJxWd
         RA7D7dYwx50cBi9YYB80W03WSfQGSMDC3fwOuQDsDkzUnP5CVONUUuUehT1hz2yYdheT
         lulUfrAE1rPal+EDHju5mCdc/ZEALfUclR1NssFwu3LZsL49FPLT8lt69yz4lwwtYQrW
         /OAEDBayqgB9Wga5bBUZ0tQMRZ3sLD6L4zhxqLQenVkh0ayUmLMh2NKPqRV5gwe4VcxY
         HdM02OvxexHoy+24FYA2GU4mJzINVje7CQ9KI70lbtgAy6EUlnfdrNaBJn9m41wWDy0Q
         cuWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788912176; x=1789516976;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KuPFodhgCBbZm2jHRVC44V/Q+1Z+/kVdeF95tt7cU/s=;
        b=Gb/AGsUIFZRj+bQB9BHc7zPxu8DseIVFjqgREEJjkD86gXBmvaJSIQnDqAWpE4mAYW
         zay1zp3GJZee02YEhEmvKa2BlTiMVUswpVmCbbTsTJv8yHG3820pEqsZ6izI02i266MH
         QejpFsDTXpTFW4yDhloO9eONZpefafJxA3sWjLSD5WRh23QsEMnlaBZ0UfXAH4XSgQd9
         +zVIdLkH6kGNzurYLg5zZ/hLcEXmCkOIhoCmr6IHQo8hI4uVJKXTYhDk3K4WWy31ZnoP
         C/aYfUKcCSzliE69UXdKQS+MbunWyBCk+XJxwJVmR3a84UhN18EY9uH4OMgHREGni+AX
         7cVw==
X-Forwarded-Encrypted: i=1; AKwUvByXW4za3LU/MX9mom69fu07Rlems92ldwkZm2FKZ9sWoIQWjqXu5aJIx6MtCZ4ejSjiZFgevdwfwZe/NfXjKThZ@vger.kernel.org
X-Gm-Message-State: AFuF++niiCZ8ciqUVGvJhEi5mj6V0yAHLO89poAMltsH/gk/ljAYFs7V
	jkelkARAJSPIQyIMlMnp6hTObE2RJbnujKAOtihqTq5lvcmGVBboPtSi5P9U3irchsg5Mis2Po0
	uDev2tIn+nLMJ3oflli2xfmHsjoYK8Q4gIA==
X-Gm-Gg: AYBFou1GnHb8NB9qwwcBR99Ks1c9ROHfizMewOc968fy6pqCwylR5OhOUAMhHF2hSO3
	3OvJwexCnVYNO+CkUa9lowu/ILbBKJvnp59VretscevTFjRrfCFUMFIvzQJu4DzAoWwXwcZ0VQx
	gzGE/RNV41pCZG8Yq8PMPihRUpPxqekD9O1mgUNPmT+YTlA0DjBGkdsdo0kbcHpmPdULz+YRvhi
	h1D2Qp26eNSAQsG5HwK0FzjRHKXUiwmdFVFepx7JwzXQ95XQgzkN3Vju9Puv6pHIOW6Fi/mxd/4
	VNVNitx/zjQqAFGqIzj3ZkhNcAY2/xfYznipoEnBCbeXZA78Wm20iw5GmuaI0zoiNcxxg7W1Gez
	/4noOs6+jKY5NXvp0552lm5pRCTlW/k4x8OnoHPIXvw==
X-Received: by 2002:a17:90b:4d87:b0:380:540:d499 with SMTP id
 98e67ed59e1d1-39b26100bfdmr42942839a91.6.1788912176194; Tue, 08 Sep 2026
 17:02:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260908-bpftool_cyles_per_run-v3-0-60e86f325c35@meta.com> <20260908-bpftool_cyles_per_run-v3-3-60e86f325c35@meta.com>
In-Reply-To: <20260908-bpftool_cyles_per_run-v3-3-60e86f325c35@meta.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 8 Sep 2026 17:02:38 -0700
X-Gm-Features: AcwNN1U32cODWFXdn0UQM3wuCF3Jdj-_a5a67JY9Pv5PVVQ21YTd963X4BHet8E
Message-ID: <CAEf4BzZ0GwQS3vHDywzkLPo_FspsuPYeYEXsZ9q5c5Mp6nWVjQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 3/3] bpftool: Scale counters and report cycles
 per run
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
	daniel@iogearbox.net, kernel-team@meta.com, eddyz87@gmail.com, 
	memxor@gmail.com, qmo@kernel.org, linux-perf-users@vger.kernel.org, 
	acme@kernel.org, namhyung@kernel.org, Mykyta Yatsenko <yatsenko@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 8, 2026 at 7:27=E2=80=AFAM Mykyta Yatsenko
<mykyta.yatsenko5@gmail.com> wrote:
>
> From: Mykyta Yatsenko <yatsenko@meta.com>
>
> Perf counters can report too few events when the PMU multiplexes them.
> Scale each per-CPU value before aggregation.
>
> Use the same CPU set for derived ratios. Report cycles per included
> program run, and preserve the total run count in JSON.
>
> Fixes: 47c09d6a9f67 ("bpftool: Introduce "prog profile" command")
> Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
> ---
>  tools/bpf/bpftool/Documentation/bpftool-prog.rst |  13 +-
>  tools/bpf/bpftool/prog.c                         | 159 +++++++++++++++++=
------
>  2 files changed, 133 insertions(+), 39 deletions(-)
>
> diff --git a/tools/bpf/bpftool/Documentation/bpftool-prog.rst b/tools/bpf=
/bpftool/Documentation/bpftool-prog.rst
> index 90fa2a48cc26..0108a1c8be4d 100644
> --- a/tools/bpf/bpftool/Documentation/bpftool-prog.rst
> +++ b/tools/bpf/bpftool/Documentation/bpftool-prog.rst
> @@ -217,7 +217,16 @@ bpftool prog run *PROG* data_in *FILE* [data_out *FI=
LE* [data_size_out *L*]] [ct
>  bpftool prog profile *PROG* [duration *DURATION*] *METRICs*
>      Profile *METRICs* for bpf program *PROG* for *DURATION* seconds or u=
ntil
>      user hits <Ctrl+C>. *DURATION* is optional. If *DURATION* is not spe=
cified,
> -    the profiling will run up to **UINT_MAX** seconds.
> +    the profiling will run up to **UINT_MAX** seconds. Plain output scal=
es each
> +    per-CPU metric value to correct for perf event multiplexing. When
> +    **cycles** is selected, it also reports cycles per included program =
run. If
> +    a selected metric was not scheduled on a CPU, all metric values excl=
ude
> +    that CPU so that ratios use a consistent CPU set. The **run_cnt** va=
lue
> +    still includes all recorded runs.
> +
> +    In JSON output, **value** is raw, **value_scaled** is scaled, **run_=
cnt**
> +    includes all runs, and **run_cnt_valid** includes only runs used for=
 metric
> +    values.
>
>  bpftool prog help
>      Print short help message.
> @@ -360,7 +369,7 @@ EXAMPLES
>  ::
>
>           51397 run_cnt
> -      40176203 cycles                                                 (8=
3.05%)
> +      40176203 cycles          # 781.68 cycles per run                (8=
3.05%)
>        42518139 instructions    #   1.06 insns per cycle               (8=
3.39%)
>             123 llc_misses      #   2.89 LLC misses per million insns  (8=
3.15%)
>
> diff --git a/tools/bpf/bpftool/prog.c b/tools/bpf/bpftool/prog.c
> index 8c2f9255b36d..9e126f3823ad 100644
> --- a/tools/bpf/bpftool/prog.c
> +++ b/tools/bpf/bpftool/prog.c
> @@ -2062,37 +2062,52 @@ static int do_profile(int argc, char **argv)
>
>  #include "profiler.skel.h"
>
> +enum ratio_metric {
> +       METRIC_NONE =3D -2,
> +       METRIC_RUN_CNT =3D -1,
> +       METRIC_CYCLES =3D 0,
> +       METRIC_INSTRUCTIONS =3D 1,
> +       METRIC_L1D_LOADS =3D 2,
> +       METRIC_LLC_MISSES =3D 3,
> +       METRIC_ITLB_MISSES =3D 4,
> +       METRIC_DTLB_MISSES =3D 5,
> +};
> +
>  struct profile_metric {
>         const char *name;
>         struct bpf_perf_event_value val;
> +       __u64 scaled_val;
>         struct perf_event_attr attr;
>         bool selected;
>
>         /* calculate ratios like instructions per cycle */
> -       const int ratio_metric; /* 0 for N/A, 1 for index 0 (cycles) */
> +       const enum ratio_metric ratio_metric;
>         const char *ratio_desc;
>         const float ratio_mul;
>  } metrics[] =3D {
> -       {
> +       [METRIC_CYCLES] =3D {
>                 .name =3D "cycles",
>                 .attr =3D {
>                         .type =3D PERF_TYPE_HARDWARE,
>                         .config =3D PERF_COUNT_HW_CPU_CYCLES,
>                         .exclude_user =3D 1,
>                 },
> +               .ratio_metric =3D METRIC_RUN_CNT,
> +               .ratio_desc =3D "cycles per run",
> +               .ratio_mul =3D 1.0,
>         },
> -       {
> +       [METRIC_INSTRUCTIONS] =3D {
>                 .name =3D "instructions",
>                 .attr =3D {
>                         .type =3D PERF_TYPE_HARDWARE,
>                         .config =3D PERF_COUNT_HW_INSTRUCTIONS,
>                         .exclude_user =3D 1,
>                 },
> -               .ratio_metric =3D 1,
> +               .ratio_metric =3D METRIC_CYCLES,
>                 .ratio_desc =3D "insns per cycle",
>                 .ratio_mul =3D 1.0,
>         },
> -       {
> +       [METRIC_L1D_LOADS] =3D {
>                 .name =3D "l1d_loads",
>                 .attr =3D {
>                         .type =3D PERF_TYPE_HW_CACHE,
> @@ -2102,8 +2117,9 @@ struct profile_metric {
>                                 (PERF_COUNT_HW_CACHE_RESULT_ACCESS << 16)=
,
>                         .exclude_user =3D 1,
>                 },
> +               .ratio_metric =3D METRIC_NONE,
>         },
> -       {
> +       [METRIC_LLC_MISSES] =3D {
>                 .name =3D "llc_misses",
>                 .attr =3D {
>                         .type =3D PERF_TYPE_HW_CACHE,
> @@ -2113,11 +2129,11 @@ struct profile_metric {
>                                 (PERF_COUNT_HW_CACHE_RESULT_MISS << 16),
>                         .exclude_user =3D 1
>                 },
> -               .ratio_metric =3D 2,
> +               .ratio_metric =3D METRIC_INSTRUCTIONS,
>                 .ratio_desc =3D "LLC misses per million insns",
>                 .ratio_mul =3D 1e6,
>         },
> -       {
> +       [METRIC_ITLB_MISSES] =3D {
>                 .name =3D "itlb_misses",
>                 .attr =3D {
>                         .type =3D PERF_TYPE_HW_CACHE,
> @@ -2127,11 +2143,11 @@ struct profile_metric {
>                                 (PERF_COUNT_HW_CACHE_RESULT_MISS << 16),
>                         .exclude_user =3D 1
>                 },
> -               .ratio_metric =3D 2,
> +               .ratio_metric =3D METRIC_INSTRUCTIONS,
>                 .ratio_desc =3D "itlb misses per million insns",
>                 .ratio_mul =3D 1e6,
>         },
> -       {
> +       [METRIC_DTLB_MISSES] =3D {
>                 .name =3D "dtlb_misses",
>                 .attr =3D {
>                         .type =3D PERF_TYPE_HW_CACHE,
> @@ -2141,13 +2157,14 @@ struct profile_metric {
>                                 (PERF_COUNT_HW_CACHE_RESULT_MISS << 16),
>                         .exclude_user =3D 1
>                 },
> -               .ratio_metric =3D 2,
> +               .ratio_metric =3D METRIC_INSTRUCTIONS,
>                 .ratio_desc =3D "dtlb misses per million insns",
>                 .ratio_mul =3D 1e6,
>         },
>  };
>
>  static __u64 profile_total_count;
> +static __u64 profile_valid_count;
>
>  #define MAX_NUM_PROFILE_METRICS 4
>
> @@ -2182,9 +2199,39 @@ static int profile_parse_metrics(int argc, char **=
argv)
>         return selected_cnt;
>  }
>
> -static void profile_read_values(struct profiler_bpf *obj)
> +/*
> + * Filter out CPUs that have any selected metric not scheduled for them.=
 This makes sure all
> + * metrics are using the same CPU set, as a result ratio metrics are con=
sistent.
> + */
> +static void profile_filter_cpus(__u32 num_cpu,
> +                               struct bpf_perf_event_value vals[MAX_NUM_=
PROFILE_METRICS][num_cpu],
> +                               __u64 *counts)
> +{
> +       __u32 m, cpu, key =3D 0;
> +
> +       for (m =3D 0; m < ARRAY_SIZE(metrics); m++) {
> +               if (!metrics[m].selected)
> +                       continue;
> +
> +               for (cpu =3D 0; cpu < num_cpu; cpu++) {
> +                       /*
> +                        * CPU has hits, but this metric never scheduled,=
 set counts[cpu] to 0
> +                        * so other metrics ignore this CPU too
> +                        */
> +                       if (counts[cpu] && !vals[key][cpu].running) {
> +                               p_info("%s not scheduled on CPU %u; exclu=
ding %llu runs from all metrics",
> +                                      metrics[m].name, cpu, counts[cpu])=
;
> +                               counts[cpu] =3D 0;
> +                       }
> +               }
> +               key++;
> +       }
> +}

was this suggested by AI or we actually ran into issues due to this in
practice? this looks perculiar

> +
> +static int profile_read_values(struct profiler_bpf *obj)
>  {
>         __u32 m, cpu, num_cpu =3D obj->rodata->num_cpu;
> +       struct bpf_perf_event_value values[MAX_NUM_PROFILE_METRICS][num_c=
pu], *val;
>         int reading_map_fd, count_map_fd;
>         __u64 counts[num_cpu];
>         __u32 key =3D 0;
> @@ -2194,38 +2241,61 @@ static void profile_read_values(struct profiler_b=
pf *obj)
>         count_map_fd =3D bpf_map__fd(obj->maps.counts);
>         if (reading_map_fd < 0 || count_map_fd < 0) {

this can't happen if skeleton loaded successfully, just remove this
check instead of weird min() over fds/errors

>                 p_err("failed to get fd for map");
> -               return;
> +               return min(reading_map_fd, count_map_fd);
>         }
>
>         err =3D bpf_map_lookup_elem(count_map_fd, &key, counts);
>         if (err) {
>                 p_err("failed to read count_map: %s", strerror(errno));
> -               return;
> +               return err;
> +       }
> +
> +       for (m =3D 0; m < ARRAY_SIZE(metrics); m++) {
> +               if (!metrics[m].selected)
> +                       continue;
> +
> +               err =3D bpf_map_lookup_elem(reading_map_fd, &key, values[=
key]);
> +               if (err) {
> +                       p_err("failed to read reading_map: %s", strerror(=
errno));
> +                       return err;
> +               }
> +               key++;
>         }
>
>         profile_total_count =3D 0;
>         for (cpu =3D 0; cpu < num_cpu; cpu++)
>                 profile_total_count +=3D counts[cpu];
>
> +       profile_filter_cpus(num_cpu, values, counts);
> +
> +       profile_valid_count =3D 0;
> +       for (cpu =3D 0; cpu < num_cpu; cpu++)
> +               profile_valid_count +=3D counts[cpu];
> +
> +       key =3D 0;
>         for (m =3D 0; m < ARRAY_SIZE(metrics); m++) {
> -               struct bpf_perf_event_value values[num_cpu];
> +               double scale;
>
>                 if (!metrics[m].selected)
>                         continue;
>
> -               err =3D bpf_map_lookup_elem(reading_map_fd, &key, values)=
;
> -               if (err) {
> -                       p_err("failed to read reading_map: %s",
> -                             strerror(errno));
> -                       return;
> -               }
>                 for (cpu =3D 0; cpu < num_cpu; cpu++) {
> -                       metrics[m].val.counter +=3D values[cpu].counter;
> -                       metrics[m].val.enabled +=3D values[cpu].enabled;
> -                       metrics[m].val.running +=3D values[cpu].running;
> +                       /* Skip CPUs with no runs or with an unscheduled =
metric. */
> +                       if (!counts[cpu])
> +                               continue;
> +
> +                       val =3D &values[key][cpu];
> +
> +                       metrics[m].val.enabled +=3D val->enabled;
> +                       metrics[m].val.running +=3D val->running;
> +                       metrics[m].val.counter +=3D val->counter;
> +                       /* Scale counter values to account for perf event=
 multiplexing. */
> +                       scale =3D (double)val->enabled / val->running;
> +                       metrics[m].scaled_val +=3D val->counter * scale;
>                 }
>                 key++;
>         }
> +       return 0;
>  }
>
>  static void profile_print_readings_json(void)
> @@ -2239,9 +2309,11 @@ static void profile_print_readings_json(void)
>                 jsonw_start_object(json_wtr);
>                 jsonw_string_field(json_wtr, "metric", metrics[m].name);
>                 jsonw_lluint_field(json_wtr, "run_cnt", profile_total_cou=
nt);
> +               jsonw_lluint_field(json_wtr, "run_cnt_valid", profile_val=
id_count);

aren't we just overcomplicating things for no good reason?..

>                 jsonw_lluint_field(json_wtr, "value", metrics[m].val.coun=
ter);
>                 jsonw_lluint_field(json_wtr, "enabled", metrics[m].val.en=
abled);
>                 jsonw_lluint_field(json_wtr, "running", metrics[m].val.ru=
nning);
> +               jsonw_lluint_field(json_wtr, "value_scaled", metrics[m].s=
caled_val);
>
>                 jsonw_end_object(json_wtr);
>         }
> @@ -2250,24 +2322,34 @@ static void profile_print_readings_json(void)
>
>  static void profile_print_readings_plain(void)
>  {
> -       __u32 m;
> +       __u32 i;
>
>         printf("\n%18llu %-20s\n", profile_total_count, "run_cnt");
> -       for (m =3D 0; m < ARRAY_SIZE(metrics); m++) {
> -               struct bpf_perf_event_value *val =3D &metrics[m].val;
> +       for (i =3D 0; i < ARRAY_SIZE(metrics); i++) {
> +               struct profile_metric *m =3D &metrics[i];
> +               struct bpf_perf_event_value *val =3D &m->val;
>                 int r;
> +               __u64 ratio;
>
> -               if (!metrics[m].selected)
> +               if (!m->selected)
>                         continue;
> -               printf("%18llu %-20s", val->counter, metrics[m].name);
> +               printf("%18llu %-20s", m->scaled_val, m->name);
>
> -               r =3D metrics[m].ratio_metric - 1;
> -               if (r >=3D 0 && metrics[r].selected &&
> -                   metrics[r].val.counter > 0) {
> +               r =3D m->ratio_metric;
> +               switch (r) {
> +               case METRIC_RUN_CNT:
> +                       ratio =3D profile_valid_count;
> +                       break;
> +               case METRIC_NONE:
> +                       ratio =3D 0;
> +                       break;
> +               default:
> +                       ratio =3D metrics[r].scaled_val;
> +               }
> +               if (ratio) {
>                         printf("# %8.2f %-30s",
> -                              val->counter * metrics[m].ratio_mul /
> -                              metrics[r].val.counter,
> -                              metrics[m].ratio_desc);
> +                              m->scaled_val * m->ratio_mul / ratio,
> +                              m->ratio_desc);
>                 } else {
>                         printf("%-41s", "");
>                 }
> @@ -2423,9 +2505,12 @@ static int profile_open_perf_events(struct profile=
r_bpf *obj)
>
>  static void profile_print_and_cleanup(void)
>  {
> +       int err;
> +
>         profile_close_perf_events(profile_obj);
> -       profile_read_values(profile_obj);
> -       profile_print_readings();
> +       err =3D profile_read_values(profile_obj);
> +       if (!err)
> +               profile_print_readings();
>         profiler_bpf__destroy(profile_obj);
>
>         close(profile_tgt_fd);
>
> --
> 2.53.0-Meta
>
