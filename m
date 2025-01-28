Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFB841DE4D7
	for <linux-perf-users@vger.kernel.org>; Tue, 28 Jan 2025 17:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738084057; cv=none; b=jNrPtgGqhMDIu0srmIa6BQ/u0uh/HCUI42EDQqoP3BUJ4OtHvheOxnQ0qYEs80+hTlmFq8kWUL00HG6lMt1dz4RtXZrAzQ30Pi2ME2YW5mjmu9/6QP5OAsNZbsaTOucF3wosC9xsU1i2LVd9gp4FHdWzpi+Yc1cCIAP6sH8RluY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738084057; c=relaxed/simple;
	bh=4QZjfjwtypOzv4eWYyhgnkDIy1k6NPJz7TMz5Ji/MKg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IlPRhsiLPMrWyF1AIemD9vivZjqoMeHZumuSDkgvjFXzD7yK8x5eZ0B4JJJ9bZPASDNdMtCnaM+GWR0mYeSWtIGSTU2aZ1/QWHV60ksjafKz235I7Jz+WWmuTQvW1lwLMsPXBwRNhL0G2hdA/EpE9k2x6lhFqR7zBU0fW2d9Qjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1sNikPK5; arc=none smtp.client-ip=209.85.166.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1sNikPK5"
Received: by mail-il1-f180.google.com with SMTP id e9e14a558f8ab-3ce82195aa0so182605ab.0
        for <linux-perf-users@vger.kernel.org>; Tue, 28 Jan 2025 09:07:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738084055; x=1738688855; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Mqb0eF52tLOf535IH2ZAlQGNEQed25STncU4jrdtc24=;
        b=1sNikPK5pxuqgadM/V8U++zL8ZCMVrrCxTK+OKWLGr5TYtmd8mrcGgOWaxgtzqoAPN
         B0ScARbTOvhL0ikQ19Ck7zm4XOOCCj1WqPDWvOzPLTC7hKdXfzJIKRs3v7KnO/jhqf1g
         A4lglJZLNJxPNf5y8hMCgXcgoH2cvDhg3lghNp1l9tw+uzHJ/NjBxLcDmbWx3bhf7u6T
         idK4HVA1u06rGuKTlluACn6m4XGlyahRAXP+cXsVIkkORsyNG5VvEH28SbnU/AT5JHwU
         6lgD+JOj5zw9dhdF+hkE4M3DTZx3zgMlcj1FSuGvPKXeNUHBVfn0qd09escjzJPjdfk1
         7a9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738084055; x=1738688855;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Mqb0eF52tLOf535IH2ZAlQGNEQed25STncU4jrdtc24=;
        b=KipJ5izy/v2K+g03Fu+svEKvcOYAeYlJwo3bnRI5cbYrW1h1NoXbA8JcB5PZa67qxe
         gQNwXDu5nbV9OxkkOTk0UX5VQrsD8iXriym9qsdctyTsB+zdthe4HKqX5Ue5NF4sZWmA
         Ta7un+jl91tsXLoLThwXFjHNYaruQDYcne5cNiMGVGC0A0dTPtwFEd7iDBT+RwmtCFST
         cEQDhalROgrZfz+BEGOfVJS8xgc8m+V2JEjrzWsu2x9RtAlIDtYUCyQAiL+b4hDvJ3OE
         hSTOpprekpu9cQxSjwxN5BqxmbxqUXk7ZvMYeMB9W9SRSHk+nQrrXowm5hjdhDAeHW3F
         QsFA==
X-Forwarded-Encrypted: i=1; AJvYcCUvD9THosHsUdhkdp8YJ2SyiStFQTuQzPdr4xVkPENtTS1QLGzkbSkqxF3vO957IhguZQDAehKecIznSmtPefF+@vger.kernel.org
X-Gm-Message-State: AOJu0YwyO0WPtTt9g/ps9lhgzPksQseP3hpC9aF41Kd9r9wjuXGyg85r
	mwMItBWSwOf0OY5HpyQDXcwJlpQwzd3F2PRwGVmU3t/+PwtQ0xotAuCOYS7yCz2CD9APzhOzuWg
	Z6u9rvKjV6mwrvECa8ib8YJRm8go+k6HyG0Cn
X-Gm-Gg: ASbGnctE9ttR1J+iieafSeMgCYSXpbP1J0yzXU5xiQNYD8yOWQmyEGHJm9HjC4dB7f4
	GXTy6ywRh7RnjHMUXRaze3BWrjieUsZMpf+kNrvWwnTQgXdY/9/sbAILDIUBgSeJcnz01HvZoQO
	4GbBrU/sVufqxP+xp9umN5DhdP
X-Google-Smtp-Source: AGHT+IE++IfbABMr8Knlx22ERyR1iGSVpXRIQnDLXP82JJCUJbs4KEt52VzKCZpG6nprwKAddlIDZ1fxUt45eORpFkU=
X-Received: by 2002:a05:6e02:1b0e:b0:3a7:dcc1:9936 with SMTP id
 e9e14a558f8ab-3cff5b5388amr3134755ab.23.1738084054579; Tue, 28 Jan 2025
 09:07:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250128130647.4029185-1-tmricht@linux.ibm.com>
In-Reply-To: <20250128130647.4029185-1-tmricht@linux.ibm.com>
From: Ian Rogers <irogers@google.com>
Date: Tue, 28 Jan 2025 09:07:22 -0800
X-Gm-Features: AWEUYZmM4dLWwnSPOZLGKk4dWZsEDVNmh9paIJnKn-5kv1JfyoPO12ytxl7-TKs
Message-ID: <CAP-5=fVbZGnRcRbAc+kQyKn5aKdpWkSzVemERpiV2kncxnQ6pg@mail.gmail.com>
Subject: Re: [PATCH] perf test: Fix failing test case Session Topology
To: Thomas Richter <tmricht@linux.ibm.com>, James Clark <james.clark@linaro.org>, acme@kernel.org, 
	Namhyung Kim <namhyung@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	agordeev@linux.ibm.com, gor@linux.ibm.com, sumanthk@linux.ibm.com, 
	hca@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 28, 2025 at 5:07=E2=80=AFAM Thomas Richter <tmricht@linux.ibm.c=
om> wrote:
>
> Test case 37 Session topology fails on s390. I bisected this to
>
> commit 05be17eed774 ("tool api fs: Correctly encode errno for read/write =
open failures")
>
> When perf tool is invoked, it builds the perf.data file using the
> following function sequence:
>
>   #0  has_die_topology () at util/cputopo.c:223
>   #1  cpu_topology__new () at util/cputopo.c:302
>   ....
>   #9  0x00000000012a5c7a in perf_session__write_header (...)
>         at util/header.c:3774
>   #10 0x00000000011ccd64 in session_write_header (...)
>         at tests/topology.c:53
>   #11 0x00000000011cde9c in test__session_topology (...)
>         at tests/topology.c:215
>   #12 0x0000000001190276 in start_test (...)
>
> The function has_die_topology() checks for existence of sys file
> /sys/devices/system/cpu/cpu0/topology/die_cpus_list
> which does not exist on s390. This function returns false and
> information for all CPU dies is omitted in the
> perf data file section HEADER_CPU_TOPOLOGY.
>
> Later on the test case reads the perf.data file back using
> functions.
>
>   check_cpu_topology()
>   +--> perf_session__new()
>
> the missing CPU die information in the HEADER_CPU_TOPOLOGY section
> causes the id_die field set to 0 in the session->header.env.cpu[0].
>
> Later on when the test case result is verified, the functions
>
>   test__session_topology()
>   +--> check_cpu_topology()
>        +--> aggr_cpu_id__cpu()
>             +--> aggr_cpu_id__core()
>                  +--> aggr_cpu_id__cluster()
>                       +--> aggr_cpu_id__die()
>                            +--> cpu__get_topology_int()
>                                 +--> sysfs__read_int()
>
> Function aggr_cpu_id__die() reads the die_id from the CPU's
> /sys/devices/system/cpu/cpu0/topology/die_id file entry.
> This file does not exist and function
> sysfs__read_int() now returns error number -2 (ENOENT).
> Structure member id.die has value of -2.
>
> This new return value of -2 bypasses this check in function
> aggr_cpu_id__die():
>
>         /* There is no die_id on legacy system. */
>         if (die =3D=3D -1)
>                 die =3D 0;
> and the test verification fails in:
>
>   TEST_ASSERT_VAL("Cpu map - Die ID doesn't match",
>         session->header.env.cpu[cpu.cpu].die_id =3D=3D id.die)
>
> Output before:
>  # ./perf test -F 37
>  37: Session topology               : FAILED!
>  #
>
> Output after:
>  # ./perf test -F 37
>  37: Session topology               : Ok
>  #
>
> Fixes: 05be17eed774 ("tool api fs: Correctly encode errno for read/write =
open failures")
> Cc: Ian Rogers <irogers@google.com>
> Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>

Thanks Thomas, there is also James' patch which I think is equivalent:
https://lore.kernel.org/linux-perf-users/20241218115552.912517-1-james.clar=
k@linaro.org/
and my longer series:
https://lore.kernel.org/lkml/20241216232459.427642-1-irogers@google.com/
which is what I'm carrying in Googe's tree, although James suggested
corrections.

Thanks,
Ian

> ---
>  tools/perf/util/cpumap.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/perf/util/cpumap.c b/tools/perf/util/cpumap.c
> index 27094211edd8..05ced29385f7 100644
> --- a/tools/perf/util/cpumap.c
> +++ b/tools/perf/util/cpumap.c
> @@ -293,7 +293,7 @@ struct aggr_cpu_id aggr_cpu_id__die(struct perf_cpu c=
pu, void *data)
>
>         die =3D cpu__get_die_id(cpu);
>         /* There is no die_id on legacy system. */
> -       if (die =3D=3D -1)
> +       if (die <=3D -1)
>                 die =3D 0;
>
>         /*
> --
> 2.48.1
>
