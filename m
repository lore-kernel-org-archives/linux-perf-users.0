Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EBA0148848
	for <linux-perf-users@vger.kernel.org>; Fri, 26 Jul 2024 23:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722037747; cv=none; b=tRR5o4PQshV2XOY9CgzDjejoTJn55nj0k/Dv2hxQMSt8lvwfgx1cjqxAQ0g42eWZ2CHrEaixkujSJFxJH9ZEFLPiuWrF1sCPGabZxV88mDp1/AV6YqzqI8LoP92N5e37HqnEzZvLZp1gd4RDYEXZefXOVCYMiAI3xuPKRRhE004=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722037747; c=relaxed/simple;
	bh=nbQAmLIvVZkzMXYyzjgZSHL3YvJp1sN6oP6f7dR4Ob8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=V+kwFB7dxfttzJ3RhB51vqY/pfn1AZIyV7O1XljIeN/WvPc6ztQpMJLCII+8EOP4Hc2WwK0s+F95WEnHu4psw6Wl1mZ01d9S4Gz2kebj6YOUtWYylx3dpPErRC23IxykYXFzW1CKyLNxs5oOkwZKbLrltjHNhLbXf+eAdFjOEbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wwJxJwAT; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wwJxJwAT"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1fd657c9199so68785ad.1
        for <linux-perf-users@vger.kernel.org>; Fri, 26 Jul 2024 16:49:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722037745; x=1722642545; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=26UwVmpvjibxv5HZF4j+xkY0oxrA+FZv7Yj8a7DqR0k=;
        b=wwJxJwATM/rEMhbGyuxQGQMF7ZlSUOqFIUAzDJel4jokXKMXIpP1wxa69FlWJkMC3u
         DsqnrcB82HetHtTi/0ofqHVjoP9cupMUsd0jc0dtntt6pdWY5PX4x1C2v8KrlSvRjQwq
         iJGYEl7zpMuE+OeGpU1sggZvxfgL6A3VmL2qAURex4e+cMp9bnwla+Ws+vQ797g2byLn
         7Kr8RGgmIyV6x2F8GXVtW0oNWSnVziq41F0KDxd/kWoDOYW9uQLOm3WLrsaU+ZocQhHR
         CheU7YdUb60fMRIlp6n9sta288fiDIU96NCTnywtaaRkr5wZ/Gxg4cl2bEEia81OkBX7
         GRVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722037745; x=1722642545;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=26UwVmpvjibxv5HZF4j+xkY0oxrA+FZv7Yj8a7DqR0k=;
        b=h+hmVZ2gjIS8ncih6Hb8F0uoLAaioZMk1riC4MKicHb6j1TRW542wMIP/ybFcxVzqV
         Pg1w/bje9uGpADaBeAlUUQllJXcQPMQHl8Kzv/eanpbDNpvhnGLHYtmKUdqSGxhHAAVD
         mdL3B5jbtxRV8mdf7iH9cCyrHRQc28+4xXUb8r3a+2jqdr1ZN7b0h5YcOJCkCT5L+nhT
         MtOXHatYt1xVKqySVmaN6rvFL7BSV0WkNFKjaRuMZLTqqsWROKnegcMSxAP04JTTXMJE
         z1hwASVOl8QTKh8aWDAPOiu26CcAJl7V8ppbhw7Ock6Y3rcztkZs6YaiSayPAFh/AttP
         PKcg==
X-Forwarded-Encrypted: i=1; AJvYcCWuhtzHTn6TZNKwhh24HlhC+ayM8GC3AGmpQK7JW3QykK3BD9eEGetJLOjGN1z6h9NSvkON7pYNwn/HhgDbLMBluapLfW71goOGW2v+2z+fpg==
X-Gm-Message-State: AOJu0YyTzkfdnn74SwkR1lY9Mll7rRSUt7tcsbqOULwHo+M1DZ1iETn9
	mTmshj3bXHtMr/S7qTbs1GAxJSHbLLSkzeVq/U37PKvdOcnDPZ6cISD8g3s9M/9Mo+QQ6nIW9cl
	u7ZJ+Vl3+10m/1H7KGeR9vktBkWKQ11IlotgE
X-Google-Smtp-Source: AGHT+IG6ZLaL5sWTQXFM/uooYEGuLijzAG7wOiEhXH8Qw3WkvEeJSkTXmuWkkO4Z1DyjjKWmXtiB6aZrFMavW8IVn/Y=
X-Received: by 2002:a17:902:d54f:b0:1fc:7357:9076 with SMTP id
 d9443c01a7336-1feee8554ecmr4744465ad.6.1722037744391; Fri, 26 Jul 2024
 16:49:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240726102826.787004-1-howardchu95@gmail.com> <20240726102826.787004-2-howardchu95@gmail.com>
In-Reply-To: <20240726102826.787004-2-howardchu95@gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Fri, 26 Jul 2024 16:48:52 -0700
Message-ID: <CAP-5=fWi_FhQahxsKOaqdMp9agZqC3obHR_mo78+Ms9v1wZavg@mail.gmail.com>
Subject: Re: [PATCH v3 1/5] perf record off-cpu: Add direct off-cpu event
To: Howard Chu <howardchu95@gmail.com>
Cc: namhyung@kernel.org, acme@kernel.org, adrian.hunter@intel.com, 
	jolsa@kernel.org, kan.liang@linux.intel.com, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 26, 2024 at 3:28=E2=80=AFAM Howard Chu <howardchu95@gmail.com> =
wrote:
>
> Add direct off-cpu event called "offcpu-time-direct". Add a threshold to
> dump direct off-cpu samples, "--off-cpu-thresh". Default value of
> --off-cpu-thresh is UULONG_MAX(no direct off-cpu samples), and
> --off-cpu-thresh's unit is milliseconds.
>
> Bind fds and sample_id in off_cpu_start()
>
> Note that we add "offcpu-time-direct" event using parse_event(), because =
we
> need to make it no-inherit, otherwise perf_event_open() will fail.
>
> Introduce sample_type_embed, indicating the sample_type of a sample
> embedded in BPF output. More discussions in later patches.
>
> Signed-off-by: Howard Chu <howardchu95@gmail.com>
> Suggested-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/builtin-record.c   |  2 ++
>  tools/perf/util/bpf_off_cpu.c | 53 ++++++++++++++++++++++++++++++++++-
>  tools/perf/util/off_cpu.h     |  1 +
>  tools/perf/util/record.h      |  1 +
>  4 files changed, 56 insertions(+), 1 deletion(-)
>
> diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
> index a94516e8c522..708d48d309d6 100644
> --- a/tools/perf/builtin-record.c
> +++ b/tools/perf/builtin-record.c
> @@ -3325,6 +3325,7 @@ static struct record record =3D {
>                 .ctl_fd              =3D -1,
>                 .ctl_fd_ack          =3D -1,
>                 .synth               =3D PERF_SYNTH_ALL,
> +               .off_cpu_thresh      =3D ULLONG_MAX,
>         },
>         .tool =3D {
>                 .sample         =3D process_sample_event,
> @@ -3557,6 +3558,7 @@ static struct option __record_options[] =3D {
>                             "write collected trace data into several data=
 files using parallel threads",
>                             record__parse_threads),
>         OPT_BOOLEAN(0, "off-cpu", &record.off_cpu, "Enable off-cpu analys=
is"),
> +       OPT_U64(0, "off-cpu-thresh", &record.opts.off_cpu_thresh, "time t=
hreshold(in ms) for dumping off-cpu events"),
>         OPT_END()
>  };
>
> diff --git a/tools/perf/util/bpf_off_cpu.c b/tools/perf/util/bpf_off_cpu.=
c
> index 6af36142dc5a..905a11c96c5b 100644
> --- a/tools/perf/util/bpf_off_cpu.c
> +++ b/tools/perf/util/bpf_off_cpu.c
> @@ -13,6 +13,7 @@
>  #include "util/cgroup.h"
>  #include "util/strlist.h"
>  #include <bpf/bpf.h>
> +#include <internal/xyarray.h>
>
>  #include "bpf_skel/off_cpu.skel.h"
>
> @@ -45,10 +46,12 @@ static int off_cpu_config(struct evlist *evlist)
>                 .size   =3D sizeof(attr), /* to capture ABI version */
>         };
>         char *evname =3D strdup(OFFCPU_EVENT);
> +       char off_cpu_direct_event[64];
>
>         if (evname =3D=3D NULL)
>                 return -ENOMEM;
>
> +       /* off-cpu event in the end */
>         evsel =3D evsel__new(&attr);
>         if (!evsel) {
>                 free(evname);
> @@ -65,12 +68,22 @@ static int off_cpu_config(struct evlist *evlist)
>         free(evsel->name);
>         evsel->name =3D evname;
>
> +       /* direct off-cpu event */
> +       snprintf(off_cpu_direct_event, sizeof(off_cpu_direct_event), "bpf=
-output/no-inherit=3D1,name=3D%s/", OFFCPU_EVENT_DIRECT);
> +       if (parse_event(evlist, off_cpu_direct_event)) {
> +               pr_err("Failed to open off-cpu event\n");
> +               return -1;
> +       }
> +
>         return 0;
>  }
>
>  static void off_cpu_start(void *arg)
>  {
>         struct evlist *evlist =3D arg;
> +       struct evsel *evsel;
> +       struct perf_cpu pcpu;
> +       int i, err;
>
>         /* update task filter for the given workload */
>         if (!skel->bss->has_cpu && !skel->bss->has_task &&
> @@ -86,6 +99,27 @@ static void off_cpu_start(void *arg)
>                 bpf_map_update_elem(fd, &pid, &val, BPF_ANY);
>         }
>
> +       /* sample id and fds in BPF's perf_event_array can only be set af=
ter record__open() */
> +       evsel =3D evlist__find_evsel_by_str(evlist, OFFCPU_EVENT_DIRECT);
> +       if (evsel =3D=3D NULL) {
> +               pr_err("%s evsel not found\n", OFFCPU_EVENT_DIRECT);
> +               return;
> +       }
> +
> +       if (evsel->core.id)
> +               skel->bss->sample_id =3D evsel->core.id[0];
> +
> +       perf_cpu_map__for_each_cpu(pcpu, i, evsel->core.cpus) {
> +               err =3D bpf_map__update_elem(skel->maps.offcpu_output,
> +                                          &pcpu.cpu, sizeof(__u32),
> +                                          xyarray__entry(evsel->core.fd,=
 pcpu.cpu, 0),
> +                                          sizeof(__u32), BPF_ANY);
> +               if (err) {
> +                       pr_err("Failed to update perf event map for direc=
t off-cpu dumping\n");
> +                       return;
> +               }
> +       }
> +
>         skel->bss->enabled =3D 1;
>  }
>
> @@ -130,14 +164,24 @@ int off_cpu_prepare(struct evlist *evlist, struct t=
arget *target,
>  {
>         int err, fd, i;
>         int ncpus =3D 1, ntasks =3D 1, ncgrps =3D 1;
> +       __u64 offcpu_thresh;
>         struct strlist *pid_slist =3D NULL;
>         struct str_node *pos;
> +       struct evsel *evsel;
>
>         if (off_cpu_config(evlist) < 0) {
>                 pr_err("Failed to config off-cpu BPF event\n");
>                 return -1;
>         }
>
> +       evsel =3D evlist__find_evsel_by_str(evlist, OFFCPU_EVENT_DIRECT);
> +       if (evsel =3D=3D NULL) {
> +               pr_err("%s evsel not found\n", OFFCPU_EVENT_DIRECT);
> +               return -1 ;
> +       }
> +
> +       evsel->sample_type_embed =3D OFFCPU_SAMPLE_TYPES;
> +
>         skel =3D off_cpu_bpf__open();
>         if (!skel) {
>                 pr_err("Failed to open off-cpu BPF skeleton\n");
> @@ -250,7 +294,6 @@ int off_cpu_prepare(struct evlist *evlist, struct tar=
get *target,
>         }
>
>         if (evlist__first(evlist)->cgrp) {
> -               struct evsel *evsel;
>                 u8 val =3D 1;
>
>                 skel->bss->has_cgroup =3D 1;
> @@ -272,6 +315,14 @@ int off_cpu_prepare(struct evlist *evlist, struct ta=
rget *target,
>                 }
>         }
>
> +       offcpu_thresh =3D opts->off_cpu_thresh;
> +
> +       if (opts->off_cpu_thresh !=3D ULLONG_MAX)
> +               offcpu_thresh =3D opts->off_cpu_thresh * 1000000; /* off-=
cpu-thresh is in ms */

nit: In this comment, it's not clear if you are referring to the
option or the variable. In modern languages it is usual to have some
kind of "duration" type. As we're using u64s I'd be tempted to add a
"_ms" suffix, just to make clear what the units for the time are. I
think that'd make this:
offcpu_thresh_ms =3D opts->off_cpu_thresh_ns * 1000000

Thanks,
Ian

> +
> +       skel->bss->offcpu_thresh =3D offcpu_thresh;
> +       skel->bss->sample_type   =3D OFFCPU_SAMPLE_TYPES;
> +
>         err =3D off_cpu_bpf__attach(skel);
>         if (err) {
>                 pr_err("Failed to attach off-cpu BPF skeleton\n");
> diff --git a/tools/perf/util/off_cpu.h b/tools/perf/util/off_cpu.h
> index 2dd67c60f211..a349f8e300e0 100644
> --- a/tools/perf/util/off_cpu.h
> +++ b/tools/perf/util/off_cpu.h
> @@ -9,6 +9,7 @@ struct perf_session;
>  struct record_opts;
>
>  #define OFFCPU_EVENT  "offcpu-time"
> +#define OFFCPU_EVENT_DIRECT  "offcpu-time-direct"
>
>  #define OFFCPU_SAMPLE_TYPES  (PERF_SAMPLE_IDENTIFIER | PERF_SAMPLE_IP | =
\
>                               PERF_SAMPLE_TID | PERF_SAMPLE_TIME | \
> diff --git a/tools/perf/util/record.h b/tools/perf/util/record.h
> index a6566134e09e..3c11416e6627 100644
> --- a/tools/perf/util/record.h
> +++ b/tools/perf/util/record.h
> @@ -79,6 +79,7 @@ struct record_opts {
>         int           synth;
>         int           threads_spec;
>         const char    *threads_user_spec;
> +       u64           off_cpu_thresh;
>  };
>
>  extern const char * const *record_usage;
> --
> 2.45.2
>
