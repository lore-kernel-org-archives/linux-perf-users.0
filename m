Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795512048;
	b=dEHZu/wR3KIhuzieRBMSinvPl2dZcVZbFXDFAZdjP9XAUCSlTJTLWHQ3oS/PIWXx1gZ3
	 AiXYn0fthtSXw6f4qlulkhP+L2PJTLjBDtBJ9Fk+MP3PPNBGTpYIaSzibIh6Y7MyspcZV
	 tR3ke+fFf6hfE1/pLWiinGjQYp+5mQ4UypjkjrMsGxPjGrzpCw0NPpdZZeWD2Ei337kQh
	 uygO9iXUa9lV4IhfQW0WnHgQ2NeWD2lUkiEUJPTHMDEVOGPMB8kddiYBXc5Js3rwgevVI
	 t7QjAP7Gvn/sXAbKIfzy5BnX9NF8gJOIgm9RVN+YxSTEOC2Klwscw2FM7bISujx3ZAQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795512048;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=l3RRdVYtAKNKRJCh1MckF45lYtvj8EL2shZGea1sytE=;
	b=2DwDTTNvPE2zpplhL3vBYr0+RyBU/Q9HNPKgVTHkerYd+tUtySP+2Paa97s3eBQAZdHf
	 uz0FCsHsSXkXR+DiyRf8fi+z8ZE7ROPDNXQ6l5tM3V3Z0mf8Nu+iq75mpN39SNb/WX4qd
	 NGshDbhEF3Zt5UmpSggtQcyvWkbXjIwKGJkLSPJuS46bTWppZAcfNmVBW3xUqYPPNuCsM
	 9IJTb/Yz4GNFw7Dgqsu7v7Lfxn1jwgANJxqPk+x3MswITV2UxbWltpoeIU2wEe47Cyc6y
	 XMspUZto9JXiqS04VHI83Ua2bhzYmnmBVagE5BdfAwzRZOlejvvtbwD2rWKwQJMLuNQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="ENFnLn2/";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E513606A336
	for <linux-perf-users@vger.kernel.org>; Tue, 24 Nov 2026 09:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ENFnLn2/
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F095A1F000D1;
	Tue, 24 Nov 2026 09:20:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795512048;
	bh=l3RRdVYtAKNKRJCh1MckF45lYtvj8EL2shZGea1sytE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ENFnLn2/rYZVShrR1TzxQoZNI0iFEqntDJTTsyzEhnVwcK3jNNpi6ZlreLOjuFpZO
	 iUYUiuY16ZayUw42sG77Gg4xXKMTM+zdB5/xHyD+C0q4+NUTfWvXhz9J1JgsE0tiC9
	 Yx/oidvrqSZ89klWAdskSpSJhFe6Y2eGXkEYR2hTq4iJ7wit6kibAKof3qfK8NoEg1
	 sT+PnbgB99JA8dQYmwYGXJFJ+kKN6mDoEJhjYuc4+5n9lOSEFdGbr2fXWeC8ilvYTy
	 RumSkf7oovV171xCIBbk8Jip3s4Pd/Wlvsaki+UX3VXnulFpqVrajrNmQYwL+toBgN
	 LkoF8uPviVmtA==
Message-ID: <sashiko-outbox-230823@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] uprobes: avoid postponing return-probe SRCU lease
 expiration
Reply-To: sashiko-reviews@lists.linux.dev
To: "Avi Weiss" <thnkslprpt@gmail.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261124091252.567037-1-thnkslprpt@gmail.com>
References: <20261124091252.567037-1-thnkslprpt@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 24 Nov 2026 09:20:47 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> prepare_uretprobe() reprograms the per-task return-instance timer on every
> successfully installed return probe. If a traced outer function remains
> active while nested traced calls arrive more frequently than the timeout,
> the shared timer keeps moving forward and the outer instance can hold its
> SRCU read-side lease indefinitely. This delays unrelated synchronous upro=
be
> unregister operations that wait for the same SRCU grace period.
>=20
> Keep the first pending expiry by arming the per-task timer only when it is
> not pending. prepare_uretprobe() is the only rearming producer for the
> current task's timer. Order return-instance publication before the pending
> check, and order the timer core's detach before the callback reads the
> return-instance list. These full barriers prevent both sides from missing
> an instance at the expiry boundary.
>=20
> Fixes: dd1a7567784e ("uprobes: SRCU-protect uretprobe lifetime (with time=
out)")
> Signed-off-by: Avi Weiss <thnkslprpt@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261124091252.5670=
37-1-thnkslprpt@gmail.com?part=3D1
