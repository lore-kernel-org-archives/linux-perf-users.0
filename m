Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794582885;
	b=diPhRHsNNeQ93Zbo2G6+OfstaLTAJVDTtuCjp7eiM7E/yvlGz87hhIEFGm3MMAcen3OF
	 vtxJEtH2xlsKhMIZdBTEh5F67MnO79aTp0jO2+ZOybuUKzaNEVlkbb0csLB/8uKT1jCPW
	 6BB0g3tWyqJEpuN7O6mquBTjXItAvrTAEdgO3BudEcHyFM+vDAWxAK/vavdW8kz7BsAGF
	 bSQKVeLMPT9bCxm32/Rz/5OtArP/H/z9XCjLNVL74KpSE/xKlZaBUzVrU7prrAGhYCDo9
	 QpTYb9kM+7ZkXyqEcYKzGMmJ5d5dDcTK1EvaoPtSoe4VgcjAC89JUprgU+c8AiPHBPw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794582885;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=uAuiYxwFx16oZHq911IEmZYh55fRZWZ8SzilO+xE/cg=;
	b=Gu4lk90DyfoOtn9vabjGQvgASO+vjAX6smItb6Tfq+8FCIQBM0ygsKAzud9uZXme+HP5
	 DYeaXqEv+kTIW184WDJCoO7ANwy5YvnKqph+8hCQSmSD+mBYsPjS3sNuIE7l3KjJbYrwm
	 9INh5CmcuvYoxtEvx/ws1faKA2fKFwc6wbaQ0gTNwd9RqD3LCQSlLWsnKtfSah9P/NpRm
	 vhNt5Qq/TcQmi9OcpuXRbvHfXtcF661djYajCTNrEd9id6WKSDFhmES3GgAopywGpfmaX
	 aIfATsaW/CJfJ78va48xwtoN3BmUcctlHXpBnFUY1tnSdofjSJkIXOe2ewyEBq19xqg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PpyG9jCF;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12B91606A32D
	for <linux-perf-users@vger.kernel.org>; Fri, 13 Nov 2026 15:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PpyG9jCF
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D5701F000C8;
	Fri, 13 Nov 2026 15:14:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794582884;
	bh=uAuiYxwFx16oZHq911IEmZYh55fRZWZ8SzilO+xE/cg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=PpyG9jCFI41z3s9QjL/c6owgVz6ZinTo/dXx0xx0yEL0niG40XncETHDoYROCDIMD
	 lpZcsirtY53k10vAjHmkeRCV5xPCJFHGOZfNjx8EPe20hQmjpgwuOKH04+KQK6PsUJ
	 UdnUkeUC28m4vJ1fnZ6+bifcU89w9E/Qr9H9Z/4dv+XsuAqVyXF+AV8dTdId9lMC1g
	 X5CoYuWL3Ar1ijdJWy4iTmC5Um4kv48jxTyNyYxdUF4g1CB8yj5EswbX5tS4qdnJjG
	 t3ZeNLz4Pl0lyI7GE216vA39ZANz33yjoF3HIql0sJwetm1L398XFX5Mircjl8v2on
	 tQdFThWQwuMNw==
Message-ID: <sashiko-outbox-213069@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 08/12] perf build: Record the display-only features
 in FEATURE-DUMP
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261113150555.1163049-9-acme@kernel.org>
References: <20261113150555.1163049-1-acme@kernel.org>
 <20261113150555.1163049-9-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Nov 2026 15:14:44 +0000
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261113150555.1163=
049-1-acme@kernel.org?part=3D8

