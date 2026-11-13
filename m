Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794552973;
	b=kvBNjb5cbGCutixmhS5Pl1Tkqc0/JnK/o4nPrc47q0L2sAh/asyZeZHAy4zyW1Lv/bgT
	 GQdZefBGZWvoAMXxxWREVb/W6ttfAHTu16A68OP84GZ4ZU26VLudSpYzMBKoVsk3kJMvI
	 jsG3o6CotG0x/pSid/5wu4ucRbdLtL+rmE1n/ly+eB5BQTJEJPiVWo0uzxn18FZwOgFyD
	 fneBoFDHjAeq5eRRbB/BUyg3HJL5/hAYg7tYoEp9PNuHyfA8mI/gOVTqc0KdREdC1kNls
	 SIFjoo0FwiiQECtoVNTyFzrqEv0kg2XH01wwgTBfw1rr4/V/jA3nNvd5tp/0mVs+uXQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794552973;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=kbn8/D7s0G3G+UckRaaF8vWaT8cwfiYN5IgbKji6buU=;
	b=jGGi7po4cafZqCdE0ZyjqBoiGDQpIpi5lXbE8y0jrdo4Heug/uP1Aj40UPPpyQ5KR01f
	 lrPPp4G5C/p0zHtQu1w8u3WXvzoSx7Mz39PFn2lycDVpy7OPM1zzY9URtFjMLnL8zJA9A
	 IoMMAP1S97WOsAyVh5n3Is7L3FmJemdV6eqwpr16CQL2YE6ZvG8zn6QSvkyHm99kAp5/n
	 28dW+Q5TFmtbXuLYePDoys7NyTHgGJB+5VWujteYtqgu6TFFCQ9+fkG+fQ/gMzW3CaMDj
	 iPYiZyYV/M+DieP39G7SHwqtHYl0qDly7OYRI1HIJKeVOSk4yz5eK5g+MkAweET3A9A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KZJcTrmR;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69A2C606A8AB
	for <linux-perf-users@vger.kernel.org>; Fri, 13 Nov 2026 06:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KZJcTrmR
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCAAC1F000C4;
	Fri, 13 Nov 2026 06:56:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794552973;
	bh=kbn8/D7s0G3G+UckRaaF8vWaT8cwfiYN5IgbKji6buU=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=KZJcTrmROdlrt9o77iXlHhDiopKemKG0IqAfQeeLvvem8IsCyynRcpuvVO6+8Pjyh
	 vWKCNe4sYe3+7eNSqRt2iNOKGITHkqtsPMApMuSGpfKAyoZAnB7ECf+YTFYw+5VF7l
	 mqtYWnBE4e18Ug+AiHsSQPj9nM3pC2BO84agmMNN1n58z/mQk6B2kaXcM1jDC/OYXc
	 3WfjomCYQcoiRdxvG19+xA++AF4jiLQ76rxEwf0dyitptuxUxwSqEbpF0Kn48Z7FNC
	 FS/3DLYCE4HXlmFITAlVZGFfw9/K2yWHvuDJRHEtmwDPCJO0wOKENNFkIIyqxb521x
	 Vp/iFKyQBc2lg==
Message-ID: <sashiko-outbox-212298@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] perf vendor events arm64 AmpereOneX: Fix misspelled
 PublicDescription keys
Reply-To: sashiko-reviews@lists.linux.dev
To: "TAKANO Mitsuhiro" <takano32@gmail.com>, linux-perf-users@vger.kernel.org
In-Reply-To: <20261113065253.746615-1-takano32@gmail.com>
References: <20261108183846.3804875-1-takano32@gmail.com>
 <20261113065253.746615-1-takano32@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Nov 2026 06:56:12 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> Sixteen of the 28 entries in mmu.json spell PublicDescription as
> "PublicDescrition"; the other 12 spell it correctly.  jevents.py reads
> only the keys it asks for by name, so those 16 fields are dead.
>=20
> Fixing them does not change the perf list output: every one of the 16
> entries has a BriefDescription with the same text, and jevents.py drops
> the long description when it equals the brief one (jevents.py:405).
> Running jevents.py for arm64 before and after this change gives a
> byte-identical generated string table (1580383 bytes both times).
>=20
> The file becomes self-consistent again, and the field works if the brief
> text is ever changed on its own.  No text, name, code or expression
> changes.
>=20
> Written with Hermes Agent, an LLM assistant; the author reviewed it and
> ran the generator as described.  perf was built, not run against
> hardware.
>=20
> Signed-off-by: TAKANO Mitsuhiro <takano32@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261113065253.7466=
15-1-takano32@gmail.com?part=3D1

