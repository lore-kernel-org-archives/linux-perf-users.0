Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795138544;
	b=IVvYmF2slwMBrBukBqA4Ew8gPf6DHKT+YekpWJdl6O37w4p2tOuWVFgXIYwnjtTfgJKA
	 uTcNY8YOOzgaREwKrqykhp1fDNRch6v2k89tN+um7cWvlQT9eO9+Xu5L0U5zTf+N5/M4h
	 tcv3fUc4sQhKNDgsam29LU/FJL7daCgS1ZnmtHOg3fiamOa/V+IHtjGfZG8qhcXz4yCfl
	 5vQEzaxv8t1CVLLR/DJ2PKvzgMXqTt2xgVuerQX0l5iSfGJmxnnB60QU42Yrba+EmbDmT
	 M3w3LgTXQL6wd326wlEvj6NCu2XzI7ShLOjHZudBCASuMvzgaBho3XGYGRwRsRhX8nQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795138544;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=hDlMLagPM7qH5fUQILm6hL6WZEKsbZ/BepruDSWYSJ4=;
	b=VqXn0tAIFvkZZJPCmRpl5IuAuaNXJkPMr2QuLlsaAxABCW2wVcdJliW/Cr+pRQINEW3q
	 sQFU8//V3Xn9gJsYqRchH4iL2AjEkRaB8bz/JMjUqGmqTFi4o6UVrBdDeDJ/5YWKK/Cfs
	 8ql1mzsBK9YxhsFlOIzez7+ik42IphXNLpUflDRrxO9nQJHt7tEnKLYGJiaw6w9j4ijex
	 Sr6AKM7BFRLII+Lun1fzQkXpjEvbQU8l+P0eVtfurRJ/munZWd9ULA/D26UH10GLYhaoJ
	 S/n1PPImnmijSi/tdLNeiCYODBWRCp0mGjqecm9k46lFsmyfjp+Ew00WuXHCufxgPXQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=He7SuQtc;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CDE0606A320
	for <linux-perf-users@vger.kernel.org>; Fri, 20 Nov 2026 01:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=He7SuQtc
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED80E1F000CA;
	Fri, 20 Nov 2026 01:35:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795138544;
	bh=hDlMLagPM7qH5fUQILm6hL6WZEKsbZ/BepruDSWYSJ4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=He7SuQtcDmWYLiiBOMoVJChryON9Psr7vhBpHX0ZocqNlxM+txUBJwprA5ZD9ZsXI
	 66H3x4GjzO+dGg+a02T4M2LSQDlUbB/KZOudDnbflKpgwJdouE5q3Vyi5zbTTzAROI
	 NUn6alpoHaZg9cV9QoQs5jcszBpMOMfZjdjl2DiqvX3wkEab5nWErIcuDaCdFyHJCB
	 l9vGmq9iiLPf9TneGQ/2f62I+Bw9oaMlqLv4jXRUNEMC+5kVq5lR1SPuJHkM92mTuG
	 jZ0Wgl8cFtMrUb1C6YVinuJqlF2n59eoH+Sh9sl3cSmsEuCJTgR5+5rDL4n8Rwc73P
	 9U8H2Io1PCiQQ==
Message-ID: <sashiko-outbox-224323@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 09/13] perf tests: Silence the libbfd probe in
 build-test
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261120013211.1510-10-acme@kernel.org>
References: <20261120013211.1510-1-acme@kernel.org>
 <20261120013211.1510-10-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 20 Nov 2026 01:35:43 +0000
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
> build-test evaluates the libbfd probe at parse time and the compiler's
> stderr isn't captured by $(shell ...), so without binutils-devel it
> prints "bfd.h: No such file or directory" once per tests/make
> invocation, five times per run.
>=20
> Redirect the compiler's stderr; the empty result still skips the
> nondistro tests as intended.
>=20
> Fixes: 523471c5163659c6 ("perf build: Skip nondistro build test if libbfd=
 is old")
> Reviewed-by: Ian Rogers <irogers@google.com>
> Cc: James Clark <james.clark@linaro.org>
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261120013211.1510=
-1-acme@kernel.org?part=3D9

