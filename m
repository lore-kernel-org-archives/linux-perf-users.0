Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9CEB563285
	for <linux-perf-users@vger.kernel.org>; Tue, 13 Oct 2026 22:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791930639; cv=none; b=HBslW3UnqMzdA1lL+Cwr8gif+tGIF//p9qqZx5RmIpN3oGVrUXlJkNo+dnTqBiRPygqfYire7xkg2hyC3a+J1wqqqWBVLBPVCEfwwb3Kemg41ywTGp4MXZEFSmg3Y/Ebz85qjz4kw1Ks+JZ5qQ21pBn0U4qwe/rLxnFqVkTewPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791930639; c=relaxed/simple;
	bh=r3itCCrr0zIJRm8Sf4DtCYY/YNMf5uSLzKS/malPcmE=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=PDhGhJmwsZTqW7K+QOvhX1rak1tslfcAbwameLVjrQQeFfJkCjnpyAs9Dkhi57Q3gHp9PMMfknF7xg7dgbGfAGoDA+sMXt+BIezlubkyc00MDJBKxM74d2ZtwVSq0aj0CPdBM5TJrhrqKcQQyB26CVUU06xe4ouEdYczuahi7L8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ABgCDP1Y; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ABgCDP1Y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6CBB1F00899;
	Tue, 13 Oct 2026 22:30:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791930632;
	bh=r3itCCrr0zIJRm8Sf4DtCYY/YNMf5uSLzKS/malPcmE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ABgCDP1YNii2R+RjSdtU0E1En6gyvReys+vOUoaJjXUbW9/Ia1a8Ij9q8IlLRcwmi
	 hgIe7QTL1W+gVVRw2lBEabBonsF+ozdAuIWBVhADcQUVMFmLocTYJKtOb6vvly02T1
	 PGpmUa+BmFGe7m3i6a4c+2t0fjFKOK3pnvT9TMv3EYvGBwwoUl+JJ6wIbg3lz2qaRS
	 dYcREULHSfJkDTxn66Y6kTCV3eHyvUqFlG5kN8puN1PRdWiOmgkU3RgyCSWhemF/8J
	 OMLepgFc/MXTy26fOUZPnkFROwNWGAgU1YoA5MbZvKoCfTGXPdfNjxZRim7ii98tId
	 PrHNt9q+yWV3Q==
Message-ID: <sashiko-outbox-170579@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 01/10] compiler-context-analysis: Avoid unused
 parameter warning in _context_unsafe_alias()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261013222622.1822619-2-irogers@google.com>
References: <20261013182458.1234616-1-irogers@google.com>
 <20261013222622.1822619-1-irogers@google.com>
 <20261013222622.1822619-2-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 13 Oct 2026 22:30:32 +0000
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
> Assisted-by: Antigravity:gemini-3.1-pro
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261013222622.1822=
619-1-irogers@google.com?part=3D1

