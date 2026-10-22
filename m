Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792700584;
	b=l/oNNNtFZ1Hs9PjcQ8uBRmJwebngxU30TGDeNAETHdOK2qBeXpRrq24tL9BjlJptDeGu
	 Fq+CmUj0TbHMCBIuyWlL7IETFjERsYvsGMlGoLHKTbuGac1YVhWMLcYj4+tvUigElOkRy
	 DlLKgsIq1gCizr+os0x7ZammZ4RvcYJWOovQxcwre3CBNWmxQbM15TQo7cVWpipFqPgId
	 aEwnxi71yagBd6XzLU4ynSqQKsI3nkRpzMuxcl9PofXsYKdgFcDHwuVxnzfSf9VMTmzKc
	 EvYsxjcDxd6O9j+kRTOCFOf/uA3TdqwacUJJaUQkkg9GAtc92kKtrSqjr15XDyHB/PA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792700584;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=6+N30lIOYuTu+3ivt95el49c3iQN7SOu0cZIYB88/8o=;
	b=ZyVIZ0AlZxsQGVoE27p/1IrCS4SBUsz8R3VD/BG2tfCahO81MOwWbOTbfj4JVSAsZwcX
	 QOxDKKHF5t7XYVbJWnyJUrjy/OcSIrx2yz//VHhfIQWt6F97lY7MQzSbHGpKDAMKTlxpo
	 yR1kYfsPkRLfi9lFZ+2oCVflfKj941TXS368vtkhDwOua6bMU8q30uvBPq8nD/3+H8Gv9
	 ayfPPFSGIDQZgtkE+eDB5i6bSR7I133PgR6Fm9EFfuRUAPP9hH0BdzjGpB1KSUFHG52Oc
	 5LRZa1jJyxx04R7p+RhrWS0T3rLBGd45gEXuLRJKvhMYM9OULYciHLZ+MFQSPlg9IIQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gPjxMUc7;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC85D606A31A
	for <linux-perf-users@vger.kernel.org>; Thu, 22 Oct 2026 20:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gPjxMUc7
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5025D1F01825;
	Thu, 22 Oct 2026 20:23:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792700583;
	bh=6+N30lIOYuTu+3ivt95el49c3iQN7SOu0cZIYB88/8o=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=gPjxMUc7ks0pXNA9iYxqmGBB/okXnt2EvPT02fnuhVjuUgGcQ1R23bTbRrUvaMsQ4
	 yxFZK3v7xNrOAqcClChFWD2Liv8LUBI/AqejjKCT/Gj6TMyhkQVdC4D6/ADbtAAG0q
	 Mgd7ZTwWE4yYJwyL36W+iVC/+3gfyWUWSYwevHt0gzVTlGOjJ18UdWTBh1BtW/19bO
	 ILHP8QDMEm3NUFR2LWPNBZedV/1oM3m9h4y5b2ZH7zKrTiKh650LoALBdbPlXltVF3
	 hI0wk4PsuER9ZH+MUekBe8iF3CNliFu1ultC1NZIjtcTxhzGZqWwgYxWJuYSKKRrUh
	 1tkQjQV9N6PXA==
Message-ID: <sashiko-outbox-181992@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 11/19] perf dso: Use DEFINE_MUTEX for
 dso__data_open_lock
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261022201453.1717523-12-irogers@google.com>
References: <20261021223905.715051-1-irogers@google.com>
 <20261022201453.1717523-1-irogers@google.com>
 <20261022201453.1717523-12-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 22 Oct 2026 20:23:02 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> Replace _dso__data_open_lock and its pthread_once() initialization
> wrapper dso__data_open_lock() with DEFINE_MUTEX(dso__data_open_lock).
>=20
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261022201453.1717=
523-1-irogers@google.com?part=3D11

