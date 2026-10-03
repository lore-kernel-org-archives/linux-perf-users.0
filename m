Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6682332629
	for <linux-perf-users@vger.kernel.org>; Sat,  3 Oct 2026 01:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790991204; cv=none; b=GMtBBgzHfAaDUlWFGkzhQDlgNdGWtyI/xjoSf3UeveK8YIhtgnIBI105pWcB6in1cZYfRsn7VVcyW9X3SEJD2oOemAIHvYpLTScqxjM0+G8VMptb2qQTQEtnq+G94tFVcu9PVKL41dThEXH6TTJS7Cm4KgcZ6OnzQwVmzt8RkHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790991204; c=relaxed/simple;
	bh=mIWNl2o8lM5Ra/2oVBZBKqlv2P9QshDKHFOZRfum+tg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=sHr1gpfQBN+p34FKxKK7QtqYKlhVn2jFSWXgf9Mr0qkqjkL7ZSDNdLVNLRRE9RfrGnKHIUOarUIVmiOWX6iyX6wTXHcPW+4aGb6o4AHmRsajWxONaE69sNK8rFNjD3FGhSyUijLUY8vogf698iL20nlv5W8iVkZd2fjALl2LOzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BVVvsbXn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BVVvsbXn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E2021F0089D;
	Sat,  3 Oct 2026 01:33:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790991203;
	bh=mIWNl2o8lM5Ra/2oVBZBKqlv2P9QshDKHFOZRfum+tg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=BVVvsbXnzaIXznfEtQww/YOgAUd2NgKyoZN+Wy4UtIpcNlBkACoQrLHNMcI0g905Q
	 5zSagPN+zQt53tLWWinFeDzav0EvQPLAlbejTLLn11GUJ9IuofQH9UVlBLfKgEMOGr
	 IZQPoz+87WYcVa3YloMgyyYB7MQ96vIa+y3+ZqEfpxexcp5lfASpT3cNarZf8wdkls
	 p9ZIeLogqUT9ZvsqgKx72IMEiEhczztNo3EQO8Fw+u3SjLunIDw4FOK8P+Yb04+lNk
	 ZHDoGvgj4BGRbsPhYcG+gxA6hlE/M/0OHmIFSG/rCQUHFDL97RbMGNO6db0uxpg928
	 qbPLzND98rGBw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 3/8] perf/core: Implement BUILD_ID_OFFSET sample type
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261002173848.3228217-4-irogers@google.com>
References: <20250424061943.1321025-1-irogers@google.com>
 <20261002173848.3228217-1-irogers@google.com>
 <20261002173848.3228217-4-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 03 Oct 2026 01:33:22 +0000
Message-Id: <20261003013323.6E2021F0089D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> Implement PERF_SAMPLE_BUILD_ID_OFFSET and
> PERF_SAMPLE_CALLCHAIN_BUILD_ID_OFFSET payload writing in the perf event
> core by reusing BPF's stack_map_get_build_id_offset().
>=20
> When attr.defer_callchain is set, user-space IPs and callchains request
> a deferred unwind via unwind_deferred_request() and emit a
> PERF_CONTEXT_USER_DEFERRED marker and cookie in the sample. In the
> faultable task_work callback (perf_unwind_deferred_callback), the
> unwound user IPs are resolved to build IDs and file offsets using
> stack_map_get_build_id_offset(..., may_fault=3Dtrue) and emitted in
> PERF_RECORD_CALLCHAIN_DEFERRED with PERF_RECORD_MISC_MMAP_BUILD_ID set.
>=20
> When attr.defer_callchain is not set (or if deferred unwinding is
> unavailable), user-space IPs and callchains are resolved in-place during
> perf_output_sample() using stack_map_get_build_id_offset(...,
> may_fault=3Dfalse). If the mmap_lock cannot be trylocked or the ELF
> header/note pages are not present in the page cache (nor mlocked into
> memory), resolution falls back to emitting a zero-sized build ID
> (size =3D 0) with the virtual address as the offset. Using the deferred
> approach (attr.defer_callchain and attr.defer_output) is therefore
> preferred as it can fault in pages and wait on locks, resolving more
> build IDs without requiring ELF header pages to be mlocked in the page
> cache.
>=20
> Kernel-space IPs and callchain entries are emitted with a zero-sized
> build ID (size =3D 0) and the virtual address as the offset.
>=20
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261002173848.3228=
217-1-irogers@google.com?part=3D3

