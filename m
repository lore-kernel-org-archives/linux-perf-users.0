Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794811710;
	b=GkyKLo34O+i17UoRgxekne4tO/9ce2/HX7O2jN74YKSB1NAN7VzcW8yQrUcl0AYpfcmL
	 4Gl0AIw0ZBhYayr5YZGmsRGcV1atBxvvT/CG8Hc20A4ShYheVOBI30oUcRJQCL3E/TLBs
	 TchxV4QdGLBlHHyCLliFDmEKJqt4zSMRQpuTdCu8kSY+dspQZ9CSto5qJCaxrE+yM5mfi
	 ya9f3Vs4zGY+0fzlhczE1SvQow2Ss+0s2ggLJK9QDuha3h3w1WIdFEv0G8E9YpKiscwsq
	 p74PNeeKDV6sXypwYhFbb95NqVb3DccwHQkLtfR+hQmwgdoyzpKhIAN4rRbQe6Dlttw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794811710;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=gEePlUmAi36VKtxMRRE/llY+Vtza4Z2aBvhGX1Enh4I=;
	b=HkfbJyiFQu9/R/+RAV62aqyKXYoCMil2Y9cip1A0BrGwpw5sruUr26bnVGPF36MRhCMT
	 e1M9+NaI7XT/taVQ86MqOtIKCjxkUH/wcbLQ0xgiyNWfYr1jHU78tpa02DFB0Lr+ymr+i
	 qbHF68vIPHm9k6mL3qLnmh/bBtjohFC4A42+hB3/5XnTZ/UMyWuQfOZaynUrwE+jM4ed3
	 BTulfUJonJklS0FtQHwJRXPBaWFmyeGAsLjOcZekkkCJQg6W0yYQFvrXeLwLt7v4u2tXs
	 6St59qyyN/yE7NI6s74wp2uOdMKosE1cGPwPYFSy43OGZdQ8j3GgT4vHIOa5fK0OYBA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MUCcXW9c;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEF91606A332
	for <linux-perf-users@vger.kernel.org>; Mon, 16 Nov 2026 06:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MUCcXW9c
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BA621F000CA;
	Mon, 16 Nov 2026 06:48:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794811709;
	bh=gEePlUmAi36VKtxMRRE/llY+Vtza4Z2aBvhGX1Enh4I=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=MUCcXW9c0qo/eBUwc8aWdX7430/GT3zP6EswWGxFubWnKoNC1GhqHB6Jtl+kwSxfe
	 wa5bhmBkMBo+XbfDQRn9qCV1MHQQHg6xY5Rk/SHGySvaVdHn5MJd3lBf8mh1gCWtsZ
	 2sNy/7+L9dNHuQDGSDZwi9Uhwj//B9eIumcZPxEfrWdzRwbTwN90vBrxHVy/Y5Saj3
	 KfIXAxKkVf7k3i3WdWoBwcWBmMR0vxUt1BRHHDQjvz6nx/VLUiNmbY2N0E1/3GotMx
	 I4rL0a8AteNW/6cMo1qM506M5aftSyCLJLUc9bH7tvgDlNK8zi3DyLhFukcAB4VTPY
	 RAfqULNs1zopg==
Message-ID: <sashiko-outbox-216324@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 3/9] perf symbol-elf: Cache ELF program/section
 headers and defer symbol name lookup
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261116063435.2817923-4-irogers@google.com>
References: <20261116063435.2817923-1-irogers@google.com>
 <20261116063435.2817923-4-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 16 Nov 2026 06:48:29 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> Profiling dso__load_sym_internal() on large binaries showed significant
> time spent in repeated libelf section and program header lookups
> (elf_section_by_idx() and elf_read_program_header()) for each symbol and
> in resolving elf_sym__name() before filtering out non-symbol and
> non-allocated entries.
>=20
> Speed up ELF symbol table loading in dso__load_sym_internal():
>=20
> - Pre-load PT_LOAD program headers into struct elf_phdr_cache and cache
>   per-section metadata in a 64-entry direct-mapped table in
>   dso__load_sym_internal() to avoid repeated libelf section and program
>   header lookups during symbol iteration.
> - Defer elf_sym__name() lookup until after non-allocated and non-symbol
>   entries have been filtered out.
>=20
> [ ... ]
>     Average DSO load + sort: 22.433 msec (+- 0.260 msec)
>   After (libLLVM.so.21.1, --no-demangle, -14.8%):
>     Average DSO load + sort: 19.122 msec (+- 0.226 msec)
>=20
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261116063435.2817=
923-1-irogers@google.com?part=3D3

