Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C29F38C40E
	for <linux-perf-users@vger.kernel.org>; Tue, 22 Sep 2026 14:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790088870; cv=none; b=MOGxSM8ZcPzIKBlY019ttyzxkP2XVfuoiwaNAPZO65hXtc5ZP+VkBNsKQ8W9f+tkyYPAy77Se/Kw6n/AG/968mNw/udJJolRsA40jfxzwX0iSVLlYYE0i5Rqo/fmihH8eQoPebKWbIoLocrV3I6gh1Nm8ycCc1BQ0TrFJL+BL+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790088870; c=relaxed/simple;
	bh=wxq2u6J4V2D3nS4EKs9w96YhScMaRWsJnhCCMnHXspk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=gR518Y2L1usWWWrcCQQNj5da4/iY0B8Elvkl4YzUn9ZvjUrHyV0+LkxovfwVWMSOEEXH4AqQqGkYTEzGEQeRboTnLqNuuPk6G80mR2LY3vDHopAhvepwsFFgNbdh3T7iGrOCFkGi4YthIEbJklY8Y6ppNgPmyhLAES9c3ktB3Dw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d90jnkxr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d90jnkxr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E2281F00893;
	Tue, 22 Sep 2026 14:54:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790088869;
	bh=wxq2u6J4V2D3nS4EKs9w96YhScMaRWsJnhCCMnHXspk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=d90jnkxrenyjtZfQ9t7jzptE3tANQOIa7tAl7R1FYQhvI4URaZeJJmK9H9Cx5wEMJ
	 m9l99DOf0jGseCcjRXqgLLCDgzGrMVVqbSQHEomknMkQqhABGZVruBaXkF1SSj+9Zg
	 rQk9zPTc683SnGFKxtMfeazhY7rpZfSjqSpiyUu3iF+Q/LfDOG6bNVyDxkRJnKb5md
	 dFzDiXdLTDQWrEabJr586pz1jYOrq7WjbstCeR/5BA1Qkl6ISmEtf4m4JInX/JPTi0
	 XvHjNq8o8i8IUmMyHCa1HzQLOtPgo31P6P7N8DlECvJfweP8DEWkapHJbhqRNgoCRy
	 hlHiUTElqD51Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] perf buildid-list: Fix empty output for AUX data
Reply-To: sashiko-reviews@lists.linux.dev
To: "James Clark" <james.clark@linaro.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260922-james-perf-aux-archive-v1-1-0ede8ed764ff@linaro.org>
References: <20260922-james-perf-aux-archive-v1-1-0ede8ed764ff@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 22 Sep 2026 14:54:29 +0000
Message-Id: <20260922145429.4E2281F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> perf record enables buildid_all for AUX trace because buildid-list does
> not decode AUX data to identify hit DSOs. Historically those build IDs
> were available in HEADER_BUILD_ID, and buildid-list disabled hit
> filtering when HEADER_AUXTRACE was present.
>=20
> Build IDs are now carried by MMAP2 records by default and the build-ID
> header is omitted. perf_session__list_build_ids() forces with_hits when
> the header is absent so that it processes the event stream. That also
> filters the result to DSOs referenced by ordinary samples. AUX data has
> no such samples unless the trace is decoded, so every DSO is dropped and
> perf archive reports that no build IDs were found.
>=20
> Process the event stream whenever the build-ID header is absent,
> allowing MMAP2 build IDs to be read, but do not enable hit filtering for
> AUX data, this ensures that all build-IDs are included for AUX data.
>=20
> Fixes: 6bd89ae7d147 ("perf record: Make sure to update build-ID cache")
> Assisted-by: Codex:GPT-5.6-Sol
> Signed-off-by: James Clark <james.clark@linaro.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260922-james-perf=
-aux-archive-v1-1-0ede8ed764ff@linaro.org?part=3D1

