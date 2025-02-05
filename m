Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34DCE17E;
	Wed,  5 Feb 2025 00:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738714709; cv=none; b=Bs2smneee3Uooy+NN2LYwy7WpRSOS4/TyiONBp8r0k9PXir3CmPXBKuEfAQFnGYBvix3/EGOjl+Xuyp5nb9MR4BfbvtSxOs/xE/J0kxc1MhlnGyFXukViB1i6cME+rpkDwOdGaFm6q7CIdFcJoQGrfJeGIyp7QvjR6zgoihYk9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738714709; c=relaxed/simple;
	bh=6rpNioCKtFoP05RhE8/qA9E5K5ZZ44Bw5ouwv+qtuE8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GXShJ1UL/DA5T1+D0rv7ANKogzy7rHHRLvZFTp7jzf7P7zRBWpvFZ4bN+4lXCfgWZD6k3IxSPvy2urDiPIYiZkTGxcO6R4PImkXBigvgE57a6FETPhXQ2R3bAknIxBARv8dzxi8Vzr3A0TaFBjnqMaS19vbYsYL/y5V8AZbnsYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KeLbmgQN; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KeLbmgQN"
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-6f666c94285so43596447b3.3;
        Tue, 04 Feb 2025 16:18:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738714706; x=1739319506; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5rtdthpBJrwcgNAq4MLskdy0qqwWwNY3y4M9TWna4I4=;
        b=KeLbmgQNKG2v5t2iZngdh96th5yeLTpbVfU/ee4lwv+tISQnQbsnDTk9sfFYc/rfW6
         h6O28QQXPdKWmM+YRmftyMO7blTUo1yqjiPi97SQ6m6CJ8Tla0j/C5Lq1J3PV+cgLkcx
         WQVrQ3x5Ebur1NpSz3/Yl9cinU1n0xB+M7W3lL2PWEU4uC4TXPCgOQ5mhMI0NF2lF9mK
         nR+F9BgXrKGuHrS0xiicIKzTNXLhwOMaJU8DuIWqHEjHYyueY2sJlxgrKHAAz6vZ8Y+4
         BWnoEQVgma4vdmdY8nlJli1KK4Mlmve/ZeEUg7uQe0ywKgBG/HGKKrKHbvckKp6308s7
         NWqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738714706; x=1739319506;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5rtdthpBJrwcgNAq4MLskdy0qqwWwNY3y4M9TWna4I4=;
        b=w2kg0AjOsy3pA1PFQKayKOZ9k/9EErXVdoBjcZNsSvunauQue/yUWpShrKRqZAfequ
         ZNXorfHM4BlOHvgt52FbaA/vWTFczMeb5OwkCKqCnx4n6McgXQOp0n3B6CTgZnRHW7Q/
         xOSwtYb35PUhvy+53QDxwdr+a6rq2zW0uptaVoNvwMbwpCPp71oQPeIf+KEO4xt0tqNz
         NpZUUSCV+TV4UMhjCkya8u+QWsWdH4Via5le8wn2/lXjUNhCTQGXo03gcn4IR4wmUEJT
         ossirqsikPQ++pqJy1Onc/pDsWkO9EHC86U32xYzDtflos54g71MoHMf3L0OqIjID8jt
         LoPw==
X-Forwarded-Encrypted: i=1; AJvYcCUe9epPZd1gjnCQeXF9R77qxXZk6IC1eHHoZ1iAR7Dnl6xE0pAqyKoJcnEnTuOG11BAZNjIAcVgi+UR@vger.kernel.org, AJvYcCV8a+4XGCIPx6QGXw0KFGNrSxSqJagJErqLivZ/ZSWXqWszH/VhXnDWCtKAJWhaVGA+/DL33im2pkchPBYjnSniuw==@vger.kernel.org, AJvYcCXSUuFyG4N95NCttfagY5AtgUKxiOGiVsPUjtxY8dXFqqZBK0GH4DZ3uqQpohViHOcTiRKGmd31Hd7HVwUJ@vger.kernel.org
X-Gm-Message-State: AOJu0YwxvgcbdeoDSDPfF/GgFOpkdyI8xU+kMj2SvEudoSdMGdPOJqiZ
	17mHiBUaPS4a1obfun8QT5Xd2xsLWUR0UrqE+VsE28F2FyD7Msj/bEKnmfdCR9O2AgmGzQWOZKV
	VHrI77oLb47b1fTHd0f5XY2pRobU=
X-Gm-Gg: ASbGncsde5hpV3n5drxBhUeFggfIlofmczfKbcMlpZIv2UJrJNymFwD83wp3PrzgiPl
	csgVnVaKG6azVQwWOe4FnppjjtJHIm0Y+nC5a3NRwyK+C5q/3N47JnCtv+yGWXYk2/2kDNzE=
X-Google-Smtp-Source: AGHT+IF3QL4TV9dOUKXBDIW4smHixZqZ7eyBlAej1OtpZinafoFrVYf+NsTxW5fsk6+TsJa0eFgWGuStQ5v0p7b6AVs=
X-Received: by 2002:a05:690c:6887:b0:6ee:ad00:f157 with SMTP id
 00721157ae682-6f989fbd804mr8890997b3.32.1738714705880; Tue, 04 Feb 2025
 16:18:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250201071455.718247-1-irogers@google.com> <20250201071455.718247-4-irogers@google.com>
In-Reply-To: <20250201071455.718247-4-irogers@google.com>
From: Howard Chu <howardchu95@gmail.com>
Date: Tue, 4 Feb 2025 16:18:15 -0800
X-Gm-Features: AWEUYZnuMzmRVdL_FfRkW9jppkCICfaQ_wjHAwbcvcTmvJen8yb5sy5tfsisiX0
Message-ID: <CAH0uvoi8J3mg8UxpiuHrCpH07jyGNkSfDFybs7EFcxgOoxYx7g@mail.gmail.com>
Subject: Re: [PATCH v1 3/7] perf syscalltbl: Remove struct syscalltbl
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>, 
	James Clark <james.clark@linaro.org>, Mike Leach <mike.leach@linaro.org>, 
	Leo Yan <leo.yan@linux.dev>, Guo Ren <guoren@kernel.org>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Charlie Jenkins <charlie@rivosinc.com>, 
	Bibo Mao <maobibo@loongson.cn>, Arnd Bergmann <arnd@arndb.de>, Huacai Chen <chenhuacai@kernel.org>, 
	Catalin Marinas <catalin.marinas@arm.com>, Jiri Slaby <jirislaby@kernel.org>, 
	=?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@rivosinc.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org, 
	linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Ian,

On Fri, Jan 31, 2025 at 11:15=E2=80=AFPM Ian Rogers <irogers@google.com> wr=
ote:
>
> The syscalltbl held entries of system call name and number pairs,
> generated from a native syscalltbl at start up. As there are gaps in
> the system call number there is a notion of index into the
> table. Going forward we want the system call table to be identifiable
> by a machine type, for example, i386 vs x86-64. Change the interface
> to the syscalltbl so (1) a (currently unused machine type of EM_HOST)
> is passed (2) the index to syscall number and system call name mapping
> is computed at build time.
>
> Two tables are used for this, an array of system call number to name,
> an array of system call numbers sorted by the system call name. The
> sorted array doesn't store strings in part to save memory and
> relocations. The index notion is carried forward and is an index into
> the sorted array of system call numbers, the data structures are
> opaque (held only in syscalltbl.c), and so the number of indices for a
> machine type is exposed as a new API.
>
> The arrays are computed in the syscalltbl.sh script and so no start-up
> time computation and storage is necessary.
>
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/builtin-trace.c       |  88 +++++++++++++-----------
>  tools/perf/scripts/syscalltbl.sh |  36 ++++------
>  tools/perf/util/syscalltbl.c     | 113 ++++++++++---------------------
>  tools/perf/util/syscalltbl.h     |  22 ++----
>  4 files changed, 103 insertions(+), 156 deletions(-)
>
> diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
> index 10d3ad0d21f7..7e3aa2f6c5e2 100644
> --- a/tools/perf/builtin-trace.c
> +++ b/tools/perf/builtin-trace.c
> @@ -143,7 +143,6 @@ struct syscall_fmt {
>
>  struct trace {
>         struct perf_tool        tool;
> -       struct syscalltbl       *sctbl;
>         struct {
>                 /** Sorted sycall numbers used by the trace. */
>                 struct syscall  *table;
> @@ -2100,7 +2099,7 @@ static int syscall__read_info(struct syscall *sc, s=
truct trace *trace)
>                 return 0;
>         }
>
> -       name =3D syscalltbl__name(trace->sctbl, sc->id);
> +       name =3D syscalltbl__name(sc->e_machine, sc->id);
>         if (name =3D=3D NULL) {
>                 sc->nonexistent =3D true;
>                 return -EEXIST;
> @@ -2196,10 +2195,14 @@ static int trace__validate_ev_qualifier(struct tr=
ace *trace)
>
>         strlist__for_each_entry(pos, trace->ev_qualifier) {
>                 const char *sc =3D pos->s;
> -               int id =3D syscalltbl__id(trace->sctbl, sc), match_next =
=3D -1;
> +               /*
> +                * TODO: Assume more than the validation/warnings are all=
 for
> +                * the same binary type as perf.
> +                */
> +               int id =3D syscalltbl__id(EM_HOST, sc), match_next =3D -1=
;
>
>                 if (id < 0) {
> -                       id =3D syscalltbl__strglobmatch_first(trace->sctb=
l, sc, &match_next);
> +                       id =3D syscalltbl__strglobmatch_first(EM_HOST, sc=
, &match_next);
>                         if (id >=3D 0)
>                                 goto matches;
>
> @@ -2219,7 +2222,7 @@ static int trace__validate_ev_qualifier(struct trac=
e *trace)
>                         continue;
>
>                 while (1) {
> -                       id =3D syscalltbl__strglobmatch_next(trace->sctbl=
, sc, &match_next);
> +                       id =3D syscalltbl__strglobmatch_next(EM_HOST, sc,=
 &match_next);
>                         if (id < 0)
>                                 break;
>                         if (nr_allocated =3D=3D nr_used) {
> @@ -2673,6 +2676,7 @@ static int trace__sys_enter(struct trace *trace, st=
ruct evsel *evsel,
>         int id =3D perf_evsel__sc_tp_uint(evsel, id, sample), err =3D -1;
>         int augmented_args_size =3D 0;
>         void *augmented_args =3D NULL;
> +       /* TODO: get e_machine from thread. */
>         struct syscall *sc =3D trace__syscall_info(trace, evsel, EM_HOST,=
 id);
>         struct thread_trace *ttrace;
>
> @@ -2747,6 +2751,7 @@ static int trace__fprintf_sys_enter(struct trace *t=
race, struct evsel *evsel,
>         struct thread_trace *ttrace;
>         struct thread *thread;
>         int id =3D perf_evsel__sc_tp_uint(evsel, id, sample), err =3D -1;
> +       /* TODO: get e_machine from thread. */
>         struct syscall *sc =3D trace__syscall_info(trace, evsel, EM_HOST,=
 id);
>         char msg[1024];
>         void *args, *augmented_args =3D NULL;
> @@ -2822,6 +2827,7 @@ static int trace__sys_exit(struct trace *trace, str=
uct evsel *evsel,
>         struct thread *thread;
>         int id =3D perf_evsel__sc_tp_uint(evsel, id, sample), err =3D -1,=
 callchain_ret =3D 0, printed =3D 0;
>         int alignment =3D trace->args_alignment;
> +       /* TODO: get e_machine from thread. */
>         struct syscall *sc =3D trace__syscall_info(trace, evsel, EM_HOST,=
 id);
>         struct thread_trace *ttrace;
>
> @@ -3175,6 +3181,7 @@ static int trace__event_handler(struct trace *trace=
, struct evsel *evsel,
>
>         if (evsel =3D=3D trace->syscalls.events.bpf_output) {
>                 int id =3D perf_evsel__sc_tp_uint(evsel, id, sample);
> +               /* TODO: get e_machine from thread. */
>                 struct syscall *sc =3D trace__syscall_info(trace, evsel, =
EM_HOST, id);
>
>                 if (sc) {
> @@ -3678,9 +3685,9 @@ static struct bpf_program *trace__find_syscall_bpf_=
prog(struct trace *trace, str
>         return trace->skel->progs.syscall_unaugmented;
>  }
>
> -static void trace__init_syscall_bpf_progs(struct trace *trace, int id)
> +static void trace__init_syscall_bpf_progs(struct trace *trace, int e_mac=
hine, int id)
>  {
> -       struct syscall *sc =3D trace__syscall_info(trace, NULL, EM_HOST, =
id);
> +       struct syscall *sc =3D trace__syscall_info(trace, NULL, e_machine=
, id);
>
>         if (sc =3D=3D NULL)
>                 return;
> @@ -3689,22 +3696,22 @@ static void trace__init_syscall_bpf_progs(struct =
trace *trace, int id)
>         sc->bpf_prog.sys_exit  =3D trace__find_syscall_bpf_prog(trace, sc=
, sc->fmt ? sc->fmt->bpf_prog_name.sys_exit  : NULL,  "exit");
>  }
>
> -static int trace__bpf_prog_sys_enter_fd(struct trace *trace, int id)
> +static int trace__bpf_prog_sys_enter_fd(struct trace *trace, int e_machi=
ne, int id)
>  {
> -       struct syscall *sc =3D trace__syscall_info(trace, NULL, EM_HOST, =
id);
> +       struct syscall *sc =3D trace__syscall_info(trace, NULL, e_machine=
, id);
>         return sc ? bpf_program__fd(sc->bpf_prog.sys_enter) : bpf_program=
__fd(trace->skel->progs.syscall_unaugmented);
>  }
>
> -static int trace__bpf_prog_sys_exit_fd(struct trace *trace, int id)
> +static int trace__bpf_prog_sys_exit_fd(struct trace *trace, int e_machin=
e, int id)
>  {
> -       struct syscall *sc =3D trace__syscall_info(trace, NULL, EM_HOST, =
id);
> +       struct syscall *sc =3D trace__syscall_info(trace, NULL, e_machine=
, id);
>         return sc ? bpf_program__fd(sc->bpf_prog.sys_exit) : bpf_program_=
_fd(trace->skel->progs.syscall_unaugmented);
>  }
>
> -static int trace__bpf_sys_enter_beauty_map(struct trace *trace, int key,=
 unsigned int *beauty_array)
> +static int trace__bpf_sys_enter_beauty_map(struct trace *trace, int e_ma=
chine, int key, unsigned int *beauty_array)
>  {
>         struct tep_format_field *field;
> -       struct syscall *sc =3D trace__syscall_info(trace, NULL, EM_HOST, =
key);
> +       struct syscall *sc =3D trace__syscall_info(trace, NULL, e_machine=
, key);
>         const struct btf_type *bt;
>         char *struct_offset, *tmp, name[32];
>         bool can_augment =3D false;
> @@ -3800,9 +3807,9 @@ static struct bpf_program *trace__find_usable_bpf_p=
rog_entry(struct trace *trace
>         return NULL;
>
>  try_to_find_pair:
> -       for (int i =3D 0; i < trace->sctbl->syscalls.nr_entries; ++i) {
> -               int id =3D syscalltbl__id_at_idx(trace->sctbl, i);
> -               struct syscall *pair =3D trace__syscall_info(trace, NULL,=
 EM_HOST, id);
> +       for (int i =3D 0, num_idx =3D syscalltbl__num_idx(sc->e_machine);=
 i < num_idx; ++i) {
> +               int id =3D syscalltbl__id_at_idx(sc->e_machine, i);
> +               struct syscall *pair =3D trace__syscall_info(trace, NULL,=
 sc->e_machine, id);
>                 struct bpf_program *pair_prog;
>                 bool is_candidate =3D false;
>
> @@ -3886,7 +3893,7 @@ static struct bpf_program *trace__find_usable_bpf_p=
rog_entry(struct trace *trace
>         return NULL;
>  }
>
> -static int trace__init_syscalls_bpf_prog_array_maps(struct trace *trace)
> +static int trace__init_syscalls_bpf_prog_array_maps(struct trace *trace,=
 int e_machine)
>  {
>         int map_enter_fd =3D bpf_map__fd(trace->skel->maps.syscalls_sys_e=
nter);
>         int map_exit_fd  =3D bpf_map__fd(trace->skel->maps.syscalls_sys_e=
xit);
> @@ -3894,27 +3901,27 @@ static int trace__init_syscalls_bpf_prog_array_ma=
ps(struct trace *trace)
>         int err =3D 0;
>         unsigned int beauty_array[6];
>
> -       for (int i =3D 0; i < trace->sctbl->syscalls.nr_entries; ++i) {
> -               int prog_fd, key =3D syscalltbl__id_at_idx(trace->sctbl, =
i);
> +       for (int i =3D 0, num_idx =3D syscalltbl__num_idx(e_machine); i <=
 num_idx; ++i) {
> +               int prog_fd, key =3D syscalltbl__id_at_idx(e_machine, i);
>
>                 if (!trace__syscall_enabled(trace, key))
>                         continue;
>
> -               trace__init_syscall_bpf_progs(trace, key);
> +               trace__init_syscall_bpf_progs(trace, e_machine, key);
>
>                 // It'll get at least the "!raw_syscalls:unaugmented"
> -               prog_fd =3D trace__bpf_prog_sys_enter_fd(trace, key);
> +               prog_fd =3D trace__bpf_prog_sys_enter_fd(trace, e_machine=
, key);
>                 err =3D bpf_map_update_elem(map_enter_fd, &key, &prog_fd,=
 BPF_ANY);
>                 if (err)
>                         break;
> -               prog_fd =3D trace__bpf_prog_sys_exit_fd(trace, key);
> +               prog_fd =3D trace__bpf_prog_sys_exit_fd(trace, e_machine,=
 key);
>                 err =3D bpf_map_update_elem(map_exit_fd, &key, &prog_fd, =
BPF_ANY);
>                 if (err)
>                         break;
>
>                 /* use beauty_map to tell BPF how many bytes to collect, =
set beauty_map's value here */
>                 memset(beauty_array, 0, sizeof(beauty_array));
> -               err =3D trace__bpf_sys_enter_beauty_map(trace, key, (unsi=
gned int *)beauty_array);
> +               err =3D trace__bpf_sys_enter_beauty_map(trace, e_machine,=
 key, (unsigned int *)beauty_array);
>                 if (err)
>                         continue;
>                 err =3D bpf_map_update_elem(beauty_map_fd, &key, beauty_a=
rray, BPF_ANY);
> @@ -3950,9 +3957,9 @@ static int trace__init_syscalls_bpf_prog_array_maps=
(struct trace *trace)
>          * first and second arg (this one on the raw_syscalls:sys_exit pr=
og
>          * array tail call, then that one will be used.
>          */
> -       for (int i =3D 0; i < trace->sctbl->syscalls.nr_entries; ++i) {
> -               int key =3D syscalltbl__id_at_idx(trace->sctbl, i);
> -               struct syscall *sc =3D trace__syscall_info(trace, NULL, E=
M_HOST, key);
> +       for (int i =3D 0, num_idx =3D syscalltbl__num_idx(e_machine); i <=
 num_idx; ++i) {
> +               int key =3D syscalltbl__id_at_idx(e_machine, i);
> +               struct syscall *sc =3D trace__syscall_info(trace, NULL, e=
_machine, key);
>                 struct bpf_program *pair_prog;
>                 int prog_fd;
>
> @@ -4389,8 +4396,13 @@ static int trace__run(struct trace *trace, int arg=
c, const char **argv)
>                 goto out_error_mem;
>
>  #ifdef HAVE_BPF_SKEL
> -       if (trace->skel && trace->skel->progs.sys_enter)
> -               trace__init_syscalls_bpf_prog_array_maps(trace);
> +       if (trace->skel && trace->skel->progs.sys_enter) {
> +               /*
> +                * TODO: Initialize for all host binary machine types, no=
t just
> +                * those matching the perf binary.
> +                */
> +               trace__init_syscalls_bpf_prog_array_maps(trace, EM_HOST);
> +       }
>  #endif
>
>         if (trace->ev_qualifier_ids.nr > 0) {
> @@ -4415,7 +4427,8 @@ static int trace__run(struct trace *trace, int argc=
, const char **argv)
>          *  So just disable this beautifier (SCA_FD, SCA_FDAT) when 'clos=
e' is
>          *  not in use.
>          */
> -       trace->fd_path_disabled =3D !trace__syscall_enabled(trace, syscal=
ltbl__id(trace->sctbl, "close"));
> +       /* TODO: support for more than just perf binary machine type clos=
e. */
> +       trace->fd_path_disabled =3D !trace__syscall_enabled(trace, syscal=
ltbl__id(EM_HOST, "close"));
>
>         err =3D trace__expand_filters(trace, &evsel);
>         if (err)
> @@ -4688,8 +4701,7 @@ DEFINE_RESORT_RB(syscall_stats, a->msecs > b->msecs=
,
>         entry->msecs   =3D stats ? (u64)stats->stats.n * (avg_stats(&stat=
s->stats) / NSEC_PER_MSEC) : 0;
>  }
>
> -static size_t thread__dump_stats(struct thread_trace *ttrace,
> -                                struct trace *trace, FILE *fp)
> +static size_t thread__dump_stats(struct thread_trace *ttrace, struct tra=
ce *trace, int e_machine, FILE *fp)
>  {
>         size_t printed =3D 0;
>         struct syscall *sc;
> @@ -4717,7 +4729,7 @@ static size_t thread__dump_stats(struct thread_trac=
e *ttrace,
>                         pct =3D avg ? 100.0 * stddev_stats(&stats->stats)=
 / avg : 0.0;
>                         avg /=3D NSEC_PER_MSEC;
>
> -                       sc =3D trace__syscall_info(trace, /*evsel=3D*/NUL=
L, EM_HOST,
> +                       sc =3D trace__syscall_info(trace, /*evsel=3D*/NUL=
L, e_machine,
>                                                  syscall_stats_entry->sys=
call);
>                         if (!sc)
>                                 continue;
> @@ -4767,7 +4779,8 @@ static size_t trace__fprintf_thread(FILE *fp, struc=
t thread *thread, struct trac
>         else if (fputc('\n', fp) !=3D EOF)
>                 ++printed;
>
> -       printed +=3D thread__dump_stats(ttrace, trace, fp);
> +       /* TODO: get e_machine from thread. */
> +       printed +=3D thread__dump_stats(ttrace, trace, EM_HOST, fp);
>
>         return printed;
>  }
> @@ -4999,8 +5012,9 @@ static int trace__parse_events_option(const struct =
option *opt, const char *str,
>                         *sep =3D '\0';
>
>                 list =3D 0;
> -               if (syscalltbl__id(trace->sctbl, s) >=3D 0 ||
> -                   syscalltbl__strglobmatch_first(trace->sctbl, s, &idx)=
 >=3D 0) {
> +               /* TODO: support for more than just perf binary machine t=
ype syscalls. */
> +               if (syscalltbl__id(EM_HOST, s) >=3D 0 ||
> +                   syscalltbl__strglobmatch_first(EM_HOST, s, &idx) >=3D=
 0) {
>                         list =3D 1;
>                         goto do_concat;
>                 }
> @@ -5136,7 +5150,6 @@ static void trace__exit(struct trace *trace)
>                         syscall__exit(&trace->syscalls.table[i]);
>                 zfree(&trace->syscalls.table);
>         }
> -       syscalltbl__delete(trace->sctbl);
>         zfree(&trace->perfconfig_events);
>  }
>
> @@ -5282,9 +5295,8 @@ int cmd_trace(int argc, const char **argv)
>         sigaction(SIGCHLD, &sigchld_act, NULL);
>
>         trace.evlist =3D evlist__new();
> -       trace.sctbl =3D syscalltbl__new();
>
> -       if (trace.evlist =3D=3D NULL || trace.sctbl =3D=3D NULL) {
> +       if (trace.evlist =3D=3D NULL) {
>                 pr_err("Not enough memory to run!\n");
>                 err =3D -ENOMEM;
>                 goto out;
> diff --git a/tools/perf/scripts/syscalltbl.sh b/tools/perf/scripts/syscal=
ltbl.sh
> index 1ce0d5aa8b50..a39b3013b103 100755
> --- a/tools/perf/scripts/syscalltbl.sh
> +++ b/tools/perf/scripts/syscalltbl.sh
> @@ -50,37 +50,27 @@ fi
>  infile=3D"$1"
>  outfile=3D"$2"
>
> -nxt=3D0
> -
> -syscall_macro() {
> -    nr=3D"$1"
> -    name=3D"$2"
> -
> -    echo "     [$nr] =3D \"$name\","
> -}
> -
> -emit() {
> -    nr=3D"$1"
> -    entry=3D"$2"
> -
> -    syscall_macro "$nr" "$entry"
> -}
> -
> -echo "static const char *const syscalltbl[] =3D {" > $outfile
> -
>  sorted_table=3D$(mktemp /tmp/syscalltbl.XXXXXX)
>  grep -E "^[0-9]+[[:space:]]+$abis" "$infile" | sort -n > $sorted_table
>
> -max_nr=3D0
> +echo "static const char *const syscall_num_to_name[] =3D {" > $outfile
>  # the params are: nr abi name entry compat
>  # use _ for intentionally unused variables according to SC2034
>  while read nr _ name _ _; do
> -    emit "$nr" "$name" >> $outfile
> -    max_nr=3D$nr
> +       echo "  [$nr] =3D \"$name\"," >> $outfile
>  done < $sorted_table
> +echo "};" >> $outfile
>
> -rm -f $sorted_table
> +echo "static const uint16_t syscall_sorted_names[] =3D {" >> $outfile
>
> +# When sorting by name, add a suffix of 0s upto 20 characters so that sy=
stem
> +# calls that differ with a numerical suffix don't sort before those
> +# without. This default behavior of sort differs from that of strcmp use=
d at
> +# runtime. Use sed to strip the trailing 0s suffix afterwards.
> +grep -E "^[0-9]+[[:space:]]+$abis" "$infile" | awk '{printf $3; for (i =
=3D length($3); i < 20; i++) { printf "0"; }; print " " $1}'| sort | sed 's=
/\([a-zA-Z1-9]\+\)0\+ \([0-9]\+\)/\1 \2/' > $sorted_table
> +while read name nr; do
> +       echo "  $nr,    /* $name */" >> $outfile
> +done < $sorted_table
>  echo "};" >> $outfile
>
> -echo "#define SYSCALLTBL_MAX_ID ${max_nr}" >> $outfile
> +rm -f $sorted_table
> diff --git a/tools/perf/util/syscalltbl.c b/tools/perf/util/syscalltbl.c
> index 2f76241494c8..760ac4d0869f 100644
> --- a/tools/perf/util/syscalltbl.c
> +++ b/tools/perf/util/syscalltbl.c
> @@ -9,6 +9,7 @@
>  #include <stdlib.h>
>  #include <asm/bitsperlong.h>
>  #include <linux/compiler.h>
> +#include <linux/kernel.h>
>  #include <linux/zalloc.h>
>
>  #include <string.h>
> @@ -20,112 +21,66 @@
>    #include <asm/syscalls_32.h>
>  #endif
>
> -const int syscalltbl_native_max_id =3D SYSCALLTBL_MAX_ID;
> -static const char *const *syscalltbl_native =3D syscalltbl;
> +const char *syscalltbl__name(int e_machine __maybe_unused, int id)
> +{
> +       if (id >=3D 0 && id <=3D (int)ARRAY_SIZE(syscall_num_to_name))
> +               return syscall_num_to_name[id];
> +       return NULL;
> +}
>
> -struct syscall {
> -       int id;
> +struct syscall_cmp_key {
>         const char *name;
> +       const char *const *tbl;
>  };
>
>  static int syscallcmpname(const void *vkey, const void *ventry)
>  {
> -       const char *key =3D vkey;
> -       const struct syscall *entry =3D ventry;
> +       const struct syscall_cmp_key *key =3D vkey;
> +       const uint16_t *entry =3D ventry;
>
> -       return strcmp(key, entry->name);
> +       return strcmp(key->name, key->tbl[*entry]);
>  }
>
> -static int syscallcmp(const void *va, const void *vb)
> +int syscalltbl__id(int e_machine __maybe_unused, const char *name)
>  {
> -       const struct syscall *a =3D va, *b =3D vb;
> -
> -       return strcmp(a->name, b->name);
> +       struct syscall_cmp_key key =3D {
> +               .name =3D name,
> +               .tbl =3D syscall_num_to_name,
> +       };
> +       const int *id =3D bsearch(&key, syscall_sorted_names,
> +                               ARRAY_SIZE(syscall_sorted_names),
> +                               sizeof(syscall_sorted_names[0]),
> +                               syscallcmpname);

This has puzzled me several times lol. Searching in
syscall_sorted_names returns an int id... I get that it's sorted by
name, but maybe call it syscall_ids_sorted_by_name, syscall_ids, or
syscall_ids_sorted instead?

> +
> +       return id ? *id : -1;
>  }
>
> -static int syscalltbl__init_native(struct syscalltbl *tbl)
> +int syscalltbl__num_idx(int e_machine __maybe_unused)

I haven't found many instances of *num_idx in the source tree
indicating the length of an array. Are you okay with
syscalltbl__nr_idx()?

Otherwise LGTM.

Thanks,
Howard
>  {
> -       int nr_entries =3D 0, i, j;
> -       struct syscall *entries;
> -
> -       for (i =3D 0; i <=3D syscalltbl_native_max_id; ++i)
> -               if (syscalltbl_native[i])
> -                       ++nr_entries;
> -
> -       entries =3D tbl->syscalls.entries =3D malloc(sizeof(struct syscal=
l) * nr_entries);
> -       if (tbl->syscalls.entries =3D=3D NULL)
> -               return -1;
> -
> -       for (i =3D 0, j =3D 0; i <=3D syscalltbl_native_max_id; ++i) {
> -               if (syscalltbl_native[i]) {
> -                       entries[j].name =3D syscalltbl_native[i];
> -                       entries[j].id =3D i;
> -                       ++j;
> -               }
> -       }
> -
> -       qsort(tbl->syscalls.entries, nr_entries, sizeof(struct syscall), =
syscallcmp);
> -       tbl->syscalls.nr_entries =3D nr_entries;
> -       tbl->syscalls.max_id     =3D syscalltbl_native_max_id;
> -       return 0;
> +       return ARRAY_SIZE(syscall_sorted_names);
>  }
>
> -struct syscalltbl *syscalltbl__new(void)
> +int syscalltbl__id_at_idx(int e_machine __maybe_unused, int idx)
>  {
> -       struct syscalltbl *tbl =3D malloc(sizeof(*tbl));
> -       if (tbl) {
> -               if (syscalltbl__init_native(tbl)) {
> -                       free(tbl);
> -                       return NULL;
> -               }
> -       }
> -       return tbl;
> -}
> -
> -void syscalltbl__delete(struct syscalltbl *tbl)
> -{
> -       zfree(&tbl->syscalls.entries);
> -       free(tbl);
> -}
> -
> -const char *syscalltbl__name(const struct syscalltbl *tbl __maybe_unused=
, int id)
> -{
> -       return id <=3D syscalltbl_native_max_id ? syscalltbl_native[id]: =
NULL;
> -}
> -
> -int syscalltbl__id(struct syscalltbl *tbl, const char *name)
> -{
> -       struct syscall *sc =3D bsearch(name, tbl->syscalls.entries,
> -                                    tbl->syscalls.nr_entries, sizeof(*sc=
),
> -                                    syscallcmpname);
> -
> -       return sc ? sc->id : -1;
> -}
> -
> -int syscalltbl__id_at_idx(struct syscalltbl *tbl, int idx)
> -{
> -       struct syscall *syscalls =3D tbl->syscalls.entries;
> -
> -       return idx < tbl->syscalls.nr_entries ? syscalls[idx].id : -1;
> +       return syscall_sorted_names[idx];
>  }
>
> -int syscalltbl__strglobmatch_next(struct syscalltbl *tbl, const char *sy=
scall_glob, int *idx)
> +int syscalltbl__strglobmatch_next(int e_machine __maybe_unused, const ch=
ar *syscall_glob, int *idx)
>  {
> -       int i;
> -       struct syscall *syscalls =3D tbl->syscalls.entries;
> +       for (int i =3D *idx + 1; i < (int)ARRAY_SIZE(syscall_sorted_names=
); ++i) {
> +               const char *name =3D syscall_num_to_name[syscall_sorted_n=
ames[i]];
>
> -       for (i =3D *idx + 1; i < tbl->syscalls.nr_entries; ++i) {
> -               if (strglobmatch(syscalls[i].name, syscall_glob)) {
> +               if (strglobmatch(name, syscall_glob)) {
>                         *idx =3D i;
> -                       return syscalls[i].id;
> +                       return syscall_sorted_names[i];
>                 }
>         }
>
>         return -1;
>  }
>
> -int syscalltbl__strglobmatch_first(struct syscalltbl *tbl, const char *s=
yscall_glob, int *idx)
> +int syscalltbl__strglobmatch_first(int e_machine, const char *syscall_gl=
ob, int *idx)
>  {
>         *idx =3D -1;
> -       return syscalltbl__strglobmatch_next(tbl, syscall_glob, idx);
> +       return syscalltbl__strglobmatch_next(e_machine, syscall_glob, idx=
);
>  }
> diff --git a/tools/perf/util/syscalltbl.h b/tools/perf/util/syscalltbl.h
> index 362411a6d849..2bb628eff367 100644
> --- a/tools/perf/util/syscalltbl.h
> +++ b/tools/perf/util/syscalltbl.h
> @@ -2,22 +2,12 @@
>  #ifndef __PERF_SYSCALLTBL_H
>  #define __PERF_SYSCALLTBL_H
>
> -struct syscalltbl {
> -       struct {
> -               int max_id;
> -               int nr_entries;
> -               void *entries;
> -       } syscalls;
> -};
> +const char *syscalltbl__name(int e_machine, int id);
> +int syscalltbl__id(int e_machine, const char *name);
> +int syscalltbl__num_idx(int e_machine);
> +int syscalltbl__id_at_idx(int e_machine, int idx);
>
> -struct syscalltbl *syscalltbl__new(void);
> -void syscalltbl__delete(struct syscalltbl *tbl);
> -
> -const char *syscalltbl__name(const struct syscalltbl *tbl, int id);
> -int syscalltbl__id(struct syscalltbl *tbl, const char *name);
> -int syscalltbl__id_at_idx(struct syscalltbl *tbl, int idx);
> -
> -int syscalltbl__strglobmatch_first(struct syscalltbl *tbl, const char *s=
yscall_glob, int *idx);
> -int syscalltbl__strglobmatch_next(struct syscalltbl *tbl, const char *sy=
scall_glob, int *idx);
> +int syscalltbl__strglobmatch_first(int e_machine, const char *syscall_gl=
ob, int *idx);
> +int syscalltbl__strglobmatch_next(int e_machine, const char *syscall_glo=
b, int *idx);
>
>  #endif /* __PERF_SYSCALLTBL_H */
> --
> 2.48.1.362.g079036d154-goog
>
