Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 440B51FF7C7
	for <linux-perf-users@vger.kernel.org>; Sun, 20 Sep 2026 05:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789882192; cv=none; b=aIC2HgUNodnGsL2T/gZNeAX0nlZ6oqZs96QBbITkgt2gaQUPftQnYdkXjqiM2E8dYhUAqEnrQm6VzPbw2MQwLrQ6aqQElk5Jsog+TZHW+RmfqNWvTr3W/aNZTT+fzyAiLTAfDT+wtKuTi5gg0f89eB026WFllzBqNa5s3wTsqKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789882192; c=relaxed/simple;
	bh=3iroX1pzX7uju5hbR6gyNVtsbod2w+qp3WRmarzJII0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=cTVoE9e6zTIKjVhc+Dh4OjwDkDNAxj/W5fqgbxUJ1sbH7ylfZCY2+ubFbc2FRzL3tfEcDxzC2eqdMYeaZAL8boayNN7eNXbima86SAqXgSJ6gxmqAQ6QF/M9R/e6Tsrt9lfg+1+vWDCNYHhdnDJGLcUBCsFYHq8OwHA0/M6gsQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Of5N4JhV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Of5N4JhV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF24D1F000FF;
	Sun, 20 Sep 2026 05:29:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789882190;
	bh=WcRzqQYEwkEzFKc01bIgRAzXqJOrkKQmFiAEyNja0CI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Of5N4JhVt9j/5YkvVIRROMm3WlITyRxsU5LxXsZNJg+ddL4LU4p0DsJGvJl+GKmID
	 2996ziwwIX+3oVObjiAJn9kEDeSOx2dnszhJyZ2YHXAG+Dx/jEOQD3bPSnbQw4E0SS
	 S/HwwQSsDiGv1CWSD2LkCBI5oP7zOorE28v+2iAm8tc0JP7RJEuK3y3J8r94umvexn
	 0ewQEkbyPU8NHl0xNituiyd9e7RnPMlBRvSfy0HitARLv3LUmARTEAlH21tbfwXlvH
	 nHGNpRr3u+vnYVwWADWZoy+8YXiGZACqCTEpgSgxVY63Il2FkcAETrBL4+GIBSmn8G
	 30TiwOKd7LZfA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 11/49] perf pmu-events: Clean up mypy and pylint
 issues
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <339d7d6a5c9d2c4900871cf1221e7bb67dd99ec2.1789880842.git.irogers@google.com>
References: <cover.1789880842.git.irogers@google.com>
 <339d7d6a5c9d2c4900871cf1221e7bb67dd99ec2.1789880842.git.irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 20 Sep 2026 05:29:50 +0000
Message-Id: <20260920052950.BF24D1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> Clean up mypy type errors and pylint warnings across the pmu-events Python
> scripts (amd_metrics.py, intel_metrics.py, jevents.py,
> make_legacy_cache.py,
> and metric.py) in preparation for making MYPY and PYLINT build tests
> opt-out.
>=20
> In addition to type annotations and unused import/variable cleanups, fix
> three bugs in intel_metrics.py exposed by static analysis:
> - Fix references to undefined 'args.model' (instead of '_args.model')
>   inside
>   try/except blocks in IntelL2() and UncoreMemBw(), which previously threw
>   NameError and silently disabled Skylake/CascadeLake L2 silent eviction
>   adjustments and uncore memory bandwidth JSON loading.
> - Define DC_WB_U and DC_WB_D before their first use in IntelL2(), fixing
>   an UnboundLocalError that silently dropped the l2_out_rate, wbn, and isd
>   metrics.
> - Fix Event-to-string comparison and addition in IntelFp() by comparing
>   and modifying 'f_assist.name' instead of the Event object 'f_assist'.
>=20
> Assisted-by: Antigravity:gemini-3.1-pro
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1789880842.gi=
t.irogers@google.com?part=3D11

