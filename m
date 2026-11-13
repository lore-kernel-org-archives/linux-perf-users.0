Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794567528;
	b=Oz9EnPBhbfn49g5o4ZDkIkiudA54aBVcZ8J7KnXARzSewCG80gHS5COJ4gh/WDIscwNv
	 4jB9IFmKxLtN8qtGrbMrLyM4Ittac6nXvv+/YVUo7uKjAwt8L9y6KWbzghhRUaykSNyxQ
	 3WQFIfEX6nq0U0SQy85cV7wZF3SAGlEdSJHahLkZmsojwCJ1ep8jNS7tN5UlB9TkvvfSu
	 2szZ/H1ByPd97+5stVXSSwuufs8cltGRC8qno8AKv6I9OqCwb2HlYSEjxh86qMhhQhwEm
	 52mIFcjDZjEzKI6JZ6zvHOWPXF+ACYAYTBajBsX1PyMZL1UNizVTtNEclr3XcPaELaQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794567528;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=n2uGRD+w0BMjqx851vNrxQvVPabKmeaHp+sWVbWqVeM=;
	b=zcvEawGqcwCh0rxfSDHkYWVLFfspiKFDhxHiDe2armG23mcSM/VdYUzuKmyCZ+caJW4z
	 CVgWlNlIjDfj+aKZuoranpKhrwP6S6wTRAKZ/wLvjwumg1o3V2o2qITd35rnEYk162Sfm
	 HwE2TjOHLOY+4VLBRngpus/5Iu78sZAgU8mBzBLkDEyeO21PvHeROd1add3Ix6wjv6KL3
	 +oSYGT8JLFK4NDSI6XUrds6pRZEon23T27WwISXX7dLbDd/GLBbeS03o4dybOtwCijJj0
	 EMxnSfG+iAWP+4XYO21yp6A5/CHWh37QPgMAhczV+6rc+Sw1dyne9WvGy4c0LzLbF4Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JTu2Ikl+;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8706A606BD80
	for <linux-perf-users@vger.kernel.org>; Fri, 13 Nov 2026 10:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JTu2Ikl+
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 080881F000C5;
	Fri, 13 Nov 2026 10:58:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794567528;
	bh=n2uGRD+w0BMjqx851vNrxQvVPabKmeaHp+sWVbWqVeM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=JTu2Ikl+9xqsa8dwZbhK8RgxrCwQgz5WRwacMvAA5CW4aut5T7t5xc4dD4kSsG+mi
	 BxcV82lg4CZhdMGOTJrAMsW+fVPpNfrDPZejTX9Hs9yKVFMjZHRvzXBLG7P39cpX2O
	 B8oQAyszNQRsBG9xPqSlqZCks1XknnTYgEYokfQVGFhnCrbTi6flrD9qKhOf5qQ1+z
	 GDfQwwIY4A1iv3EdBu3l+vb6JmpdWLYye9NxFMCVo+toObezEDhoQh86/enMskiMA2
	 zsRnJhrr5+jXclaXRwq58PaUVOdWJVus4Iv35GdMf+fHBv0+jaGjannAVejKxfhSpE
	 GlzKh6gyKBlpw==
Message-ID: <sashiko-outbox-212653@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/3] perf cs-etm: Initialize the Thumb instruction
 buffer
Reply-To: sashiko-reviews@lists.linux.dev
To: "Leo Yan" <leo.yan@arm.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261113-perf_fix_gcc15_failure-v1-1-eae592c5ff64@arm.com>
References: <20261113-perf_fix_gcc15_failure-v1-0-eae592c5ff64@arm.com>
 <20261113-perf_fix_gcc15_failure-v1-1-eae592c5ff64@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Nov 2026 10:58:47 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> cs_etm__frontend_mem_access() can return zero or a short read without
> fully initializing instrBytes. cs_etm__t32_instr_size() nevertheless
> inspects its second byte. With CORESIGHT=3D1 and -O3, GCC 15.2.0 reports:
>=20
>   error: 'instrBytes' may be used uninitialized
>=20
> Zero-initialize the buffer to avoid reading uninitialized stack data
> when instruction memory is unavailable and fix the build failure.
>=20
> Reported-by: Ian Rogers <irogers@google.com>
> Closes: https://lore.kernel.org/linux-perf-users/20261030-perf_cs_etm_fix=
_non_taken-v3-0-7629b52ab047@arm.com/T/#m64fb81c665214b79883d9be815b40ac5f6=
669628
> Fixes: a7ee4d625ede ("perf cs-etm: Support for ARM A32/T32 instruction se=
ts in CoreSight trace")
> Signed-off-by: Leo Yan <leo.yan@arm.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261113-perf_fix_g=
cc15_failure-v1-0-eae592c5ff64@arm.com?part=3D1

