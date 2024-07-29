Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9FD878274
	for <linux-perf-users@vger.kernel.org>; Mon, 29 Jul 2024 18:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722277393; cv=none; b=JFCDFERrSCHdkNt+He0B187oDO9FxpRRzui79KETfqraOsSRWVVoHQzhqwGiJ/ENpa8jKbsG7qOfQ7A7aR2OPM5mXs08lGyQTBstCElmnJLXlCcKlwX2VCjDcpxGR2Yhd0ETnzmQTWlXDPl1hziFDy7mE4I5/OP2i4tejr3lWHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722277393; c=relaxed/simple;
	bh=WnNhB5hl4PWalG5K4s/yj7xgk2QRfccIU4uPfCmhzKI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=l/od5ihDGYbAmVp+8F6882UrK4SDCKL11RoaUlMe3Ifp+CzUhMkiUTYnssyMuXzytuSBlLqWfeKh2ZfWecO4Sa3afioN+e4rEW6ows8IDVE2pIR4bBQHEvQt1KLwMp+1FZCeDN0RF8oYr+uDSEkhVAXJ11THOcr6bOwCx9ZghSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vpDMu9Xu; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vpDMu9Xu"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1fd657c9199so19405ad.1
        for <linux-perf-users@vger.kernel.org>; Mon, 29 Jul 2024 11:23:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722277391; x=1722882191; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9wW9dLEagiP7trbFcpTZEYkzfN8YZbrgKrWxiBHYcWs=;
        b=vpDMu9XuBtviaWiy5WmCu8+qL8VNvItA/DLZ3eMTHG+aEcC/MgmRYyavTYRWSXLgLR
         PKhldQ/37h2N4rwqRNgkAo9Lt7RsCYJT+M89DWPmHCX323mGjeZ92xpBqUfMlIBfTvZ2
         WodxIVMoP8Wj2Ig0jdXMfA1pC6xO2U3DtodUo/Mi3I7qz3fZlp8dyRUAu2H0IKq5ci4g
         YSHWl6r74xn0bDU3yKKmJt2V/BU6CtMG5i+ASYy2Q61VgMJ77BNlVRbt3drkPUOV0wHt
         Urxs9tfhFK83NX42esQIEqclwe4tPszC9tljyZE0q9iSsPlnEqhNuaPzr67TYZVuLtYz
         j7Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722277391; x=1722882191;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9wW9dLEagiP7trbFcpTZEYkzfN8YZbrgKrWxiBHYcWs=;
        b=sa6KCCz34Iw3k2RiZoy28VxBru7xWUnMgQQVESVYTUKz1m2Tac4tsMeq+3LWGahfon
         TWje29sJNW5QJYgwyNOEzgiTEukcE+2EVS7EUllp0T5Y3DSsCH8sfWtI+vd+BMAJv0Wo
         Bc6ehbqwCraX2N/SrCppzDfRWJAJrdyUDAcO739of3Yj71I14gYVu+7r7e5phZyU8rsz
         Lt7sijcNN1DtZxKfSUQqsrg9hg2dG3AQ7APD/DqbMqGki24HSR7lWtSPR10CfylFvexU
         z6Av9vfWFqELG3ZIoKqDteSYnHLwA7XelrRHjL52jg0CNLtNL0CcRwM9/YbENWm1P1xY
         N/XA==
X-Forwarded-Encrypted: i=1; AJvYcCXX4YsGyCz0RPxKFQhk9CIxfB/2ku9NqvUVWkkdm7wM11AmqyJWZ8IWrCnGdt9RMmEIW7H0iRrlZcemFsme0TusqCCA16nCg2YjPV6ask/B/Q==
X-Gm-Message-State: AOJu0YytiUd7KpFZLl1Es+qdg+5bZEvZYcJ95UHwKleT15nOy7qFZGi+
	vA/uF9B4Bmg5Zng5HRtVKTTB4UTcXmazUftivOasZdfntzHV975jHqiEQr7010dZ6Sm3oszJZuo
	QnY/YwK3NDp+y6c3AwVGjj5DptRIfZc68HLc3
X-Google-Smtp-Source: AGHT+IF8Ks4NgZw4ox8mnmoB3loe9bJH8mqZoWZi2P+XuTkyw/POJMltrLC1jn9h4LnhjD0VwKxRWmD/51tyw4ujO6I=
X-Received: by 2002:a17:903:2a84:b0:1f7:34e4:ebc1 with SMTP id
 d9443c01a7336-1ff34d6465fmr835425ad.5.1722277390733; Mon, 29 Jul 2024
 11:23:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240729004127.238611-1-namhyung@kernel.org> <20240729004127.238611-3-namhyung@kernel.org>
In-Reply-To: <20240729004127.238611-3-namhyung@kernel.org>
From: Ian Rogers <irogers@google.com>
Date: Mon, 29 Jul 2024 11:22:59 -0700
Message-ID: <CAP-5=fVt_k=MzGUhMQzS7YRXQ7xzKEFa9+E4kV0D4BPHCNabGw@mail.gmail.com>
Subject: Re: [PATCH 2/4] perf ftrace: Factor out check_ftrace_capable()
To: Namhyung Kim <namhyung@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Kan Liang <kan.liang@linux.intel.com>, 
	Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org, 
	Steven Rostedt <rostedt@goodmis.org>, Changbin Du <changbin.du@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jul 28, 2024 at 5:41=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> The check is a common part of the ftrace commands, let's move it out.
>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>

The whole ifdefs and perf_cap__capable seemed wrong, not least as we'd
like the error message to be accurate not just when libcap is present,
so I sent out;
https://lore.kernel.org/lkml/20240729181931.2870851-1-irogers@google.com/
which I think can supersede this.

Thanks,
Ian

> ---
>  tools/perf/builtin-ftrace.c | 44 +++++++++++++++++--------------------
>  1 file changed, 20 insertions(+), 24 deletions(-)
>
> diff --git a/tools/perf/builtin-ftrace.c b/tools/perf/builtin-ftrace.c
> index 33c52ebda2fd..978608ecd89c 100644
> --- a/tools/perf/builtin-ftrace.c
> +++ b/tools/perf/builtin-ftrace.c
> @@ -59,6 +59,22 @@ static void ftrace__workload_exec_failed_signal(int si=
gno __maybe_unused,
>         done =3D true;
>  }
>
> +static int check_ftrace_capable(void)
> +{
> +       if (!(perf_cap__capable(CAP_PERFMON) ||
> +             perf_cap__capable(CAP_SYS_ADMIN))) {
> +               pr_err("ftrace only works for %s!\n",
> +#ifdef HAVE_LIBCAP_SUPPORT
> +               "users with the CAP_PERFMON or CAP_SYS_ADMIN capability"
> +#else
> +               "root"
> +#endif
> +               );
> +               return -1;
> +       }
> +       return 0;
> +}
> +
>  static int __write_tracing_file(const char *name, const char *val, bool =
append)
>  {
>         char *file;
> @@ -586,18 +602,6 @@ static int __cmd_ftrace(struct perf_ftrace *ftrace)
>                 .events =3D POLLIN,
>         };
>
> -       if (!(perf_cap__capable(CAP_PERFMON) ||
> -             perf_cap__capable(CAP_SYS_ADMIN))) {
> -               pr_err("ftrace only works for %s!\n",
> -#ifdef HAVE_LIBCAP_SUPPORT
> -               "users with the CAP_PERFMON or CAP_SYS_ADMIN capability"
> -#else
> -               "root"
> -#endif
> -               );
> -               return -1;
> -       }
> -
>         select_tracer(ftrace);
>
>         if (reset_tracing_files(ftrace) < 0) {
> @@ -902,18 +906,6 @@ static int __cmd_latency(struct perf_ftrace *ftrace)
>         };
>         int buckets[NUM_BUCKET] =3D { };
>
> -       if (!(perf_cap__capable(CAP_PERFMON) ||
> -             perf_cap__capable(CAP_SYS_ADMIN))) {
> -               pr_err("ftrace only works for %s!\n",
> -#ifdef HAVE_LIBCAP_SUPPORT
> -               "users with the CAP_PERFMON or CAP_SYS_ADMIN capability"
> -#else
> -               "root"
> -#endif
> -               );
> -               return -1;
> -       }
> -
>         trace_fd =3D prepare_func_latency(ftrace);
>         if (trace_fd < 0)
>                 goto out;
> @@ -1220,6 +1212,10 @@ int cmd_ftrace(int argc, const char **argv)
>         signal(SIGCHLD, sig_handler);
>         signal(SIGPIPE, sig_handler);
>
> +       ret =3D check_ftrace_capable();
> +       if (ret < 0)
> +               return -1;
> +
>         ret =3D perf_config(perf_ftrace_config, &ftrace);
>         if (ret < 0)
>                 return -1;
> --
> 2.46.0.rc1.232.g9752f9e123-goog
>
