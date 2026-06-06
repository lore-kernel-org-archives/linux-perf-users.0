Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 732AE26C3B0
	for <linux-perf-users@vger.kernel.org>; Sat,  6 Jun 2026 15:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780759858; cv=none; b=IP1jMvTrx0efgrI3Q0op8AiwHNcXiOOw/fI89JTEkFFXEcaeCzUd3X1aqnVeRHojmuj33sSAsR955MX5FT9o2hf2j8Ttyink+PdWg9X8Dnpb8BT9kPS2n4hiDqgRfFbkdFUP0l6FTLwJj3anfuiXiXpt4olSrw6Scg1VIls64Cg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780759858; c=relaxed/simple;
	bh=fBcB5aOv01HL9fle7YizfpGLekUhNYtqZqhntWFFuSw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Ykq1ca3wU9GYm9Fdr1T+0Vyj08grRKPtyRccV2PgMz9fl0bmnqX3uil4ZDrgNmdBtZsuiou3+G0jhIJmJEC43sRNwKh0P33yrECngz37ZBUq9A6symsRkNjVtddBLLcr60PuxiHytj6+UFy+pFguJTm5j1VpVqwamDnQQpw1ubo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hh9pirDz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hh9pirDz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD6B41F00893;
	Sat,  6 Jun 2026 15:30:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780759857;
	bh=8LVOtPIanNoqh9ESd/V5T5weim2zt3YYVOE3JTC3gog=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Hh9pirDznKWT5U866QREOcQUACwgwto3HEPPXwuDW6BEUwfo78LpHowAa20axxSax
	 gK+B7R9mUGIrkv6JqrKqK5Vp89Usa740lA5s4nAY2nZZ4k7XEcSMDGMwy7KdIlGERI
	 hvfnAGplsRNE9ULFBp+KIePMp8nDDO5bsxb8C14Fd9wcsPXQgnlyaWxw6zJwklYElP
	 w4JutwISMsuCh/OoBEgg/FMhqZfZwjO/vcJQnQpMVRy2Czmf9oZMqwNs4GVFHw2Egv
	 seZhCjn82JnmsAYmWM2o0qUarKTATrvYfMw/QJ9zHLdHD17blqZHIlV2NRc8yzRUG6
	 bhSjYGXh7KZgQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v16 3/5] perf inject/aslr: Implement sample address
 remapping
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260606151451.2913860-4-irogers@google.com>
References: <20260606151451.2913860-4-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 06 Jun 2026 15:30:56 +0000
Message-Id: <20260606153056.DD6B41F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] The tool modifies the shared `evsel->needs_swap` flag without lock=
ing and bypasses necessary 32-bit field unswapping, corrupting cross-endian=
 sample parsing.
--

commit 3f98dbfbab405b30a77c04881137ca3c9d4c8fa6
Author: Ian Rogers <irogers@google.com>

perf inject/aslr: Implement sample address remapping

This commit adds the sample address remapping logic to the ASLR tool.
It parses sample events, remaps addresses and IPs, and filters out=20
potentially leaking raw samples.

> diff --git a/tools/perf/util/aslr.c b/tools/perf/util/aslr.c
> index 084158014dc73..7afa5a0dac2f3 100644
> --- a/tools/perf/util/aslr.c
> +++ b/tools/perf/util/aslr.c
[ ... ]
> @@ -597,13 +651,405 @@ static int aslr_tool__process_sample(const struct =
perf_tool *tool,
[ ... ]
> +#define COPY_U64() \
> +	do { \
> +		if (CHECK_BOUNDS(1, 1)) { \
> +			ret =3D -EFAULT; \
> +			goto out_put; \
> +		} \
> +		out_array[j++] =3D in_array[i++]; \
> +	} while (0)
[ ... ]
> +	new_event->sample.header.size =3D sizeof(struct perf_event_header) + j =
* sizeof(u64);
> +
> +	orig_needs_swap =3D evsel->needs_swap;
> =20
> -	return delegate->sample(delegate, event, sample, machine);
> +	evsel->needs_swap =3D false;
> +	perf_sample__init(&new_sample, /*all=3D*/ true);
> +	ret =3D evsel__parse_sample(evsel, new_event, &new_sample);
> +	evsel->needs_swap =3D orig_needs_swap;

[Severity: High]
Does temporarily setting evsel->needs_swap to false here break
cross-endian parsing and introduce a data race?

Since new_event is built using COPY_U64(), it directly copies the 64-bit
swapped words from the original event. If we force needs_swap to false
when parsing new_event, won't that bypass the necessary unswapping of
packed 32-bit fields like pid and tid, resulting in corrupted data for
cross-endian files?

Also, mutating the shared evsel->needs_swap flag without locking could
cause data races with other threads processing samples. Since this patch
introduces __evsel__parse_sample() specifically to take a needs_swap
parameter, should we be using that helper here instead of mutating the
evsel? And should we be passing the original orig_needs_swap value to it
so that the packed fields are unswapped correctly?

> +
> +	if (ret) {
> +		perf_sample__exit(&new_sample);
> +		goto out_put;
> +	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260606151451.2913=
860-1-irogers@google.com?part=3D3
