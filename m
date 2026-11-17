Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794941553;
	b=dazW73jmsfO7lHCTOb3YdPKOdbrM8jYoWYMm+/Y3AdoK/4ccLTZ6wMGKx3O5ptmGN6Xf
	 hIRx9CoXTGa0+iEUXMxGF64RxRBRatauEjSiV0ZQPHofSK3ZP53r3DoLBSETrjDyX1OkC
	 uPf9hT0vHYQPSCQQlmLREHEaX+a/XkJ8Yi2Y4+MltwTkG267NNzWtYwJYSl9Z+MM6pvZO
	 q0AR0WZr2lIpZZvhfN7EXAt7lXeafqkASHtuQHjitIYmdy3KKIFa4/uEMh4QTNHZ5ohT6
	 odZVfzR10czBYz8DazuHW175PyiekUhCDXio7rarWzxt4WoBJiHM7MAa0PIV4prw1gA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794941553;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=kkceuyQ9y/K25PpDHMdggZ4cLrtGr3BBrsmHjfzMGAc=;
	b=5Vo3bcIBbLbq9RCxQF0J4nTJ5N7zDKZqEx2m+INhBmprUdaG1f18mnMcQBM7ygkEXu0T
	 jVPtTxq/qSFHeyWFN+HRHJCOJN0inNSjrLhIIhjQK4uh8kZw+z5J8eLc48ZdG1CaJLqlp
	 F0R9jwEZHFtJ9jFK+vR3YE/s+9mwt+bE/U++WbkGkEDu/EesdFg1OIplq0T9PxDtuQ6J/
	 x8UAuszkNKcuWtuPhreNILOMZb7s9nxe8n+N2c/vokKlMA+rDxPdVxSAWhaQU1445olaa
	 caYtG287yinuTemvlWlnu56VOKXVaNQ1ArT3BbK+3LRdPmG2nZm+caXYeK6D9Ig4f7g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=m5kAhS3j;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 088B7606A31C
	for <linux-perf-users@vger.kernel.org>; Tue, 17 Nov 2026 18:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=m5kAhS3j
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA0BD1F000C5;
	Tue, 17 Nov 2026 18:52:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794941552;
	bh=kkceuyQ9y/K25PpDHMdggZ4cLrtGr3BBrsmHjfzMGAc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=m5kAhS3jBG9gwxczAWVpMwlimMTSa1lnR7d/96CCJk8o24u51fRJ/yGSn8oK4LQeY
	 JWJBtuAq2Y+n7ipuR0Icn59neiAf8vVO1Viuuh4x03hvTXpPF+WWZqCYZfNSAVjFcp
	 3yopEI/zCrIyy/l6RQR2s+hkg+LWi1G01ghY/HnZtCPFs8zp2Ita52W2hjJle7K1ja
	 Xqlg7/fllMKJbdKrj91ABqWl9fi2sJbFmVmkxWtgLaiH8yYnwEFWU337E+iI51EwDL
	 v4Q+mNi/NOv9+XsF69aCt/+U1MImLpt/Jrm2SUEKZAwVW+kaFYCkd0VUT2tWjAYtX0
	 Xg5/uiYZ5bD6g==
Message-ID: <sashiko-outbox-219394@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v14 11/23] perf dso: Use DEFINE_MUTEX for
 dso__data_open_lock
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261117184844.99889-12-irogers@google.com>
References: <20261117184844.99889-1-irogers@google.com>
 <20261117184844.99889-12-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 17 Nov 2026 18:52:32 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> Replace _dso__data_open_lock and its pthread_once() initialization
> wrapper dso__data_open_lock() with DEFINE_MUTEX(dso__data_open_lock).
>=20
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261117184844.9988=
9-1-irogers@google.com?part=3D11

