Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794941583;
	b=AAcSO01zTokrCC1qnsB4PlVLiq6kX+nTwdxLxGNnv09AzEFaRwSSFemJeX9edgBeiJkO
	 49Q5u3Eqf+5AvX+iWyZfcUTizzlfWTPMos+pKne8+T2UdMYLO779kq5lS94j1OAlN8Pz4
	 7k53VMpujZKaEfxXCFPk9+kmRJmO4H3O8daddQmSZ7qp3byReVQ2HJTq44GEP2xsF8aZs
	 wbniEfWYlfW9tILixpCGrs044N4CgWandm/OQ5JA57ffPgFfD2xn6VMCnfQaSF1kho2I2
	 WSxDqbU16KCU6CcnDRQKh5gWiRUi+GRgoy+HXIRqYv8XoeY0oiV+ybjrkZpzUgF6PjA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794941583;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=VtvVbzzpkV6q6FNNnbZM//B/8zkkW8F14PMMfMhFSoM=;
	b=3mHMS4gSOHLy452M5kh06GgWgp6/6bq5u4EYHSwFy7kWPa0FNOeFBn1lTFxXFMFMCg0i
	 6a98FfhekywzhzHd+FwR5DywIId1nyFfl4cKmtCf1i6GA6PwTh3+pDUU8rFFTl2pBXSVZ
	 02Jc8qSfMyMUmKWw2WeHtTAwiFTHr9L99uFCr2S69vqMbEnUHGdkRztYc8XeuyiOOeuOH
	 OYofD/mFiMkc9g+//90NWZAH8ALV6TB/SHI+u3AdkXWhzujgK+I0nfhE9imbqQdbJsG89
	 FNEWVsPngeb/S0wqWSZ5v+9oV0MIPQ7kBGeHZIuPjXP0CUy0mEP2TW5fzo9t3ajCSQQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=INFdzTxq;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE588606A31C
	for <linux-perf-users@vger.kernel.org>; Tue, 17 Nov 2026 18:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=INFdzTxq
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BED21F000C4;
	Tue, 17 Nov 2026 18:53:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794941583;
	bh=VtvVbzzpkV6q6FNNnbZM//B/8zkkW8F14PMMfMhFSoM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=INFdzTxqwqubBSA8WUr+UinMJcwA/3TLQ2U+1Yj50aCYDj0ylVmo3mA9BMN8NFbdU
	 IG1xbiV0ToASj66Ab/KEq9UXuN1RO+dagGu+jFlLYPRVYn1apdTEQw4Z1vB1kG7r6p
	 0PkSIBaGY9pVvRDoggqeqsHY7suhrutSh2+HwXYlq4Cj9LAWwI8J5p62HGAgtGcTLJ
	 szkz0NEEzVseleqSAViaWM4iU/lkmc2t/PGF3F/MAVstvIBssIGoRmjYKAm+cypP20
	 HHjMeX/yu39alm9tdq3ov/xs1IfV8a+CjrevACIi6bg54iAUHhD9+ipkC8rPhElkqP
	 EA6jpLseTxTdQ==
Message-ID: <sashiko-outbox-219401@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v14 01/23] compiler-context-analysis: Avoid unused
 parameter warning in _context_unsafe_alias()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261117184844.99889-2-irogers@google.com>
References: <20261117184844.99889-1-irogers@google.com>
 <20261117184844.99889-2-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 17 Nov 2026 18:53:03 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> _context_unsafe_alias() does not use its parameter 'p', which triggers
> -Wunused-parameter when building code that enables -Wextra (such as
> tools/perf, tools/lib/perf, tools/lib/subcmd, and tools/lib/symbol).
> Explicitly cast 'p' to void to silence the warning, matching
> __assume_ctx_lock() and __assume_shared_ctx_lock().
>=20
> Reviewed-by: Marco Elver <elver@google.com>
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261117184844.9988=
9-1-irogers@google.com?part=3D1

