Received: from mail-wr2-f35.google.com (mail-wr2-f35.google.com [74.125.225.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15D894CC262
	for <linux-perf-users@vger.kernel.org>; Mon, 28 Sep 2026 13:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.225.99
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790602970; cv=pass; b=OkvzJujaZL6Ljw+Aof0LSI8ekPrQr8OdGfA2t+tX1w/3gJlUAMARxOH8CSxWMOao5UAwQR+IgCifyjZhH9TYzlQgq5l1t3dbKf+EQXoN0XA06B53yfPvlJUxYSagBQCSBf14wgNoq6ve2/FuO6CwIhMo0JUTCjH1HCWZIOzyVqU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790602970; c=relaxed/simple;
	bh=/nDI86/KM+ocuhtUm25HoH+LB5OX5lxCX1zJ59Hdx0k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=A89ZLhV+hOFWk9XdSUN8MNpk4XVw1qR3VYhSd9hmsQTmD/5/3OEP1Wllpp5HTrgGs9UBS5Sgn1CWiuJGGfly0GlTVbvCNui6fomblxx2FRjLu2dzuR9p0LNsbFOcqgkjYntD77h65itvEzbAaFM8+Lq5XUn2ZAxTrvqh6oSIRQI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org; spf=none smtp.mailfrom=brainfault.org; dkim=pass (2048-bit key) header.d=brainfault.org header.i=@brainfault.org header.b=QS25UlXO; arc=pass smtp.client-ip=74.125.225.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=brainfault.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault.org header.i=@brainfault.org header.b="QS25UlXO"
Received: by mail-wr2-f35.google.com with SMTP id ffacd0b85a97d-4888129c46eso1639508f8f.1
        for <linux-perf-users@vger.kernel.org>; Mon, 28 Sep 2026 06:42:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790602966; cv=none;
        d=google.com; s=arc-20260327;
        b=EVn1Rg7b8xUsbIWWXUOig5b50ClVuDsnUJ/vBMEnudc8knXigOGZeOWLAlgmPamKXq
         7htP428LNjkwZsTGpWgH0mZknekrZXgtAaqVpL4FhixjA02MBaEfuK4NE4447Osrx2OA
         TP4kZR1VQz0kyc0XFrDVrKkl37vfUXut5dIDkinzdTFXRXtwpS+s58i6APCZxxmyN+bO
         3pmkkuMw6IRcezmOB8yJOPhIImjmvTjnrAeIwFErQjhnqi/sWjWxBWSKHL+Bo4kwJXvK
         k3bR87B3hPRJZbvwv8Q18aIBZowfkjvnUTEqd7D67ayuuywIvRUn4sXnUO8l+3l+SfNC
         G5cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=VoieX7gEf9mbaFA2GdnHRYMTOfTM4g2UWo3J9oxSSuw=;
        fh=8P8pi1k1GVUlRm4eB5BPVT1cYH/3GqV0g9nnGwtuRNo=;
        b=NzNKVMGdAM4ghAmLL5Sd1w1i1EV0gci6IBp3VqaK9jxoIo+itWsRa4/cYBY1hzeALX
         yfsdATnU5vBCdejkRA3O6OnOuQU6AVK1hFHXAQZCuNtRDLBOLYIHE+3FnQ68vdDJbo7Y
         zWxE2PZbQrsZLDosOqJFk4JOHIJcjBA5gxAOBIakb6LalWGkgGxA5sBaDj6L/Bm3bbjr
         vgS+gy0tJDuo8Q91j9aJW0mXdV3Wu1YW8hJ7s/d9+ASuFAkQROr1Pb8StE+NFHTgy7wk
         ivrBXmJwxws0LBwclvz91q2uCTf8s6lcrYcmFJGf6uj1Ir6tlCUjg0KfElndYNAY0JmN
         BB7g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault.org; s=google; t=1790602966; x=1791207766; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=VoieX7gEf9mbaFA2GdnHRYMTOfTM4g2UWo3J9oxSSuw=;
        b=QS25UlXOULfXTZ5yFVEi5uYs7XD9DCFLgGZqQCwrYtxy5rbuCbKZGeR7/Vhs9uXuxu
         CoDgftKPzHnPE5nZ3eRgOyvEgSG1yyUSXKCWHZoa5FCi9pluZVKMoh6coj62AFANV/9B
         2C8ANBIEL4LAICbZyZ0Z0pQoFJWE3ejQZK+yv/wWoclw8/4AIBD/Htr6lejSoifFliRC
         mnaUTjtU/lkT4mPxXSW+aWgG9CP8WzpFqW0mO0u7vW+FWNwy9tMNTogAYn3q7LTWGIRg
         LOCz0+OzuecRlUvDlfy7iO9Gk635BYOqOvPgOVdn6I4AhLZaQw+ZEYhlxJQfM9DXDUG7
         H0gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790602966; x=1791207766;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VoieX7gEf9mbaFA2GdnHRYMTOfTM4g2UWo3J9oxSSuw=;
        b=s2XYRcS3CF5JN6DcodG5BRMWgQo5KdYRnGBClSycSI3nWU/KwS8sFLy2E9yjrkLL02
         wcVxpKvHMtVU2Ae3I7A0dvG9X4pBM4DrLUyTShOjVreY9N8f2Ynbci+e5FSy98yGnT9e
         JHl5VpuKuJUmXtLhMc13Z2n/Hf9mh089rMabJ7ecChKD4RCP+gjra2qZddN9ICYjffQT
         +cOsvGhUxj5XBNgp+L8tgYaCAb6TwXEmH6jOqc5UH2kA46izLIQepdpDaUAwZRw66omy
         4DrU7hETCMZNrzDqeae87RdVTCdqTQVK81dKtYWzkY55sOQe2RU+e4J8rk3i8QgcamSR
         hKrQ==
X-Forwarded-Encrypted: i=1; AKwUvBy/wZhUo/XLvunNsUnwn+uJ2J3PyVbakOvrI0O3+bqAobTv8KHPsrodknfwgQUI/vESO+zp2N8J0LWrkhR5By6w@vger.kernel.org
X-Gm-Message-State: AFq9FYL8mbh77PolklMqCx1ivcCzc3RfLuVLLwbkVon+yXpZdlgGeX/N
	MZON/kMoB1hEWOgz8U5Uwu0aSqUo0veQ+YYDgnu6Z2GUmfS2UQV+cpquGHBxTdbS3zJDjFrw09f
	sF76JW2G6xMEkhEY5wYo+Y41ewdMZAVhLjfbSuFlGjA==
X-Gm-Gg: AYBFou3nw1fcjsFGdnjEfkEmglHfOn1wVt+ofEpGWpfM6EwV8ez/FFuo8Dni9En6CEB
	TaXTK+WyGE69Gzkavv0HC+Yxjq5d7SjGBy6Wnb4gchbL+PwRFjCyl4GQx4mrriZ4tOM9JVVhN4+
	752gH3mnR2e2g/rug8Mv8SHo3OxiJFouIC0+SFuPBUFnORGZT29RJ0EgFtd0bSCSD3cgBUknJnm
	JAy9lXiDHqS1RAbr3zebgaPIlz3QXLqPpJS/Jlv5rueZWHMaJpGTcPnzef2yRPFX2WsLJBzwa8q
	7PvnASsPUOWDzHAAbUcbUHSjqhA4FupEj93UTvN42lyj7zuHqPoIpLT2lyTT9pESvkxNSo622W+
	r66S6jol7VD26SwHEM/+rqQPKLdkRWzS4XJUjSERMakFl8UfQvu47LoOkn0BsSr5cHzUlpee2yD
	8=
X-Received: by 2002:a5d:5d0e:0:b0:488:7f1d:2735 with SMTP id
 ffacd0b85a97d-4887f1d288amr19321423f8f.57.1790602965883; Mon, 28 Sep 2026
 06:42:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260928094739.2605-1-cp0613@linux.alibaba.com> <20260928094739.2605-3-cp0613@linux.alibaba.com>
In-Reply-To: <20260928094739.2605-3-cp0613@linux.alibaba.com>
From: Anup Patel <anup@brainfault.org>
Date: Mon, 28 Sep 2026 19:12:33 +0530
X-Gm-Features: AclHuK-74TWd3BjhOYFsGW8F1pliz-aGiiWKp_r2qgxigINlZVJkaGpvr4QoqNI
Message-ID: <CAAhSdy0n7P+UP8M7pge7PHp_aifSsxqcsh8ahTEYjfUO8wengw@mail.gmail.com>
Subject: Re: [PATCH 2/2] perf tsc: Replace the compile-time TSC support check
 with a weak hook
To: Chen Pei <cp0613@linux.alibaba.com>
Cc: acme@kernel.org, peterz@infradead.org, mingo@redhat.com, 
	namhyung@kernel.org, mark.rutland@arm.com, alexander.shishkin@linux.intel.com, 
	jolsa@kernel.org, irogers@google.com, adrian.hunter@intel.com, 
	james.clark@linaro.org, leo.yan@linux.dev, john.g.garry@oracle.com, 
	will@kernel.org, mike.leach@arm.com, pjw@kernel.org, palmer@dabbelt.com, 
	guoren@kernel.org, linux-perf-users@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 28, 2026 at 3:18=E2=80=AFPM Chen Pei <cp0613@linux.alibaba.com>=
 wrote:
>
> The "TSC support" subtest of the "Convert perf time to TSC" test decides
> whether the architecture is covered by matching compiler macros for
> x86_64, i386 and arm64.  That list has to be edited for every new
> architecture, and it can drift apart from the set of architectures that
> really provide a counter: util/tsc.c already ships a weak rdtsc() which
> an architecture overrides with a strong definition when it has one.
>
> Add a weak arch__rdtsc_supported() next to the weak rdtsc(), let the
> test query it instead of the macros, and have x86, arm64 and riscv
> override it in the file where they implement rdtsc().  Support is then
> declared next to the counter it describes, and a caller can tell a stub
> apart from a real counter without keeping its own copy of the macro
> list.  This follows the pattern of the other optional per-architecture
> hooks in util/ such as get_cpuid_str().
>
> x86 and arm64 keep the same behaviour, and riscv starts running the
> subtest because it gained rdtsc() in the previous patch.
>
> Signed-off-by: Chen Pei <cp0613@linux.alibaba.com>

LGTM from RISC-V perspective.

Reviewed-by: Anup Patel <anup@brainfault.org>

Regards,
Anup

> ---
>  tools/perf/arch/arm64/util/tsc.c    |  5 +++++
>  tools/perf/arch/riscv/util/tsc.c    |  5 +++++
>  tools/perf/arch/x86/util/tsc.c      |  5 +++++
>  tools/perf/tests/perf-time-to-tsc.c | 12 +-----------
>  tools/perf/util/tsc.c               |  9 +++++++++
>  tools/perf/util/tsc.h               |  1 +
>  6 files changed, 26 insertions(+), 11 deletions(-)
>
> diff --git a/tools/perf/arch/arm64/util/tsc.c b/tools/perf/arch/arm64/uti=
l/tsc.c
> index cc85bd9e73f1..fd7fba50d0a6 100644
> --- a/tools/perf/arch/arm64/util/tsc.c
> +++ b/tools/perf/arch/arm64/util/tsc.c
> @@ -19,3 +19,8 @@ u64 rdtsc(void)
>
>         return val;
>  }
> +
> +bool arch__rdtsc_supported(void)
> +{
> +       return true;
> +}
> diff --git a/tools/perf/arch/riscv/util/tsc.c b/tools/perf/arch/riscv/uti=
l/tsc.c
> index 7cc4710ac38c..312b0c755439 100644
> --- a/tools/perf/arch/riscv/util/tsc.c
> +++ b/tools/perf/arch/riscv/util/tsc.c
> @@ -17,3 +17,8 @@ u64 rdtsc(void)
>
>         return val;
>  }
> +
> +bool arch__rdtsc_supported(void)
> +{
> +       return true;
> +}
> diff --git a/tools/perf/arch/x86/util/tsc.c b/tools/perf/arch/x86/util/ts=
c.c
> index 3a439e4b12d2..6c01e96b5c2e 100644
> --- a/tools/perf/arch/x86/util/tsc.c
> +++ b/tools/perf/arch/x86/util/tsc.c
> @@ -17,6 +17,11 @@ u64 rdtsc(void)
>         return low | ((u64)high) << 32;
>  }
>
> +bool arch__rdtsc_supported(void)
> +{
> +       return true;
> +}
> +
>  /*
>   * Derive the TSC frequency in Hz from the /proc/cpuinfo, for example:
>   * ...
> diff --git a/tools/perf/tests/perf-time-to-tsc.c b/tools/perf/tests/perf-=
time-to-tsc.c
> index f8f71fdd32b1..c91e22d93b53 100644
> --- a/tools/perf/tests/perf-time-to-tsc.c
> +++ b/tools/perf/tests/perf-time-to-tsc.c
> @@ -22,16 +22,6 @@
>  #include "tests.h"
>  #include "util/sample.h"
>
> -/*
> - * Except x86_64/i386 and Arm64, other archs don't support TSC in perf. =
 Just
> - * enable the test for x86_64/i386 and Arm64 archs.
> - */
> -#if defined(__x86_64__) || defined(__i386__) || defined(__aarch64__)
> -#define TSC_IS_SUPPORTED 1
> -#else
> -#define TSC_IS_SUPPORTED 0
> -#endif
> -
>  #define CHECK__(x) {                           \
>         while ((x) < 0) {                       \
>                 pr_debug(#x " failed!\n");      \
> @@ -49,7 +39,7 @@
>  static int test__tsc_is_supported(struct test_suite *test __maybe_unused=
,
>                                   int subtest __maybe_unused)
>  {
> -       if (!TSC_IS_SUPPORTED) {
> +       if (!arch__rdtsc_supported()) {
>                 pr_debug("Test not supported on this architecture\n");
>                 return TEST_SKIP;
>         }
> diff --git a/tools/perf/util/tsc.c b/tools/perf/util/tsc.c
> index ebf289bf6b9d..815621b1d112 100644
> --- a/tools/perf/util/tsc.c
> +++ b/tools/perf/util/tsc.c
> @@ -113,6 +113,15 @@ u64 __weak rdtsc(void)
>         return 0;
>  }
>
> +/*
> + * An architecture that implements rdtsc() with a real counter should ov=
erride
> + * this, so that users of the counter can tell a stub apart from support=
.
> + */
> +bool __weak arch__rdtsc_supported(void)
> +{
> +       return false;
> +}
> +
>  size_t perf_event__fprintf_time_conv(union perf_event *event, FILE *fp)
>  {
>         struct perf_record_time_conv *tc =3D (struct perf_record_time_con=
v *)event;
> diff --git a/tools/perf/util/tsc.h b/tools/perf/util/tsc.h
> index 57ce8449647f..83e76b207365 100644
> --- a/tools/perf/util/tsc.h
> +++ b/tools/perf/util/tsc.h
> @@ -25,6 +25,7 @@ int perf_read_tsc_conversion(const struct perf_event_mm=
ap_page *pc,
>  u64 perf_time_to_tsc(u64 ns, struct perf_tsc_conversion *tc);
>  u64 tsc_to_perf_time(u64 cyc, struct perf_tsc_conversion *tc);
>  u64 rdtsc(void);
> +bool arch__rdtsc_supported(void);
>  u64 arch_get_tsc_freq(void);
>
>  size_t perf_event__fprintf_time_conv(union perf_event *event, FILE *fp);
> --
> 2.50.1
>
>
