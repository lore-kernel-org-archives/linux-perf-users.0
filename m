Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C077145B2E;
	Mon, 11 Nov 2024 18:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731348341; cv=none; b=TtQXyFOb0/s2QdNvtqJCYgfeNJIJCEPbcezDi+vreCWiAiUQMszgqOkyjVIbvFEh8yhkg3ZnNDwA6lUTmkv526WS6NCptM+C6cphuArbqsMv/Yuz+Unq/GT8yUG6Us30GSmryz6WTKoirAFqSbPP97Jrp24UHFcb2dJRMFNxxZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731348341; c=relaxed/simple;
	bh=JEO+B8QOizatqwb1g9mjpIaXLtkamIuvdm5kIgrtzDM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GDjk33p3NjSJiWaQaX4hCku+tsVh6YKxNhUhmdo1OdzsyfrIF8WlOzSf/bL6XOnf4r5OpiLgT2MhFWwFKW5e2JbFiduPPv8iRWCzHiSNANTNigRznWoyxJQ78RFbm7u8vsihYFtZFIlj1KOb5UcwKwHonnqJm/VP3ub0T5IzZ7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SZDhHYVS; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SZDhHYVS"
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-6e3cdbc25a0so46905047b3.2;
        Mon, 11 Nov 2024 10:05:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731348339; x=1731953139; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/O5vwpnOpUfo0dGuASRPQwgdNYcihVOMr+xGnfkmQOM=;
        b=SZDhHYVSNIlaRbmd86Jgz5RSEAhx6rvLQi7Jp/A4es2WmJguPQoWTTingEofv/9mGZ
         5JLrUusLpOg7oPrQMN8KCxSyG0dkoNtrK4HTDnvdnLi3jBMPyIz76QoCPauGuTqigfDP
         WdDAxrYy4ZZeGA6+xB7JGeBSBDAoBr414fbfCmpU7OFbG89REWr9WmoOS7x7dhrdjJAe
         neDiHXrlpKfU4jbY0zECuiNeDXJgbcSK78K2N4TkSdP67yFRKMQiTQP8XdvvRyekR8aX
         VCJgH2HkLNhDTCV/sfu2b5ifyVIWgSs5DGHjGkyvaw8NlffADy7P1k3nrNSYOdr5xuQK
         9wpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731348339; x=1731953139;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/O5vwpnOpUfo0dGuASRPQwgdNYcihVOMr+xGnfkmQOM=;
        b=ImxLLC4SSqFUPTgxTjMzORJ7LjE9aT3iUkvbDy3Tfl+p4zBuyt5FmieIlX8YBg+Qhz
         pqUT1FYyuuocxm86RWW585/Zug7TQ8Gcp/EnFNwoF1fRFeEZP3FqhjW7FllOZ6dAVhif
         1cetF5jdhui+pq6vbYvDakOFkq3JuDaYX6RbDUq6BzgomoKkUyvyGl80fJLFUt81BMts
         CkU699x6FWfS2Lnr2TvJD9A7VmRxUdtlFIGDTlBOUVhXzYS+30pC3LxeKgvC4M0Sp+cj
         vPip3WjP+7JSeVW6YZsQIolWIVEkkUEXKEx3kMnuzuvG1nXTAgC+HV7C2G1XN6mLIOm2
         3/iw==
X-Forwarded-Encrypted: i=1; AJvYcCUmRUIJub5ppN19Rfi2DP6ao12Nn4sYvLwrKrjDNIN7TIZRIQHyJDhAEHM2skdlqHJKMMLL6HmFTFaZcyI=@vger.kernel.org, AJvYcCWphAAN3yN3EyDl3dcwAbSV95T7NwljBi9y3+SEs7ZVFUeCoSLfEA6kYbWLLF1k/nPnartRj3dpTiOg/07of6XT7A==@vger.kernel.org
X-Gm-Message-State: AOJu0YxMTRKv3TwvvSzx8YHv/iQlEX63ZGIWOexe4jLq/HpaotAqDNl+
	+lVbxCrVnCbiiqZ43OPivcUspSAX3ouLv/iNsWi95HMD9JHPIkCqieWiDIWO3mpjkNJJqWU12Yj
	1gopbFTx6iyud+HSPuSzXtRKzkrw=
X-Google-Smtp-Source: AGHT+IGX9vLtZICs88jg6RGBDCMcD2/P34q0X6s03XFLDnj8l5B1ZYNafGrYjWaXV9znGxuqXPcGf6p/8cFdSiGgatw=
X-Received: by 2002:a05:690c:388:b0:6ea:807c:bbaa with SMTP id
 00721157ae682-6eaddd79c47mr130256457b3.5.1731348339099; Mon, 11 Nov 2024
 10:05:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241108204137.2444151-1-howardchu95@gmail.com>
 <20241108204137.2444151-6-howardchu95@gmail.com> <CAP-5=fXDd2MUvukB6NVMN962wxjPN6_F-AxOxOUUb-uj5BVV0A@mail.gmail.com>
In-Reply-To: <CAP-5=fXDd2MUvukB6NVMN962wxjPN6_F-AxOxOUUb-uj5BVV0A@mail.gmail.com>
From: Howard Chu <howardchu95@gmail.com>
Date: Mon, 11 Nov 2024 10:05:28 -0800
Message-ID: <CAH0uvogkoUW+hA7V8TgyUT-PrGx6JajKZDMj9-w9z25QVT5O4Q@mail.gmail.com>
Subject: Re: [PATCH v7 05/10] perf record --off-cpu: Dump off-cpu samples in BPF
To: Ian Rogers <irogers@google.com>
Cc: acme@kernel.org, peterz@infradead.org, namhyung@kernel.org, 
	mingo@redhat.com, mark.rutland@arm.com, james.clark@linaro.org, 
	alexander.shishkin@linux.intel.com, jolsa@kernel.org, adrian.hunter@intel.com, 
	kan.liang@linux.intel.com, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Ian,

On Mon, Nov 11, 2024 at 9:54=E2=80=AFAM Ian Rogers <irogers@google.com> wro=
te:
>
> On Fri, Nov 8, 2024 at 12:41=E2=80=AFPM Howard Chu <howardchu95@gmail.com=
> wrote:
> >
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
> > ---
> >  tools/perf/util/bpf_skel/off_cpu.bpf.c | 83 ++++++++++++++++++++++++--
> >  1 file changed, 78 insertions(+), 5 deletions(-)
> >
> > diff --git a/tools/perf/util/bpf_skel/off_cpu.bpf.c b/tools/perf/util/b=
pf_skel/off_cpu.bpf.c
> > index dc6acafb9353..bf652c30b1c9 100644
> > --- a/tools/perf/util/bpf_skel/off_cpu.bpf.c
> > +++ b/tools/perf/util/bpf_skel/off_cpu.bpf.c
> > @@ -18,10 +18,18 @@
> >  #define MAX_STACKS   32
> >  #define MAX_ENTRIES  102400
> >
> > +#define MAX_CPUS  4096
> > +#define MAX_OFFCPU_LEN 37
> > +
> > +struct stack {
> > +       u64 array[MAX_STACKS];
> > +};
> > +
> >  struct tstamp_data {
> >         __u32 stack_id;
> >         __u32 state;
> >         __u64 timestamp;
> > +       struct stack stack;
> >  };
> >
> >  struct offcpu_key {
> > @@ -39,6 +47,24 @@ struct {
> >         __uint(max_entries, MAX_ENTRIES);
> >  } stacks SEC(".maps");
> >
> > +struct offcpu_data {
> > +       u64 array[MAX_OFFCPU_LEN];
> > +};
> > +
> > +struct {
> > +       __uint(type, BPF_MAP_TYPE_PERF_EVENT_ARRAY);
> > +       __uint(key_size, sizeof(__u32));
> > +       __uint(value_size, sizeof(__u32));
> > +       __uint(max_entries, MAX_CPUS);
> > +} offcpu_output SEC(".maps");
>
> Does patch 4 build without this definition? (we're in patch 5 here). I
> think this should be in patch 4.

Okay sure thanks :)

>
> > +
> > +struct {
> > +       __uint(type, BPF_MAP_TYPE_PERCPU_ARRAY);
> > +       __uint(key_size, sizeof(__u32));
> > +       __uint(value_size, sizeof(struct offcpu_data));
> > +       __uint(max_entries, 1);
> > +} offcpu_payload SEC(".maps");
> > +
> >  struct {
> >         __uint(type, BPF_MAP_TYPE_TASK_STORAGE);
> >         __uint(map_flags, BPF_F_NO_PREALLOC);
> > @@ -185,6 +211,39 @@ static inline int can_record(struct task_struct *t=
, int state)
> >         return 1;
> >  }
> >
> > +static inline int copy_stack(struct stack *from, struct offcpu_data *t=
o, int n)
> > +{
> > +       int len =3D 0;
> > +
> > +       for (int i =3D 0; i < MAX_STACKS && from->array[i]; ++i, ++len)
> > +               to->array[n + 2 + i] =3D from->array[i];
> > +
> > +       return len;
> > +}
> > +
>
> Dump is something of a generic name. Could you kernel-doc this
> function to describe the behavior?

Sure.

>
> > +static int off_cpu_dump(void *ctx, struct offcpu_data *data, struct of=
fcpu_key *key,
> > +                       struct stack *stack, __u64 delta, __u64 timesta=
mp)
> > +{
> > +       /* dump tid, period, callchain, and cgroup id */
> > +       int n =3D 0, len =3D 0;
> > +
> > +       data->array[n++] =3D (u64)key->tgid << 32 | key->pid;
> > +       data->array[n++] =3D delta;
> > +
> > +       /* data->array[n] is callchain->nr (updated later) */
> > +       data->array[n + 1] =3D PERF_CONTEXT_USER;
> > +       data->array[n + 2] =3D 0;
> > +       len =3D copy_stack(stack, data, n);
> > +
> > +       /* update length of callchain */
> > +       data->array[n] =3D len + 1;
> > +       n +=3D len + 2;
> > +
> > +       data->array[n++] =3D key->cgroup_id;
> > +
> > +       return bpf_perf_event_output(ctx, &offcpu_output, BPF_F_CURRENT=
_CPU, data, n * sizeof(u64));
> > +}
> > +
> >  static int off_cpu_stat(u64 *ctx, struct task_struct *prev,
> >                         struct task_struct *next, int state)
> >  {
> > @@ -209,6 +268,12 @@ static int off_cpu_stat(u64 *ctx, struct task_stru=
ct *prev,
> >         pelem->state =3D state;
> >         pelem->stack_id =3D stack_id;
> >
> > +       /*
> > +        * If stacks are successfully collected by bpf_get_stackid(), c=
ollect them once more
> > +        * in task_storage for direct off-cpu sample dumping
> > +        */
> > +       if (stack_id > 0 && bpf_get_stack(ctx, &pelem->stack, MAX_STACK=
S * sizeof(u64), BPF_F_USER_STACK)) {
> > +       }
>
> Why the empty if?

Forgot to say in the commit message, bpf_get_stack() has a return
value and if I don't use it I'll get result unused warning from clang,
so either this or:
    int __attribute__((unused)) len;
    len =3D bpf_get_stack(ctx, stack_p->array, MAX_STACKS * sizeof(u64),

We don't need error handling, it goes to "next:" naturally, there's no
code in between.

>
> > +
> >  next:
> >         pelem =3D bpf_task_storage_get(&tstamp, next, NULL, 0);
> >
> > @@ -223,11 +288,19 @@ static int off_cpu_stat(u64 *ctx, struct task_str=
uct *prev,
> >                 __u64 delta =3D ts - pelem->timestamp;
> >                 __u64 *total;
> >
> > -               total =3D bpf_map_lookup_elem(&off_cpu, &key);
> > -               if (total)
> > -                       *total +=3D delta;
> > -               else
> > -                       bpf_map_update_elem(&off_cpu, &key, &delta, BPF=
_ANY);
> > +               if (delta >=3D offcpu_thresh) {
> > +                       int zero =3D 0;
> > +                       struct offcpu_data *data =3D bpf_map_lookup_ele=
m(&offcpu_payload, &zero);
> > +
> > +                       if (data)
> > +                               off_cpu_dump(ctx, data, &key, &pelem->s=
tack, delta, pelem->timestamp);
> > +               } else {
> > +                       total =3D bpf_map_lookup_elem(&off_cpu, &key);
> > +                       if (total)
> > +                               *total +=3D delta;
> > +                       else
> > +                               bpf_map_update_elem(&off_cpu, &key, &de=
lta, BPF_ANY);
> > +               }
>
> Looks good! :-)
>
> Thanks,
> Ian
>
> >
> >                 /* prevent to reuse the timestamp later */
> >                 pelem->timestamp =3D 0;
> > --
> > 2.43.0
> >

Thanks,
Howard
