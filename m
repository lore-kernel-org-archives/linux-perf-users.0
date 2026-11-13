Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794607685;
	b=aG9dZIoR8hXIKQWqvK9mFMtlwXSq5uOmwBN40b8a7R32FvFofUDAEhldJJIAYog0sGC2
	 gNzs4ge7k2uHxeGdaM2Kb2eNU1NLZKHkw+8hLbngRbO2jbg5YvRUNLRzB3IQMP8MT25tk
	 nAIAgQYSNTaGRCasU/m64Y8DUwGiNkG8HQLcXDSvKH+nfnnZDg/Q81zLv9K+d7DV5ndmQ
	 qGJEPnI9OiEHho9Y6B8JL7VOlYEJM0AneCxdRVxcSGmcV2kN0bgG0N53s9gZBoVJ2grGj
	 OT0D+yRTuu7l4SMG+LR+ChIDx1x3OTUx301KRxBfHAXnx5tdTqMl07wQ/54zDl6M9dg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794607685;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=VNZWPe/iEJeBfiLc9ZZsiqu1OfRN+9gYoY0qaFKBKhY=;
	b=pe9y+Ar2SOvDtz/3xHoKnAdCdB7naogr9Ue8RyO45antZRYsxMiOO6/mofAR35rscZqg
	 oLOha9VO+HE37MzytfFWuXhbKxs9T4r9/fmi9HxPgIgbxQRerh29vA+JnnVKkcBe7b1Pr
	 gi69cDDXiGbuOjQs3IhaeyXghJkAW/8rTaSWhw2+hhd11Kza5YlDqB/Wx3BHA0TMCBKbH
	 v1ZpMzE7C7X8YUlyX15bTeysFCvYFbQx446xR260f2ZI+2ATVsEKLKc3cRuGnNMpgP7MK
	 K4goYLYIHW/j4nlYYzpn8aAm1i/hxO1d+a92Sh0cDRI/WPRfQFNo9nEPMlxCPNWhHEQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YPbwldnz;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B9C7606A331
	for <linux-perf-users@vger.kernel.org>; Fri, 13 Nov 2026 22:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YPbwldnz
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B94011F000C5;
	Fri, 13 Nov 2026 22:08:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794607684;
	bh=VNZWPe/iEJeBfiLc9ZZsiqu1OfRN+9gYoY0qaFKBKhY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=YPbwldnzmwe6ZMIqi3pQEFHn1f44TVB2fm8NSP4zn8fdSv7SwXbpGIPvlE0r+MddF
	 Zt9FPEfFICyp3ZmfWGknxDktCVyXL/PJJV28BA+dOBAquFdzPqwJnUtSj6OSSvyQQZ
	 nHomfgv2+407tLHTXX2pEO78Nx7Raefh0LFuMDFy9fgGJ7vxxlRD1raVYKJ4EBN+Xp
	 isnqbC3PUIBGb7PS7zA5fRvEioL5ZIZGwDVsxvKHUXWa7H5YhIQp27WzCgAG0MldDE
	 O6imTKIkkDOvNUoxvqf4Y0W/T/gYbYzbNqwWRSCECB0H7OEZS84KU9O7J6wf9cIPBH
	 AJYuLQShEDWGg==
Message-ID: <sashiko-outbox-213773@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 20/26] perf annotate: Use generic hashmap for
 sym_samples
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261113214850.3329699-21-irogers@google.com>
References: <20261113214850.3329699-1-irogers@google.com>
 <20261113214850.3329699-21-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Nov 2026 22:08:04 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 2 potential
issues to consider:
- [Medium] perf annotate: unused-but-set variable key in
  hashmap__for_each() loops
- [Low] perf annotate: DECLARE_HASHMAP() placed inside struct
  annotated_source kdoc
--

commit 0f2a111b069905a59af5949de2e5dc82c8c9ba96
Author: Ian Rogers <irogers@google.com>

perf annotate: Use generic hashmap for sym_samples

This commit converts annotated_source::samples to a typed hashmap
declared with DECLARE_HASHMAP(sym_samples_map, long,
struct sym_hist_entry *) and updates histogram entry freeing to use
hashmap__for_each().

> diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
> index d11add6424dc3..c6325040452f0 100644
> --- a/tools/perf/util/annotate.c
> +++ b/tools/perf/util/annotate.c
> @@ -112,16 +112,16 @@ static struct annotated_source *annotated_source__n=
ew(void)
> =20
>  static __maybe_unused void annotated_source__delete(struct annotated_sou=
rce *src)
>  {
> -	struct hashmap_entry *cur;
> -	size_t bkt;
> +	long key;
> +	struct sym_hist_entry *val;
> =20
>  	if (src =3D=3D NULL)
>  		return;
> =20
>  	if (src->samples) {
> -		hashmap__for_each_entry(src->samples, cur, bkt)
> -			zfree(&cur->pvalue);
> -		hashmap__free(src->samples);
> +		hashmap__for_each(src->samples, key, val)
> +			free(val);
> +		sym_samples_map__free(src->samples);
>  	}
>  	zfree(&src->histograms);
>  	free(src);
[ ... ]
> @@ -163,11 +163,11 @@ void symbol__annotate_zero_histograms(struct symbol=
 *sym)
>  		memset(notes->src->histograms, 0,
>  		       notes->src->nr_histograms * sizeof(*notes->src->histograms));
>  		if (notes->src->samples) {
> -			struct hashmap_entry *cur;
> -			size_t bkt;
> +			long key;
> +			struct sym_hist_entry *val;
> =20
> -			hashmap__for_each_entry(notes->src->samples, cur, bkt)
> -				zfree(&cur->pvalue);
> +			hashmap__for_each(notes->src->samples, key, val)
> +				free(val);
>  			hashmap__clear(notes->src->samples);
>  		}
>  	}

[Severity: Medium]
Does declaring key without __maybe_unused in annotated_source__delete()
and symbol__annotate_zero_histograms() break the build with
-Werror=3Dunused-but-set-variable?

hashmap__for_each() assigns to key on each iteration, and neither
function reads it.

> diff --git a/tools/perf/util/annotate.h b/tools/perf/util/annotate.h
> index 1b47c1156b9a7..495c8602864cf 100644
> --- a/tools/perf/util/annotate.h
> +++ b/tools/perf/util/annotate.h
> @@ -312,10 +312,13 @@ struct cyc_hist {
>   * presented. It is deallocated right after symbol__{tui,tty,etc}_annota=
te
>   * returns.
>   */
> +struct sym_hist_entry;
> +DECLARE_HASHMAP(sym_samples_map, long, struct sym_hist_entry *);
> +
>  struct annotated_source {
>  	struct list_head	source;
>  	struct sym_hist		*histograms;
> -	struct hashmap	   	*samples;
> +	struct sym_samples_map	*samples;

[Severity: Low]
Does placing DECLARE_HASHMAP() between the struct annotated_source
kernel-doc comment and the struct definition break scripts/kernel-doc?

Moving DECLARE_HASHMAP(sym_samples_map, ...) above the kernel-doc comment
keeps the comment attached to struct annotated_source, and the forward
declaration of struct sym_hist_entry can be dropped because it is already
defined earlier in this header.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261113214850.3329=
699-1-irogers@google.com?part=3D20
