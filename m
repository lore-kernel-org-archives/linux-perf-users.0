Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794707271;
	b=VJSyMwwTuWqY2A93NaLdnJeZsZc4aQhU2SPG+M+tcwsHvIpRtvU2ns4xAaMDdkZgMIVn
	 d37K0NhU3nBdP2A+v432k3jt5vxBGA6beJRLEKpwSiMEmaE5mG3su4paivmgpXvFIE7/4
	 ZdlMZsXgCPkZevxVSE+bsg/SzVY8nJI9Xp9vRlenVpOAZ0yny9+baUQd+mX0NtTsLhs6c
	 3xP4Xn/MVs2IjvzwaaqixJPg2MjKFsegIzVe3ttwRy9DGHDc0tvT+lDxGDkD95mjRv3kj
	 CvqEomVQ4Tff4nRE+nXBaKISzWH+Auo0rEGZLFClJj1p1zPtoyPWp0vCA5oaIkqg42Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794707271;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=D0YuuZHE5mlN25CDi1OZz8ldedrsk8mTDwZbIoFufZE=;
	b=E1saIeyCSckOsY7SqXxdyQt14An0KubOZlQoZKqgBUClbI/owEam0YWTDU02JznQ1uoq
	 8yCxpgVRpc5Wn7tzjkYWMQq8VmBQCX9skki6UAJuSG7tIlCbwcdPxhJ7ZRNUE9hQJ9ZON
	 0qFRadiiHIUroL0MajEdISPSudA1I/7IYR3QM7NWxVF0PjY0tbZ2TfuTjjodVSt/Be7ek
	 BRmecKXnIS1Y1rLVE0oI6Erz7u+gpoyt7Qv9RuhXNwErn+Tem5oRLQ+6awHl24VA0Ze/6
	 SibRqnYzYbMco/dxEhX8Bd1m0BN0GPO7QSBNYoheGNmpIEWKKc9eY7qc1av2kO6znJg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fbH6mpVj;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59D5D606A323
	for <linux-perf-users@vger.kernel.org>; Sun, 15 Nov 2026 01:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fbH6mpVj
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 035071F000C4;
	Sun, 15 Nov 2026 01:47:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794707271;
	bh=D0YuuZHE5mlN25CDi1OZz8ldedrsk8mTDwZbIoFufZE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=fbH6mpVj+0OvEof/G60Hn866zzY4VW+gr+kic13VTZmsYZLom4+/64MXZr6Tujf+g
	 qo/y0fr+PVnsUDBC5JLuXkY4gmKX2c+ctYmbAzoMoDNTvkno8rAJX1wwxZ9K4FXxU7
	 ThfvY6RY3cfCXDJuOK84n/fooJeVdSOtywV+yV/D4TcpjUHmq1io6XFjwXDeCKNQ23
	 3M13/BSWzmAXcK87/OM7OrPD01WdLEzPADdG4IaJrkVay5u0RnWHVLxnpRdulFtPQM
	 QjnC+C7aom2nI0//PZu1Nnd4Wyrh5hVJSt37WpeJZ1w6O1iD+GTOpznrowJ/KwCYiX
	 k3QL2pnmbMNlg==
Message-ID: <sashiko-outbox-215170@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 11/12] perf test: Drop samples without an IP in the
 dlfilter test
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261115014102.2879372-12-acme@kernel.org>
References: <20261115014102.2879372-1-acme@kernel.org>
 <20261115014102.2879372-12-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 15 Nov 2026 01:47:50 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> Since v7.3 the kernel zeroes PERF_SAMPLE_IP when a userspace-only event
> skids into kernel mode, so that kernel register state is not exposed to
> an unprivileged event (166f10836a653dfa "perf/core: Fix kernel register
> info leak via hardware skid").
>=20
> The test dlfilter keeps those samples, and the check that nothing but
> test_loop survives then trips on their lines: the comm column reads
> "perf".  Drop them, which is what the test wants, everything except
> test_loop must be filtered out.
>=20
> Fixes: 199d5e872a9ce737 ("perf tests script dlfilter: Add a dlfilter test=
")
> Cc: Ian Rogers <irogers@google.com>
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261115014102.2879=
372-1-acme@kernel.org?part=3D11

