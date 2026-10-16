Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7978D4E01E5
	for <linux-perf-users@vger.kernel.org>; Fri, 16 Oct 2026 17:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792172204; cv=none; b=s1uJpWwvSJECmG0mgV5tIN7CtTW3fdw0RCgWdx6/976r4iZf/pfwxhoasiLedqE4vH1JoP2j7jYV2/qzs5giWdhva2bkBftet/aILzWqlsB4a8DtC4EM1bwATu6rGC7vQgetSPRD2oNkYdd6Wgdl1voXJgby5navHUgp2E0z9X8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792172204; c=relaxed/simple;
	bh=Ve1JuoFfsBCapyzdDS7whAOikfDiNbpHwMC0BvrOQZ8=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=ezr+0PnYxYFYjKWxg8A+1LaToFrtxS9Hwrb7UIWyyuVxPttNM84CFUQ6uVHnxHruVzk+hmFrQEJ952EsBQlKbNr3zj/AAp6WixUOlyU3Ayj5IXvaB7U2zoqE79Krln21Vj5UeJ+HG53cvomi9mAri0jpdVm1TwAl8gg833NYlHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WWzLoY+e; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WWzLoY+e"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F23441F000C4;
	Fri, 16 Oct 2026 17:36:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792172203;
	bh=Ve1JuoFfsBCapyzdDS7whAOikfDiNbpHwMC0BvrOQZ8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=WWzLoY+eS0dBtCJ39At0sYRHcJRsmz/9qTPyloTEg46CqoPFq7gyLM17QLvQ7f7Kh
	 NY9HXHmZzKie8QEYau8A3oUekyAEJjKwM5UX4NBQU0lBN58t0oQaT1IqTLU527HnF0
	 CZd+TS8xsV1/7oI2Rv4qW1OLdn0cVPG9FdBiDkshWu23OubxelPckPfZrFFr2TH3Ia
	 nG2KTyTVrZJ15XUvJSrQcZm+ElzprE65vEhMNzZGZ4PmTfbX2h1HEvcK3q6P0BBB7d
	 fklQdEwyaJcXe/elJ+NLM0nLzuTZ34O40LYO4BPPl8/+qMHDdBznWYn6sM7w0FtbU2
	 2meShm8J3cbVA==
Message-ID: <sashiko-outbox-174727@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 01/17] compiler-context-analysis: Avoid unused
 parameter warning in _context_unsafe_alias()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261016173106.679725-2-irogers@google.com>
References: <20261013222622.1822619-1-irogers@google.com>
 <20261016173106.679725-1-irogers@google.com>
 <20261016173106.679725-2-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 16 Oct 2026 17:36:42 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> _context_unsafe_alias() does not use its parameter 'p', which triggers
> -Wunused-parameter when building code that enables -Wextra (such as
> tools/perf, tools/lib/perf, tools/lib/subcmd, and tools/lib/symbol).
> Explicitly cast 'p' to void to silence the warning, matching
> __assume_ctx_lock() and __assume_shared_ctx_lock().
>=20
> Reviewed-by: Marco Elver <elver@google.com>
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261016173106.6797=
25-1-irogers@google.com?part=3D1

