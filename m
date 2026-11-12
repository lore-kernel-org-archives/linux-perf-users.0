Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794447525;
	b=1RrPTeLpZ60cLLyPe4/RtlT6M02HRAUoJUTxKva+y+4iQ8pIurrwxVVbKjS26uYgCwZI
	 9bJ5elQqIzMcqniAnRkO8SoI9HUbMH+sc0vtj5Q4zWPkzGmZLxvfCnjqm9DRPyCsSJhsb
	 6lPYigL8HVXQRwWkH8JyGNesluGNFgbtnWts+o67EYi8aiEZniQxJxH2S3RLtHwXafoXE
	 GbzBQr5dN/F5yLdVZUPqDKDBdXcL2456Mjt5OvQ65anxRBkf+xKS/E6lsKVOiee9/875K
	 5TsAJUVNuX9+g5EoEB5z6qnArvsNi6HTAGuJGwXy9us7AoD612lkas0hQQ27rXwv+GA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794447525;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=1A0FHHRkeZNu59qGXPq9bvmsKCRiK5XouhN7KZ6v/hQ=;
	b=LrPgG5f/LyrmC2tqqn9VMRwA+QOIKCTwhIv5WcLtTiBGnwadqw/wjXUvU7BR9+9SB9Ct
	 VD7+1EjXB7U+J0lh0xmrVHyMIhULba/Zf9vzL7LQi9NJa+Y15DeVbY1dAATUdNT7WamOu
	 /KQVEp1bTiAhiAc/yS/8MsGDIcSw0d/UxHo9xUsa1N8noaHNhzvyRcfYA9N1N1Y91uHLQ
	 P7oJ9JUXqPiXjf96qsyUxKr2o/g2lqvdagzbdH5Q2ZjSBEeNxLs3PTLyWEPZmT0Vcawu3
	 keOzb+OkiP3et/ei/r6NF1TuWjoOpRcfvDM/ThJQZXchOwWzC64GqlfvQ/7nMpFE3hg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="bM1aSUG/";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09DF8606A31C
	for <linux-perf-users@vger.kernel.org>; Thu, 12 Nov 2026 01:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bM1aSUG/
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEFEF1F00A05;
	Thu, 12 Nov 2026 01:38:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794447524;
	bh=1A0FHHRkeZNu59qGXPq9bvmsKCRiK5XouhN7KZ6v/hQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=bM1aSUG/i2jG43antmoG13A6/AZuGiBmCZgvIRGh8RanWzgZFov+yPWx7zxL2LZtL
	 /LjuSUcEKKnM6KuqS/ad53TzO+iP0s8jN1q2/pQqvmCKo4lP8AwuhiPhHhg3KVktyN
	 z5Us7KrjWm9YYj7yHmJNLHIVy3z1UWLOOX1FohjJPyHTwf0iro9pHawT1FqmKy9wDd
	 VCsO9BR3hswClkTrls9dzilHDJZU87BbgSHRq+YB9HsVZ++lT4glevNI3sdTzl/AFW
	 Elg4ubHn6kRMZ8cBVGpiqMu7lk0Yd9a/zKh6TyS7ExuEzJHbeVZudZLE3hSzOSgUKx
	 ZtydMG3QRgH4Q==
Message-ID: <sashiko-outbox-210078@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 5/5] perf test make: Add BPF skeleton build tests for
 clang and bpf-gcc
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261112011514.4032822-6-irogers@google.com>
References: <20261022204627.1813821-1-irogers@google.com>
 <20261112011514.4032822-1-irogers@google.com>
 <20261112011514.4032822-6-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 12 Nov 2026 01:38:44 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> Add make_bpf_skel_clang (CLANG=3D$(CLANG) BPF_GCC=3D) and
> make_bpf_skel_bpf_gcc (BPF_GCC=3D$(BPF_GCC) CLANG=3D) targets to
> tools/perf/tests/make when the corresponding compiler and BPF skeleton
> dependencies (libelf, zlib, bpf, and libopenssl via Makefile.feature)
> are available on the host.
>=20
> Verify with 'perf check -q feature bpf_skeletons' that BPF skeleton
> support is enabled for both targets and disabled (exit code 1) for
> make_no_bpf_skel.
>=20
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261112011514.4032=
822-1-irogers@google.com?part=3D5

