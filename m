Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44BAE3624AD
	for <linux-perf-users@vger.kernel.org>; Tue, 14 Apr 2026 07:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776150752; cv=none; b=c9GKs+1rGDs4z/e1HQciIUH74h2Z1zk/uV6339jO99mwYgLS5pw8TBqtTv4tV4A7m2xHtU1NFq9vm7hsKm5DzK9bUoy2PBYKl9A0v0iNL/X1SGOcn26ggethSCdybPg2Yj/2rVweZaaHw9xcf47Na1p9EFX7RgKkyW2XS+uh9ek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776150752; c=relaxed/simple;
	bh=7e7/qkPenvrl5SHxOd+nOJ9XiE9voHDzEHIXRcpng7k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=G4UyhAJ/N2TX8ads4emEmcIsANJAclKlLOhncJPQu5PRGD7cvZXcjBU7Cs5biJquHLdbFnuCXIMwjyHoW3dDNZs9e3ChdHKp9PO9QwsK5u0sJCI8y+a7NWO3aLNZ8eaTwt6EXKIV8GM9FYK0nzBHyTghnASkJfS0Fj6NaUChYPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sd0tPW9l; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sd0tPW9l"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AECC1C2BCB3
	for <linux-perf-users@vger.kernel.org>; Tue, 14 Apr 2026 07:12:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776150751;
	bh=7e7/qkPenvrl5SHxOd+nOJ9XiE9voHDzEHIXRcpng7k=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=sd0tPW9l6YabFbRlpxUZx3Q7m4Pxs6dDcdW5xSVHS32VURvRXcJAZqTeIUTFwwxHI
	 ZjqQJfLQZeDlJYmfK6GeKqauGc8bP3lT7cmULhuxkWgIfi75W+OIxRIx6+cATeRwfd
	 4iQAXrbBzy+4vITL8/WSG+mqU8X2jThnffSrQ4I4WJfqsZVTbR3kbRjjjIJqELPd0R
	 q98oLT1JkXo4rOqs1cJXddXQqr8oCYMLn3Wsiz5pNVKjbiDGQdGFXgeWrspXBwEE6l
	 /GKKb4gmPadPEN9HVKvygLK3ZLVOOjkelv6iyw3NNOptVBl0/z6KHb8W75xVFoKRkS
	 1Jv12dDXOCxtw==
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-b980b35534eso722505666b.1
        for <linux-perf-users@vger.kernel.org>; Tue, 14 Apr 2026 00:12:31 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ+mmH8u/Q/M1zFsa4/5H7XQHlB8e8Dhji21l59YINVT9vsAB6nbv2+UeferToq1kg1NKC0NyGIkwEuOM4+FyBRa@vger.kernel.org
X-Gm-Message-State: AOJu0YzqamhVT2dwcO1QhHrXaYiY+CwE5LhnoHkXSpn7Qerle6pibE0g
	3Jshxs4nBI+cdHnFUfwfh2eADDRJ9II+3KEA1iTC7DHCs4cLVobtZOpPwfcFRWc45R6yJtjJsm8
	6pErvSPSsHvA0PLV8Sqb+bGqGn5AwdrU=
X-Received: by 2002:a17:907:fdcb:b0:b9c:11ee:3c2f with SMTP id
 a640c23a62f3a-b9d4600c3e6mr1019204066b.1.1776150750183; Tue, 14 Apr 2026
 00:12:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260414005152.10550-1-r@hev.cc>
In-Reply-To: <20260414005152.10550-1-r@hev.cc>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Tue, 14 Apr 2026 15:12:17 +0800
X-Gmail-Original-Message-ID: <CAAhV-H6fo4WzpNPckOK28PXFPzuhMbteCXCFS3dZ0JoO4kBg_g@mail.gmail.com>
X-Gm-Features: AQROBzDCkDOhGwZDCutYcSxP-6C7pt5y-8aREcpE04Ti_HC1hFjxRTk35DOgh40
Message-ID: <CAAhV-H6fo4WzpNPckOK28PXFPzuhMbteCXCFS3dZ0JoO4kBg_g@mail.gmail.com>
Subject: Re: [PATCH] perf loongarch: Fix build failure with CONFIG_LIBDW_DWARF_UNWIND
To: WANG Rui <r@hev.cc>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, loongarch@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 14, 2026 at 8:52=E2=80=AFAM WANG Rui <r@hev.cc> wrote:
>
> Building perf for LoongArch fails when CONFIG_LIBDW_DWARF_UNWIND is
> enabled because unwind-libdw.o is still referenced in
> arch/loongarch/util/Build.
>
> Fixes: e62fae9d9e8 ("perf unwind-libdw: Fix a cross-arch unwinding bug")
> Signed-off-by: WANG Rui <r@hev.cc>
Acked-by: Huacai Chen <chenhuacai@loongson.cn>

> ---
>  tools/perf/arch/loongarch/util/Build | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/tools/perf/arch/loongarch/util/Build b/tools/perf/arch/loong=
arch/util/Build
> index 3ad73d0289f3..8d91e78d31c9 100644
> --- a/tools/perf/arch/loongarch/util/Build
> +++ b/tools/perf/arch/loongarch/util/Build
> @@ -1,4 +1,3 @@
>  perf-util-y +=3D header.o
>
>  perf-util-$(CONFIG_LOCAL_LIBUNWIND) +=3D unwind-libunwind.o
> -perf-util-$(CONFIG_LIBDW_DWARF_UNWIND) +=3D unwind-libdw.o
> --
> 2.53.0
>
>
