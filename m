Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793622084;
	b=NFjqzXr1k9EmIkhZ7eHUKHpCB/EWvvKPHjOvadK4xTfgywlzoUfDG54r+XW33l1LPxTl
	 +Dr3gy5FxrNf/uhH0Ob5qOlaM1jA+9HccBXd6vq/Mry+cq+fih3rtBLC4o/WO8Qi19aGk
	 zc1i1etskJ9UlB8mLvqpILIgT4i/MWZtd6VFVIM9AD1HZ8hMYP+D1hd4epzcGFSO4A3ZZ
	 Bz7ZJgvTSZqOOmijQik8xXVb08JWICD/oRm7Z2z5Z0jPmUJTzAd3o9XljWGX+Xam/XtlG
	 USt3rq4h32whFjEbjywePMRvTjfy7Kf92a2RYDDOoecjwqpsgKWEUydWMr0OJ/1H4CQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793622084;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=NEu+YnkRBZm22VaAtT9g0ASIz4ukm9lCH8be7A00SfM=;
	b=DtM1yz8untG4Y6xokAqcUHXhRQk/lcWiK/EYUx9kzYylRf84QQELA8dkI85UxgYC3OwM
	 v8V/bSE1Q5VvBMxIMEGTfHRTbXwvTF+kmGTQm+5DJ+XTrQ2F8+1ULChQUanLaQtwYzFmO
	 w88fn/J2Mc8TC84YpoDd5+/nbicp5cnzrmgymnu296EVeIC4PdySUtyE1bSo/lvb3skBo
	 HTdQDmW2LtYI2iDPnII9jjk788kGy91yF+5vQhrQdoDghv0LS0JQABwVhqWqyiAjq8Phi
	 G9fu+P82qQXllrTZ6Alc6wkrFQ8sfLpjrHo4Nswdf3ySsYd5XQPL+dUedxm63hz2TDQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QVoLKp2s;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB1F5606A324
	for <linux-perf-users@vger.kernel.org>; Mon,  2 Nov 2026 12:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QVoLKp2s
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FFBA1F00A17;
	Mon,  2 Nov 2026 12:21:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793622083;
	bh=NEu+YnkRBZm22VaAtT9g0ASIz4ukm9lCH8be7A00SfM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=QVoLKp2sRpJ+6KZA4kiO+dBVH9aqbezSB0ybsvVU4G0KorC7IQIRN5g1diF4O4G7c
	 pFa12lmVgUypDj3890x+0pWSruogqV551l8Hr/zzPzpbBWpvth739tpAhqNc51dSiw
	 ofRLsq2pBc2OceVBRvwfbf1uwsAPCejIgNn1BPi/gMEgD7SGonVu9Ex6x0i+NuvQ0S
	 FAN38pfnUdqExLXpkW6cCY1VaB7q268rYIF7wabJQCMhWQyJt75Icxi5qyGYglqTsN
	 ODNg/HUIUsJ4LrSiA6FaKB/DvHxUGrY4MFTFIguOTRsvo6BNNP8iJPjxpKnKQ/Ipne
	 K9l0ER5fUuP6w==
Message-ID: <sashiko-outbox-193390@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 10/18] perf auxtrace: Turn Intel BTS snapshot search
 into a generic one
Reply-To: sashiko-reviews@lists.linux.dev
To: "James Clark" <james.clark@linaro.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261102-james-cs-unformatted-per-thread-fix-v3-10-dbcb0c281b9b@linaro.org>
References: <20261102-james-cs-unformatted-per-thread-fix-v3-0-dbcb0c281b9b@linaro.org>
 <20261102-james-cs-unformatted-per-thread-fix-v3-10-dbcb0c281b9b@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 02 Nov 2026 12:21:22 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> Currently each auxtrace user has to implement both the snapshot search
> and the logic to fixup the 'head' and 'old' values after finding a wrap.
> IntelPT and BTS have the same fixup logic but different wrap searches.
> BTS and Arm SPE have the same search but SPE modifies head differently
> (although it probably shouldn=E2=80=99t), and Arm Coresight doesn't have a
> search at all, but later it will want the same search and fixup logic.
>=20
> Add auxtrace_record__default_find_snapshot() as a generic
> find_snapshot() implementation that tracers can use without
> reimplementing it. It's based on intel_bts_find_snapshot() and the
> search includes the caching from it. Split the pointer fixup into
> auxtrace_record__snapshot_fixup() so that tracers with their own search,
> like Intel PT, can still share it.
>=20
> No functional changes intended apart from changing the pr_debug3()s
> to print hex to match __auxtrace_mmap__read() and no longer leaking
> snapshot_refs when expanding the array length.
>=20
> Signed-off-by: James Clark <james.clark@linaro.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261102-james-cs-u=
nformatted-per-thread-fix-v3-0-dbcb0c281b9b@linaro.org?part=3D10

