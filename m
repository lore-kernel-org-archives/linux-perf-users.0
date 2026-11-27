Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795758512;
	b=f7qFPjcvQ4WUlUP3lB2Z8QgwNjtG9eJUav/2nRkDRdYt4GOQwFrj3QgMxxkHUBWHVAb3
	 xRXBWg60kWni7U8aJtgeIW7adMFQnzQsTAC4D7/5ZQ+dJ1s8K0o+9srkncBXNe9xqVGZ2
	 16vq2PSiTeggbR0W+hcghXfClM2S3X36yZLzagXmtVDvbNC5VsdIZ1CdprqC2gu7YrNCN
	 /GeNXVxG05WiCYpH2p5HZAEZZzAF5FbEtlSymF3V4K/558fAYpeEyv/uoTdr6las3eq43
	 /4XnDGC2Agon+1NoQ63yIvkOULYB7LmUwoMLORxFjs9boaAw/J4hLC+puocOAeu8v0A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795758512;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=ogbuhzWg1vwjvfBwluulD0K9RE5xL7WVsEqFqTsAnt0=;
	b=Ohoe+3G5Kmqgfx/bvpuRrAOC770+6UC9R8w9lkPT9x2sCFFPO3gjq9+a2nvAPYA2k5Lt
	 U7c+uzWa16vsCOEHhyJTCL9uLGS/x8LUCTI+FaK4hXRAlumB9rlK1pEBS9ODzRB1+nIty
	 oBDRynFjruhhvzNKKQQs6Z3xm0Yl6OyRn4pAqj4V2AqoHxMXMzyCtk/i7z08dlpzLrybi
	 7iFTpY5r24h8aJeBfc7YS/9NluZppQSq5r6fBEOwLb6Jxfig+UagBZxgCEGqVpZvdJAdv
	 hHWzBRzpjSxdaUmGiaHOCq49GJY9NaLlGMiYJ26tjBrMRa7EXmivSYt7e/ZrHWO9pIw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RXR1lpY3;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65270606A31C
	for <linux-perf-users@vger.kernel.org>; Fri, 27 Nov 2026 05:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RXR1lpY3
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2A401F00893;
	Fri, 27 Nov 2026 05:48:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795758511;
	bh=ogbuhzWg1vwjvfBwluulD0K9RE5xL7WVsEqFqTsAnt0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=RXR1lpY3BXFy5pbAiTgc1BXv+XKVTDipHZfDPXpc8JaAd4xvbDevcRo8fO6AcSO94
	 /TRoAtw2cclZR6UZw2ssnXJIfxf5sXuquGuVHSdWo/IMHObyoNRA5CWk+2aq7Du4bV
	 gpnQSPmycs2D8vaGargmjtpLn2DxfClVfdHf56bEnuZdxap+/GrodnvWLd5w0pXXMb
	 ioUBaHwJGc/MMKf5ETnUHgoXA5W19kvIzWMSEfXTOUAZhmyA6ZNaBu0EB+0/I648AN
	 hB4cfNqMtLRykGjGPq57SJe8AsDGp9OET7dcVy1+pu2JN5K21FoTg6jigrF7LaEVXk
	 fjVRYMt49LGIA==
Message-ID: <sashiko-outbox-236661@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 0/5] arm64: Add workarounds for FUJITSU-MONAKA CPU
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tomohiro Misono" <misono.tomohiro@fujitsu.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261127-monaka-fix-for-upstream-v4-0-3395c415bbe4@fujitsu.com>
References: <20261127-monaka-fix-for-upstream-v4-0-3395c415bbe4@fujitsu.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 27 Nov 2026 05:48:31 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

Sashiko has reviewed this 5-patch series and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261127-monaka-fix=
-for-upstream-v4-0-3395c415bbe4@fujitsu.com
