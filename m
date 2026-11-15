Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794703531;
	b=nkDeeNt11bFNIWmbI9BcgdL3vvltcEe2jY9vteQ3cnqGYZHlRjp+tjnEcKptmHKofBMc
	 oB1R6If+Garfy/UgircwJZdjNbkATXqvblACPukZavhC2N/76mp/PeV8TcwebW9ye5VEU
	 uVVRoKtVup+F1zjKPhICBPENHo47ZcpOBVjMNbddwsmFm2Kol9MmxO5ygoWbwawKPgPZo
	 ZEuszIfUYKSPHHYGteTMqIdYk1U0uay9SeNcwM+oE8JHjn2xexytOwVijiUKii1T4zuKx
	 1lABgSvbggcoc6a5LrtP4Lk/TDcNt1BDbeARo2B4wIOrcy5ybWQsWN8hdPLUssVPmtw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794703531;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=mdGY0dLrFy5zuXnsbrSyKaVob4y9bzHemUvTSQXxHO4=;
	b=P7Kxr9L7+0emW6S+kkgNWV2z5PCj4D9BfQ5pZ8+3rCEQP2u7A47V0SxHwIOjfdQT5n8n
	 xU9Y40Kg4nV7MrsGCXwoA0A054fsxJqUjSLpllGQRLTWcCfN0Hu9zgMedVfEUdrqLTLO7
	 ZjbU6TJphlL93NfxS/RKHsiDcGimrN8JZtTJV7eFHvsL1f8xgRE+8kY8EPYIb5aT7jh4V
	 U0O1f9z3+oBSfTBtumiHIQyFTUGSelRx+ZXp9K5fj2Pq/+3ag1dcVIedVoX05oVLzwiZa
	 0XJ67C86/+lGRK8BR1P0wOb9tMTgVrEtjwxYaEPgISUAnRe/N5QrtjS3F0fae2mlRpw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kP72h6Mc;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F560606A323
	for <linux-perf-users@vger.kernel.org>; Sun, 15 Nov 2026 00:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kP72h6Mc
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8A3C1F000C4;
	Sun, 15 Nov 2026 00:45:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794703531;
	bh=mdGY0dLrFy5zuXnsbrSyKaVob4y9bzHemUvTSQXxHO4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kP72h6McLfFeaFEwHBvdJzNh6kSXe1+3vw4TzE/fEGL6A68eXqK56bQHUGu4cVB+S
	 2+p0VMxJys4Ww7AvvnVDNbtrNAnG9cI5OvWMk9sq4iVQQuRXzW0TptF+XM56T8/z8F
	 jcisXgk6JzTTyChJUZLSiFMdG2zAlxTFDuOTGAAf61T/x+7UsereWhcaRZki5Zdn67
	 MmuEvq8E6cbZJHz2AyMR5N9NEVDlIGWLypxXDeMwjNYf5CrBMzBhm4Z3Ep7WxeBYEm
	 PoAaVHhGXa1hireTdVRe7XtxkNAtyNJb3AQ2ql7+S9XqvuQBSB/wQ5pH16fTR6GMUq
	 dWF+Z+FsUE96A==
Message-ID: <sashiko-outbox-215157@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/4] perf python: Add kernel attribute to callchain_node
Reply-To: sashiko-reviews@lists.linux.dev
To: "Lalit Maganti" <lalitmaganti@gmail.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261115003916.1873857-2-lalitmaganti@gmail.com>
References: <20261115003916.1873857-1-lalitmaganti@gmail.com>
 <20261115003916.1873857-2-lalitmaganti@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 15 Nov 2026 00:45:30 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> Scripts that convert callchains to other formats often need to know
> whether a frame is in the kernel. A callchain_node only has the DSO
> name, so gecko.py guesses from names like "kallsyms", "/vmlinux" and
> ".ko", which misses kernel DSOs named anything else.
>=20
> Add a "kernel" attribute that is true when the frame's DSO is a host or
> guest kernel DSO.
>=20
> Assisted-by: LLM
> Signed-off-by: Lalit Maganti <lalitmaganti@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261115003916.1873=
857-1-lalitmaganti@gmail.com?part=3D1

