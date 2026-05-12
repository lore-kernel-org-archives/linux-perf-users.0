Received: from mail-dl1-f54.google.com (mail-dl1-f54.google.com [74.125.82.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14A7825B09F
	for <linux-perf-users@vger.kernel.org>; Tue, 12 May 2026 18:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778610784; cv=pass; b=PRJvX4hGbGQF0YSkZN5mnVkJukeLRD1T/wQLMMswOJ5BB0Hm3+8nkjbSsOH+6kmvCjXtYBv+dZJ8u505biYop0oBa9vMV79uCIfPHICAWJwL1h93NmujkvNxLqH3//J6gDMJaDuX46B4LGjD+ktSP7g/ap5xDaKfHWyUwsbZw5Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778610784; c=relaxed/simple;
	bh=D0QU0UvYDdeysFf/bcljDGLY48i4xXFXvC+ntFcdOVo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Jo0ulypAuWFlPAiipKO+w4BIlT+Ml7fwmmeIJFq6pcXcvk/cUResPgSkSfevYnJGB+Pi3qICX0jiHV2IVtFnglOys/KM9pdd4cA8VuK31g9HI+DfvBZ5eFBvmyfBJ93T0sEqVl00rUtZyjugv8OO5Cx9WOKEs9sqoCJKjr/yTgI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DKovfjm9; arc=pass smtp.client-ip=74.125.82.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DKovfjm9"
Received: by mail-dl1-f54.google.com with SMTP id a92af1059eb24-12c8d0945b3so22c88.0
        for <linux-perf-users@vger.kernel.org>; Tue, 12 May 2026 11:33:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778610782; cv=none;
        d=google.com; s=arc-20240605;
        b=TlJPLkoRdn1IJObNw56b5z1pMVLMBLbt5xAJr1bZgKfmdNFr18wXcrfe3LEWLhIdRn
         cBebBoTzxEYEtQm1++Yv38KkWCIZt+6kn21YtmbxhZ2kK3ic7bENPj2PIrb9PJO9Gm0l
         /Cw52+PDYOms2U3S4hXMLpkvDhozskZcAMQzOdO3vLPnd5noyxtYvoIrAs+cY8vTG9p1
         YMbw57SxQ7VSxx91KTVKyFqaA0GKtKjmR7E0+l7ciuHNpOEwdBy+ERw1skkUG2Hyeb0V
         ulVDyeeaFo6zEuRO5Zvu/WbH+j7AluqUwILAA1L1rKU/aay5x/89oWdKg8JGkGaQnRfD
         UwYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=xOggf0i0n3EC5//lyzW10FgJ8QqbUqt/L75uffHitZA=;
        fh=wc2HNrKaTA2+A48BtJNz6PkPYCOiyOY6hPMcLirXIdU=;
        b=GGh+pyAK2sMqa25rTugrAgQ+b+hBYUdUlX1+T1BFi0Oyue11uScGG1ZDLX1tnCDfNx
         +faKH8mrRS5YXYBK653siFbleqBQONSeUeR7lzWv0LLBKNw5o41OuUnOUtZbabumGzlH
         ZQ9xPx7tOCh3xS4euqLeY43hQqnAVgvpPbpXXz+1tgHe+znK7sUgfEMAKFlr4BhDGbIn
         BIf/z4FqG4uL0Knqf6xRdA9GwdDryB/amloFwIUrobZqWWFNt+biH3HXHxWiXSHGqwEI
         VX6Pox7JY/FxLxP0rmIe4/SJatTgx87mi5pOo9WR+iqzi60sVpOiWBGRPplIO3B1nWdm
         v3nA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778610782; x=1779215582; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xOggf0i0n3EC5//lyzW10FgJ8QqbUqt/L75uffHitZA=;
        b=DKovfjm9YXapQokQrMe6EiSUEMY4NuOUbD2EAb8mBvbvXmWxF2VLL5WW584yLwm9U2
         h9NraFMhKa8uJa+R38ElEwYbbcjh5H+hHQ/0YVS6riAUzQ+R09ZxpURz72vXAUmyWbEs
         h9ZlNav5PbQ9BvIIGgfF+WU4PDVIpbkmu5jz5Z9zIyLxdCdETmlCxJbVVugtiV+WkVz8
         FG5NlIvFWmQyJVKaoW35KC7M0YydFkQ/S5sdQg10ERy4TNb+q8M8F9evHcSU33UeAkRv
         q0Oq6xMhdq3DYUz0ugKhvHQZKjudEJe85TWq/u3ruuJvuNxMAERjA+5CIm6DBw1ys+cl
         0NFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778610782; x=1779215582;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xOggf0i0n3EC5//lyzW10FgJ8QqbUqt/L75uffHitZA=;
        b=MK+SLKPHIGmTSL3+De42qUtgq5NvyYeQ4bgTgRQOfax6Da/J/JtfriyHiTQ9I7w0mX
         X7RLwn6/MR0IOYUqdOLzaQ9e/SXufnyz7wC1yFGGGJTcPR7C8zzW2D64r/ipxi2kpGIM
         OcJN5RVgWW+QsZnPS+zuCjqVU0TMM77qQu7pDk8xQN0Dd5Rkpta91EK1Kwh8nryymm7V
         tMaiIYQo89iTMioUrHrx9kkvBBxwIL5zgCQqZ7Fmx3CeDG2uwB3WUdbhXAEBXbWraO5f
         oXKsfmr9Mft+TgyQ4X95jZduv+/3vI7AQjHiQjcXlPXLj8biNompKmw5DMrq9MenPtRW
         kd4w==
X-Forwarded-Encrypted: i=1; AFNElJ/MjriHVxus1fp+wMQyXZwykvQ1NACybU20dReflI/S/YUOH/Y7pcPmou1w/WMHNs7nshuTA+cwH6B36ecl/OHP@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4YafstDN1NvJn2PDFUaUx+RkNHjvlrVXwFmmqYBTxDZdxlsO3
	HUna+GSrYKMw9k1h9Pf4RbUrP623LXF+npNOfrIdVZSAOAzZ+e+4rBekqRh7UxVOmGWvKGIQj5r
	RtOupLiZ/oYOER9VdEBxUN9AAn+vGLG6MNTdBOCgM
X-Gm-Gg: Acq92OFVLw6DUahBcT2Wdkc1rcD2GEwvu6wkLU8X+YtssWyFD8yewtQ4iuR4J1X+HF+
	PU6RdoDDBP+koXTP2w/EnT193A6ocfsMYRN8N61oVTkPE98XKWjjxliVnMwZDwabTdCaIthNb2J
	POsKFi2INgO8TFmd+B8IDMgiNelmjJVlx5Qi1aiR/vU5EAPDEs88Uy7cfiibAjMFAuI+tS9xnkO
	wWr2RN52ta9tsADKDhlctMaP6+Vf+2SzXel1WzunXNkWjrafQZaYV9ZaVchGXs5clXGibSlk8EO
	uzEVj2X6YmoFS95qiuqhICBmyfFl69v5KWrEAPHRqKPU89Tz
X-Received: by 2002:a05:7022:301:b0:130:5c2c:d255 with SMTP id
 a92af1059eb24-13414f7052emr46811c88.21.1778610781488; Tue, 12 May 2026
 11:33:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260510033424.255812-1-acme@kernel.org> <20260510033424.255812-27-acme@kernel.org>
In-Reply-To: <20260510033424.255812-27-acme@kernel.org>
From: Ian Rogers <irogers@google.com>
Date: Tue, 12 May 2026 11:32:48 -0700
X-Gm-Features: AVHnY4L2NNucqUZagGk3qZdASPRj-ca2gaIJqRu5vu6khWu-V8ChmWiWEdLoREk
Message-ID: <CAP-5=fU11BRywA+YaRV5X6iLw0zfm5ju2B9PuZ6yJn8aAtv4XQ@mail.gmail.com>
Subject: Re: [PATCH 26/28] perf timechart: Bounds check cpu_id and fix
 topology_map allocation
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>, Ingo Molnar <mingo@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, James Clark <james.clark@linaro.org>, 
	Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Clark Williams <williams@redhat.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	Arnaldo Carvalho de Melo <acme@redhat.com>, sashiko-bot@kernel.org, 
	"Claude Opus 4.6 (1M context)" <noreply@anthropic.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, May 9, 2026 at 8:37=E2=80=AFPM Arnaldo Carvalho de Melo <acme@kerne=
l.org> wrote:
>
> From: Arnaldo Carvalho de Melo <acme@redhat.com>
>
> The cpu_idle, cpu_frequency, power_start, and power_frequency
> tracepoint handlers extract cpu_id from the event payload via
> evsel__intval() and use it directly as an array index into
> cpus_cstate_start_times[] and cpus_pstate_start_times[], which
> are allocated with MAX_CPUS (4096) entries.
>
> Unlike sample->cpu which is validated in perf_session__deliver_event(),
> cpu_id comes from the tracepoint data and is never bounds checked.
> A crafted perf.data with a malicious cpu_id in a tracepoint event
> causes out-of-bounds array accesses.
>
> Validate cpu_id against tchart->numcpus (nr_cpus_avail from the
> file header) and reject the event with an error if it is out of
> range, as this indicates a corrupted or crafted file.
>
> The power_end handler uses sample->cpu (not a tracepoint cpu_id
> field).  Add a bounds check there too since a crafted file could
> omit PERF_SAMPLE_CPU, leaving sample->cpu as the (u32)-1 sentinel
> which would cause out-of-bounds access in c_state_end().
>
> Also validate sample->cpu in sched_switch and sched_wakeup
> handlers, which store it in cpu_sample structs later used as
> array indices into topology_map[] during SVG generation.
>
> Fix svg_build_topology_map() to allocate topology_map using
> nr_cpus_avail instead of nr_cpus_online.  When offline CPUs exist,
> nr_cpus_online < nr_cpus_avail, and a valid cpu_id that passes
> the numcpus check could still exceed the topology_map allocation,
> causing a heap out-of-bounds read in cpu2y().  Reject negative CPU
> values in str_to_bitmap() to prevent perf_cpu_map__new("") on an
> empty topology string from passing -1 to __set_bit(), which would
> write at offset ULONG_MAX/BITS_PER_LONG.
>
> Fix the pre-existing backtrace memory leak: change the
> tracepoint_handler typedef to pass const char **backtrace
> (pointer-to-pointer).  Handlers that consume the string
> (sched_switch, sched_wakeup) set *backtrace =3D NULL to claim
> ownership.  The caller always calls free() after the handler
> returns =E2=80=94 if ownership was taken the pointer is NULL and
> free(NULL) is a no-op.  Skip cat_backtrace() entirely when
> tchart->with_backtrace is not set.
>
> Cap tchart->numcpus at MAX_CPUS in the HEADER_NRCPUS callback
> so the bounds check cannot exceed the array allocation size.

So there are some overlaps with the changes in:
https://lore.kernel.org/lkml/20260413041143.1736055-18-irogers@google.com/
I'll repost the series that Namhyung started merging. It would be good
to rebase these changes on that.

Thanks,
Ian

> Reported-by: sashiko-bot@kernel.org # Running on a local machine
> Cc: Ian Rogers <irogers@google.com>
> Cc: Jiri Olsa <jolsa@kernel.org>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Assisted-by: Claude Opus 4.6 (1M context) <noreply@anthropic.com>
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> ---
>  tools/perf/builtin-timechart.c | 115 ++++++++++++++++++++++++++++-----
>  tools/perf/util/svghelper.c    |   6 +-
>  2 files changed, 104 insertions(+), 17 deletions(-)
>
> diff --git a/tools/perf/builtin-timechart.c b/tools/perf/builtin-timechar=
t.c
> index 40297f2dcd0353cc..bccc48cfb99a1d57 100644
> --- a/tools/perf/builtin-timechart.c
> +++ b/tools/perf/builtin-timechart.c
> @@ -71,6 +71,7 @@ struct timechart {
>         bool                    io_only,
>                                 skip_eagain;
>         u64                     io_events;
> +       u32                     nr_invalid_cpu;
>         u64                     min_time,
>                                 merge_dist;
>  };
> @@ -569,7 +570,7 @@ static const char *cat_backtrace(union perf_event *ev=
ent,
>  typedef int (*tracepoint_handler)(struct timechart *tchart,
>                                   struct evsel *evsel,
>                                   struct perf_sample *sample,
> -                                 const char *backtrace);
> +                                 const char **backtrace);
>
>  static int process_sample_event(const struct perf_tool *tool,
>                                 union perf_event *event,
> @@ -588,22 +589,46 @@ static int process_sample_event(const struct perf_t=
ool *tool,
>
>         if (evsel->handler !=3D NULL) {
>                 tracepoint_handler f =3D evsel->handler;
> -               return f(tchart, evsel, sample,
> -                        cat_backtrace(event, sample, machine));
> +               const char *bt =3D NULL;
> +               int ret;
> +
> +               if (tchart->with_backtrace)
> +                       bt =3D cat_backtrace(event, sample, machine);
> +               ret =3D f(tchart, evsel, sample, &bt);
> +               /*
> +                * Handlers that consume backtrace (sched_switch,
> +                * sched_wakeup) store the pointer and set *bt =3D NULL
> +                * to claim ownership.  For all other handlers bt is
> +                * still ours to free.  free(NULL) is safe.
> +                */
> +               free((void *)bt);
> +               return ret;
>         }
>
>         return 0;
>  }
>
>  static int
> -process_sample_cpu_idle(struct timechart *tchart __maybe_unused,
> +process_sample_cpu_idle(struct timechart *tchart,
>                         struct evsel *evsel,
>                         struct perf_sample *sample,
> -                       const char *backtrace __maybe_unused)
> +                       const char **backtrace __maybe_unused)
>  {
>         u32 state  =3D evsel__intval(evsel, sample, "state");
>         u32 cpu_id =3D evsel__intval(evsel, sample, "cpu_id");
>
> +       /*
> +        * cpu_id from tracepoint data indexes cpus_cstate_start_times[]
> +        * and cpus_pstate_start_times[], both allocated as MAX_CPUS
> +        * entries.  Reject out-of-range values to prevent OOB writes;
> +        * numcpus (from nr_cpus_avail) is the tighter, valid bound.
> +        */
> +       if (cpu_id >=3D tchart->numcpus) {
> +               pr_err("cpu_idle event cpu_id %u >=3D nr_cpus_avail %u\n"=
,
> +                      cpu_id, tchart->numcpus);
> +               return -EINVAL;
> +       }
> +
>         if (state =3D=3D (u32)PWR_EVENT_EXIT)
>                 c_state_end(tchart, cpu_id, sample->time);
>         else
> @@ -615,11 +640,18 @@ static int
>  process_sample_cpu_frequency(struct timechart *tchart,
>                              struct evsel *evsel,
>                              struct perf_sample *sample,
> -                            const char *backtrace __maybe_unused)
> +                            const char **backtrace __maybe_unused)
>  {
>         u32 state  =3D evsel__intval(evsel, sample, "state");
>         u32 cpu_id =3D evsel__intval(evsel, sample, "cpu_id");
>
> +       /* Same bounds check as process_sample_cpu_idle =E2=80=94 see com=
ment there */
> +       if (cpu_id >=3D tchart->numcpus) {
> +               pr_err("cpu_frequency event cpu_id %u >=3D nr_cpus_avail =
%u\n",
> +                      cpu_id, tchart->numcpus);
> +               return -EINVAL;
> +       }
> +
>         p_state_change(tchart, cpu_id, sample->time, state);
>         return 0;
>  }
> @@ -628,13 +660,20 @@ static int
>  process_sample_sched_wakeup(struct timechart *tchart,
>                             struct evsel *evsel,
>                             struct perf_sample *sample,
> -                           const char *backtrace)
> +                           const char **backtrace)
>  {
>         u8 flags  =3D evsel__intval(evsel, sample, "common_flags");
>         int waker =3D evsel__intval(evsel, sample, "common_pid");
>         int wakee =3D evsel__intval(evsel, sample, "pid");
>
> -       sched_wakeup(tchart, sample->cpu, sample->time, waker, wakee, fla=
gs, backtrace);
> +       /* sample->cpu used as index into topology_map[] during SVG gener=
ation */
> +       if (sample->cpu >=3D tchart->numcpus) {
> +               tchart->nr_invalid_cpu++;
> +               return 0;
> +       }
> +
> +       sched_wakeup(tchart, sample->cpu, sample->time, waker, wakee, fla=
gs, *backtrace);
> +       *backtrace =3D NULL;
>         return 0;
>  }
>
> @@ -642,27 +681,41 @@ static int
>  process_sample_sched_switch(struct timechart *tchart,
>                             struct evsel *evsel,
>                             struct perf_sample *sample,
> -                           const char *backtrace)
> +                           const char **backtrace)
>  {
>         int prev_pid   =3D evsel__intval(evsel, sample, "prev_pid");
>         int next_pid   =3D evsel__intval(evsel, sample, "next_pid");
>         u64 prev_state =3D evsel__intval(evsel, sample, "prev_state");
>
> +       /* sample->cpu used as index into topology_map[] during SVG gener=
ation */
> +       if (sample->cpu >=3D tchart->numcpus) {
> +               tchart->nr_invalid_cpu++;
> +               return 0;
> +       }
> +
>         sched_switch(tchart, sample->cpu, sample->time, prev_pid, next_pi=
d,
> -                    prev_state, backtrace);
> +                    prev_state, *backtrace);
> +       *backtrace =3D NULL;
>         return 0;
>  }
>
>  #ifdef SUPPORT_OLD_POWER_EVENTS
>  static int
> -process_sample_power_start(struct timechart *tchart __maybe_unused,
> +process_sample_power_start(struct timechart *tchart,
>                            struct evsel *evsel,
>                            struct perf_sample *sample,
> -                          const char *backtrace __maybe_unused)
> +                          const char **backtrace __maybe_unused)
>  {
>         u64 cpu_id =3D evsel__intval(evsel, sample, "cpu_id");
>         u64 value  =3D evsel__intval(evsel, sample, "value");
>
> +       /* Same bounds check as process_sample_cpu_idle =E2=80=94 see com=
ment there */
> +       if (cpu_id >=3D tchart->numcpus) {
> +               pr_err("power_start event cpu_id %" PRIu64 " >=3D nr_cpus=
_avail %u\n",
> +                      cpu_id, tchart->numcpus);
> +               return -EINVAL;
> +       }
> +
>         c_state_start(cpu_id, sample->time, value);
>         return 0;
>  }
> @@ -671,8 +724,16 @@ static int
>  process_sample_power_end(struct timechart *tchart,
>                          struct evsel *evsel __maybe_unused,
>                          struct perf_sample *sample,
> -                        const char *backtrace __maybe_unused)
> +                        const char **backtrace __maybe_unused)
>  {
> +       /*
> +        * sample->cpu is validated centrally when PERF_SAMPLE_CPU is
> +        * set, but a crafted file could omit it from sample_type.
> +        */
> +       if (sample->cpu >=3D tchart->numcpus) {
> +               tchart->nr_invalid_cpu++;
> +               return 0;
> +       }
>         c_state_end(tchart, sample->cpu, sample->time);
>         return 0;
>  }
> @@ -681,11 +742,18 @@ static int
>  process_sample_power_frequency(struct timechart *tchart,
>                                struct evsel *evsel,
>                                struct perf_sample *sample,
> -                              const char *backtrace __maybe_unused)
> +                              const char **backtrace __maybe_unused)
>  {
>         u64 cpu_id =3D evsel__intval(evsel, sample, "cpu_id");
>         u64 value  =3D evsel__intval(evsel, sample, "value");
>
> +       /* Same bounds check as process_sample_cpu_idle =E2=80=94 see com=
ment there */
> +       if (cpu_id >=3D tchart->numcpus) {
> +               pr_err("power_frequency event cpu_id %" PRIu64 " >=3D nr_=
cpus_avail %u\n",
> +                      cpu_id, tchart->numcpus);
> +               return -EINVAL;
> +       }
> +
>         p_state_change(tchart, cpu_id, sample->time, value);
>         return 0;
>  }
> @@ -1519,7 +1587,8 @@ static int process_header(struct perf_file_section =
*section __maybe_unused,
>
>         switch (feat) {
>         case HEADER_NRCPUS:
> -               tchart->numcpus =3D ph->env.nr_cpus_avail;
> +               /* Cap at MAX_CPUS =E2=80=94 the allocation size of cpus_=
cstate/pstate arrays */
> +               tchart->numcpus =3D min((int)ph->env.nr_cpus_avail, MAX_C=
PUS);
>                 break;
>
>         case HEADER_CPU_TOPOLOGY:
> @@ -1625,6 +1694,16 @@ static int __cmd_timechart(struct timechart *tchar=
t, const char *output_name)
>                                             tchart,
>                                             process_header);
>
> +       /*
> +        * Truncated files (interrupted recording) lose all feature
> +        * sections so the HEADER_NRCPUS callback never fires, and
> +        * pipe mode doesn't use perf_header__process_sections at all.
> +        * Fall back to MAX_CPUS =E2=80=94 the actual allocation size of =
the
> +        * cpus_cstate/pstate arrays.
> +        */
> +       if (!tchart->numcpus)
> +               tchart->numcpus =3D MAX_CPUS;
> +
>         if (!perf_session__has_traces(session, "timechart record"))
>                 goto out_delete;
>
> @@ -1646,6 +1725,12 @@ static int __cmd_timechart(struct timechart *tchar=
t, const char *output_name)
>
>         pr_info("Written %2.1f seconds of trace to %s.\n",
>                 (tchart->last_time - tchart->first_time) / (double)NSEC_P=
ER_SEC, output_name);
> +
> +       if (tchart->nr_invalid_cpu) {
> +               pr_warning("WARNING: %u events had invalid CPU values and=
 were skipped.\n"
> +                          "  Scheduling and power state data may be inco=
mplete.\n",
> +                          tchart->nr_invalid_cpu);
> +       }
>  out_delete:
>         perf_session__delete(session);
>         return ret;
> diff --git a/tools/perf/util/svghelper.c b/tools/perf/util/svghelper.c
> index e360e7736c7ba65b..a3c7cfecc072f3e3 100644
> --- a/tools/perf/util/svghelper.c
> +++ b/tools/perf/util/svghelper.c
> @@ -736,7 +736,8 @@ static int str_to_bitmap(char *s, cpumask_t *b, int n=
r_cpus)
>                 return -1;
>
>         perf_cpu_map__for_each_cpu(cpu, idx, map) {
> -               if (cpu.cpu >=3D nr_cpus) {
> +               /* perf_cpu_map__new("") yields cpu=3D-1; reject to preve=
nt __set_bit OOB */
> +               if (cpu.cpu < 0 || cpu.cpu >=3D nr_cpus) {
>                         ret =3D -1;
>                         break;
>                 }
> @@ -756,7 +757,8 @@ int svg_build_topology_map(struct perf_env *env)
>         char *sib_core, *sib_thr;
>         int ret =3D -1;
>
> -       nr_cpus =3D min(env->nr_cpus_online, MAX_NR_CPUS);
> +       /* Use nr_cpus_avail: offline CPUs still need slots in the topolo=
gy map */
> +       nr_cpus =3D min(env->nr_cpus_avail, MAX_NR_CPUS);
>
>         t.sib_core_nr =3D env->nr_sibling_cores;
>         t.sib_thr_nr =3D env->nr_sibling_threads;
> --
> 2.54.0
>
