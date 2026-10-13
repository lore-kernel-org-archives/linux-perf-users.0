Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D97B651CF79
	for <linux-perf-users@vger.kernel.org>; Tue, 13 Oct 2026 13:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791898166; cv=pass; b=KIIDXFwmMWLMxyvaG5AuXx2gUdDTAUNdn7Gxr85PD5NiZ+o/GpDeVue0AA5l/mVTfIaarDX/Q0cuOhZaYZuj/6Sl8wozRNs0jT2EQbjym39h18q9ROTvUqfeafMN21TxTsSNcz6NYaQ5DJTsyvBmLKaa4NAgXp66yNUueBPosVI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791898166; c=relaxed/simple;
	bh=xFG8pRzJwqHSYz1ahl0Nv6+CxBGkp2FcavjQZZvSvWk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eDwifmb3SUwxAUZEQFeddwEwN9wk2jI84MbppkarGZwVT2dJPV7DQ/iHObiZ7RESlCHaVBhA2JkCmtvAHq0dpZg+F014beg4uou+EabSLwhs8R2S779SnEuSQUyZ4/X6u61XDc88P+sys7MektrbIxhIFHQTvJ6xLMZRGopTMuo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YtNH8fIT; arc=pass smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YtNH8fIT"
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-535f598d126so124741cf.1
        for <linux-perf-users@vger.kernel.org>; Tue, 13 Oct 2026 06:29:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791898164; cv=none;
        d=google.com; s=arc-20260327;
        b=SpoiJNRPEYl4ww1x1C5vcbDcVqrGKcXEx35qR9373BAIOrES+c9NEjJllytGQCt6E6
         q/b4B46cvcYqi7kqD2WuoUuW/ao4+L4jq1wM1A02B5PuoojzOb1Zb1be5TGR3st7UCyi
         eiDDKrUgJB7RX18vWnCY97O/DB7I+MtXIXWajnt1CQMveGOzke3GsQdZw5qYrLmWApTk
         lNn3MTCeZQhRHsfezaT/Dw/QNOH/jvKqg/72+MhPCvOVbIwizmLNYnGiA8O3aJiU0Oib
         jkJFBmuGV8L0zmwrFL/XlSkACLEp5YDnlcLNUnIo/c6Ub144JPxG/m2qJbY4qFUauMlc
         cnKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=k2ZJ67cl4IO2/wFBLGAmZXVM6FrfonA4qhd6y3/BX5E=;
        fh=j5cOap2bf93JoSc+5D7Szm5or8HOFpsDLQwK5VXr8B8=;
        b=BGuOBo/vVw5ucUexaXKCt5BUVwl2PlYOmXfBfvsOEf6oikO7+1Bd1CPbRQ4WJMtS40
         jmHJYsSkwGJIQsnJSPBZm1ASivTTKQoGz3g23OqLyw8Zajy4jYUyeISxu3kVqzPFlxPX
         ggVGyFGgBD3ljGRqMxMQD6LPWyz7eZgSmaBNYAkJhUcYxqoEtohkwOV2lT818yN/Pfw5
         CSo/3Unzq8U8fAGCdVVhMH9yZaZB8jn6CdtF0ZpxHO2lCx4KPW9/0iNeIoS60fITModJ
         45HIwUEMpnDFGOSsvx2RrjOnNoKm4Fv7rXJDA6mPlOnJTFcsgcdV532l9Wh8fW5WdOBk
         NPEQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791898164; x=1792502964; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=k2ZJ67cl4IO2/wFBLGAmZXVM6FrfonA4qhd6y3/BX5E=;
        b=YtNH8fITsvMujN7RZkU30AVJ43qxbhH8Nscqj2RI3xtLnFjxUaAYK/U4oupekgX9Rs
         r6ONbx7WMkpPaWhf/NfIIz5H6hcpUUqBJ0zZtgmJHr5uWo8rOVvorpYFeLkpD0kaa3mv
         5Xoee0IU5P7A0XKwIVLl0F51vFlj7nh0wA3npOJTVrP6nTl9ZZOgsozbMjlcpaKOkx75
         l4oaVwhSOaFVW9SSDvaP2S7/7nEOBHjb801f4ynipHdNXz81JPJlHNSgVr1jaaDbDCAx
         aydpreIqB1AZ/dgThdL4fOa2JoQF2cGsPZfZbcH8shngkilrDGyEjX3++vcU/GyH6Tim
         FZMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791898164; x=1792502964;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=k2ZJ67cl4IO2/wFBLGAmZXVM6FrfonA4qhd6y3/BX5E=;
        b=v2T5V/0oZmh2cZM+uTfxJZFI9mlj7oXcoHvxm6H0zhatCqQX1L+o8SXzRFqMDmVDxk
         VBjTgBincBgE2GHCeflcexijtdcTnJiJjNnSrbNf07MICOFgFLGQPhKmi5afr8d847PJ
         dYiaWjDyNvDBE+d46hq76zkMVP0HExWOOXhETRlg7H6tzjgaiIQ/SNX2qyzCaNVswsbY
         H/bAi8h8TOUFA6I74m2jhSot3ZKlpf18CisuNPdgxixr2x6R0n2MzKi/hZshOAMBjBqm
         rI1DkCY1zxKqr1gsUK3CEpHgSWi1ChpkwZLnH8qrg1+R0/j/eE0twT1lsca/LG+aaJ/W
         bmug==
X-Forwarded-Encrypted: i=1; AKwUvBxFYhyhxJieqtO0jpAY2GRHqhizVlTFhiYyipbiWOrMLIfiQsrmIOmyc+99NC4XKjuiU/Dz63nCNiIi/lbMdzUv@vger.kernel.org
X-Gm-Message-State: AFq9FYL9eF41BDeEkWr0DWNhwYQgJ7ncsHsqHMC13V9rlp4ltQKC8mT4
	q8Rt8XgeCmatU2Lszryuldx2iLKW8wQD5tVrtO324/d00Nqh4C4enIor30AQBKzKdgBTNw+Q/B5
	++GO1kdlS+K0rX5IYSBBQ4+lcjbyI73+mAo6u7fpA
X-Gm-Gg: AYBFou0AQ2rE0EX/ePt8sagUYjVgyVh1R7q2I638lJcWs9O12iSCCPmgBCYeZQeut2T
	PHNJJXe5zfbAsJ/LF6ps+3G5as/BmHtzAy3H7YrdKFFfZsI70GIggZfSXtbEuw7TlBOel1kA2zY
	0t9ogx1veA/bFQrbWA7qFaE2lwmwU388R5bN9ST0vitfF5qJgfitZeFLCg7CAbRLpWqA+Dfxu7g
	LcGZTRW6CjE2jpyPd9FMjGpr+KFw3DsxmMJ2LYf+jQZwqCimTGxOxx1YLWZE+CWzaqLNZQdUbOO
	I+Oe/8ujrErTpozzkpDwzUfQOWXLti4R9+/bwjRLVzw1+6201PbdaYpq
X-Received: by 2002:a05:622a:1f0c:b0:534:b7b2:634f with SMTP id
 d75a77b69052e-535b4eca219mr52262061cf.8.1791898162935; Tue, 13 Oct 2026
 06:29:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261013130052.3012773-1-max.kellermann@ionos.com>
In-Reply-To: <20261013130052.3012773-1-max.kellermann@ionos.com>
From: Ian Rogers <irogers@google.com>
Date: Tue, 13 Oct 2026 06:29:10 -0700
X-Gm-Features: AclHuK9sirKJ2K2WjUv42s8M4AHEmquQGSkkZvKFoqEcv8urLNEiHGZTNG_l-lQ
Message-ID: <CAP-5=fVPtjkxcjEkR9r6QZGsoKe=_rZssjZp1FcJ7rCgntpPng@mail.gmail.com>
Subject: Re: [PATCH] perf: skip unnecessary userspace map synthesis
To: Max Kellermann <max.kellermann@ionos.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	Dapeng Mi <dapeng1.mi@linux.intel.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 13, 2026 at 6:00=E2=80=AFAM Max Kellermann <max.kellermann@iono=
s.com> wrote:
>
> Reading `/proc/PID/task/PID/maps` for existing processes is expensive
> on systems with many processes.  `perf record` already allows skipping
> these reads with the `--synth=3D` option, but `perf top` has no
> equivalent option.
>
> Skip userspace map synthesis by default in `record` and `top` when all
> events exclude userspace and no sample feature needs user mappings.
>
> Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
> ---
>  tools/perf/Documentation/perf-record.txt |  4 +++
>  tools/perf/builtin-record.c              |  8 +++++
>  tools/perf/builtin-top.c                 | 19 +++++------
>  tools/perf/util/evlist.c                 | 40 ++++++++++++++++++++++++
>  tools/perf/util/evlist.h                 |  1 +
>  tools/perf/util/record.h                 |  1 +
>  6 files changed, 64 insertions(+), 9 deletions(-)
>
> diff --git a/tools/perf/Documentation/perf-record.txt b/tools/perf/Docume=
ntation/perf-record.txt
> index 178f483140ed..cdef14f22df3 100644
> --- a/tools/perf/Documentation/perf-record.txt
> +++ b/tools/perf/Documentation/perf-record.txt
> @@ -696,6 +696,10 @@ Available types are:
>    - 'all'     - synthesize all events (default)
>    - 'no'      - do not synthesize any of the above events
>
> +By default, userspace MMAP synthesis is skipped if all events exclude
> +userspace (for example, with --all-kernel or -e cycles:k) and their
> +samples do not need userspace maps.
> +
>  --tail-synthesize::
>  Instead of collecting non-sample events (for example, fork, comm, mmap) =
at
>  the beginning of record, collect them during finalizing an output file.
> diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
> index a57987851cf0..f8b4e5279fca 100644
> --- a/tools/perf/builtin-record.c
> +++ b/tools/perf/builtin-record.c
> @@ -2574,6 +2574,13 @@ static int __cmd_record(struct record *rec, int ar=
gc, const char **argv)
>
>         evlist__config(rec->evlist, opts, &callchain_param);
>
> +       if (!opts->synth_set && !opts->full_auxtrace &&
> +           !opts->auxtrace_sample_mode && !rec->off_cpu && !rec->buildid=
_all &&
> +           !evlist__needs_user_mmaps(rec->evlist)) {
> +               opts->synth &=3D ~PERF_SYNTH_MMAP;
> +               pr_debug("Skipping synthesis of userspace maps for kernel=
-only recording\n");
> +       }
> +
>         /* Debug message used by test scripts */
>         pr_debug3("perf record opening and mmapping events\n");
>         if (record__open(rec) !=3D 0) {
> @@ -3412,6 +3419,7 @@ static int parse_record_synth_option(const struct o=
ption *opt,
>                 pr_err("Invalid synth option: %s\n", str);
>                 return -1;
>         }
> +       opts->synth_set =3D true;
>         return 0;
>  }
>
> diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
> index 570410599f1b..d85ecc140eda 100644
> --- a/tools/perf/builtin-top.c
> +++ b/tools/perf/builtin-top.c
> @@ -1017,14 +1017,6 @@ static int perf_top__start_counters(struct perf_to=
p *top)
>         struct evlist *evlist =3D top->evlist;
>         struct record_opts *opts =3D &top->record_opts;
>
> -       if (perf_top__overwrite_check(top)) {
> -               ui__error("perf top only support consistent per-event "
> -                         "overwrite setting for all events\n");
> -               goto out_err;
> -       }
> -
> -       evlist__config(evlist, opts, &callchain_param);
> -
>         evlist__for_each_entry(evlist, counter) {
>  try_again:
>                 if (evsel__open(counter, counter->core.cpus,
> @@ -1265,6 +1257,14 @@ static int __cmd_top(struct perf_top *top)
>         if (ret)
>                 return ret;
>
> +       if (perf_top__overwrite_check(top)) {
> +               ui__error("perf top only support consistent per-event "
> +                         "overwrite setting for all events\n");
> +               return -1;
> +       }
> +
> +       evlist__config(top->evlist, opts, &callchain_param);
> +
>         if (perf_session__register_idle_thread(top->session) < 0)
>                 return ret;
>
> @@ -1296,7 +1296,8 @@ static int __cmd_top(struct perf_top *top)
>                 pr_debug("Couldn't synthesize cgroup events.\n");
>
>         machine__synthesize_threads(&top->session->machines.host, &opts->=
target,
> -                                   evlist__core(top->evlist)->threads, t=
rue, false,
> +                                   evlist__core(top->evlist)->threads,
> +                                   evlist__needs_user_mmaps(top->evlist)=
, false,
>                                     top->nr_threads_synthesize);
>
>         perf_set_multithreaded();
> diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
> index c3d784727810..6636edee0d2b 100644
> --- a/tools/perf/util/evlist.c
> +++ b/tools/perf/util/evlist.c
> @@ -1990,6 +1990,46 @@ bool evlist__exclude_kernel(struct evlist *evlist)
>         return true;
>  }
>
> +bool evlist__needs_user_mmaps(struct evlist *evlist)
> +{
> +       struct evsel *evsel;
> +       bool has_kernel_event =3D false;
> +
> +       evlist__for_each_entry(evlist, evsel) {
> +               struct perf_event_attr *attr =3D &evsel->core.attr;
> +
> +               /* Tracking events do not produce samples, regardless of =
modifiers. */
> +               if (evsel__is_dummy_event(evsel))
> +                       continue;
> +
> +               if (!attr->exclude_user)
> +                       return true;
> +
> +               /* Kernel samples can still contain a userspace callchain=
. */
> +               if ((attr->sample_type & PERF_SAMPLE_CALLCHAIN) &&
> +                   !attr->exclude_callchain_user)
> +                       return true;
> +
> +               /*
> +                * These may reference userspace even when the sampled
> +                * IP is in the kernel.  Keep maps for opaque trace
> +                * payloads and AUX trace decoding too, whose address
> +                * requirements are PMU specific.
> +                */
> +               if (attr->sample_type & (PERF_SAMPLE_ADDR | PERF_SAMPLE_R=
AW |
> +                                        PERF_SAMPLE_REGS_USER | PERF_SAM=
PLE_STACK_USER |
> +                                        PERF_SAMPLE_BRANCH_STACK | PERF_=
SAMPLE_AUX))
> +                       return true;
> +
> +               if (evsel__is_aux_event(evsel))
> +                       return true;
> +
> +               has_kernel_event =3D true;
> +       }
> +
> +       return !has_kernel_event;

Thanks for the contribution! I can see if there's a user event then
evlist__needs_user_mmaps will return true, otherwise we'll return
false if there's a kernel event but true if the list is empty or just
contains dummy events. Why do the empty list and dummy case need the
user mmap events?

Thanks,
Ian

> +}
> +
>  /*
>   * Events in data file are not collect in groups, but we still want
>   * the group display. Set the artificial group and set the leader's
> diff --git a/tools/perf/util/evlist.h b/tools/perf/util/evlist.h
> index 838e263b76f3..b208bf7211e8 100644
> --- a/tools/perf/util/evlist.h
> +++ b/tools/perf/util/evlist.h
> @@ -631,6 +631,7 @@ struct evsel *evlist__find_evsel_by_str(struct evlist=
 *evlist, const char *str);
>  struct evsel *evlist__event2evsel(struct evlist *evlist, union perf_even=
t *event);
>
>  bool evlist__exclude_kernel(struct evlist *evlist);
> +bool evlist__needs_user_mmaps(struct evlist *evlist);
>
>  void evlist__force_leader(struct evlist *evlist);
>
> diff --git a/tools/perf/util/record.h b/tools/perf/util/record.h
> index 93627c9a7338..1317ddce3cf0 100644
> --- a/tools/perf/util/record.h
> +++ b/tools/perf/util/record.h
> @@ -80,6 +80,7 @@ struct record_opts {
>         int           ctl_fd_ack;
>         bool          ctl_fd_close;
>         int           synth;
> +       bool          synth_set;
>         int           threads_spec;
>         const char    *threads_user_spec;
>         u64           off_cpu_thresh_ns;
> --
> 2.47.3
>
