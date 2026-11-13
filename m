Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794548064;
	b=fnYVb0Ca5L1JgSHvpjjqf/Ee01udytKvFbBI01+VQN4OXxIUj6ctAD+JcPaJpv3KkklT
	 4roDjY/yLg8mqIZivb8HYCi0HWhcdPrkmyGCVnlC5lf8kI9hMAhyX6QubzEK31ZKttdV2
	 mbHtjdHz5BNyTB1NlbV9iRAWd6ehkMp2bcs4Hc2lujHByfFXjmKlmN7li5InZv/KVOox5
	 J8BppdhgIsxveme/XFrIst0RpnnlK3uBG3l4gGsdr0XD3Ef/eLFRBjPr9/VnBDK2ouejZ
	 +6OAsjzFEoKawK34MUmrCZrXQmDv+Cy/y6jqX96xwCXBxV6JCRtMIGy0tgDBUshWF7w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794548064;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=6IijxzSmZ981KMePaV/OjrO+sbTvZFFRqi52JgrrxAw=;
	b=dJG8eZJBY+cBbDwo5Ua/sPn/mbUnxSTG4axLpMp/tkQdquDv67sftSRRdky1IJm35HS/
	 9vLFHysiu3CyYs+yQiZDkFASMYwNa6sQhneMJWdVjWogzhaAL+JJwJ/Ey3D21lYupIBlB
	 NHVCv1TK4fHC2LRR2epyxptv/5NitOPXXQxaWGVRNYFPhP07/NB0Jb3dotWec1Qb2cEz9
	 YfEYURgHpDYpPOe4KbcFCWjV7dB6zfiFnJsyDRN/pLblKTFjvtQUgSiCp2R6n+ozrvgHZ
	 Q63vyhNKT11t9PNJBsZ0gnL7VrAtR0BHdSDmr8Z1gM7AOrOggiA4+sScC/qeVse0Q3Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NAKz9a2m;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C62F606CBCD;
	Fri, 13 Nov 2026 05:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NAKz9a2m
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC4C91F01834;
	Fri, 13 Nov 2026 05:34:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794548063;
	bh=6IijxzSmZ981KMePaV/OjrO+sbTvZFFRqi52JgrrxAw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=NAKz9a2m10VR+V5E86Yhd9+n+RurGk/nd+aJ9vi2xJROqJEL1YKqdq5oTHDezG+eo
	 Bx4vM66lu29juA3E8pb+DKYJxYYQh2Hb2Rz8n22hKvHYuE7NHecofK5G+5PodkLiYx
	 VER657uw6rmEpnJ4A1p6mEzzLb8AL0elkbIlY/8h/PhV67pBJbdI6O+Y1NTMgeCKg7
	 N0oXRpv41XZUEksAmx7GgrumehoQyFWPIercMydXG023NxAiHl9qdSYyZax2Wen1Gz
	 tKqjuAQH5Y6X1fAii66cYygIev6h65eLhpu9KYvkUzO3dYFjnOFLb/pcI+aYVWJAVn
	 erCBjImxi7XwA==
Message-ID: <sashiko-outbox-212235@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3] uprobes: Use flexible array for xol_area bitmap
Reply-To: sashiko-reviews@lists.linux.dev
To: "Rosen Penev" <rosenp@gmail.com>
Cc: linux-trace-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
In-Reply-To: <20261113052948.2668076-1-rosenp@gmail.com>
References: <20261113052948.2668076-1-rosenp@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Nov 2026 05:34:23 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Low] uprobes: commit subject claims flexible array for fixed-size
  bitmap
--

commit 1d1d15ef8335187f18a7637def6f83ac3b705261
Author: Rosen Penev <rosenp@gmail.com>

uprobes: Use flexible array for xol_area bitmap

This commit embeds the XOL slot bitmap directly into struct xol_area as a
fixed-size array instead of allocating and freeing it separately.

> uprobes: Use flexible array for xol_area bitmap

[Severity: Low]
This isn't a bug, but the subject line still says "flexible array" even
though struct xol_area embeds bitmap as a fixed-size array
(bitmap[BITS_TO_LONGS(UINSNS_PER_PAGE)]) and the commit message body
describes it as a regular array.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261113052948.2668=
076-1-rosenp@gmail.com?part=3D1
