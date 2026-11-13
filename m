Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794607160;
	b=bjAiBtPYJkPlacIouIGSAq9ye2mRCR5qUNCcdekIL1tqDtXg3eGJaWCPkHGhBW52RxEi
	 r49A5jY97jgHREOzRK5lPe2L1hep1tKtnGoiSd+JSQxeb003yluW/JvibTUwncgBmi2Xc
	 yyjHvv2EHDFdNFw2QSE8GnOFQFlJAUGT0ewAVT6liuNansZBog/pWRLM0F6O3Kas9WII/
	 tuPcezEvx1ApvQm3TotpyG8OmdreC3Lc8HN/wd0JqXW5CrMkdGX3elWyrXR6MptZJs6LR
	 GMvlqAd1St4JvhBflkpvlwfaJmGajq4H0eWTvdi8q+Hn3irWjtddGQEBiB8I4oCWEDA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794607160;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=fWb2UdVf7jivXlvYbdXApEPIv6SJnlNxtJbhutKm2W8=;
	b=zHcu1SE5PYU8vgjUxQHENg6S8hX69LhRV5IMZvybhFfa1lMx6iUg+faIGkfOaGedLXYU
	 w/dE2dSAZKBqtMNN6SUD9+KhX9DCeTXNFJVaABI6N+Kc2GuJqe8ZO6l6L6ynTVwKXCviG
	 8rE2yRgNGjFg5BOWwFIra7Ff6a6BQfxv5AyDZw3FBjgDuQL78cnrcjZUmwPazld5EraUy
	 3Ihps8Dc+MxJi5fjjvb2Sz4bnX2FIbigSIZ3B4nfvXBAA0+7jS9h9or6DvOS62dvC84gA
	 Phaj0sWxhGn4CZWBBinmSP04Wc3ZS6AEToKETdScIxcDkFzuCcFk6OqhK3YuTlH7aJA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Z1FOQe1v;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 680B5606A334
	for <linux-perf-users@vger.kernel.org>; Fri, 13 Nov 2026 21:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Z1FOQe1v
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 091C31F000CA;
	Fri, 13 Nov 2026 21:59:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794607160;
	bh=fWb2UdVf7jivXlvYbdXApEPIv6SJnlNxtJbhutKm2W8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Z1FOQe1vC1Ad4AcHSt/KBf+ga0AKZJEcrzChOjxU4MS2zsz5V9gM2GvQlxIjDEyGJ
	 zPvUq5m6RZmHb9yVKpNQCptxeOAWJCt+SXePCfqpsaw6ebHuKmuPdpK/A47aFGZyk2
	 79/Az4MqHZLshJiphK5iZyyPgDpRoYCyu6a50ndTqfxOjK1IIE9WbmGICcdLdWrHqt
	 owJ8LKnqtub7T+YLmYnGJmORz/RiiD1f+zyOkHu9w5U1cSg9QUuvbFZzsUdL8COBsx
	 ykQm8Hy2qTwslJwI8Vh/oQw68EFF1tELJk8EIshHQkuLR40+9Tml4JmrL8If27IrX3
	 zhkmEKeAJbcoA==
Message-ID: <sashiko-outbox-213758@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 21/26] perf annotate: Use generic hashmap for browser
 type_hash
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261113214850.3329699-22-irogers@google.com>
References: <20261113214850.3329699-1-irogers@google.com>
 <20261113214850.3329699-22-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Nov 2026 21:59:19 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> Convert annotate_browser::type_hash and annotation_print_data::type_hash
> in util/annotate.{c,h} and ui/browsers/annotate.c to
> DECLARE_HASHMAP(type_hash_map, long, struct type_hash_entry *).
>=20
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261113214850.3329=
699-1-irogers@google.com?part=3D21

