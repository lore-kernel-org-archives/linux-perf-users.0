Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794607171;
	b=3NvBm90bB4dKbE3D/ZmCxqiAW1oVRGXRB+ERIXYE5syruJDdSUpy6BQqN39hhjg8uUq5
	 DAabYiIrp2lA1CEYD6KaW1m/vsK1angoTUeL/ttVWgtJeOQLleTOjBjvtTyIjX6GyM58V
	 z6VyaqA2h98/ml3gr9TU4GZBm+RV8o5lrjfS47HJ/Nt3kopBAmVYx3i9pO4mTCq4cHAyR
	 2RILSJN/YyPJ8WW5WCQ6/rYKfuE9GM3L/n2jJTi9tB+jFalfqPipjM5B7SQODhfXQdiPJ
	 8wzLdyVYFLSlAZaQLNQm+ZxXURCNZUFS500VRQCjwYsHp4WvxRnh2P23/k/fS1DD4fQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794607171;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=Y7AiDRYNVVPP0/qspzpPull/Y6fOSdm0aep6WVRLpw0=;
	b=5W9jFvOIvqssTmdDmzaA39ix2Q1UFax/z1Sjm5Xl9zM0Z71Ut1WDGom2ac7G9fjHoVMD
	 Fj/2OlNzSOMCW3P3UU5XEX18+SFdpzV7V0QRBtEJIpuw/qnac0w8S5D1WOt2XrtKneYZb
	 DQ+Dp7T8idAzg85b5rNR0PXuhP6C6sKQCgDbOnuq+JIdLC658dW/8jXGjMmDgCCAAcNJN
	 SDFe2lPATL7Ky66xrdQ3hsZpiyxltVBhK1dDjyfvagnlcnMxhl3HbevZtlbv77iCnWRb7
	 3RGgqrgCZ8eF2PrzpSEMh9GAnbHHTSaKccK/fal4yqHi8bRv+IB3FzF9KxkS2jqG/RA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=baltD18n;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58A85606A330
	for <linux-perf-users@vger.kernel.org>; Fri, 13 Nov 2026 21:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=baltD18n
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE77A1F000C4;
	Fri, 13 Nov 2026 21:59:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794607170;
	bh=Y7AiDRYNVVPP0/qspzpPull/Y6fOSdm0aep6WVRLpw0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=baltD18niQtByuC03YHXlejgFZ8OYFrdppbXzNzaP3eNo9mreBEPxaea2WMh5PYRv
	 2hvLbol5Xu9azFiMYU/qf2OeNtUGUnLUHlOlszeLK4B/iMWJBytj3C7FJoCGteVjGl
	 X3IRAtOdmX4jQ2cwIT9L/UyZaoQW/cO97WssICg7dFfRE3YgmvTknYDYm+dY4jrQ3X
	 ZaQN0asbezLNkLB/iMu3Uf4zkVr4ObwcRUQpG2SJzSKVB2PiW+aoCBlh5JdDLdWXUK
	 CuRd20DstnlC++8MWSD3NorVd7dzJg+62EN1W51nVYRA7Ci8w9wt47RpDgf0Ei79yX
	 Zb1HA57eOqUMw==
Message-ID: <sashiko-outbox-213759@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 23/26] perf inject: Use generic hashmap for aslr
 remap_addresses
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261113214850.3329699-24-irogers@google.com>
References: <20261113214850.3329699-1-irogers@google.com>
 <20261113214850.3329699-24-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Nov 2026 21:59:30 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> Convert aslr_tool::remap_addresses in util/aslr.c to
> DECLARE_HASHMAP(remap_addresses_map, struct remap_addresses_key *, u64 *).
>=20
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261113214850.3329=
699-1-irogers@google.com?part=3D23

