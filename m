Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793656246;
	b=l7W3k/4zIP7PoEWMrvlJXB9Ms2SqVpCmY4YA7aNjBR0VtO9/uWro9mbUsdltGXQBcDxa
	 cnd/wafo/OQk7VrnN4l8mPMTZ44Te5sxK2Cl51ChN9Uf7JnmPzngDoLLCEMwV4ECuXrvX
	 u/76WCeLuPt9B0KZCpnglSGt1tyR1RRzEWTOOQYMyOWxg58gyCn7Nf+pSXzVNQ6FiFHmC
	 YFwko+7epliUHlAMrK7HJvgs6I13e4PxdaUtpsPY4mzlL4lUsXQYAZDEvgG/I7OM08siN
	 BElUE1yGOhdh5N3t+SKsKRPITjSqo6yI5PmJncmhaCWxd//2T8vypg3Qn+U5FXtOOtA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793656246;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=2wTmXHm8ZB2VmYmV9wxZOcCJlNrvo9F3qb3t1CCEHxg=;
	b=my1veEI4NJHW6or0fMBWXAPbjbJTrhDVCNSQdBoFrpulKzG74Udl6AfSj6YWYnDrfEUm
	 mDbiaMm+zSePNL6yzQxOo0J28jEaj8YIrOmPXi9KYPShPoc/HLjWDcxtRSq4HSbq9qg3e
	 myJl2CY006spNI2xZahdPvY70GsP3Dy/hNG6WtAgaxeNV/CF2k3nmzFIcVGWT6tOPyuW3
	 p8McAfAqYUrN8pPTEarnuFEAlnUOUf9FnmVY9k0y9PFah+e7Afrsqif8D1r/9iXF7CQMR
	 Ng8fgOxR95hIDuAwW84PyZDRATf87FobZybZXVTUYVN+63USnxStJOlmm/umfDdK8IA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=C8CcA0Xo;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 109A6606A324
	for <linux-perf-users@vger.kernel.org>; Mon,  2 Nov 2026 21:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=C8CcA0Xo
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F41F1F00A16;
	Mon,  2 Nov 2026 21:50:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793656245;
	bh=2wTmXHm8ZB2VmYmV9wxZOcCJlNrvo9F3qb3t1CCEHxg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=C8CcA0Xo0NKhxDD/ze0BLKvzgxSCLQijdE77X8Qht+pCY42NZ+7/JMnv7oPCySg+P
	 6HsXOiMmMiLw9luB5Q4t7dAaICghCL5lukGhT4gBYC38FNP4avwfPG1u408qGTSh0b
	 T8bvaT4IIOXfY9sn23U+I1cCzC4euoh74nWkfCLkO/n+ynDlHsRQP5fS0WqHWPFHQQ
	 aaRWoZLja2DsvQ6WgEromxKt/A5/rm4WIG5l770dM7Pt0jJTY/dcu0ue5HSbT5puD3
	 jySfjXIsu8xZYPEkJuY1GGyWRjEo4uos1n6bIgmGxEDFUwrHRaSQMh61FjCCY75U38
	 f5T9NLKtULvRw==
Message-ID: <sashiko-outbox-194235@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH perf-tools-next v13 08/10] perf test: Add test for
 ftrace inline and task stack tracking
Reply-To: sashiko-reviews@lists.linux.dev
To: "Aaron Tomlin" <atomlin@atomlin.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261102214054.911298-9-atomlin@atomlin.com>
References: <20261102214054.911298-1-atomlin@atomlin.com>
 <20261102214054.911298-9-atomlin@atomlin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 02 Nov 2026 21:50:45 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> Add an automated unit test suite ("Ftrace inline processing") in
> tools/perf/tests/ftrace.c to validate the function graph call stack
> tracking and inlined function reconstruction implementation.
>=20
> The test suite verifies:
>=20
>     1.  DWARF inline symbol resolution
>=20
>         Uses vmlinux_path__find() to locate the kernel image, setting up
>         symbol resolution and validating activate_task inlining within
>         wake_up_new_task at offset 0x1d1.
>=20
>     2.  Inline presentation and return address filtering
>=20
>         Verifies that synthesised inlined entries and exits are
> [ ... ]
>         FTRACE_MAX_STACK capacity.
>=20
> Tested-by: Ian Rogers <irogers@google.com>
> Reviewed-by: Ian Rogers <irogers@google.com>
> Signed-off-by: Aaron Tomlin <atomlin@atomlin.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261102214054.9112=
98-1-atomlin@atomlin.com?part=3D8

