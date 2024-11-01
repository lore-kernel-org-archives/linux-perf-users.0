Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F59312D758;
	Fri,  1 Nov 2024 21:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730494859; cv=none; b=mEl1vDjoO/xPqWUu8jHDugdRuuXloX0Fej/Hv4fc/P4b9+Is6F7YI6PIZXOWO/YFrbvEhrw4SBqX/CGXUZTVp+64GHvcMZWafvxTqxuT4/wjRUz5Jnwj2Mq5I1O/9BrSZ4gXqt55i7R4OBpeqF99FER6MhsnagymyhNUwzqTzIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730494859; c=relaxed/simple;
	bh=miy3Kf2jwUEuhZOasiLIiux1aqtLf72tk87BaWrvkjo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fbAgFIGcZJ3hPeJIirB3pyZVSiKN1t82QRgA4CEu9NzfbK8ps9ejUGNZIECKgzZm5+Hi8kwSiP3/SxujaFwweCwmQrAwN9CcVtyH5DG3G1vKV2Z7gAGJBes6/r4iTOWYH7SP9VWZLi+652pALxXiCtzFnZHICqYOTtEkOmwvHvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DLmVHrGB; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DLmVHrGB"
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-6ea053b5929so20763307b3.0;
        Fri, 01 Nov 2024 14:00:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730494855; x=1731099655; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qaV7ELqFA+mAL6sc/qk3B5LXboH7u0S8/APmxDBWmp8=;
        b=DLmVHrGBOaF2f5HhAwbbgQTjMp7MU/epymRSEVO3k2pB7j+zEznhlNYPxEPf0NUzet
         Sk42Uyt/5Z1/Z6w6V/Fk6GgUyRn+FBiqgbg7SobT1f3osSvBtbWVVJhheJCAVdMSVTZG
         f1PN/BpfO6YnjKxgXAUD4F4/K8Vw+fMORhill812bhW+YtcbsQqPcmKpH8w0IrUXEHpB
         3IsOFVrNkzB5jFdsygMtB+hLVKZG63gt8DlEsX9foJSgdktfPVNvigsAg2qNoJQo2Nz/
         68eG9mCvx44FywQH+z7wuEmY1SZsh5tPScXRtCbsQolEU2GR+qgycZFdt2YtCo8UiRQH
         6+tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730494855; x=1731099655;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qaV7ELqFA+mAL6sc/qk3B5LXboH7u0S8/APmxDBWmp8=;
        b=NAZkBEiD/LAF9HhuFyrAhZyjjHLNeGT6QyF03Vgj8KC3IXr2C86Xa+EpSEsATs1jkE
         EOKsQPKujVTTo58yvt0nUcGf74K3u7NauOVwyV0sDF9ECbUlw5aBLrb4/pYcSacM/N49
         eKtzojH4xq5CTg54vffG0veWxkPy1ZXq6QgRmDTfj2Xl/YVWc31nmkMUisATQarsPZx5
         wguOUO2YQz0LRqva1hKd/+ViIWqoJT6Icd+S4oYDYoYlzpHIL//BL7QXSBk3yAtz0XED
         L8pDxkazzKbqZCbG9UvLGPjZkkLBpimJ8RXROEuq+Moqsirhy6LysGh8J3iClNHSLZ5j
         FQRA==
X-Forwarded-Encrypted: i=1; AJvYcCVxU3efEdNvBY+Yme39KoOJFPBX5TUBmCwIWjoqOkpifvNegZGGg49+Dk7oWfNa4HbTOE0M85xcp6nOgpr4X9WTYg==@vger.kernel.org, AJvYcCX2i1TuQI+Fu6+qhpDsou1B9QiWI3XnAnb4KaZTzr95P26FomkDcb6+/NLujYBCiMhzwONJIECSdocJkio=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQfTaji6Hl+EF8g419wVKGCC9svCq7AF5Dbu4405J3D7wRkDdj
	Z5yJm4IC0cpJ1+ncjThdkU42ceySuwk0TGYxa/E9a1pNjPWmTnmS7h/Doi8+HCZv2yEDAC6k2GV
	r0yuNG4VKOlRnKHLhg8XAEosoYMY=
X-Google-Smtp-Source: AGHT+IELpH/0F7dV8dRl6EddHDXSq+7XHjxQcti0Y+c3T6a7N/b71cptP8YYhBzeeaH+weNQlnH7APaJPYE8K3tw2/c=
X-Received: by 2002:a05:690c:6306:b0:6e3:1003:cb0c with SMTP id
 00721157ae682-6ea64c9f0a9mr51785097b3.46.1730494855149; Fri, 01 Nov 2024
 14:00:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241101005338.5846-1-benjamin@engflow.com> <20241101172714.84386-1-benjamin@engflow.com>
In-Reply-To: <20241101172714.84386-1-benjamin@engflow.com>
From: Howard Chu <howardchu95@gmail.com>
Date: Fri, 1 Nov 2024 14:00:46 -0700
Message-ID: <CAH0uvohNO517GAD7XH-VvUvU+dPdeZBKDw0Teij50sAPSe9sCQ@mail.gmail.com>
Subject: Re: [PATCH v2] perf trace: avoid garbage when not printing a trace
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

Before your patch:

perf $ ./perf trace -e net:netif_rx_exit
     0.000 irq/79-brcmf_p/1694977 net:netif_rx_exit(6n<)
    28.153 irq/79-brcmf_p/1694977 net:netif_rx_exit(6n<)
    36.429 irq/79-brcmf_p/1694977 net:netif_rx_exit(6n<)
    36.461 irq/79-brcmf_p/1694977 net:netif_rx_exit(6n<)

After:

perf $ ./perf trace -e net:netif_rx_exit
     0.000 irq/79-brcmf_p/1694977 net:netif_rx_exit()
     7.352 irq/79-brcmf_p/1694977 net:netif_rx_exit()
    30.232 irq/79-brcmf_p/1694977 net:netif_rx_exit()
    37.529 irq/79-brcmf_p/1694977 net:netif_rx_exit()

It works beautifully, but I'm thinking can we simplify it by just doing:

+       char bf[2048] =3D { 0 };
        size_t size =3D sizeof(bf);

That being said, trace__fprintf_tp_fields() should return void because
currently its return value is not used by any other functions, plus
this line:

return printed + fprintf(trace->output, "%s", bf);

in trace__fprintf_tp_fields() does not make much sense, since that
will be 2 * printed. So I'm thinking maybe:

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 748b061f8678..8a628d1e80f3 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -3021,10 +3021,10 @@ static void bpf_output__fprintf(struct trace *trace=
,
        ++trace->nr_events_printed;
 }

-static size_t trace__fprintf_tp_fields(struct trace *trace, struct
evsel *evsel, struct perf_sample *sample,
+static void trace__fprintf_tp_fields(struct trace *trace, struct
evsel *evsel, struct perf_sample *sample,
                                       struct thread *thread, void
*augmented_args, int augmented_args_size)
 {
-       char bf[2048];
+       char bf[2048] =3D { 0 };
        size_t size =3D sizeof(bf);
        struct tep_format_field *field =3D evsel->tp_format->format.fields;
        struct syscall_arg_fmt *arg =3D __evsel__syscall_arg_fmt(evsel);
@@ -3087,7 +3087,7 @@ static size_t trace__fprintf_tp_fields(struct
trace *trace, struct evsel *evsel,
                printed +=3D syscall_arg_fmt__scnprintf_val(arg, bf +
printed, size - printed, &syscall_arg, val);
        }

-       return printed + fprintf(trace->output, "%s", bf);
+       fprintf(trace->output, "%s", bf);
 }

 static int trace__event_handler(struct trace *trace, struct evsel *evsel,


Then this will be one more diff line than yours.

But that's just my opinion, yours works just fine, thank you :).
Arnaldo, what do you think?

Tested-by: Howard Chu <howardchu95@gmail.com>

Thanks,
Howard

On Fri, Nov 1, 2024 at 10:27=E2=80=AFAM Benjamin Peterson <benjamin@engflow=
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
> index d3f11b90d025..4e785ea29df6 100644
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
> +       fprintf(trace->output, "%.*s", (int)printed, bf);
>  }
>
>  static int trace__event_handler(struct trace *trace, struct evsel *evsel=
,
> --
> 2.39.5
>
