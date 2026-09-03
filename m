Received: from mail-qk2-f12.google.com (mail-qk2-f12.google.com [74.125.230.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87DDB38E5E9
	for <linux-perf-users@vger.kernel.org>; Thu,  3 Sep 2026 05:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.230.204
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788411870; cv=pass; b=KmgYblb7vtMdTu6ljgwzUMdDxrMtv+WUfLlw/BwkX3Zh581Rke9npJ3wue+yOu9HFffPMLlclBjX6tTuM5bVnWh64uQG71LwCCou+6op7YJ4hzTEhnoDNEcTOwkzXnDykj6oRV2HezHe4CLUUHgl9DBluMYeWrgR62IVRoFQnY0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788411870; c=relaxed/simple;
	bh=sgnNYk9h4pIk4/DDM5OnPDb+W31jLGx6uPQ1r12d9qk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cHQFEMX2vU2lUugvuGhyQirL3DOC4KkfZZDDOxIpB3gk9nHwmV4hQuUNUyTR7mrgJzkO308U5u160MLM/FMGv9hYOhGImgjoXOTHKnxhPyc1EMWPdWnDl0w/TmMBi41cL0OE8N4olJJh5FXdMTSsLYxf8Wff3F+MG/QkRLIICwo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NvqnI8zH; arc=pass smtp.client-ip=74.125.230.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NvqnI8zH"
Received: by mail-qk2-f12.google.com with SMTP id d75a77b69052e-52e843c64b8so75221cf.1
        for <linux-perf-users@vger.kernel.org>; Wed, 02 Sep 2026 22:04:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788411866; cv=none;
        d=google.com; s=arc-20260327;
        b=NyTcVTIKhh36NUR0W96skQAgKu0hUPEgufYnJqXV6ygQjp9uH38234e406TgRxspdS
         MS9sxPCgFeUQqmDN+Qo6VedEHyrY9lbjmewvBD7dEzCReiP1b7Erc/u91GF/9IPXNY9a
         DX4bh0ddfx9p1N2XdacaPHX3fCI/WjUlj/fP0ROrwJiYTp4fGmqdd7XkGFODg/j3/ekp
         +wmlRHkA+Rq9m+6XBGKcSQv/w4riHdPA/Atu6T/Id7NL2RACAclqVR85LnxjcL+gJvyB
         lXvs0sXPOBNvYBVUyn7xG/7QjoWDtVew9gR3D6XixuN5g4RTGYczL5qR3QtkicUFGAhQ
         XjFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=KPklHbxXeJDxNdoiQqefpW644DYAeavucLCni6Pnx4I=;
        fh=+ARk5vqASeXIouPoh1xiU7DkPInMPvyeNLnsh/xj+7I=;
        b=S72PyFGMfU9ZF7ba6roqTgbznfDr1yxz8S4BSrry8N5R8AAhu88Y9p0LZrPpL4KHLB
         1BJ5vrHOh6d1y520NTn88EYqHYanDfGzv1AIK5sd7tlnWZN4wm7+ciay4RMKqZ8pkUTG
         4yoMw4u+5lZNXTXgNl1/kb0njpqdKx6rz62S9EkJwFBizsUhD32J4WVC4EUu4ntFkS8f
         /Dv1B3Zai0EDfDxzetF7itZjbHxz0TbMMEz7K3LIkgBDvvgcRrmEWpLsE4JgrsZfQasX
         gtCeZ4feSQ0ElTregDighxuYsaHgNiZZKQrXksdcoAUrEA1OMnC3Ozb3jrIQjx/d5R9c
         unIg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788411866; x=1789016666; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=KPklHbxXeJDxNdoiQqefpW644DYAeavucLCni6Pnx4I=;
        b=NvqnI8zHm4vu/modJxNV6hv9e5OHlBSLoCaC75QIhr1jz9vKbaviy6DoxZBwSBA2xj
         OS8RJgy+7fWmPAghHn1dZx2DOqODzHt6b6BIsKZplkmicWJ7qxUqa3oN0JJuUazWeAfG
         cPIc15UUNBDC2egC9o4+7YUW4n/9Al29+AnPib0FZSmu+YcDdiBPXx0A88bZoO9L8OMg
         zlFRW2g0F+vaVFHcKoNp+t66RS9h6/cGZv3HDQkcEKW7BkAmZO9wt2k36iTv858udJmx
         a+MPUpCjuJQaHG9EyhoDLv+UuOREgKCAIarZW+WNBYlD7YzoLs2QtSHaWNDGx3hxVp3u
         sT8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788411866; x=1789016666;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KPklHbxXeJDxNdoiQqefpW644DYAeavucLCni6Pnx4I=;
        b=T8qYQCtW9weJTUOKW15UZXkNcutXJSWIwDoBOkgDzBhj4W7x4+aF1sDkx5EDvz89V3
         ijUGayWXqzDU23CE2XDTTEL8KCeFGN8RHjy1mLY7+F998K20LL+ryINxN/+pDGHEXUgP
         hN1/eZRuSNQwPsyR40GWkmUWu4YpdBiiWy5s8HVm4eDLU0Rt7ruvi+R2xzo8mc7IYA6n
         lJRvOkZ4mBmm2y7R+xoAfOVemnkhTwRQwryN48+7iLm4whp47OQD1LRD/4JCC9+UaYp7
         Niae+UfVk3KRaTwd6N0fnZvEzI8WwqzZc+B2PPnE+fx39QyfErHnqR8Tt8NeRb8QcVMJ
         n4+Q==
X-Forwarded-Encrypted: i=1; AKwUvBxwCcmMUoKbn8t3LG/5ZbNF5gzPRQLe9QHlhwOEP5KDTYdzZC/9qNLeBbJC7/9FxLs7p5dkMimol4/XR+g1rS6i@vger.kernel.org
X-Gm-Message-State: AFuF++nmmuwVX8T6r4xEVTzZh9CZoDb4fr4aLnfIbJX6wwm7mxpDYKIs
	Mf9C5pqq8TbHHBrC2otSw/14tCHK2xu800EWaaVcFeuKEQ5h1TmEmrrWEQ20oPJ/mx7CxKiO4Ex
	zJOTMY00ELZSnH9zVNV/SA1EndP/ZntybwN/rlGEx
X-Gm-Gg: AYBFou0RFbKj3nwKENj47xGI9OJq+reRttzlWs5MOTpOoeZILniknD3drIbhyloUUQR
	ggfeWunHB4xiEBH+ajg20tH7DpjpB7137Aovq/a4BemO8zJW9SjE3KsSLv2PLHpB0saUr59gJdr
	+AXiFuSjNYnRtb6f8QCpfVlxrWXvHFXBI1ze6OvSX1MsJ82sy6yZ+HXUUDoZJNmynSHOBZz+MGk
	Q+LzYXmjDD/pDcGlEfij7Econk4OBGuTUAqK22UIBNFVfsCFvtl4JO/rj5bz4M0sveLVW/vMFzS
	ZrXQwtAGGzsHWlQuKvN4hrUcj6Lc5b+7OgtrQhkV+0/FcA==
X-Received: by 2002:a05:622a:a0c:b0:530:2f98:cebb with SMTP id
 d75a77b69052e-53045879fdamr7780491cf.11.1788411865734; Wed, 02 Sep 2026
 22:04:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260902093210.3571958-1-nylon.chen@sifive.com>
In-Reply-To: <20260902093210.3571958-1-nylon.chen@sifive.com>
From: Ian Rogers <irogers@google.com>
Date: Wed, 2 Sep 2026 22:04:14 -0700
X-Gm-Features: AcwNN1WOa23S96LNVp309j3VaLFfZ9MpfJyynTE8hrogcm-8TGXhXoba-fFjNmc
Message-ID: <CAP-5=fUzqFPfN+xH8uqERugK9xsauUoxZTVr+YLGGXVRi6UC9w@mail.gmail.com>
Subject: Re: [PATCH] perf bench futex: Define SYS_futex on 32-bit arches with
 64-bit time_t
To: Nylon Chen <nylon.chen@sifive.com>
Cc: Namhyung Kim <namhyung@kernel.org>, Arnaldo Carvalho de Melo <acme@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Thomas Gleixner <tglx@kernel.org>, 
	=?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>, 
	Davidlohr Bueso <dave@stgolabs.net>, Palmer Dabbelt <palmer@dabbelt.com>, Alexandre Ghiti <alex@ghiti.fr>, 
	linux-perf-users@vger.kernel.org, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 2, 2026 at 2:32=E2=80=AFAM Nylon Chen <nylon.chen@sifive.com> w=
rote:
>
> The kernel does not provide sys_futex() on 32-bit architectures that lack
> a 32-bit time representation, such as riscv32. Consequently glibc does no=
t
> define SYS_futex there, only SYS_futex_time64, and perf bench's futex
> benchmarks fail to build:
>
>   bench/futex.h: In function 'futex_syscall':
>   bench/futex.h:77:18: error: 'SYS_futex' undeclared (first use in this f=
unction)
>
> Define SYS_futex as SYS_futex_time64 when only the latter is available.
> The guard and its comment are taken verbatim from
> tools/testing/selftests/futex/include/futextest.h, where they were added =
by
> commit 04850819c65c ("selftests/futex: Define SYS_futex on 32-bit
> architectures with 64-bit time_t"), keeping the two futex userspace heade=
rs
> in sync.
>
> No timespec conversion helper is needed on top of this. glibc lays out
> struct timespec on 32-bit architectures with 64-bit time_t as
> { int64 tv_sec; int32 tv_nsec; 32-bit pad }, which is compatible with
> struct __kernel_timespec, and every futex_wait()/futex_lock_pi()/
> futex_wait_requeue_pi() call site in perf bench passes a NULL timeout
> anyway, so no timespec ever crosses the syscall boundary here.
>
> Note that an earlier and more ambitious attempt at this was
> commit c1ff12dac465 ("perf bench futex: Add support for 32-bit systems
> with 64-bit time_t"), reverted by
> commit ba4026b09d83 ("Revert "perf bench futex: Add support for 32-bit
> systems with 64-bit time_t"") because it included linux/time_types.h,
> which is unavailable on older distributions. This change deliberately
> avoids that dependency and adds only the one guard needed to fix
> compilation.
>
> Signed-off-by: Nylon Chen <nylon.chen@sifive.com>

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/bench/futex.h | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>
> diff --git a/tools/perf/bench/futex.h b/tools/perf/bench/futex.h
> index fcb72d682cf8..6df8837b365b 100644
> --- a/tools/perf/bench/futex.h
> +++ b/tools/perf/bench/futex.h
> @@ -14,6 +14,17 @@
>  #include <sys/types.h>
>  #include <linux/futex.h>
>
> +/*
> + * SYS_futex is expected from system C library, in glibc some 32-bit
> + * architectures (e.g. RV32) are using 64-bit time_t, therefore it doesn=
't have
> + * SYS_futex defined but just SYS_futex_time64. Define SYS_futex as
> + * SYS_futex_time64 in this situation to ensure the compilation and the
> + * compatibility.
> + */
> +#if !defined(SYS_futex) && defined(SYS_futex_time64)
> +#define SYS_futex SYS_futex_time64
> +#endif
> +
>  struct bench_futex_parameters {
>         bool silent;
>         bool fshared;
>
> base-commit: 66498c75b4f8017f62d720d9b59675bdf3abce91
> --
> 2.43.7
>
