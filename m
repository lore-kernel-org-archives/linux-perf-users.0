Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A50152D2CC
	for <linux-perf-users@vger.kernel.org>; Fri, 18 Sep 2026 21:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789767076; cv=none; b=V+NxpfXRcrBwa+vShVRQxJv7h8Rk6zzpoAn86sSa/NrPrcmKALecFG8EXWFg4Y9zY/WyMvrH9xdgKPgATxmZem7oKiKaIU2ft3x13BcgsspDKUXRmZH27BlLki4zweGDu4d7Ue3SMIFlqfqpdwe4yScsU21EmpmfT6OCZ1Z8JF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789767076; c=relaxed/simple;
	bh=qtHBdjFom6qu82QDEG4rAxb7cgjTyC4OaA5RpRL7Bmk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=VTmhzh6PO2oHK8YRL76MnsYiWLAE4yzEfald4jaeYn5Kvw32TwSqYFoNdz56Oxy7k1mxxPADEiGZGdQ1Jde0+Zvw0MDxp1+DeQJKBBrZkHMg0fsabrEkvV/t/GEEZ5DIMxA0Q4XBlXhHyuu1tQrPMJQMpkdMSgj+pdcoUlj7ylw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gGCFe++A; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gGCFe++A"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9B341F00898;
	Fri, 18 Sep 2026 21:31:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789767075;
	bh=qtHBdjFom6qu82QDEG4rAxb7cgjTyC4OaA5RpRL7Bmk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=gGCFe++AXJb89WHVcWXfxpf5PawTHMFZMq01CExiL9EXOKjNv03ogXVesKdN0RJya
	 T4Oo2AElHsViZI97qnKrTHSha5emHDWs0vo8S5GG3QJyVa+4ozqsiRsH9rmGnR2e82
	 Y9qoiVZbgNOJwhyo0Cjflz9df3pD0U2MbWr0VdMd1+A8RycnTHTYBHZYD2OYICbPKv
	 CmEPHs2tW+kW6k5PPrO0kqmF65/b64qm6k0R3YrKXR93KYqqma6qAvAIpAa2FPBpCp
	 9SzN6v9vhv8BC7F6uX7hqEJZr63Dyed0z/zUB6e3pFWepgilTOofW5QD3Ad5GmGhL2
	 8H6jd2BNxR9LA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 17/18] perf test trace_summary: Make non-exclusive
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260918211932.2966061-18-irogers@google.com>
References: <20260918140659.2501976-1-irogers@google.com>
 <20260918211932.2966061-1-irogers@google.com>
 <20260918211932.2966061-18-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 18 Sep 2026 21:31:14 +0000
Message-Id: <20260918213114.D9B341F00898@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> trace_summary.sh tests various summary modes of `perf trace`. It already
> directs output to a unique temporary file without polluting the current
> working directory.
>=20
> Remove the (exclusive) tag so it can run concurrently in parallel test
> runs.
>=20
> Running perf trace in parallel is only safe now that the probe tests no
> longer name their probes "vfs_getname...": perf trace opens everything
> matching a hardcoded "probe:vfs_getname*" wildcard, which used to pin
> those probes and make their cleanup fail with -EBUSY.
>=20
> Assisted-by: Antigravity:gemini-3.1-pro
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260918211932.2966=
061-1-irogers@google.com?part=3D17

