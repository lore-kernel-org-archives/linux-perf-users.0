Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7303D3A9624
	for <linux-perf-users@vger.kernel.org>; Wed,  3 Jun 2026 15:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780499670; cv=pass; b=FiFZCFNiZ1Z/yXfbffxyoRioD7RSlmto2aoqrTp8cX10mMxlfbywvAsxHN/7K2hGINxL/7OCVexH3KYytGxKSvh3muJ76BIGyUndsKFvgm0eeAZ3hpzWTt35lrh87tdJhsfw1eBi2KcH9Cpd6QHqyB29gcL60rGFnJxL0b4MPu0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780499670; c=relaxed/simple;
	bh=IN3Xvmsaf3hRep4wib9NAF01UrZ54PvMW16QFYDsJIA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QQ50qPp3oKBh0I+BBu1mDM1dLeVrY7ir4tdZfF0ozD3EE8M3W6VMoMQ/tvqOkO2BDjk/P46hbBbBpT6zzSez2X4ZdziegUgFFglxHQlcDyJD6XKL8MF76QT+wTMmoybog7S8EpUh5uTB+jrW7K90RrBEaNpgKoEn1BXIC8eDa44=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tvI8xoYI; arc=pass smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tvI8xoYI"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2bf2911f93cso69505ad.1
        for <linux-perf-users@vger.kernel.org>; Wed, 03 Jun 2026 08:14:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780499669; cv=none;
        d=google.com; s=arc-20240605;
        b=BNdTvuaMT1HLPpGn+EctTPPPSLzGRytEp5OQ0o62FYEpfuYoMhMQt7M5wCHSyzKm5B
         N+GQbM8/9B6MXmJDzImW7d9bcB2MZeMtGulz2WqA3WPufiK0j9EQUAgHjPEQDr4CuMRi
         UWBhkUImH76eFVf/AVxQ/IT52sLHIjfMIGlvBBVtvh98S8WvYd2q9xVYxX4JqAoXkTQk
         0JKN94GfVp0e1jntfIjvtR/Tdv7qEjncW+fqGiQq32jJfOG2Vd4coAFKXZAB9xE0yioJ
         oDWAu68XzlggQb+WxdYdG2Bp9MgjscWOsPjsu14CCSLlS3G/uLkaQL+PB7rPukbcvz55
         F8RQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=fo/V5/gQ6EEpDh3ToeIMSy+/IyweNKtGox8Dqnz87fA=;
        fh=/HI+D5G2Ho407EW/wJKAnqcpyNHCt4bDVwipUyCe4bY=;
        b=D8jVAFs19mCu3Ue1ImEUTfZD3HFL3HdqIEgGtvE4WSgMrcbayDR9cbMZjA9p0/37D6
         pBiEEOr35n1CrQk4ktH6w2m/MKMDM5maRpW+5oDBwYaXj3htGE3mV5vZjbCsuymii9Tv
         zjO0FyaX1N8a52sG0ZWbxJdY8rsYQeuYbrtjLHlsjwXiHS/cDYD4RLH/vxMMoxTJDg2s
         4QO7TSRJeFrzzt1UkuWY085YqGcK9FF/x41aoFioGDAxeEVW5TvJ16ideGdoarZOZ+D9
         vpYvXYXMDHsQdWEq1gdnX6EF2bZ6MBBDoDZmct1b5WBRwU16Xb31yhXiWp6URPVV09wx
         etTg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780499669; x=1781104469; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fo/V5/gQ6EEpDh3ToeIMSy+/IyweNKtGox8Dqnz87fA=;
        b=tvI8xoYItp4moYoaP9CnQT+dpNIWJQhanIUl+wpLGbWoVa0X9zDH0kIn/Z07ih76Sc
         WyrJUoL9wQf66XRNtPpzWxUCftk7jT6Gij2ceC9QP9QInN4jWVnpExFG5Tfak3zI/IE1
         FoGpJYamwZEZHuX6N1f0ou06Mi6YFLI6MuHaRKl9BQJ12jv0RHOicKYPJKUiNkeZGUiB
         9n+887pRBihtR457a++yxfetACXTmkX1oJp3ygPR0lLYUeYrIbv8xSnPz8i6lAcUKnL1
         ERLW6m1n9fwUCvE6nY5/eXGgnllVNXPUrexiVrE6oJEpKQdR9D50IZXhIqOWiaSRvUeg
         R7oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780499669; x=1781104469;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fo/V5/gQ6EEpDh3ToeIMSy+/IyweNKtGox8Dqnz87fA=;
        b=mpQxaHz38g2im7XHApoQ9Erm0ktIOzXf1Rnrokfx3jNWNHiqDoK9o4kwHEDPi9knMq
         Q2VCV0ILHhkrWh7kBJY0kcWbRHPeSMRR1zeYLuYvOEP9+PLAGJ/Yqpw8eEqq394Lbw+5
         wVrt+DAjdLakGm+CW0Iz9e4IgT48wCCT0s5UtQy2ji4OYP5j2ElOgbXfJnyt03WoA51v
         AFGc+sRI122T8lqGuOu++aAK1HIXi468Xb2KcCZbcAB18dY+aTYYjLZ06o6LJrZardLx
         l1zEcRPaHVTZlRg0kKJM3qN6GMTF2GRZUV+lSojDX75TUPGTYpoN7fPLb2aI3UQ0e2ch
         hI3A==
X-Forwarded-Encrypted: i=1; AFNElJ/b0xJv2QrTLV+tINs1ipYpRMA2/iy+F6llJlq+dQ+/Lq5aKDJSVWhnJJGKTAgnide3SjNp31SoNka67eTSU6bT@vger.kernel.org
X-Gm-Message-State: AOJu0YyFq7TlCiRQqeZkln5ZOengL9KgSW/TNxpRUzVFC/VouG5GHJs7
	Q53+D6soOBbwG9kfKkdCxb14zvM6tNvO8F09a1rLul8tPqk2S+66FTQzgjt4+vZizxyWWtet/iZ
	/nY4sC6nfH5AzgXnGLCskyrV+tpJp6N/HCvd5ZPtg
X-Gm-Gg: Acq92OGPmIwYgSEDyIa9ej4HEmsDlrlJcIMxO7Orsbi1UbnjEultffUygtFLNW6pSet
	gIEsCUs17D2Av9/5WqFlhALhYYdz20qJ1Ye9oaClwxSVBalcDBkdsdcqNJo/6x0zeWrXs8ySZ/j
	ldtZcbeSAGx1+sTunH2TlXN7EJmERXneuVm0NugaPhQqO63uFvLNNBycE665/+T/sn8IQwS+oz3
	rYtWHbRMjKpSRcrjL1RsvZFXDAFBNcNXvIyoEIw6IORXbB+G7P8MHv/XmV11utllzKgXfgOg88D
	YuwU4Vv1kR4MU3njh4pv4c8qKJ5E0HGemW164ieI/axaC3ss
X-Received: by 2002:a17:903:8cd:b0:2b0:b925:da98 with SMTP id
 d9443c01a7336-2c16fb41f7dmr1553475ad.19.1780499668221; Wed, 03 Jun 2026
 08:14:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260602235709.1541603-1-acme@kernel.org> <20260602235709.1541603-5-acme@kernel.org>
In-Reply-To: <20260602235709.1541603-5-acme@kernel.org>
From: Ian Rogers <irogers@google.com>
Date: Wed, 3 Jun 2026 08:14:17 -0700
X-Gm-Features: AVHnY4Ik1zqk7139y6Wx5BT4W8zFNjy0kjhBY6vwJIOBQ1SpGnvT1Fl45RJJ5Bg
Message-ID: <CAP-5=fWTkZwhq9bOTc+Lz_1UgOw92Egtp=DJQykY4UUZju3ELA@mail.gmail.com>
Subject: Re: [PATCH 4/8] perf timechart: Include file offset in CPU bounds
 check messages
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>, Ingo Molnar <mingo@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, James Clark <james.clark@linaro.org>, 
	Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, 
	"Claude Opus 4.6" <noreply@anthropic.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 2, 2026 at 4:57=E2=80=AFPM Arnaldo Carvalho de Melo <acme@kerne=
l.org> wrote:
>
> From: Arnaldo Carvalho de Melo <acme@redhat.com>
>
> Add the perf.data file offset to the out-of-bounds CPU debug messages
> in process_sample_cpu_idle(), process_sample_cpu_frequency(),
> process_sample_sched_wakeup(), and process_sample_sched_switch().
>
> Assisted-by: Claude Opus 4.6 <noreply@anthropic.com>
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/builtin-timechart.c | 19 +++++++++++++++----
>  1 file changed, 15 insertions(+), 4 deletions(-)
>
> diff --git a/tools/perf/builtin-timechart.c b/tools/perf/builtin-timechar=
t.c
> index 630756bebe3242dc..071987241a528ba4 100644
> --- a/tools/perf/builtin-timechart.c
> +++ b/tools/perf/builtin-timechart.c
> @@ -605,8 +605,10 @@ process_sample_cpu_idle(struct timechart *tchart __m=
aybe_unused,
>         u32 state  =3D perf_sample__intval(sample, "state");
>         u32 cpu_id =3D perf_sample__intval(sample, "cpu_id");
>
> +       /* perf.data is untrusted input =E2=80=94 cpu_id may be corrupted=
 */
>         if (cpu_id >=3D MAX_CPUS) {
> -               pr_debug("Out-of-bounds cpu_id %u\n", cpu_id);
> +               pr_debug("at offset %#" PRIx64 ": out-of-bounds cpu_id %u=
\n",
> +                        sample->file_offset, cpu_id);
>                 return -1;
>         }
>         if (state =3D=3D (u32)PWR_EVENT_EXIT)
> @@ -624,8 +626,10 @@ process_sample_cpu_frequency(struct timechart *tchar=
t,
>         u32 state  =3D perf_sample__intval(sample, "state");
>         u32 cpu_id =3D perf_sample__intval(sample, "cpu_id");
>
> +       /* perf.data is untrusted input =E2=80=94 cpu_id may be corrupted=
 */
>         if (cpu_id >=3D MAX_CPUS) {
> -               pr_debug("Out-of-bounds cpu_id %u\n", cpu_id);
> +               pr_debug("at offset %#" PRIx64 ": out-of-bounds cpu_id %u=
\n",
> +                        sample->file_offset, cpu_id);
>                 return -1;
>         }
>         p_state_change(tchart, cpu_id, sample->time, state);
> @@ -641,8 +645,10 @@ process_sample_sched_wakeup(struct timechart *tchart=
,
>         int waker =3D perf_sample__intval(sample, "common_pid");
>         int wakee =3D perf_sample__intval(sample, "pid");
>
> +       /* perf.data is untrusted input =E2=80=94 CPU may be absent or co=
rrupted */
>         if (sample->cpu >=3D MAX_CPUS) {
> -               pr_debug("Out-of-bounds cpu %u\n", sample->cpu);
> +               pr_debug("at offset %#" PRIx64 ": out-of-bounds cpu %u\n"=
,
> +                        sample->file_offset, sample->cpu);
>                 return -1;
>         }
>         sched_wakeup(tchart, sample->cpu, sample->time, waker, wakee, fla=
gs, backtrace);
> @@ -658,8 +664,10 @@ process_sample_sched_switch(struct timechart *tchart=
,
>         int next_pid   =3D perf_sample__intval(sample, "next_pid");
>         u64 prev_state =3D perf_sample__intval(sample, "prev_state");
>
> +       /* perf.data is untrusted input =E2=80=94 CPU may be absent or co=
rrupted */
>         if (sample->cpu >=3D MAX_CPUS) {
> -               pr_debug("Out-of-bounds cpu %u\n", sample->cpu);
> +               pr_debug("at offset %#" PRIx64 ": out-of-bounds cpu %u\n"=
,
> +                        sample->file_offset, sample->cpu);
>                 return -1;
>         }
>         sched_switch(tchart, sample->cpu, sample->time, prev_pid, next_pi=
d,
> @@ -676,6 +684,7 @@ process_sample_power_start(struct timechart *tchart _=
_maybe_unused,
>         u64 cpu_id =3D perf_sample__intval(sample, "cpu_id");
>         u64 value  =3D perf_sample__intval(sample, "value");
>
> +       /* perf.data is untrusted input =E2=80=94 cpu_id may be corrupted=
 */
>         if (cpu_id >=3D MAX_CPUS) {
>                 pr_debug("Out-of-bounds cpu_id %llu\n", (unsigned long lo=
ng)cpu_id);
>                 return -1;
> @@ -689,6 +698,7 @@ process_sample_power_end(struct timechart *tchart,
>                          struct perf_sample *sample,
>                          const char *backtrace __maybe_unused)
>  {
> +       /* perf.data is untrusted input =E2=80=94 CPU may be absent or co=
rrupted */
>         if (sample->cpu >=3D MAX_CPUS) {
>                 pr_debug("Out-of-bounds cpu %u\n", sample->cpu);
>                 return -1;
> @@ -705,6 +715,7 @@ process_sample_power_frequency(struct timechart *tcha=
rt,
>         u64 cpu_id =3D perf_sample__intval(sample, "cpu_id");
>         u64 value  =3D perf_sample__intval(sample, "value");
>
> +       /* perf.data is untrusted input =E2=80=94 cpu_id may be corrupted=
 */
>         if (cpu_id >=3D MAX_CPUS) {
>                 pr_debug("Out-of-bounds cpu_id %llu\n", (unsigned long lo=
ng)cpu_id);
>                 return -1;
> --
> 2.54.0
>
