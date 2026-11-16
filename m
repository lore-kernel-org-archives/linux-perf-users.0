Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794812883;
	b=WQ1wow6drOSfoGSVWk9ZlkrIUXzgi7l/cXiVIMr6w/qk1iO4ZncBGEncErRDviz8ZLIk
	 2429E8GzNnJyu2zIk7OX7aic5pXt6f5H/nzWBQGXCcoa4UWhRxlFrTN5VS1l7NElAB/Zf
	 AJ4qAPfz1MLo+0pJb6havpDDoUs/oSME71QBMdAeqowrtQ+NmkK8m3chXUmog0q5xlXuk
	 d8idSGdQIYgmX9qe/JrrWOoGOdwnWPbLug/5tMj12RX9Pv9nzn5Tso6tromca2eWV0X+E
	 yFz0SLVTqgTQF2IMjANcWWhciZUjHMPO9av7LdjC5y1Nre3GAjwhFgvhOHzDStTtjPg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794812883;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=XUIEkSw7I4kJqR/wDcPYs0XTVAky73S7hc1K+K4TyFI=;
	b=HSjaQzq4aqKSuLX3Tl7pJ+LPJ8r6hPlUiEFhN4bUIAbvl9Chk2CCEDscTH4KA4arQaDb
	 EjKa/hmmhmzTc/wrQa5HQ7SgisP+MMqSxmtQ0hxq0+MODsM8euuK1uEKzMmOse0Oabhfg
	 80N7ZCa7RGgli2vVgA6PTF0cMRHrJgUjfuJN2XqoNq2OOGYBfOXUa7uX4prB7+Ui/mpmn
	 gkzJC+uZRBLkVMUaOck7WpW6p33nE7rwiBPys3TJJEHxyTZ31IAXT+cmR49qZ9F44mjhc
	 qQSoGtpIvP0rG5qPv1ynFMrPT0ftVcwcg54XnMahO1fLJ7ywEZeYKp7N/EuMt3oPnqg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=l0GlBjfc;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E10F606A881
	for <linux-perf-users@vger.kernel.org>; Mon, 16 Nov 2026 07:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=l0GlBjfc
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90B301F000C4;
	Mon, 16 Nov 2026 07:08:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794812882;
	bh=XUIEkSw7I4kJqR/wDcPYs0XTVAky73S7hc1K+K4TyFI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=l0GlBjfcSQY/UNKUvxGgCJVdXyNmGvKGU/j5hJqttChvUpGaCIP/KXpaq5Q4X51H/
	 4m1YTIOfDuNeaj72DoY94+BR4nFQyF028BmIBWXhca6m7RWd2hJI+TAAn5AQmNT+nX
	 AkLKaeIuhZbDQVAOW1/tyV+dAPJNcBud3SlqQrwejFA4/V6dxr8PWLiKPIyD4/Sq2X
	 svo0+z5LeI/HcN3SStJmyKjws/SzQReqdRLIKi1B/zKwojVL3UBr2Vo4FBzUrfuRtG
	 cTOSZRTE72bhOQC0NitmO3MBoJPHfquhEh2kJy0mUSslyDxdzbAuk71k29Fgfj4q/n
	 oYrSjUfQI29CA==
Message-ID: <sashiko-outbox-216386@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 07/10] perf jevents: Add --compress=zstd block
 compression backend
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261116070038.2968725-8-irogers@google.com>
References: <20261116070038.2968725-1-irogers@google.com>
 <20261116070038.2968725-8-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 16 Nov 2026 07:08:02 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> Add a 'zstd' block-indexed string compression backend to jevents.py that
> trains a single shared 64 KiB Zstandard dictionary across all ~8 KiB
> string blocks (itself stored zstd-compressed in .rodata and digested
> once on demand into a shared ZSTD_DDict freed at exit) and compresses
> each ~8 KiB block independently with ZSTD_compress_usingCDict().
>=20
> Without a dictionary, each ~8 KiB block starts with an empty match
> window and must emit its own Huffman/FSE entropy tables from scratch.
> Sharing a trained 64 KiB dictionary pre-seeds both common event/metric
> substrings and precomputed entropy tables across all blocks, shrinking
> compressed .rodata by ~26% compared to dictionary-free ~8 KiB zstd
> blocks (738 KiB vs 1,003 KiB across all architectures, recovering over
> half the gap toward a single non-seekable 521 KiB whole-table stream)
> while keeping every block independently decompressible via
> (block_id << 16) | sub_offset.
>=20
> To avoid mandatory third-party Python package dependencies across Python
> versions, lazily probe three Zstandard bindings in order:
>   1. Python 3.14+ standard-library compression.zstd
>   2. python-zstandard (zstandard) if installed
>   3. ctypes binding to the system libzstd shared library
>=20
> When total string data is too small to train a dictionary, gracefully
> fall back to dictionary-free Zstandard frames. On x86, --compress=3Dzstd
> shrinks pmu-events-string.o from ~6.90 MB to ~587 KB (~11.8x reduction).
>=20
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261116070038.2968=
725-1-irogers@google.com?part=3D7

