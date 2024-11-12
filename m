Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDE6B20604B;
	Tue, 12 Nov 2024 21:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731447643; cv=none; b=EIFJSYeo2KF4igbkstOOFvie0QHx1xNju0C5wmYDFRdgRKir+f2A247AE0/ORYLfHp9YDIXbO2BvXC7O+W/Jxj4+a/bfW0I9BPItmfn8qCAUJFE1kg/SLxTo4+WPf8o1fgC/UoMILfmx+qj5JD3D3Cmj0xAseyI/wNAlsvoXrzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731447643; c=relaxed/simple;
	bh=edoAyla8Rqv0rNa7JGF9aon7gJr5YK26ByGNMwLc/Es=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=toEmsfgxlWU5ytZNSVBCIDKFQrpuOmcDNgoqgEFP+Bkgo0nHD2xqwZ2jWS8ktsuf2qY2ILbgEiz8ne3m1ni7bbPcrosGXFrBCeA1LI77agi8SGJHYOIemZMX3Ap782hptH5WP8PhUoXapxKURqNWuzFq0CUj9RLVJFkNm7+xQo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V1XnnVC6; arc=none smtp.client-ip=209.85.219.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V1XnnVC6"
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-e290e857d56so5895292276.1;
        Tue, 12 Nov 2024 13:40:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731447641; x=1732052441; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ra+hu73Jn9BLF/9oZjXy+Xnf5EDq8HGwgu7FojceqVg=;
        b=V1XnnVC6boMAdaU8Sqd1R0PK9uSwJOtZN4rhNEinfYpSUGbX049O3knszdZkzNEsHN
         EjmkPAj15nJRya3aOdCTLG3CuIzxfOktSNjAJjlnVF4oiMYalVTUPOz+o1rRab+ssitH
         aaqRRp3+671nd13VKtVcuqztCU4nl8+A5FnmII0vRUQQt1tTnngHTmv4FDtOWC5Tl0VO
         wYoJwFLXC7F9MAcCKwr9Bb+6651/ACSAd5RwPNSEdTYRd4MNdJPFaO3uIPcGHQ+PGZWL
         92NgZvZkVgvyMpP8SnWTPQ/9u4rtpWETedCRtruuk28B+37subJdp/0DlIy3nDVOmM/S
         1HDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731447641; x=1732052441;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ra+hu73Jn9BLF/9oZjXy+Xnf5EDq8HGwgu7FojceqVg=;
        b=jvMl+1Ut4rGrquGSiBVrg/iPUm+lNlfeDggydpzbKxxwf3Y3CalA2vzMzZX/h+8VrF
         iOmY9jdVsdJVX7YprQnSNZMPQNR47x54Jk7hTqfWLcRS7ZtWR7/mETItkbHbJ3hU/71f
         Iqvy6VphKVXOHM7P/hXf741h5q9R28eWAfx20K/3ottRd5SGhEilMmFwJjTAUh/FDzrN
         FV+YSSkJBGcEWHjDaVIVy9Fo/Uwcj5vfn//kx8/s7Fqf5DkQIvL8vLaTJGYGzPVsDnak
         WMQfc9/0E9bYCkNEgD5Rs3oK7YthvSwTPTgijiXe6gGY8gHmb7zG5JUTAWfddd8XKzax
         ooRg==
X-Forwarded-Encrypted: i=1; AJvYcCVwsv3P2VjsXszbR1gw3P7R12vclaYOsgMbZZxB+O4aWz9PY/90OcUmC7L3QH/S+qZjSn+BTt7uzZ3EeJs=@vger.kernel.org, AJvYcCXEBLCkWe7mVhTHGs6csVBbkxtNZSMb1PshMK6LC3uQ4cV9pecIsU1IBv1ebnjaekmCZlmodhSl7KZV3CVpuZB/Xw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwXUCzeu47cLR1VbkRQbqxxdrO1aJxKs0EqUZ6kGHXdKI+tdnSI
	vsE6r9v4R9T6ySzgeUjbjntXaMy3qIvCQGNq9LygFj5IwFiDqHPgq4cRJl+CzNr67C0vee2TWVw
	+QZXdNXswRvyx2wwiSIRAVyAS6EU=
X-Google-Smtp-Source: AGHT+IHbkkvhmT5jB1Iw/RfnrsZdesYrAU6+6bsibexySVnZzYJ+X09a4MVvrqvtiBACJ17tbPpFcwmArNAg+2sVOhY=
X-Received: by 2002:a05:6902:a04:b0:e33:1014:2d9c with SMTP id
 3f1490d57ef6-e337f8d3c6amr15832778276.50.1731447640783; Tue, 12 Nov 2024
 13:40:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241108204137.2444151-1-howardchu95@gmail.com>
 <20241108204137.2444151-10-howardchu95@gmail.com> <CAP-5=fX-+bcovrhgW585xZZEZv=bx+=w-Aw5Y8ONR3Q0dORA5Q@mail.gmail.com>
In-Reply-To: <CAP-5=fX-+bcovrhgW585xZZEZv=bx+=w-Aw5Y8ONR3Q0dORA5Q@mail.gmail.com>
From: Howard Chu <howardchu95@gmail.com>
Date: Tue, 12 Nov 2024 13:40:30 -0800
Message-ID: <CAH0uvoh76QH8OjBfrs_nRYHEirwDb+=hxbvJTRJQhY5DZKvLEw@mail.gmail.com>
Subject: Re: [PATCH v7 09/10] perf record --off-cpu: Dump the remaining
 samples in BPF's stack trace map
To: Ian Rogers <irogers@google.com>
Cc: acme@kernel.org, peterz@infradead.org, namhyung@kernel.org, 
	mingo@redhat.com, mark.rutland@arm.com, james.clark@linaro.org, 
	alexander.shishkin@linux.intel.com, jolsa@kernel.org, adrian.hunter@intel.com, 
	kan.liang@linux.intel.com, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Ian,

On Mon, Nov 11, 2024 at 10:07=E2=80=AFAM Ian Rogers <irogers@google.com> wr=
ote:
>
> On Fri, Nov 8, 2024 at 12:41=E2=80=AFPM Howard Chu <howardchu95@gmail.com=
> wrote:
> >
> > Dump the remaining samples, as if it is dumping a direct sample.
> >
> > Put the stack trace, tid, off-cpu time and cgroup id into the raw_data
> > section, just like a direct off-cpu sample coming from BPF's
> > bpf_perf_event_output().
> >
> > This ensures that evsel__parse_sample() correctly parses both direct
> > samples and accumulated samples.
>
> Nice, hopefully this should mean we can get rid of the logic holding
> all threads live for the sake of off-CPU, as off-CPU events were being
> "sampled" after threads had terminated
> (symbol_conf.keep_exited_threads). An example of this logic is:
> https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/=
tree/tools/perf/builtin-report.c?h=3Dperf-tools-next#n1484
> Perhaps there is a follow up to dump exiting processes with a BPF
> program on `tp/sched/sched_process_exit`. If the exited process is
> already "dumped" then its map entry can be removed which may lower
> overhead if off-CPU is running for a long time system wide.

Thanks for the advice, that's actually a great idea. IIUC, when a task
exits, dump its off-cpu time regardless of the threshold, and delete
the map entry to save space for other tasks.

>
>
> > Suggested-by: Namhyung Kim <namhyung@kernel.org>
> > Signed-off-by: Howard Chu <howardchu95@gmail.com>
>
> Reviewed-by: Ian Rogers <irogers@google.com>
>
> Thanks,
> Ian
>
> > ---
> >  tools/perf/util/bpf_off_cpu.c | 62 +++++++++++++++++++++--------------
> >  1 file changed, 38 insertions(+), 24 deletions(-)
> >
> > diff --git a/tools/perf/util/bpf_off_cpu.c b/tools/perf/util/bpf_off_cp=
u.c
> > index cfe5b17393e9..f1be354e2fe7 100644
> > --- a/tools/perf/util/bpf_off_cpu.c
> > +++ b/tools/perf/util/bpf_off_cpu.c
> > @@ -37,6 +37,8 @@ union off_cpu_data {
> >         u64 array[1024 / sizeof(u64)];
> >  };
> >
> > +u64 off_cpu_raw[MAX_STACKS + 5];
> > +
> >  static int off_cpu_config(struct evlist *evlist)
> >  {
> >         char off_cpu_event[64];
> > @@ -61,6 +63,9 @@ static int off_cpu_config(struct evlist *evlist)
> >  static void off_cpu_start(void *arg)
> >  {
> >         struct evlist *evlist =3D arg;
> > +       struct evsel *evsel;
> > +       struct perf_cpu pcpu;
> > +       int i, err;
> >
> >         /* update task filter for the given workload */
> >         if (skel->rodata->has_task && skel->rodata->uses_tgid &&
> > @@ -304,6 +309,7 @@ int off_cpu_write(struct perf_session *session)
> >  {
> >         int bytes =3D 0, size;
> >         int fd, stack;
> > +       u32 raw_size;
> >         u64 sample_type, val, sid =3D 0;
> >         struct evsel *evsel;
> >         struct perf_data_file *file =3D &session->data->file;
> > @@ -343,46 +349,54 @@ int off_cpu_write(struct perf_session *session)
> >
> >         while (!bpf_map_get_next_key(fd, &prev, &key)) {
> >                 int n =3D 1;  /* start from perf_event_header */
> > -               int ip_pos =3D -1;
> >
> >                 bpf_map_lookup_elem(fd, &key, &val);
> >
> > +               /* zero-fill some of the fields, will be overwritten by=
 raw_data when parsing */
> >                 if (sample_type & PERF_SAMPLE_IDENTIFIER)
> >                         data.array[n++] =3D sid;
> > -               if (sample_type & PERF_SAMPLE_IP) {
> > -                       ip_pos =3D n;
> > +               if (sample_type & PERF_SAMPLE_IP)
> >                         data.array[n++] =3D 0;  /* will be updated */
> > -               }
> >                 if (sample_type & PERF_SAMPLE_TID)
> > -                       data.array[n++] =3D (u64)key.pid << 32 | key.tg=
id;
> > +                       data.array[n++] =3D 0;
> >                 if (sample_type & PERF_SAMPLE_TIME)
> >                         data.array[n++] =3D tstamp;
> > -               if (sample_type & PERF_SAMPLE_ID)
> > -                       data.array[n++] =3D sid;
> >                 if (sample_type & PERF_SAMPLE_CPU)
> >                         data.array[n++] =3D 0;
> >                 if (sample_type & PERF_SAMPLE_PERIOD)
> > -                       data.array[n++] =3D val;
> > -               if (sample_type & PERF_SAMPLE_CALLCHAIN) {
> > -                       int len =3D 0;
> > -
> > -                       /* data.array[n] is callchain->nr (updated late=
r) */
> > -                       data.array[n + 1] =3D PERF_CONTEXT_USER;
> > -                       data.array[n + 2] =3D 0;
> > -
> > -                       bpf_map_lookup_elem(stack, &key.stack_id, &data=
.array[n + 2]);
> > -                       while (data.array[n + 2 + len])
> > +                       data.array[n++] =3D 0;
> > +               if (sample_type & PERF_SAMPLE_RAW) {
> > +                       /*
> > +                        *  [ size ][ data ]
> > +                        *  [     data     ]
> > +                        *  [     data     ]
> > +                        *  [     data     ]
> > +                        *  [ data ][ empty]
> > +                        */
> > +                       int len =3D 0, i =3D 0;
> > +                       void *raw_data =3D (void *)data.array + n * siz=
eof(u64);
> > +
> > +                       off_cpu_raw[i++] =3D (u64)key.pid << 32 | key.t=
gid;
> > +                       off_cpu_raw[i++] =3D val;
> > +
> > +                       /* off_cpu_raw[i] is callchain->nr (updated lat=
er) */
> > +                       off_cpu_raw[i + 1] =3D PERF_CONTEXT_USER;
> > +                       off_cpu_raw[i + 2] =3D 0;
> > +
> > +                       bpf_map_lookup_elem(stack, &key.stack_id, &off_=
cpu_raw[i + 2]);
> > +                       while (off_cpu_raw[i + 2 + len])
> >                                 len++;
> >
> > -                       /* update length of callchain */
> > -                       data.array[n] =3D len + 1;
> > +                       off_cpu_raw[i] =3D len + 1;
> > +                       i +=3D len + 2;
> > +
> > +                       off_cpu_raw[i++] =3D key.cgroup_id;
> >
> > -                       /* update sample ip with the first callchain en=
try */
> > -                       if (ip_pos >=3D 0)
> > -                               data.array[ip_pos] =3D data.array[n + 2=
];
> > +                       raw_size =3D i * sizeof(u64) + sizeof(u32); /* =
4 bytes for alignment */
> > +                       memcpy(raw_data, &raw_size, sizeof(raw_size));
> > +                       memcpy(raw_data + sizeof(u32), off_cpu_raw, i *=
 sizeof(u64));
> >
> > -                       /* calculate sample callchain data array length=
 */
> > -                       n +=3D len + 2;
> > +                       n +=3D i + 1;
> >                 }
> >                 if (sample_type & PERF_SAMPLE_CGROUP)
> >                         data.array[n++] =3D key.cgroup_id;
> > --
> > 2.43.0
> >

Thanks,
Howard
