Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794009132;
	b=pk4NX0b+cZBcL5aFwlWZfy7NW4vNpN5g26V/wqUacPPqLdIFptfQ3SDyraiHlgle+pwJ
	 076i9vt31QAVii9d70b+5G6/j7utW7qGQiipIiua8VGWIUH/rNb8qIRQO13LeOzWm+Xv2
	 8F1T3yY8qq5w5qRlFC8f8uT46Qwd6+Pg/6cAW7kyfoDpkBS7Rh7ko25oqyuNYjPdroFGH
	 zvwUlo00a/mK3QphkC84ezF58WwzdyocyimOyQ9JgpUdUv7ivejUsQvuEdnFWavSum1Jo
	 YyHQJk+X9f6LFEvVtge9wo35bQ8xgUYYKA3lWYN/JCw8ltddmlvtbg3co7yXJmquH7A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794009132;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=bElC7m3z/oP78yokV3nnz4OuEFaEydNKlCF3noIVrrk=;
	b=lRe8sTGa2/stYZaohCElmrC0yVIz842DtQTtSGBihrkpQ/2JwhOAv9B8v7KObS+3fK7T
	 k6bSK1UHqEuW7TjRmN6+cS1gNs9DeF+y+IISfs6XqjGeBCsU7Evl7942Q1lZ1lPoS+8Rq
	 TzG6YpFk6W8VUs2ERzk7gsJIuAvxUXsnhEvt355rzBeeHrYbmG8BY/e0rsEbfSJU3jMkr
	 jWJXwCHfEcVkKl96WjP+bxzEPKx3XCrA/P/k7BpD/pLKVsZIsLb0ZTyO8XgFTCTaf7bG3
	 uU3jrAQE3DSgj/mQ4ycC+H4oFPU4eDYUyjVmNc/MzAZK9u/+7DSaEVBC/BrSBkcrUHA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cMd5tjY7;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90A7C606A326
	for <linux-perf-users@vger.kernel.org>; Fri,  6 Nov 2026 23:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cMd5tjY7
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EF851F0089F;
	Fri,  6 Nov 2026 23:52:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794009132;
	bh=bElC7m3z/oP78yokV3nnz4OuEFaEydNKlCF3noIVrrk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=cMd5tjY7szHAfWJbWQSEZK9UdFe59IP3jP3fZqDHof7JaLiWtxb2D5XTv/2MUVjKi
	 dpqMdqv2fjfvhZV9W9eTu1HJTcUU388nYE3QcoLbxOvQemKk47NOsRnKk3l5LAxEYy
	 ve/0EDIkJCDAOyd72CP1yxUOAIQcGX0tweS2xcOcXcUb1VkBIH4sG4KoJozHe9YFu+
	 sfg1MoBKb+8lnxa8YY9B3Mh9KTPBnp1Af5m5JwVwT0Y8HojSgkXlV7BEUpef4/IMCT
	 aWj3gD/bR9hTbUukAMSTbZR9f++larGJkuzp820E/rtXnM2pxwdHxpjHWlb5fSVbdi
	 wAQ5UB0emi8ew==
Message-ID: <sashiko-outbox-202392@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] arm64: perf: Fix the userspace counter example link
Reply-To: sashiko-reviews@lists.linux.dev
To: "TAKANO Mitsuhiro" <takano32@gmail.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261106234551.1474417-1-takano32@gmail.com>
References: <20261106234551.1474417-1-takano32@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 06 Nov 2026 23:52:11 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> Documentation/arch/arm64/perf.rst points at
> tools/perf/arch/arm64/tests/user-events.c, in the text and in the link
> target, but the file does not exist: no file of that name is in
> tools/perf/arch/arm64/tests/, and no commit in the history leading to
> this base has added one.
>=20
> The userspace register access described in this section is covered by
> the "User space counter reading of instructions" and "User space
> counter reading of cycles" cases in tools/perf/tests/mmap-basic.c.
> That file is the only in-tree userspace test that walks the core PMUs,
> pins the test task to each PMU's CPUs, and selects the PMU by its type
> number when the kernel accepts the extended type.
>=20
> perf test -v user runs the four cases in that file; the two reading
> cases ask for user access through config1.
>=20
> Point the text and the link target at that file.
>=20
> make htmldocs does not fetch external links, so a plain documentation
> build does not report it, but make linkcheckdocs does.  I checked that
> the old link target returns 404 and the new one returns 200.  No kernel
> was built.
>=20
> The edit and this changelog were written with the help of an LLM
> assistant (Hermes Agent).  I reviewed the diff and the reasoning, and I
> am responsible for the submission.
>=20
> Fixes: aa1005d15d2a ("Documentation: arm64: Document PMU counters access =
from userspace")
> Signed-off-by: TAKANO Mitsuhiro <takano32@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261106234541.1474=
324-1-takano32@gmail.com?part=3D1

