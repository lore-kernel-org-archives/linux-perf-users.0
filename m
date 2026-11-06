Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793957680;
	b=novtPmyRqwBWXJxtsxbIbz91AecxJGu5jzmNM83vYPPfEufqUvzWlgJH1OGRfLnfXMGj
	 0VT397dd9RNG++qM0hKbpr2S80EFYIYXRaomBU/ow/raZTqX4m58xZhNVGuPrMvsy7eVr
	 ivPDkPBZ/IsucsNDQFQ6oyFk6hn33ZYraHianpa+4wjfkmXvprvXnTl1OLfsXVzgnZScN
	 XOliAZRtc6I/uzvCHxjvwpAAYmjMA51gTCftj+6MDiedEGjxhM7qveReKqnwMVTiulqyW
	 NSA4F3pat3tH2PgFyPK8I4tO3A96h5A7ubMs8pT3ZXna9PFyPG+bQyzo/bYLN+V6BMA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793957680;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=hxKwJFU+fIbPuAPA1uLf3ieLJNAgb5z7/qxmUZ/noVg=;
	b=jvlzIjhiOgP3j2jvT9aD73TFBtBSQkz0/0nIb95p3b/gb3XrTIBia1XbazjCGox4JsF9
	 1L1u9W6le2BqbsWWOEu57PvxUEttHI9M30sj27Ijebo6MgPa3lvGpH5Y7TtmZIRgKPbpK
	 QnNA0w2D/jt0qsyoJW7cWo2th5zj9ifiqsaGj2t5QOuIaCPIjDNHK3jIn8LbD3FOwrEtV
	 YiAuRR13EvzC/cvQFRF9B+aZPkaUk9Tc9pZxfIpqvq79Pe1V9dvOin8E5fUuhjx9MU3gi
	 eQmjt4h+Bvggh+8y/Ky6dOZ2qBugFG2SFaDepvLdCdknOsRL9HaR0o3CPE2B+q5CPfg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FpoQaXz3;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2BAD606D807
	for <linux-perf-users@vger.kernel.org>; Fri,  6 Nov 2026 09:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FpoQaXz3
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6037F1F0089F;
	Fri,  6 Nov 2026 09:34:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793957679;
	bh=hxKwJFU+fIbPuAPA1uLf3ieLJNAgb5z7/qxmUZ/noVg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=FpoQaXz3TYPGNXYS3rp3t4Xk2egXL5DDXSPRbtCKtUnnGX4HISHTNJqUXOiArl4KE
	 H2355MGu75J2+dGecmf1QcDA+3YHwUOnKQ4S/qshl9HKTpLc26gl0MGdDgViWFlle6
	 g3UilDv3YkfUJ8WhPi/Az4BfEXmeAYl5bjY4uLZMujKKfleg7f4UFImJkl5apisdOL
	 Ub8JWJqrIh3DcCb3Y37FV0Nb0VN94qrSqWlb3o7Z/kYESByoBUE3rQrA0nO6aYGx4z
	 kpGzUlKv8BbcGJrHg5Rhhcp+T8Zm54lIEziaNPVb8aQ4RzAs7MTWvCb/qXDSRL5TXV
	 mYxrHyobF093g==
Message-ID: <sashiko-outbox-201117@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 2/2] perf tests: Use TEST_ASSERT_EQUAL for all
 watchpoint tests
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tiezhu Yang" <yangtiezhu@loongson.cn>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261106092808.6914-3-yangtiezhu@loongson.cn>
References: <20261106092808.6914-1-yangtiezhu@loongson.cn>
 <20261106092808.6914-3-yangtiezhu@loongson.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 06 Nov 2026 09:34:38 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> Currently, WP_TEST_ASSERT_VAL uses TEST_ASSERT_VAL which only prints
> the failure message but drops the actual and expected counters. This
> makes debugging hard when a watchpoint test fails due to arch-specific
> hardware behavior or counter mismatches.
>=20
> Rename WP_TEST_ASSERT_VAL to WP_TEST_ASSERT_EQUAL and use the built-in
> TEST_ASSERT_EQUAL macro. This ensures that both the expected and actual
> counter values are automatically printed upon failure.
>=20
> Here is the log when executing "./perf test -v 'Read Only Watchpoint'".
>=20
> Before:
>   FAILED tests/wp.c:90 RO watchpoint
>=20
> After:
>   FAILED tests/wp.c:90 RO watchpoint (2 !=3D 1)
>=20
> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261106092808.6914=
-1-yangtiezhu@loongson.cn?part=3D2

