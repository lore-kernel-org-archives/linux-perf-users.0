Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795041883;
	b=FMwLZkqj+regza8oZKLhXkNQPQOUrR1gfjnE0sCwhEFlGJcwvDS42ycNXcN2dMZiEKDx
	 ysAA1+3FdpE2UtyTB8oZufVJ96HSr45a4tM0HUjzqlpLXwtX1tn62d9Yz1+weLKcmMNcZ
	 oYV8ZmthqG0oGYDLjOmmRgHuFIQJen16N+iiKTp8s77uyc8ylT98MNaq8SNjnjb2Lvkfs
	 tWdcxqVgcBqyvk53uZQwk0OG18pBXlmayIHli7cfRpg2x0xPb8fGnf3XYvU4XV7au6UZi
	 G0kxKqDKC3fHe9m+6u+zMxUk0dVHlIRGwtvJaKff1puxDbM2NYrUsrNNcNTa0vJOx5Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795041883;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=L5Hl6heUtB5PKWcY8A2AGSDHmeou3gSfug0sTu6fj3U=;
	b=GeoVp2OwuELVI/xi5gDG2XKH9fcccaXIsluUP4EM56RHln4RUGLJBZpIC+oV/tUgPJvM
	 6Z5b05mb67M2AnHhvbrj7IxWTcATIHVA4saF12Nv60GT2KfoBCAFu1MTxKcHerXbMG7TU
	 2EB+lo5MBIIt5vjZOtbY2+8YFhsy3RiaEYDZTz43ZMyUtWDXpGMCYhGMMJ5GlDBsisFeo
	 YRhfDN9ltCyntayHx3MkPDeFPVFE+b5vrSEsNwRfwRQSUjdN8tLeiQG/7/PNGiPrw6DZb
	 MFjWZu0tq/tfoxAdG+LLjAzvQiR5bNHm9peXQhEYJMhOHODX8F2dZy2zO1b9SSAtxQg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RfmdLyoh;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CE6E606A32F
	for <linux-perf-users@vger.kernel.org>; Wed, 18 Nov 2026 22:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RfmdLyoh
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCD921F000C5;
	Wed, 18 Nov 2026 22:44:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795041883;
	bh=L5Hl6heUtB5PKWcY8A2AGSDHmeou3gSfug0sTu6fj3U=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=RfmdLyohm3kIows1re88BAGCjM6sZkkxGICyEdd3ErFm4YydkTg1WXmHzz+VVHLQG
	 6JlyqwqWu4nPKpEvMsKN/fk7x1d1Ehpp/SL/bCws83SaCOvkJCQJm26rVZET6MuAro
	 VlGLiA75zFqrcsYHOkVD2WQJ4WJh1DXBFa/3xM1pxMNQwgzNJl7PmfYZfJ+PuIv2jv
	 +WblHprYn2QMc3hByWGsXfgIn+0pb+wdSYB0WnXYhKTrLEtSChN1uzZ8+ANIYcacNL
	 2jWShzQKtomztA5cGn34r2HJrqZYLqYwlQKoXR2LVo5MbadRKDEEvlc8oltY3vj4Uv
	 0nNN+YYVKOBmQ==
Message-ID: <sashiko-outbox-222123@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 13/13] perf test: Skip the LBR inline unwinding check
 when unsupported
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261118223725.121500-14-acme@kernel.org>
References: <20261118223725.121500-1-acme@kernel.org>
 <20261118223725.121500-14-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 18 Nov 2026 22:44:42 +0000
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
> The LBR check takes caps/branches as sufficient to record cycles with
> --call-graph lbr, but the file only says the PMU has an LBR: AMD LBRv2
> rejects the call stack mode with EOPNOTSUPP and AMD BRS, which samples
> only its own retired branches event, rejects cycles with EINVAL, so the
> test fails on AMD instead of skipping.
>=20
> Skip when the same event records without the branch stack, so a PMU
> without the LBR call stack skips while a perf record that fails for
> another reason still shows its error and fails the test.
>=20
> Fixes: 446c595dc0dd1759 ("perf test addr2line_inlines: Ensure inline info=
rmation shows on LBR leaves")
> Cc: Ian Rogers <irogers@google.com>
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261118223725.1215=
00-1-acme@kernel.org?part=3D13

