Received: from mail-il1-f181.google.com (mail-il1-f181.google.com [209.85.166.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB94F208D9F
	for <linux-perf-users@vger.kernel.org>; Wed, 16 Oct 2024 19:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729106884; cv=none; b=qeTjNfytXfjUbmIqxs/xDBQEki5N3V2BU1zBIbKlswVMlIRgzZRaAbItxygqhOkVP1KGflQzTVIuV7yWNMc+iUhWEIQ4zeJENK5H/rw78n98OMIwB1He9wZiBicXDfMx8A+FIj7KufueP1+TmqyLx/NtPNAlrd5L2hicrEmdnZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729106884; c=relaxed/simple;
	bh=kgnqpdKkc/l7Qu2ygVy3RP3nHEyLe2cZrbhYsgl6YD4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=G/tpN4S971XbMAF+XW3QE2Pw8EkAxQKXmWUyphN8P30QCnzWOoHc7aWDb/4YW4+p+4F43B8kt5wbDQCRTQjBHdlJRUggyoL5R27XnbpfOOvFMJUcCnEh93EWwB6U2rHyI/U9qcmwBVvMBNp1c0LW0DOTVeka2u9YFu56hd92Kfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BgDxISaN; arc=none smtp.client-ip=209.85.166.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BgDxISaN"
Received: by mail-il1-f181.google.com with SMTP id e9e14a558f8ab-3a3b3f4b2afso42435ab.0
        for <linux-perf-users@vger.kernel.org>; Wed, 16 Oct 2024 12:28:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729106882; x=1729711682; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d0xFVkJStAPxCfaCemrTY4BomoxBEHGl8j5YbuyJ6Tc=;
        b=BgDxISaNRG4qhuw3ExwHy4gfhDoepcy9PxHUwTnQbS0hQ9xOmR41W5dy7VIUGOSqcC
         ZnhFbcveHo0sYM3w9gosJ39kz/NSJDyeaagPxkWkX4Nqf21e07DBiu2d7EtGnHumRW7n
         fb+MwL/HsHQTgSkw9oLYtWWpZhyvn4CabBwpXT+xLrAmHrRP+QtWJxHle59L6lR35uaz
         hqtPk5lI6xJEqiuvO5pVTJBG0BTZnK3LguAihdjvJrGTLAGRmyNmwv8Ngin2M4Myhmtc
         yM78LngqWeu1pNgy0W2v/CQgd4sQgggEcq8mFEKTGg8mcXsQj7OLlfYkDqwj54rUzn66
         mslw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729106882; x=1729711682;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d0xFVkJStAPxCfaCemrTY4BomoxBEHGl8j5YbuyJ6Tc=;
        b=XPCpPtrurW+y6MGznYRFGqlCHNdsq0+XO4dS9jejr+TBDHtuFHwR7+BYL6fybfjKHn
         vLb3R/y1aEqhi19sioI+UjQP3xwXe2MU3Njj7Ie6yDqcAQcHp2DxYgfVR7HFHKDOfv4r
         izTP7YV/FYZBypqvXmfPc10jh/qnnByP/4ODXJ+xybQGuCpNmFK5JdP9OIJLBwUdI/vf
         4+IQcFqvNAUnBzVDt+z8vNi6TN7KIsAf8+nnXicfN7/ZBqzIu9FwpaILYDNfJvBSp+bH
         y9FsHBMz2jLc5i2RjEQkR4UrQRL9doSN6L14dAYqRP74fqHPRXk5kvVR1F4sqSO+M6qA
         Blvg==
X-Forwarded-Encrypted: i=1; AJvYcCWPWmar3UI+fbc1wb5WZCbKSVdBZgAtgi1C3rCb2HVFwjltKcIEMQBNyNu3EVsW1m0jAOWVD5VbaONCI2hkU28J@vger.kernel.org
X-Gm-Message-State: AOJu0YzpBY7j9xURjf5zdpFhbB4+NYVKSo+IQ9wl7U+giZHZTSSGzkTn
	9xTNJu+yv9MwTFYsPoWHX4l44mgFZPGRHuhm93T1vc1Cumz4hQvhfdCKD6M8zqAW+L1l3T3bXBg
	e4+oNcgWsRUQnlBHc9lIXM9jiGDIKh/mNm60o
X-Google-Smtp-Source: AGHT+IG5weUPZ8RB6PaxtT/ZgYfk37msbb5rdpaXmMg2MUFpnJ7Hg14FZtyDabvRZAmUFO68QI7w/w/ShcCtt7VhaUs=
X-Received: by 2002:a05:6e02:1d8a:b0:3a0:be64:a351 with SMTP id
 e9e14a558f8ab-3a3e58ef5d2mr673165ab.10.1729106881679; Wed, 16 Oct 2024
 12:28:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241016190009.866615-1-bgeffon@google.com>
In-Reply-To: <20241016190009.866615-1-bgeffon@google.com>
From: Ian Rogers <irogers@google.com>
Date: Wed, 16 Oct 2024 12:27:50 -0700
Message-ID: <CAP-5=fWy7geJGM-T3XPjbbmdYg4spj4H9s+jE_+aqCSEUJeSFQ@mail.gmail.com>
Subject: Re: [PATCH] perf tools: sched-pipe bench: add (-n) nonblocking benchmark
To: Brian Geffon <bgeffon@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>, 
	Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Steven Rostedt <rostedt@goodmis.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 16, 2024 at 12:00=E2=80=AFPM Brian Geffon <bgeffon@google.com> =
wrote:
>
> The -n mode will benchmark pipes in a non-blocking mode using
> epoll_wait.
>
> This specific mode was added to demonstrate the broken sync nature
> of epoll: https://lore.kernel.org/lkml/20240426-zupfen-jahrzehnt-5be786bc=
df04@brauner
>
> Signed-off-by: Brian Geffon <bgeffon@google.com>

Reviewed-by: Ian Rogers <irogers@google.com>

I liked the commentary in:
https://lore.kernel.org/lkml/ZxAOgj9RWm4NTl9d@google.com/

Thanks,
Ian

> ---
>  tools/perf/bench/sched-pipe.c | 43 +++++++++++++++++++++++++++++------
>  1 file changed, 36 insertions(+), 7 deletions(-)
>
> diff --git a/tools/perf/bench/sched-pipe.c b/tools/perf/bench/sched-pipe.=
c
> index 3af6d3c55aba..e2562677df96 100644
> --- a/tools/perf/bench/sched-pipe.c
> +++ b/tools/perf/bench/sched-pipe.c
> @@ -23,6 +23,7 @@
>  #include <errno.h>
>  #include <fcntl.h>
>  #include <assert.h>
> +#include <sys/epoll.h>
>  #include <sys/time.h>
>  #include <sys/types.h>
>  #include <sys/syscall.h>
> @@ -34,6 +35,8 @@ struct thread_data {
>         int                     nr;
>         int                     pipe_read;
>         int                     pipe_write;
> +       struct epoll_event      epoll_ev;
> +       int                     epoll_fd;
>         bool                    cgroup_failed;
>         pthread_t               pthread;
>  };
> @@ -44,6 +47,7 @@ static        int                     loops =3D LOOPS_D=
EFAULT;
>  /* Use processes by default: */
>  static bool                    threaded;
>
> +static bool                    nonblocking;
>  static char                    *cgrp_names[2];
>  static struct cgroup           *cgrps[2];
>
> @@ -81,6 +85,7 @@ static int parse_two_cgroups(const struct option *opt _=
_maybe_unused,
>  }
>
>  static const struct option options[] =3D {
> +       OPT_BOOLEAN('n', "nonblocking", &nonblocking,   "Use non-blocking=
 operations"),
>         OPT_INTEGER('l', "loop",        &loops,         "Specify number o=
f loops"),
>         OPT_BOOLEAN('T', "threaded",    &threaded,      "Specify threads/=
process based task setup"),
>         OPT_CALLBACK('G', "cgroups", NULL, "SEND,RECV",
> @@ -165,11 +170,25 @@ static void exit_cgroup(int nr)
>         free(cgrp_names[nr]);
>  }
>
> +static inline int read_pipe(struct thread_data *td)
> +{
> +       int ret, m;
> +retry:
> +       if (nonblocking) {
> +               ret =3D epoll_wait(td->epoll_fd, &td->epoll_ev, 1, -1);
> +               if (ret < 0)
> +                       return ret;
> +       }
> +       ret =3D read(td->pipe_read, &m, sizeof(int));
> +       if (nonblocking && ret < 0 && errno =3D=3D EWOULDBLOCK)
> +               goto retry;
> +       return ret;
> +}
> +
>  static void *worker_thread(void *__tdata)
>  {
>         struct thread_data *td =3D __tdata;
> -       int m =3D 0, i;
> -       int ret;
> +       int i, ret, m =3D 0;
>
>         ret =3D enter_cgroup(td->nr);
>         if (ret < 0) {
> @@ -177,16 +196,23 @@ static void *worker_thread(void *__tdata)
>                 return NULL;
>         }
>
> +       if (nonblocking) {
> +               td->epoll_ev.events =3D EPOLLIN;
> +               td->epoll_fd =3D epoll_create(1);
> +               BUG_ON(td->epoll_fd < 0);
> +               BUG_ON(epoll_ctl(td->epoll_fd, EPOLL_CTL_ADD, td->pipe_re=
ad, &td->epoll_ev) < 0);
> +       }
> +
>         for (i =3D 0; i < loops; i++) {
>                 if (!td->nr) {
> -                       ret =3D read(td->pipe_read, &m, sizeof(int));
> +                       ret =3D read_pipe(td);
>                         BUG_ON(ret !=3D sizeof(int));
>                         ret =3D write(td->pipe_write, &m, sizeof(int));
>                         BUG_ON(ret !=3D sizeof(int));
>                 } else {
>                         ret =3D write(td->pipe_write, &m, sizeof(int));
>                         BUG_ON(ret !=3D sizeof(int));
> -                       ret =3D read(td->pipe_read, &m, sizeof(int));
> +                       ret =3D read_pipe(td);
>                         BUG_ON(ret !=3D sizeof(int));
>                 }
>         }
> @@ -209,13 +235,16 @@ int bench_sched_pipe(int argc, const char **argv)
>          * discarding returned value of read(), write()
>          * causes error in building environment for perf
>          */
> -       int __maybe_unused ret, wait_stat;
> +       int __maybe_unused ret, wait_stat, flags =3D 0;
>         pid_t pid, retpid __maybe_unused;
>
>         argc =3D parse_options(argc, argv, options, bench_sched_pipe_usag=
e, 0);
>
> -       BUG_ON(pipe(pipe_1));
> -       BUG_ON(pipe(pipe_2));
> +       if (nonblocking)
> +               flags |=3D O_NONBLOCK;
> +
> +       BUG_ON(pipe2(pipe_1, flags));
> +       BUG_ON(pipe2(pipe_2, flags));
>
>         gettimeofday(&start, NULL);
>
> --
> 2.47.0.rc1.288.g06298d1525-goog
>
>
