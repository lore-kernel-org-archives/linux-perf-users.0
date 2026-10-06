Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D485D3BED46
	for <linux-perf-users@vger.kernel.org>; Tue,  6 Oct 2026 16:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791304981; cv=none; b=LuCBUZCN9rEYZOel4CBVWEgGD7oe/fYcBg8JK75rez5B83N74DHtNJJBAKw92dZECj5GVRD8Xa9Ze/a1DOpBlBXNfl2QhTzz8v8R75ltfB/e3NKRnmPuPe65OAIxVNcsaUlZ1Wb8EvGi8lXUyFI22qXnaQAMypSS8RA2O17tXZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791304981; c=relaxed/simple;
	bh=xzhZpxJqC9UwUaAIpDC8SZCpaRE3UrFoTDwuqyY05WE=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=ZffWtWR8FFLBQr5NyF6jFCHV2KeHLWKRDj5+K1fwsM1+Myycb+dN6EVDL24Wt0rXJGI0SKKvXZBeMuqTkYaQnOTyP8tfmGethC7w3FkA2+BqqgJOsak7VoaUbaqoJKsmKSfCgZSi1d36t6ILzvwidV7Ag65npZdWosqHTZyWKKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VU+q7NwI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VU+q7NwI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C82E1F0089B;
	Tue,  6 Oct 2026 16:43:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791304980;
	bh=xzhZpxJqC9UwUaAIpDC8SZCpaRE3UrFoTDwuqyY05WE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=VU+q7NwIWKKnSKfuSbVce0rJvZecH7CjQ1C+8/1dlZG/q60S0tNlt2CN1980wvsDO
	 UmRvNGdFVNMyyKvUlEqemkhfPAOPyJ+BQHTIY6qwUslpoWP/Kl49yK53mmQS570Kb1
	 fVUljEBi1vZAjMZrLGavBHJJ2+ePTSkpZmiLfxQtW5ToLA228cYzH4gfS6N+vQR/hZ
	 t1Riw+ucQAeSDq7gm/MFHA1gNdjSuOD4FG0is41tw6FsO/FBG+qteLzfF2KHvPWSEK
	 mK7+FDsJge0wEtVbSpFxk/BAUuYRD0TZwJ8k6G2ZA3u5IiYmtRvHQf/yD38Qh1Oihb
	 ptQJuxa7I4Cyg==
Message-ID: <sashiko-outbox-162266@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 1/2] perf tests: mmap-basic: Only test userspace
 reading on supported platforms
Reply-To: sashiko-reviews@lists.linux.dev
To: "James Clark" <james.clark@linaro.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261006-rdpmc-detection-logic-v5-1-b25c9d49baa1@linaro.org>
References: <20261006-rdpmc-detection-logic-v5-0-b25c9d49baa1@linaro.org>
 <20261006-rdpmc-detection-logic-v5-1-b25c9d49baa1@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 06 Oct 2026 16:42:59 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> mmap_user_read_instr() and mmap_user_read_instr_disabled() are the same
> test for platforms that libperf doesn't support userspace counter
> reading for. Only run the 'enabled' test for platforms that do support
> it in order to simplify it in the next commit and not run the same test
> twice. The test can then assert stronger guarantees and have fewer edge
> cases to handle as we know it only runs in places where
> 'rdmpc_supported' will be true.
>=20
> "unsupported" hasn't been a relevant skip reason since
> commit 588d22b40480 ("perf test: Expand user space event reading (rdpmc)
> tests") added the UNKNOWN fallback for unsupported platforms. Remove it
> and leave only "permissions".
>=20
> Signed-off-by: James Clark <james.clark@linaro.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261006-rdpmc-dete=
ction-logic-v5-0-b25c9d49baa1@linaro.org?part=3D1

