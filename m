Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A546351C35
	for <linux-perf-users@vger.kernel.org>; Thu, 12 Mar 2026 17:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773335954; cv=pass; b=YsR4yJNSuKPNMV0zAmx3w6ZZe5ExhTlL3wUMvvPLPsYg84ng0v5g6GABROGkOkEERfAf9TmTiNU/ULqwdFYCVWBBO5ZDDAVfneo0DkSsYoowdcgppiGcs03OE/URjTsDYhugxUGHTHiO6dw0uob3diMhbIrZjy2UKn7dvz39YgQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773335954; c=relaxed/simple;
	bh=FcuzOrt8CzOV4rxc+ZCEf+asw9BvAvJuhmnBpc7COdY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eKuuwyQLzYBGbn5qft9Ox9aZGEoWpCzEkiKABcb7KjO/Lc9oBv1QkkXHS54GeZA+zmrPCmiZu/ukGLcHqNv5HM68thQl3ojF/trf/UV9QwzMOnQEn8uS/2vBhJcyzrZt2Yn97On60wPwtgVH4XW+PAnYHE46nW/ElZxOBuYOrRc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TeEOCKhG; arc=pass smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TeEOCKhG"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2ae49120e97so6055ad.0
        for <linux-perf-users@vger.kernel.org>; Thu, 12 Mar 2026 10:19:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773335953; cv=none;
        d=google.com; s=arc-20240605;
        b=IcIP/4N+G7evFVnM8+kjffJwJjdbHg4wqMh7NSh/1kpbdPUFrAeqDaSFitqGXXzrXs
         MCqO6LuprJMaMMbsOOQEpLt0Us7ua10WJUiIK67o4be0pkXc50CXbqrdWs+Wsaxgmr81
         q8Uq+yLt9RM5bNANLR7LzIXngXLAQR7Urjn2sCMt6anyoYwGIl/ufCGFMQerr+okMcXi
         6IK6GsmMt0nIEpaNOmApGang3c+7Lp9i+UUV1WLPJG3mEAnZuOxOIZaD4SWs5qUiKJKr
         eO9K2+mmK7+e/wLXc9G77ISnfL9tW3mAXdXyGZ6orqbuVChDfnGX/V9RfKjwBC9nkw9B
         1OLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=tyrqMT1RraqOR3ZZK0z9ezdihjR5JsMGsGUwXou17EU=;
        fh=HpULPgTxGFhiWQ4UNnzUoueK0dTVt0g8bIHWmseizXk=;
        b=d/G89ic/3IS8JDUp2ZNCfB/Qu/I4Tbp8ZkHy4PmFLEC4sYJnQIb28po2U412CFpE8R
         NKrGaJwKWT5YMmYjWhBN37CWBN8KWCAAMslnGidZewxyOYSb2GiGF4rwiXWOsNu3vvEg
         /J3G49Qei4XrZpESIjLGzUfRW/7Ur5COL1JO94Xd4tizEGROxqPt1kjTc36xk9TBf+Ie
         81i8HYpX5eFFOjmh7iyJN8bUXpY42NzN874AarvNtgV0IOggnxmfsf6h/PVkGkh5Mi+k
         jZTwhZarglTpyDSq/PI4EKBR+LLgibaaqHhuXmGScRFGcCay5/fJAiCa6DS0qlOjl8t/
         6cCw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1773335953; x=1773940753; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tyrqMT1RraqOR3ZZK0z9ezdihjR5JsMGsGUwXou17EU=;
        b=TeEOCKhGt63Ay+IiScS+u0phzkgda5ovVrP5FPsTXJtCtUv02MtQY0WKcZTAS3yaWP
         vnn784VqT7e6O4cuZAtsRxMNks48CxpFBrD5YmTlRTdY9F4VaId6HiZZuoovqb0ASixZ
         AGs0G53XEHY5lhDxzpripJ8U0STdlPExPhSiOz4zKmpJwArT1WLb5zdgg1TVerTif1T+
         FyMV5IJ6qKfA5VF6iHcGVWE3Xwccamnjr9klbZvpeQ4pm+n/siVDQxPREgvId9rU+/W+
         mLHzb/D9yZJAjFz0x/huGxGQtGJkRc4dfMIqNA1/WGWXCF8+jd/rX2owEGaAXJiEEGIj
         6vQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773335953; x=1773940753;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tyrqMT1RraqOR3ZZK0z9ezdihjR5JsMGsGUwXou17EU=;
        b=veVsqVOJZmSe/FFCbrlF2WOCr6MTpn6QGBZwSO/QX8k/jA1xcakSWZJwLSsYRYaUWB
         NyabD6ZqLsRGLgTkZ3jYXF5Ur9isn7vBZJGPJiPGFXHASmSyx/wjbE5wm2sQYve7WyPZ
         pCDncmis7KlyO9BAXqoBYfi8bovX4KRoZ4xqqJ6L0OKksE31HnGPifrS2eqTUNiFQ/Pa
         ZNPFU7Iaui6vkwIPejO6nTQpvliwe9Uln7X5iHgHvqpHncdhuSbQXMzFn73CBD31e/dk
         D2Rhwjfksz8UDuvhD1T6SVvcYBuvff3SlE2uxCK5cof2xyiu26t4B5+rQ8EKDYcFGxbF
         FMcw==
X-Forwarded-Encrypted: i=1; AJvYcCWY1Do5Imh2buK9QemY55112diQPyPYS7mKHBOMqyzJujFmzfQ8b5AZVjuNRcNeiAXJvQEtfqfLYdbP/u0amAMf@vger.kernel.org
X-Gm-Message-State: AOJu0Yxv2ACL6/sHZO1UWhetFEm1fAUfNXSEkh3Z5ASwuggoO0nTljJM
	IXuMhXajadBKDtmr0molJPt4UNDbE9f/5+58xNkCdAUq7cClBDoccI7UEC7N/XVbbVoUdzMbL26
	oJb/CcSs7UNVL6y2XYqvNijeUJBhFbvfjkhfAgcLe
X-Gm-Gg: ATEYQzyOPiz/EUfUQAmgDInbwvFAdFld13z61HoMZ3tsAWkI4auXnxn0C3QFxOJs3nQ
	JT+UdKxhDna7EMD+2E6ddzoh+FH/2nAgvSJq1n6RkgFduVI6o7FX+obz0G+OrP2FeOdqZeTwLu9
	aAYebgvzE2A/M6/NvwXwvCO6wr8naOPpO9xLDx70rB6YcluXmzlq7XeKTZcIZOzKWcCwtYxRBoM
	93D8H4R8u2xWr55MDWvMoPJTPfVBlzORgawP3ercDl35EOrSuo1qYaTkbaI1H1+uyIZhho0X49y
	gVA7MgoTc3dWSoDCHhohZ2gZZ9SiES6Bvier
X-Received: by 2002:a17:903:124e:b0:2ae:6432:8f77 with SMTP id
 d9443c01a7336-2aecb880cc3mr9165ad.17.1773335952229; Thu, 12 Mar 2026 10:19:12
 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260311-tools_build_fix_zero_init-v4-0-9e35bdb99cb3@arm.com> <20260311-tools_build_fix_zero_init-v4-5-9e35bdb99cb3@arm.com>
In-Reply-To: <20260311-tools_build_fix_zero_init-v4-5-9e35bdb99cb3@arm.com>
From: Ian Rogers <irogers@google.com>
Date: Thu, 12 Mar 2026 10:19:01 -0700
X-Gm-Features: AaiRm50U3ZuNTb9znfrdFL1Z7R9QSzl9qCksbNeUFXxnNuOwB-32dLFYQSGvW9M
Message-ID: <CAP-5=fUOYsnbB4B0khUetRWOFMtHuO6_ESG30b1ZW01n_-gt6g@mail.gmail.com>
Subject: Re: [PATCH v4 05/30] bpftool: Avoid adding EXTRA_CFLAGS to HOST_CFLAGS
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

On Wed, Mar 11, 2026 at 1:30=E2=80=AFAM Leo Yan <leo.yan@arm.com> wrote:
>
> Prepare for future changes where EXTRA_CFLAGS may include flags not
> applicable to the host compiler.
>
> Move the HOST_CFLAGS assignment before appending EXTRA_CFLAGS to
> CFLAGS so that HOST_CFLAGS does not inherit flags from EXTRA_CFLAGS.
>
> Acked-by: Quentin Monnet <qmo@kernel.org>
> Signed-off-by: Leo Yan <leo.yan@arm.com>
> ---
>  tools/bpf/bpftool/Makefile | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/tools/bpf/bpftool/Makefile b/tools/bpf/bpftool/Makefile
> index 519ea5cb8ab1c0ee31acc67fc5f96b40e21005c2..3e7d8359e1b2a81a29a47544b=
e8539e3b191a0e8 100644
> --- a/tools/bpf/bpftool/Makefile
> +++ b/tools/bpf/bpftool/Makefile
> @@ -81,6 +81,12 @@ CFLAGS +=3D -DPACKAGE=3D'"bpftool"' -D__EXPORTED_HEADE=
RS__ \
>  ifneq ($(BPFTOOL_VERSION),)
>  CFLAGS +=3D -DBPFTOOL_VERSION=3D'"$(BPFTOOL_VERSION)"'
>  endif
> +
> +# This must be done before appending EXTRA_CFLAGS to CFLAGS to avoid
> +# including flags that are not applicable to the host compiler.
> +HOST_CFLAGS :=3D $(subst -I$(LIBBPF_INCLUDE),-I$(LIBBPF_BOOTSTRAP_INCLUD=
E),\
> +               $(subst $(CLANG_CROSS_FLAGS),,$(CFLAGS)))
> +
>  ifneq ($(EXTRA_CFLAGS),)
>  CFLAGS +=3D $(EXTRA_CFLAGS)
>  endif
> @@ -88,8 +94,6 @@ ifneq ($(EXTRA_LDFLAGS),)
>  LDFLAGS +=3D $(EXTRA_LDFLAGS)
>  endif
>
> -HOST_CFLAGS :=3D $(subst -I$(LIBBPF_INCLUDE),-I$(LIBBPF_BOOTSTRAP_INCLUD=
E),\
> -               $(subst $(CLANG_CROSS_FLAGS),,$(CFLAGS)))
>  HOST_LDFLAGS :=3D $(LDFLAGS)

Should HOST_LDFLAGS be similarly moved? Otherwise, it seems target
flags in EXTRA_LDFLAGS will be added for the host.

Thanks,
Ian

>  INSTALL ?=3D install
>
> --
> 2.34.1
>
