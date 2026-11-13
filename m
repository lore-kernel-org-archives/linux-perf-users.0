Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794588569;
	b=TPH36wUQ+R1lzaRUJBmNYo4E8IBTXkAUbzDkjTOV3sdldXb0F6RGn2zgt5i72WLBEA+C
	 fMdpd/vxjT5fMlHPKbzrFYLgEYUtkR+C8un1s254PlhBMRcykcLlIV2KaMVHPbQEa8JeV
	 FMjOa5MEn304jgs49W10JSHnvs9H8cVhFUeF+wKwHfYdYHMAYMynajhbkTe1nTpahj3xd
	 sYsvfDG87RGS8HGKhiZbnXBevT1j4MfT7h9x6ti7871H2CuKliHFXlpTMkwJNnf/aaNjD
	 muDqgYa9KWuC/x3U9MLrjcaCen7kalI+Qqm54O2oPfDXuDMdBLAVcdiV9Zi+vEomF1w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794588569;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=YFihTVPSahlbDhnbSCfhTVMvmJEnzyLmU8I4ixnLOoE=;
	b=c3o7+3j0qfZHzx5RI+1hi+8YHNN/8fj/qh7ciLSkpOXdy1jFo5ASjeL8u2F2gantq9Qi
	 urNhrcQbtSR/SIzlrI74diT3dKMqdKcwOAddc9TgQ6xXYIciVCgB0xQY31gdzTTOAszPT
	 LZGI53ExI2WfAeRcuIUIsKSsO4sdkyVBL6vYgq/eByW3S6MBV8YlKf1u09j3W6vrs18Rb
	 BuzAikqyPbkwG1E0YULD8oLRzPRn5+hBVJ2BxWaY/iLdnKN3M1Ds6GE8MAcvXpp9ylMbl
	 7+439feAqftUPXlBg3uYZfqB1yYAY27aQ0CPRSSQtJTiy8NZ1/4lYfNPHdsvBxgg2mA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nBQS3txM;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20D36606AFE6
	for <linux-perf-users@vger.kernel.org>; Fri, 13 Nov 2026 16:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nBQS3txM
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 818B81F000C4;
	Fri, 13 Nov 2026 16:49:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794588568;
	bh=YFihTVPSahlbDhnbSCfhTVMvmJEnzyLmU8I4ixnLOoE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=nBQS3txMDYCH346MZ8U4CFytWFQ2d5mJQM1ZmvgkcWNFbtHzIrjVlEboUB3jd7tKK
	 DfR1L/rSk44X3ppRrGZqAY2NmLCIhwy1zF5fj8NM2+dygY2PGnkELUS5IRicIhV4gj
	 QqBFeDxnaxipdwNlZbMJsPuQ2e1SUMsGgTlJIo8BgdskqH9WmgpoGBPe8yxbkIqgUi
	 pDUwWy4TzCGvjWnpnabrZ9+9vWVXngNVf7PfBUt632ShOMftCHlGtf22X6hkvlUUev
	 0d+SO/q0PVVbnsIpTvfUzjFKxROlAh+7xaD/YW7N9GPFdWNpCJ+QTCzRoN6imYhrtw
	 7snNU+4x7YYhg==
Message-ID: <sashiko-outbox-213233@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v13 03/21] tools headers: Synchronize
 linux/compiler-context-analysis.h with the kernel sources
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261113164152.2095566-4-irogers@google.com>
References: <20261113164152.2095566-1-irogers@google.com>
 <20261113164152.2095566-4-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Nov 2026 16:49:28 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> Replace the no-op stub tools/include/linux/compiler-context-analysis.h
> with the full kernel implementation from
> include/linux/compiler-context-analysis.h and add it to
> tools/perf/check-headers.sh so future changes are tracked.
>=20
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261113164152.2095=
566-1-irogers@google.com?part=3D3

