Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC2FE2C11D1
	for <linux-perf-users@vger.kernel.org>; Mon,  9 Mar 2026 18:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773079572; cv=pass; b=b3XIl4uXl6mIFkfQ9EXfCi+R45F1FYhJpHk0Fb7zemGrwdKvoORX1+exqu1+jl58AuoA8G1dMwMC46eye5pcKde68UtKgSzoYSoHxTY+6Sl2FTe69zSgABqbz/IHnLmyrUUdREXPLtUIHAegeVcsic0VmJAwzn9HuUTIh/FtmP4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773079572; c=relaxed/simple;
	bh=42c9ZH1wrf48IJ9g6TUsDx3jUDNj6OlA/w9q9LS4OsQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nX19plBuE3JrSPFeqIj7o6c8PZYc/6msf+xqNFUiuQrjbc4m5gxElC6WzhDxzk9FBpnJ1nGhQWUwZsoIFvqs52hYfp4kvEgAL2qdHRFezc9YLRbsZHT/yVROtxJ8VP1DYHttuVrkvvDoFIOUQzXS4S3nyEnt1aLQSwDVcgDJiDQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3lqW/qjJ; arc=pass smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3lqW/qjJ"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2ae4b40999bso17665ad.1
        for <linux-perf-users@vger.kernel.org>; Mon, 09 Mar 2026 11:06:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773079570; cv=none;
        d=google.com; s=arc-20240605;
        b=Rdd6vxvHvM2Gr29LgDAdVi3MTz5Sc+xZNZdekUYjIwOGmJ6WuyGl19xM1TQLWPbHnI
         K3gwRdU7ZXKRD5SoH+/XIlYtqKpmvXF9YYjWV6fGKHccQsbhY2EW2Z864nNzyF5f7AR7
         Aki3BXEMriYxo9IcfyGtiLGb3mKilUVdVrTM1zWaXIeaelpOhZNHXLInYkl6Sv/65iRz
         R3ZLc0Gf4JPFL8dMHvvkuTsV7ooPgTAsI/rEQd+0Jh0/oRE0mvIcnHZiw8zce4l5rv2T
         6nlmjyHRRK2uzFQ0N0WwBr2g6z0UrdkypiSpa3TMW5QT/XIu/zJb2ttsUA+BboGU1ymQ
         AH2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=a8XdeGKgfNmQ0ihM13m4/+pDXEjwuXh/6MDXE3f2Ssk=;
        fh=8wpxwfyHNvh7YFoBXe7wpypkA61q0KgURKmDZWIzFZ4=;
        b=RKay5W2Y968e8KB1sbm8mnwGLBNF/NmBTUxI7vhIqblRcoN7StyGZlSp3EbDeahiGM
         IjmqJ5SdqQSMpT4ZUpGe+aE0TR23d/K9rKqR+sri2ohuqLA5nEjYHUbFeENQWKwmxR0C
         bs26z/sh7eGefmaeSXiPw3G3/eE3v990RYDDLYCqq8aI5lgIThFCQqJb3BsvGT0mXh5N
         2Qx2PtMHX7tYRJW1Ri10KPRJRE0vuGUBgYkV9/QZAlpPTr06VgCQrd3fOY4o9nHkRMjS
         lJmyqVGTUFfJGBYGjAq1bujt6GqNIrns6jBH2T6UlOruusVdb6nLDzR3pCWpoBLaZtDl
         FNCg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1773079570; x=1773684370; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a8XdeGKgfNmQ0ihM13m4/+pDXEjwuXh/6MDXE3f2Ssk=;
        b=3lqW/qjJ/A40fgCTjx+nk1JEN4FD2Iejutu4MU5MSH7QIu9fUP5EzC6c22S5eiLWoA
         fIPC/+TAB4YVfQl4Ag+xsG9JgbEf4aGTh7cPhdLuL7A+9DRwZuHvTYmYqLcQiujE4VNL
         B0RusBXunN0H6DY5ingObMA09KqUhKP7RwJ65c8SRtBu0xcS9qLIaMew4N0tg5JJQzv6
         MUmRdiIiE1Vng3/5S5vZDO+SEfqoDPqzC0b44j1P1XBWXSlNAbpx/G+U6oS6M28eGFCO
         xYs8cUYQeNcpM4ngkyzKJdIfCIdhU4ZJcuXOkob39fc3P25eREVwoYrVHMKuU9WEwU64
         LXGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773079570; x=1773684370;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=a8XdeGKgfNmQ0ihM13m4/+pDXEjwuXh/6MDXE3f2Ssk=;
        b=u22PCDh+Rp9iqZ3YLyWYu9tBJOW+x6jSer0yxpNNqLqqiAbu4OLeUF63O7/cG0kRl/
         3BMo9ABRH6NeBCmMSvRW8pd4GERKROOkKYdtB82ZQbNVTEzmOdFRVOeN0a0mbBBRRbuA
         HFOYp6LwjnK0zi+XFpGt4poovNoWuNZO3u2IDSSOMOEqhy64CzA5eF1xx5AIK/yTHj5j
         IngfRQfSA4OjG+rnQuPpdhdP7kDyQJKkxwqIDr7bvlT3sZaAsJIziE81YyY2EXP2VM1D
         NsZiV65OvbsWc35t9Iv4jNrK0SvryEWX2FkjtcnWmvH3Kr6qOqesCKq9myZU5PMZG11x
         4eNw==
X-Forwarded-Encrypted: i=1; AJvYcCWVhZTZSs63QVAAk8JGcDaPGKFEEUrS5GQLg96SEPt6wpuucz9TABLR4f+5+ADKTaTi4Mj0Vf1DQs9mqnTWoh4G@vger.kernel.org
X-Gm-Message-State: AOJu0Ywt6qxtprUNSD5AWb7T0O0mrB2bp9XZ6ktgezRYjqKPtzaxRnm8
	drKIOSHuSIoVUB116lsOZucddZ8lQ/mMK4ZUpO2wmtbvaFEG8PegF/Pr5Vk59tFKsi6NORi7sX0
	KjLWSaE0SLH9sIerj7iXYBXmP6RdFJHDQmE+lfrYG
X-Gm-Gg: ATEYQzy+PFTvZknz4tfyTBSTFcD6SSBb7GkSaIa3j43tv+C/gMmutIjUOt6U7S32vqr
	0DSSX2v8TENWhWi4ebBB4ZUpKYpV7OsYjrlCAF6HX7L6AN1wuwZRtytaIwVihFh4TrxeyZCiRVM
	u3q6ngC4cKIUz6zWaUzCXBTzUdb49S/y9hEelAMa1twqPfo5Jp9sLOb7zA6bRLCcii5hgE1pxoK
	FerOEtyrPZjnMn2Y0upNbQyYb9rizLOMj0Jmvzr354lHnfNqsVvay4OCQhno1aCIJecy1lTEUOA
	MtwrY3SCUlZv52eOSjukF9Ox4qFzymE+5G2AZK7fpGclPw==
X-Received: by 2002:a17:902:aa85:b0:2ae:8039:fcb0 with SMTP id
 d9443c01a7336-2aea3122a7cmr154565ad.5.1773079569456; Mon, 09 Mar 2026
 11:06:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260308-tools_build_fix_zero_init-v3-0-6477808123b7@arm.com> <20260308-tools_build_fix_zero_init-v3-27-6477808123b7@arm.com>
In-Reply-To: <20260308-tools_build_fix_zero_init-v3-27-6477808123b7@arm.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 9 Mar 2026 11:05:58 -0700
X-Gm-Features: AaiRm538eyfLQGrSYDrM92WeXq5PMuuL8X7tS3nLFN11znCK8k6pxl_hktQ-lc8
Message-ID: <CAP-5=fVR6cTg4HU_DvK8sckgAqWw=HbgSGSdY9-prjb+TiOzbA@mail.gmail.com>
Subject: Re: [PATCH v3 27/30] selftests/bpf: Append extra cflags
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

On Sun, Mar 8, 2026 at 9:50=E2=80=AFAM Leo Yan <leo.yan@arm.com> wrote:
>
> Append EXTRA_CFLAGS to CFLAGS so that additional flags can be applied to
> the compiler.
>
> Signed-off-by: Leo Yan <leo.yan@arm.com>
> ---
>  tools/testing/selftests/bpf/Makefile | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftes=
ts/bpf/Makefile
> index 72a9ba41f95ebb825d25799c07ba3f0311243e45..29dfcdbe98c781b53f1e87dce=
becf2027bafcd5d 100644
> --- a/tools/testing/selftests/bpf/Makefile
> +++ b/tools/testing/selftests/bpf/Makefile
> @@ -49,6 +49,7 @@ srctree :=3D $(patsubst %/,%,$(dir $(srctree)))
>  srctree :=3D $(patsubst %/,%,$(dir $(srctree)))
>  endif
>
> +CFLAGS +=3D $(EXTRA_CFLAGS)
>  CFLAGS +=3D -g $(OPT_FLAGS) -rdynamic -std=3Dgnu11                      =
   \
>           -Wall -Werror -fno-omit-frame-pointer                         \
>           -Wno-unused-but-set-variable                                  \

The append should probably happen last to allow the default values to
be overridden.

Thanks,
Ian

> --
> 2.34.1
>
