Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795838318;
	b=jEkQCfmGVf6/4AxwE1G1lvFstrobdvB58kObO1KH/XI0cg5/QtA9GiWEwqX1CpUmRBwj
	 Kua5tiGt2ebAfKjXKw+xOAIkyBTKsbU+5D32gRoLSXBtt+Px0qce7EpkHVNSk/RUNLxvn
	 HiwZ3H1QiJmeDQQ4BeSO+X2+F7J/cD0bwT9rwSwLOIgENyVxya89OVXB+75n/JjM5CHD7
	 rnocUa6T/i8VKliIisjvlhZi+EdTSVa5shkT+Vhs3bUmmNA5qIQ4zj7bzTPLknt/xZo48
	 QcP0ht4j1ZyzdcBU1J/iUI4oqiGaXAZhUMoIqhOnQIKey+LgkYWsQNpCfkeNz37dGQA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795838318;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=8+/UcxeDQBgdGn6fEh4Q2j6NPlO52qJyC9nWhiHi6H0=;
	b=mFt3+FUYxhrq++8+Hfu8ORMel6mp7Kh6kcOPCffFT2QjAZ9s/vDQj0Cd7o+iUmRGKNah
	 hUAwIyJ6zjbrew0FwGC1sxuKOE7IwtLfxx6o9zuO9f8je0VFFLMM4nk7EoHal9rBCtjHj
	 e03VR+w2aqivtAcK1rTcW8kEZ+MBTkYRLk8E3qGK316R30ADNb7xDbl7QXSHnwTwmhmxA
	 QAyCXcZSJlFs8KLo4MrFCXZk8PWsrPycM65Z59nv6MjbRiCwwPBBxrwqwHzUxFhTzDlG9
	 nuEjUlgaa+RE0yX9sHPpcCJ4mvAq6p7lsuYX4jDFoQ4ni8y1FUaeSuQ778zkKvWJWgg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jGkGoZhA;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06731606A31C
	for <linux-perf-users@vger.kernel.org>; Sat, 28 Nov 2026 03:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jGkGoZhA
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DD451F00893;
	Sat, 28 Nov 2026 03:58:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795838317;
	bh=8+/UcxeDQBgdGn6fEh4Q2j6NPlO52qJyC9nWhiHi6H0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jGkGoZhAJ1sPwy2q1viCc2CvVmhF4BWrdHSCG0ElHz5vK11jWuN/bVNUemNbUFPMI
	 T3RXjfq8N/IqXVxNOCm7OVNyYw1xt3MqeLU5t4/04w3V4SWhG1x7NWZ9jFtIxvw0wU
	 a4F1Rh54mvJ0iSy1vD4FEuL/s3QZwahs1AWltLIoX6uuycJRyGrgJq6LN+ORgD556S
	 3xK9aWEvPaMQjU5Y5sbhkRkkAIoeHXd+Wo/Gac9rhULo7/3doOyELKAHB628VV/84t
	 JY5uRSO7bK8D8DA7Pq6K8MaHrtCBacOA6EbDd88PuBc6mFpkN+p8cvksrvhZQRnA4j
	 4y09Q/tSiH6Ng==
Message-ID: <sashiko-outbox-238445@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/3] dt-bindings: vendor-prefixes: add phytium
Reply-To: sashiko-reviews@lists.linux.dev
To: "Harry Bit" <idleassetsd@gmail.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261128035504.760778-1-idleassetsd@gmail.com>
References: <20261128035504.760778-1-idleassetsd@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 28 Nov 2026 03:58:37 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

Sashiko has reviewed this 3-patch series and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261128035504.7607=
78-1-idleassetsd@gmail.com
