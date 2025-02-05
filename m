Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5105A173;
	Wed,  5 Feb 2025 00:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738714338; cv=none; b=TkBe0k2bevo9csqg1/TA1M44v2vAzFVcgll5tzxh6M+eV7UMJWhszBq+SHCqGP8buswMKipbZEov8DRamBjwwx44Jjd/BIZcKfzUSpvLF8Z6Fo5MNLqTHGbU1Slk1N0UdAQgpLmCaZFvuMRROUmQBI8c2UydC5+mMU0UmiulJis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738714338; c=relaxed/simple;
	bh=BQ7KDqiMBAjM5ZEMMzNCF9Kq/cWzWjI8o8r4yiZ717c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nKs7x9cSLpncz7pGRjDRbU9SFzhQw2ubBnld3TicI4DsdWyTIPuP5hCXdGr7NAxOa5H6J7DPAfrQSoJHPK867JlSYopRusgyN/4rITGH3XJw3ghKCDLKBYMSyqJHjrLUyMyzy0jNIVkj9EGL1mzYOvXeqguzfMXw8YRyreWpBUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZsoRV1oT; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZsoRV1oT"
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-6f974a5e5e3so14630447b3.0;
        Tue, 04 Feb 2025 16:12:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738714335; x=1739319135; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MpTKFbLMSoKrPhXAQQBFXwIc5BgdqJVRd6V21V7NRDM=;
        b=ZsoRV1oTBk5snmcco9LiK4gbaRW9g91mpGQpII07MqkftRky54qW23taKKqjzyTxSM
         ZIeM1BMWlDutgaGHjzG9/2rFrisnFsZ0fLzgTOM/yEqnTgh5NK3G5PMEAFSQdfQJfYMJ
         bj/cI4jG0fLMeeWMEPvGxHj1zkN7Br6kSgS0pq9bIgyKnHdyx/HWjqi5kI0k/RyorGzK
         KpiumBju2R1lL958H9iszx0EvvkARU0TQ0FWjmURg778LB8YNA13pyirO0XAmkkHOujg
         CwzP6JtQGlkDWyQYTkYYN3VXEHghYu0/FDeHHXuwa0EJfK/NDWUxYzOynFThebzxozFN
         EqfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738714335; x=1739319135;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MpTKFbLMSoKrPhXAQQBFXwIc5BgdqJVRd6V21V7NRDM=;
        b=KVdkG0TKm14mo7WQWKkICX/t98JU7wXFxjnc8NqLvdNrOegqLx0YqE0BA+ymxjEbJj
         7h8grCzlBMsDEE24afCUtQnLqjtuYbeRPAuhOPIG/Pnyvp43kTt6ynh945tJbFr3/TU2
         UKsyfhBIxPRtjqtWDjEKlHCQRkhxKSr0myuUVPr7H3WFwD189G5SjPdkcy29iPMia7n7
         r1LG3n53I/fI1SurHWugIShuhQnmfInn7r1Ba+fq+npiVULUG1f+mVwIOWt1vsV3C2i5
         mUS23Ccd1E5YxVoesESZtvfAZ9yYXIEmtjyKVcZryEoKKzJUK6ZpW8SHwYd2YfXg7myn
         2H8Q==
X-Forwarded-Encrypted: i=1; AJvYcCUoji9vPFdndNtPxxIzKRk4cXWvoVGG7G7UGqMOLRtzSrp+1vUN10d3+NC7w6fHEcJPZKHjwOlweij6OTKFMW9/mg==@vger.kernel.org, AJvYcCV6HoDFhrNpKwHJfkpc0DrESgAYQaNMJGsXx1+DMvV/36BlJAbmnz/kZwX6kHBV/VDCW5y/NS8GGSD+@vger.kernel.org, AJvYcCWw7Ir9kEXw5p7jofBq9hBKVLpt3Kp2EvrMSqCjKUEZxfNOCtSKi3zT0Fky0otnIfJBwHt8Zgjoj2l1kMjR@vger.kernel.org
X-Gm-Message-State: AOJu0YzjQgyu434PJmPGuCyaUquMC8HPL3IGX67IZd+9faa1WWT0JNmx
	XuzTTCYC/HNMi8kpYiXT+4UAi2ovEo6FgfOW+mFEzasrhoCSoZzqj3VGmKQ4FtlM0GMRITT9SF4
	XNwmSWL0LCdEhNdvUi+LbmHCQVhc=
X-Gm-Gg: ASbGnctTpW32ZMgZQL+oprETbnHiaZvjdqJQMQuoFJT8MUcrZDVhH4eh+Ey1N4nd3jY
	cKn20/oegrbxOk8AqZ6fmxqh+D9uM6BwgOeux0ne7dv1i2vipW0MZzB+KSesHtoq9+DKR5vk=
X-Google-Smtp-Source: AGHT+IHZDxWlHKGGnBPgCLgl8zvxhRaHlC2bhE3+pL8he5Wjieca/BQSaBN5v36SLdGsq1w/fGUvHTp8rgDgGCRQniE=
X-Received: by 2002:a05:690c:3385:b0:6f9:7d7d:a725 with SMTP id
 00721157ae682-6f989f86a5bmr8707697b3.33.1738714334971; Tue, 04 Feb 2025
 16:12:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250201071455.718247-1-irogers@google.com> <20250201071455.718247-3-irogers@google.com>
In-Reply-To: <20250201071455.718247-3-irogers@google.com>
From: Howard Chu <howardchu95@gmail.com>
Date: Tue, 4 Feb 2025 16:12:04 -0800
X-Gm-Features: AWEUYZnrLPcAVatH_8hMj0vAgavMm9A_MK2I4QgLyTsUdL2nS8yu-yE3h7vkFJU
Message-ID: <CAH0uvogeG9rUw+1huquE=8fEq8AdJaSygS94G8a05=cHckjndg@mail.gmail.com>
Subject: Re: [PATCH v1 2/7] perf trace: Reorganize syscalls
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

Thanks for doing this.

On Fri, Jan 31, 2025 at 11:15=E2=80=AFPM Ian Rogers <irogers@google.com> wr=
ote:
>
> Identify struct syscall information in the syscalls table by a machine
> type and syscall number, not just system call number. Having the
> machine type means that 32-bit system calls can be differentiated from
> 64-bit ones on a machine capable of both. Having a table for all
> machine types and all system call numbers would be too large, so
> maintain a sorted array of system calls as they are encountered.
>
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/builtin-trace.c | 178 +++++++++++++++++++++++++------------
>  1 file changed, 119 insertions(+), 59 deletions(-)
>
> diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
> index ac97632f13dc..10d3ad0d21f7 100644
> --- a/tools/perf/builtin-trace.c
> +++ b/tools/perf/builtin-trace.c
> @@ -66,6 +66,7 @@
>  #include "rb_resort.h"
>  #include "../perf.h"
>  #include "trace_augment.h"
> +#include "dwarf-regs.h"
>
>  #include <errno.h>
>  #include <inttypes.h>
> @@ -86,6 +87,7 @@
>
>  #include <linux/ctype.h>
>  #include <perf/mmap.h>
> +#include <tools/libc_compat.h>
>
>  #ifdef HAVE_LIBTRACEEVENT
>  #include <event-parse.h>
> @@ -143,7 +145,10 @@ struct trace {
>         struct perf_tool        tool;
>         struct syscalltbl       *sctbl;
>         struct {
> +               /** Sorted sycall numbers used by the trace. */
>                 struct syscall  *table;
> +               /** Size of table. */
> +               size_t          table_size;
>                 struct {
>                         struct evsel *sys_enter,
>                                 *sys_exit,
> @@ -1445,22 +1450,37 @@ static const struct syscall_fmt *syscall_fmt__fin=
d_by_alias(const char *alias)
>         return __syscall_fmt__find_by_alias(syscall_fmts, nmemb, alias);
>  }
>
> -/*
> - * is_exit: is this "exit" or "exit_group"?
> - * is_open: is this "open" or "openat"? To associate the fd returned in =
sys_exit with the pathname in sys_enter.
> - * args_size: sum of the sizes of the syscall arguments, anything after =
that is augmented stuff: pathname for openat, etc.
> - * nonexistent: Just a hole in the syscall table, syscall id not allocat=
ed
> +/**
> + * struct syscall
>   */
>  struct syscall {
> +       /** @e_machine: The ELF machine associated with the entry. */
> +       int e_machine;
> +       /** @id: id value from the tracepoint, the system call number. */
> +       int id;
>         struct tep_event    *tp_format;
>         int                 nr_args;
> +       /**
> +        * @args_size: sum of the sizes of the syscall arguments, anythin=
g
> +        * after that is augmented stuff: pathname for openat, etc.
> +        */
> +
>         int                 args_size;
>         struct {
>                 struct bpf_program *sys_enter,
>                                    *sys_exit;
>         }                   bpf_prog;
> +       /** @is_exit: is this "exit" or "exit_group"? */
>         bool                is_exit;
> +       /**
> +        * @is_open: is this "open" or "openat"? To associate the fd retu=
rned in
> +        * sys_exit with the pathname in sys_enter.
> +        */
>         bool                is_open;
> +       /**
> +        * @nonexistent: Name lookup failed. Just a hole in the syscall t=
able,
> +        * syscall id not allocated.
> +        */
>         bool                nonexistent;
>         bool                use_btf;
>         struct tep_format_field *args;
> @@ -2066,22 +2086,21 @@ static int syscall__set_arg_fmts(struct syscall *=
sc)
>         return 0;
>  }
>
> -static int trace__read_syscall_info(struct trace *trace, int id)
> +static int syscall__read_info(struct syscall *sc, struct trace *trace)
>  {
>         char tp_name[128];
> -       struct syscall *sc;
> -       const char *name =3D syscalltbl__name(trace->sctbl, id);
> +       const char *name;
>         int err;
>
> -       if (trace->syscalls.table =3D=3D NULL) {
> -               trace->syscalls.table =3D calloc(trace->sctbl->syscalls.m=
ax_id + 1, sizeof(*sc));
> -               if (trace->syscalls.table =3D=3D NULL)
> -                       return -ENOMEM;
> -       }
> -       sc =3D trace->syscalls.table + id;
>         if (sc->nonexistent)
>                 return -EEXIST;
>
> +       if (sc->name) {
> +               /* Info already read. */
> +               return 0;
> +       }
> +
> +       name =3D syscalltbl__name(trace->sctbl, sc->id);
>         if (name =3D=3D NULL) {
>                 sc->nonexistent =3D true;
>                 return -EEXIST;
> @@ -2104,11 +2123,12 @@ static int trace__read_syscall_info(struct trace =
*trace, int id)
>          */
>         if (IS_ERR(sc->tp_format)) {
>                 sc->nonexistent =3D true;
> -               return PTR_ERR(sc->tp_format);
> +               err =3D PTR_ERR(sc->tp_format);
> +               sc->tp_format =3D NULL;
> +               return err;
>         }
>
> -       if (syscall__alloc_arg_fmts(sc, IS_ERR(sc->tp_format) ?
> -                                       RAW_SYSCALL_ARGS_NUM : sc->tp_for=
mat->format.nr_fields))
> +       if (syscall__alloc_arg_fmts(sc, sc->tp_format->format.nr_fields))

Makes sense because IS_ERR(sc->tp_format) is checked a few lines
above. However, nr_fields can be 7 with the __syscall_nr prefix. I
sent a patch to fix this, but it's not included here... Never mind,
it's off-topic. This patch looks good.

Thanks,
Howard

>                 return -ENOMEM;
>
>         sc->args =3D sc->tp_format->format.fields;
> @@ -2397,13 +2417,67 @@ static size_t syscall__scnprintf_args(struct sysc=
all *sc, char *bf, size_t size,
>         return printed;
>  }
>
> +static void syscall__init(struct syscall *sc, int e_machine, int id)
> +{
> +       memset(sc, 0, sizeof(*sc));
> +       sc->e_machine =3D e_machine;
> +       sc->id =3D id;
> +}
> +
> +static void syscall__exit(struct syscall *sc)
> +{
> +       if (!sc)
> +               return;
> +
> +       zfree(&sc->arg_fmt);
> +}
> +
> +static int syscall__cmp(const void *va, const void *vb)
> +{
> +       const struct syscall *a =3D va, *b =3D vb;
> +
> +       if (a->e_machine !=3D b->e_machine)
> +               return a->e_machine - b->e_machine;
> +
> +       return a->id - b->id;
> +}
> +
> +static struct syscall *trace__find_syscall(struct trace *trace, int e_ma=
chine, int id)
> +{
> +       struct syscall key =3D {
> +               .e_machine =3D e_machine,
> +               .id =3D id,
> +       };
> +       struct syscall *sc, *tmp;
> +
> +       sc =3D bsearch(&key, trace->syscalls.table, trace->syscalls.table=
_size,
> +                    sizeof(struct syscall), syscall__cmp);
> +       if (sc)
> +               return sc;
> +
> +       tmp =3D reallocarray(trace->syscalls.table, trace->syscalls.table=
_size + 1,
> +                          sizeof(struct syscall));
> +       if (!tmp)
> +               return NULL;
> +
> +       trace->syscalls.table =3D tmp;
> +       sc =3D &trace->syscalls.table[trace->syscalls.table_size++];
> +       syscall__init(sc, e_machine, id);
> +       qsort(trace->syscalls.table, trace->syscalls.table_size, sizeof(s=
truct syscall),
> +             syscall__cmp);
> +       sc =3D bsearch(&key, trace->syscalls.table, trace->syscalls.table=
_size,
> +                    sizeof(struct syscall), syscall__cmp);
> +       return sc;
> +}
> +
>  typedef int (*tracepoint_handler)(struct trace *trace, struct evsel *evs=
el,
>                                   union perf_event *event,
>                                   struct perf_sample *sample);
>
> -static struct syscall *trace__syscall_info(struct trace *trace,
> -                                          struct evsel *evsel, int id)
> +static struct syscall *trace__syscall_info(struct trace *trace, struct e=
vsel *evsel,
> +                                          int e_machine, int id)
>  {
> +       struct syscall *sc;
>         int err =3D 0;
>
>         if (id < 0) {
> @@ -2428,28 +2502,20 @@ static struct syscall *trace__syscall_info(struct=
 trace *trace,
>
>         err =3D -EINVAL;
>
> -       if (id > trace->sctbl->syscalls.max_id) {
> -               goto out_cant_read;
> -       }
> -
> -       if ((trace->syscalls.table =3D=3D NULL || trace->syscalls.table[i=
d].name =3D=3D NULL) &&
> -           (err =3D trace__read_syscall_info(trace, id)) !=3D 0)
> -               goto out_cant_read;
> +       sc =3D trace__find_syscall(trace, e_machine, id);
> +       if (sc)
> +               err =3D syscall__read_info(sc, trace);
>
> -       if (trace->syscalls.table && trace->syscalls.table[id].nonexisten=
t)
> -               goto out_cant_read;
> -
> -       return &trace->syscalls.table[id];
> -
> -out_cant_read:
> -       if (verbose > 0) {
> +       if (err && verbose > 0) {
>                 char sbuf[STRERR_BUFSIZE];
> -               fprintf(trace->output, "Problems reading syscall %d: %d (=
%s)", id, -err, str_error_r(-err, sbuf, sizeof(sbuf)));
> -               if (id <=3D trace->sctbl->syscalls.max_id && trace->sysca=
lls.table[id].name !=3D NULL)
> -                       fprintf(trace->output, "(%s)", trace->syscalls.ta=
ble[id].name);
> +
> +               fprintf(trace->output, "Problems reading syscall %d: %d (=
%s)", id, -err,
> +                       str_error_r(-err, sbuf, sizeof(sbuf)));
> +               if (sc && sc->name)
> +                       fprintf(trace->output, "(%s)", sc->name);
>                 fputs(" information\n", trace->output);
>         }
> -       return NULL;
> +       return err ? NULL : sc;
>  }
>
>  struct syscall_stats {
> @@ -2596,14 +2662,6 @@ static void *syscall__augmented_args(struct syscal=
l *sc, struct perf_sample *sam
>         return NULL;
>  }
>
> -static void syscall__exit(struct syscall *sc)
> -{
> -       if (!sc)
> -               return;
> -
> -       zfree(&sc->arg_fmt);
> -}
> -
>  static int trace__sys_enter(struct trace *trace, struct evsel *evsel,
>                             union perf_event *event __maybe_unused,
>                             struct perf_sample *sample)
> @@ -2615,7 +2673,7 @@ static int trace__sys_enter(struct trace *trace, st=
ruct evsel *evsel,
>         int id =3D perf_evsel__sc_tp_uint(evsel, id, sample), err =3D -1;
>         int augmented_args_size =3D 0;
>         void *augmented_args =3D NULL;
> -       struct syscall *sc =3D trace__syscall_info(trace, evsel, id);
> +       struct syscall *sc =3D trace__syscall_info(trace, evsel, EM_HOST,=
 id);
>         struct thread_trace *ttrace;
>
>         if (sc =3D=3D NULL)
> @@ -2689,7 +2747,7 @@ static int trace__fprintf_sys_enter(struct trace *t=
race, struct evsel *evsel,
>         struct thread_trace *ttrace;
>         struct thread *thread;
>         int id =3D perf_evsel__sc_tp_uint(evsel, id, sample), err =3D -1;
> -       struct syscall *sc =3D trace__syscall_info(trace, evsel, id);
> +       struct syscall *sc =3D trace__syscall_info(trace, evsel, EM_HOST,=
 id);
>         char msg[1024];
>         void *args, *augmented_args =3D NULL;
>         int augmented_args_size;
> @@ -2764,7 +2822,7 @@ static int trace__sys_exit(struct trace *trace, str=
uct evsel *evsel,
>         struct thread *thread;
>         int id =3D perf_evsel__sc_tp_uint(evsel, id, sample), err =3D -1,=
 callchain_ret =3D 0, printed =3D 0;
>         int alignment =3D trace->args_alignment;
> -       struct syscall *sc =3D trace__syscall_info(trace, evsel, id);
> +       struct syscall *sc =3D trace__syscall_info(trace, evsel, EM_HOST,=
 id);
>         struct thread_trace *ttrace;
>
>         if (sc =3D=3D NULL)
> @@ -3117,7 +3175,7 @@ static int trace__event_handler(struct trace *trace=
, struct evsel *evsel,
>
>         if (evsel =3D=3D trace->syscalls.events.bpf_output) {
>                 int id =3D perf_evsel__sc_tp_uint(evsel, id, sample);
> -               struct syscall *sc =3D trace__syscall_info(trace, evsel, =
id);
> +               struct syscall *sc =3D trace__syscall_info(trace, evsel, =
EM_HOST, id);
>
>                 if (sc) {
>                         fprintf(trace->output, "%s(", sc->name);
> @@ -3622,7 +3680,7 @@ static struct bpf_program *trace__find_syscall_bpf_=
prog(struct trace *trace, str
>
>  static void trace__init_syscall_bpf_progs(struct trace *trace, int id)
>  {
> -       struct syscall *sc =3D trace__syscall_info(trace, NULL, id);
> +       struct syscall *sc =3D trace__syscall_info(trace, NULL, EM_HOST, =
id);
>
>         if (sc =3D=3D NULL)
>                 return;
> @@ -3633,20 +3691,20 @@ static void trace__init_syscall_bpf_progs(struct =
trace *trace, int id)
>
>  static int trace__bpf_prog_sys_enter_fd(struct trace *trace, int id)
>  {
> -       struct syscall *sc =3D trace__syscall_info(trace, NULL, id);
> +       struct syscall *sc =3D trace__syscall_info(trace, NULL, EM_HOST, =
id);
>         return sc ? bpf_program__fd(sc->bpf_prog.sys_enter) : bpf_program=
__fd(trace->skel->progs.syscall_unaugmented);
>  }
>
>  static int trace__bpf_prog_sys_exit_fd(struct trace *trace, int id)
>  {
> -       struct syscall *sc =3D trace__syscall_info(trace, NULL, id);
> +       struct syscall *sc =3D trace__syscall_info(trace, NULL, EM_HOST, =
id);
>         return sc ? bpf_program__fd(sc->bpf_prog.sys_exit) : bpf_program_=
_fd(trace->skel->progs.syscall_unaugmented);
>  }
>
>  static int trace__bpf_sys_enter_beauty_map(struct trace *trace, int key,=
 unsigned int *beauty_array)
>  {
>         struct tep_format_field *field;
> -       struct syscall *sc =3D trace__syscall_info(trace, NULL, key);
> +       struct syscall *sc =3D trace__syscall_info(trace, NULL, EM_HOST, =
key);
>         const struct btf_type *bt;
>         char *struct_offset, *tmp, name[32];
>         bool can_augment =3D false;
> @@ -3744,7 +3802,7 @@ static struct bpf_program *trace__find_usable_bpf_p=
rog_entry(struct trace *trace
>  try_to_find_pair:
>         for (int i =3D 0; i < trace->sctbl->syscalls.nr_entries; ++i) {
>                 int id =3D syscalltbl__id_at_idx(trace->sctbl, i);
> -               struct syscall *pair =3D trace__syscall_info(trace, NULL,=
 id);
> +               struct syscall *pair =3D trace__syscall_info(trace, NULL,=
 EM_HOST, id);
>                 struct bpf_program *pair_prog;
>                 bool is_candidate =3D false;
>
> @@ -3894,7 +3952,7 @@ static int trace__init_syscalls_bpf_prog_array_maps=
(struct trace *trace)
>          */
>         for (int i =3D 0; i < trace->sctbl->syscalls.nr_entries; ++i) {
>                 int key =3D syscalltbl__id_at_idx(trace->sctbl, i);
> -               struct syscall *sc =3D trace__syscall_info(trace, NULL, k=
ey);
> +               struct syscall *sc =3D trace__syscall_info(trace, NULL, E=
M_HOST, key);
>                 struct bpf_program *pair_prog;
>                 int prog_fd;
>
> @@ -4659,7 +4717,11 @@ static size_t thread__dump_stats(struct thread_tra=
ce *ttrace,
>                         pct =3D avg ? 100.0 * stddev_stats(&stats->stats)=
 / avg : 0.0;
>                         avg /=3D NSEC_PER_MSEC;
>
> -                       sc =3D &trace->syscalls.table[syscall_stats_entry=
->syscall];
> +                       sc =3D trace__syscall_info(trace, /*evsel=3D*/NUL=
L, EM_HOST,
> +                                                syscall_stats_entry->sys=
call);
> +                       if (!sc)
> +                               continue;
> +
>                         printed +=3D fprintf(fp, "   %-15s", sc->name);
>                         printed +=3D fprintf(fp, " %8" PRIu64 " %6" PRIu6=
4 " %9.3f %9.3f %9.3f",
>                                            n, stats->nr_failures, syscall=
_stats_entry->msecs, min, avg);
> @@ -5067,12 +5129,10 @@ static int trace__config(const char *var, const c=
har *value, void *arg)
>
>  static void trace__exit(struct trace *trace)
>  {
> -       int i;
> -
>         strlist__delete(trace->ev_qualifier);
>         zfree(&trace->ev_qualifier_ids.entries);
>         if (trace->syscalls.table) {
> -               for (i =3D 0; i <=3D trace->sctbl->syscalls.max_id; i++)
> +               for (size_t i =3D 0; i < trace->syscalls.table_size; i++)
>                         syscall__exit(&trace->syscalls.table[i]);
>                 zfree(&trace->syscalls.table);
>         }
> --
> 2.48.1.362.g079036d154-goog
>
