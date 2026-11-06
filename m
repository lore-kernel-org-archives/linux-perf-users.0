Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793962351;
	b=LtHWYd9sy6mLrWq0amSqh/9ID/MiO1VCkhLZxaTKHWkh9Dch4nPGnYL57EcuG6KZOP33
	 XZ8Wt/UXe4fb56JxuHr2QekeLC4SRrnzjPslAsmZT8jvp261Fn44NpNFCOw1x8NM5CgSX
	 jUn8Ut3Rzw1K2beyyCoXykAmfKPXvg5rpPb0SBEkbGnbf6SrU3Th8RjQ+NUNYp9Lj9E+2
	 XMT0ZC2KZZwU7dsLQH1zt7Dq9f7+wogYhYZDkbqEh2DtOgjoe8mrw0sERj7/pU19K3ydk
	 1c6bl440HmMth1+OsHuTdR+ZMWsiCqBD4y/SpPqAOddYFWQ8LHw+cTkgBC42vdHqUIQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793962351;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=rR4nK+c9pvYipYsedIWAmCdwp3kO1wMEJmf1vQsa4Rg=;
	b=dSzEuj4nR5V+GGr5k5gZdQh/Cw6KuMt29TrKDHKojx22bYJH9AtCGXO6gYv/tdFgXZ+z
	 VtAYWyEkgXm8Ovu2h3KgqH3kmq/36cKvUmn3EKhfB/qeAZs+GMHnxhWC6x/XlkglZqmn5
	 V/2ZFM7zY7g0OMq6LjoTvzTu5fy5J+exf6d6qgNXRMC1MAEa+QLOEEmEUHB5z7onxDWCD
	 iArbZJ9LJw7I9VjHYpW1KNOK1wYZylM2YyGT6WOorkPzlX5PtvYunzvCpi6eladiCZBuw
	 skFQXBep5DKKNz17GRHYtR4R3qoPoOQJSjlzTWZfHN3P2ZACNX76sDefadygi3/xoaA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BkTLlBPn;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75FA0606A326
	for <linux-perf-users@vger.kernel.org>; Fri,  6 Nov 2026 10:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BkTLlBPn
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E89571F0089F;
	Fri,  6 Nov 2026 10:52:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793962351;
	bh=rR4nK+c9pvYipYsedIWAmCdwp3kO1wMEJmf1vQsa4Rg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=BkTLlBPnCMKr+wS0PXjoGYzH+c28QjWeD50hsjvBxq9dPc8a+6/5H/3MaLLZA8zgl
	 YQQ9DNnA2WL91+9E0mQ2hS11rFsOMHFGcfcEXo0pSw1VouGXTAhfSejBbrluppehdq
	 u54AzamGObvnVp3UTpA7Y/7sMsHZRqH9zcq3EpHu5TSeE2erTV4sfqjgNZThkc4TuD
	 YY0kJ88h6MHNN9ekN/FpGZfhgHbZ29zl4KFRIR3nshgcSpxTiO7LOVnObvbr6VLdSf
	 5YCxJP1Szu28bELNP4esIPEkiD7/y7rmw/RcpHBgBwZe1cSpZYkbbQdUD11VJEZjdt
	 qYTgi5g9sjIIw==
Message-ID: <sashiko-outbox-201235@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/4] perf dwarf-aux: Support DW_OP_addrx locations
 for global variables
Reply-To: sashiko-reviews@lists.linux.dev
To: "James Clark" <james.clark@linaro.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261106-james-perf-test-fixes-v2-2-9a912662f822@linaro.org>
References: <20261106-james-perf-test-fixes-v2-0-9a912662f822@linaro.org>
 <20261106-james-perf-test-fixes-v2-2-9a912662f822@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 06 Nov 2026 10:52:30 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> die_find_variable_by_addr() and die_collect_global_vars() only accept
> global variables with a DW_OP_addr location. DWARF 5 producers like
> clang use DW_OP_addrx instead, which is an index into .debug_addr, so
> global variables are never found when Perf is built with LLVM=3D1.
>=20
> Add a helper that also resolves DW_OP_addrx and DW_OP_GNU_addr_index
> through dwarf_getlocation_attr() and dwarf_formaddr(), and use it in
> both places. This fixes the "perf data type profiling tests" test:
>=20
>   $ perf test -vvv "perf data type profiling tests"
>   ...
>   Basic C perf annotate test
>   Basic annotate [Failed: missing target data type]
>   ...
>   Pipe C perf annotate test
>   Pipe annotate [Failed: missing target data type]
>   ...
>   Basic FS perf annotate test
>   Basic annotate [Failed: missing target data type]
>   ...
>   Pipe FS perf annotate test
>   Pipe annotate [Failed: missing target data type]
>   ---- end(-1) ----
>    88: perf data type profiling tests : FAILED!
>=20
> Fixes: d60469d7c0e5 ("perf dwarf-aux: Add die_find_variable_by_addr()")
> Signed-off-by: James Clark <james.clark@linaro.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261106-james-perf=
-test-fixes-v2-0-9a912662f822@linaro.org?part=3D2

