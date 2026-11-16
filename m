Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794838874;
	b=1mMED7/f0kkdMo1N/0oryQwvqKlV47abnvNcuFln7NAo3e6hakBjsvB90Ik6jz8b+l7I
	 C3olI7Fx1GMVXFnhUFAx4V5MD1IrOxcZgFUualLmXRp+pV9z8Sk59z6PV4BojenG7iXwB
	 Z6Ot3qdsXlZQWtLqI5GhbHvL7OuGpGrU/FzFS1c/luIYyAbCCMlOWLMD9+qGAOORNJgVg
	 jiQlEA6K6t4P1pFlVvu7PVADk3OJXDXicJE/V8I0cXoBN5aLyjNinrqzVwx1PcwGX/90w
	 eAqQta3QSUxXWx1m9gjFtuy39nx+g3s/Wz9EmH7ieJ30L1s05aptChYxL5qAvqy/bQw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794838874;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=aB/varX5gb3aGFwceFyDS7BOAxB2dDV1zfNgj8GlA3g=;
	b=PUgmlTpjplNyXqyrT2TGEvmBwwxBRGiPg2QknUIrb6uzyYb0pHFbDRJODWeVIcNO2NET
	 F3RsbhP7wlurp3pMuMAShyBd/Ceuhf2JbF8mWuwtMa/75n6JfI78/i0FCiIHG1hy+jVXw
	 GWRwSKAccSs69rriyLHjWeaHPzPziaknwS9e2JJ8zEbbX3YK1G6uxgL5g3j7tdR44Gvnl
	 dtr7fYKy4zX58IGD6S53D+Tom9V0kAhGaT2o+fpS6HqbXcDREwW3NiCc7H8WmLqTxlw7O
	 RTn50vHJACxTxIeli7G8QxBQ02ceVLQ8eTA26TwVS9Mplrv3l2gvkHvaZ2L8fchB5Ww==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FpEfLchB;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3857606A32F
	for <linux-perf-users@vger.kernel.org>; Mon, 16 Nov 2026 14:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FpEfLchB
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2766A1F000C5;
	Mon, 16 Nov 2026 14:21:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794838874;
	bh=aB/varX5gb3aGFwceFyDS7BOAxB2dDV1zfNgj8GlA3g=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=FpEfLchBBqeTEPamuqnSTqjYrj3pUFmtulDBGKyOF/yyT0CBn1qm8bHcwqMZQy1/Z
	 OvIonWvh6FUBXosO2XEXDmI865dtrkE0BDC3ZAjtRI1D2XelTaJU2ZIi2mc6t3yPpi
	 tVoj21tyv7rsXLGqTJiz0JzyJGpqZvNqn7nBqxzXoMv5sYCy64sAA61d/RmGU4iLvP
	 VpOpgErCljtyxDpIFGya/BQnCBOp4StEbkgc/9TrkJCnca/cRSQeyn8FX2qHPUsgFs
	 gGoDhzyG5T3EgQlzAs5qzrhssuKVEgIgOZ4SRZAeFqH1wbnbsLtjV/a0QUA7esjAzT
	 UtYkRcPQu7Vmg==
Message-ID: <sashiko-outbox-217155@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3] perf docs: Correct JIT_CODE_UNWINDING_INFO
 specification
Reply-To: sashiko-reviews@lists.linux.dev
To: "Letian Jiang" <letian.jiang@outlook.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <CYXPR84MB34769BAF18918C609FCD3327827C2@CYXPR84MB3476.NAMPRD84.PROD.OUTLOOK.COM>
References: <CYXPR84MB347640EF284BED04EADB0B4A826C2@CYXPR84MB3476.NAMPRD84.PROD.OUTLOOK.COM>
 <CYXPR84MB34769BAF18918C609FCD3327827C2@CYXPR84MB3476.NAMPRD84.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 16 Nov 2026 14:21:13 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> The JIT_CODE_UNWINDING_INFO description places the EH Frame Header before
> the EH Frame. However, jit_add_eh_frame_info() uses the beginning of the
> unwinding data for .eh_frame and the trailing eh_frame_hdr_size bytes for
> .eh_frame_hdr.
>=20
> Correct the unwinding_data description and the eh_frame_hdr_size field
> description to match the layout consumed by perf. Clarify that
> unwind_data_size includes both sections. perf subtracts
> eh_frame_hdr_size from unwind_data_size to obtain the .eh_frame size.
>=20
> Also document that an unwinding record precedes and applies to the next
> JIT_CODE_LOAD record. perf caches the unwinding data and uses it when
> processing that load record.
>=20
> Revise the mapped_size note to describe frame-pointer-based unwinding as
> a possibility depending on the backend and valid frame pointers in the
> generated code.
>=20
> The libunwind-specific use case still matters: its EH Frame Header fields
> through fde_count are read directly from the ELF file, while lookup-table
> and EH Frame accesses require a mapping covering those addresses. An
> empty lookup table can trigger frame-pointer-based unwinding fallback
> without mapping the unwinding data. This does not impose the same access
> requirements on other unwinding backends.
>=20
> Signed-off-by: Letian Jiang <letian.jiang@outlook.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/CYXPR84MB34769BAF18=
918C609FCD3327827C2@CYXPR84MB3476.NAMPRD84.PROD.OUTLOOK.COM?part=3D1

