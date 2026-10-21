Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792550330;
	b=r1K0hIEiOVcryWNqWrybR8T6TemIc2YKSJH37PdZ/v3cIGoNtH3OB9AUS9wZ/gcuhZe2
	 OcmfLoaO229utRnmb77KVTdq374jNV8wH+8Y3kaB824Atri4Gu7VMS1PfNcUUfExpIQn+
	 QjglDAAEJMcB7SlI8eDot/AXwH/bSK0sT5vSxPFDg/xVJo2nDRf8HnSEJd6x5l2dMdwi/
	 bixXnm+pjEzHyIij9+SgXfpL4Gtf3NZtdfUWvSIqqPiWkTz5uUdvUHi4vLb0o6lmCaxVK
	 XtLDlXzSMT2KXDF631mMgEF3xmv7pmX4Jt45Nkk88IQfm74Sttq3+xTRThzURqD7yrA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792550330;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=TvgKmNuzK5J3ZvYrQAixL8dJ9zUrmsU9Cv5SIFMnDsU=;
	b=xFnVaUwAi2pze+9A0mzaVmANejI2S0Jgh57Ioxttp4+Dxq4YFn0ERV5jwNQDvC91Y78W
	 YpSrjtVdMe6mYu7iN+inzwB1XwM40Gdak+PW9XEmcwMPX5q5O12MrLFKmxj27tov0guqJ
	 kNrKrhCpagAc/rORZOdcR8BAHhSczLZxh3Hh+rGgLfeZZ614tSLcfTOpwYc6YyiH9nVNW
	 lMNujzcBDYewaMnK1wjlRJZsvfXh/L2v4Ltmd1G9YlTOHSxOyw6wRMzX6viNjKeF+FeWq
	 ZXz9L3+4IoJX1ECoy2XFcwkrp8zXWdI1qRrN4SCRP7PqNfU+7kxjYsNnVw0x8t8EEfg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="YNtbp7/F";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ADB8606A319
	for <linux-perf-users@vger.kernel.org>; Wed, 21 Oct 2026 02:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YNtbp7/F
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F2301F000C9;
	Wed, 21 Oct 2026 02:38:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792550330;
	bh=TvgKmNuzK5J3ZvYrQAixL8dJ9zUrmsU9Cv5SIFMnDsU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=YNtbp7/FTtlNy+1xJ9GMILw7726iQbr9e8nfFnWNNYHHmcbcwtnf1PBQbPbOsPi2X
	 ge/sL7Ez9VGoZTAWOSD0sh3wAp2/eF1A0kV5O8jbAea6oJUSo57KJ5aFn/hq2uDRwG
	 s032AhbafBXhOawc6qtqx4lGsZpXWo568kbdRm6D4AukDk9UTOU4iyi1Vf8USgEYyB
	 Vi6Bpt14rao3YA5+ILpkJ3p/TJ19Z9IfMiHODv9c7F6ek9nixcbjfV4OJIY8WAWLwV
	 BaBQj5vHEVx5fowt1VWbYKp7uVaDWFgTE7zmv0YjfqeZeG/L4QMrHJSpseN9X64r8a
	 DFSkEscCUDj8w==
Message-ID: <sashiko-outbox-179707@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH perf-tools-next v9 2/6] perf ftrace: Support filtering
 return address comments
Reply-To: sashiko-reviews@lists.linux.dev
To: "Aaron Tomlin" <atomlin@atomlin.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261021023337.809936-3-atomlin@atomlin.com>
References: <20261021023337.809936-1-atomlin@atomlin.com>
 <20261021023337.809936-3-atomlin@atomlin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 21 Oct 2026 02:38:49 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> When tracing with the Linux kernel's function graph tracer, enabling
> funcgraph-retaddr records the return address of each function entry as
> a comment in the trace stream (e.g. /* <-load_elf_phdrs+0x6c/0xb0 */).
> While valuable for tracing execution origins, these trailing comments
> can add considerable visual clutter to the call graph, particularly
> when examining deeply nested call trees or when synthesising higher-level
> abstractions.
>=20
> Introduce support for filtering out return address comments from
> function graph trace output. Provide a standalone --filter-retaddr
> flag.
>=20
> Key aspects of this implementation:
>=20
>     1.  Return address parsing and filtering
> [ ... ]
>         processing") in tools/perf/tests/ftrace.c to validate comment
>         parsing and string filtering across all supported formats.
>=20
> Assisted-by: Antigravity:gemini-3.1-pro
> Signed-off-by: Aaron Tomlin <atomlin@atomlin.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261021023337.8099=
36-1-atomlin@atomlin.com?part=3D2

