Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794885456;
	b=uOzXk7qjWIcFZrac+IGf35F/mZgLclileKUe5GQBnARqt06zo2mgYzUpI9HGpcCd3xba
	 KZyTS51doeBQ3DJx/xVi3bg1BiTMOY5CeFDgsqFbW6jWnO1tgH39u5wD8q7P1CzlskU6L
	 Tvv6OxMtL5VtTJJnw7TPYA0lo+aombAcE+7Z3g8CJBBAzZXDdJ1c4yJujqJ+4NLg6QZXL
	 8tcJ7kiX4c+twUNpUv0DpXaMlL5uYhAJbjBcyLduu1E5h4QhGAmq7PspMCBIv2v+ffkI5
	 ng150Jrg+oGUedQ7SyEQtGMf8VF7PZCSMVHxVtQAj+/oTKaRAU6i92Zf850cEOQOHFw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794885456;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=W7ntX4cE4NU3EkU1/KHog28eTfWwB3lGBQtCRLi64zc=;
	b=gsnt0YV6ZfVezmaI3QkAGKasXBXupUAzA/xRCsQWkhvEAy3tqjrwsyNcWxQMC4XkAQMm
	 ZwEG2ozTnopHDmaMV+FbAwM3G13Jv2OslGLQjfFZ6W17cXu/MH959PkoSFssGbF+nOAdG
	 6RqFl27AZhFJY3aZG516xaCRDgXdyhg6gqVkgSJ9Rz3qOWjJc9qp/BH2CD40k8z2JsNhk
	 RUOMQgnFQlzbqC32wEy35vhBySEUCuaE1NPboNIjQE22ni6JukH0SsA3HRnIPDfsoftLO
	 LLvLZPYlzSrpm0jbUcf3Tw/Z+mghMmiiZvREitRkUI3gyr3QI8bKbKNd5jtBQCSnNoA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mx8skrgi;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04157606A31C
	for <linux-perf-users@vger.kernel.org>; Tue, 17 Nov 2026 03:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mx8skrgi
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 626631F000C4;
	Tue, 17 Nov 2026 03:17:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794885455;
	bh=W7ntX4cE4NU3EkU1/KHog28eTfWwB3lGBQtCRLi64zc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mx8skrgiR4mneUTriuH7bhh6pHC6rejn49moOZGYph+IrTBNPnUot1akLNA3GVGT/
	 TNF9q4VZDMUhwJoOFPF4j8MaBvXUilu4l2gSjcsuvZ+IFH+E8KLmIuO1FjQ9ZFH1P/
	 /6k0Kvtj32qZ9d9c5QHCuDNfIZlAyxbC43E712ERDa51pMC9Rq1fnziHRFiIbE9VaF
	 T/MZXQQR0IvHN8hhIG5Wv5tNE//3Xs8WGgVwRG2/RADSpvrX/4pnZbLkztFShlEHTD
	 Ht3QizjhESwzpC1RJFcAG6GKRsLWrdGC1W1zH7y7zbCsKRwIh/OtIxeUWw15tJPibl
	 WvKU/c7aBo7xg==
Message-ID: <sashiko-outbox-218133@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 02/12] perf annotate: Handle absolute addressing in
 data type profiling
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261117025305.3958882-3-acme@kernel.org>
References: <20261117025305.3958882-1-acme@kernel.org>
 <20261117025305.3958882-3-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 17 Nov 2026 03:17:33 +0000
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
> 32-bit x86 accesses globals with absolute addresses, like
> "movl %eax,0x8c73448", but the operand parser only recognized the
> offset(reg) forms, so the operand had no memory reference, the resolver
> saw a zero data address and resolved nothing.
>=20
> Parse a bare number as an absolute memory operand, leaving jumps and
> calls out, use the address in the resolver, and let the instruction
> tracking record the type of an absolute global load in the destination
> register.  The displacement is sign extended for 64-bit objects, as the
> CPU does, and zero extended for 32-bit ones; a zero address is skipped
> by both users, since it is what an unrelocated operand looks like.
>=20
> With bare numbers being memory operands, a frame base register of -1,
> "none", would also compare equal to the -1 "no register" of an absolute
> operand and take it for a stack access, so guard those comparisons.
>=20
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261117025305.3958=
882-1-acme@kernel.org?part=3D2

