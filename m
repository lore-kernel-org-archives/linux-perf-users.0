Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793944028;
	b=aylDX9iLsnDlIfyb81GCt0kD0Nb8iPqi5Q76mkVLLutLb0BliWjnNKUdG+C2Q4MfO3bC
	 yWjzEjKHcXmC0s5ZMhnX0TNhayA5jRWdrFu8pJNol0aHExD8jbcEgQYU7XRqCvvW85e1N
	 yOD/2yac1EuaWczTlosKR+N2WBlMd8xYWwePR4NjoA+mZIroiTnrjeHJVgn6xE/dkXpKo
	 dLmqHOJOaZ5P0Mr3GMUralNF5dlf5nFbffg20/LSGFaa4ALBcXp3tuhEF5S8L7hedyK4T
	 2LZNg/nOjQss/ADtT3k9LZpUjB0BaP/7JlaNw4dpRUKgPe/PKpbr6ieznBHBSQI4CdQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793944028;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=PNPtcgvRTOzWDxUuYXqTUWmUw0KOnBac+bmRe8/32Bc=;
	b=qBgg/m8CoAVLZGB5f8si+bflmi/Xc9mDibhU2IpVCkz6qeTSF9EXZMGvB7jW8kKrIbs1
	 RGrPMJq5fbuoYcK3qVT6nzJyRNpUEldmWbU71zXtb5GyFkoAktgxfwOLz3kJPPCl3YkAc
	 pGtMemfBt680+ucw5GPFCAn7tqXQMZZWhmC+L552sMljpchBTLLlFawYt+QjTxJ7e80Ao
	 Yw/FaBYfQ2n571lzR8rlvsdaghHl2kQ4Qq5eZkWfB+6Z6kZWHkoy84BySM7GZuTef7Yrd
	 Ti33VohR+hpdR0K7bwHjGCsKCq40x2GiiuviVL6BgohP5rblbwo3AtuMQWe/x+b7ekw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ILqJZ4Cu;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5301C606A333
	for <linux-perf-users@vger.kernel.org>; Fri,  6 Nov 2026 05:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ILqJZ4Cu
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4B3D1F008A4;
	Fri,  6 Nov 2026 05:47:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793944028;
	bh=PNPtcgvRTOzWDxUuYXqTUWmUw0KOnBac+bmRe8/32Bc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ILqJZ4CurLkqKnVJgOYGBX7JiOm4zKDzcFhE0o15DWEy5xmN3sLdbwqKOj8v+wVW/
	 R/LvxRWfWYPIKtsHRkDwvfCYadHrCoe4n8bnwZTSn7lrwgiGGGYuLNHUeV9jEg1UDm
	 dw2x9D+Eczdrj7hzMA7D9ubxt9Mc3d7B5uOJpNOye/Qu5oeYeTOOnxkteEPzXhNjUb
	 oznduzt4goJwHt0rB1NDtRinO1PFqQU/XthKlPUdZkAL9u18Sj0Lf4gANtsWsJCV42
	 EvTxXP0tznuATuIGqE/eNUejUEN54VsYdIjvkt1npkG+lIHIOUDgh2+ngQOdfw18Ov
	 H4pgOoqmjOs2g==
Message-ID: <sashiko-outbox-200853@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/4] perf test probe_vfs_getname: Fix missing debuginfo
 detection
Reply-To: sashiko-reviews@lists.linux.dev
To: "James Clark" <james.clark@linaro.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261105-james-perf-test-fixes-v1-3-0b279bee5830@linaro.org>
References: <20261105-james-perf-test-fixes-v1-0-0b279bee5830@linaro.org>
 <20261105-james-perf-test-fixes-v1-3-0b279bee5830@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 06 Nov 2026 05:47:05 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> skip_if_no_debuginfo() looks for the errors that 'perf probe' prints when
> there is no debuginfo in the output of add_probe_vfs_getname(). But since
> commit 92b664dcefab ("perf test probe_vfs_getname: Skip if no suitable
> line detected"), add_probe_vfs_getname() returns early without adding a
> probe if 'perf probe -L' doesn't find the line, which is also what
> happens when there is no debuginfo. The error from 'perf probe -L' is
> discarded, so the debuginfo errors are never found.
>=20
> This causes the debuginfo dependent subtests of the
> "perftool-testsuite_probe" test to fail instead of being skipped on
> kernels without debuginfo, because test_adding_kernel.sh calls
> skip_if_no_debuginfo() unconditionally. The other users only call it
> when add_probe_vfs_getname() returns 1, so they aren't affected.
>=20
> Fix it by doing a dry run of a probe that needs debuginfo instead. This
> [ ... ]
>   ...
>   189: perftool-testsuite_probe : FAILED!
>=20
> Fixes: 92b664dcefab ("perf test probe_vfs_getname: Skip if no suitable li=
ne detected")
> Signed-off-by: James Clark <james.clark@linaro.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261105-james-perf=
-test-fixes-v1-0-0b279bee5830@linaro.org?part=3D3

