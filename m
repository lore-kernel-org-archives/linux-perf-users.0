Received: from mail-dl1-f43.google.com (mail-dl1-f43.google.com [74.125.82.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C046298CAB
	for <linux-perf-users@vger.kernel.org>; Thu,  5 Feb 2026 16:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770310760; cv=pass; b=RYAc4LNQ2IlANikHYvQR/O7BLokl1sGz/qNpN29Up3DdV5Iokn8ncdgZUZz/lHnnRcsrBbIXEkVzgSM+e1F1kFTERTa7dX2KyVozs+PD7hjpNrGzEtzLtBQ9ADkuV0tC3xhcw71UWnu6W/g08whb3TMSW3tLJJjxNaD29V3fHRE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770310760; c=relaxed/simple;
	bh=UXt9LVz1kdx0CRTPWN+OX9MpAIzSGiixz98xzQMcuDc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iJtKydjLVisQ5X2pJUs1B7fIbqQxTRBh84uztaQ2ANlVbyt0hCZNhDeplPbga0i90tpcSmBNGPx+vlkeXAaIOlaNcbluLXU93f0XhgHGMJHEzKTUjwghvd6m6D5Dah14uIeHiZeOhMVuPuMcRNSM7Qp20Moi/vMmLdFGZSoVssw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rOG0yKIk; arc=pass smtp.client-ip=74.125.82.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rOG0yKIk"
Received: by mail-dl1-f43.google.com with SMTP id a92af1059eb24-126ea4e9697so10074c88.1
        for <linux-perf-users@vger.kernel.org>; Thu, 05 Feb 2026 08:59:20 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770310760; cv=none;
        d=google.com; s=arc-20240605;
        b=BN6iqOUcdAVLMmWuPiVOsDSdpkDdKSkc9EXgtrqoKZeL2oWhmcATepD19Ki0BPbfa+
         wANM/rLRo/O43FOJD5l4ktF44Puc8siFtZ9y94gl7+UqcF8vmTOoRz9aP6Y6KsySYQ7n
         V9tbVssgyJWAWv4FPGDKioRyMxr/IQBO5G6C/HMtLxRmSGzsx8oa1/+/l9ipdisozXzl
         79clbW7fOAKWsTqmH4wZ2u6402B3AJcMEbqw+f1kvJIHovyUllJeI3CNYZpQHLzGvsS2
         3YDWl0YEGuntlenjtK54a1wtv8mKuDbrMcEBMwkpmAufwRL0gUWAZslX3Np9dGe1gTkw
         cV3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=IH5kLy7d5c+JXGRDTc9qc+tjf9PpwnWEmoP9i/3+TsM=;
        fh=fbLYvoud5j6yIUcs1XEh9HSeJmBTrpAGlb/xLNc/Ijc=;
        b=Kr9RQ0lOjwhz9nPVRvm0MpGStpzUn0yssjCLvqqfkwXgzQ7vuNWO4hbs5qWm49mLI0
         fPDX+BDnYvNpJU1qXLS1qRaUF/2mWvyilSm+/knRfb1CDHEaUUEHcfMyvL09WblFBfcP
         ZYLdTUWo2WrvDUMuQNbGqDQsrYie0bWW8RgkjGFGcS0YQsoBRB/L3vM3flDjoyR5HdwA
         0VMVRwPMZLtW8GuJFS47aKQCGkUMey7+10kUMmNiRuWvFAEGvXrqcWya9RDgIpzPmZso
         1j3igi5kfc3+ZMtd0YgRt+jGbWmZo3LqoUuWRJEvqHmIzE26fhoE7PF89KJ+51VpVooC
         G0TA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1770310760; x=1770915560; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IH5kLy7d5c+JXGRDTc9qc+tjf9PpwnWEmoP9i/3+TsM=;
        b=rOG0yKIkGP3HzZFVU/ignFkQZO7t7KKOjFTrYphG0654u7kGd52qCESpXyrBtz9/ha
         rc7XVGtTiantn8I+eDdQhd63oGZK2l07xvVmDWHLZkivhIPyxG61hZ+xbTURVF5h/2W7
         Nea0LrcqjbucrNWt4WZWEArG3hNewrCFkAR+O7Ws8hL2d4ZBHiZ+VtuUMhl2RabTrqJP
         MzjWYd90XcOoVzc2S1gSH05qGCNYw8xho46qA1rvRXNz4+WaKeyoPzEotGgJYpV9SuhX
         xEj+W6NYrfryOo6IrRDI+XmjBsJbaHhEnIO4tENI8XFqsTCCLV0b1IkR0bRfk6HODBgr
         5VXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770310760; x=1770915560;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=IH5kLy7d5c+JXGRDTc9qc+tjf9PpwnWEmoP9i/3+TsM=;
        b=L7hA/OGIuN5HkEa/33qEPfh/6jb9h+m5+w/+1FZh1f7F0guP8iZdX8Ynonx/JYCLzF
         2U2WianfRXAJ93Ei2fSkdZ0cmHRFhV+xX+XH9Nxf+C66v9MH2e808vd5VOVU6bSkQQSR
         iqPTeXFxYj9FYHe/hiZ3lmd7cYNnFS1kDupehjCyjo8c1b2AvHkmw2r3QJ26Q/aJh/ti
         H0nhmAOyPXr1P1yzFiQYHqfKMOv+Zc2P7aIKPYnBbUZmvH6lRwunbUlJHXDXwzSP85YK
         jWRR5Fdj8v2lkmrsoNfCgfM2XJAjeCNE+vCP136UvYE3/rEkIGGQtD7tgzwuA0cnbAVV
         3mzA==
X-Forwarded-Encrypted: i=1; AJvYcCWR7TbqQSpdphU9AJHLfAVkZ4TPGyytJ8JcFRFuDGmjPDQEFnVchfT3RWyq4gx7X+Zi9LLpIe65gQdUbiyBTat6@vger.kernel.org
X-Gm-Message-State: AOJu0YwxMJtf7egY7zhR5s6/BKj4jHHR8+F+qv9FkNJb5w5lLQ++y9PA
	dB3/P8R7+Zzw0YTke+GJFvjAc1bMM/9zKF6C+sK5JzqePts4hdwk5AspvPZxnXr/C1c9sUOjFHV
	F9tAPTJxhTs3F+2UytIzmJMk5Zsw9mu7M1iiY6zIW
X-Gm-Gg: AZuq6aLyy4CEyaS46A+tS20XTgSTWdZHZiyjkwSumzT0PTrx7lJac/GA7g2HaifAfO/
	a1fKHz9UkpXWtRTEoOh/r6WyFFEI+krsw5lFUcILmwhrTWLxqUVv1wyX8e8Iy/UI3kVDEB0u7B1
	Z99H16SZU+K6wfauWlFPgEV2mhz02thfm0J2ARnHqd/X9/AqkrcVVQ377bbBca/NN/dvRL5gibm
	8SSJZrTiOTUpO2IN5eVkbtswCdLkrbDO3qBxzzdKmxLM/0PiBjydiaP9fAOGneSPbcqQXVl/5Q0
	jxS9vW7QmszzgY492C+9FVO2rNk1WEW4JK63
X-Received: by 2002:a05:7022:e98e:b0:119:e55a:8084 with SMTP id
 a92af1059eb24-126fd248e83mr139970c88.1.1770310759312; Thu, 05 Feb 2026
 08:59:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260205-perf_stat-v1-1-e433b0c918af@debian.org>
In-Reply-To: <20260205-perf_stat-v1-1-e433b0c918af@debian.org>
From: Ian Rogers <irogers@google.com>
Date: Thu, 5 Feb 2026 08:59:07 -0800
X-Gm-Features: AZwV_QhoIfrDgqZTO2pTv8Wv4A4FDGqOWW6ME1W658Wh2_ZRGSJpgDMeqKYcLkM
Message-ID: <CAP-5=fW2iUbaZRX789SaJNGXk1VhGg0igLukb6SAosKiA-f1tA@mail.gmail.com>
Subject: Re: [PATCH] perf stat: Fix crash on arm64
To: Breno Leitao <leitao@debian.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kernel-team@meta.com, Denis Yaroshevskiy <dyaroshev@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 5, 2026 at 3:46=E2=80=AFAM Breno Leitao <leitao@debian.org> wro=
te:
>
> Perf stat is crashing on arm64 hosts with the following issue:
>
>         # make -C tools/perf DEBUG=3D1
>         # perf stat sleep 1
>         perf: util/evsel.c:2034: get_group_fd: Assertion `!(!leader->core=
.fd)' failed.
>         [1]    1220794 IOT instruction (core dumped)  ./perf stat
>
> The sorting function introduced by commit a745c0831c15c ("perf stat:
> Sort default events/metrics") compares events based on their individual
> properties. This can cause events from different groups to be
> interleaved, resulting in group members appearing before their leaders
> in the sorted evlist.

Hi, sorry for the issue. I can see what you're saying but why is this
an arm64 issue? The legacy Default metrics are common to all
architectures:
https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.gi=
t/tree/tools/perf/pmu-events/arch/common/common/metrics.json?h=3Dperf-tools=
-next

> When the iterator opens events in list order, a group member may be
> processed before its leader has been opened.
>
> For example, CPU_CYCLES (idx=3D32) with leader STALL_SLOT_BACKEND (idx=3D=
37)
> could be sorted before its leader, causing the crash when CPU_CYCLES
> tries to get its group fd from the not-yet-opened leader.

Which metric is this?

> Fix this by comparing events based on their leader's attributes instead
> of their own attributes when the events are in different groups. This
> ensures all members of a group share the same sort key as their leader,
> keeping groups together and guaranteeing leaders are opened before their
> members.

This makes sense but I'm not understanding why this problem wasn't
seen previously. I'm guessing that in a metric like
backend_cycles_idle:
https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.gi=
t/tree/tools/perf/pmu-events/arch/common/common/metrics.json?h=3Dperf-tools=
-next#n63
```
        "BriefDescription": "Backend stalls per cycle",
        "MetricExpr": "stalled\\-cycles\\-backend / cpu\\-cycles",
        "MetricGroup": "Default",
        "MetricName": "backend_cycles_idle",
        "MetricThreshold": "backend_cycles_idle > 0.2",
        "DefaultShowEvents": "1"
```
The PMUs for cpu-cycles and stalled-cycles differ? This may mean we
also need to be smarting in determining PMUs for legacy events.

It'd be interesting to see what events are coming from the kernel, e.g.:
```
$ ls /sys/bus/event_source/devices/*/events
/sys/bus/event_source/devices/cpu_atom/events:
branch-instructions  cache-misses      instructions  ref-cycles
topdown-fe-bound
branch-misses        cache-references  mem-loads     topdown-bad-spec
topdown-retiring
bus-cycles           cpu-cycles        mem-stores    topdown-be-bound
...
```
and the cpuid to match it up with the json.
```
$ perf stat -v sleep 1 2>&1 |head -1
Using CPUID GenuineIntel-6-B7-1
$ ./tools/perf/pmu-events/models.py x86 GenuineIntel-6-B7-1
tools/perf/pmu-events/arch/
alderlake
```
this information is in the verbose output too:
```
$ perf stat -vv sleep 1
...
------------------------------------------------------------
perf_event_attr:
 type                             1 (PERF_TYPE_SOFTWARE)
 size                             136
 config                           0x2 (PERF_COUNT_SW_PAGE_FAULTS)
 sample_type                      IDENTIFIER
 read_format                      TOTAL_TIME_ENABLED|TOTAL_TIME_RUNNING
 disabled                         1
 inherit                          1
 enable_on_exec                   1
------------------------------------------------------------
sys_perf_event_open: pid 608809  cpu -1  group_fd -1  flags 0x8 =3D 7
------------------------------------------------------------
perf_event_attr:
 type                             0 (PERF_TYPE_HARDWARE)
 size                             136
 config                           0xa00000001
(cpu_atom/PERF_COUNT_HW_INSTRUCTIONS/)
 sample_type                      IDENTIFIER
 read_format                      TOTAL_TIME_ENABLED|TOTAL_TIME_RUNNING
 disabled                         1
 inherit                          1
 enable_on_exec                   1
------------------------------------------------------------
sys_perf_event_open: pid 608809  cpu -1  group_fd -1  flags 0x8 =3D 8
...
```

Thanks,
Ian

> Reported-by: Denis Yaroshevskiy <dyaroshev@meta.com>
> Fixes: a745c0831c15c ("perf stat: Sort default events/metrics")
> Signed-off-by: Breno Leitao <leitao@debian.org>
> ---
> Cc; linux-arm-kernel@lists.infradead.org
> ---
>  tools/perf/builtin-stat.c | 26 +++++++++++++++++---------
>  1 file changed, 17 insertions(+), 9 deletions(-)
>
> diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
> index ab40d85fb1259..3a423ca31d8d3 100644
> --- a/tools/perf/builtin-stat.c
> +++ b/tools/perf/builtin-stat.c
> @@ -1938,25 +1938,33 @@ static int default_evlist_evsel_cmp(void *priv __=
maybe_unused,
>         const struct evsel *lhs =3D container_of(lhs_core, struct evsel, =
core);
>         const struct perf_evsel *rhs_core =3D container_of(r, struct perf=
_evsel, node);
>         const struct evsel *rhs =3D container_of(rhs_core, struct evsel, =
core);
> +       const struct evsel *lhs_leader =3D evsel__leader(lhs);
> +       const struct evsel *rhs_leader =3D evsel__leader(rhs);
>
> -       if (evsel__leader(lhs) =3D=3D evsel__leader(rhs)) {
> +       if (lhs_leader =3D=3D rhs_leader) {
>                 /* Within the same group, respect the original order. */
>                 return lhs_core->idx - rhs_core->idx;
>         }
>
> +       /*
> +        * Compare using leader's attributes so that all members of a gro=
up
> +        * stay together. This ensures leaders are opened before their me=
mbers.
> +        */
> +
>         /* Sort default metrics evsels first, and default show events bef=
ore those. */
> -       if (lhs->default_metricgroup !=3D rhs->default_metricgroup)
> -               return lhs->default_metricgroup ? -1 : 1;
> +       if (lhs_leader->default_metricgroup !=3D rhs_leader->default_metr=
icgroup)
> +               return lhs_leader->default_metricgroup ? -1 : 1;
>
> -       if (lhs->default_show_events !=3D rhs->default_show_events)
> -               return lhs->default_show_events ? -1 : 1;
> +       if (lhs_leader->default_show_events !=3D rhs_leader->default_show=
_events)
> +               return lhs_leader->default_show_events ? -1 : 1;
>
>         /* Sort by PMU type (prefers legacy types first). */
> -       if (lhs->pmu !=3D rhs->pmu)
> -               return lhs->pmu->type - rhs->pmu->type;
> +       if (lhs_leader->pmu !=3D rhs_leader->pmu)
> +               return lhs_leader->pmu->type - rhs_leader->pmu->type;
>
> -       /* Sort by name. */
> -       return strcmp(evsel__name((struct evsel *)lhs), evsel__name((stru=
ct evsel *)rhs));
> +       /* Sort by leader's name. */
> +       return strcmp(evsel__name((struct evsel *)lhs_leader),
> +                     evsel__name((struct evsel *)rhs_leader));
>  }
>
>  /*
>
> ---
> base-commit: 5fd0a1df5d05ad066e5618ccdd3d0fa6cb686c27
> change-id: 20260205-perf_stat-a0a2a37e21c5
>
> Best regards,
> --
> Breno Leitao <leitao@debian.org>
>
