Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794941743;
	b=P2o/cQQWW1sdrcRb9MHiKrt0EfnjuMDV4AdMQAqupGgAc9Ruj6/XpLEXJeGtMYwLnoQ2
	 Dt265lQTL7rlY1cp1yMXgLVsVXDt5VeZH4HXGFoNgLrb4F9GXMSwd4TvqzAtXk82yntiP
	 UmPurxMNJ95buD0umENH3xl0jFbT4hsggLAC0yD3GQ7XFARtpmtKqWuKSDSn0iwyNOCEX
	 l80quZK3MVTZLucVV1E5ilWcZSHaRLlHVoqFliRl3OnEjrAW0qOwdW8nHB+f/eOHu8neY
	 1YNPd429dFqmeyhNE8xnGca23mqShyEtFO1wUp9e/gtGNyv6t57PUr/OThwMw2/EXDQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794941743;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=JRhaSAE+C6N0cKmgxhCg5y9DVZ49bLkmTEG3yHw3DSE=;
	b=mJm9Hdp6HAzLjoMJsntyvi962VckX8gSOeZAF1AThq6zjJAORk6/c0JCtVnMvzYRUYlK
	 fcA3Dtr6o6KzcQ9rk1/uSD2iESO/wivULqHFXOe058MkM5FbUSn70cz8lAKYbKB+d/H85
	 GwolHaZAOhJeTeyU9g9a+G9QeiLHARVi6JjYDm4MCM//soH+BUhF5NJr6jTPmKJZrMbjA
	 98zE0/wVKwEANALu3XMqd6kuhA8nqIfJn1qoxkSbWp4czNOXtwAXk2dmziasYxphO21qg
	 bJT3ryBhGhvbJP8p6z+4c6AqECqQ9yDFKw9VJ+SdLftpfu9zM2Jt7o4erHAvz6TXwkg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QC2LFsUi;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61582606A31C
	for <linux-perf-users@vger.kernel.org>; Tue, 17 Nov 2026 18:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QC2LFsUi
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 139CE1F000C5;
	Tue, 17 Nov 2026 18:55:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794941743;
	bh=JRhaSAE+C6N0cKmgxhCg5y9DVZ49bLkmTEG3yHw3DSE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=QC2LFsUiSo10/qM5H/oHf0N/+7qCfOdBDSd7fYhXZ/KawHqOqIdqHJ+2paNsL5h7p
	 v7KcpJ2fNPPp6Ag+19ZHThKm/0Qstx+EfHrqLAKl4YBE2QHyUeH/MtdyslYS2kKTBS
	 feHf8gdiqu0aDfEsuGiqZCh2uN5TuZyZmtJDfxOSGb6cDbjKPRIh4oNqfXvn5kWiO4
	 cv+fOtrcZDYa/96xw33f4C7hEguc+2zoLr8yHmyd916Cj0LfndPSq1MKNHsTnlLjkn
	 ap1oN9/qcC8mM1tvpaH2NXH2A75N129VB3p/Cq7RyMgMt96Y1g6ZhC6JtJpcH9HcWf
	 MlR7sEIAgBTzg==
Message-ID: <sashiko-outbox-219407@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v14 16/23] perf intel-tpebs: Use DEFINE_MUTEX for
 tpebs_mtx and add lock annotations
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261117184844.99889-17-irogers@google.com>
References: <20261117184844.99889-1-irogers@google.com>
 <20261117184844.99889-17-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 17 Nov 2026 18:55:41 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> Replace tpebs_mtx_get() and its pthread_once() initialization helper
> tpebs_init() with DEFINE_MUTEX(tpebs_mtx) and static initializers for
> control_fd and ack_fd, and add __guarded_by(&tpebs_mtx) and
> __must_hold(&tpebs_mtx) annotations to the TPEBS state.
>=20
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261117184844.9988=
9-1-irogers@google.com?part=3D16

