Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794432195;
	b=IKNsP5fX7ovL1L7xTeZHTy14JM1vNk7XD8D8L0bkVQqVtE7YJDcjSTbiiTpC/40jS/qF
	 1THD4+Y3kRH23MJXjYsThPPQlr0mI6lx5/IlTEouCIdQ6/ZSo7IaxSBQtrI6UzJS3jE89
	 8VjXIw67REq4yuS/aop6vuZoKbGtRsJy3MJTP5ZfxjHxEfG//QDlVVvCnGdDic7jY1hd8
	 BBepksmpIgvr14w1ZrnKGXCdOx9lOJiBk8+2ZrUxOOAWntUI3UQn3D1k/MVS9j4zkKTfz
	 xj+QLzqhKk9vbtK1CfyLdIjFMDCWD6PjN85FW85G45DPexcnJlKGKGCjaSEPrJKYjRQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794432195;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=+YJoNo9bOf5NqUHfegiWsiCl8oqWrD2lwqG2HAOPuVI=;
	b=iCBjkmn7c/AoPYLfvdbu5rCRQCSFY+2+ebRxl2jMLcFtdHUKb7OWzKMe3Q9vAAzAEc1H
	 WUbx2X6Pw/uXLheOeul2xK1uvmubFJ0lBikq3mIqWfzOyEjWLYU/BbqO9thIzjiCybXCM
	 Dz7RKgAQfqddFLL+nNOxga7QYDtCwx+LeajtZlohpp270bwV9FmAIMWuRvVqU+uMp+OH3
	 uEQQiElvb+h3wExNQ092BdubZNNNjQG0bb8PEdZA9xsDjCYLeT+XeTxc1PR9Yy4h4DOD/
	 LyIlsbTeSwLWWHuHLKWJZx+LDnSCi1NT/Aqhli8gyyYlj2hoCysGukbFYH/TPg25sMg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="B/hSFVqs";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D90A6606A324
	for <linux-perf-users@vger.kernel.org>; Wed, 11 Nov 2026 21:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=B/hSFVqs
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 475A11F00A05;
	Wed, 11 Nov 2026 21:23:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794432195;
	bh=+YJoNo9bOf5NqUHfegiWsiCl8oqWrD2lwqG2HAOPuVI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=B/hSFVqsV0GcBXY8iY/AuCM7m56GojHQKH3qpNVJe7kTyz9u1twlU+ZfYx5PCjOTH
	 PFN+1V2O7Xzl92cbBRGMBZpGgIraVoRrNXF27tlN2c41PWQvQicc4jBBU9Tsk4/Ocv
	 sbVTxjDEhMOm/NCdZ/6nSlpoB1IT4OLx9m+tEiTcG5qqOwMTue+1+8Ngd84zK714ih
	 rsF7mVQQIR+jAFRm08smhOPpRSA6FKGQwRoIhFR3A7qsvA4W2OrHJWJrYTkMGEW6Gv
	 tRKtqa487GHwkC3xTHYDRfWqQOgEiHV91mJEFvCA/sg6RyJazgdFybpLBxDgPbb2F2
	 +ZlgNukMujc/w==
Message-ID: <sashiko-outbox-209700@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v12 20/20] perf maps: Add context analysis annotations
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261111174213.3526604-21-irogers@google.com>
References: <20261111174213.3526604-1-irogers@google.com>
 <20261111174213.3526604-21-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 11 Nov 2026 21:23:14 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> Add __returns_ctx_lock() to maps__lock(), annotate DECLARE_RC_STRUCT(maps)
> members protected by lock with __guarded_by(&lock), and annotate
> internal maps helpers with __must_hold() and __must_hold_shared().
>=20
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261111174213.3526=
604-1-irogers@google.com?part=3D20

