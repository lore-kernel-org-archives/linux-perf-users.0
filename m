Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794261998;
	b=XoYdDH0sD+/Yu3WNyg9/oJDfRo9wVD9eQs33TajyqWiFhKKLRhunOG6c5Reg9hAcOEvy
	 S4HL5pl6+NNXtsbNy+8o100EEOuE0Y6sq98i78hfQSjI+SxJzrFClaGv+HLgtjulqhsC8
	 4m8KzsNAZwOY0Da029J9nxWl28bSN7KcXerQv/lZu5dkl4bI1BEWB+EzuUWPhJ2KTxTz/
	 /91bRaAyTtuzIbVq5kYRf396ZH3kE9IEeuYzIbLLY62CUDFJUTS5x2D+sP/qA0TB/ZVaM
	 6mkvbRRTyK1NHp5ygUfm68bIjbw6RzDzKgf/r+gvirPMSvuajlt7RL2Idlu7S7/OOjA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794261998;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=gjGR3Q9EEt6K1XfUDYxL8HindxgkhfYBJ7tU3IXDrGg=;
	b=ZU/pmSS6nQJT4JDKCTMCgHJmiyD1I7kwDj16+E2cAOxI9CD6OAeOb6A4uR3zBOaD0S7L
	 fAGtq3x7gu4S/hb+maSGt1jOSNPiz6Itym+NygtS7kC5uUw9CKuW1Ls4V+HG03CC7rEr6
	 AhDnjQLWByiqa3dLJZ6wY/wI7Ki427ph3PiTbSRnnZOtaRBxlhhodQdWuExpeUIRKy7FT
	 RquDcl5GGwNpjlpRBLAquowbbP31mPaYXmFNk2AQHzo3K95r6rQCYsBAxYOxTgaP6nuXr
	 duWf9cC0DnoRFn/k1ku1r+PTz57oVOpZThuWWuMyEm1K+wpM5C0TuoccTYL+7ddeo5w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Jaa49i8e;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 937FA606A321
	for <linux-perf-users@vger.kernel.org>; Mon,  9 Nov 2026 22:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Jaa49i8e
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 040671F0089F;
	Mon,  9 Nov 2026 22:06:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794261998;
	bh=gjGR3Q9EEt6K1XfUDYxL8HindxgkhfYBJ7tU3IXDrGg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Jaa49i8elMZNz2v4YB/+epjpu3yibWDiYErQQtz06+aCpyAt3/1Uw7eFQCgGRytH3
	 /RztHHOZstkYizftrZx9+5ojdVoO+T4VK9G1biyNRx8wqE8D51pACg4OSSs6d32iVJ
	 exNEk/wJTJUh4ro44v/zg2O60QkTj0w/WEw+gZF5GQisclMKLVP/Ihq1puobB3Uq3R
	 Yh3Hsp2uhl8d28maNB4zKTb9ysOnbg5d+4hqj03iVD9JhoH8iC1fiYuZZpTvlTYeKC
	 H79bH4AHDfIzlDhH3Xs5KszeEcGLoIO+IyrFQLdyqHGfj+N/NY/fK5ywzJ1dRV8p5H
	 iIJwtyjDrYglQ==
Message-ID: <sashiko-outbox-205702@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v11 17/20] perf config, intel-tpebs, env: Add
 __guarded_by and __must_hold annotations
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261107044102.1506626-18-irogers@google.com>
References: <20261107044102.1506626-1-irogers@google.com>
 <20261107044102.1506626-18-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 09 Nov 2026 22:06:37 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> Add __guarded_by() and __must_hold() annotations to static parser and
> config state in util/config.c, TPEBS state in util/intel-tpebs.c, and
> bpf_progs and cgroups trees in struct perf_env.
>=20
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261107044102.1506=
626-1-irogers@google.com?part=3D17

