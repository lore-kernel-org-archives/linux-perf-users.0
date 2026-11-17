Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794946439;
	b=Fwnkyhc8r/YBz8OSH+zK/q9yb2Ct5WwwvG4ZcfEHKyGxHuknVBpYS8zd4UaeBdf6lMWR
	 jiQtrsvBD+nFgN11u5UqYx/CZyKBkbBdJilsQ6m78y0C7Ji3VyWe8MAMNLnI4vxWAx2w8
	 VbLavXZyLhSXJ4lvhIFL785YYXShde05RHB1bUlVaOh3z9MBKva43XCkMWEdKSAdv31AJ
	 XyQ326jl3MvATjd3HDY/Tpz72C54VatjETbEVOWKF9ZJogS7WAwD5Sq7V8P9S8G/qD/x5
	 lI+KiPYBqwcU2lcseUydyQj2PM84u+hj3QyFO5qnHvbUGwsz9nZ/d36VTViKQ/Gtz4g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794946439;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=bSNKloEkKaZIWjxUBIDe47VmFDAOb3xA+OTn0+rnoU0=;
	b=u6Dylnc285RzcLhD/rV0YqhsF2seGlBmsWWR65YVXcjytcH/QwujCprDeBJ/7LBJw/C+
	 7F6sMpI1PDBAmQMsYC772cf7jkGVkjCrC7KXoOUXCvNEzF15rbbIz5WKKGc78xF55mmHm
	 WcIiGLNLZPj6/qb/JLx0aLADAX48xQr28hoiP7HVnJ2zeen8shcXGI8WMqbWYiEQ+rRHE
	 30Xn72IkmduBX8mGAzfbABgQh8lENBB8/2eaUdpIFMAj+drBzbW2VD/bjUKT9RbpaOsOg
	 /9KIVb4ui64U33VwKBZqYlN5dCWOw6dH8GrLfCMrrLa2n3AktHQgnkmLQwybK3U8BsA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VXdlnNRK;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0F25606A31C
	for <linux-perf-users@vger.kernel.org>; Tue, 17 Nov 2026 20:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VXdlnNRK
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7603A1F000C4;
	Tue, 17 Nov 2026 20:13:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794946439;
	bh=bSNKloEkKaZIWjxUBIDe47VmFDAOb3xA+OTn0+rnoU0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=VXdlnNRKgZeAFmo29GTWuFRLmUFfmCjGzN6BuRJm/eeVMgOseddGALBBRptkis4F7
	 14yd7E7XHpSONlIaH0FG051ZdpKbJ8tfZYjyqUxBlRAkxIEBYhSvTqdYP9ENYeyoqA
	 HrkEhqyqdrESvpgDnmepadGdSj0FQAjfQR6oG7vDdBKtXPvyPi0SDlPXC2Wzfiawrr
	 Wf6jVawWxuy6+9tex9A+QCqjk8nm02WqdNSa9MZgIV7zD8Bc66WF7X4zBcCAXRgCOV
	 3P8JtQt6BDu2cr1myHhDKBhJWIdZJQTOn/2RuaNWY7sUUEOlBJTjD8PAznIgYdA31S
	 ctfDt1h1fylfw==
Message-ID: <sashiko-outbox-219580@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 04/13] perf tests: Exercise DW_OP_addrx global
 variables
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261117200433.45174-5-acme@kernel.org>
References: <20261117200433.45174-1-acme@kernel.org>
 <20261117200433.45174-5-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 17 Nov 2026 20:13:59 +0000
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
> DWARF 5 (e.g. coverage.sh --dwarf-version 5), and the DW_OP_addr one
> with gcc.  It skips on 32-bit PIE builds, which reach static globals
> relative to the GOT base register, and the resolver does not track that.
>=20
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261117200433.4517=
4-1-acme@kernel.org?part=3D4

