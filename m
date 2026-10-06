Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E564E456E1A
	for <linux-perf-users@vger.kernel.org>; Tue,  6 Oct 2026 13:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791292034; cv=none; b=uixT8BqfAcQzbOQ5qXbxE9Y2cgEdvjWnAtEcfF3tjS8U8DImeQnHbJzd6R2QIMEb2h1pASqA8i0WyypL9ulBE0kxhT73Dp0BnhipGmFoaeJCgskE7/5j7KrlIOfHDkf1lvq5kBSsMzv7S9ElWtXVhQWQk0r8asl2PfEdNELCaYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791292034; c=relaxed/simple;
	bh=kZNrOBlcMowRuVg7emMZxgBpjcXx7ehbisrzxM0g3bM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=uWMqouGTBFDyloVuj8K5iTUyWSaULOJgRUWgFK0i4fFC2TLjjzAX7KabfCFmwg0GXmPdGEbSWf710vC7bvIWaFOHgqEykptD3rU9czxhK1/mjuMO3kyqiHZuE/PMxLMViSSyw0GT5xD7lO4NufjPgK411JE880ULU+gXaUpMU/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eyHzWU+B; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eyHzWU+B"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04F701F000FF;
	Tue,  6 Oct 2026 13:07:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791292032;
	bh=TziZJpMZsKVNjZ5jeajvQdKWuW2fGc0ejkmO2XUp7k4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=eyHzWU+BU3bt3I8L1A7ivgaB6R1XTIOWVIA2F/rCxGZDglChaLCoUkdzYNCBLovm3
	 1k5HIMKOzo1oLTBRXvpVmYnYdRLj6iploOJwLZfZz5CAQflBULDiq/w6172vR0rqyU
	 MySHGAMiQBp/Vwj40nMrc8kSHZQ5KkKJ94YSjgH/9aFhPeN+ThugYUcrNGsiqnreZ2
	 HpNkz9SFLvpxyOK6opkVqfdm+CPDXOaPnhbKyq5t+01HXaAFn1GQSYTVCprlfUQb+g
	 rQqjbAcoQAixfgtlN1iipohCkv+0Uj8JJD9a6QC37PRcRo/POF+iOHdOaaHzamrt51
	 BeZzCovkPsikQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/2] perf timechart: Fix task row type narrowing in
 goto_task()
Reply-To: sashiko-reviews@lists.linux.dev
To: "James Clark" <james.clark@linaro.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261006-james-perf-timechart-mypy-v1-1-e2c7edf4dd31@linaro.org>
References: <20261006-james-perf-timechart-mypy-v1-0-e2c7edf4dd31@linaro.org>
 <20261006-james-perf-timechart-mypy-v1-1-e2c7edf4dd31@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 06 Oct 2026 13:07:11 +0000
Message-Id: <20261006130712.04F701F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> Mypy cannot narrow Row to TaskRow or IoRow when the class passed to
> isinstance() comes from a loop variable, causing the perf build to fail
> with:
>=20
>   python/ttimechart.py:1686: error: "Row" has no attribute "task" [attr-d=
efined]
>=20
> Check against TaskRow and IoRow explicitly so mypy can verify access to
> the task attribute. The tasks and I/O views contain TaskRow and IoRow
> instances respectively, so task navigation behaves as before.
>=20
> Fixes: e7a72d691980 ("perf timechart: Add an interactive --tui mode")
> Assisted-by: Codex:GPT-6.1-Sol
> Signed-off-by: James Clark <james.clark@linaro.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261006-james-perf=
-timechart-mypy-v1-0-e2c7edf4dd31@linaro.org?part=3D1

