Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792878150;
	b=BEDYMqnOBdKyxfKw2vG2Zxry6ATo78Cp/zpABOglHEmaw+htzqG8CIBnxuN/Pne9b+98
	 9k8xKw+6L9CCpWNtiDxL+Vg70h5XgK+7jo4GblpC7O3WpPgm8k7oYomTdT5QSI2tq9Nt1
	 Pf+z3d4SmkrJcLd118VOl2rJArMAZ2/aMFXQ9W3ct9HU/RfJZN8UFFZWf/mUrGE9kD0Yg
	 QAqU+wl+eHifFCgNFr/JNY5yzli10xA9v/py5I7HjvQwFuhw50dIzCSWbB0OquL9LVwpk
	 vGOQgx5l0xnAKaZn8mHR0yk6+T8v8d7zX7yx1lBsN2W1QBMzLCmNklK8jeMnycx+fWA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792878150;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=DdZ6mnfw/MZcQvl1XoKPgSMy32xBjgeiL0Du01/aOGk=;
	b=HDlaw84X8eJ79L1eOG1nzWTnuYVBLGb6HjS+/4YFp/sICjUWhQ0+5mdR8gqNngC3mlbo
	 otg9dH65+dfwrn4zuInHjzmg0osmeXOrJxOsjLvTvh7f1L+V1VHsSxtkqxB+Ssyt13tt+
	 yjyd/yZsTK28AxfZxOrtD7ZrMB3RfLuOKECd8HnLXUxQ7TVGR33HU7oP3sEYnc9Le0p2t
	 HDMTRjnw19rVFh7jvJW20BQbFjrLa2/IVPhsTZp/f4RWg7YAILDa3zgUBDBnnVzH/ifCU
	 o4IJrbEOaHrON8JZRs+GuoTqU6gsdirxf436++++MtzU+LVVlI2yxUsvMSOOK+bkBtg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gjd1iNaz;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ED79606A31A
	for <linux-perf-users@vger.kernel.org>; Sat, 24 Oct 2026 21:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gjd1iNaz
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B07D71F01825;
	Sat, 24 Oct 2026 21:42:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792878149;
	bh=DdZ6mnfw/MZcQvl1XoKPgSMy32xBjgeiL0Du01/aOGk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=gjd1iNaz2Rp5L/eT2z3M6HH0Y5irtyVVuwWfHoDZHc9g42hjADN+cbiJQHMIET110
	 KpLa2jKHJRF7YhP0A2S5X02TqKC0WciT7p1cHUAduz1uYUxGlo+RwHPJe9w9Y/M5RF
	 YNOLRBu/H+LH35j10d1QHAbAcq5Bb3bBLN86QY1YQNVyH3WIAKj6LOpv1Kve7qQ4Zi
	 kzQ+eOQ1pbWSkC/Cv4dqLAFnrM3pwbN4yqMFFHLGfGHz/bULHyhyDoU2psf70/FSHx
	 TPLPht3INNlOo8IU6dsuCaYkXhnmh07Xl7pNJRD/Jbu1J6Pw90aQNvWQZ60JD6eXhf
	 cKy6wIoMFWtiQ==
Message-ID: <sashiko-outbox-183895@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH perf-tools-next v10 03/10] perf ftrace: Support
 filtering return address comments
Reply-To: sashiko-reviews@lists.linux.dev
To: "Aaron Tomlin" <atomlin@atomlin.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261024212549.450634-4-atomlin@atomlin.com>
References: <20261024212549.450634-1-atomlin@atomlin.com>
 <20261024212549.450634-4-atomlin@atomlin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 24 Oct 2026 21:42:29 +0000
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
> Whilst valuable for tracing execution origins, these trailing comments
> can add considerable visual clutter to the call graph, particularly
> when examining deeply nested call trees or when synthesising higher-level
> abstractions.
>=20
> Introduce support for filtering out return address comments from
> function graph trace output whenever return address display is not
> explicitly requested via --graph-opts retaddr.
>=20
> Key aspects of this implementation:
>=20
>     1.  Return address parsing and filtering
> [ ... ]
>         Add a dedicated unit test suite ("Ftrace return address
>         processing") in tools/perf/tests/ftrace.c to validate comment
>         parsing and string filtering across all supported formats.
>=20
> Signed-off-by: Aaron Tomlin <atomlin@atomlin.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261024212549.4506=
34-1-atomlin@atomlin.com?part=3D3

