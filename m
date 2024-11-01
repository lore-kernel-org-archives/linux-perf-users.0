Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9620F2D047;
	Fri,  1 Nov 2024 02:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730426600; cv=none; b=eb5TecfzQORLloyJPr1fZXmxXxA+IcVOSjm9hZIg7NCaCnMan5q8pP9dI8jfZiKdeq01jA8SniYs/rpT2pBx7Aht2Gq3EdvaF2dc5/jAPFKep9ra61bMUJzOmnsIo2tccLcIdBY5hmJYGKzdocWiqQZk0xQBgfASvmOfz8ZO2G0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730426600; c=relaxed/simple;
	bh=UzZGjlq2NMeCCNYaIEhS4hI/vfrwUwvmx0tvmBsn8tE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=K0kWRIdnD046B6F6+b3FcRBskPfZXwKnckXLOAxkfcYEvInLMr8zhqxz8Io25DCGqR1NXI/V8b2HqqKmUVsLFO/V4tP3gIts732RlDMl5HWINafxddXnbM1Lo5qyjinmieBQJ5A5ClvDyYY9+CQ3OE+38KazHlKg1t6mwPcIcog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HTHpru/V; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HTHpru/V"
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-6ea4add8a5fso15195647b3.0;
        Thu, 31 Oct 2024 19:03:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730426593; x=1731031393; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Te1OE/CZo/VDUhv2lpaanuO9l9CeXus+cfr9lW8+Q20=;
        b=HTHpru/VRP3iMrEHLjsoXFoQwRTNNA5398pxpq7+kJtVKdXbbUzKBm4ysiRVn1m3Uj
         waLaynzzoSxxNEBHAv1DHdMXKAkrDqaPuOMZHDn1JPGKd+x6kFPA+iajsJOr7ONoiDaA
         hRsjkCkZHP0Gwq0pLjJNeY6vxc9eT7rm9JJZar3jlf6SSNkAWdv0J9MZsiLup2OfUWfn
         TRkBv+f0O0b1dY6Z+wt2DEIMjnXbJ0Pp9LV/tSJiE38PfCPEroH7747uVq5V6LQc+nnE
         ZCJ+r70c3O/I33M4+UdJyp2khHghm6beet91vhJgHBZTo9bRSrAG4MaTH8ags4LqJUPi
         CCCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730426593; x=1731031393;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Te1OE/CZo/VDUhv2lpaanuO9l9CeXus+cfr9lW8+Q20=;
        b=rvtVhgLKs92Z60tRo2S2W3MwT+CzyDzCJyU+K6QQoWe+Y9mQgfM1VutNZLYmBIXNjn
         kgO2nUxtqpVKtXqNhrb4qv80MmSuvFny74R0IUv6Hxgs3oeu2wouw/zhsGAGFKmyb54P
         Ypw8Ou8Md29L/EUNV+aQkNHy3oI25woqgJ1vsgsbNs0y3vaibJ67FFJ3nBgy0aoabL0A
         5w4pnCo9EA5lIdPFuQ1RIYT8aZOA7E7ilVQz3OSQ3b0kH049ztqKa/eJo4EmV3piTqrd
         ZuuE9w6g+H/I5nGlj83uPkGidBUwZVUXPho/i7V91n2ARrNEJAzCn41vlJcPBeDSDGX1
         aenA==
X-Forwarded-Encrypted: i=1; AJvYcCUF19jMblWMu5ShEmugHvym8wnIUco/1yJfBruJ0wyjm5K/DGuECA+LRkGiVB/zjUyH23yhnynGrNLlMl4=@vger.kernel.org, AJvYcCVyZQJrS9avRtDE2+WyrPaokiJIAEoQoP8rZgsCnSvDarutq4l0KrJgLihIHFXTibVLvnIi0yfUdsz9s7VKClEWxw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxVaM7DpPILFjRtNbY9pnmoAYsGgE1rY4db5RWlFMpHlivf2luG
	HZwU7dd4ODFfhBeeIwP2y4KoLLz9ugBLN8Ar8ispGcOOWqFJn8AR2/sRfYsFZuMJH/v2GJ49gIb
	F9sGRSvw9vbfHSS0/Q8WOKkFrxkVBnka8AQo=
X-Google-Smtp-Source: AGHT+IFconlXndYXuiFUkbijurfjCn/QXjppHpR3BjmjmGzAuMrOOpa/i5ZIRe+HHn/doxcXrIzMDNy3qhlWBcjicuw=
X-Received: by 2002:a05:690c:296:b0:647:7782:421a with SMTP id
 00721157ae682-6ea52549817mr56596107b3.45.1730426592621; Thu, 31 Oct 2024
 19:03:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241101005338.5846-1-benjamin@engflow.com>
In-Reply-To: <20241101005338.5846-1-benjamin@engflow.com>
From: Howard Chu <howardchu95@gmail.com>
Date: Thu, 31 Oct 2024 19:03:02 -0700
Message-ID: <CAH0uvohLu-N+SRu=ddaHnLhC48JAj_=Pf-ZthgOTyFJ44AEumQ@mail.gmail.com>
Subject: Re: [PATCH] perf trace: avoid garbage when not printing an trace
 event's arguments
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

It does not build on my system due to this warning:

builtin-trace.c: In function =E2=80=98trace__fprintf_tp_fields=E2=80=99:
builtin-trace.c:3090:35: error: field precision specifier =E2=80=98.*=E2=80=
=99 expects
argument of type =E2=80=98int=E2=80=99, but argument 3 has type =E2=80=98si=
ze_t=E2=80=99 {aka =E2=80=98long
unsigned int=E2=80=99} [-Werror=3Dformat=3D]
 3090 |         fprintf(trace->output, "%.*s", printed, bf);
      |                                 ~~^~   ~~~~~~~
      |                                   |    |
      |                                   int  size_t {aka long unsigned in=
t}

Thanks,
Howard

On Thu, Oct 31, 2024 at 5:54=E2=80=AFPM Benjamin Peterson <benjamin@engflow=
.com> wrote:
>
> trace__fprintf_tp_fields may not print any tracepoint arguments. E.g., if=
 the
> argument values are all zero. Previously, this would result in a totally
> uninitialized buffer being passed to fprintf, which could lead to garbage=
 on the
> console. Fix the problem by passing the number of initialized bytes fprin=
tf.
>
> Remove the return value of trace__fprintf_tp_fields, since it was meaning=
less
> and ignored.
>
> Fixes: f11b2803bb88 ("perf trace: Allow choosing how to augment the trace=
point arguments")
> Signed-off-by: Benjamin Peterson <benjamin@engflow.com>
> ---
>  tools/perf/builtin-trace.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
> index d3f11b90d025..e93f795e680f 100644
> --- a/tools/perf/builtin-trace.c
> +++ b/tools/perf/builtin-trace.c
> @@ -3021,7 +3021,7 @@ static void bpf_output__fprintf(struct trace *trace=
,
>         ++trace->nr_events_printed;
>  }
>
> -static size_t trace__fprintf_tp_fields(struct trace *trace, struct evsel=
 *evsel, struct perf_sample *sample,
> +static void trace__fprintf_tp_fields(struct trace *trace, struct evsel *=
evsel, struct perf_sample *sample,
>                                        struct thread *thread, void *augme=
nted_args, int augmented_args_size)
>  {
>         char bf[2048];
> @@ -3087,7 +3087,7 @@ static size_t trace__fprintf_tp_fields(struct trace=
 *trace, struct evsel *evsel,
>                 printed +=3D syscall_arg_fmt__scnprintf_val(arg, bf + pri=
nted, size - printed, &syscall_arg, val);
>         }
>
> -       return printed + fprintf(trace->output, "%s", bf);
> +       fprintf(trace->output, "%.*s", printed, bf);
>  }
>
>  static int trace__event_handler(struct trace *trace, struct evsel *evsel=
,
> --
> 2.39.5
>
>
