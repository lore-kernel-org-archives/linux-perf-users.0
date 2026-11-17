Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794909828;
	b=w1WEZZq6nFpTr2BzJ3lgtuei7SlELSOf4z4zkphOCuip2x9/xZXbUJm8rXSyUX6WaDfl
	 LJ4mah3TOgb3GpAZHKFegETtsXi8yf392ZpXSRNe9Yigyh0yFQ6DdlQ6ZJSp61TNr+sNl
	 PYsxtzHEabGf2wDbm2pZh6kB0hsjeB9VIqXqYqMLp9PU4PlN45NrxhZOyEvkO7+HjVC+X
	 RaVBoScWBXfa/zLDkX5Go52TVPEzvu05NpVh4e7KoWCbnrMdC6+pCDHr6ZFgnK0MQoUYG
	 VdUsdHN50pUcCUcJ8xDr1htMdufL64ScMOS/v6RJmBx4Nyfv3uO4MAaGJpQmP5cl1Dg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794909828;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=tNMKGT4ORbB5oyZrF9IO16MGBmMgxZ9gzqn1Rb5LaIQ=;
	b=fiJURU2/+sRk84urpS8B6m/xhCyl8OkLfJxSb/N7crJyoEJBOLg2xLDkDLuknujeJYlb
	 uivdr0oniSm/GPkP2lzYnet0xqnf7q2FlbGLAhbODfpPMlb4dfMx96aAoB51XjtCUnBAU
	 sXA6R5/3+FE+QwGZLkfi5h+dQJp2S/SvKIGf5TL7aAHw7CYpLDF/wdsbELHoA0U3Z0J/w
	 j/TCa0EEUJCnohvJwO8KR89067WiWZgwXAQGhJdd2n37eWevRI/7G4dsA+4MkwHVzd0XQ
	 FoURXZ0aYNov+QqoCQrDJO5Jhripe19tNZYyhNm7xySKy6z52+RaliwMSYe+gW20S6g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VnV3pqkp;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CECF6606A32F
	for <linux-perf-users@vger.kernel.org>; Tue, 17 Nov 2026 10:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VnV3pqkp
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 859A21F000C4;
	Tue, 17 Nov 2026 10:03:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794909828;
	bh=tNMKGT4ORbB5oyZrF9IO16MGBmMgxZ9gzqn1Rb5LaIQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=VnV3pqkpBhGEjOU3Dxl3hOd4IHjPtGkPLnKMbcnshDMnA/eyigSWvFgxbZckkNmjZ
	 u6v0Vs1qkDmlHwpgLA67VNHkyxQ/ldceLeLTnVgfzVABHKfU3VjFNuLyVceluWUY2W
	 7RQxSw2nvj/MgpZbNDaP06u98rd/Pt3SXyvPEb6RudD9Xm1pdpfA4uY7mu5euD1mDF
	 BJnziqankGYLwc0VhpTtnxdlkP5rz1MrC7KGAAUqUDYE8pAIOWgGy/nagyZRB5iQjX
	 dAmjNDQm1I+2tr18Tugg9FFHnjLcDdEGxw2xYvSNEpIocjM09VgM8bRm/jmhOOyAlC
	 02v+fZHlT/HaQ==
Message-ID: <sashiko-outbox-218566@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] perf trace: free filter_pids entries in trace__exit()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Gu Bin" <gubin@cmss.chinamobile.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261117095603.2397-1-gubin@cmss.chinamobile.com>
References: <20261117095603.2397-1-gubin@cmss.chinamobile.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 17 Nov 2026 10:03:48 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> trace__set_filter_pids_from_option() allocates trace->filter_pids.entries
> with calloc() when the --filter-pids option is parsed, but trace__exit()
> never frees it.  Free it there along with the other entries array of the
> trace struct, ev_qualifier_ids.
>=20
> Fixes: f078c3852c73 ("perf trace: Introduce --filter-pids")
> Signed-off-by: Gu Bin <gubin@cmss.chinamobile.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261117095603.2397=
-1-gubin@cmss.chinamobile.com?part=3D1

