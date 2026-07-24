Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71FE131A07B
	for <linux-perf-users@vger.kernel.org>; Fri, 24 Jul 2026 23:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784935642; cv=pass; b=MdV/wqJA6gXVJbpSg3D3SpZ3MvnLeg5wOkv+c7KGqYsY4PeJGiuecFca5bdAJK3+ima10Krgymw1H2li5224fJQNxFUYEs+xTIVuG2v3w8r4Nv+yUuy60hfDQZZdaSx0+fGRu9Q4sTzKS0Vsdpy3L7hVtFHNwTOmDL2E8smjbJ0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784935642; c=relaxed/simple;
	bh=BKHkFkDk2dIstaypKR7HzNqA6eQZvcD/EHRPzl0qFIA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a2FI8851/JHo/mBtp22CuOyYga0QwsFD4EznjP3222iRJgw9HrYG2Zg8yQ9A51pQDNuCzhSUyehhpnnbBzBBGXGax2IahO5g4G8LY2B1EsG0QxD+vtVEIJz5kcbovD7DSNXas9LzJGth9MCCIpOxIotiNqm//EnlakcF0GQgM4Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=J6GesGlA; arc=pass smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="J6GesGlA"
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-51c01c79467so104661cf.0
        for <linux-perf-users@vger.kernel.org>; Fri, 24 Jul 2026 16:27:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784935639; cv=none;
        d=google.com; s=arc-20260327;
        b=RaKuzeGxCVs4SaCBQoHg0IHvLCWBUlDiBTlqb7tsfwqPMPpkW4TTA5rYTGmLp2ouIG
         L5b0DP1kSG+e6UgKv+6Zs4wNycbMu8j3L22h6q0QdkwVDVlk9tuKFcTs3mJn4SfvZEE1
         r8arK9Ce9zwxS03xZK+h3Lm/q6CiiUMB5pAo6CAw801q1g+ldFqahZI1mjWXRjKu1umW
         DgfHpGqWE7usORDVIdcmFX39Qfg6qbuIVhWlyXfLsZzK/WksNBO/LKlaVEq830K8z7/w
         qstrKtU15UTjra+HkR4p9bjB8wvAaZYDMzdKM1nLXIQRiXJJJdP80NhXsrWL1r94N80+
         MziQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=PoqjSSihks2KoUNcB45aaCTkprCz3/yXGp46FIQac8M=;
        fh=ubY2cCB9PaTwAQor4t4ztbLhK8ZemFXy+nG+zuFTZqs=;
        b=nCFlN5CJrPTmn36R83YzEi2D/zhkAt9TmB65U5fnZOiH3q8ZetQY0Qb2QJfZ8D5lFa
         j+06rRbC2zcvfI9wAI29MtHhK/2/zvXIz2KSnSryAlIX9Yw0ogekt/15I+T/Qns94ERo
         MvuvXS93kRSD0s424CyFzhIt0sc736Cq6wj0wRmuVhdHx2RxCGHSldCwDVNqExR+2fXn
         mUSetQF7Bk/LuE1cIyhTqbroh54/8xaW1VRDqoJih/sgQ7pEz2Tx+dmq9jdje6sCkGbi
         qMOUstbQMm5xr9XQtL+w/w6RqbCDhQs+9ce5Q9mpfJUfjP+LJ72MIB60zvFCE8GJBnVW
         SJGQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784935639; x=1785540439; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=PoqjSSihks2KoUNcB45aaCTkprCz3/yXGp46FIQac8M=;
        b=J6GesGlAYPA2lNVUjoLz7UlKRGj7s1U8da54PU/towkRcneyz1RUakdlywM4aDpga8
         aiHMLHDDfxzidKwxGYu/Qe/tQ7EkIPr65HBsNmN/SPnZASflFIRdZAMaPZR7Jg2wD6p2
         7vVY9zz9jrpUgI4geJgDXPD+QbYD6elbjcdTB/rdCRb2RFnndO4feef5HPLgeu+Fz8fE
         BpIgYs1UYzazrFTCCojNEdngAZFcBfhm2CFRRK9AqmwRulSKj8ALXA7qRq56Ne2cxReu
         Osde9rj6LDg+WpdKcVU1grQYS3g69fAhu+rymatGUcqaZ7gP4gJKacHnGp7/genP1dAK
         Alxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784935639; x=1785540439;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PoqjSSihks2KoUNcB45aaCTkprCz3/yXGp46FIQac8M=;
        b=cH78Q1MXLKcGqljR4zhFXR8nsX0qpO247wnGcamqCPy9p6fe0E2rerLhlWXulaU8DF
         wywp+0oyBgnr0SN8EURFYIdSWd67wHIMWah6sThSj4kzPLWUcm1OD9OUeFY4hULjFi6b
         4LvX9K49F84BGevnHq5oU1M3tKN2uJPx8aVn5JP2JTOuB1JJWYvZaIi6CE3/FqnddJ8z
         SGmZW7qVUWep3a706J5ZsnJFQHq0jI1SpClraWyAzyRjqBu9TMgf8WvftexJIxXCYmIj
         d2orETocAEwAzcxeIZ0GsIi1+FOjrCFSHgd9JvRgjlIPuwzEXpcs54gJqovc2cLCDy7K
         w/iw==
X-Forwarded-Encrypted: i=1; AHgh+RocBPhOk8/7Kj5WESN65a23yFSXxgnU0gRa6K+XnFWPBK22NvRAxljTpJsqgwMRpC7hLnQAxSfmHTJoWg2yE2rz@vger.kernel.org
X-Gm-Message-State: AOJu0Ywil3enIYx5aHmKpcZocBZlP4x1j5uJxytbY+pb1ldM6WDP5+1H
	9fCffC68mxTiS/mOgvxWnIU/sHSs1KN6QDkjDv8rWMQ+fzw8xfmSxrnITYpFOro/YovBiGFwKLM
	/8Yi+Rl8/xCFYDABNGe1/StqkzoMnSnYj6pApvL0S
X-Gm-Gg: AR+sD120k8tLohj+NYsvucJKKvlyjVBfyAU43aldXTvxI8B0ATOA1O+xPCQmQ0TFYwz
	ua3AdasHLoHxm0UOcQe86ugrT5zYi8ms+juDxPxRrIEW+kB8bTcgCWms1gPNatqJPwyDSRRgvkb
	zTC44ekgxp9s2nTk8a8nvkxAom1Nteij640ugJ2WljIt99JqqEQG+xNBnFY+pn6nwvvmMG4L2BX
	UstKu86tiEYIv8OL/cBx351YJR/m5op3/2auaCSXgpQxHC+IWiXoWo4TvVPWHk=
X-Received: by 2002:a05:622a:a918:b0:51c:ad5:93be with SMTP id
 d75a77b69052e-529a5e72857mr6361791cf.8.1784935638565; Fri, 24 Jul 2026
 16:27:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260724201207.661300-1-atomlin@atomlin.com>
In-Reply-To: <20260724201207.661300-1-atomlin@atomlin.com>
From: Ian Rogers <irogers@google.com>
Date: Fri, 24 Jul 2026 16:27:07 -0700
X-Gm-Features: AUfX_mxARhnAWr8oJ7GNjWbvhqk8J79_MOgnPNiq2VcZu9PSvPsII2NaUo7vbSc
Message-ID: <CAP-5=fWmV2YoBdGKhxt9G_VByMzqimxEamxbjh_Gf_vBx9=cng@mail.gmail.com>
Subject: Re: [RFC PATCH] perf sched latency: Add histogram and time interval options
To: Aaron Tomlin <atomlin@atomlin.com>
Cc: peterz@infradead.org, mingo@redhat.com, acme@kernel.org, 
	namhyung@kernel.org, mark.rutland@arm.com, alexander.shishkin@linux.intel.com, 
	jolsa@kernel.org, adrian.hunter@intel.com, james.clark@linaro.org, 
	howardchu95@gmail.com, neelx@suse.com, chjohnst@mail.com, sean@ashe.io, 
	steve@abita.co, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 24, 2026 at 1:12=E2=80=AFPM Aaron Tomlin <atomlin@atomlin.com> =
wrote:
>
> While 'perf sched latency' reports task runtime and delay statistics
> (average and maximum delay), it does not provide a visual representation
> of how task wait times are distributed across latency ranges between
> snapshots (start and finish of the analysis window).
>
> The --histogram option collects CPU wait latencies (time between when
> a task becomes runnable and when it gets scheduled onto a CPU) into 22
> latency buckets, displaying an ASCII bar chart distribution.
>
> The --hist-mode option configures the bucketing scheme:
>   - log (default). Logarithmic latency buckets ranging from
>     sub-microsecond (< 1 us) up to >=3D 1.05 seconds
>
>   - linear. Equal-width linear latency buckets
>     (i.e., 100 us steps up to >=3D 2.1 ms)
>
> The --time option allows filtering trace event processing to a
> specific time interval [start,stop].
>
> Example histogram output excerpt:
>
>     =E2=9D=AF sudo perf sched latency --histogram --CPU 0
>
>      CPU Wait Latency Distribution Histogram (between snapshots) (total s=
amples: 36114)
>      -------------------------------------------------------------------
>       Latency Range    |      Count |    Pct | Histogram Graph
>      -------------------------------------------------------------------
>       < 1 us           |         17 |   0.0% | #
>       2 - 4 us         |        673 |   1.9% | #
>       4 - 8 us         |       6237 |  17.3% | ######
>       8 - 16 us        |       3224 |   8.9% | ###
>       16 - 32 us       |       1388 |   3.8% | #
>       32 - 64 us       |        709 |   2.0% | #
>       64 - 128 us      |        690 |   1.9% | #
>       128 - 256 us     |        789 |   2.2% | #
>       256 - 512 us     |        541 |   1.5% | #
>       512 - 1024 us    |       2256 |   6.2% | ##
>       1 - 2 ms         |       3577 |   9.9% | ###
>       2 - 4 ms         |      13259 |  36.7% | ##############
>       4 - 8 ms         |       2523 |   7.0% | ##
>       8 - 16 ms        |        222 |   0.6% | #
>       16 - 32 ms       |         10 |   0.0% | #
>       >=3D 1.05 s        |          3 |   0.0% | #
>      -------------------------------------------------------------------
>
> Signed-off-by: Aaron Tomlin <atomlin@atomlin.com>

This looks like a useful addition and because the behavior is behind a
flag it won't break anyone. I saw Sashiko had some issues, but I'd be
happy to add my tags once that's cleaned up.

Thanks,
Ian

> ---
>  tools/perf/Documentation/perf-sched.txt |   6 +
>  tools/perf/builtin-sched.c              | 180 +++++++++++++++++++++++-
>  2 files changed, 183 insertions(+), 3 deletions(-)
>
> diff --git a/tools/perf/Documentation/perf-sched.txt b/tools/perf/Documen=
tation/perf-sched.txt
> index a4221398e5e0..4da06215163a 100644
> --- a/tools/perf/Documentation/perf-sched.txt
> +++ b/tools/perf/Documentation/perf-sched.txt
> @@ -40,6 +40,12 @@ There are several variants of 'perf sched':
>    Tasks with the same command name are merged and the merge count is
>    given within (), However if -p option is used, pid is mentioned.
>
> +  If -H or --histogram option is passed, a CPU wait latency distribution
> +  histogram is displayed illustrating how long tasks waited for CPU
> +  runtime across latency buckets between snapshots. The --time
> +  option (start,stop) limits analysis to a specific snapshot time interv=
al.
> +  The --hist-mode option (log or linear) configures the latency bucketin=
g scheme.
> +
>    'perf sched script' to see a detailed trace of the workload that
>     was recorded (aliased to 'perf script' for now).
>
> diff --git a/tools/perf/builtin-sched.c b/tools/perf/builtin-sched.c
> index b3cf678573e0..b73149b84fb8 100644
> --- a/tools/perf/builtin-sched.c
> +++ b/tools/perf/builtin-sched.c
> @@ -59,6 +59,68 @@
>  #define MAX_PRIO               140
>  #define SEP_LEN                        100
>
> +#define NUM_LAT_BUCKETS 22
> +
> +enum hist_mode {
> +       HIST_MODE_LOG =3D 0,
> +       HIST_MODE_LINEAR,
> +};
> +
> +static const char *lat_bucket_names[NUM_LAT_BUCKETS] =3D {
> +       "< 1 us",
> +       "1 - 2 us",
> +       "2 - 4 us",
> +       "4 - 8 us",
> +       "8 - 16 us",
> +       "16 - 32 us",
> +       "32 - 64 us",
> +       "64 - 128 us",
> +       "128 - 256 us",
> +       "256 - 512 us",
> +       "512 - 1024 us",
> +       "1 - 2 ms",
> +       "2 - 4 ms",
> +       "4 - 8 ms",
> +       "8 - 16 ms",
> +       "16 - 32 ms",
> +       "32 - 64 ms",
> +       "64 - 128 ms",
> +       "128 - 256 ms",
> +       "256 - 512 ms",
> +       "512 - 1024 ms",
> +       ">=3D 1.05 s"
> +};
> +
> +static const char *linear_bucket_names[NUM_LAT_BUCKETS] =3D {
> +       "< 100 us",
> +       "100 - 200 us",
> +       "200 - 300 us",
> +       "300 - 400 us",
> +       "400 - 500 us",
> +       "500 - 600 us",
> +       "600 - 700 us",
> +       "700 - 800 us",
> +       "800 - 900 us",
> +       "900 - 1000 us",
> +       "1.0 - 1.1 ms",
> +       "1.1 - 1.2 ms",
> +       "1.2 - 1.3 ms",
> +       "1.3 - 1.4 ms",
> +       "1.4 - 1.5 ms",
> +       "1.5 - 1.6 ms",
> +       "1.6 - 1.7 ms",
> +       "1.7 - 1.8 ms",
> +       "1.8 - 1.9 ms",
> +       "1.9 - 2.0 ms",
> +       "2.0 - 2.1 ms",
> +       ">=3D 2.1 ms"
> +};
> +
> +struct perf_sched;
> +static int latency_bucket(struct perf_sched *sched, u64 delta_ns);
> +static void print_latency_histogram(struct perf_sched *sched, u64 *hist,
> +                                   u64 total_count, const char *title);
> +
>  static const char *cpu_list;
>  static struct perf_cpu_map *user_requested_cpus;
>  static DECLARE_BITMAP(cpu_bitmap, MAX_NR_CPUS);
> @@ -124,6 +186,7 @@ struct work_atoms {
>         u64                     nb_atoms;
>         u64                     total_runtime;
>         int                     num_merged;
> +       u64                     hist[NUM_LAT_BUCKETS];
>  };
>
>  typedef int (*sort_fn_t)(struct work_atoms *, struct work_atoms *);
> @@ -219,6 +282,10 @@ struct perf_sched {
>         struct list_head sort_list, cmp_pid;
>         bool force;
>         bool skip_merge;
> +       bool show_histogram;
> +       enum hist_mode hist_mode;
> +       const char *hist_mode_str;
> +       u64 global_hist[NUM_LAT_BUCKETS];
>         struct perf_sched_map map;
>
>         /* options for timehist command */
> @@ -246,6 +313,59 @@ struct perf_sched {
>         struct perf_data *data;
>  };
>
> +static int latency_bucket(struct perf_sched *sched, u64 delta_ns)
> +{
> +       u64 delta_us =3D delta_ns / NSEC_PER_USEC;
> +       int b;
> +
> +       if (sched->hist_mode =3D=3D HIST_MODE_LINEAR) {
> +               b =3D delta_us / 100;
> +       } else {
> +               if (delta_us =3D=3D 0)
> +                       return 0;
> +               b =3D 64 - __builtin_clzll(delta_us);
> +       }
> +
> +       if (b >=3D NUM_LAT_BUCKETS - 1)
> +               return NUM_LAT_BUCKETS - 1;
> +       return b;
> +}
> +
> +static void print_latency_histogram(struct perf_sched *sched, u64 *hist,
> +                                   u64 total_count, const char *title)
> +{
> +       const char **bucket_names =3D (sched->hist_mode =3D=3D HIST_MODE_=
LINEAR) ?
> +               linear_bucket_names : lat_bucket_names;
> +       int bar_total =3D 40;
> +       char bar[] =3D "########################################";
> +       int i;
> +
> +       if (total_count =3D=3D 0)
> +               return;
> +
> +       printf("\n %s (total samples: %" PRIu64 ")\n", title, total_count=
);
> +       printf(" --------------------------------------------------------=
-----------\n");
> +       printf("  %-16s | %10s | %6s | %s\n",
> +              "Latency Range", "Count", "Pct", "Histogram Graph");
> +       printf(" --------------------------------------------------------=
-----------\n");
> +
> +       for (i =3D 0; i < NUM_LAT_BUCKETS; i++) {
> +               double pct;
> +               int bar_len;
> +
> +               if (hist[i] =3D=3D 0)
> +                       continue;
> +               pct =3D (double)hist[i] * 100.0 / total_count;
> +               bar_len =3D (hist[i] * bar_total) / total_count;
> +               if (bar_len =3D=3D 0 && hist[i] > 0)
> +                       bar_len =3D 1;
> +               printf("  %-16s | %10" PRIu64 " | %5.1f%% | %.*s\n",
> +                      bucket_names[i], hist[i], pct,
> +                      bar_len, bar);
> +       }
> +       printf(" --------------------------------------------------------=
-----------\n");
> +}
> +
>  /* per thread run time data */
>  struct thread_runtime {
>         u64 last_time;      /* time of previous sched in/out event */
> @@ -1129,10 +1249,12 @@ add_runtime_event(struct work_atoms *atoms, u64 d=
elta,
>  }
>
>  static void
> -add_sched_in_event(struct work_atoms *atoms, u64 timestamp)
> +add_sched_in_event(struct perf_sched *sched, struct work_atoms *atoms,
> +                  u64 timestamp)
>  {
>         struct work_atom *atom;
>         u64 delta;
> +       int b;
>
>         if (list_empty(&atoms->work_list))
>                 return;
> @@ -1158,6 +1280,10 @@ add_sched_in_event(struct work_atoms *atoms, u64 t=
imestamp)
>                 atoms->max_lat_end =3D timestamp;
>         }
>         atoms->nb_atoms++;
> +
> +       b =3D latency_bucket(sched, delta);
> +       atoms->hist[b]++;
> +       sched->global_hist[b]++;
>  }
>
>  static void free_work_atoms(struct work_atoms *atoms)
> @@ -1188,6 +1314,9 @@ static int latency_switch_event(struct perf_sched *=
sched,
>         int cpu =3D sample->cpu, err =3D -1;
>         s64 delta;
>
> +       if (perf_time__skip_sample(&sched->ptime, sample->time))
> +               return 0;
> +
>         /* perf.data is untrusted input =E2=80=94 CPU may be absent or co=
rrupted */
>         if (cpu >=3D MAX_CPUS || cpu < 0) {
>                 pr_warning("WARNING: at offset %#" PRIx64 ": out-of-bound=
 sample CPU %d, skipping sample\n",
> @@ -1241,7 +1370,7 @@ static int latency_switch_event(struct perf_sched *=
sched,
>                 if (add_sched_out_event(in_events, 'R', timestamp))
>                         goto out_put;
>         }
> -       add_sched_in_event(in_events, timestamp);
> +       add_sched_in_event(sched, in_events, timestamp);
>         err =3D 0;
>  out_put:
>         thread__put(sched_out);
> @@ -1255,11 +1384,15 @@ static int latency_runtime_event(struct perf_sche=
d *sched,
>  {
>         const u32 pid      =3D perf_sample__intval(sample, "pid");
>         const u64 runtime  =3D perf_sample__intval(sample, "runtime");
> -       struct thread *thread =3D machine__findnew_thread(machine, -1, pi=
d);
> +       struct thread *thread;
>         struct work_atoms *atoms;
>         u64 timestamp =3D sample->time;
>         int cpu =3D sample->cpu, err =3D -1;
>
> +       if (perf_time__skip_sample(&sched->ptime, sample->time))
> +               return 0;
> +
> +       thread =3D machine__findnew_thread(machine, -1, pid);
>         if (thread =3D=3D NULL)
>                 return -1;
>
> @@ -1302,6 +1435,9 @@ static int latency_wakeup_event(struct perf_sched *=
sched,
>         u64 timestamp =3D sample->time;
>         int err =3D -1;
>
> +       if (perf_time__skip_sample(&sched->ptime, sample->time))
> +               return 0;
> +
>         wakee =3D machine__findnew_thread(machine, -1, pid);
>         if (wakee =3D=3D NULL)
>                 return -1;
> @@ -1362,6 +1498,9 @@ static int latency_migrate_task_event(struct perf_s=
ched *sched,
>         struct thread *migrant;
>         int err =3D -1;
>
> +       if (perf_time__skip_sample(&sched->ptime, sample->time))
> +               return 0;
> +
>         /*
>          * Only need to worry about migration when profiling one CPU.
>          */
> @@ -1438,6 +1577,11 @@ static void output_lat_thread(struct perf_sched *s=
ched, struct work_atoms *work_
>                  work_list->nb_atoms, (double)avg / NSEC_PER_MSEC,
>                  (double)work_list->max_lat / NSEC_PER_MSEC,
>                  max_lat_start, max_lat_end);
> +
> +       if (sched->show_histogram && verbose > 0)
> +               print_latency_histogram(sched, work_list->hist,
> +                                       work_list->nb_atoms,
> +                                       "Task Latency Histogram");
>  }
>
>  static int pid_cmp(struct work_atoms *l, struct work_atoms *r)
> @@ -3544,6 +3688,8 @@ static void __merge_work_atoms(struct rb_root_cache=
d *root, struct work_atoms *d
>                                 this->max_lat_start =3D data->max_lat_sta=
rt;
>                                 this->max_lat_end =3D data->max_lat_end;
>                         }
> +                       for (int i =3D 0; i < NUM_LAT_BUCKETS; i++)
> +                               this->hist[i] +=3D data->hist[i];
>                         free_work_atoms(data);
>                         return;
>                 }
> @@ -3602,6 +3748,24 @@ static int perf_sched__lat(struct perf_sched *sche=
d)
>
>         setup_pager();
>
> +       if (sched->hist_mode_str) {
> +               sched->show_histogram =3D true;
> +               if (!strcmp(sched->hist_mode_str, "linear"))
> +                       sched->hist_mode =3D HIST_MODE_LINEAR;
> +               else if (!strcmp(sched->hist_mode_str, "log"))
> +                       sched->hist_mode =3D HIST_MODE_LOG;
> +               else {
> +                       pr_err("Invalid --hist-mode '%s', expected 'log' =
or 'linear'\n",
> +                              sched->hist_mode_str);
> +                       return -EINVAL;
> +               }
> +       }
> +
> +       if (sched->time_str && perf_time__parse_str(&sched->ptime, sched-=
>time_str) !=3D 0) {
> +               pr_err("Invalid time string\n");
> +               return -EINVAL;
> +       }
> +
>         if (setup_cpus_switch_event(sched))
>                 return rc;
>
> @@ -3634,6 +3798,10 @@ static int perf_sched__lat(struct perf_sched *sche=
d)
>         print_bad_events(sched);
>         printf("\n");
>
> +       if (sched->show_histogram)
> +               print_latency_histogram(sched, sched->global_hist, sched-=
>all_count,
> +                                       "CPU Wait Latency Distribution Hi=
stogram (between snapshots)");
> +
>         rc =3D 0;
>
>         while ((next =3D rb_first_cached(&sched->sorted_atom_root))) {
> @@ -5052,6 +5220,12 @@ int cmd_sched(int argc, const char **argv)
>                     "CPU to profile on"),
>         OPT_BOOLEAN('p', "pids", &sched.skip_merge,
>                     "latency stats per pid instead of per comm"),
> +       OPT_BOOLEAN('H', "histogram", &sched.show_histogram,
> +                   "show CPU wait latency distribution histogram"),
> +       OPT_STRING(0, "hist-mode", &sched.hist_mode_str, "log|linear",
> +                  "latency bucket mode (log or linear, default: log)"),
> +       OPT_STRING(0, "time", &sched.time_str, "str",
> +                  "Time span for analysis (start,stop)"),
>         OPT_PARENT(sched_options)
>         };
>         const struct option replay_options[] =3D {
> --
> 2.54.0
>
