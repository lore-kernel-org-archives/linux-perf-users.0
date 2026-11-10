Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794349222;
	b=EhDG8TZndxp+57e7qmrfJWLu9cZGsiIewumQmYXqm1SfZjstSPiGUUVSp93HSOQNC9/o
	 HXRpHf6FBmlRMLY3zj4dKmxunUoXvcw8qAFShOqmzrCYPDrqoOlqUnNktyG6nYKNcZ4rk
	 YZekKreZ2F/Qrt7Of07u04Y6vKdXURzrAySQJXb4KIcWpLcWbSfWXRVnzJ/m+/WNEPH3c
	 dkPO2ioIfL+rHmwPwVlPu6IaSnGWCIjjRlfWo3Y/BBCdvCrm3dY39auaH+unMaRXK9qKD
	 POB29Bq4Z9Wx5XEPgkzpYaYTaZ1CxKszDU2nu6A8GrLFPE8jJMm7SZ76NhgOf7x6OKg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794349222;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=e1UOtZbgpd216c96ooLpFi5rytKZYIXBtH20TTzJNzg=;
	b=qDAR+ZE0rCLbRzYREn28Mm9nxwHs0vksIh7XoU0Bgr5WlZnb/fES4TYPUoGmCN7GBVuG
	 oSq4oVg/XAti/S9OlpuyfctpBjwpvMKvH+11TMx/PvUTm5w8RFWhpiLJQ69rDKr3z9fuI
	 X+1aOqtkTzC8SIhIL7eFHSba8Ao9sFgLwVgy4xT8R52fBysghDdIcAg/UXX2Pk1RhneuT
	 P5BGCBYn14aSokm2h3QpDOxSjxbe0SUNINXe7B5SdAJInE63y6N1mDto3mntSnOd5324f
	 EtT+Ip7+lv83Pv+N7eDb1jolIiEeQ8Lr8SordQTHwXGA7mXdmoEZ2MBhiIHT/ECQyaQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Zy0n7gS6;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10DFF606A320
	for <linux-perf-users@vger.kernel.org>; Tue, 10 Nov 2026 22:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Zy0n7gS6
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8624A1F008A3;
	Tue, 10 Nov 2026 22:20:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794349221;
	bh=e1UOtZbgpd216c96ooLpFi5rytKZYIXBtH20TTzJNzg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Zy0n7gS69ArqUFA5j4Yki2TbGF47JadMV4R+l/uqtLvWVXI/0Ipxy4nXB54qWKJDK
	 yBZIPJEqK9ruVlYOMmsL5P8nExQT2w3DoKeG4tWASfQjbUL5Zqj40jLecDa7gX2Bt0
	 H3a4ipYqS2bI9dLoHJozTni5aYhQbMzbTwDXO9GUZXXLoZkm62MwLzM+PTYZbs9b99
	 TcLeB7JbdNX9Dj9epdKfHKtBLuE3vyi9nXGuqWhSEJwM74DFJTRX7aX8U+zjkKKp8B
	 CdI6yB8xfKPcqTcR+2LRue+9BMHn+bk6yOzJE1dN085D9V8/PVWcsFk54mYnbL5cYL
	 0r0DU/09+QBeQ==
Message-ID: <sashiko-outbox-207819@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 01/20] perf map_browser: Fix browser index heap
 corruption by computing on demand
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261110220803.2503416-2-irogers@google.com>
References: <20261027231513.816148-1-irogers@google.com>
 <20261110220803.2503416-1-irogers@google.com>
 <20261110220803.2503416-2-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 10 Nov 2026 22:20:21 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> Commit 259dce914e93 ("perf symbol: Remove symbol_name_rb_node") removed
> the 24-byte symbol_name_rb_node reservation from symbol_conf.priv_size,
> but left symbol__browser_index() in ui/browsers/map.c subtracting
> sizeof(struct rb_node) + sizeof(u32) (28 bytes on 64-bit) ahead of
> struct symbol. In 'perf report -v' and 'perf c2c report -v',
> symbol_conf.priv_size is sizeof(struct annotation) + sizeof(u32)
> (20 bytes on 64-bit), so opening the TUI map browser writes a u32 index
> 8 bytes before each symbol's calloc() buffer, corrupting heap metadata.
>=20
> Remove symbol__browser_index() in ui/browsers/map.c and compute the TUI
> map browser index on demand in map_browser__search() by walking the map
> browser's symbol entries when the user searches with '/'.
>=20
> While this changes finding a symbol's display row index in
> map_browser__search() from O(1) to O(N) in the number of symbols in that
> [ ... ]
> overhead, so remove the verbose > 0 restriction and allow '/' search in
> the map browser unconditionally.
>=20
> Fixes: 259dce914e93 ("perf symbol: Remove symbol_name_rb_node")
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261110220803.2503=
416-1-irogers@google.com?part=3D1

