Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795041773;
	b=OfIxVBs1l8+MDzo2X/q9Q9d5NxNQWgc+OO6eJGtdtJnq9yggZcJ2wOJRKGfC73JHuVjA
	 zdHFn91zWDCF1U/wTE1xfT+eild7mhEDbkJHBfo6qD8jkXuwE9HFb58fE/mRrMBVE72ob
	 yF8j+pVy/R0xtRag0kn3ncxQYtZKZHczMZDcBz23UeJKAOkgHmRCOsxfb4cxfoKkFEwWX
	 BzsssX86/hnLJ3vUaWzvsRU9kzk3DXFqEUYA+E6ga14LbuC+2mdKRV+zmUAHLuSkU4NTY
	 ZFC0BMCMPStchamgssQ361jFW4sMGbl4vxNbHzHEgFjL4O5sC1Q4/zyQ9q2c2mzMoJg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795041773;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=cjlDSJZlLIk5bhSCSTYzHAcrEe8pvokPcJ/BKkj3MUc=;
	b=JHQSJv+QPF3RAeEIAbygwfc434LlfpYnyfAqDII9r0Zuz4FeNGDJgYmAWGhi9qhfFTOP
	 mSbY9f1ss7X1grPsGsSIQvW4N477ZRnNs1tjqqCUs8GabVxbBNR5lKnpHPbXaXiwN5sh0
	 jsl4eTycE4DTt62BckYpWTPs30c9cW6OcN/EfqDENHsHWZEYj0ypexWyLl+2xFgnrGrCX
	 649O7hHEEQwuea572UQomdWcSJiTwiBYnCMcM7ehTOC+sz8D/MGmZ86yWd/hLQvnG2Ont
	 J0UFj1r28GKNLDhoP9G7US9TKi9NfZ4gC31g6QoCOttcvki10XHL7X+us3LaFuozsSg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oOqskAKI;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A153A606A320
	for <linux-perf-users@vger.kernel.org>; Wed, 18 Nov 2026 22:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oOqskAKI
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FCD71F000C4;
	Wed, 18 Nov 2026 22:42:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795041773;
	bh=cjlDSJZlLIk5bhSCSTYzHAcrEe8pvokPcJ/BKkj3MUc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=oOqskAKIIrO/mJwa9fpZUi2WkAuHOZzGu1uuAx2KxH/EbSJbBLQIRlb9difLb3jvh
	 uUaHXawmvJ789eDMw6dbsqrBorYvq4Z7hSNvgOlNDxDqSz29WP47lNQFxByrzHnglV
	 BogtPec0PHWLjz1gIGWKcNhrrGTGWW5zbS9BJd+me3e6sAOo+bWGPfxuNlBAVOjn0i
	 LwHLcxPUzggWpsLG0dpyiFOrs/m+NWa8Xrpgd+ISXP2XHMx2od9G3LBlGEESLE+LEN
	 Z3ub3RGFQQ56ArrdIqoflrqxoGQWtztRukp3nzdUKBhliPYw5OHSo72cyY0UTL13RK
	 0X0FxxnglnpZA==
Message-ID: <sashiko-outbox-222113@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 07/13] perf tests: Exercise data type resolution from
 a register
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261118223725.121500-8-acme@kernel.org>
References: <20261118223725.121500-1-acme@kernel.org>
 <20261118223725.121500-8-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 18 Nov 2026 22:42:52 +0000
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
> At -O2 a struct pointer lives in a register (with DWARF describing it with
> a register location on register-argument ABIs), while the unoptimized
> workloads the data type tests profile keep their variables on the stack.
>=20
> Add a regptr workload with a noinline function that takes the pointer from
> a volatile global, so the compiler cannot constant-propagate the object
> address, and check that its three member accesses are resolved from that
> register.
>=20
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261118223725.1215=
00-1-acme@kernel.org?part=3D7

