Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793826514;
	b=qx0Rz7C9BtGaoZga4fJfQCcSiSxMIJIQRCyEtSh3ajbVX8p6flWyjPaWg3+WtfFfiiq6
	 2aThnKkF//aVuZ4R+DwG2fy01wlT1+Pz2yzwT628gonaVNMRHusDTZc1sdTv8B9OIk5J9
	 9V+r+TxA5JlyB1at2Nsh2EuPnhkPmLNxmxHFUhraQwv9OHV0qoyB7cDSgCFJ3006/c38r
	 bBrXZnI0dpBa62NVMIFJM2wtmLqRBB73JtXCLee98+SCp+fUyNQHBYDs6WYcUAU/3Ev6+
	 IUuszwXexFdDvfPI7LX86rU6GqfQWCnz3BzT7816GbZljtkULtn720Ao2X1RebDo8BQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793826514;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=+M/HPbqBch+O8u3a7C/Vi57BwuCTBIwI/id5oldq+64=;
	b=O/UdYHkyOgkd/0uXK21zA9f5dcJ5bG3qNJ4CQifBPrQfjqJWWctalnTcth42S7et0pFw
	 ocCvxOljT5BFIUhGFf/zkCemtZa/YZHYaV4+SlTGe+YEYm1yeJWGhlJIcZyJNmJ2tBuHa
	 1nKaViFF/zcnQWN08K2kWFtNG0grxPgM3X/o8xcr+4EwKzl6dkHtw8J+7PQZLtQQjZdNW
	 fLFyRVqr5yxb5fA+WO0de1CkS3KhLnd/bw/Slar/gRNHWonwqdSAgyqrnBcxRxejoctei
	 gihp55BKpIIjJyrL4CvCNGGmLkZl4olbiZtk0T9JTF+soYnTWz3wlsI+eTIr6eFY6PQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CoCap6jr;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 433BA606A32F
	for <linux-perf-users@vger.kernel.org>; Wed,  4 Nov 2026 21:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CoCap6jr
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A93C21F000C1;
	Wed,  4 Nov 2026 21:08:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793826513;
	bh=+M/HPbqBch+O8u3a7C/Vi57BwuCTBIwI/id5oldq+64=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=CoCap6jrAH4crcxKnebHcs5gWXY1vG8qXloVfphcXpSYFU8lvq+l6/B846L1dwT5r
	 Bvnm7xwW9z6aLonG6MWq/TraYJ44vDmgZPr9EsgWfRmSzDzJnJ37mhNnGufxvfXYyo
	 ig4t7rvWKx8+8X9fcfN4qeTE0YyU9uuI13mwr7QPWQqzVv7C+f1femy8uhJu3inxod
	 Ff41/j3ynQP258v72QSFwvMaHVsjxTaFccoQv/9vKsacAGFTJlwR6atooS9JSct7wf
	 DWmiVVB0B0SZVZxoV53uyuqtc9hvPNEq7Ej1eMEDsjKlReYYgSOb9SXdmT4TBjU2Pb
	 evK+OPMgg7Qgw==
Message-ID: <sashiko-outbox-198048@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 02/19] tools headers compiler: Synchronize
 compiler_types.h with the kernel sources
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261104205909.2078411-3-irogers@google.com>
References: <20261104205909.2078411-1-irogers@google.com>
 <20261104205909.2078411-3-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 04 Nov 2026 21:08:32 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> Synchronize the non-__KERNEL__ sections of
> tools/include/linux/compiler_types.h and
> tools/include/linux/compiler-gcc.h with the kernel sources (including
> ___PASTE/__PASTE, BTF_TYPE_TAG, object-size helpers, asm_goto_output,
> ASM_INPUT_*, asm_inline, __typeof_unqual__/__unqual_scalar_typeof,
> __signed_scalar_typeof, __native_word, compiletime_assert, and the
> __diag pragma helpers required by compiler-context-analysis.h), and
> remove the duplicated definitions from tools/include/linux/compiler.h.
>=20
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261104205909.2078=
411-1-irogers@google.com?part=3D2

