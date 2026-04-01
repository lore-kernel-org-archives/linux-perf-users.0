Received: from mail-dl1-f52.google.com (mail-dl1-f52.google.com [74.125.82.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E707738838B
	for <linux-perf-users@vger.kernel.org>; Wed,  1 Apr 2026 21:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775077711; cv=pass; b=J8hmHLfU53AJoz0OwErtER0/sBlRlP7apwZGfOOr+D5crkBAxSkbM9hu3siOiA8SHjRLuXVz+ukjrrsZwxl+PCZLkEx+2brNfc8EHCOXkrb3VM1KBVE8PWbbqPQmikScgJq7sCj+HN6Q4F7oE3Le102lIt0F1fis9vJITxO9B5A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775077711; c=relaxed/simple;
	bh=vcIHZrAyfg0m4198caOIabYp3B6FvYDftZygG0uh+Go=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mCM9/RrUD9Ruo+XtZPEDk8GW7BfgMPwHbFuGLvqzB5KsXw/SI7NRVJD5L5zY/JfIbRUEwZR5ry5Hn4d8CIpOnVrfshoEUddQxhZLK+SBUU/aRYgmbl9GpxXQgecigo+9q43nC7Y7pBh0KnvGP6CmtnP0/3TTW+6j1oYQXbXUZrw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CyQMSY1K; arc=pass smtp.client-ip=74.125.82.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CyQMSY1K"
Received: by mail-dl1-f52.google.com with SMTP id a92af1059eb24-126ea4e9697so1025c88.1
        for <linux-perf-users@vger.kernel.org>; Wed, 01 Apr 2026 14:08:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775077709; cv=none;
        d=google.com; s=arc-20240605;
        b=LTWDnnle8FZWOl1eLdTItKIvF0sp9+L4SqvBZuAJ+/jnLfWG3a3wQnl4R5/ChIt7hL
         OzkS2xQcEC1KUsLgL8axCGXnQ/yI9UYmBeDae0k+OsFt2INXQ3zLB+E/H06bSvjEhzLR
         2/BLVq5CDVFm1aMbQn0guxAvYa1Ozl4ZdE5iKV+3ZeKPCJL7h0y8rfL0VRJEr9+/ZRGg
         vS8CVC891x64qCLjo+/GqMkxuX1NTb6s8A+Uu0Yc8FWhJKtDZTbXSpGmW6XfGw/ahSdJ
         SC8fuoBxe2Rpq/A/f78xoBpFcJxk6B4H9aMQcfUzEAB5/2Q3zkGYc/lHIrZYR1XTPLfz
         D+LA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=9ucDhJ6lwYktf9dCOlOtXzwrIvyGzqYFOODgsg1UA2k=;
        fh=9g3W/m7C4w45OhtemZMa4WXH2mQNdJPS4VhKaMa0iIc=;
        b=SoynBEYub1o5Poji/RxulfyjXEtzvWblx2d7p/ZjcTud6GriLyg31s5NA+9X+6DoJz
         2SvPy2dndGgStuT1J5YCL0AiRVT0z1RuY7F0TxOwUtys8l5juxsHSHpSqOd4fqC3Gcvy
         lGtlOwGaWo6o3Tmt2dJJCrlC1xFKQrJhKjJMQXo+CKvpWcGa86PvlP/Gj68Vicp+Gq4n
         yCmf1PoUFDBwOaFJ10hCnLeDe/rX4/VzCDX5Ds0VuVux/AtcdqPHZIasFMKuSPa//9Si
         H64yZ7B3kyCQFcatht5xhwIeWFugkQVy/zoCHFK3k44gLxxqxNIODT+1DLpbpUbAk1hl
         oBxw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775077709; x=1775682509; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9ucDhJ6lwYktf9dCOlOtXzwrIvyGzqYFOODgsg1UA2k=;
        b=CyQMSY1Km22Dh5VdGNYq7Sv+bYhB/gVXQusyp3KhGb7rVOlnb7iMSPdxezbaELczpv
         FbG4BFTITrrtVqh2hSwxeJRQbmwMPLOrj7wL1uE8EH6tY9niqwPJCCspJuswJ32uErv0
         hn2hUIGPZfgEdVI+2K43j685ru/xWtoCV1UXnqYwc16pv17gFvq8/WPT2i0Qwl1rpxbz
         Qzv1l0gLX9s3mOkpOP3oP8Dnm+eSyyZbIvhYqEmzEW3HcK7fCV67DOOqTJRWmb8xbJAy
         R5Ns4LMP/pX6CZs97G3k6/FDplVh56UqTiuPHbs62ZKtVjxAK+NGhuMv7i0Oo83OMUxM
         OWiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775077709; x=1775682509;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9ucDhJ6lwYktf9dCOlOtXzwrIvyGzqYFOODgsg1UA2k=;
        b=Xw1DelrM8EyVOFY9EW6EzzZjOKaSVUT9JlEWfxGqaiHUkJFOVCSSbyTeZE0Qx3yfYw
         hyC4dybiBMySn2E9BxDt+hfZRSuoTbDrD3EECKIuyE3MOG2TbnFi++OYBt5l93o9pu+a
         444GpdB8mAaXzWry1CFSC+xfjg9sa5EBZlej9MVorhPDEBY/iqpx4bnWGPwuuQEPKoIL
         uN6Ddad5MhmrGMuI4QBz7n1p8G6CbmuFo6t1+fW61xdT/tKlovu6nYVA+mMJvDY1cJNN
         aiS53MtxNR+ltByCZqhdcj7GGzRYkP5Mr/om7FRQB4Gcss3IcK2SzsZkduqsqPfdLI7g
         SEyQ==
X-Forwarded-Encrypted: i=1; AJvYcCUfhMB5Wj10ckz6I+lug2q5meaA7eB1d/nHr8fLFDw+cK4BNAtBZGWI+taLsOrKyxqor0dExRL29npfAOhu4MDY@vger.kernel.org
X-Gm-Message-State: AOJu0YxYHG0xq3GeOGiV99+gElfSvfe1vnTozt+gHCkfxojWJxArA9xD
	vCvHZD3R061XUysJJwDg15Au8hftrklgtOiTxIUOUfjSY7REcyExZEOZgMy1nBIFnKn+bbqlMtf
	T4LcUjxxtEFsxi12Ujqyuj7QdXwcA9SM4n9ocakzQ
X-Gm-Gg: ATEYQzzVvnR1TkAvjm5gM3ppCyJFiycr17uqWSMmfAPRB6QNptct104Lgc38F8ad74G
	+WHVTuyUMlq6XM49pkPjltPKGD491cv1AFregLHJoYcn+boyfptPLq7Xbn4CUQhuHKES/HgCOQj
	cHX5yQFdzaRT4wrQqcWADuE0+oT4OKmHboU41m6Z2LvNvuND0mCTmpyMbU/vwadPfp0QtDFgm3a
	xWOTIO4UPjjEdmDMC+4lOinv99+LVDnDsw1AgSKN8KOd98J/XwcNLzh1LDlpz3aPihp20Xmxs39
	tk8YO7YuRbdWRQJjhunGDKQXkRgyBcfXVcAU
X-Received: by 2002:a05:7022:6b87:b0:128:ec96:67 with SMTP id
 a92af1059eb24-12bef3e48bfmr30584c88.9.1775077708411; Wed, 01 Apr 2026
 14:08:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260401210203.2150651-1-acme@kernel.org> <20260401210203.2150651-7-acme@kernel.org>
In-Reply-To: <20260401210203.2150651-7-acme@kernel.org>
From: Ian Rogers <irogers@google.com>
Date: Wed, 1 Apr 2026 14:08:16 -0700
X-Gm-Features: AQROBzBmkcUSzJsiJ_QpoVIttJCsLSxo0kCjp6OIaENPfOdAtpcNldX5-kKrdpI
Message-ID: <CAP-5=fXEVn8BBcQBfXSWwWYPfWV50Xk6FAgm1gCBxu=qqxoJpw@mail.gmail.com>
Subject: Re: [PATCH 4/4] perf symbol: Add missing libgen.h include to get
 basename() prototype
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>, Ingo Molnar <mingo@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, James Clark <james.clark@linaro.org>, 
	Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Clark Williams <williams@redhat.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	Arnaldo Carvalho de Melo <acme@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 1, 2026 at 2:02=E2=80=AFPM Arnaldo Carvalho de Melo <acme@kerne=
l.org> wrote:
>
> From: Arnaldo Carvalho de Melo <acme@redhat.com>
>
> This works in some places because there are tricks to prefer a GNU
> version instead of the XPG version, but started breaking in some musl
> libc systems due to some unrelated change that made libgen.h stop being
> included by chance.
>
> Since symbol.h is using basename(), make it include libgen.h.
>
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> ---
>  tools/perf/tests/make    | 2 +-
>  tools/perf/util/symbol.h | 1 +
>  2 files changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/tools/perf/tests/make b/tools/perf/tests/make
> index 6587dc326d1b272e..e12ff6397077806e 100644
> --- a/tools/perf/tests/make
> +++ b/tools/perf/tests/make
> @@ -148,7 +148,7 @@ run +=3D make_extra_tests
>  run +=3D make_no_jevents
>  run +=3D make_jevents_all
>  run +=3D make_no_bpf_skel
> -run +=3D make_gen_vmlinux_h
> +#run +=3D make_gen_vmlinux_h

This looks like something removed during testing that you meant to put back=
.

Thanks,
Ian

>  run +=3D make_libperl
>  run +=3D make_no_libpython
>  run +=3D make_no_scripts
> diff --git a/tools/perf/util/symbol.h b/tools/perf/util/symbol.h
> index c67814d6d6d6f64a..b37ecc2e90f77efe 100644
> --- a/tools/perf/util/symbol.h
> +++ b/tools/perf/util/symbol.h
> @@ -10,6 +10,7 @@
>  #include <linux/rbtree.h>
>  #include <stdio.h>
>  #include <errno.h>
> +#include <libgen.h>
>  #include "addr_location.h"
>  #include "path.h"
>  #include "symbol_conf.h"
> --
> 2.53.0
>
