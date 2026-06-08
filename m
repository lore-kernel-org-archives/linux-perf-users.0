Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D29B3DD518
	for <linux-perf-users@vger.kernel.org>; Mon,  8 Jun 2026 15:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780932755; cv=pass; b=c3QOPZf/+FoifTKXX/mON73TWe4/jCodNZgvJZkVFJ8/Qol+Ja3M2LAZHBLaUiDtG5wvadeRotWElm5kvwC6PAz6oGjiXP1SCiyB2W5pegmdVAV4VyOXCw0/WxKeot0fh4Y0PgtIJXzX8ZLu8AWy8ipN95hn+bJrAiJCrslzwY0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780932755; c=relaxed/simple;
	bh=cP6jWO/bJAfePjlkjw7xHqaTWVKpsaF8TspuBsVRkQM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oR/odSgH9j30h7X4IoQzSu+XFVQke7MhRh6qOhc5rP64lEjpXynfofNhtmtpFs17wqgf/HPBJQcwWmISxfPKReZbRgVIx9REfEZjxwGuwSx2geO3ze5uGIWikxU55WS4Zuxi1KkCKKL6kVXdNsVo08GhMpeekxHRF90jySF7xfA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UJ/fkiNn; arc=pass smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UJ/fkiNn"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2c0b1a48855so394825ad.0
        for <linux-perf-users@vger.kernel.org>; Mon, 08 Jun 2026 08:32:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780932754; cv=none;
        d=google.com; s=arc-20240605;
        b=WTMs3ZswxD5ZSoemk/LWJUg6dUdLXz6KeqMbRGawziEVbx2YYcUWRcWnd/fswQZJ4K
         /p7+vTwJNJjXu6yldOREUC0qtIh/1NlbCp0IuCYNk+traxje/A/pMCN1ndBdTqWVThdO
         CucIb0D9Kq0ZJ//E7SMtilZqIsr+isZxHOUiyHXEN+AQYqO3U46t/XiggOMj4gwD7dwO
         AJho+ZeUT6SdXQecNg7S4pzRIooPhC+TXWS7C/gxUjTDq0U1ThV13eU3phRervUZikk6
         f/HOWY0JEVRJ2yPph1ZXut77QjZOVr/6ljVZ2Jap2rDZ4iLH70i5DnNR8GwI2AnSyQ9s
         tScA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=IjrGvJx+UDN2wBLVOXpCzp0d4KmmngycB4ETVbE9LMo=;
        fh=dzAxbUGcKZpvJWY1rRZDUkRHqzfHsm5YygJdVAcBPOA=;
        b=As1rhl3hyAH4nZPvLhNeLgC+uuD/7ObhojmOr62XXDnmM2fCd9/PehAUx1HDY6JDPH
         VOnlxetrdLWP+acKsMqM5o/ZPuTUMpV4BHgEsLO3BzsmvGRZgXTfekR/N6D6Oxv7qkNf
         Xt3+6xim85xSzPC0UviJZg/Xfp+arTlPIzGdMaeeyO6+7G8LkHY6Xz/TltpKzd6cuDo7
         UGYlNgj8iLaARYl32SHkjdHkdJjr5FbeRI+DJhgh3bUgNb3BdHshIKOPFXOWJ0sgCQiW
         mKNt2jYvl+Rbv2XZHZoQFTbjCtWa6mmBWLohOVj8jtm7FPv2TITS1HM4e+gEBClEJeln
         w8sg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780932754; x=1781537554; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IjrGvJx+UDN2wBLVOXpCzp0d4KmmngycB4ETVbE9LMo=;
        b=UJ/fkiNnOXMKzOsi0c3HPXVadyZ4PlI/rC/E3BQ01ubl83w/QyDzOW2oiXLjfAWInE
         j1boH6qCJlpflsInDJT8j3cakBwzapsShK4ouqAy44ctdM/Usk9/NHPYYv+X8NetmXlQ
         gkmnvP2Bg/s/Q4EhEurM/sQNIIe0xsD4EjF2A5MD/qNQOVIAP0Rcl2Yevzx/+WTHWLYz
         vmMWeA7fwEFFuwuVYGDVRhG+BHmGPbSDeItN/8xDcC6Z9DjxQty5uiZo7Hc7gefS006I
         1sGSfXMELs1yQP9f2CSqqt0iBkNNQMaPG4wfvX2xCzbYdBHeU0NWQoGb0hjUj/zwNTth
         sDiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780932754; x=1781537554;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=IjrGvJx+UDN2wBLVOXpCzp0d4KmmngycB4ETVbE9LMo=;
        b=EnDqOobpizieWv/rxfN1K4VsKFOS937cXxUaeIzjhdbzQ6HZmd0K0Tby6yBWOaaECo
         MD9n+JLAbGPDToUl282vvPoITvqoHELo9Wb6GVVa2xAiBFJjCLo6B++4Kf/lXIOYv4IY
         khzIaZRYnXtFpKUZRCFbd9AXNKKuaaP7fC9nRiQ8ag9RfGZoKMCkPXpfN0pxteQZmQdW
         3usIgO64RMSUdgEmkuOzy6oHxUJ5pTzfcIsLePN+1BQhTNxZDYJKXxcPst/7lo26aHlF
         ZfsMRUHP9G418YxfqWYudWkQELjKAgW1rHAcW7eLq/tR4gsu61+Mv97NLFlXwz1HCsl2
         gBKg==
X-Forwarded-Encrypted: i=1; AFNElJ8ZToZuRVbzvDN8/jOQhqIXPiVTg1ywqddejC15ISvUDLN/reIgjfzlY+8gGG95ZsAoH0RR9rvmFzm81785BIAU@vger.kernel.org
X-Gm-Message-State: AOJu0YxPzzgdMfpML8xmFrIiLl/VxwuI39IVMmMysZW3lzuBc/W7/1mm
	PoAwgQg7KRNaosez5aybcfiDrJlava3DvrArcXRrKe8+OVzjTHW4OeIzMGqfWlrU5Ylg3wA1kNP
	UKBf+w0ZdTefzEPUHr68rqyQeJBSkOLamWsLpwOqm
X-Gm-Gg: Acq92OGkG2vI9xnX0lTZBBdSzxj+dO4Vjv1GRUNQan2ZT/8Sh7l2nZjHMCBdlygZyIO
	IwAh7IJ7aJUOHIkmNfG9r8rUpH/TLAqTwwjsDdu1VOrIfGqVYibbzRyi4OYOobdQRuWn4D62IOD
	bbWnTxdODHVZxZeK2dziFxJvbbDH4yjaNvO3wMB0Z8VZYUbOj41IoXTahYm4eKM0OFDWr3nN24S
	9RJ5j8ZVYhcw4QPTSoQtMxveCiyRUVASZ+9rBCRi46stDjwrtVrgrdm82UCG3FdqzLWJE/tpuci
	LOMOWKHRnXH4C/fdilEzyMjy08Fst3E52iW2YhdS/Fyw0Yo=
X-Received: by 2002:a17:903:1a4e:b0:2a7:87c2:fcde with SMTP id
 d9443c01a7336-2c1ebd874a5mr5706335ad.15.1780932753477; Mon, 08 Jun 2026
 08:32:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260608151525.2358438-1-jremus@linux.ibm.com>
In-Reply-To: <20260608151525.2358438-1-jremus@linux.ibm.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 8 Jun 2026 08:32:21 -0700
X-Gm-Features: AVVi8Cct-5sj4UH1vFOzW6hhpXDuVAkZNk2qIxvdH992OuD2gp2LWF9fQ0l1zpc
Message-ID: <CAP-5=fXP8uyQgnLLxvLoVoju_yk++zWWn3SX-qLmLk8MpmCwBA@mail.gmail.com>
Subject: Re: [PATCH] perf build: Respect V=1 for Python extension builds
To: Jens Remus <jremus@linux.ibm.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Jan Polensky <japo@linux.ibm.com>, Thomas Richter <tmricht@linux.ibm.com>, 
	Heiko Carstens <hca@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 8, 2026 at 8:15=E2=80=AFAM Jens Remus <jremus@linux.ibm.com> wr=
ote:
>
> Make util/setup.py respect the verbose build flag (V=3D1) by conditionall=
y
> passing --quiet only when not in verbose mode.
>
> This eases debugging of Python extension compilation issues and aligns
> with the existing perf build system behavior.
>
> Tested-by: Jan Polensky <japo@linux.ibm.com>
> Signed-off-by: Jens Remus <jremus@linux.ibm.com>
> ---
>
> Notes (jremus):
>     This patch applies on top of tip:perf/core:
>
>       git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git  perf/cor=
e

This is a useful change! I suspect it will need rebasing on the
perf-tools-next tree to come in that way:
https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.gi=
t/

>  tools/perf/Makefile.perf | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
> index cee19c923c06..c5a338ada6f1 100644
> --- a/tools/perf/Makefile.perf
> +++ b/tools/perf/Makefile.perf
> @@ -402,6 +402,10 @@ export PYTHON_EXTBUILD_LIB PYTHON_EXTBUILD_TMP
>
>  python-clean :=3D $(call QUIET_CLEAN, python) $(RM) -r $(PYTHON_EXTBUILD=
) $(OUTPUT)python/perf*.so
>
> +ifneq ($(quiet),)
> +setup_quiet=3D--quiet

nit: could this variable be python_setup_quiet to add a little more
intent to the name?

Thanks,
Ian

> +endif
> +
>  # Use the detected configuration
>  -include $(OUTPUT).config-detected
>
> @@ -747,7 +751,7 @@ $(OUTPUT)python/perf$(PYTHON_EXTENSION_SUFFIX): util/=
python.c util/setup.py $(PE
>         $(QUIET_GEN)LDSHARED=3D"$(CC) -pthread -shared" \
>          CFLAGS=3D'$(CFLAGS)' LDFLAGS=3D'$(LDFLAGS) $(LIBS_PY)' \
>           $(PYTHON_WORD) util/setup.py \
> -         --quiet build_ext; \
> +         $(setup_quiet) build_ext; \
>         cp $(PYTHON_EXTBUILD_LIB)perf*.so $(OUTPUT)python/
>
>  python_perf_target:
> @@ -1152,7 +1156,7 @@ install-bin: install-tools install-tests
>  install: install-bin try-install-man
>
>  install-python_ext:
> -       $(PYTHON_WORD) util/setup.py --quiet install --root=3D'/$(DESTDIR=
_SQ)'
> +       $(PYTHON_WORD) util/setup.py $(setup_quiet) install --root=3D'/$(=
DESTDIR_SQ)'
>
>  # 'make install-doc' should call 'make -C Documentation install'
>  $(INSTALL_DOC_TARGETS):
> --
> 2.53.0
>
