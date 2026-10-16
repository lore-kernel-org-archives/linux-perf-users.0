Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CFB258B6A9
	for <linux-perf-users@vger.kernel.org>; Fri, 16 Oct 2026 17:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792172334; cv=none; b=UUgUcrSds0oqGHYdQAytSLrUrrxzurHxVpuEfZ6ICLTcVq7C9cYKFnlSjs0w41Ds3eyifeg4GTJR4Ocqc7bL+RR4KLfeqelUfHQLw6y4YQM25K+3a7AerKDR/EtBqNDr1JwTIFqeetonTiabso5Uuk377fPpkRZPudcV7tyyCew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792172334; c=relaxed/simple;
	bh=c6zsAigQEQmJEy9jYqTVeJw3vp5EDnShZ/uYt75H8Y0=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=KjhwAKGxbXCUoxUy2b/q+3PINWtol19wwElZJpMAmMhN0W96vMufB+54iuovhjkSpPmvAG4X+0/HtgGq9blNF10/nf6Xj2SNWmilTE25DpL+7njdBAlhlI1no4mMnFgzdYajes7ToXwJv2w6BGK27wIZa4WRMRL14dt1E9ZFMrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oEpz1nGX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oEpz1nGX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9752E1F000C5;
	Fri, 16 Oct 2026 17:38:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792172332;
	bh=c6zsAigQEQmJEy9jYqTVeJw3vp5EDnShZ/uYt75H8Y0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=oEpz1nGX9J6NHDPiibV3KquMpiHfiG16FJxWfwp6XLCO0YxWXTlcLW9a6ZOgX45w6
	 ga7TO6R4T8I/zm/c2LJB5dZGXVJtChS1DlZoa3QGjmxQUCjs/gB1wnGe0KLuxp0Zk5
	 aoHn4yXBkum3Fl9RvaOCqOy6CDriNm0cwstV8/UERNbkexIzdOfbNfQl7Xy3FeWyQJ
	 8I5CwAk2W3MLBEMpVCvvpdwwnb9p/UVrrtFONhYTFLT8tfzzJf1MgOgDg0OZ/GCPHF
	 DvF9LiodxfnrTMP2f4r9v22jNo/9icymjmGq7u7q96pzPfE4EeCnJctNywh/yE6uBA
	 uF54OR7H8JrzQ==
Message-ID: <sashiko-outbox-174730@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 03/17] tools headers: Synchronize
 linux/compiler-context-analysis.h with the kernel sources
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261016173106.679725-4-irogers@google.com>
References: <20261013222622.1822619-1-irogers@google.com>
 <20261016173106.679725-1-irogers@google.com>
 <20261016173106.679725-4-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 16 Oct 2026 17:38:52 +0000
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261016173106.6797=
25-1-irogers@google.com?part=3D3

