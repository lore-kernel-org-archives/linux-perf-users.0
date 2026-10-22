Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792700755;
	b=vH6gUaxd14YKS1PZmNo/m19nCmYWLYHLhilCaMHyXtcpbk/RLjoUkMbHj+7SGAZLW1pG
	 ZAmC0BfgpdeXXS4JsqMmnsCh2eanWtYkFwmdV2BuG7tb3Evl0jjOKj6OHdL0csmQ69N59
	 lpTiOTLoLp9ua4JEvd4yVAZToygh3KeQX+wXXnKESF/ezOhN1r9zbYsf9EVCu2oSxNr5d
	 GHYBVhYgT5gs9iCawevSFByJ9NqaZF+eElrgsgiKxn99NcN5oJcAZSQ0HuN3yOfk3ei4R
	 I3zZ0zafO9zaoMmpxNrJdED/zmMG4Pd7QMNjV1kvuweH5qUA9paU1JUVM/UF7ynpZnA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792700755;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=ohzQSJP5dcBE7DIaDZLAE4oM6uGS5JLtCq0YA6VOYHw=;
	b=vOWBVjiKKtwfEgui9cGv9h0yLBj8ihsuiIyTF716rvAsnSiqqTgTLlY04G25Angzcgb/
	 MktxFZA1taTzqZCBB7AZ/hl5J/3Vt7ov5M7aIFjkZiiQvgULRFqdlPsqlA207YILRPq8i
	 rkkbawRXhPMMTIYTZNNX+xkNU8mBiqBXW2BFx8bFhBUT045IcqHWI89BC8O5Z32BpB8Vw
	 bAe2KzvSmxMIZ2yTxmHzoUoCYnYaXlZAOHa7NMkqUqAJu9D7YXdNS25nUm/fzhcCWVVQR
	 l8EkhkK5SyraROxKK+pNmxPBCTg+t79gBIKxulKWGvFB6GyAL9ra1j8tQg3Dd74o7jQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="G/GCJirN";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3C8C606A31A
	for <linux-perf-users@vger.kernel.org>; Thu, 22 Oct 2026 20:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=G/GCJirN
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CF521F01825;
	Thu, 22 Oct 2026 20:25:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792700754;
	bh=ohzQSJP5dcBE7DIaDZLAE4oM6uGS5JLtCq0YA6VOYHw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=G/GCJirNESU9Y4UgxNeRE32bubrJveoYORsY7TVwCDbZTTqOf1wk5xpxqYty1bOZJ
	 3xsIH2cihlV1k2iTT4UTLF8kUgGmb4p4ZRCVSvMnIhoK6jFqWkAbK684iB44T9n2Yg
	 YBhFBEVc9pEOC6w+p/RMXkOnrg6eHYpk8SaCwKKU9BnBav/5BQMDhGMIHXGrIRkcrl
	 cNugsaBI0Buo/h3GVJAwk5RJklFTvx4RY+DV5cnpWYPwe8x4KUV7LgQOD8BLZCUWcJ
	 jVgpHfJjH1fdv7H80xDAy5OB/A+U6HUMEcfzKcGmBA3jQscNTNdfBK72+bWKYrl+WC
	 ycA1zIoCi/Qdg==
Message-ID: <sashiko-outbox-181999@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 19/19] perf maps: Add context analysis annotations
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261022201453.1717523-20-irogers@google.com>
References: <20261021223905.715051-1-irogers@google.com>
 <20261022201453.1717523-1-irogers@google.com>
 <20261022201453.1717523-20-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 22 Oct 2026 20:25:53 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> Add __returns_ctx_lock() to maps__lock(), annotate DECLARE_RC_STRUCT(maps)
> members protected by lock with __guarded_by(&lock), and annotate
> internal maps helpers with __must_hold() and __must_hold_shared().
>=20
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261022201453.1717=
523-1-irogers@google.com?part=3D19

