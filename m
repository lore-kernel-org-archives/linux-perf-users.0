Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 077AF3E6DD5
	for <linux-perf-users@vger.kernel.org>; Tue, 14 Apr 2026 13:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776172451; cv=pass; b=NpMi5ItpVrMJTgQBkj9ku4t7twAuFmrrrhqmhH4kt8tImoRickuTiWhns9fuh1YgRAx/K1cxnKz/JTwmEtSgPJtrxOi9ti8luftcL6BKJmt4FLUiYTeY5ssMw4Jg3TTEtNCx6mkglf1plLO7cNv3DZB2ak3gpevEleRwRVJ8NtE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776172451; c=relaxed/simple;
	bh=jOsViN4NIKUTK2djxj/LqGafrFIIjSXC4TelnhrR6zA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MQccnFAktddibJ61u0R93EA5ntTeVDq0hwVdA4wLvSiwm3v0zDGsqdzB5poBQRdX0IXXIDpW9iYuNaxiK6FxHzt29tXFm7C0kY5tN9KNRDp8N5vnQsiw+SyfKOLqRmh5S6mOmEi0/MdqNhY16wEtwxuSFA/yNhTPN/8qoEgXohs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IJ4QDpd+; arc=pass smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IJ4QDpd+"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2b2591757fbso576055ad.0
        for <linux-perf-users@vger.kernel.org>; Tue, 14 Apr 2026 06:14:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776172449; cv=none;
        d=google.com; s=arc-20240605;
        b=dH87u85VIpFUgHWMc3R//ZJXsOF5TAgbL1hu15zPYbBpBaDhGcCQuCIPTkAs2mzZTN
         xChzDOJmHFNNufJD7nMNwsLgPDcIqH3+zrEEdS7u4uPR1xgfQuQTNkMHoYrqxk4dsnr4
         MeMLfq1nvODPIMwo4V5Ild0n4g2kihFTmAosbbWuVqof8M1f/WnvqyBgkEUcQpIT+MfJ
         3CJsF4GXgrESgDAEtBrxEk8zCj6YaC3qkJMWPgfXJiiX8pGqSdoaSIJMrUYbKKb4G2Lk
         LTT+9KgeMiT8+UMyDRbUDxRbO5K5pJC4rn1rOVYKyao/DnaQ8gzY2cYP+jQBkVWCp0Ox
         SUMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=UJQ/3w1DBcgGlnLHAerUmdd07zGHcm64GaPdH458Eu0=;
        fh=pmroGTm4pTg5eXmqiC+gvZQaHPS4M7dQsJXRQqf0gH0=;
        b=BAv6JtzYoZ9yLRCQTCNiGkOwQj6JMjATkrXKn1viLxyCMycMU8m3RWLgs84vzd5CJp
         6vPNhwU9g9UWWINHLgSYT+U4vsXwU1DndcZHS62xBap06mIg8ATKlzsWyZYC7AG0CsAF
         hW2o9w9id1anp4/G9yWs+sE/jTwscD7teIlUkncJunBqkE8iRxghGSDv4KtAa5ousI0b
         5/LLn/y/p+OrRX6VSLU0UnaeoilPohtHaEO6mKkNzTcf9IeUlKnVUzyE3TTGmwQeibzW
         DqtI/pVWH7ISoa3RibV0RA5uNyBHRract+s7xrGIbFnqiK1rAFe3cI+lkQcJ2O/T6C5g
         iIdQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776172449; x=1776777249; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UJQ/3w1DBcgGlnLHAerUmdd07zGHcm64GaPdH458Eu0=;
        b=IJ4QDpd+dv5883rCErhENnX0qwehzP3e390o7PUBl9DLskSl6GdTG2rLtJ914HJF2V
         +oNQ7IDOeLqayWSygauXeJzS2z52oYTT6ZspHgjVh+9N3z99KPWxChiQj3MyPk4iE0tx
         yRPH7T59EJmBXNN8dDZEdv1aW/R9DmleCzaVyzzy0Qjewn9hWFfqtxPwamHUhGMdSBS0
         D0rZkkTYxZlnMkpnpVRhBRKqde8LjaCt2pOXw7+AM+jG0fyVaURWqAIevWvum5nT8RjQ
         hQ6cgpdZqz2b8rtS8424ofv2KqRGBDofeTJrsoTrc17AC7GtlnHdEji8FxGgwvDYQMJW
         Xg/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776172449; x=1776777249;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UJQ/3w1DBcgGlnLHAerUmdd07zGHcm64GaPdH458Eu0=;
        b=Kd3LCt8UbOIzbFe9Ob+jYn7Yye+7+ZjpsROYEUy6vjUzwSQNALrlqaGn6CDYkVCclb
         0gqAHO3z8guA1gmZinmLReRQKKtB8sh6Epx6FZmW52dxeUkaZv8gqYDG7h6IjdJfTqtR
         /jDHaC2KSec70YulSxYPkk5XrAJCaVoDYsP+/rCCGA+LsrWy55eSj5yDKJnLVJRZDSmG
         p2MlL/N9CHedDlIoVF0ICxh5AiJqfcetYrmOPAkqew6/nzM49mWQSdzh3oGCT/lv+p7w
         wRyA1U/oXT2KVdy2OHj9WFHaHnEAixN5Nd/ysgw4x74k42tqwOKBDgumPqJHMPYSPigO
         PGUA==
X-Gm-Message-State: AOJu0YxZ88WrPva9oqFRawzwv+Ku5OdqjN8s/YcwhZ2wODJfkUYVq+9K
	CVUiyN3LgjNMfVDBwfam3qRb4+0XaHZSF5bFBLu4hZvF8fPFMzr7r1OD7JXm4Juxa8Ky2gpIItP
	P806DTAuXKFDwpUYVeXUrl7Y9tqP0yL7+Eo+o1wNb
X-Gm-Gg: AeBDievUEYcI9ug7/HKkl7DoU6whfRzCdTtkpz4LYSe+aFC33uMXp2bZ6jv06NWd3Ma
	CQnetOf3fi85JxnvmKDlFjDSwDRe0ej9iG3Z2aha9qkFbgxsblszLaszAMpLJ20gk+DaWYKgOlJ
	/q86XpZvo7IIXmQ5ys/g510WuIwLETvbGVP3TwKAeir7kr2nQuHcvvI6On3NSATqxwzLu6C66LE
	gU1CKcTjLc0FV8R7eZqgrtp7CobgsrPs4Vy5zO9RUdn5zagbIjf028PWtdRJjkRjx6vKGV/dsi2
	oK0LcX8XR3qCgum6tmOU5dgCDy49iA==
X-Received: by 2002:a17:902:d28a:b0:2b0:b458:2dc3 with SMTP id
 d9443c01a7336-2b468152a26mr964615ad.21.1776172448591; Tue, 14 Apr 2026
 06:14:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260414071242.95637-1-mgsharm@amazon.com>
In-Reply-To: <20260414071242.95637-1-mgsharm@amazon.com>
From: Ian Rogers <irogers@google.com>
Date: Tue, 14 Apr 2026 06:13:55 -0700
X-Gm-Features: AQROBzCo-GKeDRA6Lk3sTQXMfYYJ12DlhceopjwbpJatt3xI7c_OxYLcfadMFHc
Message-ID: <CAP-5=fUPfjhyh4N6CqgAwwR=tQXOOVjS=YoEJSGkz70rHCp0Zw@mail.gmail.com>
Subject: Re: [PATCH] libperf: fix parallel build race with header install
To: Gaurav Sharma <sgaurav00719@gmail.com>
Cc: linux-perf-users@vger.kernel.org, acme@kernel.org, namhyung@kernel.org, 
	stable@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Gaurav Sharma <mgsharm@amazon.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 14, 2026 at 12:13=E2=80=AFAM Gaurav Sharma <sgaurav00719@gmail.=
com> wrote:
>
> When perf is built with high parallelism (-j128), there is a race
> condition between the install_headers and libperf.a targets in the
> libperf sub-build. Both are invoked as targets of a single make
> invocation from Makefile.perf:
>
>   $(MAKE) -C $(LIBPERF_DIR) ... $@ install_headers
>
> The perf tool's exported CFLAGS includes -I$(LIBPERF_OUTPUT)/include
> which points to the header install destination. The coreutils install
> command creates the destination file (truncated) before writing content.
> If the compiler runs between file creation and content write, it
> includes an empty header, causing incomplete type and missing prototype
> errors in the libperf source files.
>
> Fix this by making the libperf compilation target depend on
> install_headers, ensuring all headers are fully installed before any
> source files are compiled.
>
> Fixes: 91009a3a9913 ("perf build: Install libperf locally when building")
> Cc: stable@vger.kernel.org
> Signed-off-by: Gaurav Sharma <mgsharm@amazon.com>

I believe this was addressed by:
https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.gi=
t/commit/tools/lib/perf/Makefile?h=3Dperf-tools-next&id=3D8c5b40678c63be6b8=
5f1c2dc8c8b89d632faf988

Thanks,
Ian

> ---
>  tools/lib/perf/Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/lib/perf/Makefile b/tools/lib/perf/Makefile
> index 32301a1d8f0c..8372cd9919b7 100644
> --- a/tools/lib/perf/Makefile
> +++ b/tools/lib/perf/Makefile
> @@ -99,7 +99,7 @@ $(LIBAPI)-clean:
>         $(call QUIET_CLEAN, libapi)
>         $(Q)$(MAKE) -C $(LIB_DIR) O=3D$(OUTPUT) clean >/dev/null
>
> -$(LIBPERF_IN): FORCE
> +$(LIBPERF_IN): install_headers FORCE
>         $(Q)$(MAKE) $(build)=3Dlibperf
>
>  $(LIBPERF_A): $(LIBPERF_IN)
> --
> 2.50.1 (Apple Git-155)
>
