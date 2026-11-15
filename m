Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.180
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794779285;
	b=rC1oTP8uK5OQXFA05d+pacGdpJB/gmXsnD/UJucq+F80xBrZiCFwIn1WXGhwDvM2Jyhg
	 Y0MTh/YhXtE0Hof06QOOE6KbjV8pzN4Jhoe115xRaNWHxxYJRR99nlB14pfBkyd+/Xw+S
	 jC7aWkumTldqnjGewC0uvlbRohYvdAPxKqQ6GmIey/KTL/XwZQ3FQYsuRD85oi0H4jZ08
	 4no9gnVTS1VGbU2bhzPTr2dgf210LtOU6/68VACE2eiMC2N4lEsosJV93rCmqidCzdS8u
	 IU7Q34f1Q5PfdrobqQOfJy+QGFCZET4GKRnLsvGEJmNElFaTwpO8wSuw+muAgMI4fKA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794779285;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=ljN6SGuoiRBY5PtAOwAHFb9VP3FqrLxtIxFUMqL78oA=;
	b=XoBaRFSRcyaiKp1NsmYZgn09Rh+XdCd3AzRpGbN3uGHsOMDaHbUUZQ3KiuzsCVZDj996
	 /OeCnkpAcWkhVEq3acRSjAy84sZVA9wNPTjExFSLd2kAbtR5cZulF5Ptr5ohbzd6seqJ/
	 wo2lM7B7IUDQshXQ8vy0xKzurV2J1wmOEx3HekUV4g9EjT5p6RihywvcCkoVCzjlQxcEP
	 qH1Aoip9XXer37Nq7kvpRyeMMWYfCC77/SyEaUSAtBAhXyHEpMxD1bEil1hWPQMpBa5nU
	 NRWZrmCCQVOyMOEXm0BrcKSQ3vvPzLujo+dAdY86cUU30pwf00wG2fXtSqPnH14Dffw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b="BGqj/a7X";
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.180
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00C6C606A31F
	for <linux-perf-users@vger.kernel.org>; Sun, 15 Nov 2026 21:48:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 00C6C606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=BGqj/a7X
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-55be673e029so210821cf.1
        for <linux-perf-users@vger.kernel.org>; Sun, 15 Nov 2026 13:48:04 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794779284; cv=none;
        d=google.com; s=arc-20260327;
        b=am/kXosKU2gLdfL4ZSlJD8/+hGpsY/dORnxXrw8iPgwstviIER92QDFNrwM3W82Qy7
         KQvcXqrdOMdjSQUt19uu9AA9oi0gu5Dz/rEhdybHW/ER6DiuvSVpBOmsj6TtAK4krMjR
         3apEIb69c1cGl36xrOEHjTZu6XV5yOMbdwuDR9rCiIjCamKTF4qlyocTNTULJQicJf5z
         7Gvjtos+8IRgQu+8RDsOpsC7P3HZhYCxjsLiSvyiibQ2omDmTmJLKrxILiy7GAbzbqZl
         M/ncdPc3i7SmtNhRLY2a+Cel6N3O8y9rXhI+S/RMFYDnKH04f3/9bnONtsfs70CEZnLL
         3s1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ljN6SGuoiRBY5PtAOwAHFb9VP3FqrLxtIxFUMqL78oA=;
        fh=vNUAgAqtHuK/GVfC6Dpj2lh8Yw6bczSH5S7MXvb4H18=;
        b=pxtPj/X7qUxwpfMnMRk7qtxpUcgddpRXkuwD/SbD9gKXwYSCeSbFzD1vExWR6Rz0Ri
         BGTomOLGE254NUXIyPk7DFfVC4EJ+XcRCf8VnL3gJ6UKU6dtjCEIZ89QjwcCYPHZsAf3
         YEdEJbphiX5V2FC+LxvgIUbVo7QYw20Om1V1vKDZ3k6/cWx8aa7tfOgZBupTtMy9fUIK
         VPKNzf98tTdfraS+V0Bfc6ZS3f4oSaPaStQ7h61gECf/MG2ePk7eySNgN5NxwlJNJ5t/
         TfdcBKO6IWdmu5NndbZYAFqFX40eCqd1D3BTCsHswA5YD00z6J+h3gsDWbiB5GNr5wxI
         A6EA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794779284; x=1795384084; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ljN6SGuoiRBY5PtAOwAHFb9VP3FqrLxtIxFUMqL78oA=;
        b=BGqj/a7Xdpt6jjmSRSiMpaIkC5OjXCjruiN2GUK3GPq86vtTB5lGkcYGe2c3nhQNIe
         9lCAQXS9BGCBo2zxAm7ue0FAIScPDkiFf8Tu8kM71BA0naC8V+h6v0SRfuX8YyyWQHcU
         6Bw1GmyFyrfCiKMXocDKViYauybk/r0GSGemNvZA2bUrGmAc/GZgDjB0aF32FjbnbzN4
         jD6D9UinJF0SEFiqxyKj14U+HRz4pqnGGgmWh/aboPNs0q4zuZWqEsu/Nbz8kCbqyPXV
         WQhh1dTPwH41DE3ZO/JiirC3n3lf3JuNBf69j3zcEvTdk0KWAbBJ5ggN/NUbysMcWUHn
         VZeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794779284; x=1795384084;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ljN6SGuoiRBY5PtAOwAHFb9VP3FqrLxtIxFUMqL78oA=;
        b=rmVBFLJs1ljISl/pBrgHvec0hrn1ZrhfEsB3UOwxszhXWFGLXzYDH5YaC0H1E2kwr6
         /y05Rehi5UM/Le6GaP22SE4R/lBoyuc84APBOcsAn1xlxdZJ7mg6pnzbH2iKZmtKZMro
         zRKThC3zZuciHH8DDHtJDaViRgyVrtdVXLr7Li3R4O2Lmo8CT3zvigzXwAYoQEEc/w6T
         R+hSVCiVX5JMEKyg4w20tpjYofrA2k6DSzHGKUzs6oxq3OKrKZZSEpXKvE+Q1ZilKEPR
         YSbMP2mzYcxKgx3kLCSowbamSrl2KZIIjKMCIduyEibAjH3knFSQfQLAy7ITmrZT64Ya
         dSsg==
X-Forwarded-Encrypted: i=1; AL+hErGjw2T9qLuRkq6NOkP3ZECpnHP93L77pjtPay5CTuahia6mOVTVMweL9mSFE4X4vToFIdZRCUjylzyHP4oeJRSk@vger.kernel.org
X-Gm-Message-State: APuU4Z9vuFH6KxfBkbM/bn1ibihWep/bMMdVNpd+AyxmIhE/eGuQgQLW
	I1UNzIuXYbPuHv6F21lXO+28uwaW+rdtjdQIlyPhVhzNJwGpIw1TOgOPpj8nuJUvn9iqun4aFPM
	SmOKzYNgP/xwrQ4r4vAehHbDb7lJO0GD9XwW27E4h
X-Gm-Gg: AYBFou2cU0STezugomejJA8qJnOxp56JaIeoVNTclPAb6+0VWEDM7OJKyrODM7fgPvf
	KOC6Zic78Q9PEqesh4QtdR7WG2LCgziOkVcvzSwtAiUt+fpHn82E99gbfr9OuIsepIoKo2ppXd7
	qyfcPCVYHG/kurwBFSzyqnTACT2dirHcmEdKkDkkl9UEZH1pyqZO01Z4adVQLBjyPdIXgrxfDnR
	LK4C/NIFuPCu79zjclmIETPaLkiuNsOtnlaUbeZjWgwgaCRQuErHgHh3SGR/O7tcVDO2v7IchrX
	2/v88tb/6+fgipaqpMmL8qLfKckLS1ywmZV3jCnK8jzUwTXEHR11ryGDsrI7QoTOGLJkoCv6ajv
	FMLkMsXDjm2ugj91Y8iHOY7agU91SYLBOI/mM
X-Received: by 2002:a05:622a:230f:b0:534:b7b2:634f with SMTP id
 d75a77b69052e-55c6888bc4amr25392681cf.8.1794779283515; Sun, 15 Nov 2026
 13:48:03 -0800 (PST)
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261115014102.2879372-1-acme@kernel.org> <20261115014102.2879372-9-acme@kernel.org>
In-Reply-To: <20261115014102.2879372-9-acme@kernel.org>
From: Ian Rogers <irogers@google.com>
Date: Sun, 15 Nov 2026 13:47:51 -0800
X-Gm-Features: AclHuK_IYVF9TNn2P3848BZK59RLBacsy1GSQiLJ2BeBGoKLmKRR2ByiO4eH4yI
Message-ID: <CAP-5=fXr6NceuDbTbJWnBn-pJJvDSB+pFUJESfgt7psOTwTx3g@mail.gmail.com>
Subject: Re: [PATCH v3 08/12] perf tests: Silence the libbfd probe in build-test
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>, Ingo Molnar <mingo@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, James Clark <james.clark@linaro.org>, 
	Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 14, 2026 at 5:41=E2=80=AFPM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> build-test evaluates the libbfd probe at parse time and the compiler's
> stderr isn't captured by $(shell ...), so without binutils-devel it
> prints "bfd.h: No such file or directory" once per tests/make
> invocation, five times per run.
>
> Redirect the compiler's stderr; the empty result still skips the
> nondistro tests as intended.
>
> Fixes: 523471c5163659c6 ("perf build: Skip nondistro build test if libbfd=
 is old")
> Cc: James Clark <james.clark@linaro.org>
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/tests/make | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/perf/tests/make b/tools/perf/tests/make
> index 7524de5228029e7e..e6d7ac49b5b1693d 100644
> --- a/tools/perf/tests/make
> +++ b/tools/perf/tests/make
> @@ -128,7 +128,7 @@ make_minimal        +=3D NO_SDT=3D1 NO_JVMTI=3D1 NO_L=
IBZSTD=3D1
>  make_minimal        +=3D NO_CAPSTONE=3D1
>
>  # binutils 2_42 and newer have bfd_thread_init()
> -new_libbfd :=3D $(shell echo '#include <bfd.h>' | $(CC) -E -x c - | grep=
 bfd_thread_init)
> +new_libbfd :=3D $(shell echo '#include <bfd.h>' | $(CC) -E -x c - 2>/dev=
/null | grep bfd_thread_init)
>
>  # Whether libLLVM can be built, which needs the llvm-devel/llvm-dev head=
ers and
>  # libraries of version 13 or newer, not just llvm-config. This mirrors t=
he
> --
> 2.56.0
>
