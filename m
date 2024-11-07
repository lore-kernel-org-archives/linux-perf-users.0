Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAEB9DDBE;
	Thu,  7 Nov 2024 21:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731015989; cv=none; b=rC6KuEk59oDEykb4PoGsw8v3z9Mw9KYOVZgca9WGi2CTUaurr71/r6xg+tMdTH/s4ugIrWvexLtvUHN+qpws59VMOFdJpR4wTTVewurF9JPFvc6qjVIBTfpBAP8u/k1lPmgSS3lzYWBNehstHJbpz91sZuVfIMMh/Z4hxNnQnM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731015989; c=relaxed/simple;
	bh=Fb0MiIbLCXPXmfhjTJQInLRGdtkD2HZ0eZUS1xVTb5U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=vBjMqKH7N1bGj8vcAhIVxeQw7a1iMbBLOzrfPArKbLbVrDSTCmcNTLR4xbFC2TsJ67JSDCEqubXXeCGUIfY+movxcv7TEPGNCAAGlEaHf3YGit2n+rouA0jKEgDabukNvYqMh3cVaEndwj0tMbSgKH/8gGaQ++9LFWQOoA65jDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ArIf0MEg; arc=none smtp.client-ip=209.85.219.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ArIf0MEg"
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-e290554afb4so1565918276.0;
        Thu, 07 Nov 2024 13:46:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731015987; x=1731620787; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FboSWRAZe89SlRX3X2Htv47szgsz9jQ5dqHGQjAOzbQ=;
        b=ArIf0MEgm33gKAbPYwV1AjNkxuRGemCcamapWafCkxxvstXdBHceXz5bEOPTZO8PO9
         EC3pqC1YkQ38biNdCZgyNXAaeD1Z3ioYQS661y1Bj4bCulW4kAgsW8MFWXWM19cvYtrD
         7N8gEfEGT722tOeYfkDJgKdYcEjTJeoz2WjehR9fbVGVf2NT0hl8JA8HF9CZaFAZQPnt
         vPOoQQ6Qi5/FyDutttLiIu4SW20O0uCr05mr20jRNM8216/56vwmLgKRQ8nBXDX9o+Kp
         zjwJC1tw+NgQ6sjyEFyMiWZD16yu/zWfzpIYTFbooC5UKKQ5cPbX+y7edskIyvCv+Tsh
         MT8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731015987; x=1731620787;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FboSWRAZe89SlRX3X2Htv47szgsz9jQ5dqHGQjAOzbQ=;
        b=k0oVqvl9RoUwMppgTQsP89aty4OWTUnoDbHQ7XVPlFsBPxstcFgnCyY9FJWJJ1Fxsc
         bpRl9kw2Ks9sN5zLpqwgtwimgKKVFYv5Wx1DgDa+rhYoZcUScXus/4qmtA3ZFfLfnRqu
         cuMh+N53w9qEBmteANBTVuix8TuL+ZCrYXIEuqPQ051lqg4gXMV6j2KC1RuSgmCLrRKP
         zPa9AjK92ofzLOWGAlMsJP5T43j4O8r9NYmMx4Qrd7aYTlXv8L5zD279x2/gSH7bjBpx
         YLIX5sSkdgQSmlM6jfku1HuZX2Uq30A6/z3RQFUD3r7iWq9nre6BTiT127TBKkgjRC+/
         5Ztw==
X-Forwarded-Encrypted: i=1; AJvYcCUEfaQPcAV9miEiXLt2jJvPlIESlZQk2KRSq8DjjBWtCR7GHj+ivD5c36XQtKGEmd6Avc4KTD0YalPSptOu0TPCEA==@vger.kernel.org, AJvYcCXLWMeZ0LfYtKvwr3lfhop8Ktp5e7/MknOHK2JoclI0q51ZRPk2xpU9EMphSenGTWNvlRV6HechDxMO7s4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPJUaIV+7oW2bINA9SgmB+vyILe1oMgQYyRpVi6Md+kw4p9ir0
	YskqBbE2vxb8UwI1bq0B/FuZ39x805Mg53lg37JjKOQ+hfCvcbyPl9aMTfFwlmdqGejoaXl20dU
	/1FcicvVg9BTJg5yzNqKz6zQFMWc=
X-Google-Smtp-Source: AGHT+IFJ4F8u/Qi41tFeFHe2VfD76MJ6LUbm1txagiXutEZGZ9e21KrJTm+bLI2badHgdk7pOKxKK3Q0JIZvXar+rds=
X-Received: by 2002:a05:6902:c06:b0:e30:dc1e:d81f with SMTP id
 3f1490d57ef6-e337f86cdfdmr762098276.21.1731015986825; Thu, 07 Nov 2024
 13:46:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241106234518.115234-1-benjamin@engflow.com>
In-Reply-To: <20241106234518.115234-1-benjamin@engflow.com>
From: Howard Chu <howardchu95@gmail.com>
Date: Thu, 7 Nov 2024 13:46:19 -0800
Message-ID: <CAH0uvohodYgZ9hL=fRauk_85+sNjAVvjdB1UxKouMLLURYTbuQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] perf trace: do not lose last events in a race
To: Benjamin Peterson <benjamin@engflow.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	"Liang, Kan" <kan.liang@linux.intel.com>, 
	"open list:PERFORMANCE EVENTS SUBSYSTEM" <linux-perf-users@vger.kernel.org>, 
	"open list:PERFORMANCE EVENTS SUBSYSTEM" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Benjamin,

Without your patch (no output):
perf $ ./perf trace -e syscalls:sys_enter_exit_group true
perf $

With your patch:

perf $ ./perf trace -e syscalls:sys_enter_exit_group true
     0.000 true/1530009 syscalls:sys_enter_exit_group()

The result looks good.

Tested-by: Howard Chu <howardchu95@gmail.com>

Thanks,
Howard

On Wed, Nov 6, 2024 at 3:45=E2=80=AFPM Benjamin Peterson <benjamin@engflow.=
com> wrote:
>
> If a perf trace event selector specifies a maximum number of events to ou=
tput
> (i.e., "/nr=3DN/" syntax), the event printing handler, trace__event_handl=
er,
> disables the event selector after the maximum number events are
> printed. Furthermore, trace__event_handler checked if the event selector =
was
> disabled before doing any work. This avoided exceeding the maximum number=
 of
> events to print if more events were in the buffer before the selector was
> disabled. However, the event selector can be disabled for reasons other t=
han
> exceeding the maximum number of events. In particular, when the traced
> subprocess exits, the main loop disables all event selectors. This meant =
the
> last events of a traced subprocess might be lost to the printing handler'=
s
> short-circuiting logic.
>
> This nondeterministic problem could be seen by running the following many=
 times:
>
>   $ perf trace -e syscalls:sys_enter_exit_group true
>
> trace__event_handler should simply check for exceeding the maximum number=
 of
> events to print rather than the state of the event selector.
>
> Fixes: a9c5e6c1e9bff ("perf trace: Introduce per-event maximum number of =
events property")
> Signed-off-by: Benjamin Peterson <benjamin@engflow.com>
> ---
>  tools/perf/builtin-trace.c | 9 ++-------
>  1 file changed, 2 insertions(+), 7 deletions(-)
>
> diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
> index d3f11b90d025..f6179b13b8b4 100644
> --- a/tools/perf/builtin-trace.c
> +++ b/tools/perf/builtin-trace.c
> @@ -3096,13 +3096,8 @@ static int trace__event_handler(struct trace *trac=
e, struct evsel *evsel,
>  {
>         struct thread *thread;
>         int callchain_ret =3D 0;
> -       /*
> -        * Check if we called perf_evsel__disable(evsel) due to, for inst=
ance,
> -        * this event's max_events having been hit and this is an entry c=
oming
> -        * from the ring buffer that we should discard, since the max eve=
nts
> -        * have already been considered/printed.
> -        */
> -       if (evsel->disabled)
> +
> +       if (evsel->nr_events_printed >=3D evsel->max_events)
>                 return 0;
>
>         thread =3D machine__findnew_thread(trace->host, sample->pid, samp=
le->tid);
> --
> 2.39.5
>
>
