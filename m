Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793766856;
	b=V2EUFanzBRaoUrQclH2C/ac1n6ME/c3Q57LMjEIyxqI+RD6ZxDXsAAyQHUR1fOQYNSDI
	 PFQXn2igTrk+3G7KWf3tGLEWKrma3m5Dg/cl9hUsehK6/f/QkJ5w5YUWUowo/JIXBZXIp
	 6DO6wN7fwNBddhwhNn4PIEJPu0bTem/2YM7npyLWUKsGmgUL8baLaR8YxB+eszm2jjJOo
	 sUui96v3VZFBskFteG0Rt5gLv6CoE6qk77dJ+3yGHN1sa2Vfh1Y85aLzpcf6N49p+wS24
	 tCpnuXB9cb/82ywQg9iVbEJHdEVLT+AzUznffQAbsNn1P9bhi1fzM6VYNUZeWC9VKGA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793766856;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=Z3Y/FZAoCpN0GdYLJx7lZ3YcXmXIniGnnc1FP6gTyT0=;
	b=Fpb8/KvWjoxBhkFeF891GY5f8joNk/EsJNuM+8noITWknCCIqAMCgVS6Q+58yXqpV9vL
	 5uGDXIQHx9v1m08mYriqK9Pb5h94YBzyksLr9ZWa7NmaaO9KcsMHyGnoeuYh0ECzOkh1L
	 O3xPAvYnSlUKiPd7OXc/gvz6VHHcRpuR5CtT2h/WrAjWX3GhEo8IktFH3My7021h5Aeyu
	 MFujKlky7wUaKaXa15UkSxWtk/xYx4wqmxuyGXVLdPYZFUDR49m4WbV9miGm1qATvuWbS
	 3lCE0ZOevOgZt15jMovuRMinToVGME0O4Xz4iKFubJ2ail/YoeKrDomBu53RPegAXTA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=F2dxasyJ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73532606A31B
	for <linux-perf-users@vger.kernel.org>; Wed,  4 Nov 2026 04:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=F2dxasyJ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27DBD1F000C1;
	Wed,  4 Nov 2026 04:34:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793766856;
	bh=Z3Y/FZAoCpN0GdYLJx7lZ3YcXmXIniGnnc1FP6gTyT0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=F2dxasyJP/ibyiJWqbaI8XHWX1hTGXrU1+gNoueHcKYypYLBD5FXXakCaVuisnr5f
	 ZKFBSnhupEkHrdqLN7+mKNqWhpSdh2wqeF2IVyy6et0ayRISa0X8Kf0IQfaBLkq7Cj
	 wIp1k4HSteX1cwja4q/9WJA5jq9paCWFgWGsqcITgtja4RJiniJtYSvlHBpiPs9+T2
	 6B7QcQ/uHFsUgHkZfabVBH8fYosk6MFIPKeC86glJ8T0QADn+ADutd/31leqS8TqY5
	 r9xdPTlRoFL1MK9T++LO7qlqJALhZFDWYOsNS4574piAlu/MVUrvlh8jtmGFDZo1o4
	 Mt5mK3+g9tiFQ==
Message-ID: <sashiko-outbox-196656@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 3/4] bpftool: Add explicitly sequenced -lzstd to
 libbfd feature fallback
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261104043006.1199857-4-irogers@google.com>
References: <20261104043006.1199857-1-irogers@google.com>
 <20261104043006.1199857-4-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 04 Nov 2026 04:34:15 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> Distributions like Fedora ship a statically compiled binutils libbfd
> that depends on zstd to decompress sections (e.g. undefined reference to
> 'ZSTD_decompress').
>=20
> Add libbfd-liberty-z-zstd to FEATURE_TESTS and FEATURE_DISPLAY in
> tools/bpf/bpftool/Makefile and append the '-lbfd -ldl -lopcodes -liberty
> -lz -lzstd' branch to the libbfd fallback chain.
>=20
> Acked-by: Quentin Monnet <qmo@kernel.org>
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261104043006.1199=
857-1-irogers@google.com?part=3D3

