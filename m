Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795123172;
	b=H4eT2suaDeKbnrEpAsOP3m1U4R0gJw2/IhkHpW5McfX7AF/rMadIt2vv9+aBVnzJcDk9
	 /oTPIN9xkO2y7lLzY5+QhkzUBFN2dgKA0A2Nur5AE+KY+NILmpGo+MTdzP2biFno82tAu
	 2D/VJgsmwrjOgcXA4s7Lgm3Wq+o6CRMvT70oQstJI8q2wYtZPzr+B4fRljlk/ypSjSRBW
	 R1OYV53uSTllcDuOhfMk6w8WrZVUpxLaZhbpI1gDBbu5FMZ/F2ABCw4praCWWmDPHLybu
	 pLwWy9ZjQfnBalY84JA5nNmzD+mmr/WBDwXjg8hJEXPkfaViVIO0dUnktrgZa28aFFw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795123172;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=Ur5WdyBa7Nsynadk8aM3gSMjN1x718Lr6MFypWK9iks=;
	b=sxJF/CXLiq+89lAZLlfXCyGAzcE6CHEtnJgRISwKt3lnNP/OquEhsM28NCLxU1DRBsjF
	 VFn7jqwHqwetE0ic+kmiF1wNjOezStrdTeVdJbFwVT8IgBscf9P8sX2zapRjpPDOpxtLs
	 4TRmY2BQskPhxKpxAqfHlOotqEPrCIrQXIS7yWDB2F9PLcvw2GJL5ZaNTw//R/h6ZzaXi
	 QOM39rj2aoKYdYBmLP4IxvWzp9un5+MvFjmlEUfTZrl+fK9opN04NUi2xPv9upCCiGrUm
	 d7gmS5ynhSwns/wt0WdMZO9zuUB/ZXE0BMpotCp9vy17WMzv0WInUIqwr4N8FVeKyuw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oaKAswNj;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB864606A32A
	for <linux-perf-users@vger.kernel.org>; Thu, 19 Nov 2026 21:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oaKAswNj
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37C691F000CA;
	Thu, 19 Nov 2026 21:19:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795123172;
	bh=Ur5WdyBa7Nsynadk8aM3gSMjN1x718Lr6MFypWK9iks=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=oaKAswNjL/b96iWWDQZwXGJJpHqD4TXfQCENbkjapiY/nVBGqCBEXwBp1xayMxk1E
	 vggLiMj5no0KHq/uLX1vb06UJAREZHHhsrrt8bz65VMYMCc4wIfBKqABnNCxSWD9Zs
	 eQxpb+eyoFSE5k2mXhzjsv2w44PBHshepHOmGFDxao1yCJE9xK+e5dLRx6a6O3/WZK
	 Y6hHMJhfU6+NHLZjFiL2Erl4gCgrdKeAJIXzABs15cJoniQuulSlDXNLd78ivRmLld
	 9lh8eideelk9RH+iczBs5obbZ6Q0CaVVdMJ4idMMcX28wPhFPvwSbmJUiSsrwEZMks
	 W99W7GkPH9T4A==
Message-ID: <sashiko-outbox-224088@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/3] perf/core: Don't zero perf_sample_data in
 do_perf_sw_event()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Usama Arif" <usama.arif@linux.dev>, linux-perf-users@vger.kernel.org
In-Reply-To: <20261119211235.99805-4-usama.arif@linux.dev>
References: <20261119211235.99805-1-usama.arif@linux.dev>
 <20261119211235.99805-4-usama.arif@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 19 Nov 2026 21:19:31 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> Kernels built with CONFIG_INIT_STACK_ALL_ZERO, the default when the
> compiler supports it, clear every local variable on function entry. For
> the 256-byte struct perf_sample_data in do_perf_sw_event() that is a
> memset, and it runs on every entry, before the list of events is even
> looked up.
>=20
> do_perf_sw_event() is entered for a software event, e.g. a context
> switch, as soon as one event of that kind is open anywhere in the
> system. Counting events add to event->count and never read the struct.
> For every matching event, perf_sample_data_init() resets sample_flags,
> period and dyn_size and stores the address if there is one; for a
> sampling event, perf_prepare_sample() then fills in what its
> sample_type asks for.
>=20
> A single context-switch counter, e.g. one kept open by a monitoring
> [ ... ]
> this cuts the time they add to a context switch from 54 ns to 44 ns
> (sched_yield() between two threads on one CPU, with
> spec_rstack_overflow=3Doff).
>=20
> Signed-off-by: Usama Arif <usama.arif@linux.dev>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261119211235.9980=
5-1-usama.arif@linux.dev?part=3D3

