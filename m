Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792538407;
	b=B0hQu+cieIBruCBjJGLRwD06IMybi0FVubkCtFLUp2a0136S8ppYAfni2aNK2aLp6pMu
	 zOdYMLLbZBa/RIhC7NSeP9QpR7O8uZ1l6LRUkhdwiJmpSQP6Qjvwdolq6qsYb3c11oMjd
	 3nxPE9UisHcStNsrdeRsvqf/McMIBd5z2reGR7CaPATQFYJbEnyuSki0FT8/UIfDvBt87
	 XFjZApJb1uRZ4C696/eWlFN/hiUIiQ+wdetBuLwYQ3PiinJ4eZYgQSScaHFKd9iayl9XX
	 rRq71G5kV0NTxPpjh7an4cy3iQyjno+SVf0S/UgK75gg+io2A/Ke/56wJT6RjSO0X6Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792538407;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=9pBs/2Q20f+LzgzEisjBWhb0nO8VeleBkvRYcOKc8V8=;
	b=PrwfFGowijF0i2h9LBmHGF2NenBzWlXxDkREyQDNtN5Y6jgFdogIGSQ0njxco6LHiUjw
	 3SPG7A6L29WBJGpQa040GliFhXDEPIZw1uZBPEOxwdccCNega3THQpIR0R0HU7KTFP7hY
	 XN736GE+Mc7ZjHQoOHgPwo1YH2jxX6UZD2XBb4fwyDEtXRdocB0Em9JqfZ7bDjvsvqAJt
	 iQH9F6U+4lD1SH0HFlcc54vewb2Rvvgfbeht3HfRQmB5PPp6LcvIyn47ZQTLhgfIUrSBm
	 VDcbX1xR4oq4dp5X4U9/xgu1bkBaQoeD41ayuT88+pk+HbUEctTBXREaCycdhnQ1sbA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hSy1L3LM;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 801EB606A319
	for <linux-perf-users@vger.kernel.org>; Tue, 20 Oct 2026 23:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hSy1L3LM
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD9D71F000C9;
	Tue, 20 Oct 2026 23:20:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792538407;
	bh=9pBs/2Q20f+LzgzEisjBWhb0nO8VeleBkvRYcOKc8V8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=hSy1L3LMKRaH4lti38Fhbn2gtAJ5jG6tc9NlvOAHtmphUY3dkDFEDTCh73sB1SbqY
	 Gx7MNKwEAzV1C1PNxgOF6NxXw8TYf4h19UtxAubd4obja9qCCNoVc4kTALmC1nzEwC
	 YFq/QtFDiw43Ndn+icVRgWpNeFb+sFEbfmzPU3FmxKSRpjb1NT0YAyWrrdXz+Svb4B
	 nOAZJ2NR0Dk59yRmYVFpWYke65QrT58ZSm0s0PictqUEesF9V5bjOMpJSHFesm6Sa/
	 xmdnBCx4m72liUBQ7IrUDCGHZmxNosTGJGaNvAIBBMoHFEz53HKxWoSYh27MzBcDfp
	 CPzBjkC7T6o7A==
Message-ID: <sashiko-outbox-179599@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 6/8] perf test: Add tests for lock_held() BPF sample
 filter
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261020205859.1080743-7-irogers@google.com>
References: <20261019220915.3943592-1-irogers@google.com>
 <20261020205859.1080743-1-irogers@google.com>
 <20261020205859.1080743-7-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 20 Oct 2026 23:20:06 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> Add unit tests in parse-events.c for parsing lock_held(),
> lock_held_read(), and lock_held_exclusive() BPF filter expressions
> (standalone predicates, negated predicates, and compound group
> expressions) and extend record_bpf_filter.sh with lock_held(),
> lock_held_read()/lock_held_write(), and ':R'/':W' recording tests.
>=20
> Example output:
>=20
>   # perf test -v 'Parsing of BPF sample filters'
>     5: Parse event definition strings               :
>     5.7: Parsing of BPF sample filters              : Ok
>=20
>   # perf test -v 'perf record sample filtering (by BPF) tests'
>   112: perf record sample filtering (by BPF) tests  :
>   Checking BPF-filter privilege
>   Basic bpf-filter test
>   Basic bpf-filter test [Success]
>   Failing bpf-filter test
>   Failing bpf-filter test [Success]
>   Group bpf-filter test
>   Group bpf-filter test [Success]
>   Multiple bpf-filter test
>   Multiple bpf-filter test [Success]
>   Cgroup bpf-filter test
>   Cgroup bpf-filter test [Success]
>   Lock-held bpf-filter test
>   Lock-held bpf-filter test [Success]
>   112: perf record sample filtering (by BPF) tests  : Ok
>=20
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261020205859.1080=
743-1-irogers@google.com?part=3D6

