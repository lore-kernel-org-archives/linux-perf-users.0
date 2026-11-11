Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794424755;
	b=OAxHDQ4kQsmPSVhnZ2zGL1Kz0fYpqU6I9ZdJvn+Nfh2njWfnXSsZ4pWUEFV8z6PLW+At
	 qdDMqbq50X/pmyJsATy32wDOv5B0sWhxQHuEDSqTQDrWUD0EQ5SMmm/UKh/6pYmI1l/94
	 M8aj1np6s6qvlQqE0a8F6Joe0Yd5JN7E4iVA7GHjIzoyr3559p4Vj25Ca0WaPaP5fo771
	 ANal79r1s5+FrWSaCeI1DOheU77TW0v8H4RrsypWrlX071RoxsspAmNwAgHoBGc/wLH2g
	 gIpR5zNVHN9TK6SCNizCGQnERNX1tc0k4mTsXBGg6GrAr/Jw0p42a/Hwc//owM6mW8g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794424755;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=bNeFuBgVAUyDl+7Czv2oKYgjYiXERhZGmYbHdbIf4mI=;
	b=tpHmhHNk6daAY2EZp6c870uxSkureTgRpxg+ecjVorDAtJS31EueBJwrQUUPkS4OGsDs
	 p0vkUnPrPfPXi65CS9WxjI39GiIh+kxx3RN710ye6xRwa13cKHgDiYBNi4z+AFrGbpDEh
	 UUOc+3veIx7S5wAjxtmqXhCm3tuc7T7xsAknUh+dYx9U8OoO+qGcvQxFsTvnLcRA9c9Gc
	 9zmO2oJp8zZ9jNbVRIOvJvHx4P+xQNWNdEhNfdiS7Dke3Caa//oJo4yxRqlMQ3ksY2Kol
	 om6eQ6VgF/WmzGszEWgoKtjJvhRMLEW5qpF3K0LGHXAF0XAXWpP7+2N3evj9gpc08/A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oZHDVrQy;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BE5D606A326
	for <linux-perf-users@vger.kernel.org>; Wed, 11 Nov 2026 19:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oZHDVrQy
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 765831F00A05;
	Wed, 11 Nov 2026 19:19:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794424754;
	bh=bNeFuBgVAUyDl+7Czv2oKYgjYiXERhZGmYbHdbIf4mI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=oZHDVrQyN9LhnOCCr0dV8ujLZSsLYIg0vtpPMjJxta6MNNoO7KVxPj/b2Ukw+mFM+
	 40Q2LUcGoKU0A5vO3JJsmRdP4ZFn9gSC9QKAoCm+ffWWQ6s7g9cWLjXC0/C5Xlv+U8
	 551cjC5UKdD7+4gVAdPGnpd88CxW2vUPk6aFlae679LzmNn+IlUQp2knT572ewM8ch
	 whanpAdFd/YqsrJvNu208XiXt/Rqz9zt4vLgIeSHKajh9fQspYvYZ8kuaZ1y4XvvRP
	 QR8Xtn/uKbHQ2IFizppEv+iYuN95zIQqL0Zz64a8CwDXzQoxCI4M44BPmp5Hl2U8P4
	 q6VUSIFHsWCiA==
Message-ID: <sashiko-outbox-209549@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v12 04/20] perf mutex: Use kernel style
 compiler-context-analysis.h annotations
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261111174213.3526604-5-irogers@google.com>
References: <20261111174213.3526604-1-irogers@google.com>
 <20261111174213.3526604-5-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 11 Nov 2026 19:19:14 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> Enable -DWARN_CONTEXT_ANALYSIS alongside -Wthread-safety for Clang
> builds in tools/perf/Makefile.config, replace the custom lock safety
> macros in tools/perf with the kernel's compiler-context-analysis.h
> annotations (context_lock_struct, __guarded_by, __acquires,
> __acquires_shared, __releases, __releases_shared, __cond_acquires,
> __must_hold, __must_hold_shared, __must_not_hold, __returns_ctx_lock,
> __no_context_analysis, and __context_unsafe), and remove the redundant
> macro definitions from tools/perf/util/mutex.h.
>=20
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261111174213.3526=
604-1-irogers@google.com?part=3D4

