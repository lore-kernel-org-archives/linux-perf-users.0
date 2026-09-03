Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30D943A0E8B
	for <linux-perf-users@vger.kernel.org>; Thu,  3 Sep 2026 10:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788430900; cv=none; b=gqvxM7+Tjj4kPKd7Cfmmt7zHfI6ztoxbTRIcwZAdbQLGejbrcp2glknZZpV0EhSXdiZekoG2nV5ckEkdFVCN4aku7FQleX3HY7bGICmORYmYCjTksnI2Ty0ZXLFjRZfh+d2RS/2FNL+U27iQGY4NR65T9FQXT1xuOUy7flFZvyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788430900; c=relaxed/simple;
	bh=TjjtU+qDfEEKw9e8/AjB1v1kIHe1LuMjD3v8jzTTngM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=FsEfhGKTnr8uASd9mKG0F8PXvuMHj/QJXCEt63knrTtr/XNLp/dEZ+g+9sx2j0ucui6hjcnN8Zb+okGT2SvY82iKI6BodBZU5nxme9SAC+TOcn8kwFGbQCCStOurFX8uynRbm9BCGnPZSTXIp0XRMP+FHKRN0tPqAS5e9CRd5WY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SgrPn/c9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SgrPn/c9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3B191F000E9;
	Thu,  3 Sep 2026 10:21:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788430898;
	bh=coeRb2lFOjM84UbAg6FKaxn/oVh90VHqqN0+0glg4pI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=SgrPn/c9nkkvRydJRaY/nzW2v/+rl0Kb53NKfCgwkuPW6YiqtbBbUkfIo+XsdBGm9
	 XUaHM50GWGRWLqyn5Y3NAWcV+5J4ltwPtSzJ8sE7kKPygdc+MgFFp8lBhspGx6okrd
	 VfdIaLCCuYaSUi1VsX6tOB2MosEBd44/GLnAop+XU35bw+qxKWVaucVpq7mYvH8T+W
	 Hu1Vdgg5iskH+F3VdCZaPBq+7xM+1wJKGCLfH79y6LoMZbTJuvkfDk9Seq13xUmnVt
	 43jVbK9dYaT/wFAKX5Q9s4J/vn0mSACk0Ed42Bf+k/6XuwkbPao19j4dbFS59Ke6j/
	 hfakLPJGR48cQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] perf evsel: Validate branch stack before byte swapping
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mark Amirkan" <markdamirkan@gmail.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260903-sympwn-linux-002-final-v2-v1-1-7c6e4166b814@gmail.com>
References: <20260903-sympwn-linux-002-final-v2-v1-1-7c6e4166b814@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 03 Sep 2026 10:21:38 +0000
Message-Id: <20260903102138.A3B191F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] Out-of-bounds memory read and write in PERF_SAMPLE_RAW parsing=
 due to mem_bswap_64 executing before OVERFLOW_CHECK.
--

commit ecce0770a0ee5a1e1d8c053f5ba923c05679efc1
Author: Mark Amirkan <markdamirkan@gmail.com>

perf evsel: Validate branch stack before byte swapping

This commit fixes an out-of-bounds read/write in __evsel__parse_sample()
when handling opposite-endian branch stacks. It moves the overflow check
before the byte-swap loop to prevent truncated samples from causing memory
corruption.

> diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
> index d4cb455f4a7d4..cc0bc08577540 100644
> --- a/tools/perf/util/evsel.c
> +++ b/tools/perf/util/evsel.c
[ ... ]
> @@ -3639,6 +3639,8 @@ int __evsel__parse_sample(struct evsel *evsel, unio=
n perf_event *event,
>  			e =3D (struct branch_entry *)&data->branch_stack->hw_idx;
>  		}
> =20
> +		OVERFLOW_CHECK(array, sz, max_size);
> +

[Severity: Critical]
This isn't a bug introduced by this patch, but while you are fixing the
byte-swapping bounds check for PERF_SAMPLE_BRANCH_STACK, does the exact
same vulnerability exist just above this code for PERF_SAMPLE_RAW?

In tools/perf/util/evsel.c:__evsel__parse_sample() when handling
PERF_SAMPLE_RAW:

		if (swapped)
			mem_bswap_64((void *) array, data->raw_size);

		array =3D (void *)array + sizeof(u32);

		OVERFLOW_CHECK(array, data->raw_size, max_size);

Could an attacker provide a maliciously crafted cross-endian perf.data file
with a spoofed raw_size that exceeds the actual event size? Because
mem_bswap_64 performs in-place byte swapping before the OVERFLOW_CHECK
validates the untrusted raw_size, it appears it would blindly read,
byte-swap, and write memory past the event payload boundary.

>  		if (swapped) {
>  			/*
>  			 * struct branch_flag does not have endian
[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260903-sympwn-lin=
ux-002-final-v2-v1-1-7c6e4166b814@gmail.com?part=3D1
