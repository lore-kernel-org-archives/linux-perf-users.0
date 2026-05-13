Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20626385D72
	for <linux-perf-users@vger.kernel.org>; Wed, 13 May 2026 20:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778705949; cv=pass; b=fxRmYbraMW0QfxQweRC8hjl7bYShsxjjqIcLk5gtVUS5zxxwfyxY6K3Vke644+zWgRwmEbbRBWWYipkYqN0juj4w2yeysGow3J45ynsdqNq9nd5Jv8aCHqzBaAoWsNPrDXB03qU6fbEN3O3jmPjc3uP4qubIgjSM6iplusRQjAk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778705949; c=relaxed/simple;
	bh=PoGpu/z9+zoZOdJw9LBSyLuRuBsPbwkXSn7YNIPBT9Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=saaqVTXIGxfA0t6aRhqCLofv043P5TI5uo1T3SYWsJxfIDHXNhGPo1RaMp5HBtA+wHn52oPsTJZBiSKWhl4ife1YgQhEMl5rAtGQHxOswyGv7DgzD5O/gEzBVG5QJbZ4aVejqkO2UgxpTYb00o9G/5bSaZ6HBBruiMjBtMsrmPg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PsGUa3Uk; arc=pass smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PsGUa3Uk"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2ba180a022dso4205ad.1
        for <linux-perf-users@vger.kernel.org>; Wed, 13 May 2026 13:59:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778705947; cv=none;
        d=google.com; s=arc-20240605;
        b=g6Fg15c4MFXhbkBt0/5+DL1xiDc4fn/AQuYWpI0dvSbdmoDAMMDORKJM9bcYd4gMjE
         h+mWDJLrQRStdb4FmfFdZGJ5AIB8ru5VwpuEe4t/BR6HQgaKPlfWUhfwJW8II/mwG2Xw
         jzw0jSrmYcyaWkCttvX9Y4IxuaSwEbT2M0jE+um5Dvh4Cn/5gyb2r8EMQhQ9FmP4FFxw
         lJf9nQ/TAazlZrGY6oqMWCIMKZ3Y2s4lzoXVHUdWf4a6qIx/ukcIwtIJVaP0Hh1RGP9h
         1lCHQuXAshwtJQCNbAmnMHbmJ+698p5FJOGKaKcZVsi3id9iMeHLx4/0njkYIqQeP3NF
         Qi0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=SSlF/0lVcawLHEA9q7YTq8PI04X66QRTAQD+S6Sx9uM=;
        fh=dTAVJln8qYacHf4ZkJ859IuMB10wROQ36rEigX7jz4k=;
        b=DBUXx5HFq3N7+qOwBSiaE9nY9Nk4jFHGxdu+Pd7EQ0TM+352Bx3zS/eCsjD0buO6l+
         +NH0N0reer2nxLzffi/ZURdun9As+H8ozZihiXAfScPikyBqy5NU2d46a3myXx0XBtST
         5UzO997qaawvAh/uNW6HHXJ7v5ASUvNiioTM4BUu6dPcXXHxGEORIa9guL3d2B4aYBbI
         Yue8TulZtdOn/K3TiIkVGRyNeFHKuWTelWiTpWT/HzxqI/jQBIBvQ1MZga0c1vQpa4UZ
         JhGslkawC7Pe+kBSYK5GudV5bDR3cudvORDaUn9unCL4/tGuHg3NmCD6J5Elf4+fErIT
         +Plg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778705947; x=1779310747; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SSlF/0lVcawLHEA9q7YTq8PI04X66QRTAQD+S6Sx9uM=;
        b=PsGUa3UkCM7pOoDDilwc5iQGFyYVVYv+ZIIJ84ujbd+WEbcCIl738nxTtwxpShyj7T
         +JIA1YRl5RWqfLtlyWCLcWNKrhUWgAwYH1BI3nMoyiTZRmpg20gAIo4ips4z9TuM0Lad
         AOcMGGfFDyZEtMvZnZKkyiYBH0bZ0ovt0KSFuSP7z8rkkUD3wfJ5HdE1I7pYUHiXfRHX
         //Y+qgk+uswPrgTNFfr/6l1eisG2SOWWbRYNLWn3XmiFlfmoi5QJulyffV6jloM91ec1
         H7HLLiSU4q/PHd0RUZiuk4qVSmkuX2VdnvICwUBYagOwuRcKA+psFqICyk4vOtqP2mlg
         Cp+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778705947; x=1779310747;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=SSlF/0lVcawLHEA9q7YTq8PI04X66QRTAQD+S6Sx9uM=;
        b=rj8UQKxN1/5Gh6PcjSGubcC0v9Y8CnRj+WGHTuC6ImxYtCutav56EO7i3h66tH3fOL
         d70cFI8ZNf0Q0WSzQrzRdroflq5AArxaKoLPmQGRujQDS+bBDKHTj+yU0rPc1ca3rNdp
         /uaMQEPp0qiHuwxacApRTAL9soIn093W2ac06pqSx2Gja/Ycorbrd+ctycutevx12Ccj
         l/L46p+ccb4dMVl5rshDC7HBeFnbuVNVm3Evm0X4ChVpQxC1rqaxPrcTvA+LVINGOwFq
         CYU0UiWWrqwLrnbCqxxIXmwJsTqguoEa+BP5edZf0iyVOzEcS0+zUxBsetdaLcNAZmWd
         E+Bw==
X-Forwarded-Encrypted: i=1; AFNElJ/SYpSjkbwFXL7kUtpjFXp/P4PFsIRiaf1nyTNA4dzz58iF/BnsMyl6efUkzVYF27AG0YEpI7lp4Etp2O/VUScU@vger.kernel.org
X-Gm-Message-State: AOJu0Yyj+UKwaT4R5jv89pyNjRSuE1WGmnJ0pqBmTkeVkPlrac3ganZJ
	3bYmS4gpNoGU9csbCGXSFjxFtU4h1vQH51Kr559bXZrI2r0d1/yA+SOK81o1Wudf+UdM/8SDWq0
	6BcIHFfQfNVpsPhaBI6bOWR2zKjdsSyT8pE7R9YBj
X-Gm-Gg: Acq92OFB6vXpsCL59dYOPDfKvFK1AMxPLm+BkRNpqfmdMdlqSKNW13x2Tlrqgg/+Atx
	N1zQ8a/6mWDJTpeus/ij2T2F0VQ0hSvWKFi28ysz+RTAnJe6GumbK0UoLN5q59sGTla82K1pxlm
	P0paBzPKapzxiyQVGReLabnGxO8erqFr65dkRI78zddkNrjTG/PAstlvsAUIJoqhe/b3mA23c+t
	e/d3an9qSEXXR34wrEKFot3AVZIsDzZmWV4gPGLicqBEa17t+DXczKSTSvK5GhF9QdEi99GXzPn
	D4o+XdaD2Af8pXmKKPzU0p8i+deumaV0GREqS+n0zVpOKFA=
X-Received: by 2002:a17:903:37c4:b0:2a9:5ef5:399b with SMTP id
 d9443c01a7336-2bd5e59a451mr241615ad.19.1778705946786; Wed, 13 May 2026
 13:59:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260513192347.4007895-1-florian.fainelli@broadcom.com>
In-Reply-To: <20260513192347.4007895-1-florian.fainelli@broadcom.com>
From: Ian Rogers <irogers@google.com>
Date: Wed, 13 May 2026 13:58:54 -0700
X-Gm-Features: AVHnY4IVv-8efHULzdSrgWZ6jueDxn830S8mqpMya5YLmFXhA6b4Uer8LQFi19o
Message-ID: <CAP-5=fXfD5bkhoufpa3aYU5mO4YiJ3agjG+vyB6KUU=o4vGADw@mail.gmail.com>
Subject: Re: [PATCH] perf trace beauty fcntl: Fix build with older kernel headers
To: Florian Fainelli <florian.fainelli@broadcom.com>
Cc: linux-kernel@vger.kernel.org, mmayer@broadcom.com, 
	bcm-kernel-feedback-list@broadcom.com, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	"open list:PERFORMANCE EVENTS SUBSYSTEM" <linux-perf-users@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 13, 2026 at 12:23=E2=80=AFPM Florian Fainelli
<florian.fainelli@broadcom.com> wrote:
>
> Toolchains with older kernel headers that do not include upstream commit
> c75b1d9421f80f4143e389d2d50ddfc8a28c8c35 ("fs: add fcntl() interface for
> setting/getting write life time hints") will now fail to build perf due
> to missing definitions for
> F_GET_RW_HINT/F_SET_RW_HINT/F_GET_FILE_RW_HINT/F_SET_FILE_RW_HINT.
>
> Provide a fallback definition for these when they are not already
> defined.

This seems fine but the commit you mention was added to Linux 4.13. Is
there a reason you've run into this problem? The oldest active LTS
kernel is 4.19.

Thanks,
Ian

> Fixes: 9c47f6674838 ("perf trace beauty fcntl: Basic 'arg' beautifier")
> Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
> ---
>  tools/perf/trace/beauty/fcntl.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
>
> diff --git a/tools/perf/trace/beauty/fcntl.c b/tools/perf/trace/beauty/fc=
ntl.c
> index d075904dccce..e1b99b8f55eb 100644
> --- a/tools/perf/trace/beauty/fcntl.c
> +++ b/tools/perf/trace/beauty/fcntl.c
> @@ -9,6 +9,22 @@
>  #include <linux/kernel.h>
>  #include <linux/fcntl.h>
>
> +#ifndef F_GET_RW_HINT
> +#define F_GET_RW_HINT          (F_LINUX_SPECIFIC_BASE + 11)
> +#endif
> +
> +#ifndef F_SET_RW_HINT
> +#define F_SET_RW_HINT          (F_LINUX_SPECIFIC_BASE + 12)
> +#endif
> +
> +#ifndef F_GET_FILE_RW_HINT
> +#define F_GET_FILE_RW_HINT     (F_LINUX_SPECIFIC_BASE + 13)
> +#endif
> +
> +#ifndef F_SET_FILE_RW_HINT
> +#define F_SET_FILE_RW_HINT     (F_LINUX_SPECIFIC_BASE + 14)
> +#endif
> +
>  static size_t fcntl__scnprintf_getfd(unsigned long val, char *bf, size_t=
 size, bool show_prefix)
>  {
>         return val ? scnprintf(bf, size, "%s", "0") :
> --
> 2.34.1
>
