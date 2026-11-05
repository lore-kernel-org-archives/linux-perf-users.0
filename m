Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793883506;
	b=GWYqpRUbg8CCgSbHc3qtvlWJfbdTPudVY0x86QPyaN9M5O5F87aLXsbITYwQdKVPHClN
	 E0LDRHsIb2jCCToJx3f5GhynAU3IOwVea6o99QaD25DnLODQtEzzKuuh2m4+GB5Cc+SKk
	 1IQTCy7vtBDs6oTKe/ETAlJzMaoaXmfGMc8sjZlD37e5N4pTMRt/IehpYVy/ivRr7xSkq
	 MWoI4eRD1WI7LLNiidBfsl5sjXIHosGbDTOBkrhQ3b24T2cODTlSBbjH7nnwhgraTF9X8
	 ud3zPwGyFs3Hu0l4alxhslKokbkbPDnrvqSRXrIYjyZC0YEHpepWsZLpsbLiNY8V3eA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793883506;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=U4dYQSlS1sDmCaUqDrao+I0dEaytN2g71sCmPG7Arbk=;
	b=VlbKcl/pgpkL3FLE7UA/DRwCdl8dmJl0uc341ZYPk1iRVsa3dan0sQ0ZXY2GIXdRAY0J
	 SPzPpxQ+ttzXoTg5y28IcJxNGwHYz4lH3U5mz3bUT6znELGnntEmKfYboNRIB7VzvSY9W
	 8+52GWDrRaI5O6ISuCT1UpQgEBRp91dBVzcwl+nw1wsaifagURQZbBeZ3VYL1m+eTGuLL
	 9X8BUUs7toW9N/OgXZbJA0cdLv6uqdKZws9acV3G9zWyr4DT2hgvBqz7t2rE2qwhLaJVm
	 h8wFBjvKIdG5lAsH9o2MAD2IZbgA/zoveVUh5fm1Cc5PE+58Z8m70VQ9mve3YYUakAg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EmudPCBF;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61433606A329
	for <linux-perf-users@vger.kernel.org>; Thu,  5 Nov 2026 12:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EmudPCBF
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 213B21F000C1;
	Thu,  5 Nov 2026 12:58:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793883506;
	bh=U4dYQSlS1sDmCaUqDrao+I0dEaytN2g71sCmPG7Arbk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=EmudPCBF1MxBEEwjHZFOjPSC+pWk4uCb6WhYgT0wShNOxZ6d3eHS1qXgG0JxhbYEd
	 5ACVoaCI9JuqlkiTuhcHJZT4pJCSvf61pZ8M6QqlvJIaq2iNkwkmeHLvhl4GcZwNu1
	 HNXvgZnYYxffGPsE1b0fHCJOunCV3iOn3JxSipYX6/SmWv7TW51n7HBPqV32FOZR9K
	 df4qg/5v99zyWY0+ep+StOzV0xuvyRAScivZLt8+nWzu3v/l4xZ79q4PViOnufW3EL
	 GCgDmuLPV5w7Ehlid6nbG9+lI+x9xJRkHYHCBPrHz9+31YScr9d7EmpWLz/s6l9ASn
	 93K8fW7Ib3NRw==
Message-ID: <sashiko-outbox-199089@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 08/19] perf cs-etm: Use instruction length in
 disassembly script
Reply-To: sashiko-reviews@lists.linux.dev
To: "James Clark" <james.clark@linaro.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261105-james-cs-unformatted-per-thread-fix-v4-8-7759e0ce2449@linaro.org>
References: <20261105-james-cs-unformatted-per-thread-fix-v4-0-7759e0ce2449@linaro.org>
 <20261105-james-cs-unformatted-per-thread-fix-v4-8-7759e0ce2449@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 05 Nov 2026 12:58:25 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> The disassembly script adds four bytes to each branch sample's IP to
> include the final instruction in the range. For an exception sample
> whose IP identifies a faulting or interrupted instruction, this
> incorrectly includes an instruction that did not execute.
>=20
> Use the decoder-supplied insn_len to calculate the exclusive end
> address. This preserves zero-length exception entries, includes executed
> syscall instructions and also uses the decoded size for Thumb
> instructions.
>=20
> Reviewed-by: Leo Yan <leo.yan@arm.com>
> Tested-by: Leo Yan <leo.yan@arm.com>
> Signed-off-by: James Clark <james.clark@linaro.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261105-james-cs-u=
nformatted-per-thread-fix-v4-0-7759e0ce2449@linaro.org?part=3D8

