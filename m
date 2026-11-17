Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794941686;
	b=zgoCV4AyHWsDKGUo87VJj+ucCjIkXwI8+YRtUbi0JM6cv4H7bMWpzH6LbGEV/o++HArB
	 INRCBwWj1X5FK5T+ua4JA0yFyH+24bM8otTFR7soEBkIkra1NyepyW8kcn8EpUz68mmHw
	 uTkeJ46tgT1T8bpCBv9gY0Lb4s2l5LFtiEjnt4/nqGNz0ag5L07PjaUrs/gqdjrgYfOPc
	 AT0NfoHo7DHLfrn0cl1VLfOCYHpWJT2Vmq3r2oR7LjHUV1r2HZvXBeRNzBbTU8ZSwoCml
	 rSUg6yTLreCYN5RABbpbQtvONXUyPKV0RvUVouF+QJCsZVHMSmMi0KY07s9lcrob0Lg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794941686;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=qGxCtGR0HclHGCsGvAsL9fltS8lXDDoWKJ0Vb6L4eNE=;
	b=JYlgse+2Isl+n9vUBxjfzc2t8p2stWF1wB7Ff8mZsFz0pu3fdb1+IkwWj2t0FkE8g4Wr
	 7HojIiMBxwweMtVhsVzhF4u/TW5LE5r4ql/cPCtN4Ui4eIFV2xqAJFCs33SV13VXCjj++
	 dXc8hhf3ZdDgTWyP/4WVWDMyIWvFizS6+DO2q85wT+IIMvSPn0EEUzKxjDLLRaqT5HtK4
	 awPz0+6LjAmCUHpMqat0ZvFau2UW5ZLE0baieLehIN5cGzpTLSODQaVRrTLkoX0J1+Tly
	 IU98Tt/7UhxSktcyk2pxigdp3jTYSW2titviw1rTOjyIxBeO2xUf76z+gZtxjNLffHw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eJceGWIg;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DE08606A31C
	for <linux-perf-users@vger.kernel.org>; Tue, 17 Nov 2026 18:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eJceGWIg
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5253B1F000C4;
	Tue, 17 Nov 2026 18:54:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794941686;
	bh=qGxCtGR0HclHGCsGvAsL9fltS8lXDDoWKJ0Vb6L4eNE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=eJceGWIgR7LPoQbokNcWpAE5ukzDEDmupx7eMRcTe7oY4sFfLVkFekWfF+RAYziiF
	 6tYheutaaHX5I4nrQxLEgCMPdjM5a+ntm7rl3sajw/KnYVsQh0kLb+G56XXSoljJMd
	 QKZXqcYHqV9vOfJ77l814Hv7VOLTEBI22wIqHZTj+q9rpSmm/POS5dOTqSS0l27kYy
	 TindZP+NHCtLPFBHr5JPvyAEMcglQVijiBsJxWa9NCByo4I+eSrxY4XCjifgr/c6uH
	 qOj1xJKmKbBXFsvlX+k9Buwbhr49C/Jphi6Yct3l6jYDJwmQIPqARRkRkaxlM/nVu/
	 NgGu195Wzx1fQ==
Message-ID: <sashiko-outbox-219404@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v14 03/23] tools headers: Synchronize
 linux/compiler-context-analysis.h with the kernel sources
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261117184844.99889-4-irogers@google.com>
References: <20261117184844.99889-1-irogers@google.com>
 <20261117184844.99889-4-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 17 Nov 2026 18:54:45 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> Replace the no-op stub tools/include/linux/compiler-context-analysis.h
> with the full kernel implementation from
> include/linux/compiler-context-analysis.h and add it to
> tools/perf/check-headers.sh so future changes are tracked.
>=20
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261117184844.9988=
9-1-irogers@google.com?part=3D3

