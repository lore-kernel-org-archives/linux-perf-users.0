Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com [209.85.219.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C76018C344;
	Thu,  8 Aug 2024 11:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723118273; cv=none; b=TDuSPaOPC6urtaMxOWlyXnFh1sbZ/T7GzykhiA2GVo2LnT3mlhhK2z34Rc72ubFx8Wrq0gmGUZMu0eFXqk4wZm9swNAWFg8NnsOeQCaaehK0Tg2FzO9d/NT2YjQeJNbWXAKElC5kW3skFZlGsW9MPnUOW8y7+i7Y1jifaV4n480=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723118273; c=relaxed/simple;
	bh=PYJLTdRtrV9Sp5KBPWGCdec/5VGnl080RZUHvUprMbI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=seEbZZvQtnfP2zr9b9HNFYk0HGFhhuWptzQc3YpWEPhVKwrtcBVv2WZmXKLpLy4F6iaokYt2FwzQvKyGT7+UzcaAw0sjHzVoRnJmy87t152ktj460ow0QJsSuOKIExZE6H1KX51nhD5xbLFC/uCk24hypK5vGQjCBExTSFmy6Gc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q10KVqKy; arc=none smtp.client-ip=209.85.219.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q10KVqKy"
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-e0b7efa1c1bso701757276.3;
        Thu, 08 Aug 2024 04:57:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723118271; x=1723723071; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y2dqiNOl4SOG08/MuWqCZdUE2L+FuJhdjLy7tHFyhCk=;
        b=Q10KVqKyNs3UEmYKlJRiiEc57a0Qr9ujmZdZKOd3fUfWpsXu/4k9VT5y8UKjYkn1m+
         xWP+v/rhXxqEbEKAKBwR31hmoiqWIltw9bGg6/L9KFnYS7LldtuHeILBfJ707eNFxe0u
         UKsr2Dc+WVEWmByyZOF50Ew/CBnOpKgR8XcZb/+aG7ZHQcPIICcg6TEA9B4us49JgqkS
         Ne7UoQ3eieig290tAV9n/1xs81UOtjoK0gSAlKA2hTRTV/AW58E5w90zNCydD0SNGZ14
         u0gVPFZ3YO+4rOlueUkyabPVT5pKKL0WxHaAjy06X2zerLhWVI68pSr0gzW2hFCvjOBw
         EkRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723118271; x=1723723071;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y2dqiNOl4SOG08/MuWqCZdUE2L+FuJhdjLy7tHFyhCk=;
        b=YAU4nxxK7WfCmPGbhUcJ+ljuoyxg4NfL0TSVnOTOmzCPY+RqtqpFXWqTihFRlzR28c
         j/rxAed+yA0YmuyxCoV6V6oh0pFg855WRnbRZdogi4fN0QmQri/j5x6RBEi54AaIuOiC
         1Jc/DVepqN6t1n6k1tSjSlzmnDlY4V1Se5WT08Sru1V1RFjgYRZTL+q4KsvzmbxJ29C/
         M6BaN1+7/tCQUPY02yO7nbHgPwlaTjDHtKHNnnfN/EHOaoSQnSXdbVcve/lEBPTKdIdF
         np77/v8anW+CGUrOuBbMNeaA5ArB5bjl4F/+YF08Mb/3A+vjuHoZWog8S0tDr8/nSO+l
         8SCg==
X-Forwarded-Encrypted: i=1; AJvYcCWQYXNc8fUOMwB8a942N1QeVol3W64L5hU9NSv8F/BxzZuXJbohtRa1LA9GwShA7Lw0OJIUfg/NvSoFbc0ctK5rq1xMpIleVrlAPHmnMTajIZb7aD/56ai49Py8oKCG2CTT1VEDvmQICFT7pIvztg==
X-Gm-Message-State: AOJu0Yw7n25BF8fZbY1YgfZhb0Oj+mKstGGT5aeurFHEw89QZxNGd0vg
	kmx8ZEIzbJWnp3wGu5YuWB8RbQCVETuVvX50RR6uecDL/UHBm5RAMKN2NuvCWL20BwC7JNy+jyT
	1jz9Dvfnx+nh9ELHFN2/GWrXaPfQ=
X-Google-Smtp-Source: AGHT+IGQXOWGIQJJizPhVH61H7Hfq5ziwNWbb+jqZ9G4SmMjlmD2spglhNdZv5qcIqLI6obIYES4xwfpiXorjqPymN0=
X-Received: by 2002:a05:6902:2388:b0:e0e:89f8:4f8a with SMTP id
 3f1490d57ef6-e0e9dab0668mr1899322276.23.1723118270728; Thu, 08 Aug 2024
 04:57:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240807153843.3231451-1-howardchu95@gmail.com>
 <20240807153843.3231451-5-howardchu95@gmail.com> <ZrQIJ9xRg22qALoQ@google.com>
In-Reply-To: <ZrQIJ9xRg22qALoQ@google.com>
From: Howard Chu <howardchu95@gmail.com>
Date: Thu, 8 Aug 2024 19:57:40 +0800
Message-ID: <CAH0uvogCCm5U0nsRp93V1+YuVbL34=pcxXsQc0z6stRWE1ouAg@mail.gmail.com>
Subject: Re: [PATCH v4 4/9] perf record off-cpu: Dump direct off-cpu samples
 in BPF
To: Namhyung Kim <namhyung@kernel.org>
Cc: irogers@google.com, acme@kernel.org, adrian.hunter@intel.com, 
	jolsa@kernel.org, kan.liang@linux.intel.com, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

On Thu, Aug 8, 2024 at 7:50=E2=80=AFAM Namhyung Kim <namhyung@kernel.org> w=
rote:
>
> On Wed, Aug 07, 2024 at 11:38:38PM +0800, Howard Chu wrote:
> > Output PERF_SAMPLE_TID, PERF_SAMPLE_PERIOD, PERF_SAMPLE_CALLCHAIN, and
> > PERF_SAMPLE_CGROUP in BPF. Ideally, we should only output
> > PERF_SAMPLE_PERIOD (off-cpu time) and PERF_SAMPLE_CALLCHAIN (sched_in
> > process's callchain). One only needs to set PERF_SAMPLE_TID and
> > PERF_SAMPLE_CGROUP, and perf_event will do everything for us.
> >
> > But in reality, that's not the case. Setting PERF_SAMPLE_TID will mostl=
y
> > give us TID of 0. We might get the correct TID for offcpu-time event
> > from time to time, but it is really rare.
> >          swapper       0 [000] offcpu-time:  /
> >         :1321819 1321819 [002] offcpu-time:  /user.slice/user-1000.slic=
e/session-2.scope
> >          swapper       0 [001] offcpu-time:  /
> >          swapper       0 [003] offcpu-time:  /
> >
> > And setting PERF_SAMPLE_CGROUP doesn't work properly either.
> >     tmux: server    3701 [003] offcpu-time:  /
> >     blueman-tray    1064 [001] offcpu-time:  /
> >             bash 1350867 [001] offcpu-time:  /
> >             bash 1350844 [000] offcpu-time:  /
>
> Isn't it just because your system was idle?

I'd like to say no, because close to 100% of the offcpu-time samples'
TID is 0, using unmodified 'perf record --off-cpu' yielded different
results, with most of the samples having a non-zero TID.

I also tested collecting the cgroup id with and without BPF output.

This is the process that I'm testing for:
perf $ cat /proc/3555534/cgroup
0::/user.slice/user-0.slice/user@0.service/tmux-spawn-cf25ea6d-587f-408d-92=
f5-2c8e97cb2a74.scope

Without BPF, we'd get (I added a printf to print cgroup id):
perf $ ./perf record -F 1 --all-cgroups --off-cpu -p 3555534
^C[ perf record: Woken up 1 times to write data ]
evsel cycles:P cgroup id is 7654
evsel cycles:P cgroup id is 7654
evsel cycles:P cgroup id is 7654
evsel cycles:P cgroup id is 7654
evsel offcpu-time cgroup id is 1
evsel offcpu-time cgroup id is 1
evsel offcpu-time cgroup id is 1
evsel offcpu-time cgroup id is 0
[ perf record: Captured and wrote 0.024 MB perf.data (8 samples) ]

perf $ ./perf script -F cgroup,sym,event
   cycles:P:  /user.slice/user-0.slice/user@0.service/tmux-spawn-cf25ea6d-5=
87f-408d-92f5-2c8e97>
   cycles:P:  /user.slice/user-0.slice/user@0.service/tmux-spawn-cf25ea6d-5=
87f-408d-92f5-2c8e97>
   cycles:P:  /user.slice/user-0.slice/user@0.service/tmux-spawn-cf25ea6d-5=
87f-408d-92f5-2c8e97>
   cycles:P:  /user.slice/user-0.slice/user@0.service/tmux-spawn-cf25ea6d-5=
87f-408d-92f5-2c8e97>
offcpu-time:  /
offcpu-time:  /
offcpu-time:  /
offcpu-time:  unknown

Now the reason why one of the offcpu samples' cgroup id is 0, is
because it's an at-the-end sample, 0 is used as a placeholder. The
direct offcpu sample has a cgroup id of 1(collected by perf_event
itself), which is wrong.

Let's use BPF to collect offcpu sample, we'll get:
perf $ ./perf record -F 1 --all-cgroups --off-cpu -p 3555534
^C[ perf record: Woken up 1 times to write data ]
evsel cycles:P cgroup id is 7654
evsel cycles:P cgroup id is 7654
evsel cycles:P cgroup id is 7654
evsel cycles:P cgroup id is 7654
evsel offcpu-time cgroup id is 1
evsel offcpu-time cgroup id is 7654 (embedded data overwrite)
evsel offcpu-time cgroup id is 1
evsel offcpu-time cgroup id is 7654 (embedded data overwrite)
evsel offcpu-time cgroup id is 0
evsel offcpu-time cgroup id is 7654 (embedded data overwrite)

This time offcpu-time's cgroup_id is correct.
perf $ ./perf script -F cgroup,sym,event
   cycles:P:  /user.slice/user-0.slice/user@0.service/tmux-spawn-cf25ea6d-5=
87f-408d-92f5-2c8e97>
   cycles:P:  /user.slice/user-0.slice/user@0.service/tmux-spawn-cf25ea6d-5=
87f-408d-92f5-2c8e97>
   cycles:P:  /user.slice/user-0.slice/user@0.service/tmux-spawn-cf25ea6d-5=
87f-408d-92f5-2c8e97>
   cycles:P:  /user.slice/user-0.slice/user@0.service/tmux-spawn-cf25ea6d-5=
87f-408d-92f5-2c8e97>
offcpu-time:  /user.slice/user-0.slice/user@0.service/tmux-spawn-cf25ea6d-5=
87f-408d-92f5-2c8e97>
offcpu-time:  /user.slice/user-0.slice/user@0.service/tmux-spawn-cf25ea6d-5=
87f-408d-92f5-2c8e97>
offcpu-time:  /user.slice/user-0.slice/user@0.service/tmux-spawn-cf25ea6d-5=
87f-408d-92f5-2c8e97>

>
> >
> > We need to retrieve PERF_SAMPLE_TID, PERF_SAMPLE_PERIOD,
> > PERF_SAMPLE_CALLCHAIN, and PERF_SAMPLE_CGROUP using BPF and output thes=
e
> > four fields.
> >
> > Add perf_event_array map for dumping direct off-cpu samples, but keep
> > the at-the-end approach.
> >
> > Tons of checking before access, to pass the BPF verifier.
> >
> > If off-cpu time (represented as delta) exceeds the off-cpu threshold, d=
o
> > output.
> >
> > Suggested-by: Namhyung Kim <namhyung@kernel.org>
> > Signed-off-by: Howard Chu <howardchu95@gmail.com>
> > ---
> >  tools/perf/util/bpf_skel/off_cpu.bpf.c | 133 +++++++++++++++++++++++++
> >  1 file changed, 133 insertions(+)
> >
> > diff --git a/tools/perf/util/bpf_skel/off_cpu.bpf.c b/tools/perf/util/b=
pf_skel/off_cpu.bpf.c
> > index cca1b6990a57..95cc130bb67e 100644
> > --- a/tools/perf/util/bpf_skel/off_cpu.bpf.c
> > +++ b/tools/perf/util/bpf_skel/off_cpu.bpf.c
> > @@ -18,6 +18,9 @@
> >  #define MAX_STACKS   32
> >  #define MAX_ENTRIES  102400
> >
> > +#define MAX_CPUS  4096
> > +#define MAX_OFFCPU_LEN 128
> > +
> >  struct tstamp_data {
> >       __u32 stack_id;
> >       __u32 state;
> > @@ -32,6 +35,7 @@ struct offcpu_key {
> >       __u64 cgroup_id;
> >  };
> >
> > +/* for dumping at the end */
> >  struct {
> >       __uint(type, BPF_MAP_TYPE_STACK_TRACE);
> >       __uint(key_size, sizeof(__u32));
> > @@ -39,6 +43,45 @@ struct {
> >       __uint(max_entries, MAX_ENTRIES);
> >  } stacks SEC(".maps");
> >
> > +struct offcpu_data {
> > +     u64 array[MAX_OFFCPU_LEN];
> > +};
> > +
> > +struct stack_data {
> > +     u64 array[MAX_STACKS];
> > +};
> > +
> > +struct {
> > +     __uint(type, BPF_MAP_TYPE_PERF_EVENT_ARRAY);
> > +     __uint(key_size, sizeof(__u32));
> > +     __uint(value_size, sizeof(__u32));
> > +     __uint(max_entries, MAX_CPUS);
> > +} offcpu_output SEC(".maps");
> > +
> > +/* temporary offcpu sample */
> > +struct {
> > +     __uint(type, BPF_MAP_TYPE_PERCPU_ARRAY);
> > +     __uint(key_size, sizeof(__u32));
> > +     __uint(value_size, sizeof(struct offcpu_data));
> > +     __uint(max_entries, 1);
> > +} offcpu_payload SEC(".maps");
> > +
> > +/* temporary stack data */
> > +struct {
> > +     __uint(type, BPF_MAP_TYPE_PERCPU_ARRAY);
> > +     __uint(key_size, sizeof(__u32));
> > +     __uint(value_size, sizeof(struct stack_data));
> > +     __uint(max_entries, 1);
> > +} stack_tmp SEC(".maps");
> > +
> > +/* cached stack per task storage */
> > +struct {
> > +     __uint(type, BPF_MAP_TYPE_TASK_STORAGE);
> > +     __uint(map_flags, BPF_F_NO_PREALLOC);
> > +     __type(key, int);
> > +     __type(value, struct stack_data);
> > +} stack_cache SEC(".maps");
> > +
> >  struct {
> >       __uint(type, BPF_MAP_TYPE_TASK_STORAGE);
> >       __uint(map_flags, BPF_F_NO_PREALLOC);
> > @@ -184,12 +227,75 @@ static inline int can_record(struct task_struct *=
t, int state)
> >       return 1;
> >  }
> >
> > +static inline bool check_bounds(int index)
> > +{
> > +     if (index >=3D 0 && index < MAX_OFFCPU_LEN)
> > +             return true;
> > +
> > +     return false;
> > +}
> > +
> > +static inline int copy_stack(struct stack_data *from,
> > +                          struct offcpu_data *to, int n)
> > +{
> > +     int max_stacks =3D MAX_STACKS, len =3D 0;
> > +
> > +     if (!from)
> > +             return len;
> > +
> > +     for (int i =3D 0; i < max_stacks && from->array[i]; ++i) {
> > +             if (check_bounds(n + 2 + i)) {
> > +                     to->array[n + 2 + i] =3D from->array[i];
> > +                     ++len;
> > +             }
> > +     }
> > +     return len;
> > +}
> > +
> > +static int off_cpu_dump(void *ctx, struct offcpu_data *data, struct of=
fcpu_key *key,
> > +                     struct stack_data *stack_p, __u64 delta, __u64 ti=
mestamp)
> > +{
> > +     int size, n =3D 0, ip_pos =3D -1, len =3D 0;
> > +
> > +     if (sample_type & PERF_SAMPLE_TID && check_bounds(n))
> > +             data->array[n++] =3D (u64)key->tgid << 32 | key->pid;
> > +     if (sample_type & PERF_SAMPLE_PERIOD && check_bounds(n))
> > +             data->array[n++] =3D delta;
> > +     if (sample_type & PERF_SAMPLE_CALLCHAIN && check_bounds(n + 2)) {
> > +             /* data->array[n] is callchain->nr (updated later) */
> > +             data->array[n + 1] =3D PERF_CONTEXT_USER;
> > +             data->array[n + 2] =3D 0;
> > +
> > +             len =3D copy_stack(stack_p, data, n);
> > +
> > +             /* update length of callchain */
> > +             data->array[n] =3D len + 1;
> > +
> > +             /* update sample ip with the first callchain entry */
> > +             if (ip_pos >=3D 0)
> > +                     data->array[ip_pos] =3D data->array[n + 2];
>
> Where is ip_pos set?  I guess we don't need this as we don't update the
> SAMPLE_IP here.

Yes, ip_pos is unnecessary.
>
> > +
> > +             /* calculate sample callchain data->array length */
> > +             n +=3D len + 2;
> > +     }
> > +     if (sample_type & PERF_SAMPLE_CGROUP && check_bounds(n))
> > +             data->array[n++] =3D key->cgroup_id;
> > +
> > +     size =3D n * sizeof(u64);
> > +     if (size >=3D 0 && size <=3D MAX_OFFCPU_LEN * sizeof(u64))
> > +             bpf_perf_event_output(ctx, &offcpu_output, BPF_F_CURRENT_=
CPU, data, size);
> > +
> > +     return 0;
> > +}
> > +
> >  static int off_cpu_stat(u64 *ctx, struct task_struct *prev,
> >                       struct task_struct *next, int state)
> >  {
> >       __u64 ts;
> >       __u32 stack_id;
> >       struct tstamp_data *pelem;
> > +     struct stack_data *stack_tmp_p, *stack_p;
> > +     int zero =3D 0, len =3D 0;
> >
> >       ts =3D bpf_ktime_get_ns();
> >
> > @@ -199,6 +305,25 @@ static int off_cpu_stat(u64 *ctx, struct task_stru=
ct *prev,
> >       stack_id =3D bpf_get_stackid(ctx, &stacks,
> >                                  BPF_F_FAST_STACK_CMP | BPF_F_USER_STAC=
K);
> >
> > +     /* cache stacks */
> > +     stack_tmp_p =3D bpf_map_lookup_elem(&stack_tmp, &zero);
> > +     if (stack_tmp_p)
> > +             len =3D bpf_get_stack(ctx, stack_tmp_p->array, MAX_STACKS=
 * sizeof(u64),
> > +                                 BPF_F_USER_STACK) / sizeof(u64);
>
> Looks redundant, but not sure if we share the stackid..

I use bpf_get_stack() because there's only one helper for
BPF_MAP_TYPE_STACK_TRACE, that's bpf_get_stackid(). Meaning one can
only collect, not retrieve stack traces(such as using
bpf_map_lookup_elem()) with STACK_TRACE map in BPF program. For
STACK_TRACE map, all the processing is in user space. Please see
kernel/bpf/verifier.c(line 8982):

case BPF_MAP_TYPE_RINGBUF:
if (func_id !=3D BPF_FUNC_ringbuf_output &&
    func_id !=3D BPF_FUNC_ringbuf_reserve &&
    func_id !=3D BPF_FUNC_ringbuf_query &&
    func_id !=3D BPF_FUNC_ringbuf_reserve_dynptr &&
    func_id !=3D BPF_FUNC_ringbuf_submit_dynptr &&
    func_id !=3D BPF_FUNC_ringbuf_discard_dynptr)
    goto error;
break;
case BPF_MAP_TYPE_STACK_TRACE:
if (func_id !=3D BPF_FUNC_get_stackid)
    goto error;
break;

So I chose the easiest way to do it, which is collecting stack traces
__twice__. Once for direct samples, once for at-the-end samples. We
could do the similar stack_id saving for direct off-cpu samples, and
then access that stack trace map in post, do you think we should do
that instead?

>
> > +
> > +     /*
> > +      * if stacks are successfully collected, cache them to task_stora=
ge, they are then
> > +      * dumped if the off-cpu time hits the threshold.
> > +      */
> > +     if (len > 0) {
> > +             stack_p =3D bpf_task_storage_get(&stack_cache, prev, NULL=
,
> > +                                            BPF_LOCAL_STORAGE_GET_F_CR=
EATE);
> > +             if (stack_p) {
> > +                     for (int i =3D 0; i < len && i < MAX_STACKS; ++i)
> > +                             stack_p->array[i] =3D stack_tmp_p->array[=
i];
> > +             }
> > +     }
>
> Why not use the task storage to get the stacktrace directly?

I'm sorry, could you elaborate? I thought we were saving the
prev's(process that gets sched_out) stack traces for later
dumping(when sched_in).

Thanks,
Howard
>
> Thanks,
> Namhyung
>
> > +
> >       pelem =3D bpf_task_storage_get(&tstamp, prev, NULL,
> >                                    BPF_LOCAL_STORAGE_GET_F_CREATE);
> >       if (!pelem)
> > @@ -228,6 +353,14 @@ static int off_cpu_stat(u64 *ctx, struct task_stru=
ct *prev,
> >               else
> >                       bpf_map_update_elem(&off_cpu, &key, &delta, BPF_A=
NY);
> >
> > +             if (delta >=3D offcpu_thresh) {
> > +                     struct offcpu_data *data =3D bpf_map_lookup_elem(=
&offcpu_payload, &zero);
> > +
> > +                     stack_p =3D bpf_task_storage_get(&stack_cache, ne=
xt, NULL, 0);
> > +                     if (data && stack_p)
> > +                             off_cpu_dump(ctx, data, &key, stack_p, de=
lta, pelem->timestamp);
> > +             }
> > +
> >               /* prevent to reuse the timestamp later */
> >               pelem->timestamp =3D 0;
> >       }
> > --
> > 2.45.2
> >
