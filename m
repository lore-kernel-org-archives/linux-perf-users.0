Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27B023BCD0A
	for <linux-perf-users@vger.kernel.org>; Thu,  3 Sep 2026 11:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788434616; cv=none; b=p/O4N7KTYpwXsLzg5DGuSrL1NsOkCYOGdGQpXEoOxx1RRDc71ZvyakfhjBCOS+quFYry1vSH15OfqApebwRGyFYdLtFrgDu+JC4EOm8DjAE2UaZD4YGFQC2//YvXbHp2Rsdt94CIKz/v3KOh+HUOGMaAtspDS7ETGMCQ16vu724=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788434616; c=relaxed/simple;
	bh=d4RBpljnduF9t+x1qqT9PmaulhawSjx/jXXanoBLFHg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=aHvJUrvn4zV3hYM2vcQjfbiDEWYy4zbAK8uW/iqiw2SmcbWPIx4glKf+OyxYpK9ewtVTWUDbaaWSW6gnNQoBYf3yN9EtDKnSgUonSBcrVYY6nWx4EG9OkCCSx6Lh1R+sJT7QPUH1DlsWx0y3Mhcg5BlDvqoodAM9k+hQhzTZIng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VW656EDt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VW656EDt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B37031F000E9;
	Thu,  3 Sep 2026 11:23:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788434614;
	bh=X8KZj2YmvaKL3CFm5NRUubeGdA22XHzGab8R3VJKYmA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=VW656EDtreiPkk9Xu/jwaMM4j4Yzqonxa0fVESprlhpI7JBCPjawUA1pfxJilC2wX
	 Ff71n2JcXvNdIGKUi/wRKedPXu8aCni1apnC09b3Y0hlyIXnCI5t7JQEHWB6ajDAyu
	 bV300co7PCWbSJeufaQeSTWUveI3nQWZuEihoaMSJZPGQNnPxHlMSup4/IufsqBIwo
	 qymFn0CXLzCaT732gIbMLZIwqGDESpzWFPdU7GK69SCFNsyT8cr43hYIlvcfGnX+ML
	 wvry5CZSzuhiayITYyIIk7g+tK2CRiwU83fNcgeJ5lWo3R/i9kVdIgAnf7x43/f76z
	 dR9quvWYknZ+A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/2] perf evsel: Validate RAW sample before byte
 swapping
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mark Amirkan" <markdamirkan@gmail.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260903-sympwn-linux-002-final-v2-v2-2-0aee1fca1f95@gmail.com>
References: <20260903-sympwn-linux-002-final-v2-v2-0-0aee1fca1f95@gmail.com>
 <20260903-sympwn-linux-002-final-v2-v2-2-0aee1fca1f95@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 03 Sep 2026 11:23:34 +0000
Message-Id: <20260903112334.B37031F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Incomplete byte-unswapping of opposite-endian RAW sample payloads.
--

commit 859452a9d73dd9126684c09b88dc1d95342d3daa
Author: Mark Amirkan <markdamirkan@gmail.com>

perf evsel: Validate RAW sample before byte swapping

This patch adds bounds checking before byte swapping RAW samples in perf.da=
ta
to prevent out-of-bounds memory accesses when __evsel__parse_sample() is
processing opposite-endian files.

Fixes: f9d8adb345d7 ("perf evsel: Fix swap for samples with raw data")
Cc: stable@vger.kernel.org
Assisted-by: Symbolic

[ ... ]

> diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
> index cc0bc08577540..ce429eb247b6c 100644
> --- a/tools/perf/util/evsel.c
> +++ b/tools/perf/util/evsel.c
[ ... ]
> @@ -3584,7 +3584,10 @@ int __evsel__parse_sample(struct evsel *evsel, uni=
on perf_event *event,
[ ... ]
>  		array =3D (void *)array + sizeof(u32);
> -
>  		OVERFLOW_CHECK(array, data->raw_size, max_size);
> +		if (swapped) {
> +			/* mem_bswap_64() accesses complete 64-bit words. */
> +			sz =3D roundup((u64)data->raw_size, sizeof(u64));
> +			OVERFLOW_CHECK(raw, sz, max_size);
> +			mem_bswap_64((void *)raw, data->raw_size);

[Severity: High]
This is a pre-existing issue, but does passing data->raw_size to
mem_bswap_64() leave the trailing payload bytes scrambled?

When parsing an opposite-endian file, the full size of the RAW section
consists of the 4-byte size header plus data->raw_size, padded to an
8-byte boundary (i.e., roundup(data->raw_size + 4, 8) bytes).

Because mem_bswap_64() processes 8-byte chunks, passing just data->raw_size
causes it to process fewer chunks than actually exist in the memory footpri=
nt.
For instance, if data->raw_size is 16, it only swaps 2 chunks (16 bytes),
but the actual size of the section is 24 bytes (3 chunks).

Could this cause the final 64-bit chunk to be skipped entirely, resulting
in silent data corruption of the payload data when analyzed cross-platform?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260903-sympwn-lin=
ux-002-final-v2-v2-0-0aee1fca1f95@gmail.com?part=3D2
