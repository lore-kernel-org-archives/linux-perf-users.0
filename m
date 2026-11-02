Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793623009;
	b=s9D4tvrs9bZeEEkE0xp8btyzg9pJhuq4AVhQyeb1w0zqneVtDksfhJaF4daazq71RY5q
	 5vXuSyZksGIeGkWSfAkootcXBTU3ct2bPA1IGFoEvvhVOlA3YGW5mpXAtT64Poxny8q8j
	 95NvMVqiPfWMBgeZsJ2Q6aIW6475WdQ8Vtb6pxShO5ncN6T89zeny0ed9Pz7pzoWjVRix
	 5/tt3q1u2+65Ka3z3x1pMtXX8Ko/BCf5RpxmAgDDom2HUKcvOq+GNP2ji7geom7K722iH
	 c0b1yK8lZhwtAD570S/IGPnbG6vQoYQ94Q/fXDMxEWKF79Mi0hXyNB2f2FcpSQ+gNUg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793623009;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=GlYiu+FzGUQ1W5PUz8vArm6wBxuPTklztAs4tQdfaLI=;
	b=nppC1VNd2qWAJWdmxYH9IH5/RGnUrT/FOypjyNSzWxFL7DmqGAnQjS/cfY26eiUmeL8Y
	 3P3bUe8AZxu+2/hRDayN1C+N7QkvDDZFa7RZr0SkRuYxUGydEEx9dQutKwZJaeSa1peSD
	 qUn/8AyT14h3EIEuVcDgL8mFO58W1/Z5rcrmaBHkEn21n9IF3dsucoQaEUypcYBKo4O75
	 NbGVwb6UPXOfZpx1jVlCB+Zh+OSf6sE3b7kRcOVqbLzg4IbnO7v8OfrmDYRUgzLpK6Qg9
	 4mHrVJLVFGErSxtL6dVl5uA8KbqJiMU7oSIGgxm3k8mccy0/XeGAq08u6FAuYjJ0RlA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BsXC0vjD;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66C2C606A326
	for <linux-perf-users@vger.kernel.org>; Mon,  2 Nov 2026 12:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BsXC0vjD
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E560B1F00A16;
	Mon,  2 Nov 2026 12:36:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793623009;
	bh=GlYiu+FzGUQ1W5PUz8vArm6wBxuPTklztAs4tQdfaLI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=BsXC0vjDeXieW1HeCStprPdyeP1I6mATO13sznLMeIPARUpiXCRFrR2fTHmH9JkPS
	 wMvSOeSdKKe0oUsyUTBTp0QMzSpFpKXtozSWonjbsaDb7PUtSk+4t1cxUdkSWODxHf
	 HLK5dSRSwXtLi+RIEjLqFIRIX/0jXuwQ3n+OUWomZCy9nrjL06OY3AsLCq3B58xtP5
	 BbTL/PZ2EuEZCOmU9Y/4pTUHRX7xSIOUfEsljAh4fA05DYrlmNWE29cDxn1P9UnxkL
	 Xq113iYBddkJw5y9c6RDl5pRoJ4dAtjwDJWe0MEjOQVubcXWchAyqVKrqPk6iaWFGN
	 z/u5R54lLysWw==
Message-ID: <sashiko-outbox-193429@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] perf test: Add LBR call stack branch filter test
Reply-To: sashiko-reviews@lists.linux.dev
To: lv.yating@zte.com.cn
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <202611021227.6A2CRwkO000175@mse-fl1.zte.com.cn>
References: <202611021227.6A2CRwkO000175@mse-fl1.zte.com.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 02 Nov 2026 12:36:48 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> From: lvyating <lv.yating@zte.com.cn>
>=20
> While debugging a NULL deref in resolve_lbr_callchain_sample()
> triggered by "perf record -j stack" (fixed in commit
> 4626d370ae89b8af4d46a45372b269f926ec662d "perf machine:
> Fix NULL deref in thread__resolve_callchain_sample()"), the "-j
> stack" filter was found to lack coverage in the perf record LBR
> tests.
>=20
> Add "call stack" tests, sequentially and in parallel.
> Use a 100% empty stack threshold, as with ind_jmp and ind_call,u,
> since the stack filter is more restrictive and can leave branch
> stacks empty more often.
>=20
> Signed-off-by: lvyating <lv.yating@zte.com.cn>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/202611021227.6A2CRw=
kO000175@mse-fl1.zte.com.cn?part=3D1

