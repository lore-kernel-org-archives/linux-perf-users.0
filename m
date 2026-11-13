Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794589794;
	b=ASB9ND5/UshaP3pZeaT8g5bdlJSBLc1+mxTAoDGGAHpR+6im9bEZAIlwxvt0uKdqJGjf
	 fKJ5saPUkqx5U/wh0ocOYynxDgp2Bq5nR7/a55CKachZ8vHVi2aoYlKQzbWppiZO1WuTw
	 PIG54+veuqTkpkOv8jyb7n7gpHzBVO4TaUzlzxgG8neiFqCtmG32jcz+FrCVLDuQXCJVB
	 8kdHZ2JkvMPQBX0l2tVht9fG5ZL0vJoxKJSU4bkvmeCgm3ZzFIozHR8/5BCRdCpyD6E13
	 by9Ys0JgfjDPzbuc7ahv5zlwQdtg8vZDWcKBWkt3LlkQAfvwfbU+ukyO4omPVx/YNsQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794589794;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=B+y2CMXAqRYjd+DxLVwalIYZhEu5ax2Aje7C7+tN//M=;
	b=otcTozyZEs5/lO7AspdV5RFvr/8jfmBISc8X+UCN4XWxSajVxQty4zyRAirc2Db9hh4i
	 +0g0u2Kq+Zdc5dgLBpwFHZfIT77E3Gg8s8kD5TQUR2Fnqi7fz+v+uE27pfHKcPoxsIWZn
	 7zb8L47OZTliFxOgHwBRx/neBBfNYaCHhnBKCcHMC33At4JU1t+jM92b9CDYuMUCGH7d3
	 XzFHfw1R4C97jwcjjA3PysyIfxNRmuUYBciSnPg0Du29DPHFs2pulpHoooI7wQb7MOFJj
	 vAQ11AW8ou0zXmcHmLxIsQkNUVLjOX4GKX7swv6FxezF6yxSlZpod/vIOBEjrUDEpdQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=h4qZtqma;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42F55606A327
	for <linux-perf-users@vger.kernel.org>; Fri, 13 Nov 2026 17:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=h4qZtqma
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBC901F000C5;
	Fri, 13 Nov 2026 17:09:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794589794;
	bh=B+y2CMXAqRYjd+DxLVwalIYZhEu5ax2Aje7C7+tN//M=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=h4qZtqmaCnVdlbnh7sq0NH/CWKJcjPw3R7iCtkosx88YM14WPcvWIxDqOWMpPzwm3
	 FLVsgzfgN4e88wsnb+huZqQ3PlHq+dP2Sq+PDZb83awm6QTSTtv7xIuFcUEM36sgy0
	 MeqUK3vv2KEOKSNDJiHFANXO4g35jnVmkEmim0qPh8XRRdkfj8S78RakT0uEYCEbDZ
	 5X4yHPPyry7ClBMKxyItCPXirK1juZ4uWP0PZy1n6T5a+eIyJayW3hJ8GwrX1KRDah
	 gR1lWFUVH9L/9HodpPjqh9c/NH1ErEKet/lV//y7ACKJQvBL68NGmfnt9C8EPtVTii
	 Zi33/IcSMycww==
Message-ID: <sashiko-outbox-213280@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v13 16/21] perf intel-tpebs: Use DEFINE_MUTEX for
 tpebs_mtx and add lock annotations
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261113164152.2095566-17-irogers@google.com>
References: <20261113164152.2095566-1-irogers@google.com>
 <20261113164152.2095566-17-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Nov 2026 17:09:53 +0000
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261113164152.2095=
566-1-irogers@google.com?part=3D16

