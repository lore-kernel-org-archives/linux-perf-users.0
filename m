Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793771346;
	b=y4T/uVN67sucPFHTl4kz6u8uZE6SdCtmy+LuwhZqb1GVBJ+srTxA5K+w5XHDuKHJK4qC
	 zLdU+ZMsNUMudi+iI4bQcCc/Puuyp5NHF2vdu0oDgPyEmkNj1DM1rl9wFssw7lrHAv6XQ
	 TdNYRSI8AsmZBYX4VtWJ2GkHRuleBBUvGRYwxw7v8Rp7W7Lc6zi6bvndoiex7nsaqoAbE
	 WhgD7UpQG4pxHthG+dEPhoimXELsgqqPICNpLQi9jGITWpNkyxyPKxTYmiAYhPGGLKL/p
	 +jKfCGdds/uPKEvFnR4FIBVPiu9b7IQTWIbHhGvdaARihR3cLrHL7QaWhyCNSHRb4NQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793771346;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=Yudw9IHXUv/V7fCYgPvhgOh2aCMvKuhzeUMkJFTVq2A=;
	b=uDsGm41yYKD2bMdZvhVwkLzeZK5eNWNBgU/iRISbbmX9tH3FOPC92jqYTjDSLp6AhW0G
	 B5/vZNV+NM46wa1Eho/uPCS1DmbrcdiQ4DJoFUW3+LQPkPo73JRIhA4V4NvAy0iOoWaol
	 tj/psQlqK1mKMWdBpXjcllKTSqPCM/+kJIcSUn1+2FtfDlNJY3TGdkAJVq0iBp4wDZEh3
	 vNicCuJ2mp0j5LN2OOGl6eLYlJoLWnY+Y5Ag0gEAFJ1vv/rreacKKpcvUwY+AWSSt8NIF
	 NAf1eWkKxJ7PGekgLnu/GOgyZEp18ckt2lwPdPlj1qrjxwkohcGqc+y00JgJox6Rf8Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=f57HUFLA;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85DDA606A326
	for <linux-perf-users@vger.kernel.org>; Wed,  4 Nov 2026 05:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=f57HUFLA
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B56981F000C1;
	Wed,  4 Nov 2026 05:49:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793771346;
	bh=Yudw9IHXUv/V7fCYgPvhgOh2aCMvKuhzeUMkJFTVq2A=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=f57HUFLAsMNzPHYKjKM0f0x+MEHkQC2QBbbmLnUXYcTfGTQyi3yPAF8Eh6trVX7A+
	 AvJqqg5OHXfcr4HPSXYIXtwF6/+VGNkSG8VRmgMmQXYFMnAOXXXa1I/QCuGL1RW/q7
	 9gFEvYmrGqm4sYBcwqFEc50FuVf44l1/yWacSzTmV1OHZSbxXLZEcfDA+KeAGS5WZw
	 GFnwK7PWFF90fgfStKtOnrzwDicPIEOcPKI6KBBw8QNsRKpjwlPyKjurJ6YzdtZZu3
	 5yEQpC18fWYqEyHC8Qj//4vi0+T9i7afLAuZw8+Na2BVMSy7reedvPj+PLGoTcRVwL
	 W0TNoxA17SZhA==
Message-ID: <sashiko-outbox-196683@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 29/41] perf pmu: Probe supported sample_type flags
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>, linux-perf-users@vger.kernel.org
In-Reply-To: <20261103234502.1008382-30-irogers@google.com>
References: <20261103234502.1008382-1-irogers@google.com>
 <20261103234502.1008382-30-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 04 Nov 2026 05:49:05 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> Extend perf_pmu__probe() with probe_sample_types() to test which enum
> perf_event_sample_format flags are supported by the PMU.
>=20
> First test a common bulk sample_type mask with a single
> perf_event_open() call to avoid per-bit syscall overhead when all
> standard sample flags are supported, and then probe any remaining
> PERF_SAMPLE_* bits individually (configuring required companion fields
> such as branch_sample_type, sample_regs_user, sample_regs_intr, and
> sample_stack_user). Populate probed.sample_types as well as convenience
> booleans for branch stack, callchain, data_src, and weight sampling.
>=20
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261103234502.1008=
382-1-irogers@google.com?part=3D29

