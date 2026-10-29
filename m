Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793249703;
	b=yQNs3obunDhSVwdJBzCVCM4+hugM5ow6tI8jIZTThHM/9kuHerrUlu+6WjZquHKWPmhU
	 Caes3DAYmhczex1NYNIxsThp83BGFMKPXBheGbDDMziuBPF3ytmWPxbVPX8TCzSBgHidV
	 3P9J5Utwl7FMYgAenngYcKt0dwZMQZjD7cVGAMOLVfvWEeNpb5lNp+YULvmbkn/Qkw/S0
	 V1hiMWFjjxbnLpYp7CiB7TTP5IAL0GuZXbUd+3R07JWqrwa4pLchtUffIiJFmiCx5dMBU
	 9EVjS3Bxq8978crqgguVwvRZCeo9BrA/0bhtlVRe7Fg0Ld2QerxbD7zxeZg8cpgXjpQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793249703;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=427wo7K9NMkzUoTzD87kK3Y5Z7laGwDriyHdFjwg31I=;
	b=4LhVNAOewYisCc8gxr49CkcAhH3br6RigiX23BjriV5VUtO4h6M5mxpYypt4LIJX+Nzl
	 qhlDcYy6JC/AcKoDJoExTybsu6JGIUuk+ykG4rGW8Oa8FySKEhHtKQU5JcnYpkza0mxd0
	 Cfxqgg16kc5ABDzAO97Tzxj63O0ChsseTg7UbrZqrsMlG9xZqWs1b2v03/4PTqLrBYnyT
	 cR2vijJZMZQGghNMmfphqC2/cLhWfAxTojeNQgEU9p2ZLU//6D3kbmWpKys5IaVilNYN7
	 kgS4Ycd4M966xQlgG336wsInKbIOKWjYvu5atgWdY2fM7eiGiEcbJtq/jEou1XehwMw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aSM5ysfW;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C2BE606A31A
	for <linux-perf-users@vger.kernel.org>; Thu, 29 Oct 2026 04:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aSM5ysfW
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D03D1F01825;
	Thu, 29 Oct 2026 04:55:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793249702;
	bh=427wo7K9NMkzUoTzD87kK3Y5Z7laGwDriyHdFjwg31I=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=aSM5ysfWLByl3bAOqS5gFMLXnzq2raI57F4cG/JE65DD8CufAQZL+QSDqJEvQHAje
	 Tbjtya9pxIBSq6WuMCIDtI/bOaC1/1SPBXOmrYIp6FSp2mZeDYg5/xFZ87MHV/ABSv
	 0p1dCYCVcp5GcsbRSwxNsDQyAfzxZxUdQ2WFADWpzailAgttR1qKSQKSCzVUDmrugZ
	 Lr3DAf6Hb+pY/RQqVVLt5NzM0MgQaPwf/InYPnWVGYAW49azAp3iHchvNJ6krceyt6
	 jh17L8WiuA0vKKwVtLPGamk+RYbP1snW/cXBiEz4ectR5rbDbY3xAGtHKtWTowIf7J
	 r9XMXoA4ZxjeA==
Message-ID: <sashiko-outbox-188715@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [Patch v5 14/18] perf/x86/intel: Account arch-PEBS in
 lbr_pebs_users
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dapeng Mi" <dapeng1.mi@linux.intel.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261029043914.1395147-15-dapeng1.mi@linux.intel.com>
References: <20261029043914.1395147-1-dapeng1.mi@linux.intel.com>
 <20261029043914.1395147-15-dapeng1.mi@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 29 Oct 2026 04:55:01 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> lbr_pebs_users tracks how many PEBS events are currently using LBR.
> It is updated for legacy PEBS events, but arch-PEBS events were missing
> from that accounting.
>=20
> Add the missing lbr_pebs_users accounting for arch-PEBS as well.
>=20
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Closes: https://lore.kernel.org/all/sashiko-outbox-179823@kernel.org/
> Fixes: d243d0bb64af ("perf/x86/intel: Initialize architectural PEBS")
> Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261029043914.1395=
147-1-dapeng1.mi@linux.intel.com?part=3D14

