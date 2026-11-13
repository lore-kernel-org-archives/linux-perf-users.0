Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794601451;
	b=DvIZJQurYTbRRMw3JKHgSj7s0xYJnwtcgrS5ovhHPLtYN+FYsk13TjkaCg8m5JAG4rAU
	 71W9LttOto3da1ANVL1I2gN8rV7Rgrh4NKwJMmsRh0HhzCdKXQ/lPfXIclek863PiE0aC
	 uIkRb/zCWlRhLJXWAadBFgt+c/9ECpi8BkXNdSZY9/TRYiE+47ubVhT5xDl9bLOlMypeA
	 9IJPPBVMh2pW/HbXduBy2Mml1DCJj/HPk/lQI7FnX+jzNE+SBns4EjvUbkRNgI0s4TC4c
	 YzxsYquKj6xDm4NHq6fXfCpjI4dM5E7Ds6tnYlgBHZfxUtES0LCUypFmeDN7innq6DQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794601451;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=7ne1ziYRdPok438q6J3GzlvhXZKcpJS5hTgzS0sUfGA=;
	b=VLkrROFfZoa038r//hG6eYzf9bSbiC8xcbVnmeyMPnytLdV2G5hkylqBKz7bpG0+ij99
	 W4xy7j69kyDdtsgMs+18GrlRr/iYwjFRCFMqv6w8WAm/njECFH8B++Rlkb2q269C3HB5Y
	 fQ9dNwJhTouMgME4EG9nsjmS8/vpg0Sf1EisD/ZTdvD4gnDwZm+xqg08O4PttuwhYPdR0
	 Xt4qcUer13Lrgxg+Yl6dxxM/rPz4aYwNbUExdUWkUCfLeUNGTF05tOPxHlI79oNywMSy/
	 rKDVjNnBiw2TyfY7mw2t1c7e4+jTty1t4iqIf3Q5va4E0ZK7yx4dYtXvdKyx/huijww==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nIOkwHUY;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23DDD606A330
	for <linux-perf-users@vger.kernel.org>; Fri, 13 Nov 2026 20:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nIOkwHUY
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A784C1F000C9;
	Fri, 13 Nov 2026 20:24:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794601450;
	bh=7ne1ziYRdPok438q6J3GzlvhXZKcpJS5hTgzS0sUfGA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=nIOkwHUYduCnJJbgv69yqu4sDxu1R4mfb1czbrz2OXqxSguUXfiRiIZMA6ZvdJtwo
	 umybQ1bGhC7sAt40NgJrbPIfN9NLL88KGpuKnLRzQbxMEdpLacPJAJdcGQ5Qu6b8Og
	 bwFVgE21NeUEo7GpiYMCTcjrtiWnaMle3ULZd7CFoIVWu0AlDUxZb+fj/LkGwXYf9w
	 +smHigkL6EV/LYBjzLCbic+CozELgy6eFVnffQl1/nafvq6yfzFku0Xo844kj+GE5y
	 IeiMf8mLIKEWBgxgW+AavH2ZGreH4Zjjy0cMWE68E1hEWnc8U/5G1mewKkym5Qdlw6
	 wip83mlE0gHKg==
Message-ID: <sashiko-outbox-213633@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 08/11] perf build: Record the display-only features
 in FEATURE-DUMP
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261113200850.2803460-9-acme@kernel.org>
References: <20261113200850.2803460-1-acme@kernel.org>
 <20261113200850.2803460-9-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Nov 2026 20:24:10 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> From: Arnaldo Carvalho de Melo <acme@redhat.com>
>=20
> llvm-perf and rust are in FEATURE_DISPLAY but not in FEATURE_TESTS: they
> can't be part of the test-all fast path, which sets every FEATURE_TESTS
> entry to 1 when test-all.c builds.  Since FEATURE-DUMP is written from
> FEATURE_TESTS only, a FEATURES_DUMP=3D build, as used by build-test, never
> sees them and silently builds without libLLVM and the rust workloads.
>=20
> Append the display features that aren't in FEATURE_TESTS to the dump
> after the regular feature checks have run.
>=20
> Fixes: 206dcfca1f5cfac3 ("perf build: Autodetect minimum required llvm-de=
v version")
> Fixes: 3f5dfa472ea6771c ("tools build: Fix rust feature detection")
> Cc: James Clark <james.clark@linaro.org>
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261113200850.2803=
460-1-acme@kernel.org?part=3D8

