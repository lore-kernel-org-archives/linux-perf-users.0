Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.173
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795219780;
	b=QorfXOW0MR2CmYvFA0HTqKyAI4mQDQrVeqO31fJOIY5gWYouhNPc8s5AUW7WUU2tcoWa
	 ExkBFWUZ9HR/QaLcvk57VVZGQCVBXqWlu24dE1h7eFxv9GfzvhHPStIkhPRmnGDFx2CUh
	 YNB9EBhKfX2hV/teiQFYs1VXSiiUccu3H28tgs6y2YNBlo77XQa3wc7QgjlDpaVPPxAua
	 c3Y4zm2SVTkBNRlvclI2cAPNhOhj47J2yKw2oeva3mf+5fY88fvpmJGNvrfx+rvW8ZTCb
	 WX7g1FVQC8m/jrNYpcEkHhIWLSzC5YIT0K78NiBvZ72VX4AQUnQ6UchBVzu4LEfJSvg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795219780;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=+dMKHR5mBoEcX/ua+H4VZoPPVxYx9Id1gISC1lJtoPA=;
	b=I98Hpyd6/eqRAv5v5icLIdRGEpujTMDl7aOXtzWXq6R+/n1tgNqxU/mSVRSP1Vth/K2D
	 VlwXaBrwMYI0+JklbBtKTUzvZY/VraQSw7ulOnm7HSdpllRRNWY+cDMNHIx5GxsMd3UHN
	 LW91m6Z+tTdtyyu/bud+oi7PBS9/n99HZG48U/DBhj+aytimer2gMx+oH//7ihg3Bihgu
	 LYxwInIqY3ipKX4rWIY/V2HnS7sN8N3d/uHk7CrH3gghzuEAQqw81EbQ4oYkAmB5wb8v4
	 0IH3g0n3lrAMcIWHr6S1zQoMAuT2ztQcl8S0wuKfGMvR8crGZmoHAxPJMYAY6xDAlbw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=jthp5SZl;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.173
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFA00606A68A
	for <linux-perf-users@vger.kernel.org>; Sat, 21 Nov 2026 00:09:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BFA00606A68A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=jthp5SZl
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-54492d8a988so110261cf.0
        for <linux-perf-users@vger.kernel.org>; Fri, 20 Nov 2026 16:09:31 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795219771; cv=none;
        d=google.com; s=arc-20260327;
        b=ZArT/gzvVizI1sIdnmuN/zWGlVhvTJTtT0lGxbriFHZY7455wsJZ4PRL0WIjBgOM0V
         tkzMEM3oE9tR5geae1YSRoj7RWupi0hXRp490iBjjCFS0dKfO2L0j9RHNnwLLmD0inK+
         6Dma9LGBGxqzpPX6M1KkELYkCQF5VdijK7ufBJOxhm6eZLLsAXajeNFEMS8a6+r1+x4p
         qqdAR/VAa6ORiiU5uSYaqXr4jWE/FSHnhXAO/g2DNhazh28PSKX8SF5JxPAYxEAxbjwB
         eYT9eTbFom97QnX6oh8YOJO/M/73MlEDhRV9jbrfftYXD9gI7bwq4NHO+Sx5aYRrd4PF
         l2DQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=+dMKHR5mBoEcX/ua+H4VZoPPVxYx9Id1gISC1lJtoPA=;
        fh=+H2TXapxV5vBFafG8DNAmBpGrIGC4k3ivm2K4kZcHLo=;
        b=FCj1De4cYzJJYvifKv+pvvweYVrLJ5FErL0g7Lv2xXERm2XU39BEgVDlSQBDP5lGi3
         9DxUZBf8mzJxiHH8l5Ieuhdn1FztIh+wGCrLsKkX37tSDYgnjSzarowpCAtDye7gWKt0
         XbVu3MjV/M/lX8IUvVPkmI4oBR+UnHuoPjL62ujZnTuyS0nsrmXFXxfYVBWDLXumbYEx
         jPK1g09SqnDEFV5Mqu2eskfq9xf6N/ooieCrSxwJh//wSDnFD/d0tjI06b1sfwrpNv/6
         EJHKNjq3qY+HFoV5OTHb4YUvgvUttnF6+mizBpfe9DwOEwiFaxdL1qYO86SIR63CdIxT
         QGgg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795219771; x=1795824571; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=+dMKHR5mBoEcX/ua+H4VZoPPVxYx9Id1gISC1lJtoPA=;
        b=jthp5SZlNFH5Li07rOwl8E2YUU+PYSMZGaCyuJIp/cIYxT6CkNw2QiIroKUzQFksez
         wipihkxCvezdE5SCfv2K2QnCreL+hSCLRr1VxqL+kLwPHRH42wYCIAWJZCy15Lz+KEBZ
         LBl0BGjVms7doBoGRHOLs50QBEOIj3oUePQm9vDt4ACD/qsiyZ/lV5/oDQ6I9waA3rnr
         PdM9Qo6Cy3UJYQI06xLIEAsLXXXeajA7eHXKfabO0AmFS8ABtMM5W/ToK+NzS0IuwACP
         w7aarkUJWMjCC8kGviUxVScPJwxCqIqsOVRmNOqiygXBciL3Wu7r2liq5vtnwkQbPCCm
         Gi5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795219771; x=1795824571;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+dMKHR5mBoEcX/ua+H4VZoPPVxYx9Id1gISC1lJtoPA=;
        b=Betr4DjEUUZVTjBXObFrTsctvCnZJNwI9C4MsTQ+cYKSNpnlpFqfwvyYvllKkCWdAL
         7MnE6zy1UCObOZFwOfo+iGJCECS+nLBqYbSQqBGFJrNQo+u3ytTlMScBZafYBNCaaTfH
         24Sokb4jA3I8s2JYGeBKgk1rImuAjvS9v5GmLaXNCSJx0A5q9zmbV06lynxvZenB5Axp
         KuCaWfA201di/cy9mnVFlCDLj/2CMTbzRAqdjZhTrq9NiMuZ3xGG4S3Ui1AHaF9zcVaZ
         RWJ2ysSFv9WO61nHSGKRw8RoxLreKtjPfGiAlpJM/ugEXpBd3RAGng1qK2/dYA7zUxp/
         /CQw==
X-Forwarded-Encrypted: i=1; AL+hErECeHDGcFDPfmJzKWjq99F7rV3x1mQK+x+DWFwu47JvR9HSIMaZ5lfWgbPRAGj6L5kNcyFWh4YolYKRiA6pMxhh@vger.kernel.org
X-Gm-Message-State: APuU4Z8k58iW9Vw1eZqLPjC/5CY/P7WMe/uNR9Ik1dE91VeU27YlSdK5
	N1Pn5+bF+ljybPmqYE4xaQ/VBeypHFCPeqjb1QdOmzThIQIVvLNPb07aearVbkKhX8gVR2sCCso
	iVE0Kc7v7HptIUKJkvezVAg2dwKUw/mS4gXjURsiX
X-Gm-Gg: AZFdTZeY2+DGVZF+PRmKW50vhFQwftlevT7deOCAZfGpCtlDgGiQyL85VYKcGZDrolT
	JHXk1N2FEBKuSt+uxwKX6iMJ++WPqQqeDLuhMI6gwQat/UrOrFpT5AD1aCOjxJkwtWlv5XQyqx+
	ahz0XD7FEcnNRSZElVwPOpsUHIAlP7uE0d+mnhDxhBMm8u5CbxTt1fG+ATRErPvOqkVp6LdWY0j
	u/9+2OMwNI1hMpg68iMonpR+3tv1tRtGYYb7lgsrdB+7LYs0eyqrn9Rv4J2Mr26OfOa2+suHnS2
	gdlh9y+J9+taMeefVya2VinYVeJrJQfprKY6YOHfcLT15CazKzJqCr/D2VhS0HjCNRg8Tvp6unq
	vBQlTMb3bA/i08jsTxJzXU0OmPzZn1+efyHRe1z4gkN81BgsY1s7uYwOZyQ==
X-Received: by 2002:a05:622a:260a:b0:52f:8389:29e0 with SMTP id
 d75a77b69052e-55d87eb670fmr7626051cf.0.1795219770051; Fri, 20 Nov 2026
 16:09:30 -0800 (PST)
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261113164152.2095566-1-irogers@google.com> <20261113164152.2095566-5-irogers@google.com>
 <av_bGKcyato9YHD_@google.com>
In-Reply-To: <av_bGKcyato9YHD_@google.com>
From: Ian Rogers <irogers@google.com>
Date: Fri, 20 Nov 2026 16:09:18 -0800
X-Gm-Features: Aa3M54oEg23XwIywUM7xCazlV1aZ6ADuzxfe0YE_c6ZVLGLnwXlwTRPiuHL2zps
Message-ID: <CAP-5=fV+q=vMuo7kf1YroivHgboTNtcYzYuVp6iJ582Jj081Bw@mail.gmail.com>
Subject: Re: [PATCH v13 04/21] perf mutex: Use kernel style
 compiler-context-analysis.h annotations
To: Namhyung Kim <namhyung@kernel.org>
Cc: acme@kernel.org, adrian.hunter@intel.com, bvanassche@acm.org, 
	elver@google.com, james.clark@linaro.org, jolsa@kernel.org, 
	justinstitt@google.com, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, llvm@lists.linux.dev, mingo@redhat.com, 
	morbo@google.com, nathan@kernel.org, ndesaulniers@google.com, 
	peterz@infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 19, 2026 at 9:31=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> On Fri, Nov 13, 2026 at 08:41:35AM -0800, Ian Rogers wrote:
> > Enable -DWARN_CONTEXT_ANALYSIS alongside -Wthread-safety for Clang
> > builds in tools/perf/Makefile.config, replace the custom lock safety
> > macros in tools/perf with the kernel's compiler-context-analysis.h
> > annotations (context_lock_struct, __guarded_by, __acquires,
> > __acquires_shared, __releases, __releases_shared, __cond_acquires,
> > __must_hold, __must_hold_shared, __must_not_hold, __returns_ctx_lock,
> > __no_context_analysis, and __context_unsafe), and remove the redundant
> > macro definitions from tools/perf/util/mutex.h.
> >
> > Signed-off-by: Ian Rogers <irogers@google.com>
[snip]
> >    # Enabled Wthread-safety analysis for clang builds.
> > -  CFLAGS +=3D -Wthread-safety
> > +  CFLAGS +=3D -Wthread-safety -DWARN_CONTEXT_ANALYSIS
>
> Why is this needed?  Also it seem to belong to the next patch.

Thanks for the review! linux/compiler-context-analysis.h gates all of
its Clang thread-safety attributes behind `#if
defined(WARN_CONTEXT_ANALYSIS)` (matching the kernel's
scripts/Makefile.context-analysis); without -DWARN_CONTEXT_ANALYSIS,
the macros expand to no-ops.

It was placed here so -Wthread-safety stayed active across removing
the mutex.h macros, but moving -DWARN_CONTEXT_ANALYSIS to patch 5 so
Makefile.config is only touched in one place is cleaner and still
builds cleanly at every commit. I'll move it to patch 5 with a comment
in v15.

Thanks,
Ian

> Thanks,
> Namhyung
