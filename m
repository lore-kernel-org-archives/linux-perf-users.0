Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 684FF2D6603
	for <linux-perf-users@vger.kernel.org>; Mon,  6 Oct 2025 15:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759764088; cv=none; b=hXn8Uz0AFTgoVR+PsLv9FBAQkFnYmFp2HyVXJj/bmNo0e2KnRMbPwsGwN896HnVkOnxlRI7OisBAbUOYir77N8qLxUVNc1M69TgO3T7zkGLSiMpASa9QK5kIznUjiUifw+JETZXDcc9rpcacunFfLl2WJlAGM4+LfvGM5+Fcxec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759764088; c=relaxed/simple;
	bh=fjnK539nhbQtIdFll+MD3J66xdOX9Swt70lV6K9PvnM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FqP7QcGYL08SP8w4EYxKgRHycpgLpDIn1QA2q+V5X7k4en3XNZrCg1v+IOQl0pJVMtBOuAodohlknVH6uCmEzkJP3S4HDhj3Zrl33KkMOkE+hBdyGTrij+lhrHPXkeGUfLU9oXCHQLHFSuoo67EH4Sx/6eU3DXaKrt8iudl5o54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UvYr8vyU; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UvYr8vyU"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2681645b7b6so347795ad.1
        for <linux-perf-users@vger.kernel.org>; Mon, 06 Oct 2025 08:21:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759764085; x=1760368885; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0TU94yC/iz9s2FtFdfZcTbm43wg3U+E+MwSkj5QqNCc=;
        b=UvYr8vyUwKhU4RW1guFOJzpsEbPETu6CwsPgm+xMt4SiAD3XC3zT55fg9hjIqBMm+9
         uSrVvD6k04clBl7XUoSiikkHGPmATV2OiyET0rJoIbBcCjgCERY7zVMPP8mXCG1w1Ywt
         tJYC7FKGt0QxLSXSNsPotu9ekSJtV/k+3TYEL58NOOiMCskzcbMN01c1gnps+EjbLqFP
         MaGg42XVfULM3k9/ND7C4tW33MxVBYczh/+GPAcI6StZsmXvveDn9MeFVZC9twjwqe6J
         xP1mgZ0SB36HrdlQdcWC2uiQ83XeXsdPxSS7K7gGn9OC3jp5/4wenW2hyWB7hLeCBVWM
         af8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759764085; x=1760368885;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0TU94yC/iz9s2FtFdfZcTbm43wg3U+E+MwSkj5QqNCc=;
        b=ouOf/vVmwAD2xu2KUc9zExvjezXcjkAf245vfQy32NNslmf1Urwh0rVjANh+oSNLcC
         54GfWXeccFg4xcG2OgIf4HdixyiNa+XXFQ95TDmRYAaZOXydQbiuMi+L6GD+kevNjhz8
         snum/Oo/O2Vu9zPXZp75hasIhbtsNOUlTNihVyNK/oRuTBJw9eMImz5cnTun7//JSEx/
         kLm4JJiRvc35qeCtur2rs5FVrhuWccq0P/fsnliidOGoFlkdl5h3y0iLCEJ9kvzq6l5S
         zTf4TwJw92Be9JMgKi1z0Iz30Hcli1wc3zCV7zCuRFudhbpRwaPXEjq1ffKfSZPDOYMc
         uMPw==
X-Forwarded-Encrypted: i=1; AJvYcCV7W20zB494Ot67vqbJ+eg7BCWuGRoawkJu7atSQO+HJFNdlAtPETJuyAFPiJ0XTXdo0OLqozsqIRx730BdPQn0@vger.kernel.org
X-Gm-Message-State: AOJu0Yzzxn5M9J+nUBrSX1mf8g6j0Fzvs+bCHEOJ3HEETjZGgfIJGOVx
	Dcj4LPBhwOPEoe9Q2ANwYNLzQAZyiqGKEQhjKVAMLfzdUJU3LWueEJ+/yfFQWfyEhmqQv4Ficwh
	h+lZ0agYKM3p2rmFmdW6szIz59rHyzTCM/eHe/f67
X-Gm-Gg: ASbGncvKyvQwMB96Y7J5dU76VsPDCjv9JTKqcRMazpbdOfBdPqJ6e7/1huGBGfAxNPO
	XX9xyLdvwDH69y/PTFjVvb6nWentBXmjZ1cw3MKz8jRnUn5/c6Hi24paD8SjZT4xx3pADtneHtS
	Z9dARuNTLxeFl6btht7DPuQnxpk4WRCJ6T7YQGHu+qib15RQeqJ0UHo+57LwMPF0CBWrUfLgtiI
	pVvoHmxpL8OWpORHyY0fIQP12KD5tNnzmdcMsg61+eGuIALtKcCoxsdsQjAJFGldXIu
X-Google-Smtp-Source: AGHT+IEyLODxqjSS1fgWC9V7jHJADOR9mg9X0nAIuhh0M9oQcZGVVcIJtFaOrEKeAAEIM29mxXCwCNTyQartiZI+SHk=
X-Received: by 2002:a17:903:3d07:b0:274:1a09:9553 with SMTP id
 d9443c01a7336-28ea7f48440mr6603945ad.6.1759764084097; Mon, 06 Oct 2025
 08:21:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251006-james-perf-object-code-reading-v1-1-acab2129747d@linaro.org>
In-Reply-To: <20251006-james-perf-object-code-reading-v1-1-acab2129747d@linaro.org>
From: Ian Rogers <irogers@google.com>
Date: Mon, 6 Oct 2025 08:21:12 -0700
X-Gm-Features: AS18NWCxuOdUcxiDEtBrDRvzzAotgdJp6vfM4rbKugKhWKfMAuJhp8NP7i-p9nA
Message-ID: <CAP-5=fXmAbz7Gp5eCRFYsYu_pZoFNSR+mcJgE6Eu6YewHyLNtg@mail.gmail.com>
Subject: Re: [PATCH] perf tests: Don't retest sections in "Object code reading"
To: James Clark <james.clark@linaro.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Leo Yan <leo.yan@arm.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 6, 2025 at 6:11=E2=80=AFAM James Clark <james.clark@linaro.org>=
 wrote:
>
> We already only test each kcore map once, but on slow systems
> (particularly with network filesystems) even the non-kcore maps are
> slow. The test can test the same objump output over and over which only
> wastes time. Generalize the skipping mechanism to track all DSOs and
> addresses so that each section is only tested once.
>
> On a fully loaded Arm Juno (simulating a parallel Perf test run) with a
> network filesystem, the original runtime is:
>
>   real  1m51.126s
>   user  0m19.445s
>   sys   1m15.431s
>
> And the new runtime is:
>
>   real  0m48.873s
>   user  0m8.031s
>   sys   0m32.353s
>
> Signed-off-by: James Clark <james.clark@linaro.org>

Reviewed-by: Ian Rogers <irogers@google.com>

> ---
>  tools/perf/tests/code-reading.c | 119 ++++++++++++++++++++++++++++------=
------
>  1 file changed, 85 insertions(+), 34 deletions(-)
>
> diff --git a/tools/perf/tests/code-reading.c b/tools/perf/tests/code-read=
ing.c
> index 9c2091310191..4c9fbf6965c4 100644
> --- a/tools/perf/tests/code-reading.c
> +++ b/tools/perf/tests/code-reading.c
> @@ -2,6 +2,7 @@
>  #include <errno.h>
>  #include <linux/kconfig.h>
>  #include <linux/kernel.h>
> +#include <linux/rbtree.h>
>  #include <linux/types.h>
>  #include <inttypes.h>
>  #include <stdlib.h>
> @@ -39,11 +40,64 @@
>  #define BUFSZ  1024
>  #define READLEN        128
>
> -struct state {
> -       u64 done[1024];
> -       size_t done_cnt;
> +struct tested_section {
> +       struct rb_node rb_node;
> +       u64 addr;
> +       char path[PATH_MAX];
>  };
>
> +static bool tested_code_insert_or_exists(const char *path, u64 addr,
> +                                        struct rb_root *tested_sections)
> +{
> +       struct rb_node **node =3D &tested_sections->rb_node;
> +       struct rb_node *parent =3D NULL;
> +       struct tested_section *data;
> +
> +       while (*node) {
> +               int cmp;
> +
> +               parent =3D *node;
> +               data =3D rb_entry(*node, struct tested_section, rb_node);
> +               cmp =3D strcmp(path, data->path);
> +               if (!cmp) {
> +                       if (addr < data->addr)
> +                               cmp =3D -1;
> +                       else if (addr > data->addr)
> +                               cmp =3D 1;
> +                       else
> +                               return true; /* already tested */
> +               }
> +
> +               if (cmp < 0)
> +                       node =3D &(*node)->rb_left;
> +               else
> +                       node =3D &(*node)->rb_right;
> +       }
> +
> +       data =3D zalloc(sizeof(*data));
> +       if (!data)
> +               return true;
> +
> +       data->addr =3D addr;
> +       strlcpy(data->path, path, sizeof(data->path));

nit: perhaps strdup rather than having 4kb per tested_section.

Thanks,
Ian

> +       rb_link_node(&data->rb_node, parent, node);
> +       rb_insert_color(&data->rb_node, tested_sections);
> +       return false;
> +}
> +
> +static void tested_sections__free(struct rb_root *root)
> +{
> +       while (!RB_EMPTY_ROOT(root)) {
> +               struct rb_node *node =3D rb_first(root);
> +               struct tested_section *ts =3D rb_entry(node,
> +                                                    struct tested_sectio=
n,
> +                                                    rb_node);
> +
> +               rb_erase(node, root);
> +               free(ts);
> +       }
> +}
> +
>  static size_t read_objdump_chunk(const char **line, unsigned char **buf,
>                                  size_t *buf_len)
>  {
> @@ -316,13 +370,15 @@ static void dump_buf(unsigned char *buf, size_t len=
)
>  }
>
>  static int read_object_code(u64 addr, size_t len, u8 cpumode,
> -                           struct thread *thread, struct state *state)
> +                           struct thread *thread,
> +                           struct rb_root *tested_sections)
>  {
>         struct addr_location al;
>         unsigned char buf1[BUFSZ] =3D {0};
>         unsigned char buf2[BUFSZ] =3D {0};
>         size_t ret_len;
>         u64 objdump_addr;
> +       u64 skip_addr;
>         const char *objdump_name;
>         char decomp_name[KMOD_DECOMP_LEN];
>         bool decomp =3D false;
> @@ -350,6 +406,18 @@ static int read_object_code(u64 addr, size_t len, u8=
 cpumode,
>                 goto out;
>         }
>
> +       /*
> +        * Don't retest the same addresses. objdump struggles with kcore =
- try
> +        * each map only once even if the address is different.
> +        */
> +       skip_addr =3D dso__is_kcore(dso) ? map__start(al.map) : al.addr;
> +       if (tested_code_insert_or_exists(dso__long_name(dso), skip_addr,
> +                                        tested_sections)) {
> +               pr_debug("Already tested %s @ %#"PRIx64" - skipping\n",
> +                        dso__long_name(dso), skip_addr);
> +               goto out;
> +       }
> +
>         pr_debug("On file address is: %#"PRIx64"\n", al.addr);
>
>         if (len > BUFSZ)
> @@ -387,24 +455,6 @@ static int read_object_code(u64 addr, size_t len, u8=
 cpumode,
>                 goto out;
>         }
>
> -       /* objdump struggles with kcore - try each map only once */
> -       if (dso__is_kcore(dso)) {
> -               size_t d;
> -
> -               for (d =3D 0; d < state->done_cnt; d++) {
> -                       if (state->done[d] =3D=3D map__start(al.map)) {
> -                               pr_debug("kcore map tested already");
> -                               pr_debug(" - skipping\n");
> -                               goto out;
> -                       }
> -               }
> -               if (state->done_cnt >=3D ARRAY_SIZE(state->done)) {
> -                       pr_debug("Too many kcore maps - skipping\n");
> -                       goto out;
> -               }
> -               state->done[state->done_cnt++] =3D map__start(al.map);
> -       }
> -
>         objdump_name =3D dso__long_name(dso);
>         if (dso__needs_decompress(dso)) {
>                 if (dso__decompress_kmodule_path(dso, objdump_name,
> @@ -471,9 +521,9 @@ static int read_object_code(u64 addr, size_t len, u8 =
cpumode,
>         return err;
>  }
>
> -static int process_sample_event(struct machine *machine,
> -                               struct evlist *evlist,
> -                               union perf_event *event, struct state *st=
ate)
> +static int process_sample_event(struct machine *machine, struct evlist *=
evlist,
> +                               union perf_event *event,
> +                               struct rb_root *tested_sections)
>  {
>         struct perf_sample sample;
>         struct thread *thread;
> @@ -494,7 +544,8 @@ static int process_sample_event(struct machine *machi=
ne,
>                 goto out;
>         }
>
> -       ret =3D read_object_code(sample.ip, READLEN, sample.cpumode, thre=
ad, state);
> +       ret =3D read_object_code(sample.ip, READLEN, sample.cpumode, thre=
ad,
> +                              tested_sections);
>         thread__put(thread);
>  out:
>         perf_sample__exit(&sample);
> @@ -502,10 +553,11 @@ static int process_sample_event(struct machine *mac=
hine,
>  }
>
>  static int process_event(struct machine *machine, struct evlist *evlist,
> -                        union perf_event *event, struct state *state)
> +                        union perf_event *event, struct rb_root *tested_=
sections)
>  {
>         if (event->header.type =3D=3D PERF_RECORD_SAMPLE)
> -               return process_sample_event(machine, evlist, event, state=
);
> +               return process_sample_event(machine, evlist, event,
> +                                           tested_sections);
>
>         if (event->header.type =3D=3D PERF_RECORD_THROTTLE ||
>             event->header.type =3D=3D PERF_RECORD_UNTHROTTLE)
> @@ -525,7 +577,7 @@ static int process_event(struct machine *machine, str=
uct evlist *evlist,
>  }
>
>  static int process_events(struct machine *machine, struct evlist *evlist=
,
> -                         struct state *state)
> +                         struct rb_root *tested_sections)
>  {
>         union perf_event *event;
>         struct mmap *md;
> @@ -537,7 +589,7 @@ static int process_events(struct machine *machine, st=
ruct evlist *evlist,
>                         continue;
>
>                 while ((event =3D perf_mmap__read_event(&md->core)) !=3D =
NULL) {
> -                       ret =3D process_event(machine, evlist, event, sta=
te);
> +                       ret =3D process_event(machine, evlist, event, tes=
ted_sections);
>                         perf_mmap__consume(&md->core);
>                         if (ret < 0)
>                                 return ret;
> @@ -637,9 +689,7 @@ static int do_test_code_reading(bool try_kcore)
>                         .uses_mmap   =3D true,
>                 },
>         };
> -       struct state state =3D {
> -               .done_cnt =3D 0,
> -       };
> +       struct rb_root tested_sections =3D RB_ROOT;
>         struct perf_thread_map *threads =3D NULL;
>         struct perf_cpu_map *cpus =3D NULL;
>         struct evlist *evlist =3D NULL;
> @@ -773,7 +823,7 @@ static int do_test_code_reading(bool try_kcore)
>
>         evlist__disable(evlist);
>
> -       ret =3D process_events(machine, evlist, &state);
> +       ret =3D process_events(machine, evlist, &tested_sections);
>         if (ret < 0)
>                 goto out_put;
>
> @@ -793,6 +843,7 @@ static int do_test_code_reading(bool try_kcore)
>         perf_thread_map__put(threads);
>         machine__delete(machine);
>         perf_env__exit(&host_env);
> +       tested_sections__free(&tested_sections);
>
>         return err;
>  }
>
> ---
> base-commit: a22d167ed82505f770340c3a7c257c04ba24dac9
> change-id: 20251006-james-perf-object-code-reading-9646e486d595
>
> Best regards,
> --
> James Clark <james.clark@linaro.org>
>
