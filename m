Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B38532F7ABE
	for <linux-perf-users@vger.kernel.org>; Tue,  2 Dec 2025 20:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764708920; cv=none; b=Vi7eS4JwMC23TDMS9KiH5gCQXEUrAwTNv2Db4thUDG1QjJ87uCaLYmqLM0EK2X9k04unGlzQQakid82plC33tVQ35YJxPikfH3XeWE19FKWheABaR6CUNmhkz8Rf3yHHrqTfYh9N3f638lvrxS8MBrvG65d6M9sZB2sxJn8AO9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764708920; c=relaxed/simple;
	bh=uzAHLdve3z8ZJMSRkzQn1ltvH2lLFC86FcYf9NOUUn4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fFcjMS/7xGa9t6EQ+BOMv1Iu4p94brKKeyE0X7KEmEZIfxXvBGnh4X4sLUqLJahQ2DVEtiSvelo9SXoZQZGyx81+C4za66NFtZYrR3IoWfO6JAPyil21s93rrcNuhrpjHBNLRwYpkInhNbK3d3hOX7h2rpGUbLtr7I/xORlE6yA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RmSPzzli; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RmSPzzli"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-297e13bf404so45125ad.0
        for <linux-perf-users@vger.kernel.org>; Tue, 02 Dec 2025 12:55:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1764708918; x=1765313718; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1ll+dmm2fT95+8DPpmyFlM0Sv0kKkcRHQD90qF4VHew=;
        b=RmSPzzliy3fMmeOufRzPTBA3Unw0GplSILS3uUmufEFm3/NCJFPDGKJB7OL81LcWl+
         zoaOoxQTPwNmW7xSrX5hHOQqszOKloHHODIgOJ15Cnfz1GgR1QYfZIGEUogeb4CG1sqp
         k/HiPjVclCjRYYPEF6idIS8yZxE5M8Ek9dboimuCT4ao1T9LWS8G0pWcRFnADlY4MHFK
         3xqje3O2oCOEcHoQKB2RacPU24Ayw8K38dNPvoZa39D3JrRRg0std4KJotCihVDN2Nll
         KXR0daFwfe5Mix5tZsvHyuIwm4sKkeFidDM/acCPaEZcYfUeFFj0K/OVwgc/ESMME646
         owBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764708918; x=1765313718;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1ll+dmm2fT95+8DPpmyFlM0Sv0kKkcRHQD90qF4VHew=;
        b=iMrHI1e2WSTtFuMDcc0C/LiMwAxmaWC1mYR2mL9HT/ior6hmjq6C0HdHDz6/lpB4UR
         ykilLqJQK/vwPMkT3A01ILxZlCd34ElVs/6hvm7rR5UgwWvx6avhHravgHyaecpzmFp3
         E5Y2CkkF3yqV6K1UxqUJy7nKfhJ9BkV0SEd1P/MnXBEF0coCF1Gfb+Pw/8rsl0JtFMr2
         k45VlD8JBgJQvOrMc33QVa1EIklsHjOrrSHmfScz4LycoMaD/fFlJnmFqt3DyWLYMaYb
         pN8kpAAhqJT7RBtVzq1ka5Gp51xLBwogGBjJIc1Z1JncNTFGII68/AxSl1q9Gl5MUfIA
         YwQA==
X-Forwarded-Encrypted: i=1; AJvYcCU83ka/1AHbdfpwFpZFCPhnuP2+Ew4vhUzXI1xF+rA+ZaM9aLEHvD0P8MRQo9aDUmKRIWvFZtc8kZhU2FzK+t1f@vger.kernel.org
X-Gm-Message-State: AOJu0Yx45hgb8JXLyrLJWDuNhhOLquYZGTWfH82BE+cq9M+9kRKW7rCz
	4nG87Mx3vYXb4w2fQ+JViV/Y1CxgO2jgXlec4QznSYXoNJc05aPL1M7NKnXx8TKMRzXRX8SYX9b
	iJAmveXAap08x1PRy/xbSyuh3HvFW1X72NWIVwiegJ9EsNvldOJPukys+
X-Gm-Gg: ASbGnctlDMDpN+IAZ7odxuEKpaHB37CkgfRICxjJ+vYJnrHc3nToXGi4GkzAd0U5DoN
	7DIk4b9ILcct0qu2I3jIxjXhvXfhM72B+Tk3J7ciPpBjcS7tRH1+htvjc68mH9Xy8QwiExiMZKl
	tKWQHuzGX5l030bCtzjkpms5Hpe3Lk06hIazlyU0QeihWZXHAQDrEREO1gxsg6tsOjgFHeaVVdQ
	aCwz4GZNG3oWom2YgOyLEvzoMmLbJRI8F+odKrhPkhvFyodmA0+am6jdmPpZqADfo5ivuxZ8bp/
	+e0i+9Oz0clYEEWIoUc5NLgL
X-Google-Smtp-Source: AGHT+IEISwm5Cugl1z8g1EVn656SK3L5inKcm5vt5BybPdtEa9XTA72tngdjeomfSQzHejhf8lkJpWA9iNlYlK3/MbU=
X-Received: by 2002:a17:902:ce90:b0:294:d42c:ca0f with SMTP id
 d9443c01a7336-29d662cb7c2mr787815ad.2.1764708917749; Tue, 02 Dec 2025
 12:55:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251202081645.931527-1-namhyung@kernel.org> <20251202081645.931527-4-namhyung@kernel.org>
In-Reply-To: <20251202081645.931527-4-namhyung@kernel.org>
From: Ian Rogers <irogers@google.com>
Date: Tue, 2 Dec 2025 12:55:06 -0800
X-Gm-Features: AWmQ_bkl-aDM3qOvm5ZFlLkswe8ZPHcAnIohM5LYYNCm99MnLp7lKVRGPfjRUZ8
Message-ID: <CAP-5=fVUKmFmrdBAV+CEx_TJQtLOzB7hisgXKOajvfAJPvqdqw@mail.gmail.com>
Subject: Re: [PATCH 3/5] perf tools: Fallback to initial kernel map properly
To: Namhyung Kim <namhyung@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, James Clark <james.clark@linaro.org>, 
	Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 2, 2025 at 12:16=E2=80=AFAM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> In maps__split_kallsyms(), it assumes new kernel map when it finds a
> symbol without module after any module and the initial kernel map has
> some symbols.  Because it expects modules are out of the kernel map so
> modules should not have symbols in the kernel map.
>
> For example, the following memory map shows symbols and maps.  Any
> symbols in the module 1 area will go to the module 1.  The main kernel
> map starts at 0xffffffffbc200000.  But if any symbol has a module
> between the symbols in that area, next symbols after 0xffffffffbd008000
> will generate new kernel maps like [kernel].1.
>
>    kernel address   |                     |
>                     |                     |
>  0xffffffffc0000000 |---------------------|
>                     |     (symbols)       |
>                     |        ...          |   <---  [kernel].N
>  0xffffffffbc400000 |---------------------|
>                     |     (symbols)       |
>                     |      module 2       |   <---  bad?
>  0xffffffffbc380000 |---------------------|
>                     |        ...          |
>                     |     (symbols)       |
>                     |  [kernel.kallsyms]  |   <---  initial map
>  0xffffffffbc200000 |---------------------|
>                     |                     |
>                     |                     |
>  0xffffffffabcde000 |---------------------|
>                     |     (symbols)       |
>                     |      module 1       |
>  0xffffffffabcd0000 |---------------------|
>
> This is very fragile when the module has a symbol that falls into the
> main kernel map for some reason.  My system has a livepatch module with
> such symbols.  And it created a lot of new kernel maps after those
> symbols.  But the symbol may have broken addresses and the later symbols
> can still be found in the initial kernel map.
>
> Let's check the symbol address in the initial map and use it if found.
>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---
>  tools/perf/util/symbol.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
> index 8eea49c50453d13a..b533fbf17a8b19a3 100644
> --- a/tools/perf/util/symbol.c
> +++ b/tools/perf/util/symbol.c
> @@ -951,7 +951,8 @@ static int maps__split_kallsyms(struct maps *kmaps, s=
truct dso *dso, u64 delta,
>                                 pos->end -=3D delta;
>                         }
>
> -                       if (count =3D=3D 0) {
> +                       if (map__start(initial_map) <=3D (pos->start + de=
lta) &&
> +                           (pos->start + delta) < map__end(initial_map))=
 {

Reviewed-by: Ian Rogers <irogers@google.com>
nit: it looks a little clunky to subtract off delta above, but then
add it on again here.

Thanks,
Ian

>                                 map__zput(curr_map);
>                                 curr_map =3D map__get(initial_map);
>                                 goto add_symbol;
> --
> 2.52.0.158.g65b55ccf14-goog
>
