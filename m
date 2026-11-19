Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795079372;
	b=IiiXbQHJm0Maish2eojlAOQx3/Eg/7EqlOph32W2JSyYNQ0spZphEhiplJYu2dUf4SnI
	 0X2RRxhkjL87uEsoMfBgW7lzZIyZMLud5Inu/MQfEonwTYvaSB3w9zq0MAipPuIuWS9kS
	 7ucO5B9Xqji33mJaItLU9bWjwkOBD1GIbfvXpJWnzdnY1S8e8S8PiBllEUsNNEpvcOMBh
	 yKkwDAu3GKMFd1ATmZ8QqrdLFgGwkn7OKTLpqXbsJVH6745SHTdof4aoFQ5LKz4DFAorM
	 yIcCJ1CoJrfltD3SBa06h3GHaXUHDOppJEkhb8nzb1AfRXG2B0OcQP6fEypWqrjPf2w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795079372;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=UdQZEuCCURgpZ4msR7l4iHO8N59uE1drCFnnDNjYIns=;
	b=UWMH2ZRkb/SNT5DJ9Uu5w/RqIpW9RyNnARfj6zlMt+AgUBm2P4zsWMJyGojuHhHqRRaD
	 UZGtgJnKpHzgbh0UA7+253WNzcxJhju+T65Q/UGuSJcezd2bwLyI2Xy/MeiYJdQszFXz9
	 aBIlRVwJLKX9fOFU5u/JFdDbpwLJHbHtl+GL6qmvWfuM/M9CGA/IX5+sCD0IcuCmL/13u
	 ZIKWQSdGejam9fBjtKLoGep1TRNd3e199sHNIRCkt2HymnCemD0e96JsYVTZFxYQWdsSC
	 +dacoTBlgZ2RQ/i4D9+p89S4ifswH8qTxKmDAaXCEjQOUiNceip2xSxhHtZvJPLiRIA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="HJ0/HYBu";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17003606A33F
	for <linux-perf-users@vger.kernel.org>; Thu, 19 Nov 2026 09:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HJ0/HYBu
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8674B1F000C8;
	Thu, 19 Nov 2026 09:09:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795079371;
	bh=UdQZEuCCURgpZ4msR7l4iHO8N59uE1drCFnnDNjYIns=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=HJ0/HYBufpuycC2bobDpb8dVbxvzMuqaNZRWgxlsknnt7yXzHiSju/L7sTigZXoj5
	 fQ3XYn8sqXOzh4HAelDdLHJPRv5oZpqYlMktmUYfvHLs25jmdqVLa9dhs6ZnfDbD9C
	 ZbtQxXthq2aSydaZFJCKI5g08bTDlBSL8LiY/BHZq5opv42JafQ94HHG+AvVxpmz/v
	 KHfOgepU2lSJHIOg+EqP9OTCACi6N3Bz4Bz6rs9U1aPgf2dl8sHNnYF3RauyqKpn+Y
	 80EbAfoOlj2oNjxs+V/HXT/40jpsNhCQ8Ni6br1+LYLZ4LV0UtXCoLzs0p1hZU1JfM
	 eZyapz1PPaX/g==
Message-ID: <sashiko-outbox-222789@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 1/5] arm64: cputype: Add FUJITSU MONAKA definition
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tomohiro Misono" <misono.tomohiro@fujitsu.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261119-monaka-fix-for-upstream-v3-1-057df4d2ca3c@fujitsu.com>
References: <20261119-monaka-fix-for-upstream-v3-0-057df4d2ca3c@fujitsu.com>
 <20261119-monaka-fix-for-upstream-v3-1-057df4d2ca3c@fujitsu.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 19 Nov 2026 09:09:31 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> Add cpu part definition for FUJITSU-MONAKA.
>=20
> Acked-by: Mark Rutland <mark.rutland@arm.com>
> Signed-off-by: Tomohiro Misono <misono.tomohiro@fujitsu.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261119-monaka-fix=
-for-upstream-v3-0-057df4d2ca3c@fujitsu.com?part=3D1

