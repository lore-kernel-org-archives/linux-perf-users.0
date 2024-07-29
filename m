Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F5A9149DFF;
	Mon, 29 Jul 2024 13:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722260180; cv=none; b=drqC9DcyRZEFCVCbWYmZHwRBfGYjglUwTrAHV0JFvwfoCILGg7GVKiqonDo3NdUQKdcLL75RGw8fKkcriDcfNXXW5xXG/2jdlNQ7OenVPNCE/OA0/bDUNpj3SYcPaFIqOf07f0Qp7U/MnStSOLlHd2La5y3X6r/jYBMm/MHtuIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722260180; c=relaxed/simple;
	bh=QVTT06NNPJliH92NkECNKiURoA0/tmAa44n9BUdRjRk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tKUC57G7zNYVaKkSZwCQilt1fHMC8ySY53J0CsxckXZSuQnU2M15Xq6Q0CD0NykGKWXv9Q8X7evVoxfOmCumQysLJSxKlS2eSWEQnkACRMA2zBz0Pft23vnokPKtq6PB8N1nGEYpi3VtC5ds2XOjfn4TMVgWb9gs0rK0VwltTcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KFFpJ1aG; arc=none smtp.client-ip=209.85.219.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KFFpJ1aG"
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-e04196b7603so1806966276.0;
        Mon, 29 Jul 2024 06:36:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722260178; x=1722864978; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iCkAVJGO0Qq0npx1C9YnKPikcp6fVMOWG8vPQWN7D0Y=;
        b=KFFpJ1aGFRGii4f1cOjLznzKsPXzsyo05nNzn/wojOIbc3Gcr4EtjjPGn8tL2sM95n
         Zr4r11IYLsVtqkY46czyk2XYze/z2c2OKB/19b4ccJDul4SGdz7pexPOZuG2LJlOe7yB
         iY0vSswK+ZzO/jyoQyiz9+/3bp6Sf9LGDu6j5e6/LAJLiEUM88XgNtFrjwCWbcAUlUar
         LQDg0RLdZixzQZ5zjfyB1x4urzIyq0/ebY0AauQMLSA70UyrQI65RevGec1z5V0sJf3E
         mhAMu7afij8O3DhBcH3r4f+QBYyC0GkjoYkMvqmgs4WREa17T0Yj2wgTrlvcCI4iWNRq
         T6AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722260178; x=1722864978;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iCkAVJGO0Qq0npx1C9YnKPikcp6fVMOWG8vPQWN7D0Y=;
        b=vxno4KNkkVN5MD0o0Bj9JraVBVZ7CGI492uiaVeL7r0CrKOPzclwKEP+yARqK+3pl3
         NUTFqqEzDzVtnWebahnSOmitoYfeVblV1ZYjVl4DQauDmbsHa3RLR/rw/45ngZE9V31l
         Zs3z7EKNfEqzCO9xyQKwgjxqiCr/SWrW5YWqINDvdoaXyrLRDO15wnIuIUMnnB/HehMy
         yPhecLOUB4H4CTXLKJsAH2p3zFrh6Ln/hAJKT1XxnGIZvGepNe7/t0Tui8qx/AREUCTW
         aRbvi6FCckaRqHobsf22jee27R9706kW+dcB9upUjlhyoB3p8KrMCLM0JRAyUqPizOco
         vC+w==
X-Forwarded-Encrypted: i=1; AJvYcCUmEDzy2sLsmdvS3yJEVEJbtA3qeANE6qxtx9ABE1usVYVO+VcEE2KdWK8c2P9Oa+5bE7b3r21it6z6O+dMoIWU2floc6mUnS7ZYTgIrWN6x7ru0dY/URzY9jMRPF/q48iTr6ZQjCJyd2VwunHKDw==
X-Gm-Message-State: AOJu0YwWr3CraM/omFMfzhUEklzdf+R+zcDda9CmC2WJIyPREHI4LwLZ
	VG6OEq5jcySKKCwbk0w9NwH0i5zJhQTY5/PZ1jeh88PqQ8WA6fTpZfgo9yzdkgQFUEKOO1gF6lQ
	fVWpllvyObgwpG7DbCLOcEEwx3IuWvHULdEA=
X-Google-Smtp-Source: AGHT+IGaof0SFl/BiJyegHanTKpqjq+1dtgN8EzD5KFww/rzyLz/Wg+sEHD2v8X8lTsVxBKbxAuJ9dZnpA4b7mOURW0=
X-Received: by 2002:a05:6902:15ca:b0:e0b:3f83:54e4 with SMTP id
 3f1490d57ef6-e0b54402037mr7210260276.6.1722260178196; Mon, 29 Jul 2024
 06:36:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240726102826.787004-1-howardchu95@gmail.com>
 <20240726102826.787004-2-howardchu95@gmail.com> <CAP-5=fWi_FhQahxsKOaqdMp9agZqC3obHR_mo78+Ms9v1wZavg@mail.gmail.com>
In-Reply-To: <CAP-5=fWi_FhQahxsKOaqdMp9agZqC3obHR_mo78+Ms9v1wZavg@mail.gmail.com>
From: Howard Chu <howardchu95@gmail.com>
Date: Mon, 29 Jul 2024 21:36:07 +0800
Message-ID: <CAH0uvojbGkQKnvSi7gqtLVJQs2xxO2zBOLCukBiOKKPy7O0uFw@mail.gmail.com>
Subject: Re: [PATCH v3 1/5] perf record off-cpu: Add direct off-cpu event
To: Ian Rogers <irogers@google.com>
Cc: namhyung@kernel.org, acme@kernel.org, adrian.hunter@intel.com, 
	jolsa@kernel.org, kan.liang@linux.intel.com, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Ian,

On Sat, Jul 27, 2024 at 7:49=E2=80=AFAM Ian Rogers <irogers@google.com> wro=
te:
>
> On Fri, Jul 26, 2024 at 3:28=E2=80=AFAM Howard Chu <howardchu95@gmail.com=
> wrote:
> >
> > Add direct off-cpu event called "offcpu-time-direct". Add a threshold t=
o
> > dump direct off-cpu samples, "--off-cpu-thresh". Default value of
> > --off-cpu-thresh is UULONG_MAX(no direct off-cpu samples), and
> > --off-cpu-thresh's unit is milliseconds.
> >
> > Bind fds and sample_id in off_cpu_start()
> >
> > Note that we add "offcpu-time-direct" event using parse_event(), becaus=
e we
> > need to make it no-inherit, otherwise perf_event_open() will fail.
> >
> > Introduce sample_type_embed, indicating the sample_type of a sample
> > embedded in BPF output. More discussions in later patches.
> >
> > Signed-off-by: Howard Chu <howardchu95@gmail.com>
> > Suggested-by: Ian Rogers <irogers@google.com>
> > ---
> >  tools/perf/builtin-record.c   |  2 ++
> >  tools/perf/util/bpf_off_cpu.c | 53 ++++++++++++++++++++++++++++++++++-
> >  tools/perf/util/off_cpu.h     |  1 +
> >  tools/perf/util/record.h      |  1 +
> >  4 files changed, 56 insertions(+), 1 deletion(-)
> >
> > diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
> > index a94516e8c522..708d48d309d6 100644
> > --- a/tools/perf/builtin-record.c
> > +++ b/tools/perf/builtin-record.c
> > @@ -3325,6 +3325,7 @@ static struct record record =3D {
> >                 .ctl_fd              =3D -1,
> >                 .ctl_fd_ack          =3D -1,
> >                 .synth               =3D PERF_SYNTH_ALL,
> > +               .off_cpu_thresh      =3D ULLONG_MAX,
> >         },
> >         .tool =3D {
> >                 .sample         =3D process_sample_event,
> > @@ -3557,6 +3558,7 @@ static struct option __record_options[] =3D {
> >                             "write collected trace data into several da=
ta files using parallel threads",
> >                             record__parse_threads),
> >         OPT_BOOLEAN(0, "off-cpu", &record.off_cpu, "Enable off-cpu anal=
ysis"),
> > +       OPT_U64(0, "off-cpu-thresh", &record.opts.off_cpu_thresh, "time=
 threshold(in ms) for dumping off-cpu events"),
> >         OPT_END()
> >  };
> >
> > diff --git a/tools/perf/util/bpf_off_cpu.c b/tools/perf/util/bpf_off_cp=
u.c
> > index 6af36142dc5a..905a11c96c5b 100644
> > --- a/tools/perf/util/bpf_off_cpu.c
> > +++ b/tools/perf/util/bpf_off_cpu.c
> > @@ -13,6 +13,7 @@
> >  #include "util/cgroup.h"
> >  #include "util/strlist.h"
> >  #include <bpf/bpf.h>
> > +#include <internal/xyarray.h>
> >
> >  #include "bpf_skel/off_cpu.skel.h"
> >
> > @@ -45,10 +46,12 @@ static int off_cpu_config(struct evlist *evlist)
> >                 .size   =3D sizeof(attr), /* to capture ABI version */
> >         };
> >         char *evname =3D strdup(OFFCPU_EVENT);
> > +       char off_cpu_direct_event[64];
> >
> >         if (evname =3D=3D NULL)
> >                 return -ENOMEM;
> >
> > +       /* off-cpu event in the end */
> >         evsel =3D evsel__new(&attr);
> >         if (!evsel) {
> >                 free(evname);
> > @@ -65,12 +68,22 @@ static int off_cpu_config(struct evlist *evlist)
> >         free(evsel->name);
> >         evsel->name =3D evname;
> >
> > +       /* direct off-cpu event */
> > +       snprintf(off_cpu_direct_event, sizeof(off_cpu_direct_event), "b=
pf-output/no-inherit=3D1,name=3D%s/", OFFCPU_EVENT_DIRECT);
> > +       if (parse_event(evlist, off_cpu_direct_event)) {
> > +               pr_err("Failed to open off-cpu event\n");
> > +               return -1;
> > +       }
> > +
> >         return 0;
> >  }
> >
> >  static void off_cpu_start(void *arg)
> >  {
> >         struct evlist *evlist =3D arg;
> > +       struct evsel *evsel;
> > +       struct perf_cpu pcpu;
> > +       int i, err;
> >
> >         /* update task filter for the given workload */
> >         if (!skel->bss->has_cpu && !skel->bss->has_task &&
> > @@ -86,6 +99,27 @@ static void off_cpu_start(void *arg)
> >                 bpf_map_update_elem(fd, &pid, &val, BPF_ANY);
> >         }
> >
> > +       /* sample id and fds in BPF's perf_event_array can only be set =
after record__open() */
> > +       evsel =3D evlist__find_evsel_by_str(evlist, OFFCPU_EVENT_DIRECT=
);
> > +       if (evsel =3D=3D NULL) {
> > +               pr_err("%s evsel not found\n", OFFCPU_EVENT_DIRECT);
> > +               return;
> > +       }
> > +
> > +       if (evsel->core.id)
> > +               skel->bss->sample_id =3D evsel->core.id[0];
> > +
> > +       perf_cpu_map__for_each_cpu(pcpu, i, evsel->core.cpus) {
> > +               err =3D bpf_map__update_elem(skel->maps.offcpu_output,
> > +                                          &pcpu.cpu, sizeof(__u32),
> > +                                          xyarray__entry(evsel->core.f=
d, pcpu.cpu, 0),
> > +                                          sizeof(__u32), BPF_ANY);
> > +               if (err) {
> > +                       pr_err("Failed to update perf event map for dir=
ect off-cpu dumping\n");
> > +                       return;
> > +               }
> > +       }
> > +
> >         skel->bss->enabled =3D 1;
> >  }
> >
> > @@ -130,14 +164,24 @@ int off_cpu_prepare(struct evlist *evlist, struct=
 target *target,
> >  {
> >         int err, fd, i;
> >         int ncpus =3D 1, ntasks =3D 1, ncgrps =3D 1;
> > +       __u64 offcpu_thresh;
> >         struct strlist *pid_slist =3D NULL;
> >         struct str_node *pos;
> > +       struct evsel *evsel;
> >
> >         if (off_cpu_config(evlist) < 0) {
> >                 pr_err("Failed to config off-cpu BPF event\n");
> >                 return -1;
> >         }
> >
> > +       evsel =3D evlist__find_evsel_by_str(evlist, OFFCPU_EVENT_DIRECT=
);
> > +       if (evsel =3D=3D NULL) {
> > +               pr_err("%s evsel not found\n", OFFCPU_EVENT_DIRECT);
> > +               return -1 ;
> > +       }
> > +
> > +       evsel->sample_type_embed =3D OFFCPU_SAMPLE_TYPES;
> > +
> >         skel =3D off_cpu_bpf__open();
> >         if (!skel) {
> >                 pr_err("Failed to open off-cpu BPF skeleton\n");
> > @@ -250,7 +294,6 @@ int off_cpu_prepare(struct evlist *evlist, struct t=
arget *target,
> >         }
> >
> >         if (evlist__first(evlist)->cgrp) {
> > -               struct evsel *evsel;
> >                 u8 val =3D 1;
> >
> >                 skel->bss->has_cgroup =3D 1;
> > @@ -272,6 +315,14 @@ int off_cpu_prepare(struct evlist *evlist, struct =
target *target,
> >                 }
> >         }
> >
> > +       offcpu_thresh =3D opts->off_cpu_thresh;
> > +
> > +       if (opts->off_cpu_thresh !=3D ULLONG_MAX)
> > +               offcpu_thresh =3D opts->off_cpu_thresh * 1000000; /* of=
f-cpu-thresh is in ms */
>
> nit: In this comment, it's not clear if you are referring to the
> option or the variable. In modern languages it is usual to have some
> kind of "duration" type. As we're using u64s I'd be tempted to add a
> "_ms" suffix, just to make clear what the units for the time are. I
> think that'd make this:
> offcpu_thresh_ms =3D opts->off_cpu_thresh_ns * 1000000

I'll do this, but in microseconds as you requested in another review.

Thanks,
Howard

>
> Thanks,
> Ian
>
> > +
> > +       skel->bss->offcpu_thresh =3D offcpu_thresh;
> > +       skel->bss->sample_type   =3D OFFCPU_SAMPLE_TYPES;
> > +
> >         err =3D off_cpu_bpf__attach(skel);
> >         if (err) {
> >                 pr_err("Failed to attach off-cpu BPF skeleton\n");
> > diff --git a/tools/perf/util/off_cpu.h b/tools/perf/util/off_cpu.h
> > index 2dd67c60f211..a349f8e300e0 100644
> > --- a/tools/perf/util/off_cpu.h
> > +++ b/tools/perf/util/off_cpu.h
> > @@ -9,6 +9,7 @@ struct perf_session;
> >  struct record_opts;
> >
> >  #define OFFCPU_EVENT  "offcpu-time"
> > +#define OFFCPU_EVENT_DIRECT  "offcpu-time-direct"
> >
> >  #define OFFCPU_SAMPLE_TYPES  (PERF_SAMPLE_IDENTIFIER | PERF_SAMPLE_IP =
| \
> >                               PERF_SAMPLE_TID | PERF_SAMPLE_TIME | \
> > diff --git a/tools/perf/util/record.h b/tools/perf/util/record.h
> > index a6566134e09e..3c11416e6627 100644
> > --- a/tools/perf/util/record.h
> > +++ b/tools/perf/util/record.h
> > @@ -79,6 +79,7 @@ struct record_opts {
> >         int           synth;
> >         int           threads_spec;
> >         const char    *threads_user_spec;
> > +       u64           off_cpu_thresh;
> >  };
> >
> >  extern const char * const *record_usage;
> > --
> > 2.45.2
> >
