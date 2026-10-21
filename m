Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792550711;
	b=AAdo8oCo/SEq5WZdWYqDR/rIIF8VNWvL1Reig9JcgUMc+p8eZ0S3O7B12UwGbX+naTg8
	 RF7Owejfs/WGeDfv513F5ybXvR5J9aQaMVUbNXMJHon3i12WTLGeUNNaIyWd1hh4qPs06
	 0XZfd+siNey8FryqAF/YP0iTACNscgbHuThvebBpj65ApvJkUL97wegc/3WvxSvT2cbrp
	 bx1JchK87pNynArTvm7zfW2q0Z18m6wQcOo6hAk+DqWqXfsQnZUOeV5DKyCKitO44uG/9
	 rpKxx4B4zhAygn4MbaT6aVizvfyAF3lTREOOO5s7qYUqtMu883n8B1X802rYLDSAnKA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792550711;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=oaxS839DebQ9CBCDs1H/GkkeAsRXKPG/YwlP0i7KlIk=;
	b=fQXzSDvu0iKH/SSySUHtVZYHlb9D0Rbhe9msKGfzrKIcqDUvO1hEB3hzvtT0NSt77fvQ
	 aOmLqjeTcpTPoW5qJBT+qNF+mHN9HtKO/RaFR4DLzhfl1efzobU05iJ+3MV3vnDtoeA2P
	 dfOEnuc6QEhbjEInlEOlx5SnjMKiwt9i7I/42nW6cn8Iw5kUduJ4jZPzwFFBUIaj1HoWD
	 N1RdyQFTHbWPVA7D0oWYjDViAcFOqzk9qxc3sRTyimBbf7QDZOnxIt/sRMMnFNKXBOYev
	 IuYVruKGKY8dxDwdI35cnOtt/OTuQh7wcc84i3R0UT9bC+fKTjpaewAY8SJfutKioig==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Rd6eRIGz;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4D76606A31E
	for <linux-perf-users@vger.kernel.org>; Wed, 21 Oct 2026 02:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Rd6eRIGz
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 375BF1F000C9;
	Wed, 21 Oct 2026 02:45:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792550710;
	bh=oaxS839DebQ9CBCDs1H/GkkeAsRXKPG/YwlP0i7KlIk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Rd6eRIGzDVyqI5nV9thMHRzUcc6fWt38Oz+9SytB/WKQAw6gNTvUak/0ccJr9QbfL
	 DQ4px4+it2xB2MzehhgqWb0GUvgDDUs2llOfyftC+BoFrFtBmc53CpJj0tBM3VEE+R
	 zGpNlV7s1UVgKUds/KZQK1uPdiBNjruEnclVhJAEz7RhGmYkHCbjic3kDDma0Xw3uQ
	 KBhJs7voii86IpAad/xvecy9BEGE1KBN1ybZKMLEXNKS7RYNwyGldNO0Z3Hxuq24rm
	 oMmgOEp4nEhqNZLnYNPNaKB5APiZvpToQBdLlG4R5iMaXGG7WhKW9RiDRNpSqRrho6
	 4WDazRQFMdbfg==
Message-ID: <sashiko-outbox-179713@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH perf-tools-next v9 3/6] perf symbol: Introduce
 vmlinux_path__find() helper
Reply-To: sashiko-reviews@lists.linux.dev
To: "Aaron Tomlin" <atomlin@atomlin.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261021023337.809936-4-atomlin@atomlin.com>
References: <20261021023337.809936-1-atomlin@atomlin.com>
 <20261021023337.809936-4-atomlin@atomlin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 21 Oct 2026 02:45:09 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> The vmlinux_path array maintains standard paths used by perf to locate
> the kernel image (e.g. "vmlinux", "/boot/vmlinux",
> "/lib/modules/%s/build/vmlinux", "/usr/lib/debug/..."). While
> vmlinux_path__init() populates these candidates and dso__load_vmlinux_pat=
h()
> loads symbols into a DSO/map, callers (such as test suites or probing too=
ls)
> often need to verify the existence of an accessible vmlinux on disk before
> attempting machine setup or test execution.
>=20
> Introduce vmlinux_path__find() to search through the configured vmlinux_p=
ath
> entries (or symbol_conf.vmlinux_name if explicitly set) and return the
> path to the first readable vmlinux file, or NULL if none is accessible.
>=20
> Signed-off-by: Aaron Tomlin <atomlin@atomlin.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261021023337.8099=
36-1-atomlin@atomlin.com?part=3D3

