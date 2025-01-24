Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 246F814A0B9;
	Fri, 24 Jan 2025 18:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737742418; cv=none; b=TofLkhY6iAy1T1zJJc5ZN/41/Rvww9+vAD4Hn/OPVZtz8X1t4CysDaic4GtFMwfhg7LyEcr5KY+FT7oVOAeepLffrN1HjvRjGllyXPsdwJeBP6eJjx5JJ2pl66l9euN5d+Ys0y3T2NhvEFEQeuWJ96HhlOzMqOifjZCaZ7WObLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737742418; c=relaxed/simple;
	bh=9DDAbzemyokZtvtBR/aZ/TelmEwfwdOpqkowRqbqoEU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=j57ozrTQzElW7/vDS0lOrIQ/vjscE/UNO3onztXhANr6gqLwXsSpi/YfvVo79ai8SJWvQaZjqyHNUJe7641ZzJZgQxsj4ehtnjFHaqNlxQtwW4ct2FXz4GbYRBtNGQF+kroaa1DiBzrsJjHRyMFGSVdF5n6YaLt/FKSnc57uV6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z1qdlUFH; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z1qdlUFH"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-2ee8aa26415so4342648a91.1;
        Fri, 24 Jan 2025 10:13:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737742416; x=1738347216; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vU0nYVzOS0l3QSwC0o+YcUhcm47zcCdg4i0PBNOq6sU=;
        b=Z1qdlUFHX5Vg0SmKgV9NnqRhNANnpBdmI0PTHsmcLzur4ZnC2HsTwZSChw3PQ90F1l
         iIinnKxleU8xU+LdMbzTOObPiyJZE1haF+vpFZFIBuFDG3Z9sgxThuiKBjI0wQZeIDqU
         +sEQtVhOABTvUN/1xf7SyNsjOy8pImkqC6o2OmdM2NgQDS/Gw7KxrlZD2b2ZOvrKL+nf
         /xUoZbMl8tAjAab8bq7/fSGHD6Zaz0FF7Nuse7FD5DkqnDQDXjbUamiAllLtl9WprtpY
         RYtWqQDzCs+5uAAx/uR6ZfVnHXCitBPGcVxO5TyBNH6Iehn4Zdj97yBn8kQN4CQ7brY2
         aQIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737742416; x=1738347216;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vU0nYVzOS0l3QSwC0o+YcUhcm47zcCdg4i0PBNOq6sU=;
        b=JW9xWxf+FU5G8hYei/eK2o1cfkEJeidqtjoZYaskFCxjstXpE+GEGs759RXaKgrfzi
         bajSKW3PvKH1VZpazezxLmGwaFd7ISKw980zmKQXM4TTZ0ybTLaaaH/wDuvh2/+s7VVz
         lb74Q5zuHx86b4pVRRR4e7vEtDJ7cvqu2IYM1wH1cVfriVj9NpsBNSKZr/MVMg7r7HYZ
         0dKgMVZy4TZRcsLeFtyjTjP1zRUtbGTOHZ2LlH/YcPKvfeV/zJBHg4vgFIArRWke5STK
         i09CzOj7jjbEyklat0SXAFKSZkshqu2hk0MPWtUdGU+nrWRvjWS4/OMRAC9bb2P5LBWC
         W8nQ==
X-Forwarded-Encrypted: i=1; AJvYcCV7jFs9blZRjqje190KaC3sB0k1eMc+5uGYQMwwZYRsFCL1Ku0Ldgtm763SYZyX4ZagaKnEigwT9escpDHbByGyRA==@vger.kernel.org, AJvYcCVAdZ0UeJA0P/vT60KAwzQr7BmeSiLLCBYQWcd9RUaKq7OHASCcXRzXI+xJ2XTZlXhydRPEDQ1gSomf+fi/97Y9xg==@vger.kernel.org, AJvYcCVeqsCv7X4FeWlWRdo27PTtS2JbulOeuU5zWsIDX2P4XZwC8d1rWNAJSZdwh+j0rGAaMEIT4pAcE62lbmg=@vger.kernel.org, AJvYcCXJBgIfU12tjR9jUE1A/jwtcwAHxDTFKup4Blr5QOyidrTtYHUMgvibKnsmhmiE1tylIzeg2Dayu1oDyZK9RdEg8ns6@vger.kernel.org
X-Gm-Message-State: AOJu0YyBfCBSyYkFPdiOH0sUt4nr38wyncscU9v6X3PFXKpiBzgnlwoC
	ByVTjO3ISFOl5P9ntx+zxfa6T/RCpepRjKCZwiOtl5woR+DX5somrnABIGA4ZqDnoCHtmCyQkrQ
	gf25AaaJh5rrew1OXeweMvlskGzU=
X-Gm-Gg: ASbGncv5cOuiVKdajb4DVXYA9mppOI/u+XwFjRajCiVd1afpOcik5gMdW2RdxXcu2BN
	/9O04qDrsOwRIWH7XJl7HZtyOtXrZAElUbVEzY4J0d4zZoihnv2q8b5jED0FKvW2M4lzYcacVfT
	6+fQ==
X-Google-Smtp-Source: AGHT+IHRQq5nVZ5DUG8wSGjoOCcN+iRttC22B4vxBj7GsGpIr7Q2ucBBb0XqLOOahLlh/k3NAtIno3HVrauBu59mvdw=
X-Received: by 2002:a05:6a00:180c:b0:725:e309:7110 with SMTP id
 d2e1a72fcca58-72daf9a53acmr41396671b3a.5.1737742416349; Fri, 24 Jan 2025
 10:13:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1737511963.git.jpoimboe@kernel.org> <73229250c0279667f617c3d6da121c6621164e4d.1737511963.git.jpoimboe@kernel.org>
In-Reply-To: <73229250c0279667f617c3d6da121c6621164e4d.1737511963.git.jpoimboe@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 24 Jan 2025 10:13:23 -0800
X-Gm-Features: AWEUYZk-oeAmrdrreOw_e-A5uiLFrAlQajpLUIR0ULrCYXnRv63Gqajgu0bakqQ
Message-ID: <CAEf4BzYLqmhb11F8X96Ac03YErf2WrHq8D5EA_f-488ij9-jnw@mail.gmail.com>
Subject: Re: [PATCH v4 32/39] perf: Remove get_perf_callchain() 'crosstask' argument
To: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: x86@kernel.org, Peter Zijlstra <peterz@infradead.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Ingo Molnar <mingo@kernel.org>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, linux-kernel@vger.kernel.org, 
	Indu Bhagat <indu.bhagat@oracle.com>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, linux-perf-users@vger.kernel.org, 
	Mark Brown <broonie@kernel.org>, linux-toolchains@vger.kernel.org, 
	Jordan Rome <jordalgo@meta.com>, Sam James <sam@gentoo.org>, linux-trace-kernel@vger.kernel.org, 
	Jens Remus <jremus@linux.ibm.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Florian Weimer <fweimer@redhat.com>, Andy Lutomirski <luto@kernel.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Weinan Liu <wnliu@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 21, 2025 at 6:32=E2=80=AFPM Josh Poimboeuf <jpoimboe@kernel.org=
> wrote:
>
> get_perf_callchain() doesn't support cross-task unwinding, so it doesn't
> make much sense to have 'crosstask' as an argument.
>
> Acked-by: Namhyung Kim <namhyung@kernel.org>
> Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
> ---
>  include/linux/perf_event.h |  2 +-
>  kernel/bpf/stackmap.c      | 12 ++++--------
>  kernel/events/callchain.c  |  6 +-----
>  kernel/events/core.c       |  9 +++++----
>  4 files changed, 11 insertions(+), 18 deletions(-)
>
> diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
> index 4c8ff7258c6a..1563dc2cd979 100644
> --- a/include/linux/perf_event.h
> +++ b/include/linux/perf_event.h
> @@ -1590,7 +1590,7 @@ extern void perf_callchain_user(struct perf_callcha=
in_entry_ctx *entry, struct p
>  extern void perf_callchain_kernel(struct perf_callchain_entry_ctx *entry=
, struct pt_regs *regs);
>  extern struct perf_callchain_entry *
>  get_perf_callchain(struct pt_regs *regs, bool kernel, bool user,
> -                  u32 max_stack, bool crosstask, bool add_mark);
> +                  u32 max_stack, bool add_mark);
>  extern int get_callchain_buffers(int max_stack);
>  extern void put_callchain_buffers(void);
>  extern struct perf_callchain_entry *get_callchain_entry(int *rctx);
> diff --git a/kernel/bpf/stackmap.c b/kernel/bpf/stackmap.c
> index ec3a57a5fba1..ee9701337912 100644
> --- a/kernel/bpf/stackmap.c
> +++ b/kernel/bpf/stackmap.c
> @@ -314,8 +314,7 @@ BPF_CALL_3(bpf_get_stackid, struct pt_regs *, regs, s=
truct bpf_map *, map,
>         if (max_depth > sysctl_perf_event_max_stack)
>                 max_depth =3D sysctl_perf_event_max_stack;
>
> -       trace =3D get_perf_callchain(regs, kernel, user, max_depth,
> -                                  false, false);
> +       trace =3D get_perf_callchain(regs, kernel, user, max_depth, false=
);
>
>         if (unlikely(!trace))
>                 /* couldn't fetch the stack trace */
> @@ -430,10 +429,8 @@ static long __bpf_get_stack(struct pt_regs *regs, st=
ruct task_struct *task,
>         if (task && user && !user_mode(regs))
>                 goto err_fault;
>
> -       /* get_perf_callchain does not support crosstask user stack walki=
ng
> -        * but returns an empty stack instead of NULL.
> -        */
> -       if (crosstask && user) {
> +       /* get_perf_callchain() does not support crosstask stack walking =
*/
> +       if (crosstask) {

crosstask stack trace is supported for kernel stack traces (see
get_callchain_entry_for_task() call), so this is breaking that case

>                 err =3D -EOPNOTSUPP;
>                 goto clear;
>         }
> @@ -451,8 +448,7 @@ static long __bpf_get_stack(struct pt_regs *regs, str=
uct task_struct *task,
>         else if (kernel && task)
>                 trace =3D get_callchain_entry_for_task(task, max_depth);
>         else
> -               trace =3D get_perf_callchain(regs, kernel, user, max_dept=
h,
> -                                          crosstask, false);
> +               trace =3D get_perf_callchain(regs, kernel, user, max_dept=
h,false);

nit: missing space

>
>         if (unlikely(!trace) || trace->nr < skip) {
>                 if (may_fault)
> diff --git a/kernel/events/callchain.c b/kernel/events/callchain.c
> index 83834203e144..655fb25a725b 100644
> --- a/kernel/events/callchain.c
> +++ b/kernel/events/callchain.c

[...]
