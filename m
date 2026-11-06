Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793942275;
	b=a8O5xz1noBsDyyS7wKWuW2BBTbfWsg1hlXVmY9XOFt5CwzLcyT49xNCV5oHB6nGuNwWT
	 Gcft571Q3OhrkJevTKVIgxPzChFgFlr4xG0escOJxxj5htUKhiQiDHGLnkjnaaYkj8KRm
	 SI1hChdDB1wxHNQHKdICy1+CXKumekRjtAoJ6pOU464V9vwEAR4h3QJU8Xd6pZ8mjo/g5
	 5JxbJAqT1N03/3bI8HwY1V10tnmy40SqL0IPCor9Oc2md1yGBYcA646vWmxd7BPNA6bgC
	 DPgGX/tmOAzni/6i6NyCacRD31+gGkJneSjBvj95Edawl3uEBm2UaoWxFW/1hYL6qxA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793942275;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=oOnyTQnDF6AxHQzhuuq8QoEcaTu0a8I34F6u+UesHkk=;
	b=M+m2wTV5+pvkIepV9vJHQZFY7A7GaL4w3bEr1ZAlEHIfMa+Ur/bMvQKPbcR+2f5wATtL
	 dswcO5BkcmhTNdH5FgRNytifaEV9GAgFUHzpVt+XqnzB+KQQCrwGl/dEV5XQCb34gGkRi
	 7XDdWXmbUw+inUR0SvlFnnigMX5ui3992efpnL/7ayNUt5TikbyQb67g7pk1k6XS8rSjU
	 hmyoxltavKHwXLewUZhIuFadUxKcfSE6xX7456cAJHZyCFtg1JNZ5qOaB2tINMb902bvE
	 DQwYWAf8LyeetK2pehxj4CQmUI4QELsnXqoMB3gOlsiCQqOHjCRnmlIoLWmZf42wyMQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QbcCVslA;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C77B9606A326
	for <linux-perf-users@vger.kernel.org>; Fri,  6 Nov 2026 05:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QbcCVslA
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78DE31F008A1;
	Fri,  6 Nov 2026 05:17:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793942274;
	bh=oOnyTQnDF6AxHQzhuuq8QoEcaTu0a8I34F6u+UesHkk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=QbcCVslA1PEOlSbBGQZPugBpXW0sozPSt4XDpfvsuGYMUjQjn3Jqqwfth4O1UVISn
	 ZCaBOzGSfQd21niZiJzvKiaoDGzngZXBUUIEZ0d2QZX+Dv7GlvJ+0WTgQ7i6ZRc6z7
	 +ZXB5RKkikDnXJo1CtblaN85Ns8HIje6n7TH5TOdDBr5s0D0KZo7R2fAqYhnJYi2Oj
	 NOA6HI/IkX4apCOUrlnsNGeJoJatM7EcWRlC8UIlb9hkd74xRojZeVIPMGE8AoKjMU
	 DiJYkbLl4Ltz4lMsy7qRspUhb6usYRsTUe11DRWXRr6rdx/xIYk6dzvzblrx7E+qkC
	 0QEkg8hsOYvqg==
Message-ID: <sashiko-outbox-200811@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [Patch v6 17/20] perf/x86/intel: Clear raw LBR counters in the
 LBR stack
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dapeng Mi" <dapeng1.mi@linux.intel.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261106043257.842864-18-dapeng1.mi@linux.intel.com>
References: <20261106043257.842864-1-dapeng1.mi@linux.intel.com>
 <20261106043257.842864-18-dapeng1.mi@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 06 Nov 2026 05:17:54 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> Raw LBR counters are currently stored in the reserved fields of the LBR
> stack even when no LBR event needs them.
>=20
> If an LBR counter event is present, it clears the raw LBR counters while
> processing the stack, but those counters can be leaked to userspace when
> no LBR event requires them. Clear the raw LBR counters when no LBR event
> uses them.
>=20
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Fixes: 33744916196b ("perf/x86/intel: Support branch counters logging")
> Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261106043257.8428=
64-1-dapeng1.mi@linux.intel.com?part=3D17

