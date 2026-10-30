Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793333472;
	b=R53DhBzMmgASn9ski0/M7eS7yNs1qtIEzKDuDZU/rc2kD9tuCdH4CrMw5rJP964vQRgS
	 mEclGPPMtKOBa3VLHWjHzaXYf09VJ2IyZaXn7LAhyNvm9PSQNLzvtZMfs9qVN14t3FNxY
	 1JRR6VCddkMhHcUIJtpmmMhE9TLE8VvBcfK2tQdhMLVao9dWvCvCHgGpIWxsRLV7kafnL
	 drXCdx53n8Z0ssOahjFz0uEGESjsp345B/0sgi1pE5GhbOSKdB5lrh3mx8oeH0sykQHS4
	 rKlLg8QDYEaz1+7lXp1udPhLJqZf4rKsUDh62tXFsmKbJ0R8km255C7KLctuHNsrX/Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793333472;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=hrRch28eKhIldaYbjUweBwczlckSAvOjfYNDFu2+M4Y=;
	b=PGow5/rab5dTre9NpHM9a2dghxAVWMsXEHzNrE3SJOkQpWz+CBinZXcF76fRGoZXBIrL
	 AIrh6pNJQAcCC0GqM0rlm6RX7aKAUMvuZZxfZpE8ovQ++ncUtha6QTzFFZ1rHVym4pOmX
	 4YZzgTdYfh+o9aTcCV6+jWBKFz7Uetf866y08VnEaeu1i/eWYS44dSKcaWqruAiCoeGpj
	 X2kOGsDR+n3ODXufvpLv7Q1DOF0PmSBYzjnxaqV/jE0pNgCSrY1C/Vr8/l1iBic7+ls/y
	 i78KmEsNgWo3+Er5s9s72V1T+zFREmqiBE+575obvULoiDE4k4sBZNArDEbVZrHGJjg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cyawVUqZ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FA2E606A31A
	for <linux-perf-users@vger.kernel.org>; Fri, 30 Oct 2026 04:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cyawVUqZ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2F861F000C1;
	Fri, 30 Oct 2026 04:11:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793333472;
	bh=hrRch28eKhIldaYbjUweBwczlckSAvOjfYNDFu2+M4Y=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=cyawVUqZ4lQq/GUBV7WuMvaBqQpXqlokI39o1hEqN+uakRSKcpsA64f1q9L1N3AgH
	 KUJF3Wj7COvvubupnQ/eiZJzCzdeFB8XI4xFhSgD1eiAkktfgfAuIQLAVHKEcJUHaf
	 1aulZfzXaAgc6wy43+3gfoKv1RoOy/Jkc0CquYeka8B41ifY/rhaAgSW1/CFKwuiCu
	 oyKTw4bxHg5csC3aiD+5WKcXkZuBLc3WkVsfTm974u8CRSfiVEnG80o5rB+kt05hTp
	 yqhPNQgwLIl/pLWMvzYWRbhXZU+gXSE2X5IrTyN/6s9VQtanEhgwgoVoCKVzycXk+b
	 YS+yJ69bxvtPQ==
Message-ID: <sashiko-outbox-190289@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 5/5] alpha/perf: optionally randomize the ProfileMe
 sampling interval
Reply-To: sashiko-reviews@lists.linux.dev
To: "Matt Turner" <mattst88@gmail.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261030-alpha-profileme-v2-5-c702f1c65272@gmail.com>
References: <20261030-alpha-profileme-v2-0-c702f1c65272@gmail.com>
 <20261030-alpha-profileme-v2-5-c702f1c65272@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 30 Oct 2026 04:11:11 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> A fixed sampling interval can phase-lock with a loop whose length divides
> it, so that the same few instructions are profiled over and over while
> the rest of the loop is never seen. DCPI avoided this by randomizing the
> interval.
>=20
> Add a randomize config bit that varies each interval by up to 1/16 of
> the period in either direction. Only ProfileMe events accept it, since
> Aggregate mode samples already land a variable distance from the
> instruction that overflowed. Counts are unaffected, because prev_count
> already records the value actually written to the counter. The jitter
> is computed with mul_u64_u32_shr() and the sum saturates, so that a
> period beyond 32 bits cannot overflow.
>=20
> The jitter comes from a per-CPU prandom state rather than
> get_random_u32_below(), which takes the batched entropy local lock and
> triggers an invalid wait context report from lockdep in the PMI.
>=20
> Signed-off-by: Matt Turner <mattst88@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261030-alpha-prof=
ileme-v2-0-c702f1c65272@gmail.com?part=3D5

