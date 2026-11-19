Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795053319;
	b=otB7xJx2Vrt/D992GnlFlF0ryL/6b0gHAJguGTkrIGHfUsFTUJWSb5KtpTwDth+Qd+KA
	 CDVJtpigO+nRmZLJ0O4pHLfB4PZE1JGZegyVbvT4mR3Isw7NOyeOdSK1CRP3rQq8FEwrY
	 bfoQ3OXkeXGkFf1q6vLZ+tiOJAhFu2fvyO13R845DWiM8oEBCRMOPjjrBXYv80PEgsbQ0
	 9C+RYCXiMQ7DeeuCFjiO0zCOSwJi6EUHJHQc4+vliFP3TYFWDn/wNtFyq9WHaXpMyG1c3
	 pnuXLD6xL4EVOc6UetHKv1WPF4KRZx/KOuZ2aHDTDKiFQ0LLQC02gVOvtrQWbmujM+g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795053319;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=RYvH72mfIJi1SK3fBFEl9Go0nFd2Ow1hRabUPObxPwk=;
	b=mCdtrvm5h8Lv31TGjGMdNz/aOHgV0XLeYKxnkLQyR96i9NTZICe4oU7qXBPI6x6gPy8Q
	 vT6wv3tMNygqmVZqOKV1ILjMHufbiAkXaEvGf+eF9NUA26UNriFnpOF6h20K9vyHpqN2h
	 FwyXB9SzZejJ+gFDwEzJGGlP2FfFi4MxGA/OvF64du+RUFHd06/7PN4s/m/KqB8rDes5s
	 uMbM7ZGJg9g8Zas62LEMSX6dbveQQQxAhbO/6I/kUiDIoI0SU0MsDyrL2PyvbWwnEOlSx
	 gogAIqLvfR8uAlh/Vy6ufGGBeWwClFUodUMA49Zppzwz5e5b9uPtItSfdSImDpbR50g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oVCSaFnN;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6223606A320
	for <linux-perf-users@vger.kernel.org>; Thu, 19 Nov 2026 01:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oVCSaFnN
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BC841F000C6;
	Thu, 19 Nov 2026 01:55:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795053318;
	bh=RYvH72mfIJi1SK3fBFEl9Go0nFd2Ow1hRabUPObxPwk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=oVCSaFnNkjsgVLOPJLOMzRAsdcqZ87ys4Zt7sp1IdP6EgpgIMy69JX2azRvJpdcNZ
	 K4shiFsCE6eceYLR23J1Rf6giyM48tAQMVlaosJcIiLop0bFhUyRBbI/oBAu956Ma6
	 wRUwBJSTBCdLvkeIo9zkmJj7roF0SIOf9hA0agt/QZ7aM1AT6cwGt4a9yxECVtGdHm
	 VAy5OV24pJ0Yb7hXAed14ljq78XY841p7VtMUDLRf+yg/Pu58SPYVnw4V3FSiDI55p
	 dgrhR3ztEibU2EPnEOYkW5Z6D1WoNjiAyk9D6nii6lqpbUpRVjIAJquKuI6MxOGxSA
	 0OEgrg7sQVpnA==
Message-ID: <sashiko-outbox-222306@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] perf: Reject group leaders detached by CPU
 hot-unplug
Reply-To: sashiko-reviews@lists.linux.dev
To: "Daniel Wade" <danjwade95@gmail.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261119014730.2074-1-danjwade95@gmail.com>
References: <20261119014730.2074-1-danjwade95@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 19 Nov 2026 01:55:18 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> CPU hot-unplug detaches the events of a CPU context but leaves them in
> OFF or ERROR, so once the CPU is back a detached leader is still accepted
> as group_fd. perf_group_detach() does nothing for a leader that is
> already detached, so closing it frees it with the new sibling still
> linked, and closing the sibling is a use-after-free.
>=20
> Detach them with DETACH_EXIT as well, so that they end up in
> PERF_EVENT_STATE_EXIT and are rejected by the check from
> commit fa091f46c383 ("perf: Reject exited events as group leaders").
>=20
> Side effect: poll() on a hot-unplugged event now reports EPOLLHUP, and it
> is refused as group_fd even with PERF_FLAG_FD_NO_GROUP.
>=20
> Fixes: 226424eee809 ("perf: Fix corruption of sibling list with hotplug")
> Suggested-by: Peter Zijlstra <peterz@infradead.org>
> Signed-off-by: Daniel Wade <danjwade95@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261119014730.2074=
-1-danjwade95@gmail.com?part=3D1

