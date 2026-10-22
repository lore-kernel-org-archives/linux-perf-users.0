Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792700943;
	b=ZWlPNuZBb8sr0j7tfZTMO8y4qulIS513Fz/en9U9E6uU9lWgTwwLj/p8EeHPaBl01Y6V
	 hR1vjqx0bjJJhCsvn5uSjSx/C1DNqn/cXVJH2CRjI6ZCREeRMk1lNQFJraCd/UH+1tBh4
	 Ik+hCmXUndW+G1LrQ5SjwV5+Yj3TViKi3EN4gM0FswAtmtn8GVIjRBiPB4PVdHh4GI8t5
	 B+r4X9zr2DaFnQmWCXXXjX5Fp2pB1/LfgiCRkQXWQbaUG3+UmRsAiv+PIpOE6776VSBJ3
	 hwFeYJl1aZRkAdu516S6pK4oxVwQ4oy6/hOk/E9NMPS8X1ZOyDI21GHkllIpTPApF+w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792700943;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=TM3VX5riTTnY3X+pqMmpnLXYyFnBCb3/PVe1rlEXvPY=;
	b=tlKefcypPUdwOClOyFeV2nZrPGxPYMzQu/np5RHWuEm1CZGa26QWSj9rXECPd6+gWmj3
	 iuzCI6uNMXZaXq7uQ05x4d+dmFRN1RR+WIeb5W97BXpDWz7HyKd964UdhiuRHB0neuZGL
	 BfCN5nLMfSFzc47b7yCaVSv++jt865E1D43NnsIcnrYpCiDZaYxpNHvl5uTBxkVzE33+c
	 nt61PLeKhh7ygfr+XaGYk0FoJMJ5eR1P6gzaBKNVITJaIVXC+HArqC4mD64gJ+RwSJ+Re
	 vWqicxouQU83JrSf9yV/9r4DrX99z+UKJ0GWEhkGPnUEdovQGeNG31dgdmh+XekbkLw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="ogcOA/2h";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B854606A319
	for <linux-perf-users@vger.kernel.org>; Thu, 22 Oct 2026 20:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ogcOA/2h
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A6D91F01825;
	Thu, 22 Oct 2026 20:29:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792700943;
	bh=TM3VX5riTTnY3X+pqMmpnLXYyFnBCb3/PVe1rlEXvPY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ogcOA/2hZH13x4B+zx6qCvaaFd+Y3mtO0q9WM+u0xdK57VNfAb3DXlFvSROkhj0vr
	 EvyG1qCl2ssVAbPFLPElvNtEG1kTWSIv+9KyKhfaEP6Apx8+aH8Bb0DVP++uLnw/CB
	 4CBFyFn2g5+ylYxNdnebnFKVOl3EyngsoouTTytQi2Q5UgC1lG0NtSQqWfhZIcZ8AA
	 ReLw0+yfLW7ofk2gCaInKRF1bcui82fqHm+JGUGusyl8JsF5Ndo0JBnSaWHWg11nFl
	 JsM2Z6nzSeurUoob0Z3dtn/vOGsYUuovRPz3nm+sanTRn3Kn8g3+yy0LT88uWjM2HX
	 Dy1EQx2+iLRtQ==
Message-ID: <sashiko-outbox-182004@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 07/19] perf vdso: Fix unlocked __dsos__add() and race
 in __machine__addnew_vdso()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261022201453.1717523-8-irogers@google.com>
References: <20261021223905.715051-1-irogers@google.com>
 <20261022201453.1717523-1-irogers@google.com>
 <20261022201453.1717523-8-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 22 Oct 2026 20:29:02 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> __machine__addnew_vdso() called __dsos__add(&machine->dsos, dso) without
> holding machine->dsos.lock, and machine__findnew_vdso() and
> __machine__findnew_compat() initialized machine->vdso_info and created
> temporary VDSO files without synchronization. Acquire
> machine->dsos.lock in write mode across machine->vdso_info
> initialization, duplicate checking via __dsos__find(), temporary file
> creation, dso__set_long_name(), and __dsos__add().
>=20
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261022201453.1717=
523-1-irogers@google.com?part=3D7

