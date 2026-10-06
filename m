Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A50249EC7F
	for <linux-perf-users@vger.kernel.org>; Tue,  6 Oct 2026 16:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791303731; cv=none; b=gJ5JmjJwxJz0uCA1osQLLGnTAsTHhRwrkx2CEhSr+KfzWdY/C3nhhSpVx2wDKUF6h/PQJYSMTgm2VlTjdt1ybV140e3TNf4U/IIzhhnEYFyPFBJ5+SkwVbwFNSFRL84XcSz1NeYMr63uM7a9WI6yAjDODa1HofCOJdxCj6gyphA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791303731; c=relaxed/simple;
	bh=EPfa/xCQL0cr5I+HOJXRBVRySgc9A1dJs8lSL01fhYY=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=E9+eOXwcgdepvOjiRJuSfiZnrMcOvRHNDQEDag0o4dqajuAc/7ikndZNWAfCiX7BLIfc/73m+nRQnirNnXSH0r0PEctO9mA6AO/vVj9qfXXdMSO2xrERBmAqpI9i09uJ7Prx0gTIBfosbslNmhcQn4jPuqV8Cj3D+rHMc1gIdXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LimaZvaL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LimaZvaL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB6C41F0089B;
	Tue,  6 Oct 2026 16:22:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791303730;
	bh=zKVUyEXWb2nXHIOuVCMsYIn8lzgHvt0E/fWo/lPstAo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=LimaZvaLZDj+uVsL5ESkxRYpQ4gPlJCxFVs8vnxHwHIZyELXv6AEDLlJejtEgewdo
	 DiR+eu8TWWYZqW9FcX45b3kThNGNPSECJeu07oLMfiAPxsHP9W7UZUnrk8UMu4DXu0
	 4Nw1qxLnLRVJs8WF1scgw+ypgmTKu6u5XJZ26QCRjGSGUh4ylJlsoldpWLh7qjB9ne
	 hzzRNCw9+MuZrlmgZUWG5MMx1aL3i3n9fZIy8aC1kCvQR7Lmb2vtqOsKbpX2WcfBjO
	 GOCS7jBndcO5FqO3V0J2CB9+WU45v0VlXQpx9IqUV0DOE0kop4AXY5myfg85u/TSSj
	 gTBOvuIYMnZpw==
Message-ID: <sashiko-outbox-162244@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 6/6] perf test attr: Relax group checking for ungrouped
 expectations
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261006161309.3078488-7-acme@kernel.org>
References: <20261006161309.3078488-1-acme@kernel.org>
 <20261006161309.3078488-7-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 06 Oct 2026 16:22:09 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> From: Arnaldo Carvalho de Melo <acme@redhat.com>
>=20
> When matching the recorded events back against the expectations,
> attr.py requires every event opened in a group to match an expectation
> that declares the same group.  The perf stat default metrics open the
> events of each metric in groups, but the test expectations only verify
> the event attributes, so test-stat-default fails with:
>=20
>   FAILED '.../test-stat-default' - group failure
>=20
> Only enforce the group of a recorded event when the expectation it
> matches declares one.  Expectations that ask for a group are still
> verified in both directions.
>=20
> Fixes: c7adeb0974f18da4 ("perf jevents: Add set of common metrics based o=
n default ones")
> Fixes: 2dfc0cab3da4a205 ("perf stat: Add detail -d,-dd,-ddd metrics")
> Assisted-by: LLM
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261006161309.3078=
488-1-acme@kernel.org?part=3D6

