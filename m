Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795560858;
	b=Nr9rB/fT2mu0yv8Zy+cKYYi31rm9XizOmOHIBE2z+/uK6Rl47M10XQZkilS3Yqpphj0l
	 qV8BvOC+iy0/m12pG4vRldR0gwe+fkPfKmpQ/n/5bBGu2edM2xnGbDZakTUhZvpskbVeE
	 5FtAtRKHuJEuB9nrqEWb67X1vn00Ydonj01qXaXRH7/MXpAC8276ilZw1/Bsb6u3R8FRR
	 YXx/b40CnY3uj0TmI1YP78mRSXo3SqYgmWJtI8Kop0vapiaCHkAUoVU9O1gS89hLRNnau
	 HhuSqBXLV0EvBDp/51yacuRiJAkSn6yqSD+NQ2m4V+CjNBStvmZmBif+xMWIM0xKNLQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795560858;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=p0X1eTEq7vOLdunUPkVqot/G+7SRyDDPaLmJzY2B9xA=;
	b=RfjUNODSOdHifwozzr/vcLwTHcqPYmMWKxfSIgXYOMUidpBpYOqfjdCCuWQk4LqU4COI
	 H8m+H2djWtsU1Uj2nlbXRtd4WidEjIZNz8GSYaqKwrxRQA9Fk5MqlBxQb3fl10CqorMgo
	 n48ajZbJHzZgpFCjw2IeBt1egyacBumwrOzNgEmhsZMebDAJ36Nd7MDoXPke5D9C4y0BW
	 4RPdGyBTkZl6dIS2bQZKNBgoXOoDIZyHsmiNcgxEOOAqJ53qec30NTo8kubijWu5H63QR
	 UEuVlw82s4p1OPtCE5aNama49AHXN46oT24IwRtIqKWCWPN3kWWQ0YB619INUom7sdA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="Li7EEa/9";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC8FD606A31E
	for <linux-perf-users@vger.kernel.org>; Tue, 24 Nov 2026 22:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Li7EEa/9
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1D391F000D0;
	Tue, 24 Nov 2026 22:54:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795560857;
	bh=p0X1eTEq7vOLdunUPkVqot/G+7SRyDDPaLmJzY2B9xA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Li7EEa/9n+uMDf1o/IBExzfwckyZ3o4FE+qNamCzOGGKVV/WxsERRvootvfbz3KAb
	 iBeREaRuW4e37eX7GXkdCNG5XYUNF2eM2d4lVQIjpbUmpsQkO7ZRuMHfMUC3rcqDFw
	 7OqF+JkTKXdXcQ83e5m1cA6F7dnkrb8YkZ8rDz3UA9xU6MOszozxlTHMh34PFlyBeX
	 LHh3g6GD7KSU9CNZT15ygVOiNQ0JtPSaIQ7o0MrWRPji8zXEPv4sJUagSrn2khEUNf
	 aMhXSLMCzDbYmassXtMou9RW/Y3ndf2PrD1yq7OzJzKGsMhKglggQo/3EiiOCa4lua
	 Yp3xSWxLvpRwg==
Message-ID: <sashiko-outbox-232169@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 00/12] perf symbol: Sorted array optimizations and
 memory shrinking
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261124223109.820609-1-irogers@google.com>
References: <20261124223109.820609-1-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 24 Nov 2026 22:54:17 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

Sashiko has finished reviewing this 12-patch series:

- Patches 2-12: no issues found.
- Patch 1 ("perf symbol: Fix symbols__fixup_end() for equal-star..."): 1
  potential issue (1 Low)

A detailed review has been sent as a separate reply to patch 1.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261124223109.8206=
09-1-irogers@google.com
