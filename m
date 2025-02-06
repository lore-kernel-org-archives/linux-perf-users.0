Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 077D31DF96E;
	Thu,  6 Feb 2025 22:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738879759; cv=none; b=q5XI6TukBaq7g31kkLK6SOAFtuhSLDft/Y4yq6GuinesgYv4wHIgj40YCu5+H6oGdNKI1jWD2vjaTkZH2yrqtiuCas45yITGtNX8b49JdxW9yu0y1JVKfSP6Z2jpAc6rq9bOSbr9LzRDHi0KxzTLviI5kwh1xIf9gGQTqTodRKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738879759; c=relaxed/simple;
	bh=C0O1HP8xhbAgcrX6+/kH2eP7TCZJdrbdIByOFmK5xlw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SrZg8JPe0b9Oth3CAf8uIIzeZS74SA912b7YWWsx1XH9KyMzhveR8YvLY1fs3GkqsYZVfbn/JNgQnjyoHFG9xfz9QJiYD4cn2jo/qx7Hg/cgMmC6kLqDwIMMZlRUpUOVCeFuNTLqzR8z9NJAvMsmZPaPva57eslyU/lela3YXBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LnhUWElU; arc=none smtp.client-ip=209.85.219.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LnhUWElU"
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-e545c1e8a15so1284270276.1;
        Thu, 06 Feb 2025 14:09:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738879754; x=1739484554; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KjgXj0CUYH9Bv190fbSnudV5Idq06JKQoyp91xyEpaM=;
        b=LnhUWElUW3KuQ4zIDlCgERGppkq5XnfhJEKzA2NI/+QphdIEP081KcKs2k08PrpdV5
         BGvc1pEaC306DaOfT+UKB9IbjlYBJucXmZMAo1OG/yfhJPJqNV5MB6yEbHFd2K8dnifp
         0y64IgsSfsWV6e16AxGwBm5B1v5KAytkpwv+25JEfn5yo+ICsHHbjLQ17qQovYbBOQdG
         vzK35o0IqicWCxg2+WuXGu2kGS4OaMp/sH/6CJslY6X2kzanA5o4U5QEPfdO6Kv1v0mq
         6AVZnofklY6GFzHe23chz4SrXsTUkvEo9wAA7NbAP4Tj7juwKXrDDfQD3qzsCnDn4+3T
         o+ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738879754; x=1739484554;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KjgXj0CUYH9Bv190fbSnudV5Idq06JKQoyp91xyEpaM=;
        b=OZ2sohLhFyrnvW7V3oRUi6REwJdGGGOgEk+t62KV8B/7esicd/om2gJ9FVUVyczM89
         +s5hV0QLn7mMjSd5jIF1ZsFL1EKskcjFOocmeDLwT3yOIk69IM6rAchb9QSMD4lpfnie
         84YUfvd2qv+YtKeTbfi10cWcxO3vfDJsw9Ib8zGVy/lcGrQSYy7jZqIDBdYpeYtL8X4e
         6zQFHxnoM4BMC0+klkBW5G5FuC4AEAgBxTupCMcoUefSjmiyh7XiwwWbc0UFXhGyooJn
         3n0LNuk90z931E9i9HMcvtgJ+TAlPrOeV91vKcco1aZZ7lFlRroHNuTTPFI4tX2VzcYl
         zwOg==
X-Forwarded-Encrypted: i=1; AJvYcCU126zFS48VdWEUkPC5NgeY+Y1zDYaqFrc4+47on84i++fHmixH4NhzRGcV4WF/fOVt04iXWQ7ZWhdPID+C69wNQQ==@vger.kernel.org, AJvYcCWFcvDmfOiD9D/ctYxSGSG3KLJv+MTszowfNxa4vB+3y3cJ5I7o6jLoe6JFhVcqjyNNbF15l8RoR3PWdZE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5eqMzhmgoz2oXpkIqIGZeSuNO0kNzZLjrPDE8N30HpQ8zb5sL
	8SbKicJ5//62nsBya4VXez9EXQUOhR/eGei+hdbbJs+yPyfP5fWDzZUGD6QEb2gFVnlEcK3yg9Z
	BqTwT7UB2f/EyOqg7cAGkk8s9t00=
X-Gm-Gg: ASbGncvStFEBkKKGY2tj/+rxgUqj8YClfoIgT3/4xSUeGGVMDHpLBq2cgPECaWv67EO
	gJutv10MOJm60QLNckdIg/qdDMy7ABe3Bgcb9n36W9ZuwZg5KBBB5gHLfQuyAvRsP5LGuqTc=
X-Google-Smtp-Source: AGHT+IGJoV5ZqBZGNCGygnvg5DoMJOhouWvNuw+ShXWC+tVIV3BnkgICVZGbi04eVwww8zkSxuVnkc7CYVOWfznEBLY=
X-Received: by 2002:a05:6902:2e11:b0:e5b:1dda:8f72 with SMTP id
 3f1490d57ef6-e5b4625a80bmr642455276.36.1738879753745; Thu, 06 Feb 2025
 14:09:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241215181220.754822-1-howardchu95@gmail.com>
 <20241215181220.754822-6-howardchu95@gmail.com> <Z6UNFXZUlo4wMZ7V@x1>
In-Reply-To: <Z6UNFXZUlo4wMZ7V@x1>
From: Howard Chu <howardchu95@gmail.com>
Date: Thu, 6 Feb 2025 14:08:59 -0800
X-Gm-Features: AWEUYZnVEK8uN85MJwwlmTJ0sKDbL977-KmR9Jvbu6D-0IxGT9c68M2TJLjcWKk
Message-ID: <CAH0uvog_RgX7wmOZ6=-rBY3YtSqJ5mRmUMOE+hehEmJ6cMEPsA@mail.gmail.com>
Subject: Re: [PATCH v14 05/10] perf evsel: Assemble offcpu samples
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: namhyung@kernel.org, mark.rutland@arm.com, 
	alexander.shishkin@linux.intel.com, jolsa@kernel.org, irogers@google.com, 
	adrian.hunter@intel.com, kan.liang@linux.intel.com, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Ingo Molnar <mingo@redhat.com>, James Clark <james.clark@linaro.org>, 
	Peter Zijlstra <peterz@infradead.org>, Arnaldo Carvalho de Melo <acme@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Arnaldo,

On Thu, Feb 6, 2025 at 11:27=E2=80=AFAM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> On Sun, Dec 15, 2024 at 10:12:15AM -0800, Howard Chu wrote:
> > Use the data in bpf-output samples, to assemble offcpu samples. In
> > evsel__is_offcpu_event(), Check if sample_type is PERF_SAMPLE_RAW to
> > support off-cpu sample data created by an older version of perf.
>
> > Testing compatibility on offcpu samples collected by perf before this p=
atch series:
>
> > See below, the sample_type still uses PERF_SAMPLE_CALLCHAIN
>
> Getting back from vacation, so bear with me, please :-)

Good to have you back :), no worries at all.

>
> So, while at this point:
>
> =E2=AC=A2 [acme@toolbox perf-tools-next]$ git log --oneline -5
> bfd7461c25a5e667 (HEAD) perf record --off-cpu: Dump off-cpu samples in BP=
F
> e75f8ce63bfa6cb9 perf record --off-cpu: Preparation of off-cpu BPF progra=
m
> 0ffab9d26971c91c perf record --off-cpu: Parse off-cpu event
> efc3fe2070853b7d perf evsel: Expose evsel__is_offcpu_event() for future u=
se
> 357b965deba9fb71 (perf-tools-next/perf-tools-next) perf stat: Changes to =
event name uniquification
> =E2=AC=A2 [acme@toolbox perf-tools-next]$
>
> And trying to test this series I do:
>
> root@number:~# perf -v
> perf version 6.13.rc2.gbfd7461c25a5
> root@number:~#
>
> root@number:~# perf record --off-cpu sleep 5s
> [ perf record: Woken up 1 times to write data ]
> [ perf record: Captured and wrote 0.037 MB perf.data (7 samples) ]
> root@number:~# perf evlist
> cpu_atom/cycles/P
> cpu_core/cycles/P
> offcpu-time
> dummy:u
> root@number:~#
>
> And:
>
> root@number:~# perf evlist -v
> cpu_atom/cycles/P: type: 0 (PERF_TYPE_HARDWARE), size: 136, config: 0xa00=
000000, { sample_period, sample_freq }: 4000, sample_type: IP|TID|TIME|PERI=
OD|IDENTIFIER, read_format: ID|LOST, disabled: 1, inherit: 1, freq: 1, enab=
le_on_exec: 1, precise_ip: 3, sample_id_all: 1
> cpu_core/cycles/P: type: 0 (PERF_TYPE_HARDWARE), size: 136, config: 0x400=
000000, { sample_period, sample_freq }: 4000, sample_type: IP|TID|TIME|PERI=
OD|IDENTIFIER, read_format: ID|LOST, disabled: 1, inherit: 1, freq: 1, enab=
le_on_exec: 1, precise_ip: 3, sample_id_all: 1
> offcpu-time: type: 1 (software), size: 136, config: 0xa (PERF_COUNT_SW_BP=
F_OUTPUT), { sample_period, sample_freq }: 1, sample_type: IP|TID|TIME|CPU|=
PERIOD|IDENTIFIER, read_format: ID|LOST, disabled: 1, enable_on_exec: 1, sa=
mple_id_all: 1
> dummy:u: type: 1 (software), size: 136, config: 0x9 (PERF_COUNT_SW_DUMMY)=
, { sample_period, sample_freq }: 1, sample_type: IP|TID|TIME|IDENTIFIER, r=
ead_format: ID|LOST, inherit: 1, exclude_kernel: 1, exclude_hv: 1, mmap: 1,=
 comm: 1, task: 1, sample_id_all: 1, exclude_guest: 1, mmap2: 1, comm_exec:=
 1, ksymbol: 1, bpf_event: 1
> root@number:~#
>
> Above the "offcpu-time" event doesn't have the PERF_SAMPLE_CALLCHAIN in
> sample_type, so I should be using some other 'perf record --off-cpu'
> specific option?
>
> The HEAD mentions:
>
> "Collect tid, period, callchain, and cgroup id and dump them when off-cpu
> time threshold is reached."

These are collected in BPF, not from perf_event. I can change the
commit message for clarity if you=E2=80=99d like.

>
> But that doesn't match the "offcpu-time" sample_type, right?

Nope, I'm sorry. If offcpu-time has PERF_SAMPLE_CALLCHAIN, it will
collect the wrong call chain.

Say I have task1 scheduling in and task2 scheduling out. For off-CPU
analysis, I want to save task2's call chain and check if task1 has
been scheduled out for longer than a threshold. If it has, a sample
for task1 should be emitted.

When a sched_switch happens, the call chain belongs to task2, and perf
should only emit task1's call chain if there is one. Therefore,
PERF_SAMPLE_CALLCHAIN, which collects an instant stack call chain at
sched_switch, cannot be used.

>
> > $ perf script --header -i ./perf.data.ptn | grep "event : name =3D offc=
pu-time"
> >  # event : name =3D offcpu-time, , id =3D { 237917, 237918, 237919, 237=
920 }, type =3D 1 (software), size =3D 136, config =3D 0xa (PERF_COUNT_SW_B=
PF_OUTPUT), { sample_period, sample_freq } =3D 1, sample_type =3D IP|TID|TI=
ME|CALLCHAIN|CPU|PERIOD|IDENTIFIER, read_format =3D ID|LOST, disabled =3D 1=
, freq =3D 1, sample_id_all =3D 1
> >
> > The output is correct.
>
> You mean because it has PERF_SAMPLE_CALLCHAIN in the sample_type?

The motivation for this patch is to add backward compatibility, i.e.,
to ensure that perf script processes the previously collected off-cpu
perf.data correctly before the change to offcpu-time's sample_type.

>
> > $ perf script -i ./perf.data.ptn | grep offcpu-time
> > gmain    2173 [000] 18446744069.414584:  100102015 offcpu-time:
> > NetworkManager     901 [000] 18446744069.414584:    5603579 offcpu-time=
:
> > Web Content 1183550 [000] 18446744069.414584:      46278 offcpu-time:
> > gnome-control-c 2200559 [000] 18446744069.414584: 11998247014 offcpu-ti=
me:
>
> > And after this patch series:
>
> After the _whole_ series? Or at this point in the series?

I should mention that the two perf.data files I used in the commit
message, perf.data.ptn and perf.data.off-cpu-v9, were collected from
perf without this series and perf with the whole series, respectively
(since only then can I use the --off-cpu-thresh option).

Again, I can add an explanation to the commit message if you=E2=80=99d like=
.
Sorry for the confusion.

>
> I'm trying to test it patch by patch, to see from output from 'perf
> report -D', perf script, etc that the patch descriptions match what the
> code does and then double checking by trying to reproduce it, step by
> step.

Thank you very much, talking about meticulousness :)

>
> I'll try to do it at the end of the series, but thought about trowing in
> these questions to help me understand your work.

Sure! Throw me some more if you want, because it has been some time.

Thanks,
Howard
>
> Thanks!
>
> - Arnaldo
>
> > $ perf script --header -i ./perf.data.off-cpu-v9 | grep "event : name =
=3D offcpu-time"
> >  # event : name =3D offcpu-time, , id =3D { 237959, 237960, 237961, 237=
962 }, type =3D 1 (software), size =3D 136, config =3D 0xa (PERF_COUNT_SW_B=
PF_OUTPUT), { sample_period, sample_freq } =3D 1, sample_type =3D IP|TID|TI=
ME|CPU|PERIOD|RAW|IDENTIFIER, read_format =3D ID|LOST, disabled =3D 1, freq=
 =3D 1, sample_id_all =3D 1
> >
> > perf $ ./perf script -i ./perf.data.off-cpu-v9 | grep offcpu-time
> >      gnome-shell    1875 [001] 4789616.361225:  100097057 offcpu-time:
> >      gnome-shell    1875 [001] 4789616.461419:  100107463 offcpu-time:
> >          firefox 2206821 [002] 4789616.475690:  255257245 offcpu-time:
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
> > Link: https://lore.kernel.org/r/20241108204137.2444151-7-howardchu95@gm=
ail.com
> > Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> > ---
> >  tools/perf/util/evsel.c | 35 ++++++++++++++++++++++++++++++++++-
> >  1 file changed, 34 insertions(+), 1 deletion(-)
> >
> > diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
> > index fc33104cd659..277b5babd63e 100644
> > --- a/tools/perf/util/evsel.c
> > +++ b/tools/perf/util/evsel.c
> > @@ -1244,7 +1244,8 @@ static void evsel__set_default_freq_period(struct=
 record_opts *opts,
> >
> >  bool evsel__is_offcpu_event(struct evsel *evsel)
> >  {
> > -     return evsel__is_bpf_output(evsel) && evsel__name_is(evsel, OFFCP=
U_EVENT);
> > +     return evsel__is_bpf_output(evsel) && evsel__name_is(evsel, OFFCP=
U_EVENT) &&
> > +            evsel->core.attr.sample_type & PERF_SAMPLE_RAW;
> >  }
> >
> >  /*
> > @@ -2846,6 +2847,35 @@ static inline bool evsel__has_branch_counters(co=
nst struct evsel *evsel)
> >       return false;
> >  }
> >
> > +static int __set_offcpu_sample(struct perf_sample *data)
> > +{
> > +     u64 *array =3D data->raw_data;
> > +     u32 max_size =3D data->raw_size, *p32;
> > +     const void *endp =3D (void *)array + max_size;
> > +
> > +     if (array =3D=3D NULL)
> > +             return -EFAULT;
> > +
> > +     OVERFLOW_CHECK_u64(array);
> > +     p32 =3D (void *)array++;
> > +     data->pid =3D p32[0];
> > +     data->tid =3D p32[1];
> > +
> > +     OVERFLOW_CHECK_u64(array);
> > +     data->period =3D *array++;
> > +
> > +     OVERFLOW_CHECK_u64(array);
> > +     data->callchain =3D (struct ip_callchain *)array++;
> > +     OVERFLOW_CHECK(array, data->callchain->nr * sizeof(u64), max_size=
);
> > +     data->ip =3D data->callchain->ips[1];
> > +     array +=3D data->callchain->nr;
> > +
> > +     OVERFLOW_CHECK_u64(array);
> > +     data->cgroup =3D *array;
> > +
> > +     return 0;
> > +}
> > +
> >  int evsel__parse_sample(struct evsel *evsel, union perf_event *event,
> >                       struct perf_sample *data)
> >  {
> > @@ -3197,6 +3227,9 @@ int evsel__parse_sample(struct evsel *evsel, unio=
n perf_event *event,
> >               array =3D (void *)array + sz;
> >       }
> >
> > +     if (evsel__is_offcpu_event(evsel))
> > +             return __set_offcpu_sample(data);
> > +
> >       return 0;
> >  }
> >
> > --
> > 2.43.0
