Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFAC34A13AA
	for <linux-perf-users@vger.kernel.org>; Wed, 15 Jul 2026 17:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784136531; cv=pass; b=HkgtmDSztSGKc4bC1+1mOTCl5TAwXV6Ck3JXV1G9Ucasjej60LEVZ6kiI+InRXHysuztPsn4LI87MU+Xn0srhc+rGR8DUrZmowv8WVas5l366EaCXaXg1Qt9y0b1F5ybAVe0RBrBEC+RZ/8o6ONmQHu6V+xLZFmZ2R9zAJ772nY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784136531; c=relaxed/simple;
	bh=5dAnbTrLmFvuckhccVqS7EIp4cPDpWpqshG2pF+axYA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D1meoFBB8BiiaOF2OrMe8wRZTWLRH85+5boiQsU2lnHgJ92GpsdaWhtoZYWoMbvr9QJk5QQNqQq+nY3h9s47RFZ16CNrszujjkNLppclU1p0/bsYq89GJfYL571nHk6BjzpGgFIPYHPPz35ALlWUCHytmteg4gzcXfd3I1Kf3Aw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GGyVxnww; arc=pass smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GGyVxnww"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2ccdf36f63dso7235ad.0
        for <linux-perf-users@vger.kernel.org>; Wed, 15 Jul 2026 10:28:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784136526; cv=none;
        d=google.com; s=arc-20260327;
        b=EeRlPWdJI+SNtzEc0mgkOcJ6ktjOZqxLrDYpQaSgYRIquAD069H3FOUgLZGx8Dgamt
         513Huu6QELPfomFGuCxr0wmpa9ctZG0QyJSyoDucvW7EL2GK7+z41089847dy+fXtf/F
         iBbjYCGYybkZkwBulK0jSnX7OjawsifqkEoMt9tSy35JqZRiymx5r+ooNGCoyndQGLhF
         nP2ghr7JUmIEius6WG3W38Rvusj9NclErxYHMmQWX17uhCBtxhqn1t0jnHUjHFXfTB5l
         KGWKuB2K6ccrOO+jbk9fhl7c3FqLnzSUH7hwPKTfJa/KUbWqpahh113GBXXuICi7j9AK
         WvjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=n2QpUytHL57E90VGZcURTA5UPhWM2Ld5vyU+Vb1Xbyc=;
        fh=IA+Mw+fgIcSdhRYxiUKZUriArBUi+dRo9ZKpguywUjo=;
        b=Nkzc5sgc2vdvVNIvOsU9gKaxH3KpXZQo+ZOSq8Hpv8iluzIW+EoUCuNhPHgMBuE+gA
         kgENeso8GJAUrE6Fo79qn00KZPcM5dExFxhFU8t4T7XyAmwhmfg13grIcE1q/oG8MFX1
         8acNeehcxtEpNg6YV9qyYHsBcEdVGpF6X9gwD2EFHf+iQpcOk1F0AUXziGYE04wg2nwX
         Ri8G45dJbD/jOXh6NtQGMn5B8ZfmBFl8lGPNPTYWPQUfIm0wQFwiHk1aTHg+Mkf49ykc
         MI56hCw/PI+m5/Vc723VghyKZLhPQ/cOqqlA3bhO48F/oLCBWeTfwmoPxV0bkMrF0q44
         uKRA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784136526; x=1784741326; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=n2QpUytHL57E90VGZcURTA5UPhWM2Ld5vyU+Vb1Xbyc=;
        b=GGyVxnwwNQJSuuf00wGSD3tMitniNOrcmguhD3PkyDipyU9g+M7FVMFR1p22lfkCFw
         /XHMcRNZXvO7cRt6oni65llhE1rGvYeeRj+rU+BzJ5CfgF2VANl4o8/2oLgYqU6jDVIT
         dB2k0sR2vcel59xtUN2ZaKjcz3nkvKesrGf17aE+NYZkZdkj2gPglvhjKA9bww7ujPsg
         nNCnocz7lw1oPfSfGDTn+W7Tz+1z+HaSVwy6vuyGemF+2at/1C+CJ2XfC6+GB3H/irZS
         ckCvrQUFIJ1Q4ep7V3lHbjLbTsd/6tYAWWbi4E2mKI45gydIbtQ12hBz36o0unt0zhxl
         HX3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784136526; x=1784741326;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=n2QpUytHL57E90VGZcURTA5UPhWM2Ld5vyU+Vb1Xbyc=;
        b=Kg4mDKQQD4+nvMzajuVNKEbDjzR9OrLsNaILsHAOQa6d1AexiLlLm6/k5pU+YNDSA8
         PBVizKa8vYWUdfTa8O6vdY0uapwqBozOHzaLyXvXRydXEztMpAgvWXXjh6bke6+SJjOJ
         8GFnOr/bq5ChVsmiVYEUyVCP/MUwcaf3WMcifuy43IelnP5P27R1cmNnWss5+XzYx9Az
         XKVWCds3pcLiBFT74/1nrkF28QEBn58Q9CIEf9W2OzK9T37qYVcD7CABtm6b3m+mRcNl
         HWA3yqEOFX93KN3OE2/iwsCateE1EyGcxEu86btpsPfjyxBacX3aQZwWPl3tm1G3Kr/J
         d+LQ==
X-Forwarded-Encrypted: i=1; AHgh+Ro7cY+WS0B6QsX9qdsO+Nu/tvp0XD6Srm/CP3JRsAkV4jS4RNtxvW9j46jdZxg155QCqwEc+yDKIAH01hRq0rzu@vger.kernel.org
X-Gm-Message-State: AOJu0YxQreSWjnzlbDLpOdN3equBF/SigfE5yUNQvuwl7dsLHJJFSLDk
	O1NN4jWXBKVV+wXKBAzyWkRpXzWcflodpZV4TnPJvJwoEvzZveJAd09LkzRmmqiOvllEVtPqwlD
	Xf4tw86K+hODev9evQ7Amv8dXs5iCcuMS+LD4TNwH
X-Gm-Gg: AfdE7cmyaPD6xE/ELDygxbv8k3PvgkXROYb35oWAWe7fyF4tKr7kRtcicr2cKSfRYs3
	O/MiTMw/TTEeP7BWPxtgCVthkg/A7snboepA07iWKQLi9Qp2VP+XkJdmnLcNIyzWw3tuiPUHmue
	KqwSj6ME3DzmiEGkJHhc3nYJcPOjkeleFFhXtIfigNcCOKRTnxqHVJFL8a2Gm/OTR1Z7NeglM5u
	iy4UmPvuAKZHgVJqW6cVFkSRoe3xtVh4qRtDJchkHdSLxTY0vcXSJVKoRnu8cZoisa82GoReQSt
	R63t1P8K8SYKQ0TYUCqPiwIzeJU=
X-Received: by 2002:a17:902:f542:b0:2b7:b03d:9dce with SMTP id
 d9443c01a7336-2cf19a6d6d4mr27695ad.18.1784136525778; Wed, 15 Jul 2026
 10:28:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260714082810.3660091-1-nichen@iscas.ac.cn>
In-Reply-To: <20260714082810.3660091-1-nichen@iscas.ac.cn>
From: Ian Rogers <irogers@google.com>
Date: Wed, 15 Jul 2026 10:28:34 -0700
X-Gm-Features: AUfX_mwL65RFB8hPMphfEVEYVM1nR61m-lO2LY34KQuewBIUq4b9IckhTBvbDL0
Message-ID: <CAP-5=fVprA-R33Oyya-M-KxS_yueos7pMcSKF_VZ_5g+ZomRdA@mail.gmail.com>
Subject: Re: [PATCH] perf test: Remove duplicate include of util/term.h
To: Chen Ni <nichen@iscas.ac.cn>
Cc: acme@kernel.org, peterz@infradead.org, mingo@redhat.com, 
	namhyung@kernel.org, mark.rutland@arm.com, alexander.shishkin@linux.intel.com, 
	jolsa@kernel.org, adrian.hunter@intel.com, james.clark@linaro.org, 
	leo.yan@arm.com, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 14, 2026 at 1:32=E2=80=AFAM Chen Ni <nichen@iscas.ac.cn> wrote:
>
> Remove duplicate inclusion of util/term.h in builtin-test.c to clean up
> redundant code.
>
> Signed-off-by: Chen Ni <nichen@iscas.ac.cn>

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/tests/builtin-test.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-t=
est.c
> index 7d18cb6021d3..41dcfbf874f0 100644
> --- a/tools/perf/tests/builtin-test.c
> +++ b/tools/perf/tests/builtin-test.c
> @@ -15,7 +15,6 @@
>  #include <string.h>
>
>  #include <dirent.h>
> -#include "util/term.h"
>  #include <linux/kernel.h>
>  #include <linux/string.h>
>  #include <linux/zalloc.h>
> --
> 2.25.1
>
