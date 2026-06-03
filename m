Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBD7C3AA1B5
	for <linux-perf-users@vger.kernel.org>; Wed,  3 Jun 2026 15:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780499881; cv=pass; b=FnAdk08W/gyqx4Jz5rxXCcXrtmwkr24s6nrbjzRiMrIN9/HH9TL3SWbq3dKp+33Su74dNCaiXxYnheQTXh2aiu/ltdbSVX+bIk5TYlkp2OSKIZB1e4BZJuOCACs7V5GXPGcQrSiTX9g58+kwvsp7NlzyPtkqFLpNyrKS76fa398=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780499881; c=relaxed/simple;
	bh=xwL1Eko0qrL8SNcfMmogPh7rgKXdDENdke0Xud2NPUI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MGt6mmcvvWYXzqHr00fEwe/ghcnt7TSiHTTJofKPegSVPnGbxfKwfu8bYpwxtSkBGqVHYAYZmSGAAyqltt+6t2hkK4/vwuf4C+dzbzen9e1kP63hgzmq7LfVS9GUrbjCvtdpY/rqm0r9PY6TGVhEMR7iGrET8BZ/0/t28k9StuE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=URU7ssaY; arc=pass smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="URU7ssaY"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2bf22c18ad3so103575ad.0
        for <linux-perf-users@vger.kernel.org>; Wed, 03 Jun 2026 08:17:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780499879; cv=none;
        d=google.com; s=arc-20240605;
        b=NVLcyUlwEfs7I4MMihqGynZ2+oS/Gbj4QFbyXG8TQ9Y6k3uTz6oM19vOlbfQo2yQrW
         IzPjCmpI75ABt+3uvQ+KGDE9pARpks796LR701N1SFUM8YaGgUFkq9ptiFQ4vjeKwokj
         I5bl2JPgWLiIHMZYjZAI1D7P6Tilo9RjafWZj29g1Xf9ARgb/VPcb2rDYzp8vdpMWHcW
         8tsLoGxZldMBQ5cDBMDaQhl39FZyctvjFq2sNrkB4MB8zwNJjuP1FwCuNA1dL0i0lSw+
         GHxSXBiYtSI4QNWbNpBI9/Z7mUNXqNBzvCxPaBZiAF+tyUR8m32BfYZZydkdjVcBsAHX
         mMUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=QJw6jKkEoqnuRxGqYPsRenO44HO7wzvYLLCzX43D1FI=;
        fh=j4GExGkeL9Sk+FYBS6CyMHSoF+EcUbdG6zny+igRu/s=;
        b=i8dLBz3ZHUvzAoJ465J0uZWOK/cLJ/F2vIR/yiM/dcSHzK8rlXTeMXFewpq5eRaZKB
         sgsVInxIQRb/ZobcLQoaIT7O8FxX2Xv4hp5vBmSpYzpWVoxZKw+kp8n3Foikc9U7536P
         lw/TcOzby1vq18dxnFN9ByBAbHBLj97p2DC/+9DA5CVmOZkZp8OkfQ4qtrNT2uceQCx6
         PW6DkFvAyCQB4c47oknEoMfmAFZVkBuWjHzOOqgqJ3oEqBmRrKt1rt7apV+2M4NHevFP
         bQ1U2ewLmItuVDJQ01SNnqxC2Gv/Nh5iuLbuQRT0DkUf4vJ7CcAD6vGlotI7G2zWGqM1
         AHFg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780499879; x=1781104679; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QJw6jKkEoqnuRxGqYPsRenO44HO7wzvYLLCzX43D1FI=;
        b=URU7ssaYA+Fw51d8+vSoq5FyeBEzGIRqDK3CTzd/fr1GTnByoaqz7V8qSUvFL9y1q9
         Ev7nE9Z2BpbPPK68nuOZgL1KWEdGJTtCgre1VJxYQU83jR2DbsNkJwrwTaFL5CnF/bF9
         Y28pExAoMcuab2VOFtNU7ARwr0kjEMe/wN4H8HYW0A6Hy0uz6WGOHsYRU424WGwl/Fd4
         P52drKI5k05k+Vl6hUF1CeeLcQQqOWcZMzT4ueD7UZF/yYdSFgN1+bGN0RgLU8DoCOiG
         B/R1L7q6hApldlib7KVkp1dRSP98HaXaDCFgTS6JzsG4oKC5bLC/KMfeuRoWsS3L0tNk
         GtqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780499879; x=1781104679;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QJw6jKkEoqnuRxGqYPsRenO44HO7wzvYLLCzX43D1FI=;
        b=V15dF/EWYpvPuEREgvOBlXh3FrCrMGpupLFhm5hon7blwzO0kZaVpZYd+wJ/OQqg65
         23T9pH0yqEEezTsHZJM4YbS0YMzAzfthyYuRWiVSEjbqi5YEoIkh97/3nPrtXGuYkLUR
         3MG8ZX1/hV9do8XzNnm/jj/Ctt7eOv9oet8PpVEF0WXdadZptDR2VFlOUnWq4cHqdOPw
         nzVJMm+JOYhA7r7Ytx5tN0r0+Dq1KbbigFFIg13QWfxYzve2vbZaaugEyN0+XMe0Dju+
         /39EwlcCiyMqEZdJOB7Q3XDh90j0AEWN69lbiEbq8sUYZQ2gLQ0C0KsvNyGp/iJFhQ2+
         8WOQ==
X-Forwarded-Encrypted: i=1; AFNElJ/KS7f1zku+HWoW1CWAXFPZR1y4gjQx5UznIYovGmXPHR9L8PPmx+xLTZ3MzCq2NB5f76FVyJJBSGj7YPAHddO7@vger.kernel.org
X-Gm-Message-State: AOJu0YwI7LaUJx0RywpgicuqZfKiaFVfNmC9JRl4GjDnPhFf2/KULqyW
	y5BqTsafOvv6H5mzA5mfwMw5bjpdsWBcUi5hqrX5ze7ynPA4OtgNFF7N/a8gS8ptngjZyAkBHnO
	uECrIzdvkDmcpHqcsYizUC29My0fdFVYRooGNJDok
X-Gm-Gg: Acq92OGniQbTjLGXqhebuNd9t3m6ngsIF0oZFPEeKhu5MyQ0I3WEe3sOHAxNSxUriJO
	Ph4v0ttBEljVL7bbeTD0QO/2S4Rplp32fu7KCDYB1K4DWpX6FkMmsp2kqZufqYzFdrI3u86/gnM
	XmQkNJIL8psfOmdXLyHiIE1FkWx2KS+HzTyciFZLsh1wZFmvmYfC5X2UfwUNAkdI3mC92Z87Vcy
	QQo1yUhmmUs6OQjmS7t5QwFf95nuvRTruv37MzaJnbM8z5Iyw5vEQruks+y5Q3AJZctPcKEJerH
	9pjGlzl3eiZxYcFcVZQTYbZMJWunbU9HhOeUUCBQ2Ban/H30
X-Received: by 2002:a17:902:f712:b0:2bf:2e8c:db96 with SMTP id
 d9443c01a7336-2c16fa5e809mr1863615ad.5.1780499878523; Wed, 03 Jun 2026
 08:17:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260602235709.1541603-1-acme@kernel.org> <20260602235709.1541603-8-acme@kernel.org>
In-Reply-To: <20260602235709.1541603-8-acme@kernel.org>
From: Ian Rogers <irogers@google.com>
Date: Wed, 3 Jun 2026 08:17:47 -0700
X-Gm-Features: AVHnY4LzhLmAQEniwXrEs-AI8pZqQYJU78FvHvMy8HEPcC7SKCQtFOfQt2l8Bmc
Message-ID: <CAP-5=fXkczzz2HQwO8mqzn8RRFsXRJD8sGc18_O4m851wdtKSw@mail.gmail.com>
Subject: Re: [PATCH 7/8] perf sched: Replace BUG_ON on invalid CPU with
 graceful skip
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>, Ingo Molnar <mingo@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, James Clark <james.clark@linaro.org>, 
	Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, sashiko-bot@kernel.org, 
	"Claude Opus 4.6" <noreply@anthropic.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 2, 2026 at 4:57=E2=80=AFPM Arnaldo Carvalho de Melo <acme@kerne=
l.org> wrote:
>
> From: Arnaldo Carvalho de Melo <acme@redhat.com>
>
> latency_switch_event(), latency_runtime_event(), and map_switch_event()
> use BUG_ON(cpu >=3D MAX_CPUS || cpu < 0) to validate the sample CPU.
> When PERF_SAMPLE_CPU is absent from the sample type,
> evsel__parse_sample() initializes sample->cpu to (u32)-1.  Casting
> this to int yields -1, which triggers the BUG_ON and aborts perf sched.
>
> The central CPU validation in perf_session__deliver_event() intentionally
> preserves the (u32)-1 sentinel for downstream tools like perf script
> and perf inject, so leaf callbacks must handle it themselves.
>
> Replace the three BUG_ON calls with graceful skips using pr_warning(),
> matching the existing pattern in process_sched_switch_event() and
> process_sched_runtime_event() earlier in the same file.  Include the
> file offset for cross-referencing with perf report -D.
>
> Reported-by: sashiko-bot@kernel.org # Running on a local machine
> Assisted-by: Claude Opus 4.6 <noreply@anthropic.com>
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/builtin-sched.c | 22 +++++++++++++++++++---
>  1 file changed, 19 insertions(+), 3 deletions(-)
>
> diff --git a/tools/perf/builtin-sched.c b/tools/perf/builtin-sched.c
> index 9ec8e049e19b0038..81833d169470582b 100644
> --- a/tools/perf/builtin-sched.c
> +++ b/tools/perf/builtin-sched.c
> @@ -1145,7 +1145,12 @@ static int latency_switch_event(struct perf_sched =
*sched,
>         int cpu =3D sample->cpu, err =3D -1;
>         s64 delta;
>
> -       BUG_ON(cpu >=3D MAX_CPUS || cpu < 0);
> +       /* perf.data is untrusted input =E2=80=94 CPU may be absent or co=
rrupted */
> +       if (cpu >=3D MAX_CPUS || cpu < 0) {
> +               pr_warning("WARNING: at offset %#" PRIx64 ": out-of-bound=
 sample CPU %d, skipping sample\n",
> +                          sample->file_offset, cpu);
> +               return 0;
> +       }
>
>         timestamp0 =3D sched->cpu_last_switched[cpu];
>         sched->cpu_last_switched[cpu] =3D timestamp;
> @@ -1215,7 +1220,13 @@ static int latency_runtime_event(struct perf_sched=
 *sched,
>         if (thread =3D=3D NULL)
>                 return -1;
>
> -       BUG_ON(cpu >=3D MAX_CPUS || cpu < 0);
> +       /* perf.data is untrusted input =E2=80=94 CPU may be absent or co=
rrupted */
> +       if (cpu >=3D MAX_CPUS || cpu < 0) {
> +               pr_warning("WARNING: at offset %#" PRIx64 ": out-of-bound=
 sample CPU %d, skipping sample\n",
> +                          sample->file_offset, cpu);
> +               err =3D 0;
> +               goto out_put;
> +       }
>         if (!atoms) {
>                 if (thread_atoms_insert(sched, thread))
>                         goto out_put;
> @@ -1640,7 +1651,12 @@ static int map_switch_event(struct perf_sched *sch=
ed,  struct perf_sample *sampl
>         const char *str;
>         int ret =3D -1;
>
> -       BUG_ON(this_cpu.cpu >=3D MAX_CPUS || this_cpu.cpu < 0);
> +       /* perf.data is untrusted input =E2=80=94 CPU may be absent or co=
rrupted */
> +       if (this_cpu.cpu >=3D MAX_CPUS || this_cpu.cpu < 0) {
> +               pr_warning("WARNING: at offset %#" PRIx64 ": out-of-bound=
 sample CPU %d, skipping sample\n",
> +                          sample->file_offset, this_cpu.cpu);
> +               return 0;
> +       }
>
>         if (this_cpu.cpu > sched->max_cpu.cpu)
>                 sched->max_cpu =3D this_cpu;
> --
> 2.54.0
>
