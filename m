Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794607016;
	b=CXsuYaQeuptPsXSyS8qE7MScLhnb1IpAbvxXt/nAaQoeHi4qLPgasUxPlvMWeyWHTnC7
	 y9ar1WIuRHBH4h9awwSvzRWzzN2gCLIr/pOICvgTaxHWtUD5o50+d2VsXrPPdLWCKJV4a
	 +OGI0jMoyEspq6PLUOxcqJxkm8gJ0dBVgOeE/PBAM5x7FeRko9RULlTohQZuNigqkTLvd
	 B3SKmLbBjgY6pFMTH9oNUNpIRQlmkVvt3bG35QGtdfJkJpFnTjLPncwZ6lJwMPZEoDqCf
	 RNl8LDVdyi5GQ8EouVR80kqfM2I+Vc7dkaB+wYEMVBHOqsSyGc+lecrSILXpxCbMw3w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794607016;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=0lvZ/pCJciACY+lvJ7x/weZaCs8eil6g9g8nZ7a7jz4=;
	b=hZlHcwtb9mg03tRiXhYEbq3ZEesD8nAowsaxYrZyr85XW93EQzqY92w8qeeujuBnnlX1
	 Zlb64GWsddPVa1tszK1KQxVUpCbhILmoU8OXf6bcY5ueIsyIm2bOrIvZdyqRl98h/ivb/
	 ehDeAqBzaoIDxGbaXAY1h4pTjRSmHP9nODsp8VCQ1FhkqkSHBEX88SGbgF/DmyXIxlbXT
	 BVCMClYPAItDqeSt8MrP4p6cIVLmz0ZVZs1f2JRKihzescmLjTHmb08Hh6YzM25y5UyDS
	 4CFTlz+e51wmeZv3WF0nBV0WifBB0BI5aeA9ChBr7WZ0cqyjSJ1ZK1HEgxmVlUs1vmg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gtL4rLuQ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEAAA606A330
	for <linux-perf-users@vger.kernel.org>; Fri, 13 Nov 2026 21:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gtL4rLuQ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B64E1F000C4;
	Fri, 13 Nov 2026 21:56:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794607016;
	bh=0lvZ/pCJciACY+lvJ7x/weZaCs8eil6g9g8nZ7a7jz4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=gtL4rLuQ1wpuTYy7I7S+ky7jkC81OzWj9XJZjDu6oojthpSI22vk1MorsSAmF9dOy
	 TJZwNbuMyr9rLRFxsAfQkFK3i1c7J8BL3LS5NBMgpdzh/YfGfHSoH5fLvSEvwbhk4O
	 NHJo0v0Ys+dQF9OVyca8s0iqVq3AfwWeEEl+3Udy9rHjDneQQRhRHuZUbj/YaNhym1
	 1VV0EGGwm4E6YN+R3dM9r3tv8L/z+ouZrj5IFMl3OnbuJjPuMCTyAT2fgEDuf0JJPE
	 Tnc3TJquf4C8d3BrjuiFoVmp/XiUm7sLVpDoA/hzaoQvud7LPh0BNXE68bjULcim3d
	 M7o0SNQxfZAVQ==
Message-ID: <sashiko-outbox-213749@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 06/26] perf hashmap: Fix strict aliasing violations
 in hashmap
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261113214850.3329699-7-irogers@google.com>
References: <20261113214850.3329699-1-irogers@google.com>
 <20261113214850.3329699-7-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Nov 2026 21:56:56 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> The hashmap in perf util (copied from libbpf) contained strict
> aliasing violations. Specifically, the hashmap_cast_ptr(p) macro was
> casting pointers (such as void **) to long *, and these were
> subsequently dereferenced in functions like __hashmap__insert(),
> __hashmap__find(), and __hashmap__delete().
>=20
> C's strict aliasing rules (C11 6.5/7) prohibit accessing an object
> through an lvalue of an incompatible type. Dereferencing a long * to
> write to a void * object is a violation, even if they share the same
> size, as they are not compatible types. This can lead to undefined
> behavior, especially with aggressive compiler optimizations.
>=20
> Fix this by:
> 1. Updating __hashmap__insert(), __hashmap__find(), and
>    __hashmap__delete() to take void * for their output parameters
> [ ... ]
> Input parameters (key and value) remain as long, as they involve value
> conversion rather than incompatible pointer dereferencing, which is safe
> under strict aliasing rules.
>=20
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261113214850.3329=
699-1-irogers@google.com?part=3D6

