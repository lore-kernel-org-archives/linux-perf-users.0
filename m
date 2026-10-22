Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792701692;
	b=3etANkwCZKrVO0UHJp3WDqz2LcghC8hjAZl210ext240noDnQKEa0TOqP9oq5eaXhPc3
	 bqA1AVPvN10poLIfhMf9Pxl+Qi8OIe/edzzSSe4cJXSzGKInvhPJezheI/P3rqPPz+0iv
	 TF/x8IZIpFpMIIbBOce1Kx49RRlvNvL1TlAPs+xqOeHdH33ANRrRVc3rUNXwwXkG6mZQq
	 OVHIw+r+vavrz4/RgkvoWKL91H45vX+x9KKkmXqAOzuIJUOURq1002wiv8CykRhdqcMn4
	 wXLsnQSn/R3abaySh27/8pljWkUZCHgCPc/bhHyP6XQ+c6EurZZJfRf9VaH9a6OdSoA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792701692;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=iGiyhqAh4Lj2SjdAylo0cGVQCXzhFb21o1K2iT0O6S4=;
	b=VDOnlxi5w5jfums8FvdzfH6vkJdF9koAaVwDqjCEwxfuzXQcmKuEGem34vbfLLnFgrUm
	 e6kL3vqix8IkaOvwr+y2qFX2CsRzJwj1B3s3SbwXH7+tuEe0jgJln0Rdc0cAeSDGtDevV
	 HY4qBgnU8w9ViQsLagXJTbVU4utq+tlq4vT6VNjfsLaDaa86xDPS0b200Qov1+l/iIVHj
	 AzCRZmNhBJsp7//BP5q1BCFi6Cj7CbthHTAtp+bR2+8GbWp6cVOJB4wTQfrLD62kEPQT3
	 EFll9Xlms/WwwBQ969v8ir+znA9scQn2lreSw/YcQp9cMIna3irpbMmivgM3ZCCxb0w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Dz5L6aGK;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C249606A319
	for <linux-perf-users@vger.kernel.org>; Thu, 22 Oct 2026 20:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Dz5L6aGK
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E8561F01825;
	Thu, 22 Oct 2026 20:41:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792701692;
	bh=iGiyhqAh4Lj2SjdAylo0cGVQCXzhFb21o1K2iT0O6S4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Dz5L6aGKvoUyhyElJsXUA/h3uG4aBUkMFk4A8+fJmeZWuDLcmegSjV9wCN+U50dHT
	 0Y0LrnN/6niRGMCQcjxkYxWUUaWWgt+5Xg8CAVGdj1p82eJuLtD4lpa4oyQeIwEWcK
	 ilSbtZMcuK2HaANT8r47dslHzYQyA1nU9MBa5PQXpmNlXo3uIzFhdhu+ZUeAMzFv2D
	 IbH3rL9HvPh7da9q2KULEdmC1KB2MranmrmCcXztUSo6DHshlcSHhkVBDo0xNEo9RP
	 94T36Aih7J2mKKE7wJAnm6mNu5QJyZHOVNMQw79AFHwHn1dN9rC9qHJat0PaIv6sMY
	 UqES++MYUtRzg==
Message-ID: <sashiko-outbox-182019@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 04/11] perf lock contention: Extend get_lock_owner()
 for rt_mutex and mutex handoff
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261022203003.1779152-5-irogers@google.com>
References: <20261020205859.1080743-1-irogers@google.com>
 <20261022203003.1779152-1-irogers@google.com>
 <20261022203003.1779152-5-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 22 Oct 2026 20:41:31 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> Extend get_lock_owner() in tools/perf/util/bpf_skel/lock_data.h to:
> - Support rt_mutex locks (LCB_F_RT) and CONFIG_PREEMPT_RT mutexes via
>   struct rt_mutex_base and struct rt_mutex___old, masking out the low
>   waiter bit (0x1UL).
> - Return NULL when a mutex has MUTEX_FLAG_HANDOFF (0x4UL) set on
>   owner.counter and is in the middle of being handed off rather than
>   actively held.
>=20
> Also add rw_semaphore.count and struct rt_mutex_base to the fallback
> tools/perf/util/bpf_skel/vmlinux/vmlinux.h.
>=20
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261022203003.1779=
152-1-irogers@google.com?part=3D4

