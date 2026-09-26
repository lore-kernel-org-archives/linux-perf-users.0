Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 050CE391E52
	for <linux-perf-users@vger.kernel.org>; Sat, 26 Sep 2026 06:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790404422; cv=none; b=rSN4VEV/CR+/vRRGTiY6M0B1dTeWM83wkrF8z8aQB2jGhmct2RVAfNCDlqOLI1ctZqJ7T5dT1IvgoDlpXuoKK2FuQieL2LK3xw6E82s83+8mFGC0Xo6wVZ1qODf29c4HQiUVE1ZXlM/RNJVPiB8eIdQbR+zYCLxbm6hjGL7pNgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790404422; c=relaxed/simple;
	bh=vJVIK+72bILW9/1OtTz/QrE7+onHUzIU6SOwZPLFYiQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=uddKEnn+gtpCCtiYpjaki47Otn9W8rCCaO2zSUW9uLqnzYrRhF0U+q2EdrArdBrBksYuf+xomVviFLhNvKPC3w1wDtGVKfyxFqinAKYczOLAGAwvI6m44it/if/7PyBb0ELBDtyMk71sX+YXkwBICkDqr/DtRYphL36HSTAeOqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A0Xcpo6a; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A0Xcpo6a"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72D581F00899;
	Sat, 26 Sep 2026 06:33:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790404420;
	bh=2tK/gNBgb/S8vXgUffhdLkQR6jBTJqpG6gFzoigk3HU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=A0Xcpo6auX7hpa2QCN2fpTwBpCEBCjHpM2QXNumMp2f6dbeOm5hf5tkbNm01ckZaN
	 yvzYLbnnsDLzu/1m9UaO1VJOfLW5HUCwljYuxvjXv7k1EvGjt4uajkNlhpx8IdP4Qu
	 SD5YSC1/1CJqU60TKSl4YtmU+H24J6YVnw0Lq/pRgDnto7zc40Xr1XoCTOg0bLOjCV
	 oX2N0wCuW74jqKTb6GEZj0P8Okc6weaDIhvXYbPoYs4jKHg0T/VY7Sd/IZ7j/oMzdX
	 MtRfzwYJ8dZEbk2lznbHIuniEKZqoTRJd/q2+IcxoYM4HxuKZBTwM5fqW+zPEp2GVf
	 Iba2s0/PHXcuA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 30/49] perf python: Port futex-contention to perf
 module
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260926062029.800743-31-irogers@google.com>
References: <20260923181213.3032038-1-irogers@google.com>
 <20260926062029.800743-1-irogers@google.com>
 <20260926062029.800743-31-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 26 Sep 2026 06:33:40 +0000
Message-Id: <20260926063340.72D581F00899@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> Port tools/perf/scripts/python/futex-contention.py to a standalone
> script in tools/perf/python/ using the perf module. Avoiding the
> embedded interpreter overhead improves execution speed by ~3.2x:
>=20
> ```
> $ perf record -e syscalls:sys_*_futex -a sleep 1
> ...
> $ time perf script tools/perf/scripts/python/futex-contention.py
> ...
> real    0m1.007s
> user    0m0.935s
> sys     0m0.072s
> $ time python3 tools/perf/python/futex-contention.py
> ...
> real    0m0.314s
> [ ... ]
> Add a shell test (test_futex_contention_python.sh) to verify the
> standalone script.
>=20
> Assisted-by: Antigravity:gemini-3.1-pro
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260926062029.8007=
43-1-irogers@google.com?part=3D30

