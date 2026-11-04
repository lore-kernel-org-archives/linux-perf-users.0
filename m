Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793755435;
	b=L1YJrFBCmEMGqlJ5DYFyB4TmlWT9SUnfB6oABLJ9cn3e/rWfSkzitvyZ0rniG4Wish53
	 1gTpkz5JZluFHJSeD1Uc5zO2LIc0U2saMdO1FxFL5IO+0Wgft5SLWcOcTtZPOrl8sdSh8
	 ceZ0Y/AYT5oodpZtIentJyBz1WWPdWYIJayccEKFgyWODtAWd0fXS96R44ZWkwZF+hjGg
	 iDNBlxb/ydnwoSAK7T7+vCPdcd2J8ZuApiy5e5Trl7+WwuDfOD1MkuuxbPSn5Wxo0yiG6
	 5p96XOq1pB7T9rilYffpQ8XIOiIyADXdWg/jkpreDBjN9Z389g9HshOVis2CrTMUFYA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793755435;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=ApzByKyqCsAk+5QXS2vLYi+CoTobTRMnuPh+BNtS2jA=;
	b=ll4Nw2/KuB3yXzzHSZyjCVId0ljVMIVtfDd/A7ZAt06wusFFoUZQTDqyZMJT9IeoIzlF
	 O91eprFPFrQo08DvyyCDfel7BBgo4RBz6b0zwVX+cVG6LMSqwqgrfkrbeHhn3U0J4N0qn
	 upJXzSSM9iA7eqBWgeNnv7S+lgfKQYGWxmcZc/VgaGz7A/b7q+CzhhXDJuHHpRXhZHQze
	 pCN6mHXpih6QgfL8mWBU4auJPEn2Lo7mOYWQ1j2zOQbnnDoXRb5wRu6CX5bXOSbSQUHbe
	 +g6zjVSVn8J8IkeWM4YKD0y0njqDjwTFSEa0uNa0LVb0fbRJeoTOLqhPMl+38gVqn+A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CAe56rkw;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFB7F606A31B
	for <linux-perf-users@vger.kernel.org>; Wed,  4 Nov 2026 01:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CAe56rkw
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 282671F00919;
	Wed,  4 Nov 2026 01:23:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793755434;
	bh=ApzByKyqCsAk+5QXS2vLYi+CoTobTRMnuPh+BNtS2jA=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=CAe56rkwjadZ1d5lyNfnB21dppzDAg4ZT4S2yn/JeHHVn9a38Y4o7D8D4OicMGnug
	 AAzmchqrWS3Uriaw+e7Zu10kSOQqN68eyVnULwYk6J4UMBGvcRblPr9U9PsKVCf3i3
	 fL00xj36spLVulXnOlr1jps8nxQO6zuz2ZHmc/A6V9ScyP6tkOhz3MhbYJYUGKogLo
	 fxXpayTRXU8XJMXOXrP497fL8hmhqG85lFj8lVLg055k1nvYT9Ulf9wUdtnH2NOlyJ
	 nFED8GywAihK4XM8MCYWd0HGjQiQCK42c8GcGFxBzBbM19984QWsiNBas/H88b9Ua9
	 iwCsVe9FADOnA==
Message-ID: <sashiko-outbox-196353@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 10/41] perf header: Support CPUID matching across all
 architectures
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>, linux-perf-users@vger.kernel.org
In-Reply-To: <20261103234502.1008382-11-irogers@google.com>
References: <20261103234502.1008382-1-irogers@google.com>
 <20261103234502.1008382-11-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 04 Nov 2026 01:23:53 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> strcmp_cpuid_str() had architecture specific overrides of a __weak
> regular expression matching implementation in arch/x86/util/header.c
> and arch/arm64/util/header.c, so a CPUID could only be compared using
> the rules of the architecture perf was built for. In addition, the
> HEADER_CPUID strings written by get_cpuid() on x86 ("vendor,family,
> model,step" in decimal) and PowerPC ("pvr_ver,pvr_rev" in decimal)
> differ from the get_cpuid_str() formats ("vendor-family-model-stepping"
> in hex and "0x%.8lx") matched against the pmu-events mapfile.csv
> tables. As a result, finding the core events or metrics table for the
> CPUID of a perf_env, such as from a perf.data file recorded on a
> different architecture, failed.
>=20
> Move the architecture specific comparisons into util/header.c and
> select them using the ELF machine of the CPUIDs: EM_NONE for the test
> and common tables compares exactly, arm64 compares MIDR part, variant
> and revision fields, x86 matches with an optional stepping and other
> architectures match a regular expression. Convert x86 and PowerPC
> HEADER_CPUID strings before matching.
>=20
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261103234502.1008=
382-1-irogers@google.com?part=3D10

