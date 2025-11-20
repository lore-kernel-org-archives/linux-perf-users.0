Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 467C42EACF9
	for <linux-perf-users@vger.kernel.org>; Thu, 20 Nov 2025 05:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763617384; cv=none; b=udX3yc558ucG6qHYkSu7gQlNCMkUEjnjshNEFKw0h8iOvkx+TIjU/6fe3nXm4okMWQ3pMLF0iBgsHPGEW4QfYHLyES7DzE5rjU5ZOlTCS9+kTz4lBG/r7NjIopzeAmg1Wmp8xJytG65P2zpyKi6ZoRTAK1dKUSDOSAEkyvyQGM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763617384; c=relaxed/simple;
	bh=TWnABHL+rQ9alCI5zG6PnV5BqWmgmpij1S6oa+69BWA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=F381uevuDNRqN+kcqSGHgrbvNzbKkDRfxwXangJfydno/TMWq653WqM+kG1ucf4Y2BaiDc8u36gsuyPUtFh0kuSWlhQcH7PgI/ceDzOjD7amHgNIoyM6uVIgxGoNWVjVb8XlRnjam8IiIwWHZBNfPBZTMaUrd8Ssx7kZuDO364k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=l6/x+DKc; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="l6/x+DKc"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-29852dafa7dso90465ad.1
        for <linux-perf-users@vger.kernel.org>; Wed, 19 Nov 2025 21:43:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1763617382; x=1764222182; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bfZDzdVomdFOAbu4k1ifjbqTlvI/oPaxcJTB+P4Vgzg=;
        b=l6/x+DKc/AxoxUbvtYNBwuCvzaWfMYLjZvhGSu09HsrabFS4ChFYmnGHON0IHD6/GB
         1rIXc/swMtDQ3p36xuiRJb6dglpX5gHcaSnceD2259cqfaexPnVDEClT1J1HInYvtATe
         o1rDMs0Y5GhiVq3OJxJYo3I8Zm+YIKJSUUlaPS3FAN64nXRlHM10V0qW5ePDfJrQTC36
         d5L0lELAezci7aT9a6EZSOP338S5c/QhHGjK9g9H/vyTJnB/ethKzzslbyJVRqLuGpJx
         t5RYFfqJWLEX9r/Aqi8jGPHm0UmJNslGwkQEfDZ7SBaENoOSwOQ2MYCo8Fb+rSjTLLMQ
         owLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763617382; x=1764222182;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bfZDzdVomdFOAbu4k1ifjbqTlvI/oPaxcJTB+P4Vgzg=;
        b=H+womheTO7SbUZqXubxDxvf/14M9cuBeV/sP9vrJgvQwRUKNU1pY2bUa3YG/g9xOrI
         bFt8AKORMo3LgvYmGwHcy7N+UTwHCtqWJ+/EES+5ARErD1IjLS5tulJAL1AMaoQqapBv
         nf3ZCzWUC7cQOAvQ+R4RwglCth54kYzzV4hOVGEtw86thiQsZjaI4B9LDUgFbkrSXb7F
         lG3sntp8+TwcGF1kwqhrMOlnMjeC8OSiBKr67kxX83rUPb79hDGEyyYh6vGZhFKCwJ5n
         QwJSgXUbkfoQxztQ6BtacldXOy8oR2US5d6NVUaLcYSKetFaSCiIplso1YlcN1BIkysO
         ANpw==
X-Forwarded-Encrypted: i=1; AJvYcCUpH5J5UDtxuBPmPPWA6JAetMWK9+zh6HDSwFxIC1wcNzIQZSSBRaZs6ES/MZMpFM1W/pahWkUoB93WrJg0rGsG@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/YVEyO5dBXvDvzjeQQ5GxVW6n/XDKsZ2w3i+2DIjsHxhL5jeU
	Pn8BaeZDSf9KxIq3rse6Fuzl80db39qroPPjmJVvAu3pIWvYzxwyHZ0w80sFPVyknC+vLfLAN+H
	iPZ46K11Muu1nZNQdSqOJ0yupZcQ6/P7c8m0f5TAr
X-Gm-Gg: ASbGncv0AS8+g4uS1ha3sIPWoituLlKAhnhCVu3nijeFG+idG9B+dZlerUFzNZJmjwC
	AOlZAGrI04YfxnKN7L4AFdHTgQz+5zd5SF+O57e+ePFqZOqA221VwI7aTis/4AaJNjQ1z62xr7H
	dgnWVO8B+EQExhXzKRTF9Zf8OwI+qnJixJFRxfxzI4bCAmATkn6Ad8y7FzjMbbJIpBVpd+HK7jA
	2vi0gTXepjP0va4/z1MDpoNbiQLthISRu41cAJg9p5+Wqpne1DbuYaKU6N2ok8xZJ/TyClF
X-Google-Smtp-Source: AGHT+IFexG2X1GJLa1BioZtPqOwj/IqTHlir182hHktW2eP4jmeZIU9Hhw1eVrE5FodFuk+qqe08v5VCv/3MHNHieoI=
X-Received: by 2002:a17:902:cec7:b0:291:6488:5af5 with SMTP id
 d9443c01a7336-29b5da76ae2mr1537695ad.1.1763617382389; Wed, 19 Nov 2025
 21:43:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251120004726.61660-1-namhyung@kernel.org> <20251120004726.61660-3-namhyung@kernel.org>
In-Reply-To: <20251120004726.61660-3-namhyung@kernel.org>
From: Ian Rogers <irogers@google.com>
Date: Wed, 19 Nov 2025 21:42:51 -0800
X-Gm-Features: AWmQ_bkhfCKwHpSFKPpdWMgknNxiPr_6XmWJY0WjY14JtA9VsIYZdfuh-ILhNL0
Message-ID: <CAP-5=fWHTGSZPDO06FJENFLW0AtS1Fukk1jqFeHqyGFa+HLhMw@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] perf list: Support filtering in JSON output
To: Namhyung Kim <namhyung@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, James Clark <james.clark@linaro.org>, 
	Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 19, 2025 at 4:47=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> Like regular output mode, it should honor command line arguments to
> limit to a certain type of PMUs or events.
>
>   $ perf list -j hw
>   [
>   {
>           "Unit": "cpu",
>           "Topic": "legacy hardware",
>           "EventName": "branch-instructions",
>           "EventType": "Kernel PMU event",
>           "BriefDescription": "Retired branch instructions [This event is=
 an alias of branches]",
>           "Encoding": "cpu/event=3D0xc4\n/"
>   },
>   {
>           "Unit": "cpu",
>           "Topic": "legacy hardware",
>           "EventName": "branch-misses",
>           "EventType": "Kernel PMU event",
>           "BriefDescription": "Mispredicted branch instructions",
>           "Encoding": "cpu/event=3D0xc5\n/"

I think these newlines can be fixed by changing:
https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.gi=
t/tree/tools/perf/util/pmu.c?h=3Dperf-tools-next#n643
```
ret =3D io__getline(&io, &alias->terms, &line_len) < 0 ? -errno : 0;
if (ret) {
   ...
}
```
to something like:
```
ret =3D io__getline(&io, &alias->terms, &line_len) < 0 ? -errno : 0;
if (ret) {
    ...
}
if (alias->terms[line_len - 1] =3D=3D '\n')
    alias->terms[line_len - 1] =3D '\0';
```

>   },
>   ...
>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/builtin-list.c | 24 ++++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
>
> diff --git a/tools/perf/builtin-list.c b/tools/perf/builtin-list.c
> index 6c5913f129f39c94..5cbca0bacd35237e 100644
> --- a/tools/perf/builtin-list.c
> +++ b/tools/perf/builtin-list.c
> @@ -373,6 +373,23 @@ static void json_print_event(void *ps, const char *t=
opic,
>         FILE *fp =3D print_state->common.fp;
>         struct strbuf buf;
>
> +       if (deprecated && !print_state->common.deprecated)
> +               return;
> +
> +       if (print_state->common.pmu_glob &&
> +           (!pmu_name || !strglobmatch(pmu_name, print_state->common.pmu=
_glob)))
> +               return;
> +
> +       if (print_state->common.exclude_abi && pmu_type < PERF_TYPE_MAX &=
&
> +           pmu_type !=3D PERF_TYPE_RAW)
> +               return;
> +
> +       if (print_state->common.event_glob &&
> +           (!event_name || !strglobmatch(event_name, print_state->common=
.event_glob)) &&
> +           (!event_alias || !strglobmatch(event_alias, print_state->comm=
on.event_glob)) &&
> +           (!topic || !strglobmatch_nocase(topic, print_state->common.ev=
ent_glob)))
> +               return;
> +
>         strbuf_init(&buf, 0);
>         fprintf(fp, "%s{\n", print_state->need_sep ? ",\n" : "");
>         print_state->need_sep =3D true;
> @@ -449,6 +466,13 @@ static void json_print_metric(void *ps __maybe_unuse=
d, const char *group,
>         FILE *fp =3D print_state->common.fp;
>         struct strbuf buf;
>
> +       if (print_state->common.event_glob &&
> +           (!print_state->common.metrics || !name ||
> +            !strglobmatch(name, print_state->common.event_glob)) &&
> +           (!print_state->common.metricgroups || !group ||
> +            !strglobmatch(group, print_state->common.event_glob)))
> +               return;
> +
>         strbuf_init(&buf, 0);
>         fprintf(fp, "%s{\n", print_state->need_sep ? ",\n" : "");
>         print_state->need_sep =3D true;
> --
> 2.52.0.rc1.455.g30608eb744-goog
>
