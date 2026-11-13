Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794591079;
	b=iqCaKtJVSJus7o4F64NBFnGef7I/nN9j6ViHLmb0Sa//Yzq6sKWPa+n+1d2rsVd32i04
	 7nYnLNtiCytgj/4DRCBj+/IsEgH5Y+p2a+UXG7WY9d0r8jSJWk/oVkV6ton/Syv3+LyCh
	 1LBs9TaH6kSeJeiRBczOdMGg07R+01WDH09YZsZMYaXb2tgoy1hPbj0qwtoEPxMsd5/gD
	 LsK2KstuFHSErKrSpN6WAuIqWv4KV4MFNjG86w31Hiav6wy42CQH+Aej0p/alE2BygE/y
	 SY4xxlKmojC9j2/6k7ak7pc6qMn1Q3CyZBmb09htGAzOk8gok3WJJudbfADWwvW1shQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794591079;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=2Jc7JvVZndVI8Bk9h/xjvwEF0vi4+1yR014HehHrFTQ=;
	b=U3nUuc4u9xg6kc8T2cuuiucZORfE8LGmta1pV8GK6k8OZ2LrlPFuaW7CCVoqRfRklV10
	 7nVcU7xuGMTdSc4mqIeNefQhocDPjwx7lBeLuB15JMtfG3z/ficw5bN5dw2n0wC4L+ODG
	 sF1AFN4h59fpdIHbph0XYfBvuEOFN3VtRnnQIoC2IubJ386C4peVbXvA2qZUbVCmmuYBh
	 UgV5sK3Z0iBiLmY22E79XPTWpJeesEWgRynSuk2IVMKWrsxX0fKctDu/kdoJODbl7H9kN
	 RQgfuKxdwW4ZmhZgK5ksw9Vtg2rJM+MabfXN5WFKiA+ai83nqFPmIvO8jMpSfK7LtZA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FdRmeTHk;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83C99606B836
	for <linux-perf-users@vger.kernel.org>; Fri, 13 Nov 2026 17:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FdRmeTHk
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D72B1F000C5;
	Fri, 13 Nov 2026 17:31:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794591079;
	bh=2Jc7JvVZndVI8Bk9h/xjvwEF0vi4+1yR014HehHrFTQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=FdRmeTHkHPAb2PB5GBEDlkgEODfnpJ3W0UeBfK884HMIxCoxqYKWsiQBNzfEX/Fgn
	 r+hlfEgm7X9MutYtBSRZVbspIfLHpmUATVUGc7y0up0i+iF0B29DA8/gdZpVh06B3F
	 LubnaBYofE1CAVnVAqoEh2Z79TA1GrQWg5/2Q4P+ME7fI3LMCCav4lP0kXNPolUJ1b
	 z1b3B2GRnNWPdNwZ9x4cBL1pligWlX0bF3apZB/ncM4sujjZXZwxzTIpEsHubJJhwD
	 q6Nvunjjz24cFHvH4/tAgFGS8kN+0LwyjKeua2BzV296wtbQG2kg2JEYudzQN4R8Jb
	 AfSI4P91cc2Qg==
Message-ID: <sashiko-outbox-213317@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 04/23] perf map_browser: Fix browser index heap
 corruption by computing on demand
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261113171734.2188066-5-irogers@google.com>
References: <20261110220803.2503416-1-irogers@google.com>
 <20261113171734.2188066-1-irogers@google.com>
 <20261113171734.2188066-5-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Nov 2026 17:31:18 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> Commit 259dce914e93 ("perf symbol: Remove symbol_name_rb_node") removed
> the 24-byte symbol_name_rb_node reservation from symbol_conf.priv_size,
> but left symbol__browser_index() in ui/browsers/map.c subtracting
> sizeof(struct rb_node) + sizeof(u32) (28 bytes on 64-bit) ahead of
> struct symbol. In 'perf report -v' and 'perf c2c report -v',
> symbol_conf.priv_size is sizeof(struct annotation) + sizeof(u32)
> (20 bytes on 64-bit), so opening the TUI map browser writes a u32 index
> 8 bytes before each symbol's calloc() buffer, corrupting heap metadata.
>=20
> Remove symbol__browser_index() in ui/browsers/map.c and compute the TUI
> map browser index on demand in map_browser__search() by walking the map
> browser's symbol entries when the user searches with '/'.
>=20
> While this changes finding a symbol's display row index in
> map_browser__search() from O(1) to O(N) in the number of symbols in that
> [ ... ]
> overhead, so remove the verbose > 0 restriction and allow '/' search in
> the map browser unconditionally.
>=20
> Fixes: 259dce914e93 ("perf symbol: Remove symbol_name_rb_node")
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261113171734.2188=
066-1-irogers@google.com?part=3D4

