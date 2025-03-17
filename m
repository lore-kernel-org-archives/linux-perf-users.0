Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2AFC2236FD
	for <linux-perf-users@vger.kernel.org>; Mon, 17 Mar 2025 15:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742223730; cv=none; b=DyeXuRCJOmcIWh8A1Og0XKerAtM3bMAgdTzIsuk+yulh00eok6J/+xidtjSznUw1/GW1X//akE8S2cpuflTwYKwCdUj+3bwIHfGJWa+ZFw5vUXVif+a9MA4cWv/ChNKDJv1TIHdb+8rZUPT9vgbE86w/GMiM4MuNb1po+eGoZfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742223730; c=relaxed/simple;
	bh=w06EUXkwlzUpH9L+Fxe4uiAMV8sDsY4AacIWe1dFuio=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Fe5yQV/7Zlgyuu7Yxj1CZhgcj/wdjoyiwpsj9LIk/tWbsy1unqPbZHOLXYNn8j0aApkCJZHRw+rSvKyQUGaTwNLIiQW/Zvn1mJulv5i8iEQBvz10z2vLLkVnxSFKzGhsKfyst4pK8FL7mUt6FJqCtUE69EAFZmwRHkq98VcZe1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jhNDAf2O; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jhNDAf2O"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-225489a0ae6so22665ad.0
        for <linux-perf-users@vger.kernel.org>; Mon, 17 Mar 2025 08:02:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742223727; x=1742828527; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jg3YtmB4valCbm7zVC0JDdo2qYGwLpSkWEkmRJ/2RkA=;
        b=jhNDAf2OJax0MgZCvJsPyS1bJBr9KXpHgcgtjSfxbIQjXOSEUCVoJIcptDZonQYUH/
         oMOQF/e61I97LH0RWlDKsUm+SybIKvubca3YgE4dWHDYrKRxRNLVzThNByprpQpf9/fj
         TyxnWoo6eFSQF8VFbfzDcfcHsIU/KM23Idj4YFu8IVyNarF81UBRtCtazHOlOblmoYyw
         wQEyJUOhNHFFHLey8SXyGqblO6Du5bEJiLrY8ENwmywpZ9iTOgqqIziFXXr6PkfBnJRT
         sKz0/bzwynROKuzX94CU3vC6DlWm/o7Ey8cfHH3bAuQtUWNSL1wlfnaO4DhADrY2jIpP
         vxqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742223727; x=1742828527;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jg3YtmB4valCbm7zVC0JDdo2qYGwLpSkWEkmRJ/2RkA=;
        b=IPpUp003iKa1zUQbpodNTDdGTOPm6xfOOI82/O6UuTsyTP8Z5mLn7haje2QkxMqYe1
         41Z4HEQtY+X0OYWmKS1b/4pNCfSDjT4s+W3YRJcJemW/uQ9thNNXDCDs8KnF7b9zHXqI
         4clJoy35OyNaGy44ochoaD7P7s9Jj03DzspmCC8LKN2RXYu8LGuOETyj3LnzzXNCJYvG
         FxLIpsg3A+HUE7A4HOmFHcDSNfAr+yRNtG4BvkmlNMZ3I9Nq5nc2fqpxnHQgUwXvoNIc
         +MCqhMIybTwru5DF9hawxbeVjtS9BUviFGOPT13DJk4cDTW+1MV0SdWgvMfdF+cBNvpZ
         Bz3A==
X-Forwarded-Encrypted: i=1; AJvYcCUbY5gSrx17/qjY/WIXbcpE6UYwZrBjqpyPxya2WpupROBV+Xyp9V6Fq6a69qoI5uDVo+7CD2BpZnameNAYyqdF@vger.kernel.org
X-Gm-Message-State: AOJu0YzsLTXmZdCGXwFJloEFbmJ7zAv8Czd9lzdelKeFb771rxT4z1fB
	r1Iyo4sQDN1zgHDNQ0SlVwj48aoxFl+AaWCPX5TYsBsNejLVd33u18zL+bdKY5jGKO5T1rTWBCU
	M6IEJc5tyiJXGAeaPpI5ingz1bc4wyrcikH86
X-Gm-Gg: ASbGnctRh9bdTVj98DgiNjmXAtnCFKKNuq3ivt5TMceuTIZvxzQh0TFSr1ROiYRTw7F
	1QrpHSwggEppAQ1Nh3xzNsuHo2yetdZnE5TmWQsE8/B/6hD3EvNqaiTt+UyBY/fDEbfQZ89w2dH
	x9B6ISRlqNu9VeBPLKZLEwDV2GmZGzsLse6806yuBhOpp5RJTw5deZlcg=
X-Google-Smtp-Source: AGHT+IH/In9Xn9Q6fd6+GqFKulEafF8p3Jv23xNcBcIIk7P9+Kx1bGmfsiiY4ZsHsK6NikQcu964bBPbUcABTsk9x0E=
X-Received: by 2002:a17:903:904:b0:21f:9f4:4a03 with SMTP id
 d9443c01a7336-225f58a00d7mr3749775ad.21.1742223726726; Mon, 17 Mar 2025
 08:02:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250308003209.234114-1-irogers@google.com> <Z9KFLGpenwOP32q3@google.com>
 <Z9M24AJzui9lFbGo@x1> <Z9M9-YhDJg3NgiUy@x1> <Z9NEX3j_1RUvaFI0@x1>
 <Z9PCjQ8PhOadVGQ8@google.com> <Z9RjHpEJGWtj8PAM@x1> <Z9Rm0W6YLpxKIcI1@x1>
 <Z9SWDGsdgagMr8PV@x1> <Z9YHCzINiu4uBQ8B@google.com>
In-Reply-To: <Z9YHCzINiu4uBQ8B@google.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 17 Mar 2025 08:01:55 -0700
X-Gm-Features: AQ5f1JpZJLqN-cOJTEfM6rSqHnKbXe3loO-Lb0N6y7TXpAp97Yyc9XZzYy5I-RU
Message-ID: <CAP-5=fVoSVttcgFFxWrWAGXyXJm52LF8yaNR564HWcf0Jx4eUA@mail.gmail.com>
Subject: Re: [PATCH v5 00/11] perf: Support multiple system call tables in the build
To: Namhyung Kim <namhyung@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>, 
	James Clark <james.clark@linaro.org>, Mike Leach <mike.leach@linaro.org>, 
	Leo Yan <leo.yan@linux.dev>, guoren <guoren@kernel.org>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Charlie Jenkins <charlie@rivosinc.com>, 
	Bibo Mao <maobibo@loongson.cn>, Huacai Chen <chenhuacai@kernel.org>, 
	Catalin Marinas <catalin.marinas@arm.com>, Jiri Slaby <jirislaby@kernel.org>, 
	=?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@rivosinc.com>, 
	Howard Chu <howardchu95@gmail.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	"linux-csky@vger.kernel.org" <linux-csky@vger.kernel.org>, linux-riscv@lists.infradead.org, 
	Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 15, 2025 at 4:02=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> On Fri, Mar 14, 2025 at 05:48:12PM -0300, Arnaldo Carvalho de Melo wrote:
> > On Fri, Mar 14, 2025 at 02:26:41PM -0300, Arnaldo Carvalho de Melo wrot=
e:
> > > it finds the pair, but then its sc->args has a bogus pointer... I'll =
see
> > > where this isn't being initialized...
> >
> > Breakpoint 4, trace__find_usable_bpf_prog_entry (trace=3D0x7fffffffa510=
, sc=3D0x1046f10) at builtin-trace.c:3874
> > 3874                  bool is_candidate =3D false;
> > (gdb) n
> > 3876                  if (pair =3D=3D NULL || pair =3D=3D sc ||
> > (gdb) p pair
> > $7 =3D (struct syscall *) 0x1083c50
> > (gdb) p pair->name
> > $8 =3D 0x81478e "accept4"
> > (gdb) n
> > 3877                      pair->bpf_prog.sys_enter =3D=3D trace->skel->=
progs.syscall_unaugmented)
> > (gdb) p i
> > $9 =3D 1
> > (gdb) n
> > 3876                  if (pair =3D=3D NULL || pair =3D=3D sc ||
> > (gdb) n
> > 3880                  printf("sc=3D%p\n", sc); fflush(stdout);
> > (gdb) n
> > sc=3D0x1046f10
> > 3881                  printf("sc->name=3D%p\n", sc->name); fflush(stdou=
t);
> > (gdb) n
> > sc->name=3D0x6c66202c786c3830
> > 3882                  printf("sc->nr_args=3D%d, sc->args=3D%p\n", sc->n=
r_args, sc->args); fflush(stdout);
> > (gdb) p sc->nr_args
> > $10 =3D 1935635045
> > (gdb) p sc->args
> > $11 =3D (struct tep_format_field *) 0x257830203a6e656c
> > (gdb) p *sc
> > $12 =3D {e_machine =3D 540697702, id =3D 807761968, tp_format =3D 0x657=
075202c786c38, nr_args =3D 1935635045, args_size =3D 1634427759, bpf_prog =
=3D {sys_enter =3D 0x257830203a726464,
> >     sys_exit =3D 0x7075202c786c3830}, is_exit =3D 101, is_open =3D 101,=
 nonexistent =3D 114, use_btf =3D 95, args =3D 0x257830203a6e656c,
> >   name =3D 0x6c66202c786c3830 <error: Cannot access memory at address 0=
x6c66202c786c3830>, fmt =3D 0x257830203a736761, arg_fmt =3D 0x786c3830}
> > (gdb)
> >
> > Ok, ran out of time, but if I simple avoid the second loop in:
> >
> > static int trace__init_syscalls_bpf_prog_array_maps(struct trace *trace=
, int e_machine)
> >
> >
> > I.e. the one that starts with:
> >
> >         /*
> >          * Now lets do a second pass looking for enabled syscalls witho=
ut
> >          * an augmenter that have a signature that is a superset of ano=
ther
> >          * syscall with an augmenter so that we can auto-reuse it.
> >
> > This:
> >
> > diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
> > index e0434f7dc67cb988..3664bb512c70cabf 100644
> > --- a/tools/perf/builtin-trace.c
> > +++ b/tools/perf/builtin-trace.c
> > @@ -3989,6 +3989,8 @@ static int trace__init_syscalls_bpf_prog_array_ma=
ps(struct trace *trace, int e_m
> >                         goto out;
> >         }
> >
> > +       return 0;
> > +
> >         /*
> >          * Now lets do a second pass looking for enabled syscalls witho=
ut
> >          * an augmenter that have a signature that is a superset of ano=
ther
> > =E2=AC=A2 [acme@toolbox perf-tools-next]$
> >
> >
> > Then all works, we don't reuse any BPF program, but then that is an
> > heuristic anyway, that is tried becuase landlock_add_rule has a pointer
> > argument:
> >
> > root@number:~# perf trace -e landlock_add_rule perf test -w landlock
> >      0.000 ( 0.003 ms): perf/71034 landlock_add_rule(ruleset_fd: 11, ru=
le_type: LANDLOCK_RULE_PATH_BENEATH, rule_attr: 0x7fff6f2bb550, flags: 45) =
=3D -1 EINVAL (Invalid argument)
> >      0.004 ( 0.001 ms): perf/71034 landlock_add_rule(ruleset_fd: 11, ru=
le_type: LANDLOCK_RULE_NET_PORT, rule_attr: 0x7fff6f2bb540, flags: 45) =3D =
-1 EINVAL (Invalid argument)
> > root@number:~# perf test enum
> > 105: perf trace enum augmentation tests                              : =
Ok
> > root@number:~#
> >
> > So its some sort of syncronization on the various new tables, sorted by
> > name, etc that then when iterating over the syscalls ends up using a sc
> > that is not initialized.
>
> Right, I've realized that calling trace__syscall_info() can invalidate
> the existing sc since it calls trace__find_syscall() which reallocates
> and resorts the syscall table.  That's why it was ok when no filter was
> used since it'd allocate the whole table in the first pass.  Otherwise
> it looks for a pair syscall while holding the original sc but calling
> the function would invalidate the sc.
>
> What about this (on top of my earlier fix)?

LGTM.
Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> Thanks,
> Namhyung
>
>
> ---8<---
> diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
> index 49199d753b7cafbf..da0ddc713e6b35da 100644
> --- a/tools/perf/builtin-trace.c
> +++ b/tools/perf/builtin-trace.c
> @@ -2506,10 +2506,12 @@ static struct syscall *trace__find_syscall(struct=
 trace *trace, int e_machine, i
>         };
>         struct syscall *sc, *tmp;
>
> -       sc =3D bsearch(&key, trace->syscalls.table, trace->syscalls.table=
_size,
> -                    sizeof(struct syscall), syscall__cmp);
> -       if (sc)
> -               return sc;
> +       if (trace->syscalls.table) {
> +               sc =3D bsearch(&key, trace->syscalls.table, trace->syscal=
ls.table_size,
> +                            sizeof(struct syscall), syscall__cmp);
> +               if (sc)
> +                       return sc;
> +       }
>
>         tmp =3D reallocarray(trace->syscalls.table, trace->syscalls.table=
_size + 1,
>                            sizeof(struct syscall));
> @@ -3855,6 +3857,10 @@ static int trace__bpf_sys_enter_beauty_map(struct =
trace *trace, int e_machine, i
>
>  static struct bpf_program *trace__find_usable_bpf_prog_entry(struct trac=
e *trace, struct syscall *sc)
>  {
> +       int orig_id =3D sc->id;
> +       const char *orig_name =3D sc->name;
> +       int e_machine =3D sc->e_machine;
> +       struct tep_format_field *args =3D sc->args;
>         struct tep_format_field *field, *candidate_field;
>         /*
>          * We're only interested in syscalls that have a pointer:
> @@ -3866,18 +3872,19 @@ static struct bpf_program *trace__find_usable_bpf=
_prog_entry(struct trace *trace
>
>         return NULL;
>
> +       /* calling trace__syscall_info() may invalidate 'sc' */
>  try_to_find_pair:
> -       for (int i =3D 0, num_idx =3D syscalltbl__num_idx(sc->e_machine);=
 i < num_idx; ++i) {
> -               int id =3D syscalltbl__id_at_idx(sc->e_machine, i);
> -               struct syscall *pair =3D trace__syscall_info(trace, NULL,=
 sc->e_machine, id);
> +       for (int i =3D 0, num_idx =3D syscalltbl__num_idx(e_machine); i <=
 num_idx; ++i) {
> +               int id =3D syscalltbl__id_at_idx(e_machine, i);
> +               struct syscall *pair =3D trace__syscall_info(trace, NULL,=
 e_machine, id);
>                 struct bpf_program *pair_prog;
>                 bool is_candidate =3D false;
>
> -               if (pair =3D=3D NULL || pair =3D=3D sc ||
> +               if (pair =3D=3D NULL || pair->id =3D=3D orig_id ||
>                     pair->bpf_prog.sys_enter =3D=3D trace->skel->progs.sy=
scall_unaugmented)
>                         continue;
>
> -               for (field =3D sc->args, candidate_field =3D pair->args;
> +               for (field =3D args, candidate_field =3D pair->args;
>                      field && candidate_field; field =3D field->next, can=
didate_field =3D candidate_field->next) {
>                         bool is_pointer =3D field->flags & TEP_FIELD_IS_P=
OINTER,
>                              candidate_is_pointer =3D candidate_field->fl=
ags & TEP_FIELD_IS_POINTER;
> @@ -3944,7 +3951,7 @@ static struct bpf_program *trace__find_usable_bpf_p=
rog_entry(struct trace *trace
>                                 goto next_candidate;
>                 }
>
> -               pr_debug("Reusing \"%s\" BPF sys_enter augmenter for \"%s=
\"\n", pair->name, sc->name);
> +               pr_debug("Reusing \"%s\" BPF sys_enter augmenter for \"%s=
\"\n", pair->name, orig_name);
>                 return pair_prog;
>         next_candidate:
>                 continue;
> @@ -4041,6 +4048,11 @@ static int trace__init_syscalls_bpf_prog_array_map=
s(struct trace *trace, int e_m
>                 if (pair_prog =3D=3D NULL)
>                         continue;
>
> +               /*
> +                * Get syscall info again as find usable entry above migh=
t
> +                * modify the syscall table and shuffle it.
> +                */
> +               sc =3D trace__syscall_info(trace, NULL, e_machine, key);
>                 sc->bpf_prog.sys_enter =3D pair_prog;
>
>                 /*
>
