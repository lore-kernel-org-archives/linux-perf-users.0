Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0F21261561;
	Tue, 11 Feb 2025 17:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739295078; cv=none; b=aqONNzVBjqzqHBDrPZ5aDJExBY2IOMcX/cpB0JPmmqWVzSlG0TsLWofm1ieRM4KfRK4xnyUcaGNPv2UfOckpwvqNMhpyIMy/YP6OijcACbYcIDWedWoI70cEqLGxmYGI1+ohbjJE7gtw3J0Z1o7LfIrhq2XmMFnv9AqjROhqOW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739295078; c=relaxed/simple;
	bh=YTG58aFhcMGPZXyneQNggrMDhF/IanRMS47CggPiEK4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MVyWchQ86PNut8KjFxiyokm5QUR3Luv8VpcihSkAeTccv8pGQrqOmIuNm4pAl1WMx1MQEp1exZzHUvkMh6ixhjlYVObAcY+VmI5FOMLhGTwheWIMXhBRaFlOlJdWEVzWsn+q2BZdSdiaGySNbWGpMR/iUlBxapWtUEtFCM4Sso4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XCi5DfQ6; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XCi5DfQ6"
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-6f6ca1a8aa6so33109677b3.3;
        Tue, 11 Feb 2025 09:31:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739295076; x=1739899876; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8ZCocmZjosRREBGi5Yuo/Tkeo1OQzSxZP8HGc+fTbHg=;
        b=XCi5DfQ6dm92+zEnKTxA1CqrU9uM+uuyIXXp6QOtq67vrZYTyVsCcXQUS2HsVf0POg
         QCngRvTbd+NiBtiya84Fn8GLD6klywu5QNYv/hVtmghSMIofrEPyDj9rNGaXlsSMDRTR
         QOwaJT+bp0A4MaYO4PsZOK4fhbEBXpdF2MeRbrKC9kdx4d7qim8TJJDegN2b3cSPkgur
         30FLSaqnteOzagbWFrzoP00nyK7VwZv4OpYA//WKEeH+EgGwx2I3lxDvMW5PeAF56P4S
         TKUliP/nnT+yITV+OeNTSb8XEGA2u1kkHl8t5Ms1+YLQMx4top5GrEJSWQ+x2rP/cdpo
         EDLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739295076; x=1739899876;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8ZCocmZjosRREBGi5Yuo/Tkeo1OQzSxZP8HGc+fTbHg=;
        b=wiSGFUyjzKU9O2y690y+/WHeOceQGTFmCtz2FS719nDptNj03p20zTlCgy0Kw2YBRA
         B4pRmTDIisO/yKvSjfLGRF1Z36BgEiIJkTjWS710GHsd8CxzzdwFvEE0sa+KNB1fKaDT
         nTg2Qj7kwmWm3LO7JOOISvcWu6zejl1B08c3OVsIvp95fKcdv3KCFKa6NaxIqU9mSd9V
         cYOo5vEvnsfKVtkKxyp6kxRVHm+u0W4OdFNsp5Gx1/D3IZgVh19WdPRaHY4Un8SuapUj
         qd5YyOos90xEiQ/Q7xQ+6oeXxxykDo0Aicee2ClThHkYl8VHv5hKZN6ovExt5JeQ4mSp
         j8KA==
X-Forwarded-Encrypted: i=1; AJvYcCU39yu++rEK9gd2FnLVBJmIfMGVZHx4zFD6FTmEyLxarsJhV2FniLwEgx0kPC/3+3RTsHDlHHtNrlkYpa0=@vger.kernel.org, AJvYcCWDBSRZVbeGzZ9ZKObEY4JkD+fC5WcLMvwz3OG0WhvhoMA93B6ZYfR/6bsZ7ySgLPcfiUoHhuZZmlvJF3RUZE/ujg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyPw6BrmnyhXSHDF6qO15NmrLROsp8S5GG20Ei4UHbo0dUM68mT
	5MQt0rJ2Q3ZZ+rOKm9zPgtsXX8swvJfKc/S05emAaVuI/sApQh+qC8BQvQbHq/UdbgIWDgyMlqh
	nOJdg5qMSd8F46S4KUt4gM3+GEOk=
X-Gm-Gg: ASbGncuWSByaTz1U2/erpIz4E5eVZZ23QoHsszUL6bqoKhxSoxVVvR77nr488O/gfFo
	VyKCsnAw10z7keBuj13SXG+BqF55jtLRpPGJEnHNhVw+5Ejko6Y7Rf7l6kNOkWnBOe+g4IRE=
X-Google-Smtp-Source: AGHT+IE8+NNqQhZxI8SNC9wyXQG6Ck6qYDqylN37k2W1LmBOhDeeR5FP76W4LRch7TxhySwDd/ntZ9QhCwCdJKGf+iQ=
X-Received: by 2002:a05:690c:7305:b0:6ef:a53e:8e3e with SMTP id
 00721157ae682-6fb1f1a7c51mr4547607b3.9.1739295075746; Tue, 11 Feb 2025
 09:31:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241215181220.754822-1-howardchu95@gmail.com>
 <20241215181220.754822-5-howardchu95@gmail.com> <Z6uIr8cRZBllFKt4@x1>
In-Reply-To: <Z6uIr8cRZBllFKt4@x1>
From: Howard Chu <howardchu95@gmail.com>
Date: Tue, 11 Feb 2025 09:31:08 -0800
X-Gm-Features: AWEUYZkcc73CXViezOkCTJ57TsVNm2GBej5Ka24f772Cn7iL3BZPeWs3PTrb7gc
Message-ID: <CAH0uvoiHi_k3o4mpnA-6rcq0faq-G1xMVh-7=kd5Zs_OS8KZVw@mail.gmail.com>
Subject: Re: [PATCH v14 04/10] perf record --off-cpu: Dump off-cpu samples in BPF
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

On Tue, Feb 11, 2025 at 9:28=E2=80=AFAM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> On Sun, Dec 15, 2024 at 10:12:14AM -0800, Howard Chu wrote:
> > Collect tid, period, callchain, and cgroup id and dump them when off-cp=
u
> > time threshold is reached.
> >
> > We don't collect the off-cpu time twice (the delta), it's either in
> > direct samples, or accumulated samples that are dumped at the end of
> > perf.data.
> >
> > Suggested-by: Namhyung Kim <namhyung@kernel.org>
> > Signed-off-by: Howard Chu <howardchu95@gmail.com>
> > Cc: Adrian Hunter <adrian.hunter@intel.com>
> > Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> > Cc: Ian Rogers <irogers@google.com>
> > Cc: Ingo Molnar <mingo@redhat.com>
> > Cc: James Clark <james.clark@linaro.org>
> > Cc: Jiri Olsa <jolsa@kernel.org>
> > Cc: Kan Liang <kan.liang@linux.intel.com>
> > Cc: Mark Rutland <mark.rutland@arm.com>
> > Cc: Peter Zijlstra <peterz@infradead.org>
> > Link: https://lore.kernel.org/r/20241108204137.2444151-6-howardchu95@gm=
ail.com
> > Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> > ---
> >  tools/perf/util/bpf_skel/off_cpu.bpf.c | 88 ++++++++++++++++++++++++--
> >  1 file changed, 83 insertions(+), 5 deletions(-)
> >
> > diff --git a/tools/perf/util/bpf_skel/off_cpu.bpf.c b/tools/perf/util/b=
pf_skel/off_cpu.bpf.c
> > index 1cdd4d63ea92..77fdc9e81db3 100644
> > --- a/tools/perf/util/bpf_skel/off_cpu.bpf.c
> > +++ b/tools/perf/util/bpf_skel/off_cpu.bpf.c
> > @@ -19,11 +19,17 @@
> >  #define MAX_ENTRIES  102400
> >
> >  #define MAX_CPUS  4096
> > +#define MAX_OFFCPU_LEN 37
> > +
> > +struct stack {
> > +     u64 array[MAX_STACKS];
> > +};
>
> So I needed to rename the above as it fails 'make -C tools/perf
> build-test', the direct make command line to hit that:
>
> =E2=AC=A2 [acme@toolbox perf-tools-next]$ rm -rf /tmp/build/$(basename $P=
WD)/ ; mkdir -p /tmp/build/$(basename $PWD)/
> =E2=AC=A2 [acme@toolbox perf-tools-next]$ alias m=3D'rm -rf ~/libexec/per=
f-core/ ; make -k GEN_VMLINUX_H=3D1 CORESIGHT=3D1 O=3D/tmp/build/$(basename=
 $PWD)/ -C tools/perf install-bin && perf test python && cat /tmp/build/per=
f-tools-next/feature/test-all.output'
> =E2=AC=A2 [acme@toolbox perf-tools-next]$ m
>   GENSKEL /tmp/build/perf-tools-next/util/bpf_skel/sample_filter.skel.h
> util/bpf_skel/off_cpu.bpf.c:24:8: error: redefinition of 'stack'
>    24 | struct stack {
>       |        ^
> /tmp/build/perf-tools-next/util/bpf_skel/.tmp/../vmlinux.h:128096:8: note=
: previous definition is here
>  128096 | struct stack {
>         |        ^
> util/bpf_skel/off_cpu.bpf.c:218:42: error: no member named 'array' in 'st=
ruct stack'
>   218 |         for (int i =3D 0; i < MAX_STACKS && from->array[i]; ++i, =
++len)
>       |                                           ~~~~  ^
> util/bpf_skel/off_cpu.bpf.c:219:32: error: no member named 'array' in 'st=
ruct stack'
>   219 |                 to->array[n + 2 + i] =3D from->array[i];
>       |                                        ~~~~  ^
> 3 errors generated.
> make[2]: *** [Makefile.perf:1276: /tmp/build/perf-tools-next/util/bpf_ske=
l/.tmp/off_cpu.bpf.o] Error 1
>
> So for now I'm adding the patch below to get it going.
>
> IIRC there was some discussion about ditching GEN_VMLINUX_H=3D1, we can
> remove this hack later if/when we progress on that.
>
> - Arnaldo
>
> diff --git a/tools/perf/util/bpf_skel/off_cpu.bpf.c b/tools/perf/util/bpf=
_skel/off_cpu.bpf.c
> index 77fdc9e81db395d1..848a123e5610f17b 100644
> --- a/tools/perf/util/bpf_skel/off_cpu.bpf.c
> +++ b/tools/perf/util/bpf_skel/off_cpu.bpf.c
> @@ -21,7 +21,8 @@
>  #define MAX_CPUS  4096
>  #define MAX_OFFCPU_LEN 37
>
> -struct stack {
> +// We have a 'struct stack' in vmlinux.h when building with GEN_VMLINUX_=
H=3D1
> +struct __stack {
>         u64 array[MAX_STACKS];
>  };
>
> @@ -29,7 +30,7 @@ struct tstamp_data {
>         __u32 stack_id;
>         __u32 state;
>         __u64 timestamp;
> -       struct stack stack;
> +       struct __stack stack;
>  };
>
>  struct offcpu_key {
> @@ -211,7 +212,7 @@ static inline int can_record(struct task_struct *t, i=
nt state)
>         return 1;
>  }
>
> -static inline int copy_stack(struct stack *from, struct offcpu_data *to,=
 int n)
> +static inline int copy_stack(struct __stack *from, struct offcpu_data *t=
o, int n)
>  {
>         int len =3D 0;
>
> @@ -231,7 +232,7 @@ static inline int copy_stack(struct stack *from, stru=
ct offcpu_data *to, int n)
>   * information of the task, and dump it as a raw sample to perf ring buf=
fer
>   */
>  static int off_cpu_dump(void *ctx, struct offcpu_data *data, struct offc=
pu_key *key,
> -                       struct stack *stack, __u64 delta)
> +                       struct __stack *stack, __u64 delta)
>  {
>         int n =3D 0, len =3D 0;

Ack. Sorry about that.

Thanks,
Howard
>
>
> >  struct tstamp_data {
> >       __u32 stack_id;
> >       __u32 state;
> >       __u64 timestamp;
> > +     struct stack stack;
> >  };
> >
> >  struct offcpu_key {
> > @@ -41,6 +47,10 @@ struct {
> >       __uint(max_entries, MAX_ENTRIES);
> >  } stacks SEC(".maps");
> >
> > +struct offcpu_data {
> > +     u64 array[MAX_OFFCPU_LEN];
> > +};
> > +
> >  struct {
> >       __uint(type, BPF_MAP_TYPE_PERF_EVENT_ARRAY);
> >       __uint(key_size, sizeof(__u32));
> > @@ -48,6 +58,13 @@ struct {
> >       __uint(max_entries, MAX_CPUS);
> >  } offcpu_output SEC(".maps");
> >
> > +struct {
> > +     __uint(type, BPF_MAP_TYPE_PERCPU_ARRAY);
> > +     __uint(key_size, sizeof(__u32));
> > +     __uint(value_size, sizeof(struct offcpu_data));
> > +     __uint(max_entries, 1);
> > +} offcpu_payload SEC(".maps");
> > +
> >  struct {
> >       __uint(type, BPF_MAP_TYPE_TASK_STORAGE);
> >       __uint(map_flags, BPF_F_NO_PREALLOC);
> > @@ -106,6 +123,8 @@ const volatile bool uses_cgroup_v1 =3D false;
> >
> >  int perf_subsys_id =3D -1;
> >
> > +__u64 offcpu_thresh_ns =3D 500000000ull;
> > +
> >  /*
> >   * Old kernel used to call it task_struct->state and now it's '__state=
'.
> >   * Use BPF CO-RE "ignored suffix rule" to deal with it like below:
> > @@ -192,6 +211,47 @@ static inline int can_record(struct task_struct *t=
, int state)
> >       return 1;
> >  }
> >
> > +static inline int copy_stack(struct stack *from, struct offcpu_data *t=
o, int n)
> > +{
> > +     int len =3D 0;
> > +
> > +     for (int i =3D 0; i < MAX_STACKS && from->array[i]; ++i, ++len)
> > +             to->array[n + 2 + i] =3D from->array[i];
> > +
> > +     return len;
> > +}
> > +
> > +/**
> > + * off_cpu_dump - dump off-cpu samples to ring buffer
> > + * @data: payload for dumping off-cpu samples
> > + * @key: off-cpu data
> > + * @stack: stack trace of the task before being scheduled out
> > + *
> > + * If the threshold of off-cpu time is reached, acquire tid, period, c=
allchain, and cgroup id
> > + * information of the task, and dump it as a raw sample to perf ring b=
uffer
> > + */
> > +static int off_cpu_dump(void *ctx, struct offcpu_data *data, struct of=
fcpu_key *key,
> > +                     struct stack *stack, __u64 delta)
> > +{
> > +     int n =3D 0, len =3D 0;
> > +
> > +     data->array[n++] =3D (u64)key->tgid << 32 | key->pid;
> > +     data->array[n++] =3D delta;
> > +
> > +     /* data->array[n] is callchain->nr (updated later) */
> > +     data->array[n + 1] =3D PERF_CONTEXT_USER;
> > +     data->array[n + 2] =3D 0;
> > +     len =3D copy_stack(stack, data, n);
> > +
> > +     /* update length of callchain */
> > +     data->array[n] =3D len + 1;
> > +     n +=3D len + 2;
> > +
> > +     data->array[n++] =3D key->cgroup_id;
> > +
> > +     return bpf_perf_event_output(ctx, &offcpu_output, BPF_F_CURRENT_C=
PU, data, n * sizeof(u64));
> > +}
> > +
> >  static int off_cpu_stat(u64 *ctx, struct task_struct *prev,
> >                       struct task_struct *next, int state)
> >  {
> > @@ -216,6 +276,16 @@ static int off_cpu_stat(u64 *ctx, struct task_stru=
ct *prev,
> >       pelem->state =3D state;
> >       pelem->stack_id =3D stack_id;
> >
> > +     /*
> > +      * If stacks are successfully collected by bpf_get_stackid(), col=
lect them once more
> > +      * in task_storage for direct off-cpu sample dumping
> > +      */
> > +     if (stack_id > 0 && bpf_get_stack(ctx, &pelem->stack, MAX_STACKS =
* sizeof(u64), BPF_F_USER_STACK)) {
> > +             /*
> > +              * This empty if block is used to avoid 'result unused wa=
rning' from bpf_get_stack().
> > +              * If the collection fails, continue with the logic for t=
he next task.
> > +              */
> > +     }
> >  next:
> >       pelem =3D bpf_task_storage_get(&tstamp, next, NULL, 0);
> >
> > @@ -230,11 +300,19 @@ static int off_cpu_stat(u64 *ctx, struct task_str=
uct *prev,
> >               __u64 delta =3D ts - pelem->timestamp;
> >               __u64 *total;
> >
> > -             total =3D bpf_map_lookup_elem(&off_cpu, &key);
> > -             if (total)
> > -                     *total +=3D delta;
> > -             else
> > -                     bpf_map_update_elem(&off_cpu, &key, &delta, BPF_A=
NY);
> > +             if (delta >=3D offcpu_thresh_ns) {
> > +                     int zero =3D 0;
> > +                     struct offcpu_data *data =3D bpf_map_lookup_elem(=
&offcpu_payload, &zero);
> > +
> > +                     if (data)
> > +                             off_cpu_dump(ctx, data, &key, &pelem->sta=
ck, delta);
> > +             } else {
> > +                     total =3D bpf_map_lookup_elem(&off_cpu, &key);
> > +                     if (total)
> > +                             *total +=3D delta;
> > +                     else
> > +                             bpf_map_update_elem(&off_cpu, &key, &delt=
a, BPF_ANY);
> > +             }
> >
> >               /* prevent to reuse the timestamp later */
> >               pelem->timestamp =3D 0;
> > --
> > 2.43.0
