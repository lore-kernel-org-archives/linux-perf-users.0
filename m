Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794811475;
	b=dLTRwF1s4mCGB3nTNxOI/l+Zeq444f9b7QS5spSSa4Frx6Bczq99nBxtcIMBtUqk34jB
	 HFJWLztuCuCIUluo4wz7nQBhTA5/NLGaVPts4vhGGKkGl0wYqzbWai+MmjgdEdulu9lj5
	 2aNJQNe/v16pbjNWVx0nLO0AO0vpB1hp/hZKef9XYjbsWE/6SCFZeipa5OpRz2doS6/3A
	 r0SGtozJiFJDEeKDntl8zXFvp/aLl4szZR5xjwlmBOX0Vho5UxkrgwL1gSa0VkR4vmREa
	 g5Os3nR6Loo0owAb2zi4cGt/wCCw0Z88oCtT6397EfIDjN+BIJXQ6qo4Rd1KYWGJpnA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794811475;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=RCJdFeI7wPFVjmbl8qNuYjf3ersVXKvjGTzglEIHqKk=;
	b=3erItSQ+Z95uZnyMVQkNIi9tXeKqpYgkxpH0Hm2Iee+GxYio1KNLVKhuNvPPh5MxsQuN
	 9TuIkr+2IPGawtFB0MWDgIug6AgSBF2LGmXkBZ9iSgngdmdXjiKdz1wDO/0BVEva1FI4+
	 yCgqgqmXED9HPUSG5dpHv5l7Iu/33x47uCzXF49HKJC1zBPi9U/Q4oMATtFb0FvZxh40m
	 +7mXEj7lABUzJNQuO+vBJvlRa+/PaZhFZuOzs4HLqG0317cyBc3oN4ITGpbYLw5dZILZ7
	 eSiHF+kSjVsUZbj/oPnzWO0SqYR/LTifHpA0BNKHN+FjW/7dQz9pduUMiQrw4ED80Zw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=P1chOCCV;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2674A606A31C
	for <linux-perf-users@vger.kernel.org>; Mon, 16 Nov 2026 06:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=P1chOCCV
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9FD21F000C4;
	Mon, 16 Nov 2026 06:44:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794811474;
	bh=RCJdFeI7wPFVjmbl8qNuYjf3ersVXKvjGTzglEIHqKk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=P1chOCCVoYrGId8F0ihSU8fcvDu5W9csuyxE2j2fMB+LGoCU2pFS5myabN5bEVq2p
	 CEV+KivL8sRaxSDKxP9pXRN1Zk+WEzo3c8UfDNWaOoHaTT3zB+qt4MlXc63ApJp7PG
	 382lMBXnXJK5WmybVzXYlPHU8bqF/FgHGn9T5bkhs+d73uliii/ijDEMVhoquSXT+5
	 91SypMgPRrM1Mlgs5i+Vw6mnxPK4cxajDqzfv62Xm71eTtCSnhEr1TibOMBt8ST3wB
	 1tIlBgp5JnNcR5mZ1r1uaVStL/j19SjPCwrAh4NkiaGGpkIgU38Gix/QfEVBl4krjm
	 8pPtGKcBK/9tA==
Message-ID: <sashiko-outbox-216310@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 1/9] perf call-path: Use struct dso_symbol to retain
 symbol DSO lifetimes
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261116063435.2817923-2-irogers@google.com>
References: <20261116063435.2817923-1-irogers@google.com>
 <20261116063435.2817923-2-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 16 Nov 2026 06:44:34 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> struct call_path stores resolved function symbols for the lifetime of a
> call_path_root (in thread-stack call/return processing and db-export)
> without holding a map reference. Similarly, Python callchain frames and
> nodes store resolved symbols across Python object lifetimes.
>=20
> Replace bare struct symbol * fields in struct call_path,
> struct pyrf_callchain_frame, and struct pyrf_callchain_node with
> struct dso_symbol so that each retained symbol pins its owning
> struct dso until call_path_root__free() or Python deallocation. In
> python.c, this also avoids duplicating symbol names for call_path frames
> and allows pyrf_callchain_node__get_dso() to report the DSO of resolved
> call_path symbols whose ip was zeroed. Also document the DSO-owned
> symbol lifetime invariants in kernel-doc comments on struct dso_symbol
> and struct map_symbol.
>=20
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261116063435.2817=
923-1-irogers@google.com?part=3D1

