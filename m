Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794263060;
	b=OTybZXr4i3/eqbdeUB7MlQkASWkCByqQ0XPs2Hh7TTrNjymkDE5whOfwsHhbSX2x7lYd
	 8F1tqM5STE92RoXwGY6LBe5r5WxsrCJwuV/3BQc+We/iVCNJbxj5slLVVwRbXpuKnkbt9
	 vysFZWuoVjkYTmMDKMrenRMUHrBf3bYcP6w1CLIL1k415Hj2UWCAi395zJ3PaT/KU53pH
	 +oaCHelPmx9T9eGNZqKlund0an4wLakPn+sNOpMNhIvJv/r/CTnpBdQ8+DzWUaLmQQ6qc
	 c3/iTrIHXtYurAElDMI1RyRPWbcvc3yJjFSp1sst+txNEeh/AUbpCviPM22wsBtFEbw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794263060;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=gCdeqNQD1zb5jCRf70+U/j0RdUbs0AWd3dQ1TACI2kU=;
	b=aYKodqfSmpqoMB1P2Y0awdTTFVDt66rHSxPv/bANrAhGSgof2O0YLyeDO9Mr6+ggY6tQ
	 zkj6oTBtBfdb3Ilil1FIhKdXMVVahaveluTw24jQVnkMT+pItkntpJP855xPJPvIm8HRI
	 7QM74u5NUvuf78IdL6mObu6U2QCyrZje/W5cJhNNxlBnFT+VX55Mu/Ofepk2yTnuBEppN
	 jFX7zzhuyKr0oVGELuf+R/NYXF1odJ+tRgx11vXnY90D+oBzpiOj6R1+sXxOkzsjh7kTn
	 QqfWDBKjjwkI2Z3jqO+O2dgXGvxNAckbnpfxYZaUr24MCbLDbOo4/vBZ88rKVsO9Lhw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eeCjGy86;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29D4E606A325
	for <linux-perf-users@vger.kernel.org>; Mon,  9 Nov 2026 22:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eeCjGy86
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD5251F0089F;
	Mon,  9 Nov 2026 22:24:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794263060;
	bh=gCdeqNQD1zb5jCRf70+U/j0RdUbs0AWd3dQ1TACI2kU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=eeCjGy86qxiVZed9sOIx+VWcWUT0ceO+ThKo5cNkBz7X+63tDJfWxLhFakilpRhpu
	 gaGqTlyZQJFhzVHm30xgtdK2wvzV4vmB+DqEorvPHhWoQ2RLZujdxefygYxotISFTq
	 r2NgHO7c3Y0iVRPqP9amNRJrVKC9oyByvBQDojuklg4qG8DhB4IDpjWORWb7DZLTf2
	 xWDXuBFWyAbcl+F0FzyWOEqcYGveZizFb29thNxKRfKE8WnGS4QCCyRRqGxa5nRRAq
	 95ioK5ZHs52lr00qRCh2lekUZtmPYvCeO3zPt6xpztRxUxQXqhNlpG3+4MjT9nPZYR
	 HOQbXxMcdSwRQ==
Message-ID: <sashiko-outbox-205720@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v11 20/20] perf maps: Add context analysis annotations
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261107044102.1506626-21-irogers@google.com>
References: <20261107044102.1506626-1-irogers@google.com>
 <20261107044102.1506626-21-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 09 Nov 2026 22:24:19 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> Add __returns_ctx_lock() to maps__lock(), annotate DECLARE_RC_STRUCT(maps)
> members protected by lock with __guarded_by(&lock), and annotate
> internal maps helpers with __must_hold() and __must_hold_shared().
>=20
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261107044102.1506=
626-1-irogers@google.com?part=3D20

