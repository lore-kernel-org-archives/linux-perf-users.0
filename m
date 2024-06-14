Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54A0E9460;
	Fri, 14 Jun 2024 13:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718372875; cv=none; b=hh2Bd+9dr5IrY01aPF43nIlB5KnjEnfO5uhBDhYuw2K63naK9h8qC4SK87y0CMsFuUR7fljr9Y89hSE23hsGcAzvcKues8+70k9usO5x7nmL3TGY6ZNdLFNK3IGO+qz6lx+/3yCLo7QJDNIPaAwD9U8pVftMY+kihbG3FNN6/ZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718372875; c=relaxed/simple;
	bh=1aZksGUp8fLgwOWNQFUHylne4EqFbmCyrS3QmoLiH8g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RozzewteCF+/KazmlGGh0THZcA7lfQkpTRnJlQYuOjc12jG7UZUV2l4QBSjvs4a/9lEPgaXBsLYsYtiqbPBvEULwcr+VLWoha4GAeY01RtYqzmHMfhbfvk6eBmeUlYePLFOX2vi3lwuntz7oGa4o5VsIFRKHGAzNVizcGPqq0UY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1f70c457823so18282125ad.3;
        Fri, 14 Jun 2024 06:47:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718372873; x=1718977673;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FZPLXCovA6tOx8EtxF21Zr80qSMU7lHz0lsliYvpAQ4=;
        b=IfAcvIQi4jYHMKctQtoR9O+3zGM5oiyhus+mrGWf53vFLXddc3SShIos56Ak4t716E
         dYTQ3Xi+CPt88Ig9NKevroEhf3DRUJO2taXo8+PnhBiUh2teyQPpZDszRVqJN29ydtwP
         p53Fsa9Iu4ZO7E09hHscZPUA6H1JVjWMKdvHvZS7V+cVihkpJNZTBLjmhoyKLMqnOhDq
         Gsb79m//yAjACrGNR7yhgWV3+9ayYyLCLWmMQSB2S2GdKJvDOEWSmg7YMVDzucQOzbhJ
         a7I/udXyLvWEOA61o92fBB61XI2pF6VGhug8SO20v+rtiubkL2KCceTLkM2zPItMgTZv
         fhoQ==
X-Forwarded-Encrypted: i=1; AJvYcCXRyaYisizilA5uff/hkx15cdESbAXHLcTSJLIR3ZuO/RTbrsEKr/n/dcHisBqRSXRIkdJraG+hpi69mbbZ8DvbV22k3Uk3lfqJgCdw
X-Gm-Message-State: AOJu0Yy6KPAQ62LBiomGE7j47o/XhAU7rqDiGJli64zpuhwZBCWjpvnA
	bdQdhuCyhCsMlSq28aFMfbspQhW4QqBeraNtaZc0192s7FDrYO1avBhcPJ7sHRiP2iphA+hjebD
	EI/TFW8TOcR35ILIUDr1HeOlrWJY=
X-Google-Smtp-Source: AGHT+IGqYisqr6N/qTpubTKsyCIzPOsj+J+8M/m56EvEBdCWAjklU3BuWRyrgT55xP61Z2DfTNgcC5zBXsBcwmTctBc=
X-Received: by 2002:a17:90a:b00f:b0:2c2:d813:bffa with SMTP id
 98e67ed59e1d1-2c4dbd431b5mr2778121a91.43.1718372873526; Fri, 14 Jun 2024
 06:47:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240614073517.94974-1-sieberf@amazon.com>
In-Reply-To: <20240614073517.94974-1-sieberf@amazon.com>
From: Namhyung Kim <namhyung@kernel.org>
Date: Fri, 14 Jun 2024 06:47:42 -0700
Message-ID: <CAM9d7ciYQ9C0_zgwWYt505+Mv56EC7byqxBXkPgGydomrzTHcw@mail.gmail.com>
Subject: Re: [PATCH] perf: sched map skips redundant lines with cpu filters
To: Fernand Sieber <sieberf@amazon.com>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
	Madadi Vineeth Reddy <vineethr@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

On Fri, Jun 14, 2024 at 12:49=E2=80=AFAM Fernand Sieber <sieberf@amazon.com=
> wrote:
>
> perf sched map supports cpu filter.
> However, even with cpu filters active, any context switch currently
> corresponds to a separate line.
> As result, context switches on irrelevant cpus result to redundant lines,
> which makes the output particlularly difficult to read on wide
> architectures.
>
> Fix it by skipping printing for irrelevant CPUs.
>
> Example snippet of output before fix:
>
>   *B0       1.461147 secs
>    B0
>    B0
>    B0
>   *G0       1.517139 secs
>
> After fix:
>
>   *B0       1.461147 secs
>   *G0       1.517139 secs
>
> Signed-off-by: Fernand Sieber <sieberf@amazon.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
> Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>

Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks,
Namhyung

> ---
>  tools/perf/builtin-sched.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/tools/perf/builtin-sched.c b/tools/perf/builtin-sched.c
> index 7422c930abaf..aa59f763ca46 100644
> --- a/tools/perf/builtin-sched.c
> +++ b/tools/perf/builtin-sched.c
> @@ -1594,8 +1594,6 @@ static int map_switch_event(struct perf_sched *sche=
d, struct evsel *evsel,
>
>         sched->curr_thread[this_cpu.cpu] =3D thread__get(sched_in);
>
> -       printf("  ");
> -
>         new_shortname =3D 0;
>         if (!tr->shortname[0]) {
>                 if (!strcmp(thread__comm_str(sched_in), "swapper")) {
> @@ -1622,6 +1620,11 @@ static int map_switch_event(struct perf_sched *sch=
ed, struct evsel *evsel,
>                 new_shortname =3D 1;
>         }
>
> +       if (sched->map.cpus && !perf_cpu_map__has(sched->map.cpus, this_c=
pu))
> +               goto out;
> +
> +       printf("  ");
> +
>         for (i =3D 0; i < cpus_nr; i++) {
>                 struct perf_cpu cpu =3D {
>                         .cpu =3D sched->map.comp ? sched->map.comp_cpus[i=
].cpu : i,
> @@ -1656,9 +1659,6 @@ static int map_switch_event(struct perf_sched *sche=
d, struct evsel *evsel,
>                         color_fprintf(stdout, color, "   ");
>         }
>
> -       if (sched->map.cpus && !perf_cpu_map__has(sched->map.cpus, this_c=
pu))
> -               goto out;
> -
>         timestamp__scnprintf_usec(timestamp, stimestamp, sizeof(stimestam=
p));
>         color_fprintf(stdout, color, "  %12s secs ", stimestamp);
>         if (new_shortname || tr->comm_changed || (verbose > 0 && thread__=
tid(sched_in))) {
> @@ -1675,9 +1675,9 @@ static int map_switch_event(struct perf_sched *sche=
d, struct evsel *evsel,
>         if (sched->map.comp && new_cpu)
>                 color_fprintf(stdout, color, " (CPU %d)", this_cpu);
>
> -out:
>         color_fprintf(stdout, color, "\n");
>
> +out:
>         thread__put(sched_in);
>
>         return 0;
> --
> 2.40.1
>
>
