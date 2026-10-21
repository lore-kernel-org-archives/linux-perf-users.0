Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792623317;
	b=f0SsOCK1ifpir8jH1pCHfOIvj9ZZzb6JBOA6hJgoGrX0B9F9ew2RAnyjPyKfRTYkNkiG
	 v8CpOIcWXYh8Cd7crwEl4+D3hLXIXf/KMSfp9G8v8XuPBkV+qqihf9WK59swpTCcuZTCL
	 pikZFejvsYpTp7Y2jyQ9rcYAIvjCzbm0QwaxMNziqnUZDwK73Dd8v8sMQgdUoICRm4nW1
	 mecw/95pDOn6qt5mqJBf39vPHkmjEm9aySxIMZR9CoRJtqjYCXi4lvLZCbNPgoGUBmGHB
	 J5ktIJpjRVMPpyrqrdAbjYQR34/fSNGPewItoNCcLMsbKL1hsUp69l/wEYimpEHr9zw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792623317;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=kM+gj4mqMPhvWQza4oe5SO93unmuToaG/kNT87i2CPs=;
	b=AqMvSFjyF3BnqgKPheFZ8bmdXB8uPFNYsS62lFs4eFRyGkZwZWTnUyrHuxoIL5DIMvKc
	 NvTE/Mrsl4F+zpNqtebqRwX2qUsenvvVJgsOgXZ+lB3VT66+7jE7UPAXnc+jKYlpmVjKt
	 WvEFMn5ohib/A8uPkhzpFZnpwxkhX0yMHroWJc3ZkMgakpST2SbVY+IhIvPjfXAgAMvGk
	 85NCY7xGCCOs6hZAZMRlznI88XjuwTKdVSeKbIMxp+AgCyr0ufB2ihHsHLcd7yVgPVFmW
	 ldZ9Tl44JDctO1ChUgqD44JAKxFy3AhcuYiQhmI4ixZHxKhf+0jVm9IrhylEdhRoYFQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LlJq4lv8;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35974606A319
	for <linux-perf-users@vger.kernel.org>; Wed, 21 Oct 2026 22:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LlJq4lv8
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C7161F000C1;
	Wed, 21 Oct 2026 22:55:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792623316;
	bh=kM+gj4mqMPhvWQza4oe5SO93unmuToaG/kNT87i2CPs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=LlJq4lv8rcx525Nz55RN2RqvmgOg3TS07SpEpXKmTUuHFJCrQi8yljlROSK3DcqnS
	 kaZduignfFvnYodPey7dgiecQism9/AlGAZe9PFqJmOtuyoxwTpBYxDsjk7zqV9TgV
	 EzODUrVyyitbvbFxmhisxZCPpl7qMijS54qcVneQ5SFTKn/ynT2omuzhgz9BALzXVr
	 Zj0trK7JVSnzpqTl6jKkLUCTDPM2qTwahy4tSAQj9JxgFDujayA6pxUsO/pZ3g0L0R
	 JdPfr1qn5ixlCB6YFrlzeFf1J/y5p+JU8HySfz1RCXgmWUTkaHgefICMWYy2mTsoNa
	 ttNLtTYoD1BCw==
Message-ID: <sashiko-outbox-180749@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 10/17] perf dsos: Use read lock fast path in
 dsos__findnew_id()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261021223905.715051-11-irogers@google.com>
References: <20261021171044.155240-1-irogers@google.com>
 <20261021223905.715051-1-irogers@google.com>
 <20261021223905.715051-11-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 21 Oct 2026 22:55:16 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> In dsos__findnew_id(), try finding the DSO under the read lock first and
> only acquire the write lock when a new DSO must be inserted or an
> existing DSO needs its ID updated (checked via dso__needs_improve_id()).
>=20
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261021223905.7150=
51-1-irogers@google.com?part=3D10

