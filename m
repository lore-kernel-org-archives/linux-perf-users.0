Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794809393;
	b=1vP/SDzbMJDEohFzEykRp0/UMTbnf0GLTEKs9afdGUreqb0z61tcxnxUYHv+K6XDJt+x
	 6Nq3nCtcWDZ3XwZT3fDzCvI9Tm6EAjbNytViDmUksaXQJHK9AUJ/OR6hxvGKlFLnRr5jG
	 fNYLFeNpX2RD2K9zR9rBgR7Y5wFdGqEpFFw+88yOTawjEyPt46JnKmJQnTtKzJhBK0Bfd
	 5a5gx66M2PDlsoCWhob9zSJRctcSGoQJZ7G0D2J+sccMoi93vyQ844rGTKDP4HwWDdJFn
	 8mAoqlSI8GjAKvnb7ZobxfPNH/AkUKVJWqCw8H6iFfwbZHBsMHwpLyZ54Sq86jhfDYw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794809393;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=bbMpbM+W/8P/OTuBS77gbaF7a/hNxdpbBAkXPNSERio=;
	b=NWiVcAYPw0IuawWwsmV2+ghDlOwk1PSNIuoFxTx8qshnAQjh+CSiHLKpGRlocflFNFrQ
	 +h0juPjn9dRauN9nQX+pUqtAycpxMUNguLfMoMTtAmRdnn3XKANuruL7eB1w/oBgsh32k
	 BZA2WzizRR2F6pBLMld6Z9jw/B4eerNO+r0RXABkC+8kgTAii4rxSJngLRwFBIsmf70t/
	 LIOgCN0EhBFSiZopIINvwR5fZcNHt9j8ZbILLh4nihFb4taVc8vFkN1hzuW/XTjOOMtXg
	 9V7Yu2R0YDSHH7XffJt0o6W1I4KCYo6FXasx+1L9303nPCTK9RPjYB5DUNCq6cJIbHA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WMB58SAg;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58A34606A31C
	for <linux-perf-users@vger.kernel.org>; Mon, 16 Nov 2026 06:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WMB58SAg
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC1341F000C4;
	Mon, 16 Nov 2026 06:09:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794809393;
	bh=bbMpbM+W/8P/OTuBS77gbaF7a/hNxdpbBAkXPNSERio=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=WMB58SAg8pxS6V/xpdX+0uMpsDA9tDbbBRXt2aGTpJnS+OxjkEukKndtk/qWPyxrF
	 k7zfMDIQN1NAf8PDkQHrl/n2G/VDfjbD2uqCpQea90frqvsMmm1e3t1HGPgE8dDfof
	 lNgqCiAEUBTw94GkeVtbKYYWszg+VgVDxT11E335vYIKQQ/7IGWOmZ0AXjO+hgV7+b
	 5OqTMlX5DHkw3z4Vkgj29rCQ1kvEN2ev2kJI6LYdc+guewj9PhGF5OuJVM4J8Fryc5
	 3yi5bqWs4c78B/bMMTjz1DtJNfas95px701SBqZ51HJHRmxLgxuO4gaPEKt8OIs4mp
	 iuBxoOHl7vU+A==
Message-ID: <sashiko-outbox-216243@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 01/11] perf tools: Add HEADER_BOOT_ID feature
Reply-To: sashiko-reviews@lists.linux.dev
To: "Namhyung Kim" <namhyung@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261116055731.707164-2-namhyung@kernel.org>
References: <20261116055731.707164-1-namhyung@kernel.org>
 <20261116055731.707164-2-namhyung@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 16 Nov 2026 06:09:52 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> Save /proc/sys/kernel/random/boot_id in the perf.data header and
> struct perf_env so post-processing tools can identify if it's the
> same kernel boot on which the data was recorded.
>=20
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261116055731.7071=
64-1-namhyung@kernel.org?part=3D1

