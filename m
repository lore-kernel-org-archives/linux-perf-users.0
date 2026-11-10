Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794348882;
	b=IhYq4TrhN8w4Qj492sm/VKhtsDZkqkAZbAEkkYQaIlhpNLpKPMZvJD+BgT/Dk+C0S87F
	 pehsXCq05r5g1lk4Ch/lRc9SlshJFBiKR6GK9ax6lh6BD9WJgXQoFaQMV5HWkeS1CUcll
	 BD7I+87gDbiPsiZomKsJ4t80lg0jwM7/m/eOzuMqOjqCUsqLVbiCKU7s52YdarQtJEFTV
	 Q+/TqbPc9Tb/PjktOx39oVCGTx/zurROXDT6RhQcY9iQg3EVvd12zvcnxbORMDjpMrHMV
	 Uk2KMFfkJetgHcz+AAm8x5hUDovkzRAJzDnEQog+yHsY+TOB+48rZVc1lvLnrmQVfGg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794348882;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=KA0ni19mNF9Jt772Tbh0v2DU+SUqqsHb3yriF890o2s=;
	b=g9m+hJFHYCrjujq85JeG856ql5Yk1FU86/p5ak7lIaHOmosbd/idFQJRlKMHY9OW2BKA
	 bD3uRy0XdZC6bqZLa1E1A2XmArZTU2TJG0qg9nNUBFS4nDJCyAhGAqmjmOSoCW9uvrpZX
	 aFVnXwTPGtconII2rRzZrsig7SBfM5k7Pr3gHwNUejXrAOMJqGOtJeXC8O2Lphx9DO234
	 U4xeUxUj2H80O827i+cxjhumLbtYT64Wrwo1m0J7sQdzqO/M9jIwxMQfNgtZoYzLm4e1S
	 oOROY/uZH57b4nk/EmZ0AboFXopVO+OT/a0XCCQOg1vw2+yRbaqFShiZ2I2JJB6BNNQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SCvOp6qh;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30CA5606A331
	for <linux-perf-users@vger.kernel.org>; Tue, 10 Nov 2026 22:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SCvOp6qh
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1CA51F0089F;
	Tue, 10 Nov 2026 22:14:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794348881;
	bh=KA0ni19mNF9Jt772Tbh0v2DU+SUqqsHb3yriF890o2s=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=SCvOp6qhV8lihxwz1Dm92GNjmjSgpGfGlIZ5UApajyRxsO+2inZEbuPP1gNz44BC0
	 de0trsmPE0vUq4bep/MYoaHcadrSKUYkGa/3ynj+OCkPt3+g3DKxSW29onl3rN3vEh
	 YOeJsLFmL22EP6rdJrPGO5ZH7imc4YIH/ICmZcVjxhlgLKCh++tmELosT+ZBcpPxnp
	 wOgkIoQU1P4X/RRlhnH11PY8rUYcorGThX4s+D1xMEFf7Hkbn8YwMSylVE6ivZ7nSe
	 wkvv6zgDm9WQNwGxSw1DYRe6J3jSwjXo8DtyKTOV9vAd7PQJ+yX54/8H3vQ33hW+wf
	 TSRVHYQBLrN/A==
Message-ID: <sashiko-outbox-207816@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 03/20] perf vdso: Constify dso parameter in
 dso__is_vdso()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261110220803.2503416-4-irogers@google.com>
References: <20261027231513.816148-1-irogers@google.com>
 <20261110220803.2503416-1-irogers@google.com>
 <20261110220803.2503416-4-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 10 Nov 2026 22:14:41 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> dso__can_shrink_symbols(const struct dso *dso) needs to query
> dso__is_vdso(dso) on a const struct dso pointer to exclude vDSO images
> from symbol shrinking.
>=20
> Change the parameter of dso__is_vdso() from 'struct dso *' to
> 'const struct dso *'.
>=20
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261110220803.2503=
416-1-irogers@google.com?part=3D3

