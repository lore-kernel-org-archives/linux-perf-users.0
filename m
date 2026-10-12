Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A6DF34388E
	for <linux-perf-users@vger.kernel.org>; Mon, 12 Oct 2026 05:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791783191; cv=none; b=py/6MceaIy2OlMRm8BJ+OEbJW8VwR/95MwJT6+scgs26KvVl3SIHFcjLd58krUyJgdZZxZl2nEAqtlm3f9Cn81q7qooicf5/SiDO7ZEdXhoWeW+UwSCjN0+r3ynUTMMQw17VgzJsH5iBfCxucbGMPpnyWp8iKT733K6FlhvzEpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791783191; c=relaxed/simple;
	bh=jfXxKVBAOxe+uMKzp8AdZQakvCxo7DtytG3cGrQxL+Q=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=I/H87fa0q+ijmEwkDAhI/Ut7zcelPSs26xlce2q1aKqHr57wA6AvcQNSf2i06TJPlLziADj72WDRNVM/sKf3v8A2zRmYxGKkcihFFKdKqcQ18n4G0eEgA0IyP/bNoJRz2FANtCBfCnFL2p9VOjD3z3+kPImR8HtY+tKQJTmfOOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WbTLt5Ef; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WbTLt5Ef"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 820461F0089B;
	Mon, 12 Oct 2026 05:33:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791783189;
	bh=jfXxKVBAOxe+uMKzp8AdZQakvCxo7DtytG3cGrQxL+Q=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=WbTLt5Efy1xWF1L9ANlByfQFBWY3g+Gt/G7z2iayNDQrF8eOsnSaaMTtI/EhzNcF0
	 zxHbY3HgGoF+zfvOa6dRPQS2yOnO6evPfXxd2UY0EgBJWiBeoTDqPYCB3lvV9FOIVo
	 taFmRtrq9/JilsSr3oOJBmdqW9HWdO+l61Mk0URQZAfzzssvjZgCkjnQmXzPlGovij
	 8MscMi6ZGutRLh4U/R4LQBQ5mfCIosya+nCx5ImIibmWqqAJ1Zk77Q2t4TKYiuG8pj
	 Bi0/yeUAbcDvWfyVpJzowV3C9yYvfYrY1+UkxwHv2jHSf2rUC3uy5lUVyrUuE5jW0Z
	 aM5pykQaYY4tQ==
Message-ID: <sashiko-outbox-167672@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 04/10] perf symbol: Set binary/symtab type for split
 kallsyms
Reply-To: sashiko-reviews@lists.linux.dev
To: "Namhyung Kim" <namhyung@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261012052601.13920-5-namhyung@kernel.org>
References: <20261012052601.13920-1-namhyung@kernel.org>
 <20261012052601.13920-5-namhyung@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 12 Oct 2026 05:33:09 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> When it creates new DSOs for split kallsyms, set the binary and symtab
> type to KALLSYMS properly.
>=20
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261012052601.1392=
0-1-namhyung@kernel.org?part=3D4

