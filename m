Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793564712;
	b=dnFz9cgFSJQQHkNU7BSz6ZKnKmG7TLv8bJNBbNXVrfV0VNwwCT1WxoSIWQKGeCFItYVJ
	 srHnEXLP5AAvueoUbsXFgafEsyQJUw6awIH/NvHeHw0Q8TEELYm5hFYh27Q16xzBa73RG
	 WXSabAWO8j7bLk0as5QoWCreU8TXPA8PkZGBiqyWH2Yv3UiVP3jmADG/3LQJbnGp/K1N3
	 87MOUWhsAfWzCoXwCJwekdtlZ73MLoK9elZ59C8g/Z5m2Vc9X3WIaSC65pO7h9bp1qTcC
	 aP40dELCs8fNNGuyHsV7pjABqWysm2VI/30TGUaMtMnBUCOidyzx97CAzmUYpSo+l1w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793564712;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=NaorJwSyCvnkeB9YvrIUq1+SwMtg8djM8NYf4sZ2n1w=;
	b=0m246Tx1KEzX+TUIDIjrruwUe6DkP47ScKkP1G0JtXNeRcAnjdROW8DY1o74nZc+GTig
	 xVQEb+3/vhUUfRiEg13EoAzsRUUuyUaSxPzlpfCBYh5jv7cnti0fEb9de9I5L9ee4ZhuG
	 dj6KR1uAEIzmoq7pCRkDkRoNOA/urRZxGS5h4cFTb/+t/XF2ScZmeK5jZe42pIqbZeTSp
	 VQP7mzNBZt4sf+3oVKmt5XfzQWHiedaF7wIa0GhfdajRjQmeeBUIQncS5tPHgvFGG5EPk
	 oMKH9AMBZxUahEl+lGUmYQOeuzvfALkOXNTQpeMB8PrqxYW9zfAkOWY9STURNRg6Y5g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YnB6vYYn;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96826606A324
	for <linux-perf-users@vger.kernel.org>; Sun,  1 Nov 2026 20:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YnB6vYYn
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32A011F000C1;
	Sun,  1 Nov 2026 20:25:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793564712;
	bh=NaorJwSyCvnkeB9YvrIUq1+SwMtg8djM8NYf4sZ2n1w=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=YnB6vYYnYIEkRvjYIDeVSszmAl4XGZJB6TeiGQe5bIfWaQQBJULLlSP2TQjkd53sC
	 UM5Ane586OUk1a4Oy12DBfdiUsZ+NfwylGwbqkqx3YKlev6dZcIIXobajNaCMjGqJb
	 TihuVpIAOA3PBhPwY/Gx046F8PbjCmF8+taVdnu+pKVlsoOO/LlYf9rURSnv+bRejQ
	 yLZKuq0lhLn72TgzHIBJocXCUQ0SCZRb47tcysWqmHF9N+C+gW5uOPEAZgcyGxs97u
	 QOkeJzvdNFdaMMEJzm83vH/7YI3lS/uimPuLdsYJGa5CLp9ntgwWEbYE0vX5Y3vMFu
	 XzSuB9m2McTeg==
Message-ID: <sashiko-outbox-192665@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 7/7] alpha/perf: optionally randomize the ProfileMe
 sampling interval
Reply-To: sashiko-reviews@lists.linux.dev
To: "Matt Turner" <mattst88@gmail.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261101-alpha-profileme-v3-7-92d511b5a044@gmail.com>
References: <20261101-alpha-profileme-v3-0-92d511b5a044@gmail.com>
 <20261101-alpha-profileme-v3-7-92d511b5a044@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 01 Nov 2026 20:25:11 +0000
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
> already records the value written to the counter. The jitter
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261101-alpha-prof=
ileme-v3-0-92d511b5a044@gmail.com?part=3D7

