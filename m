Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B1D5332610
	for <linux-perf-users@vger.kernel.org>; Mon, 31 Aug 2026 13:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788182463; cv=none; b=tcrxGRCwToJkvxuQ3zUjJQPUaj8Gexgdr5meu5oso/m9zMgb7fS/KlHD3a+VE4H2ii5AKXDWM9bRjfHsGhM1oA5TDTQBNgYHG/HN9yIuZZzF3jKD+RM0sjFE1EMPwj8eX5CIZmBz6UkaQFk1SEa8Lp1p2wzfaiqo7spmeMq3F/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788182463; c=relaxed/simple;
	bh=5nptFH7KUedYroTrQfw6FpszDTKfJK9aS0MPT5gaLVU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=HQRIYIEAs5gOdPt+M5t6eD4A+0iFTtgZ1C69f9vgMTMrt7WUh3YRdCUc3pH5jWQ8BdYfZo4JLwR9Xr80c5Jv29aVKn4tM5pADClIE2V2xc2xmTPKCTr7Sj3EgOPWPdBNbhvUwYb2D0Xm90jHIirrZlBESXBj9JVUYM2tMyWxego=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QhlTiB1w; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QhlTiB1w"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CCC11F000E9;
	Mon, 31 Aug 2026 13:21:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788182461;
	bh=dw8z6NLQc5qvaVRZanN46yIoQA5QmezCyXvkIl3RbaI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=QhlTiB1wWbefpGzYO3bLu42y5ibFF++v10WtT1g1I/+A2AiLffeaoG1f+mS0w+NWg
	 pgTHhWXrA4hkDMKFi1xagxhUIVdK0Ec8yQJtott52u8IyFfkzl6QZXCB9rJGWbANA3
	 7Thd5FpoN2xn7EV6yCwdF1XYUvHOBP4WTIeR2DJA3N51k3a7lZKTwuDX/XzOLK7yTX
	 ISWUAKZ06WBMAu1MtRHaVyobNz6GXILFsK5rLLOc2stfIxFP55wAQOQ8anTbptXPXU
	 PDezr5a7k9QjLJd6ylIlzxOdw9oAzAjwxR8m09W2A32eyuqQ3U2WrkLpvjeK0AI53L
	 yYNzbeVd6hYig==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 03/12] perf jitdump: Validate code_size against
 total_size in code load
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260831131110.4681-4-acme@kernel.org>
References: <20260831131110.4681-1-acme@kernel.org>
 <20260831131110.4681-4-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 31 Aug 2026 13:21:01 +0000
Message-Id: <20260831132101.8CCC11F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> From: Arnaldo Carvalho de Melo <acme@redhat.com>
>=20
> jit_repipe_code_load() reads code_size from the jitdump record and uses
> it to compute a pointer to the code blob:
>=20
>   code =3D (unsigned long)jr + jr->load.p.total_size - csize;
>=20
> An oversized code_size underflows the pointer arithmetic, causing OOB
> reads into earlier heap memory.  Validate that code_size fits within the
> record (total_size - sizeof(jr->load)) before the pointer computation.
>=20
> code_size is uint64_t but csize is int; values above INT_MAX wrap
> negative when narrowed into csize, which defeats the bounds check and
> sends the code pointer past the end of the record.  Reject those too.
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
-1-acme@kernel.org?part=3D3

