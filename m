Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86D75330650
	for <linux-perf-users@vger.kernel.org>; Mon, 31 Aug 2026 13:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788182468; cv=none; b=UEbFf5ieIq1Y16zXwxxe7txPzuwl5Ys8opKO3YqhNVd43u/falbssheuqGmgJjfP1zi3Zs9i4Mzri1z4IUY5siel0x4LZlTdkdU3ZPLs/e25heaykjjZz9rAYlUa3ysaegwHMa1bhyT2rtLAiHUmMjXqVW0tepXxjrH0fSOxf7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788182468; c=relaxed/simple;
	bh=spXqQzHaiZzlB4KSs1z6g34AQMhTqtfz8G1ljF0JXIQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=rGoCvSHLshnAN1IdbJH+p1sQV+GREgM3YoThreBL6OGWKO+aLZqTMaMiq19q6wbr2GBw/pTTej+Noqu8hewa9RU9SnQKM6KCJpzWIotFTEZn3moK89P+PB5bv0KuzPJ7gDFPCpT1pWluG3t6S1ei+hAuOaloMorP7wV0lsH7iRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NrgLBsyN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NrgLBsyN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FA891F00A3D;
	Mon, 31 Aug 2026 13:21:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788182467;
	bh=O9PMd2NhLik8xVsTovaISAHpa2zV85k+ysjughtek+k=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=NrgLBsyNpfvA0qsZuUMB7tnIPGYT4qI8o1YspkDGzlJbnNsqBK4g+ur8o2AiCjule
	 aDVeSa5v3UolkWOgzvC4BlIhHgeAKfRq84vNqppHwqXjeB918y4H/srKB+IBYW8him
	 bFblJ0fbytUZf75vN+X1vK4HRTjw8E/r59wf6fe2VGlCm15e0P+V09WDIZKq9XgIj2
	 HpJyGXtXut/eOcTlC7Jk8rspSJ0N8vmTm5Fac0F9t+dvUzzNw+lS2DIahuAeiHFZud
	 2eKS3SEc98HLeAZnnvzujVvhbywDs84lG4FJI82YFH62ug989d/7PHaohNdtRom5wp
	 N0l/hE1EVVmbA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 08/12] perf jitdump: Free event in
 jit_repipe_code_move()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260831131110.4681-9-acme@kernel.org>
References: <20260831131110.4681-1-acme@kernel.org>
 <20260831131110.4681-9-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 31 Aug 2026 13:21:06 +0000
Message-Id: <20260831132107.3FA891F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> From: Arnaldo Carvalho de Melo <acme@redhat.com>
>=20
> jit_repipe_code_move() allocates a perf_event with calloc but never
> frees it =E2=80=94 the 'out' label exits with only perf_sample__exit().
>=20
> The sibling function jit_repipe_code_load() correctly calls
> free(event) at its out label.  Add the same free(event) to
> jit_repipe_code_move().
>=20
> Fixes: 9b07e27f88b9 ("perf inject: Add jitdump mmap injection support")
> Reported-by: sashiko-bot <sashiko-bot@kernel.org>
> Reviewed-by: Ian Rogers <irogers@google.com>
> Cc: Stephane Eranian <eranian@google.com>
> Assisted-by: LLM
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260831131110.4681=
-1-acme@kernel.org?part=3D8

