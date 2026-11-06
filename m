Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793988696;
	b=eZmgw9l9toSaE57rkq57u4pQLzfT4W3U6f5OkuIFm5e23H7QERg3gKlX3ds5lbwmrJta
	 Ty46TBndb6bUCl9/LSIKUuy7yDj/NoiZW1kc07XOM/5HFcRFM4wYncWJ6Ffn4XqNN3rr9
	 wxC/7Cv4MKMSnGCFtms30KK388OUw+WIvIJLAk5G1yx2Pc1MOB/7RVek82v+Q4MqZb6wV
	 f1wbqqzp4STlqMop3Yzr5zu+RXBNfQh2jg6Otik61anbVjUhhXqOMn15YuO3OjdEJpC3P
	 sAR933CpIN3SoRcs5ku/l9FIsPRJrP3LNjvOvKu+suyw/cC1aq1UHhDCM06Lzmh4zRQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793988696;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=1kg6hg7oNbVLQMLV8u++hc7LnxFA10oNzc6HZPndWMU=;
	b=ZDqzOCn83kAz7ORFa7+bVNWqavXvEm4BxI+On+AHzxSXRLLkk9OF2BcUFx8eRSs+1HWs
	 PZbul7QmPl9dGNCK2YNq6yCCryEIMyBC9nz8gmEtPHbOLjLEboCPylOinKNYxdWX9CWeb
	 JLhhU4jL8efxzRxlcy2Xx/jFpOEl5IbOcdGEZMB+CDW8h+XryHdUQ3HtL9k1aME4V2QYs
	 lFrvuUp/Ts35xlZOiT16ff03bMqGELHD72WEReCMDwQ1432/UXQAnmzixlzPGJXW/uBp3
	 KluDoebsBuBlO17luqLzk0Xf4z4y4Xnbmm60g8Xtpj/vqUYvOIc/f/5noD0xFvZMVKA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TwJslXGz;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 464AC606A326
	for <linux-perf-users@vger.kernel.org>; Fri,  6 Nov 2026 18:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TwJslXGz
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B665C1F0089F;
	Fri,  6 Nov 2026 18:11:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793988695;
	bh=1kg6hg7oNbVLQMLV8u++hc7LnxFA10oNzc6HZPndWMU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=TwJslXGzdHsksGAiF4IxqURIL5nrKvoLgcpJv7blJgVUqDR9M42ZmRqfWt3yg/BPj
	 7zgVMNn5KQBqkFZJT3TPQOuAETnEfk24tmAeF1523a3ZfqObpdiyqdgZJnKhk1qhyH
	 V0p5j8j3m0hgh755wNc4fjESysAWJAJllL9v5ixdnBR/FIPjrunLrTHgmhEfvXmcOo
	 noM3AdayOrW2fLZ1SwlcC6u0djQxX2wcnOm+5/qVRLBOEVlwuMhKMGIzHr3iUqyMSp
	 hK0Oe4Z4ASymgEDo45HhJggyHA9681/+uWWDLqK6/tSJVz98v+ejYSbAzuRJ5SX1sO
	 6c0wqP0q0tCRQ==
Message-ID: <sashiko-outbox-201995@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 3/4] dt-bindings: perf: Add Arm Bus Monitor Unit
Reply-To: sashiko-reviews@lists.linux.dev
To: "Robin Murphy" <robin.murphy@arm.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <2df5b5c0185b94602429674826e058b9687e476e.1793986672.git.robin.murphy@arm.com>
References: <cover.1793986672.git.robin.murphy@arm.com>
 <2df5b5c0185b94602429674826e058b9687e476e.1793986672.git.robin.murphy@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 06 Nov 2026 18:11:35 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> Arm's Bus Monitor Unit is a low-level performance analysis tool for
> matching and counting transactions at interconnect interfaces. Typical
> platforms will have multiple BMUs each measuring multiple interfaces in
> various parts of the system, hence for the sake of usability we make it
> mandatory for the platform to label each instance such that the end user
> can correlate with platform documentation to know what's what.
>=20
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1793986672.gi=
t.robin.murphy@arm.com?part=3D3

