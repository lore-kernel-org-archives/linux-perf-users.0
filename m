Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794144290;
	b=IabdVDMJYAnm+8jBa/V9lkRLTjXA8zpJ3BypqHFhB8o0jmvOymVP9FYSt0oTGsAvEMF7
	 cp9pWFWl6IhpX/y9sxzv3aQRpRb4Vw60ghQMGeogVquWe3dnJgBmimdbjGK1HnluQ+V3j
	 Ci4RPyewYaWyV7J7dd8v9hc/ilEoFmt33KmhlbTLbY5qBSIXyaRG0LoLvlgXakjHjqOcw
	 u+OxkJbVJl0OIi15mjuEq/8DYo+cyncpRAlDwEBKvWG9tVy6pRfEPA4sNwUZxsrju51i5
	 zpKfMkgDcg5d5AcXvIpTjCrOos1upF8PGk1Gu1IsfXSP2BY0aisQlPgUDiOkvj9yXqw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794144290;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=Or8HOQ+FUHumsZGwHSU2tgZkhlm7jJ1ipJ6DS34uNzs=;
	b=eRWNT5keh0fzfZZoW8dNoJl3bm5ro25giJkUJ8sCNu/+SJhMpTSZ+FfeDUVeKCbhYHyI
	 rrh2ofyTPxfLHQ8CYbbx8ubVfbeei3+MvWqD0OUkU+uWSGlDMo0w1ig3m6E1is0FOH6eS
	 L+XvKObgumbuTPH0Nhdsai+bkcXw4WW4uN8xM3Xz8W6G2VD7tuGVZI6OrcZEeHkUm/5XD
	 2VFpkavL5Dykeb4tRhU6F6wILgNfEaDLf8/nZPSYdxV55ISFAQ9aS+e/mECPIv+Bw3YAZ
	 MaNrTvHxPzzmUGf2EBJHs5mnq/7x09aLnxr7mXVNIKY61rLEuMCw0JyBqvbazYSfO2A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=a8xbDpCi;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11DFE606A31C
	for <linux-perf-users@vger.kernel.org>; Sun,  8 Nov 2026 13:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=a8xbDpCi
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73BC71F0089F;
	Sun,  8 Nov 2026 13:24:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794144289;
	bh=Or8HOQ+FUHumsZGwHSU2tgZkhlm7jJ1ipJ6DS34uNzs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=a8xbDpCiqbxBIZc4/FvoYyeM74505rda4TeteEv4Gv82IZD4Q4wftRWw5Db5vZxjx
	 oToaoma6i0gpEmYtBj12luBhOe7qwcERTU6WQ+brsIHFbqkJvKaAKKstVqK4ec/bks
	 9VEuB3BizBhuoBTl8rYrIFd1b52QA8zTYWD0CNDPWnjDiF5W/ndJm9C5gyj5p9+WXi
	 ahVmhlXIEHjbQKQyf9d/pHlQR/TdhcmqNTlyj+FVwVRovFcfCsvjt39tjek5I6f6ku
	 zmTJfuWUo2MFdMYEtVH2opC2ot+sZcZpfxXyp29pKYXEf0rKu+qxDPtKKW2rEU+XM7
	 vn1cy2tiEB4GQ==
Message-ID: <sashiko-outbox-203778@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 5/5] MIPS: eyeq6_defconfig: enable the CM3 PMU
Reply-To: sashiko-reviews@lists.linux.dev
To: "Vladimir Kondratiev" <vladimir.kondratiev@mobileye.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261108-i6500-cm3-pmu-v1-5-bd119584891a@mobileye.com>
References: <20261108-i6500-cm3-pmu-v1-0-bd119584891a@mobileye.com>
 <20261108-i6500-cm3-pmu-v1-5-bd119584891a@mobileye.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 08 Nov 2026 13:24:49 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> Enable perf events and build the Coherence Manager 3 PMU driver as a
> module.
>=20
> Signed-off-by: Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261108-i6500-cm3-=
pmu-v1-0-bd119584891a@mobileye.com?part=3D5

