Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792700681;
	b=tlO1qUF52AP2lxt7+tl/EvGyo71ZBCcRyOYP2ihKyHXG627I66OTZXgJ0jbsVojJbHg4
	 35xBg1rIyhea/Asm+0v8N/ueeWonasMrqBUU+WT/1I5yN2/W1sWEHcFqY5E49Y4xnT4kR
	 rXvQBFTkYpOli2nlaAOpjw6Kf0sZ+iCak1d0yX5tzyJuIuc97qrmJeHALV3eB5XjEOdHu
	 K+hgmYMbItmMGTrZQw0euE1jDFamf6nbPhD7vRo0rAD1LZPHxxzT/C5A016udQgvE8ftR
	 +X4At4pHXh5BFzcD/FYD7qTsn7SeiKCJd3XQCldvDhM9iYlO2gZEMZ8cIU+pQFA7wwQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792700681;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=CTsiUP/eolExzBfDMN1MZPqs7Tjy1rQrCtxL9XFuvLQ=;
	b=bCznRhQq7NfGuzdCq6BwgFsl0uAMKbeK0ZyvTOOhjoGzBuwvxFTrFUBUfyh/LS/1js+N
	 8mxkwpyPub77p11uWkVUbH1QIRDmIkwHdqqBXDSkNGeckS7xhYq/iUZy/o2dyInSrP2UM
	 8BAgjNI3RZr1gn50sxzaeiexy833GyWro1y1bk3sXM5/4wqyEXYDNf2AX3h5BBlMBsK4x
	 gq9Avx7CF8LlRvFVxwhFq9vHunGuhAQQRrNTVQ/qdFLZ13VLPLBs2wwb1JKjPibQEu1Lj
	 l9v9au5RuRYdmaFwJh+l06C8FYoxWEgASzF5GsAmiEiCaPTkiK/YmtIcB3hsajqsevQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=S1gGKocL;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0B3C606A319
	for <linux-perf-users@vger.kernel.org>; Thu, 22 Oct 2026 20:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=S1gGKocL
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FDD71F01828;
	Thu, 22 Oct 2026 20:24:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792700681;
	bh=CTsiUP/eolExzBfDMN1MZPqs7Tjy1rQrCtxL9XFuvLQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=S1gGKocLHyYC/HOPb3U25TqI0Mdy53EUYjVDdNMQkeYRka2LWKZAwuMpTsRYZaWHj
	 YoIZ7Pqavrt1jQr/U9CnUQ/fvYBCTCSFmiY+NGzUoFeaQe/Q68W5ZRvfXIkqV7DCy6
	 /N2pLIOilCDCWwRGCdnRYdTQM0hEwK5ySpStg6bapSH/CXaxlIcmqWwVRPbIp06wDW
	 gMy4MBScpoO+Pnc8juGHdOdYYBJSkNc04cPZUNikVVLpa4LUGiwOcSK2ag8a8AcZ+b
	 sFldi5vJJTu3+wGN0j3JzShi46SxVD30imY5l30C2yniG1xjYUOuikLCX/Q+1gjgda
	 fYkAWZLdHsLZg==
Message-ID: <sashiko-outbox-181995@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 12/19] perf dsos: Use read lock fast path in
 dsos__findnew_id()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261022201453.1717523-13-irogers@google.com>
References: <20261021223905.715051-1-irogers@google.com>
 <20261022201453.1717523-1-irogers@google.com>
 <20261022201453.1717523-13-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 22 Oct 2026 20:24:40 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> In dsos__findnew_id(), try finding the DSO under the read lock first and
> only acquire the write lock when a new DSO must be inserted or an
> existing DSO needs its ID updated (checked via dso__needs_improve_id()).
>=20
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261022201453.1717=
523-1-irogers@google.com?part=3D12

