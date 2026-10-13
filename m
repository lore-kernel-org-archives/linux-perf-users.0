Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F21EB56261C;
	Tue, 13 Oct 2026 22:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791930423; cv=none; b=X7e3VuVhiTT9CERJzyqKsdFkDOzCRyMjqZAVXUY/CFv4O5cIttHNbJhCLE/rfqXlZFX0pXFNsZ5mQ/7zXPhAjlv+MNxquwQzDSchax3UUfTbaNhYrbKyP4cgZUXH34FnRCh+L6JFsOdTabfFw2xMuvVLeMOQbdfNKuMVLFCLQO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791930423; c=relaxed/simple;
	bh=sEIrpFMFnOHxFLRCJUJoyFA3jIhqRGwbE58tvujmYic=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=XQkM1nk5rR0ZUXGks6tgan8pzhooODP+2Fp2/iuswOAgx1zPlaBcmSTXQ3f0iIDsz0glwFdyuJG7ERO/h0UEY1jADjHw0ydFM/qFFNuygYZDnLuCBXETcKnIIWSnVI5+H9mLyom9S3wqks9TIKHV2U6AwhRNtI3S6M8vpEOP3AY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZmelaPd3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZmelaPd3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85F891F000FF;
	Tue, 13 Oct 2026 22:27:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791930421;
	bh=BWLHpNDhUoFqrvHhAvfyFqkwTeOW6MkdyXRqMWS1DtU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ZmelaPd3dy2y9oKnYm85a/D3MIKUdNUBk6A1ZLQSm9yA+g7Ja4Yj4TUgkrH3VSezR
	 y4+1B1jPZfmAVJ3T6deM97T3Oeo+Tdexcu2o0X619w99cEUHQfKwF2I+RdUIX9/S7a
	 ximNZGuvhGnWVr/YlPcO1i90GuPKKkdX7eC5opm6HBZ28gOk0uYdz+Fo0IQzXfpTpM
	 8ro4o9FnhCQoA98R8otL1bX0q+XSgYe4/+TJ/4A5BmRyQmNpjRRpyVYkPbtgNYETvA
	 OTdbH/cvGPwfwRH4qTP350csAQuM+W1E9awnTukllfHk4n+01dr3lRRlIvBgDKDFn0
	 qNo/buAvI7E4Q==
Message-ID: <sashiko-outbox-170578@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 1/2] perf build: Support building BPF skeletons with
 bpf-gcc
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org, bpf@vger.kernel.org
In-Reply-To: <20261013221643.1815686-2-irogers@google.com>
References: <20261013221643.1815686-1-irogers@google.com>
 <20261013221643.1815686-2-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 13 Oct 2026 22:27:01 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] perf build: bpf-gcc version check bypassed due to mutually exclu=
sive GCC arguments
--

commit b2c0a31ec137ebce8b46644a6edfe507e7c3b298
Author: Ian Rogers <irogers@google.com>

perf build: Support building BPF skeletons with bpf-gcc

This commit supports building perf BPF skeletons with bpf-gcc (>=3D 14.0.0)
in addition to clang. It updates the build system to prefer bpf-gcc when
building with GCC, and falls back to Clang if bpf-gcc is unavailable or
too old.

> diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
> --- a/tools/perf/Makefile.config
> +++ b/tools/perf/Makefile.config
[ ... ]
> +    define check_bpf_gcc
> +      ifneq ($$(call get-executable,$$(BPF_GCC)),)
> +        BPF_GCC_VERSION :=3D $$(shell $$(BPF_GCC) -dumpfullversion -dump=
version 2>/dev/null)

[Severity: Medium]
Does passing both -dumpfullversion and -dumpversion simultaneously cause
GCC to fail with a fatal error?

If GCC rejects these mutually exclusive arguments, the error output is
suppressed by 2>/dev/null, resulting in BPF_GCC_VERSION evaluating to an
empty string.

> +        ifneq ($$(call version-lt3,$$(BPF_GCC_VERSION),14.0.0),1)
> +          have_bpf_gcc :=3D 1
> +        endif

When version-lt3 is called with an empty string against 14.0.0, the
underlying awk expression evaluates this as false (0). The outer check
ifneq (0,1) then evaluates to true, unconditionally setting
have_bpf_gcc :=3D 1.

Can this regression result in the version check being completely bypassed,
allowing older, unsupported versions of bpf-gcc to be incorrectly
permitted to build BPF skeletons instead of properly falling back to Clang?

> +      endif
> +    endef

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261013221643.1815=
686-1-irogers@google.com?part=3D1
