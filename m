Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E206D40F8F6
	for <linux-perf-users@vger.kernel.org>; Mon,  9 Mar 2026 17:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773078973; cv=pass; b=sydGX3VKLj5nzmKGXaYCQCbSYBv2fp100gp/u7QfJIgjxX5o4g5+aLI6JMV9MmuUaAA67xBsAAD262wypAYidTXffcMOkJNoiOEamzVraJGXgjJv07gTkhFyW1iKG7LD7YPKvNSHWfIL12MUXrTIxei/WOWMnR9RNJXsFpBzGJE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773078973; c=relaxed/simple;
	bh=h+/4DZvdFjdZvTikaC3AlhbGhNWEZcA48r6UYxyTE/0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oEfQ7TxqgJj61ofpZMYe3AeWivIb+DrZNvS4ie1d20GzQ7JANRPAc45M6Uje4mlN/qRcJDhZ/nf+pSQY9zMCdikw+cz6xYpX4QLKoK+TT4o38n4cbCuPSgEn+dpl7khYn8z0Cvwq0ezL24A1ONLJIqvldfV0r9Ts+odHRUSrSb8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=U11uiaOy; arc=pass smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="U11uiaOy"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2ae49120e97so16305ad.0
        for <linux-perf-users@vger.kernel.org>; Mon, 09 Mar 2026 10:56:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773078968; cv=none;
        d=google.com; s=arc-20240605;
        b=jfKVpk6ASe0vcJrn0a/i7bOWZexFwLaBOH51Q+LVIiTdmh3PtxkDtEQZJ/dJaFVOEB
         r06gVYsH79rVzPObkhKsjTaJYq7PSFFYT+d4n45RhbDFKDMB9KgDZPZjWymwi+2oVTvC
         YhXfkqniiBccQJt8N3ohYcupIHX0ubVvpf9vGDt97Sj4SlxZ2zeXN8uKLwYA6cgnN1C6
         NipvwDThU3QMvMkNvVsJohS/VaIqbtM8ELKzppYMNK2SiU0PILFdqW8kyLbWrseRiFuP
         j7rTVZsxNMpUp2P40ma4xj95IO7X9nvOOUS2EY7se6i5TY0JA+x5RrhAeVizGaw1mTSk
         K9BQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=sEzDXhUVFO4MvSKwYYet5FlMfGg8jYj3MEwBCZj/ctI=;
        fh=rMl7OrnzHsdbJ21LdDV7tADFeEIFUDU6TADufMovLhY=;
        b=CV+IzESi/flVpRTeD15z9zM2xSCQBxi5WG5RtwU7bRTJubUC70BDqVtS2s539g0Fzp
         GfeHTmj437BE2clCC3M1vkw3DKcFdbD/yrU9TKPhCuObRa/x45LcmUM4XIzqd4j0cHKq
         RheK9UWUI418q+SavPdEWH+ZMovWTYNpArPsy6ZazFJqKZMAd0aRu1EAeEUIEOIsMXrK
         AFcN4pEP9mtZCVv0BvUUUVSBeHEGQKpQoplH2oWicIXbCb3WRkAr+yM2mw8YBl+cnb2Z
         4M8kGXfuZbhEvApH/wWpz9/VEwvYYs7fNxZ2jJlyPqfo+5DcO/KzGI61j1OtvepjvNq3
         8j6g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1773078968; x=1773683768; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sEzDXhUVFO4MvSKwYYet5FlMfGg8jYj3MEwBCZj/ctI=;
        b=U11uiaOy/jBHE//aNF4E6kzY4MDJjBnaRpkoB7CCpgQ/0iyDEpsr5a1GWNDeVO+d/b
         jwU2txSbFsSlUnpe4P9zQfSMnjyyRA0jqucMrG/wq/N+9u9PKpH15QuFhRjE0FkYy5LQ
         4kCk5XZy7yKebPFSSXyLwsxh2KCFNxi4tqj6yYRWPzv2h8qoM7GKNunt05pHMVIDzoOR
         Ej4SwuTGIecayImrmWIAWqZWpA42WOCw006hMKOrONeZaRGKuHrHM1HnxEB4KDUAQfM8
         lgfXqi5CNtLOlMo6sdzq8gYqcOSORZyBCkEAOUM8z/vV3tK61VdtNhsXIaZCYn2pBR+d
         WptQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773078968; x=1773683768;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=sEzDXhUVFO4MvSKwYYet5FlMfGg8jYj3MEwBCZj/ctI=;
        b=kUIQnC5OpNjQrhvjAZPje79zb1wuirCZrQuWd9+OPP/NtiVfgtwnLJX+dlXSmQnVGR
         +MGHCti/m2Mxlvl6g8GQ0JvPxymi/uoo43GBN87NZj9BYjG5ljPGUtR8hbbGpOq0HoHp
         4XcfZHLv8IBnBEe+oCCEg9I5Gg1K1Yo4Z+qVfxq6dPJB46l91/4IAMZyS4u9hiFqOLt6
         8s07SA2RtGYulcTdu5GEy0uuZ1CD4KifP1I4+2TFXUjR06G6KRT41V4VOPCw4R8a8pSC
         kNS8zlXQzhicLoux81JK0dupHVLsDuOYV29vETW5T9FOinELI9SBF5tTKi8k1K53oGlC
         zEQg==
X-Forwarded-Encrypted: i=1; AJvYcCUy7scNKjL7tWVuE0dKDhjKEYb0GelscbH8sm7H+JPALmPYL2v637ydm4ShWhbceiQHvf/TNhIacmobyx9yMX4c@vger.kernel.org
X-Gm-Message-State: AOJu0YyJImUopBYJ9nuNLLAVzmCYw9w/SrTsHlrRXj9rH+6AkskylY8f
	UbCJr019Gk6eMaLVMihv7l3aY+ih1NvQom/C5d23H8ig/9ZUsvH4zTjjvEFK+HIk8oP6gEUEw7r
	48ls1ac8OE3XTyMHP/mGjioePn1+ptlZaqr/AKXPC
X-Gm-Gg: ATEYQzwTA85iqWFb/0DK6DMS30pJvh1qowyPjaRmb7gL4eEUXYu8wLWzcxRG3Dpxiwb
	ulZDGMHKPbLy8CkgJXgzvLNBHXPMzT0jiR4DBqWl8aEjh89Q7h2J/DRj9ChzvPitKI3hQhH/Ztw
	ib88sEnWD1D4lSXVNlxgKWeSiJ+kC0RwHJN9LJV+dltE2/LzkaEYWfJxDy6jwCI4R7nY1VpCuxO
	nOaIk5vbarevRT3HlSZQSQLBuOPkdw0SbQvra0/EnX617m4uS9Kq6WxSRtbFnduGnws+fRvKLfG
	8l3sWep7Qgrst8pQUxKte9ykHVi3n3Gb32s=
X-Received: by 2002:a17:903:22ca:b0:2ad:6f9b:3b2e with SMTP id
 d9443c01a7336-2aea32bfe3fmr148395ad.23.1773078967464; Mon, 09 Mar 2026
 10:56:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260308-tools_build_fix_zero_init-v3-0-6477808123b7@arm.com> <20260308-tools_build_fix_zero_init-v3-12-6477808123b7@arm.com>
In-Reply-To: <20260308-tools_build_fix_zero_init-v3-12-6477808123b7@arm.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 9 Mar 2026 10:55:56 -0700
X-Gm-Features: AaiRm51Xb31ugKo9S_MPmrA2EHDpcWCZuqysgwYrJ9m0CLzFNaO2kRL95jSSXGo
Message-ID: <CAP-5=fXyH=AZO9XEhXG_X0D+ikAyBmHBUXvDB8ivoJVF2ccjBA@mail.gmail.com>
Subject: Re: [PATCH v3 12/30] tools: counter: Append extra cflags
To: Leo Yan <leo.yan@arm.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	James Clark <james.clark@linaro.org>, Kees Cook <kees@kernel.org>, 
	Quentin Monnet <qmo@kernel.org>, Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nsc@kernel.org>, 
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Daniel Lezcano <daniel.lezcano@kernel.org>, Zhang Rui <rui.zhang@intel.com>, 
	Lukasz Luba <lukasz.luba@arm.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, Masami Hiramatsu <mhiramat@kernel.org>, 
	William Breathitt Gray <wbg@kernel.org>, Barry Song <baohua@kernel.org>, Qinxin Xia <xiaqinxin@huawei.com>, 
	Bartosz Golaszewski <brgl@kernel.org>, Kent Gibson <warthog618@gmail.com>, 
	"K. Y. Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
	Dexuan Cui <decui@microsoft.com>, Long Li <longli@microsoft.com>, 
	Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Willy Tarreau <w@1wt.eu>, 
	=?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>, 
	Josh Poimboeuf <jpoimboe@kernel.org>, Robert Moore <robert.moore@intel.com>, 
	Len Brown <lenb@kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, 
	Tejun Heo <tj@kernel.org>, David Vernet <void@manifault.com>, Andrea Righi <arighi@nvidia.com>, 
	Changwoo Min <changwoo@igalia.com>, Mark Brown <broonie@kernel.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Gabriele Monaco <gmonaco@redhat.com>, Shuah Khan <shuah@kernel.org>, 
	Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>, linux-kbuild@vger.kernel.org, 
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev, bpf@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 8, 2026 at 9:48=E2=80=AFAM Leo Yan <leo.yan@arm.com> wrote:
>
> Append EXTRA_CFLAGS to CFLAGS so that additional flags can be applied to
> the compiler.
>
> Signed-off-by: Leo Yan <leo.yan@arm.com>
> ---
>  tools/counter/Makefile | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/tools/counter/Makefile b/tools/counter/Makefile
> index d82d35a520f610260abb43f6ae28e56d73268231..c0628677af3807bdc331ce2db=
a92b4e5f1a25b68 100644
> --- a/tools/counter/Makefile
> +++ b/tools/counter/Makefile
> @@ -12,6 +12,7 @@ endif
>  # (this improves performance and avoids hard-to-debug behaviour);
>  MAKEFLAGS +=3D -r
>
> +override CFLAGS +=3D $(EXTRA_CFLAGS)
>  override CFLAGS +=3D -O2 -Wall -g -D_GNU_SOURCE -I$(OUTPUT)include \
>          -I$(srctree)/tools/include

The append should probably happen last to allow the default values to
be overridden.

Thanks,
Ian

>
> --
> 2.34.1
>
