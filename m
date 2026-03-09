Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFB8B3E8C46
	for <linux-perf-users@vger.kernel.org>; Mon,  9 Mar 2026 17:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773079033; cv=pass; b=i1C8yfjOH83fscHxbMrymu7HhbuY7TMUbPjZ9DRmUHtOF2dHAF523pn60gHd7+2TKcInrlXYuA7dEXmNI5rJqMv/Mhsi5Oxb5eCullSDbvoZu6VNV6NWSa8kyPQL16FDj1Yx4hFpeoyooiCoB2QSr01UstkebhtGjNy83u2IdnE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773079033; c=relaxed/simple;
	bh=e7l4SmZBUR6r5igqEW+38ztoAKGAhS0X/5S8zKQD+s4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Zmi4B7WhBI24su0aEV+TaqKaoSdoKZVndcK+xKRFQEnf3YtOCPK14quR0zLL7iVnon3loRzvDImup8CM9t8nr0UGhefF7MiIC6bR/kln6y0rG2havmwI/27+zywP1z6W6zSEillO+Da0eo7UtphFL5P2L24DVZeIjRIEtLY9JA0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qReq42Y5; arc=pass smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qReq42Y5"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2ae3f822163so12095ad.0
        for <linux-perf-users@vger.kernel.org>; Mon, 09 Mar 2026 10:57:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773079030; cv=none;
        d=google.com; s=arc-20240605;
        b=f1UVQoqypyNPrXCJk1PdU09xMYzR4jslLcHrkCYr0zoNgfV/UOm4GfN7CMdpTFLFNR
         vghY9Ap0TTCg6qs9G5WYTBzV8uQRJtLndRppX9uZ2YjnI/KSGqdjDh6Vc4mnHprM2vV6
         QkQNBlPl5GH1Uh2j2mBj5wFRuL574Eu4//VbAhF5fl9Ir9SXtTufLlxovVeXbIii9Rd9
         AYEEs515TNQT9Eo424XzCzH9mj63vjngmPRaCdF/T5AO4ZIiI6fBLx3bjQhWEnYTNkQw
         h6pHJ/cITB4ezYdwE5iBQ+XR8FxIMv1MuASRUOA2H41A6hJMGEGR3qC8qMdS6I1sh5z8
         AmIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=YgaFfLtD6LpB7+GDppuc9zjZm5c30kugkl39n1WKFb8=;
        fh=6PU6mUSvIeD4X1+BFU+mwquFGXKcL4q2HFKI/yTFQ+0=;
        b=Da42SrjsD6ky0KWl/pHztbmRTAn1L1m02+RmXhzMG/6NhG4KsG1vbJEBOZ88lkAGnE
         KYCrnhEFhrhN+UVVIsaj8G1YYrtSOigE7Ug8tnmQ7CLwNERsI6fEwMMFs6H3FHf3F9qL
         a/E+Kw6wGU3LTNOZfBCD+u40eCCZxH7SBT0CcyDlaPTcr+hYS5vRVt6EiW2e2hszren4
         /ZcrMTdwpwBVe7iQYJVMVDUbJfscpJt3pOKlbO1JflfRkH6NTtFG8VtjQyESJMFhrqme
         BdDJ79YviP6NRIqMxTb2URFuRXOclLRLY8UsN22NlFvq4xfwjfRW7zlV42u0z7D3alGW
         nzdA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1773079030; x=1773683830; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YgaFfLtD6LpB7+GDppuc9zjZm5c30kugkl39n1WKFb8=;
        b=qReq42Y5h850n1T4pu9JaSPZOvumGTlG9M+snrUQMy4qvceeMvQt1XR/1duYQkLd67
         PS+6sAeIb5AALtG/g5vK4RcJMpt3DJJfVd+VGNs8VEyXTP1mNLHu9oRQn4pMslTtkKch
         710FP7KjTkPBe/69R8f+r7yi2wHxnZsl8RcXLM+jnS64TksdIJtI8eNDtAGOmPCHZub0
         BOuQuRHTmJxL6c5iiH9Ep+QMbmLPp3YFovkgzxe4AeqcDguZvY7B+YfhP4L4P5MtCcjN
         nkMGjQLal8DaiAI8mkC2PdB5ZDfVZmPGP7YN/gexLTwLAZecN6wMr85kb+Z5W+hqocY6
         gQ+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773079030; x=1773683830;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=YgaFfLtD6LpB7+GDppuc9zjZm5c30kugkl39n1WKFb8=;
        b=JaRuTePIv9l+tQjGJOROdq3P8khdffu/Ek24C4vTOndrKuC0F+yasqVM9z+W0bNiIt
         6XtdEe6g7Q5Nm91edHTHhRoLUdWZfTWqznT6G+0bQcFUMMHE7FEfz2P80SfUrRXWcf3M
         eUpaiff/2aQy4diJeBh/kBT7phv/QUoxvM/P3QvYNyjhXTa0t8jc77iNpbuRya6T3GQf
         2YD/51THuWu9LVzW0H9E4dAIxSbfnci6WjH+QyMyM0Zc/W+DjTgTc1SalnvMjjqtdVqv
         ikOvYRiif8czplehBXWKAlyYvi395tfAt7b1orYPtmhHsSlRcR+RwkjF5hUr4RIMr15N
         cx5w==
X-Forwarded-Encrypted: i=1; AJvYcCVSbfqImiDAYUE35b1c23d7cFozsa/wR77jjtABBbBCr7ZJMPs8jkaiemdx5dqe78fTciu6NAW6BEhXJof3bSas@vger.kernel.org
X-Gm-Message-State: AOJu0YxD+55yCneObV1e8v5s/XAzF9PXoCunfNdj9aDXavaQzrEfgC5M
	w+U7lJI8cQvMm1p7czIJPw9wBabe/riWmPLTfYxBfpiSOWyRqFb3ILyVoyIMEMCCdv/CoBylU/W
	lFW8M3sqqHFwnqVBzGl+mh7gSZdPotq9Mc6x6tSCf
X-Gm-Gg: ATEYQzxUUn1uZiyhjWDwmiooMuUIzwxB4pKqTJRuTFVGkFcH2DimAegukkOWG7mdBE9
	Qc9efk3GjP9jctWqfPdfjpCGW/4Vg7NIauDPezBtQrmwqB8xUX2xMFWrVg5ODzIYSgtvPSjNEEb
	kfR4JI47rf1P6O0p9O8HtGg8gJCU+4XopUhhUIMPeqbeZswuuNLlmmuhhSilXzs22oBkE1ixM+0
	xTAaOJTFEgD2w+XjNcMmJpU3CGvH+P/Vb0lRyUnxzSSaRYLQC98YB0NjxePkvt+ROZsWf0gV++W
	uNvgCFBB8v3N86cTK3e6fMfpGvXP2s9bDqk=
X-Received: by 2002:a17:902:f68c:b0:2a7:6fd3:c11e with SMTP id
 d9443c01a7336-2aea30c63dbmr244475ad.18.1773079029518; Mon, 09 Mar 2026
 10:57:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260308-tools_build_fix_zero_init-v3-0-6477808123b7@arm.com> <20260308-tools_build_fix_zero_init-v3-13-6477808123b7@arm.com>
In-Reply-To: <20260308-tools_build_fix_zero_init-v3-13-6477808123b7@arm.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 9 Mar 2026 10:56:57 -0700
X-Gm-Features: AaiRm513FrreYhP9xkA-LN0GZhrOTdf4osjECxyH4jBzskTrYRD5OF8a_TvuwzA
Message-ID: <CAP-5=fWkVHaa417c=1kzq7s=qrsHHDyKn9K1G+BbX7TrzaXZLw@mail.gmail.com>
Subject: Re: [PATCH v3 13/30] tools: dma: Append extra cflags
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
>  tools/dma/Makefile | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/tools/dma/Makefile b/tools/dma/Makefile
> index e4abf37bf020ca613b6dca340299198cb887126a..bdca05c69a8a12a4f9419eed8=
c1df71adac4f26d 100644
> --- a/tools/dma/Makefile
> +++ b/tools/dma/Makefile
> @@ -16,6 +16,7 @@ endif
>  # (this improves performance and avoids hard-to-debug behaviour);
>  MAKEFLAGS +=3D -r
>
> +override CFLAGS +=3D $(EXTRA_CFLAGS)
>  override CFLAGS +=3D -O2 -Wall -g -D_GNU_SOURCE -I$(OUTPUT)include

The append should probably happen last to allow the default values to
be overridden.

Thanks,
Ian

>  ALL_TARGETS :=3D dma_map_benchmark
>
> --
> 2.34.1
>
