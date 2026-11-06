Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793949674;
	b=1vu13xjqhDCK2HRQGfNQvvmwWdc4dsrXjhicTXzeSf7wg6A+7weObT99fExITdIJ89Yn
	 UTs6GmTeZ7y2S6dFBUvVF6EFxwXdv2SSKQGNc3h7VNd71YIEWNzKIfvCyTHOTQswPY/cZ
	 +/V/pGNUwFh2kwkw1qdTGffB2bHi0NCbhRvkNgb+xabsKmZBiIkKqECoK20uSzyn02oEu
	 BwOQ6rgBfSuGGSZQxeO7QBeTNa/DXFFjE9v7qqmxXi7YFayv/PiBvRVbfmxOC1PQIc64K
	 0Ji8neLNTufSKqsO6zmBe1l0epv9dmGXTyAGNwcHAc7f60YKZlk+zc4Jb3AnfEnJ97g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793949674;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=A23PcTUOCby8SajBk1fMyZd+oYBFDxdMx0vuZSO9tpE=;
	b=iu3g28rt4ucBalXW2hkhO2DrA4ke4AlSs37xWcpC0d96IkYR3iRHj+EMkI1eWM/6h+y9
	 trb4kNmwaICcYhP2bp1Z+67rQ85wAlgxwp726vAyPbFzWMvMTcISVzYIP5mTwAwZNRPSF
	 +/l+7NbFK7TNr3v6q4KOTH9UnrZ6C8cBahkko94WMsURTIaxEEn69vtLwU0HPa/8GtKVN
	 bISupKugzE4ZMF7mspE2ym941+KNbIFFZK5YAiNKh9qzBrB6lFO+lfIHzR1ZWCHFyqdjQ
	 SJdsjaqaKC5ukn8mqn4iMlKuGchfCor4b3X+/mILTi5HEC0qManS/1H4rT+0JlNXdHA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kRI36khd;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F455606A328
	for <linux-perf-users@vger.kernel.org>; Fri,  6 Nov 2026 07:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kRI36khd
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC3D31F0089F;
	Fri,  6 Nov 2026 07:21:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793949673;
	bh=A23PcTUOCby8SajBk1fMyZd+oYBFDxdMx0vuZSO9tpE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kRI36khdmyAWQJn2/GyQYVQTG7qAPFbyRNCa83Y831DfaRAU1pCOigT7IMN6gTW6+
	 P2uNU2TTkggkniV6qgL65ldD/Hl2Vz3TO9LuhrGTIEjk7mIt3ITnCXzC0lSD0ylF4q
	 Ik1uyKnoWPCJR7ia6wtscLUX5CAEAaLDMvqh2ap+/nAct06SnEVb7Dvl5+NtbQ/Tk4
	 Qt2O0z7Uor8tPdi3JguO4yQe3OEey8Cf/Ix+y3EWmDrXRzpiAl/ysvPbiNaNJLClkC
	 j3MvqZIxcmZCWZVP7iPxggOKWiLurGgEUZgaImCI2KwoINlAkeagK0ycZXlTOzRDzI
	 +6TDRbxqel3Ow==
Message-ID: <sashiko-outbox-200989@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 18/20] perf maps: Fix lock inversion in
 maps__load_first()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261106070344.329897-19-irogers@google.com>
References: <20261106070344.329897-1-irogers@google.com>
 <20261106070344.329897-19-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 06 Nov 2026 07:21:13 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Low] perf maps: missing Fixes trailer for deadlock fix in
  maps__load_first()
--

commit bda0f84617c2109a3143b88eed6e438e7afdd964
Author: Ian Rogers <irogers@google.com>

> perf maps: Fix lock inversion in maps__load_first()
>
> In maps__load_first(), take a reference to the first map and drop
> maps__lock(maps) before calling map__load() to avoid a read-to-write
> self-deadlock when loading kernel maps inserts extra trampoline maps.
>
> Signed-off-by: Ian Rogers <irogers@google.com>

[Severity: Low]
Since this fixes a self-deadlock in maps__load_first(), should it include:

  Fixes: e77b0236cd0c ("perf maps: Add maps__load_first()")

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261106070344.3298=
97-1-irogers@google.com?part=3D18
