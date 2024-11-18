Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F7FB1E5728;
	Mon, 18 Nov 2024 23:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731971118; cv=none; b=cnLxwvmzA0DlauutCzuaYtvUQE3MI5zQoKr/z81f0Gl+piCVaCFNCv3YPRNnBEYnUX8hFbcELydhYppChjhcKEH7CsNm+YB/P0702e84GoTC4G8WpN/yiEkUjE2KiwUDI9LJBv9kqzJSf8T5YDfKR3fgwjbqWWd3lN+IUTyvMSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731971118; c=relaxed/simple;
	bh=DJSKdXVIPOEThPpSykEYHwZAehCTUyDj3LyciXj+2vk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Nl74ZJdpPdbYRjVY8+eJH/HkmueT6dl1+OY4o+ClVw8RuvVLUP4XcoJnfOl5yUkTc1JzddREcjUlejh+tCVwMx1jRnoSXHQIg+TcqdoXqBWK+GO5mwdtm87w9nU58m70iVYpBznvk0nR5KUWveuCrDBs7fM/OL5+YfbYkPiQCrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JMKKOyRI; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JMKKOyRI"
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-6ea5003deccso24740067b3.0;
        Mon, 18 Nov 2024 15:05:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731971115; x=1732575915; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BxTumHwCtlrCxzAaYB8nl3+vY1LyT9fxkUQ0sELmdBY=;
        b=JMKKOyRIiY9HPG9W2rxv8czMD/wYzzO1S7fAhteF5/lLGT1t/Kl3T1t1irZbAdbiri
         WtH55kCnZYcwF7zxOXhJ/TJOqQn8zNVuBoDJmVDgQ3/fzxJios7I8b8IpuahGzIRrxaI
         nvBL7tBceha6KhMp/cXUoTX8WiZG5v8EdvgxgAIrnnbJ68aEOWW3s+NmcWtZyxJymxbG
         Sm9WjokKQHrT5/8r43oUhg6mt3Tp8Zs9bxJu4wkUWgWMqK1e0vtUplMV4IBVSdmC+OYb
         ijiRUiCNYl4KGFJt1BQR7SK4mIs/dMV37rhZGUZZpX9VvJ3TZhjbQFi7jx428vLYHl6Y
         OoyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731971115; x=1732575915;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BxTumHwCtlrCxzAaYB8nl3+vY1LyT9fxkUQ0sELmdBY=;
        b=lk2mJb7buCl0qIjcm/PwnUatdnlKisBke5qMtlCB7o3gsDoBULjm3b9J2BYQtvhpWk
         Cl1FYCpYDlP94y90bWHWECt4PNYE0u2+WrZsW1tkveVrGDEtkhZddcLcGlvY+Z0kbXln
         /UUh6vcu52kUSrMqA0ZXTT3oP6RSwNybl1a+dOKkYebC+7D7x4dPFeYMy/5AlzkzIRL3
         Vna+fto1LoVwYRoVK+/Oc4YVNQaDRo1n1L8dYJGasyAAgi4e1K5zMdsTupuyjW53H9u6
         gsmql7Lhkgl/so/ehT+N9bSQ/+R2pPYH64CIxey3Un31ByRIsB+ITGHKf4Se4Kf8X2OR
         CTKQ==
X-Forwarded-Encrypted: i=1; AJvYcCWM9OkYu86JddcFalzWUx6nw3f84rdFHc5i/jFKmWVEn1ih1CpTP/Lj6EFAg9ZT8Ku32j8HYiNM0o2AAsYq4svatQ==@vger.kernel.org, AJvYcCWWTYWlzyogEotxQ4tgeRvkjBb/ffk3IPR83JBF7MehdWVmGBE1kT4PqGOaCLAvrlT1HZaf6Cl8uM7g7e0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxEOg/p0MkhOXODaJcz1t259u6N9s2BVAtkBPEucBlO+/WNVIAY
	7wQxpeSGwC/R3i4PQa+BGy3NAlwdwiv+kJ7/gYY7phCOxjuZa6mOCjy70P2x+1ylZA0L33ZkZFf
	xlD9TEuLxIf66znLLfUhaZ/HcMCw=
X-Google-Smtp-Source: AGHT+IERpz+ZK4e5hCOdIfBdoQyU3lNtE/RKmlFpyQzv8KlTkLFyUnCzl8zN/1QcJn9yYZWoBaq5BG1IcF4lrA8FRzw=
X-Received: by 2002:a05:690c:3584:b0:6ea:4e1f:2b39 with SMTP id
 00721157ae682-6ee55bba29emr132793817b3.4.1731971115303; Mon, 18 Nov 2024
 15:05:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241113002818.3578645-1-howardchu95@gmail.com>
 <20241113002818.3578645-4-howardchu95@gmail.com> <Zzuu06ybvy8IpH5m@google.com>
In-Reply-To: <Zzuu06ybvy8IpH5m@google.com>
From: Howard Chu <howardchu95@gmail.com>
Date: Mon, 18 Nov 2024 15:05:04 -0800
Message-ID: <CAH0uvojJzoKMyPExfvCdCRBViQfyV_gs5k=bCnEpg9ApW_v1eg@mail.gmail.com>
Subject: Re: [PATCH v8 03/10] perf record --off-cpu: Parse off-cpu event
To: Namhyung Kim <namhyung@kernel.org>
Cc: acme@kernel.org, peterz@infradead.org, irogers@google.com, 
	mingo@redhat.com, jolsa@kernel.org, adrian.hunter@intel.com, 
	kan.liang@linux.intel.com, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, James Clark <james.clark@linaro.org>, 
	Mark Rutland <mark.rutland@arm.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

On Mon, Nov 18, 2024 at 1:17=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> On Tue, Nov 12, 2024 at 04:28:11PM -0800, Howard Chu wrote:
> > Parse the off-cpu event using parse_event(), as bpf-output.
> >
> > no-inherit should be set to 1, here's the reason:
> >
> > We update the BPF perf_event map for direct off-cpu sample dumping (in
> > following patches), it executes as follows:
> >
> > bpf_map_update_value()
> >  bpf_fd_array_map_update_elem()
> >   perf_event_fd_array_get_ptr()
> >    perf_event_read_local()
> >
> > In perf_event_read_local(), there is:
> >
> > int perf_event_read_local(struct perf_event *event, u64 *value,
> >                         u64 *enabled, u64 *running)
> > {
> > ...
> >       /*
> >        * It must not be an event with inherit set, we cannot read
> >        * all child counters from atomic context.
> >        */
> >       if (event->attr.inherit) {
> >               ret =3D -EOPNOTSUPP;
> >               goto out;
> >       }
> >
> > Which means no-inherit has to be true for updating the BPF perf_event
> > map.
> >
> > Moreover, for bpf-output events, we primarily want a system-wide event
> > instead of a per-task event.
> >
> > The reason is that in BPF's bpf_perf_event_output(), BPF uses the CPU
> > index to retrieve the perf_event file descriptor it outputs to.
> >
> > Making a bpf-output event system-wide naturally satisfies this
> > requirement by mapping CPU appropriately.
>
> I'm afraid the inherit attribute would be updated later:
>
>   __cmd_record()
>     evlist__config()
>       evsel__config()
>
> You can add a logic to check the config term when setting the inherit
> value.

Sure.

Thanks,
Howard
>
> Thanks,
> Namhyung
>
> >
> > Suggested-by: Namhyung Kim <namhyung@kernel.org>
> > Reviewed-by: Ian Rogers <irogers@google.com>
> > Signed-off-by: Howard Chu <howardchu95@gmail.com>
> > Cc: Adrian Hunter <adrian.hunter@intel.com>
> > Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> > Cc: Ingo Molnar <mingo@redhat.com>
> > Cc: James Clark <james.clark@linaro.org>
> > Cc: Jiri Olsa <jolsa@kernel.org>
> > Cc: Kan Liang <kan.liang@linux.intel.com>
> > Cc: Mark Rutland <mark.rutland@arm.com>
> > Cc: Peter Zijlstra <peterz@infradead.org>
> > Link: https://lore.kernel.org/r/20241108204137.2444151-4-howardchu95@gm=
ail.com
> > Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> > ---
> >  tools/perf/util/bpf_off_cpu.c | 33 +++++++++++----------------------
> >  1 file changed, 11 insertions(+), 22 deletions(-)
> >
> > diff --git a/tools/perf/util/bpf_off_cpu.c b/tools/perf/util/bpf_off_cp=
u.c
> > index a590a8ac1f9d..558c5e5c2dc3 100644
> > --- a/tools/perf/util/bpf_off_cpu.c
> > +++ b/tools/perf/util/bpf_off_cpu.c
> > @@ -38,32 +38,21 @@ union off_cpu_data {
> >
> >  static int off_cpu_config(struct evlist *evlist)
> >  {
> > +     char off_cpu_event[64];
> >       struct evsel *evsel;
> > -     struct perf_event_attr attr =3D {
> > -             .type   =3D PERF_TYPE_SOFTWARE,
> > -             .config =3D PERF_COUNT_SW_BPF_OUTPUT,
> > -             .size   =3D sizeof(attr), /* to capture ABI version */
> > -     };
> > -     char *evname =3D strdup(OFFCPU_EVENT);
> > -
> > -     if (evname =3D=3D NULL)
> > -             return -ENOMEM;
> >
> > -     evsel =3D evsel__new(&attr);
> > -     if (!evsel) {
> > -             free(evname);
> > -             return -ENOMEM;
> > +     scnprintf(off_cpu_event, sizeof(off_cpu_event), "bpf-output/no-in=
herit=3D1,name=3D%s/", OFFCPU_EVENT);
> > +     if (parse_event(evlist, off_cpu_event)) {
> > +             pr_err("Failed to open off-cpu event\n");
> > +             return -1;
> >       }
> >
> > -     evsel->core.attr.freq =3D 1;
> > -     evsel->core.attr.sample_period =3D 1;
> > -     /* off-cpu analysis depends on stack trace */
> > -     evsel->core.attr.sample_type =3D PERF_SAMPLE_CALLCHAIN;
> > -
> > -     evlist__add(evlist, evsel);
> > -
> > -     free(evsel->name);
> > -     evsel->name =3D evname;
> > +     evlist__for_each_entry(evlist, evsel) {
> > +             if (evsel__is_offcpu_event(evsel)) {
> > +                     evsel->core.system_wide =3D true;
> > +                     break;
> > +             }
> > +     }
> >
> >       return 0;
> >  }
> > --
> > 2.43.0
> >
