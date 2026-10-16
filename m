Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C011D400E0A
	for <linux-perf-users@vger.kernel.org>; Fri, 16 Oct 2026 22:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792189258; cv=none; b=TO7C1h+n5l+gWLi9KW0jbi4gAQ/oOJpbWyW0pd3q78N3KZYmhmLk4A5MWUJYPrKiarpktUWbEQ8DwdyWWy7ts88HH80S5u96PxrQrXOPGF6aZ1TN6ZGt/3Xgu3r1nXPV2Blkyl2xe854qqHpydZOoU9Jl5mfi1iXNucUunQm5EE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792189258; c=relaxed/simple;
	bh=4usRvrtGXjhrXToIRXXH+jp0xrsFoGfud9AKEM9lVPI=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=JSNE2bqFSRtlt+UKYGwaVPP9WoeeO/iBfm7iL86/kIaDeOP0Tr5u5GyXH2gB1FJ+innbU5KS7zwDCUnderezJwv4Op/fi2oZ7Op6QtRVBNTB07jwI1tCb44DtiwTeRTulFz9jXMzQ9mVM8A5TZoJVTmNbPUeOlRV5KmVWm8jkbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LZ9/IW4H; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LZ9/IW4H"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 466261F000C4;
	Fri, 16 Oct 2026 22:20:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792189257;
	bh=4usRvrtGXjhrXToIRXXH+jp0xrsFoGfud9AKEM9lVPI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=LZ9/IW4Hp1OWbX93TPszWb/FWzL/RcgUjRlVwI0/piQbgsHyF0vDQYiCWKEb8vey+
	 KYkuF+tzzsDFl44uCqQd5AWH21ILBRK4jZ9p+sQYRcQXX26mdlhI6NHvSX9M4fuksw
	 jeZBkbcAEpxXPY8MRXltbBKKCenChVJwXvI4S9wuDJF6M9qABTUMYJijIx49t993BZ
	 Rqd2o5i1eM9yoi33MWK+szTN9Rz5m0HfDY7ctVjm9xxe1pLFRodY5HewC6dhL8NrWf
	 UdHeWpxoWJkxqXsVlTTuDsh656qHr5qvrFbXo0JdvLsuIxUl1ltbbNaKnO/x2YDulk
	 VgAyq22ut+Dig==
Message-ID: <sashiko-outbox-175003@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 03/17] tools headers: Synchronize
 linux/compiler-context-analysis.h with the kernel sources
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261016221700.1282659-4-irogers@google.com>
References: <20261016173106.679725-1-irogers@google.com>
 <20261016221700.1282659-1-irogers@google.com>
 <20261016221700.1282659-4-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 16 Oct 2026 22:20:56 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> Replace the no-op stub tools/include/linux/compiler-context-analysis.h
> with the full kernel implementation from
> include/linux/compiler-context-analysis.h and add it to
> tools/perf/check-headers.sh so future changes are tracked.
>=20
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261016221700.1282=
659-1-irogers@google.com?part=3D3

