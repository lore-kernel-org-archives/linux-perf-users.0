Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAEB93242AB
	for <linux-perf-users@vger.kernel.org>; Mon,  2 Mar 2026 17:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772473202; cv=pass; b=pf9RZyZB9757SP27kHqNOXKJLACK4ghITenGEE2KewF/k1IyAPwFqqQP9dPbhbmcaFmdM2f2SwjYIpN4XNsFhWdOQqR26RF9Pa3sVJwNB3q3Rg5nAxep8GDYViF6ZtnxKsLSFhqKcBsHo1QXA3G6pZPLvpCf4Rbkz1bMGtd6ddU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772473202; c=relaxed/simple;
	bh=wBZvHQtCQArGIJZg6bh3DhS4BlW+6ESvqJqqnTv93WQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fIDudI5KRfmrZsWkQbj7/mHEYjoHl9P8Qg4ySf+vaChuEg8L3vODqsouLWVFJhqFwt0uvP+Ajk2ucaKNujbpPd4ayzLWafj5lOPB7DvmejJ1nKHMGUn/WzMoI9Zbq7iaXUvDQrvY4qWtoKEIHUEiZ3rHQsSbZPjTnznjYAsbBtQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vqeKyv8a; arc=pass smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vqeKyv8a"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2ae4b40999bso108125ad.1
        for <linux-perf-users@vger.kernel.org>; Mon, 02 Mar 2026 09:40:01 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772473201; cv=none;
        d=google.com; s=arc-20240605;
        b=bNr9fqdTQNzBNWjM21y9Z0U3E4AHFDo3hHbjZ70iCqC/imUGM05oOSTvXbH8cXICFT
         SnqMyoJ4hcpwbbQBG9bBEine/H9/VX1b8t27qBAEDFdMl+vgkELcBycpjCzdGVapiZYx
         hL6tus4mWgTiVUps1myMEK4QOjGbERugitesC+e5PKET2LG2eABxO37vdRYmGamLQGTT
         9YHBs1ggXhwW+ran9jrGlMcJ7Q0keCyDxfCp2apxbImXQ8XSkdYVeYStknEPVcgNg3mC
         XdjWW8qePqCWYCM2k60qZmo5YCH606OL2xF/9F1UNlssXvjlPQz+6llt2qHpRMLXazxh
         grVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=n3YwwmChtIIKITr8nrd4/pSztHTeuCmMT2m1oPeWYPM=;
        fh=MAfkjunD8EF/EcfIA4f+JH4v04E1NOCufN5xpDViQ/0=;
        b=aPOgiPdq6Y4ryEKE5fWryRgb1CYzNVf+s520emjt/rocHXORx1ZlqMHtL08RKQFVi1
         Vy7+0ftJlqlGAprJvtpP7jiWZqMB9B+rsEjZHHzRMuHMRiC4H7vEZzfqjFZEZAVE4xCj
         zJd6/jXpOilFM5jYoAv5gSW40y/jViOqkq3cJ3HYp9qREbsikPXL7alqHEmdNS/yrwMt
         4ktn/xAIB5huyGhh+CEjTKUcQ8Ke2M2NWqG9dfVqPLNRKX75dfYfli3ajLH4U5AUF1QN
         pfgSWUts2cUX674l4nKBy7lAPfuS/l97zDy0ZewJlDjWlNSQ05QV8tfeP2UOZylJ1Llk
         ZzMQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772473201; x=1773078001; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n3YwwmChtIIKITr8nrd4/pSztHTeuCmMT2m1oPeWYPM=;
        b=vqeKyv8aHR2SfppDAcdlrESOmr4uwtuXDJ6B1eOBJnJYukX9PUTdTrXIzdRiIdA6jq
         /rV74WISJCSUn7+JDpEqHByRyXZlkcC5cl+pQPAzGijeVR6qR+dPuZFD68wqLPW9oltj
         p9WcRvfkSq7pVRt5GsmyC/ubWdGZ2DWIXHn6Szb+ipo2679i5o8X2DYRliDjCm6aUGyP
         q4faAM5CmzkRDCi8TAbwHglIdQWvMfcJ9hn7dsMLPU+mH4kgH0CSCou9tb4vbKVUPeNY
         2N1HLu1SzSt+HB6A1sb8BidqxB25U0w6ZaI7KH6SGQrc/70ktbopFt3NkN5Y/bG2hNHN
         MzDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772473201; x=1773078001;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=n3YwwmChtIIKITr8nrd4/pSztHTeuCmMT2m1oPeWYPM=;
        b=PUEkAqIyF96Em1HFAPjbKk3sa8t2JRqo/GBCKcNNWe3PIZ1m2h8nzLJC2nmXNhIYUt
         /9v+zZW4PsrBb7w5sOdZk5KBYNEF9DGYBsJLzpN01Ry46dCvjUrQXbOA1yUT7DeJhxSd
         tRUtJyRi/XlZ36GnVjNoRIP6A9YyTxcVUBiBWnQBrhS0Z1rM/37ycZJHdxQ2pULrwXGy
         7sQncEW3oxxxgkqzLSxkhPOU/kOCUQ1slgJ7TPt5qhQlNNXVMQp3o5w9JfhR3QQ8Qhyl
         XXSUSZF/IgyNRsvw68CTXc4rEiApWEhkFGuK/xtAJX9y70xqThgz653RezsPOkA31VbX
         pahg==
X-Forwarded-Encrypted: i=1; AJvYcCVIImDW8IN/ImY9Hni590NCSykO9wItJyFLrI4v5W4RCHPZBB3kc6ijmJsEdXfaLSIZE5bJMGe1Nv5/94+3Owxx@vger.kernel.org
X-Gm-Message-State: AOJu0YwRVHh7pclHDpwKNSlyiAhmTGygQ41/zX9oNyaBB+SHAZ3RNSdP
	vcqludACkQEICWmUFDeI254XrfBYVVAnvrnEbcAZK+F/4GtCQnw8P0uBT65rmU8l0UXUa3o8Qx8
	FxvI5fHjmHe31oV43tuGe6BY2h6YmZbCS+wk7TYxD
X-Gm-Gg: ATEYQzzLVGXdGhay0jSJ3ZiGfWBZ996SS32awPmTppOA/J3g1NZMFQIhBeawBG5WGkP
	pKsyPX0zqUg4lRqbc/9WRDpzroShdAPwGXwk1fRx3/HzSWijFWGsnZm2BWGBU55phK+RF0r01Rd
	fUT7subPmGsQq2C3yV6rRz6Mq977Owu5bpjkS5YQLKKpa7Ek+5kKMR30IMTxZXhHtLps63bHbdP
	vmrzGMGCGj2DJYjWEFAffS/2LlIjs+97F4wteuCD2Nght/NuEiqFkY6eo8sr1VmlIIQgH75+CtQ
	CmvaSHwwAfQHexLgqDJCg1gdi9EwX/p1PTUgU81fWo8vArk=
X-Received: by 2002:a17:903:440f:b0:2ad:6f9b:7818 with SMTP id
 d9443c01a7336-2ae3b5644aamr3668425ad.23.1772473200748; Mon, 02 Mar 2026
 09:40:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260301-perf_fix_kvm_stat_build-v1-1-e3d1ce3a5084@arm.com>
In-Reply-To: <20260301-perf_fix_kvm_stat_build-v1-1-e3d1ce3a5084@arm.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 2 Mar 2026 09:39:49 -0800
X-Gm-Features: AaiRm52Li_3Lmptnet0EpgfvDj5fkGsGVUNCxv9knARC3bIcVBVLeNHEHxvdK4k
Message-ID: <CAP-5=fVUqHrbg9YCgk-0Gu9XjyQdX=cwGq+iFj9keR5RZD6peQ@mail.gmail.com>
Subject: Re: [PATCH] perf kvm stat: Fix relative paths for including headers
To: Leo Yan <leo.yan@arm.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	Arnaldo Carvalho de Melo <acme@redhat.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 1, 2026 at 9:43=E2=80=AFAM Leo Yan <leo.yan@arm.com> wrote:
>
> Add an extra "../" to the relative paths so that the uAPI headers
> provided by tools can be found correctly.
>
> Fixes: a724a8fce5e2 ("perf kvm stat: Fix build error")
> Reported-by: Namhyung Kim <namhyung@kernel.org>
> Suggested-by: Ian Rogers <irogers@google.com>
> Signed-off-by: Leo Yan <leo.yan@arm.com>

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks!
Ian

> ---
>  tools/perf/util/kvm-stat-arch/kvm-stat-x86.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/tools/perf/util/kvm-stat-arch/kvm-stat-x86.c b/tools/perf/ut=
il/kvm-stat-arch/kvm-stat-x86.c
> index 43275d25b6cbccc477ba45a901d69c67422847ae..0f626db3a4392d7bd77417be1=
6a2dfd4f4b1e34e 100644
> --- a/tools/perf/util/kvm-stat-arch/kvm-stat-x86.c
> +++ b/tools/perf/util/kvm-stat-arch/kvm-stat-x86.c
> @@ -4,9 +4,9 @@
>  #include "../kvm-stat.h"
>  #include "../evsel.h"
>  #include "../env.h"
> -#include "../../arch/x86/include/uapi/asm/svm.h"
> -#include "../../arch/x86/include/uapi/asm/vmx.h"
> -#include "../../arch/x86/include/uapi/asm/kvm.h"
> +#include "../../../arch/x86/include/uapi/asm/svm.h"
> +#include "../../../arch/x86/include/uapi/asm/vmx.h"
> +#include "../../../arch/x86/include/uapi/asm/kvm.h"
>  #include <subcmd/parse-options.h>
>
>  define_exit_reasons_table(vmx_exit_reasons, VMX_EXIT_REASONS);
>
> ---
> base-commit: 977000589d30f8d4f0777893711199350d474363
> change-id: 20260228-perf_fix_kvm_stat_build-5962895f5f36
>
> Best regards,
> --
> Leo Yan <leo.yan@arm.com>
>
