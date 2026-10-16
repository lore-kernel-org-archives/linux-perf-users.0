Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5825118DB26
	for <linux-perf-users@vger.kernel.org>; Fri, 16 Oct 2026 00:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792110351; cv=none; b=A1/5mIJnjzYfuZNtOtxVrHQjTHXB1A7IGfhJJBzcI5j7/ai0RuEBkNYPLBkxAn+2puoOS8bzpxgCR+8HWi+x+58iTfs6XyWIsbhOZnPxgIBgf932t0wiHKGJ8ylAn0cuvQFCYmtidAHc7NxuQ+gHpsP0xt4du+vybZifiGSa5IQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792110351; c=relaxed/simple;
	bh=QqeWvjHY2yELjg9ZaWd38bTy0l0QMYp/UoPUFjc6RuM=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=uNBti6HS8RS9O2M8maItMuUtg3c035dyztvETK+aUIkRPxIJcLZsX/zEKFjUn5YCiUfob544wC4vUmcTIbe+svOTwfE+cjAyi2ngwz1e0Rjfo5141g/DPCIvG7ItkS8fHl74PGkO0sXitaV+besTPm/V4LmWyYfG71Y4Mjak/hA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UltysZOb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UltysZOb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DF641F000C4;
	Fri, 16 Oct 2026 00:25:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792110350;
	bh=Q/zI0TWA5TGJA5J5hbxpXSPiKxUO0hPtON+BXqlUZ1c=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=UltysZObyHP0n8fCuaakwksMqWTMyD6vxsndPgkU6apy/gsXNtCm6082tXmDL/f37
	 FYe4vCe5X5vCHKyvwzEXG7yuojQ8QsRg+IbcNPCJDcLNm0w9o/3DZ1GxjXzngpEz6V
	 j53Ek0TRGqnIcH6TjLH0QH8QU6L4js32wdGWDOg7InhVjih5widWFifsa4FN64eTR1
	 8daWYkXcYOa3HXmkhgwpwj+8ySGRgDFCJ6o+1izi3JjRub+9za751+v2oxUU8TXosa
	 7O6l+bossi1URRu0z0EZO1TyMtvuAOciVUrHh9sOGepGHhKoxmwr0sg9F2AGpIg7nw
	 rv8dxE2noPuug==
Message-ID: <sashiko-outbox-173523@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 06/19] perf evsel: Mark the event as supported when
 retrying an open
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261016001843.71978-7-acme@kernel.org>
References: <20261016001843.71978-1-acme@kernel.org>
 <20261016001843.71978-7-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 16 Oct 2026 00:25:49 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> From: Arnaldo Carvalho de Melo <acme@redhat.com>
>=20
> Opening a group with perf record on a machine with perf_event_paranoid >
> 1 and no CAP_PERFMON fails the first perf_event_open() with EACCES, after
> which evsel__open_cpu() clears evsel->supported; evsel__fallback() then
> adds exclude_kernel and record__open() retries, and the retry succeeds
> with supported left false.  get_group_fd() treats unsupported events as
> ungroupable, so the retry opens the group members without their leader:
>=20
>   sys_perf_event_open: pid 12345 cpu 0 group_fd -1
>   FAILED '.../test-record-group-sampling1' - group failure
>=20
> which fails the group subtests of "perf test 82", the Perf attribute
> expectations test, when it is run as a regular user, while it passes as
> root or with CAP_PERFMON, where the first open doesn't fail.
>=20
> commit 2cc7aa995ce9 ("perf stat: Refactor retry/skip/fatal error handling=
")
> dropped the pos->supported =3D true that record__open() did after a
> successful open and moved the resets into the stat code only, while
> saying "When an event is tried the supported is set to true again".  Do
> that in evsel__open_cpu(), which every open entry point funnels through,
> so that a retry describes its own try instead of the previous failure.
>=20
> Fixes: 2cc7aa995ce9ecd8 ("perf stat: Refactor retry/skip/fatal error hand=
ling")
> Cc: Ian Rogers <irogers@google.com>
> Assisted-by: LLM
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261016001843.7197=
8-1-acme@kernel.org?part=3D6

