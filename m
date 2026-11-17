Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794946303;
	b=CLwn++2IlYar2PT2XgTVQj9bi8PruH3PzMhc6mnJpHePtAzZHHO0nra+OF6aA10fEojS
	 hJk0fqn2wP5MZ58bDINLRtnyKtppEMGfuR4UqAJK5XkgBCOhGhAV3sa0vXYH4Qr4JQxWg
	 cJPF6nCudJZvAcOYQDoBvoH33srM1BW05u9KVX8NS7eRAnOxDAQYktc1dBDrb6b4aUfku
	 muW/T+71RzeNeLLktS0RWkUb1jmOP+2sxqQDIoeCv5JBuqcbfWz+tVYIbhfLnquFhG+n2
	 tH7xsKvWc/Mgie2F2CMERt/M4CTYHOcY6rSqpz7PxOFQUp+YJ4g7Q/jo0YcUAiDMgig==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794946303;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=3jskWQqmH6R71iz4CbnW41rwkQRWSgJKDWHs/uEtsH4=;
	b=kSCBTs99sx5nsyz1juqCYPclLo/ftyDRG2wcSy3uZCtmWSudtt00Pfp9CmuP1ZSSiDEL
	 JDSSIRiaw8A1kcw8d2qOQCsvgknEyLL+mrU4rWsLhQR4vNfGNKfZNVKoZSz+WDkGirF2/
	 waUgkUC6xEdlt11rWK07H1CvwsJhiCS/xZ7RLARlpSS5LNfHfzZGxd7/goeDj9m+6buQg
	 wUb+NI+R82fZMPuBtLtRKctDkr89Xd51fgtTEZ20CBzduv+y6JH6gzJlhhiOg+duDZO1l
	 XJ7aGUI4+iENi8onjfJFb3x1PhALAbk+YYx4LhKcMVjQfeEhsY8TR0moF09/qS3bYhw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="TxAZ/96v";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34659606A31C
	for <linux-perf-users@vger.kernel.org>; Tue, 17 Nov 2026 20:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TxAZ/96v
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D050B1F000C4;
	Tue, 17 Nov 2026 20:11:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794946303;
	bh=3jskWQqmH6R71iz4CbnW41rwkQRWSgJKDWHs/uEtsH4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=TxAZ/96v/EV1GHrmVYZbqIPEv3EU2ZWUmoLn24soL8MQrWFGmx2lBE0UsKUzNffj0
	 UWMb/UY50hJhISCKnM85w7YjihkJvOCQ6KT/Fbv1wJsuSTHZg2vP82TREzcoiDuINw
	 hXCiCsm/r/3hnKalaKadtyZoRhI5s81xLKK7ZaZKtPR12vveTNHuk+90f0S+LWoMX3
	 AfGsGVcr5JWrQc43cIMkOS5pmaUrOsUkOfHOb4u2QhUUjqXt4kD04zRImJdysHapS2
	 b/9wUBurzLQYjNeABKimJzgZL2YESgiQUzW555+RoPFBPYGn1ZmdWvcV/GM76MFcCC
	 nPGO92o5OBGdA==
Message-ID: <sashiko-outbox-219571@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 08/13] perf annotate: Print the stats after the
 annotations
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261117200433.45174-9-acme@kernel.org>
References: <20261117200433.45174-1-acme@kernel.org>
 <20261117200433.45174-9-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 17 Nov 2026 20:11:42 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> From: Arnaldo Carvalho de Melo <acme@redhat.com>
>=20
> The instruction stats are printed from hists__find_annotations() before
> that event is annotated: the first event reports zeros and later events
> can report stale counts. The data type total is only counted in
> --data-type mode, so --type-stat without it is incomplete too.
>=20
> Print the stats once after all events have been annotated, warning if
> --type-stat is used without --data-type. Leave the TUI's alternate
> screen before printing, so the stats remain on the terminal.
>=20
> Fixes: 58824fa0087e1cb7 ("perf annotate: Add --insn-stat option for debug=
ging")
> Fixes: 61a9741e9f78c64c ("perf annotate: Add --type-stat option for debug=
ging")
> Cc: Namhyung Kim <namhyung@kernel.org>
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261117200433.4517=
4-1-acme@kernel.org?part=3D8

