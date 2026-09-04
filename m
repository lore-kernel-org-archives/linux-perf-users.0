Received: from mail-qk2-f12.google.com (mail-qk2-f12.google.com [74.125.230.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CEF93DA7CC
	for <linux-perf-users@vger.kernel.org>; Fri,  4 Sep 2026 17:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.230.204
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788543383; cv=pass; b=r+ZAfp4MYpr/kBpITkCcT8C3RiSr+9WMRac7HVjlEljIboi6CwLBLJRSfLgMmZ1OxyOiUfUrU4qPYwo0DiXQv9XPF3OqcacQ+jHa/6bCjOV6GZ3543g9nvMcrZYr+OeR8qTph7mneyNUQaS45nxzN7AAzqukW/7s1QfLhG4GzO0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788543383; c=relaxed/simple;
	bh=kN18nX/SOnR/OYASsq4/LUm0pv6VHY1nlyDuL5HOo2I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ua2UqO2coM08OWq0OMUKkyu+yFe7S+Mv8grOFzwiA3q/JLIL+Le1aNzf4cfvIpQMyRTmdGGBQgunQjvG37PADdzQcBb1nBtftHgDgsf91z6Vir6HYrBJ45e+2IRmpgZLHZfAmGD9y4ZooPLw7k5j4PtXDGNSqy0y4veS6lwkiZc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qICsH5nx; arc=pass smtp.client-ip=74.125.230.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qICsH5nx"
Received: by mail-qk2-f12.google.com with SMTP id d75a77b69052e-52e843c64b8so313851cf.1
        for <linux-perf-users@vger.kernel.org>; Fri, 04 Sep 2026 10:36:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788543380; cv=none;
        d=google.com; s=arc-20260327;
        b=Lh8E1OZWSO7gewDHEhHjejXfHf3j7c9LgXD5nuZPnqejsj3wXVyZz8j/bdx9eP532w
         jyx5pmo0Dc2Gog9sAOKykgFzjJObzPfZuaer4dQZGCJTR/8VOBjcglCRLfGubpymSoGN
         QeK0KeLHxxrc6eWicJ2p57MSwFFfORZC+tIm9oFMvn8ale9WsTltj/ZR3bzFQvP4ephp
         0Zi78uWZ71VpmZUfxTXYwQDz/0VONNsWmUN4VrM+2onCUfisyLIXZ3b3lCey5dHqd3Gg
         0ycKblken0K2i/ogC8bchklJq+7vJMQNgICRsQQ4M41z7/+OO76Bu1bauGuTAZBjNa0P
         q2Pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=vvwnlLSpY2UR7TwM4xfNn+7t55Ks33lFeG6Z0EyOl/M=;
        fh=fwOvUz8w1ZqJZ1/v77R6/YIxWuEy4XTWYCX3Sutuspg=;
        b=pBLgRtJ28LbncJEyhU0ZCa3ul/rRwV2bk2dmztsyHH+dv8cz6ZATj68zIfWWm5u1G5
         UNFSQmsG0v04jjm4Ovww9sJCsqUUkTN1JTbfUlxdJBCUpUkkZrGT5o70+ZDGjvl5qGbv
         TkNz13Ab8oFUvP70RCVrOf69l/1K9uqO1qxzlw1CRD6+YsiNyPaJEs+cK7d6Jz6oPxGE
         FO3PRA2qHtADhmzI/vzCi1HfqjEQ1ckXR/qPuvVAM6Pjero8Cipc1tcAgZZqiWa0jiup
         vASWFUDOzbXH/c/xUA0aYOYchLxVZ0hVerUOSpDRmBIyouv8DM5TSMlgqNUA30yMXTjj
         kU7g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788543380; x=1789148180; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=vvwnlLSpY2UR7TwM4xfNn+7t55Ks33lFeG6Z0EyOl/M=;
        b=qICsH5nxTtEhjdgg6E6gdRVOkzmZIJR4hOPlCvsWN+Aef6J4z7GArjYtIO9g3seLMl
         J1zfytBjxI4MbdZeKtCxPVPJ9hM/DVizAuLibwisRCxEp5ccXH1Gg0rP9B5AY8ljJ4lJ
         lpf4xjGV8UEG/nAg3Ek/oiS3tVgft8srv5YwbT5LoIvDthnnzUy8LelOy+5P2uD0abZc
         ASSV9PYXvJI7pbIXfNtIp2kgwWg53XwZXoCFWXQBnIn0mYdbUuxkaH4Q0f95w/V0KNDK
         ifXn8d1e+oueKIIOAPpoQdBurDraaCmCxXr96uyKTIPof6aUf25F/ZyhTHlDlRsNUWmQ
         St5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788543380; x=1789148180;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vvwnlLSpY2UR7TwM4xfNn+7t55Ks33lFeG6Z0EyOl/M=;
        b=BagBGd9yike+WAEclvtFpgLz6FFQrcXhn8atrR306n2AfmGuHdku895HiUCUAjsuKe
         vz6keC5/TtJzP24xd6yhZGrCYA6sP0GFnhj5QKbLJ887IDRKWHheNnBDXt1jMJkRJVdp
         z/przeyXrP0FPylWL1o/cXVaWKpUJ93WbJc6IgUj0UtjYI8gEF/pR7gHhETwRYKQ587H
         gFMwWWnIQ5wG3lYXYjie6qyfQ1ILTHSBsJAmO4Urini3Ei9fuuTr2qAeQ4Sixj3YXqEr
         KPn9XjlwQTLZnq6H6KmXIGa+CLs/TO8CSC6fBjyjynLyc3zVKkjpwYTEwpWYwfRSasYa
         mXew==
X-Forwarded-Encrypted: i=1; AKwUvBzutacyIPGvV2oPjNna/C90VBYElYbN0IWm47ns8XMSaahPceLHWuKFCIaWVk1zZxe44ZOCuRvtGRssRhzT0Il6@vger.kernel.org
X-Gm-Message-State: AFuF++kzrjOzLvr0qau3I9pRgV54PCTDKXAsCI82Q0xa2h0T0U32Mrjd
	2lwSwatE0ODk3SR9QbfFsI3ecFIiwFClO5QVvyKZF/eCvse8DGOlcUb+WU+1p1qbye8zA/yNXk4
	iZJfVp7nsYBxiGHV4xcLWLdXzUj56j/AUFSPpM2lC
X-Gm-Gg: AYBFou0SGULZEyy2NuxttZrXZ5GmUQcxjO3lVBw+6XBPjZlIR9BdfzjaTgf61JpOHA9
	N0pCNq0cgyOx7RC0UbAqUpikZhryR2FziChvlUPlF4Xzr4xqgIwE0zkhGihaLC/TMGgC0u51boR
	5pJ02oqcpzSiqbvybAlYLxz/oe7pTx4jf9RUypQRpovHbrf9aEMdLZBcMP8n0kQYCVdKoD90rte
	qs+FcN10C70qJ442G0Q86S9sP6wtYpF3QITAs9ZF8MeMOy7uZe9jNAryNa9V7ybm1CI0DjRW1b4
	L378p1lUxZ6nknzH8delqHcgKWQM3CnETm1goSrCdOfQNhRaRz5CyHQGw1it7anVrlawo0EWNp8
	=
X-Received: by 2002:a05:622a:2589:b0:517:64f6:3365 with SMTP id
 d75a77b69052e-53065d7943emr566721cf.4.1788543379667; Fri, 04 Sep 2026
 10:36:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260831063938.756610-1-namhyung@kernel.org>
In-Reply-To: <20260831063938.756610-1-namhyung@kernel.org>
From: Ian Rogers <irogers@google.com>
Date: Fri, 4 Sep 2026 10:36:08 -0700
X-Gm-Features: AcwNN1XQImgI7VKpu9wx95am5mDKvgVk0WQfynEdEu2BFXHT6erp-E_6QoKxf1g
Message-ID: <CAP-5=fWenUPGqNjy6CdzEnti8czpJTg14w=FTbDrTrHb9APRAw@mail.gmail.com>
Subject: Re: [PATCH v2] perf ftrace latency: Do not read trace files when BPF
 is used
To: Namhyung Kim <namhyung@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org, 
	Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 30, 2026 at 11:39=E2=80=AFPM Namhyung Kim <namhyung@kernel.org>=
 wrote:
>
> I've realized that it didn't set up the tracing files when BPF is used
> so poll() just returns immediately.  It ends up with calling poll()
> unnecessarily in a loop.
>
> BPF still needs the loop to wait for the target process exiting or a
> signal from users.  Let's use a semaphore instead.
>
> Suggested-by: Ian Rogers <irogers@google.com>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Masami Hiramatsu <mhiramat@kernel.org>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/builtin-ftrace.c | 28 ++++++++++++++++++++++------
>  1 file changed, 22 insertions(+), 6 deletions(-)
>
> diff --git a/tools/perf/builtin-ftrace.c b/tools/perf/builtin-ftrace.c
> index 4f881a40c311ae52..6017493ff179758b 100644
> --- a/tools/perf/builtin-ftrace.c
> +++ b/tools/perf/builtin-ftrace.c
> @@ -6,23 +6,23 @@
>   * Copyright (c) 2020  Changbin Du <changbin.du@gmail.com>, significant =
enhancement.
>   */
>
> -#include "builtin.h"
> -
> +#include <ctype.h>
>  #include <errno.h>
> -#include <unistd.h>
> -#include <signal.h>
> -#include <stdlib.h>
>  #include <fcntl.h>
>  #include <inttypes.h>
>  #include <math.h>
>  #include <poll.h>
> -#include <ctype.h>
> +#include <semaphore.h>
> +#include <signal.h>
> +#include <stdlib.h>
> +#include <unistd.h>
>  #include <linux/capability.h>
>  #include <linux/err.h>
>  #include <linux/string.h>
>  #include <linux/zalloc.h>
>  #include <sys/stat.h>
>
> +#include "builtin.h"
>  #include "debug.h"
>  #include <subcmd/pager.h>
>  #include <subcmd/parse-options.h>
> @@ -45,6 +45,7 @@
>
>  static volatile sig_atomic_t workload_exec_errno;
>  static volatile sig_atomic_t done;
> +static sem_t sig_sem;
>
>  static struct stats latency_stats;  /* for tracepoints */
>
> @@ -53,6 +54,7 @@ static char tracing_instance[PATH_MAX];       /* Trace =
instance directory */
>  static void sig_handler(int sig __maybe_unused)
>  {
>         done =3D true;
> +       sem_post(&sig_sem);
>  }
>
>  /*
> @@ -68,6 +70,7 @@ static void ftrace__workload_exec_failed_signal(int sig=
no __maybe_unused,
>  {
>         workload_exec_errno =3D info->si_value.sival_int;
>         done =3D true;
> +       sem_post(&sig_sem);
>  }
>
>  static bool check_ftrace_capable(void)
> @@ -1146,6 +1149,11 @@ static int __cmd_latency(struct perf_ftrace *ftrac=
e)
>
>         line[0] =3D '\0';
>         while (!done) {
> +               if (ftrace->target.use_bpf) {
> +                       sem_wait(&sig_sem);
> +                       break;
> +               }
> +
>                 if (poll(&pollfd, 1, -1) < 0)
>                         break;
>
> @@ -1852,6 +1860,8 @@ int cmd_ftrace(int argc, const char **argv)
>         INIT_LIST_HEAD(&ftrace.nograph_funcs);
>         INIT_LIST_HEAD(&ftrace.event_pair);
>
> +       sem_init(&sig_sem, 0, 0);
> +
>         signal(SIGINT, sig_handler);
>         signal(SIGUSR1, sig_handler);
>         signal(SIGCHLD, sig_handler);
> @@ -2015,5 +2025,11 @@ int cmd_ftrace(int argc, const char **argv)
>         delete_filter_func(&ftrace.nograph_funcs);
>         delete_filter_func(&ftrace.event_pair);
>
> +       signal(SIGINT, SIG_DFL);
> +       signal(SIGUSR1, SIG_DFL);
> +       signal(SIGCHLD, SIG_DFL);
> +       signal(SIGPIPE, SIG_DFL);
> +
> +       sem_destroy(&sig_sem);
>         return ret;
>  }
> --
> 2.55.0.897.gb25b4bd76c-goog
>
