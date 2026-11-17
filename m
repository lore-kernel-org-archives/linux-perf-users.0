Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794884801;
	b=zr464+FGJ/T4aJS3+eR+sa8EQriC1gNL/DY2H0DpX55ySK+jPQSBkA0ep9YpQ2Tb93Mv
	 +eobhqjg1m+o8jHMITbzAvn5XSV3VgKAFOA9Cz2WJyDK38aX/WTY3IrfYR5wglZnAnQkI
	 /HCDRhI9t08M9Nwnyi+Vh71Fw92vimMUpZY6UY9PDxADSOzwKqXwGZ5w/E2QmLdyl3CFc
	 wH6Z1Y39BX/9HSnTBcV+4zSpjw3FMOvXTioHG0CTjoRkqfsRVTysVH7DMuI8PyOB70g02
	 CNYmiFdf02rCUf7lBFUTVSIXdm7yAAoAjWpnEV15//oUgWPF23jtqbVIu7RN9/JOp7w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794884801;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=uUsH4uKQrrJcaPDXH2kQs7wxdB//yLPgxnEIdbNyglA=;
	b=QfIFEHxuR0EWkNvHHYZfFXap7a/8q6prZlFpE2i+qEAI3BRXhc9H2Vm7PMfryw7ROZwZ
	 zXcDX69NwlEU9OotkULHPhVAJy2+Kqita/Gya2KkJ05K160cTt4W+XgMlTgxRUh+VeXWq
	 gZvtDgmmb/dnbKkOS51NeNRpni6r31j+9PAoon0DEvF5fT8L74fQ1gcYO+Ny4DD4Q0sAv
	 kDqaUQ2Mzn1iJ9qihYX8g/51EcibwCYN9QuE/+79Rt42+fghpfAdMwlC6F9XZyBbpYwXi
	 zVjz2ZHtE6rufEaqJOadAB2tkeDGyFHQHyFboztcLBI8tPmjHZ6CzN8aVUBtNORPgBA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XomV8FkO;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C38B4606A31C
	for <linux-perf-users@vger.kernel.org>; Tue, 17 Nov 2026 03:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XomV8FkO
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75AC01F000C4;
	Tue, 17 Nov 2026 03:06:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794884801;
	bh=uUsH4uKQrrJcaPDXH2kQs7wxdB//yLPgxnEIdbNyglA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=XomV8FkOlyiMBYYKG99mJJTTxnpqGcy0sxQhBQvWgq6Nep0PeKc44z7pRUMmpKysq
	 CjiEzw3i/1Yt3Zf4GFoboy1DVP4xl1QrtVMHdknfiJs9nrpbJqxh2AA69mB0pNDg+N
	 PkbLWAto5oaD40NizYvC4ZVPgxk5SDPR5aWRd4rPFchG8gYXqXQ1/3IyyLeGidhuXd
	 TMP0QgYDXAx9oPOMHuvKjbNWJGUP+VrG1ymZrYqESI82xOQv400Vdv4cP+qA8OTb8w
	 1M3a5WS4Wq201qA0yEp12bBREihaVMyDuH0eP5Yl6fRTWliTEwHaCcOxHj7hGENS/V
	 2LSU6cpaEJjAg==
Message-ID: <sashiko-outbox-218123@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 03/12] perf tests: Exercise DW_OP_addrx global
 variables
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261117025305.3958882-4-acme@kernel.org>
References: <20261117025305.3958882-1-acme@kernel.org>
 <20261117025305.3958882-4-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 17 Nov 2026 03:06:41 +0000
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
> clang emits DW_AT_location with DW_OP_addrx for globals in DWARF 5, gcc
> emits DW_OP_addr.  The global_data workload keeps a zero initialized
> struct in .bss and the test checks that its accesses are annotated, so
> the DW_OP_addrx path is exercised when perf is built with clang and
> DWARF 5, and the DW_OP_addr one with gcc.  It skips on 32-bit PIE
> builds, which load globals through the GOT and the resolver does not
> follow those.
>=20
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261117025305.3958=
882-1-acme@kernel.org?part=3D3

