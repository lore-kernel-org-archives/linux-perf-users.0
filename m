Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B096E471414
	for <linux-perf-users@vger.kernel.org>; Fri,  2 Oct 2026 09:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790932393; cv=none; b=Wh0BGktW0n561tHxr7uPuUs2DWBEZmBz19vOYkO5q84EgMqRnIqP+dgWn+EsDXFrWQk0v/9iab5WkGG9PMtYmJPdyy6MJ6Hk53NKxTxYR1myRZ1ZP2XQ3PLDmSUZE0pMvVvX2VBo+7v0SKvntQ5rxAXK/v3pjSTowfKl4bEE24o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790932393; c=relaxed/simple;
	bh=9sCg4JChbynkR7quKqohVwxSLEcCPOGxXi3RKtUgGeU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=MukEnm4g5MRmKzCFR9Gnh3/u123s2V8npvqCfXJDhVQ9dEi7X/0vgHOAEixBgnEGIsQYLtQFOlkmW7+jiRVrWQSmobl29vRiTFXmaf7YUbHo4i2QpfXiY5K3pXCqLvDuNU4qh/+vw94H+HsGNVStnkUTxoB36RwjiDOS2mwPYN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RdvbfG8a; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RdvbfG8a"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F81E1F000FF;
	Fri,  2 Oct 2026 09:13:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790932391;
	bh=AiIEhTSgSnB1B35knmazPEQkOIkFWWfR42pGpKt/vkI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=RdvbfG8aYfGg3frXmLFh9SF1kQfw2VA4JLE5+EtMSEcJ035iSPkNn6+l9gKC9MfhU
	 C8Rr3kVNZL8bG02vSFz0eI6YLgCcRitgcF94X8RY9UYoRiH+gGWgKPjrm0+Ny7gGj0
	 n+2DGHmCTXtZg9tKfkyEZcOzk64OjMY51ip7yo6jhWw2gf0po3aywwoYXZr13e6rvJ
	 7wq7J2jBk12B/GdPcEp3gG270Ci886rECL3voSWpv9a7Zvx+yhpeLR7x265iI+lamN
	 vYK/NdL4Jos+/YT2TUTO+sORrocOgPw4LH41ZlPl5I6GHY/iVQPoneD9CnexKV9aGP
	 VAM6XwLabqbww==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 4/9] perf mutex: Add DO_ONCE() for one-time
 initialization
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261001185400.2754753-5-acme@kernel.org>
References: <20261001185400.2754753-1-acme@kernel.org>
 <20261001185400.2754753-5-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 02 Oct 2026 09:13:11 +0000
Message-Id: <20261002091311.6F81E1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] perf: data race and missing memory barriers in DO_ONCE()
--

commit 29753096ef417d4625af9a405f85df097ba45c30
Author: Arnaldo Carvalho de Melo <acme@redhat.com>
perf mutex: Add DO_ONCE() for one-time initialization

This commit introduces a DO_ONCE() macro for lazy initialization across
multiple threads in perf user-space. It mirrors the kernel's DO_ONCE()
behavior using a statically initialized mutex and a boolean flag.

> diff --git a/tools/perf/util/mutex.h b/tools/perf/util/mutex.h
> index b85a80ad60386..87937970615ff 100644
> --- a/tools/perf/util/mutex.h
> +++ b/tools/perf/util/mutex.h
[ ... ]
> +/*
> + * Runs fn() exactly once however many threads race to it, the rest wait
> + * for it to finish; per call site state, so multiple sites wanting the
> + * same once use a common helper, as in the kernel's DO_ONCE().
> + */
> +#define DO_ONCE(fn, ...)						       \
> +	({								       \
> +		static bool ___done;					       \
> +		static DEFINE_MUTEX(___once_lock);			       \
> +		bool ___ret =3D false;					       \
> +									       \
> +		if (!___done) {						       \

[Severity: Medium]
Is an acquire memory barrier needed here? On weakly-ordered architectures,
a racing thread evaluating this lockless fast-path without an acquire
barrier (such as smp_load_acquire) could observe ___done as true while
reading stale data from fn()'s side effects. This plain read also
constitutes a data race that could trigger ThreadSanitizer warnings.

> +			mutex_lock(&___once_lock);			       \
> +			if (!___done) {					       \
> +				fn(__VA_ARGS__);			       \
> +				___done =3D true;				       \

[Severity: Medium]
Could the CPU or compiler reorder this plain store before the initialization
side effects of fn() are globally visible? A store-release barrier
(such as smp_store_release) might be necessary here so that threads on the
lockless fast-path do not access uninitialized data on architectures like
ARM64 or PowerPC.

> +				___ret =3D true;				       \
> +			}						       \
> +			mutex_unlock(&___once_lock);			       \
> +		}							       \
> +		___ret;							       \
> +	})

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261001185400.2754=
753-1-acme@kernel.org?part=3D4
