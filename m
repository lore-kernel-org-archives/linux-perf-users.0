Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792622624;
	b=GAdx7rn0dmYmgxvi2W6RySW2m8EeqOSmgBE2981S1ni89inQe3gCFGTOoLq795o2xyqS
	 ceJX63/8Ac1ysPuDErgmYOsbLvl/9IVCmFlaOwX31PflxcS9P7pzle/ZqR4v9/8WZzz7E
	 p7pIRuIX3JEs4ZIL9fF9yh32KBSrrSwypNLMvwloYNt6lVZb5EMvlCMNd99voyjEPv+Er
	 2ELHZ89kp2eODQ61/dp9Bpj0FXeWQK0zMsdyVJSCNqkbIP8zdqDdEJ01aYB4peOObltQM
	 H7jX1ai4pfnvYQebqjsk+kECpOx5+tpSp2i/uN79m3DQ9JyUKzhPuU6pzUVtoSZYeXw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792622624;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=mZbmu3RcuvvIIyn1pxSw7mrEVbmNiUikcn3ib5x4PKM=;
	b=mi8ooXgUNsUQIj/TdnzDBfDkJY6AdrMUapIAYphMvs4YUp/yZNewWXCIzbagsPPJpTi/
	 +UktRQWFQgw97vQckmhoeb51JKRR42RmgMhLbddOuQLscYDF+C8m+bO/4ZK0LMsVxGHhP
	 5gLeb6NiA6ddEHfoHA2Qjn3Ux08u/rOajS3PRBf2MImRXcSEmZ577yhkJ+GVw4uwd2lzC
	 EFP269E6fyS9NhYMMx2yE7Ps7Kr1kT0nbaJvxKGLl3RdUK7orlP9EXhEnhK3kU7agZjtK
	 iP1UAV4BdAtK01bhtin0GSyWl0id/EX5Og+AP6pkJ70VBhrMvJDW+Kjz5cdSsA9bHfA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Z4Mzy7tF;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58D6C606A31F
	for <linux-perf-users@vger.kernel.org>; Wed, 21 Oct 2026 22:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Z4Mzy7tF
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA92E1F000C1;
	Wed, 21 Oct 2026 22:43:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792622623;
	bh=mZbmu3RcuvvIIyn1pxSw7mrEVbmNiUikcn3ib5x4PKM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Z4Mzy7tFKu2UJpwVEfs0cBGWhzTaayhQM7cWki1cgqAcpKPV7fE019UyHR2OdoY//
	 Tk5QFNWOVpiEQ0jmIoy9cm2qLVlQ0LIfOT3gxI9SykXdEcC3sB3uaw/L1Ttkr4guOi
	 vMO8x29kkW9L15w+Bn/Ka/ZxetIQeMb4sCsnqGqCR1aeMzkVgGQoNA9tuWUjx35kJ2
	 LkjRIKEe4irlztJdCAaNDXIf32+xmLzEBOBLqY9IhQstq+VeqNMhuG0ProSworSQev
	 Jj9709RQwblZTzfi/UwvLZab9kh9k0DqblrviCRtgYB6Q2tb+Z9gY8eyrYKXLzBhVb
	 2L/ZmmQGfPVWw==
Message-ID: <sashiko-outbox-180733@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 01/17] compiler-context-analysis: Avoid unused
 parameter warning in _context_unsafe_alias()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261021223905.715051-2-irogers@google.com>
References: <20261021171044.155240-1-irogers@google.com>
 <20261021223905.715051-1-irogers@google.com>
 <20261021223905.715051-2-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 21 Oct 2026 22:43:43 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261021223905.7150=
51-1-irogers@google.com?part=3D1

