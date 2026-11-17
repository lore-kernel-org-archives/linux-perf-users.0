Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794946209;
	b=Jd82QSe30sGkIAs0eX+M3xEPMILlDRbifFwOFUFenvMU34YpOu1UdSWDciKC8eqGhp8D
	 SVpAXvwF4yf3Ri0mXuo61I7ghdy9ziCjWvXiMvUCQim3wK62hLjvKksuKI+yA+OG/sei6
	 5iWayMXTG8j8cwVE28DDTEztBMluLlDrf0yTM7aGl7NSVXbMMBeL6Bgv5JWfReoXQ7ELs
	 x3oKSVK3JKlzx46rJP5tAvlfg1LouqUp4X4tYvPN9uTQA2luHh6SvrP4LkjgpOktACkdD
	 SHAepoI2hwYNqNpKzBPOSfpNInxTPhJiWOdzOijehbpdVnjwRyVoY1TX52kxnJxGh9Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794946209;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=TWxZLFlRf6B37Y7rLCBv8WJE+9vInMzHNz7c4gHp9A0=;
	b=BnxBml3WTX7255AQiR3x1tnnULmfKTTCpby/HtxKoT84sttwq723mmGdhlsmh2cYXijy
	 IdkLe1yGKivIMzEuGaKdO8/VPbY+Toa7NYTNEAFcC2UAS6SQK5EuqSHwLvx26QmkhMFpF
	 TnY6HtJ/y+SQhXIhHnwTUbrvLJkFidzNyg7XNnygJBVzd6wQpKbzvq1rrF7xicuTQ/+tF
	 X2/KOY4i5X4EuxDu/NaijF4mq3S6r06oyGlrPA2/Meitv3L1jV60GTr1ZIyfidnC3n84f
	 +Ha6sq9mBJ6MOIvuI7WFO447+5wUDUivrXQg6Vvs4G8uFSix2iq82K1jn1C55E9B0NA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=N4OvyP3N;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB4DE606A893
	for <linux-perf-users@vger.kernel.org>; Tue, 17 Nov 2026 20:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=N4OvyP3N
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26BA31F000C5;
	Tue, 17 Nov 2026 20:10:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794946209;
	bh=TWxZLFlRf6B37Y7rLCBv8WJE+9vInMzHNz7c4gHp9A0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=N4OvyP3N3GSWsw2vchzHNGyGPiY9TXMOrzKNZjvS+uOvUhOfkIXYCNkXIOxZxvRmw
	 PQPr4jNDkkFoGwDP/nUO8zhYIZrialgZdZX2DkS+47apa2mEKsJGaHuuylacbMD5Zx
	 RoF6fX+LXLPgSDebfvUd7CjLCNq5TWILmmHcJf2sSdfsOStpq5RUZJGPIh0CH8uN2B
	 0BL73PP+H12A491zKcA/5wn7/CvNYdpIy2WA+qOQY7uryk0j+p0p23ivhqdDLaD56K
	 h3V7YrKceUa0QlsbELsDd6BtT5OEN79rYO/gRrod2eO64BcaiUP6oXOpCFPPZ2S6EV
	 YRdjNHMwSwU3A==
Message-ID: <sashiko-outbox-219566@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 01/13] perf jvmti: Link the agent with EXTRA_CFLAGS
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261117200433.45174-2-acme@kernel.org>
References: <20261117200433.45174-1-acme@kernel.org>
 <20261117200433.45174-2-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 17 Nov 2026 20:10:08 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> From: Arnaldo Carvalho de Melo <acme@redhat.com>
>=20
> The jvmti objects are compiled with EXTRA_CFLAGS but the agent is linked
> with LDFLAGS only, so flags with link-time parts never reach the shared
> object.  With -fprofile-instr-generate the agent's __profc counters had
> no __llvm_profile runtime to write them, and its files showed 0.00% in
> the coverage report.
>=20
> Pass EXTRA_CFLAGS at link time, as the dlfilter rule already does.
>=20
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261117200433.4517=
4-1-acme@kernel.org?part=3D1

