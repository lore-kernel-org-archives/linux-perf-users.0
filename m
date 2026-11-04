Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793828131;
	b=WoVE4MSjlMQIsGXHTbb6osacoFkJGVqx1sTtRO/bdQlEnrPLrfKFOr/iw9d5d4kUs9vh
	 8WR6EaUiaV8nTmkH8gAT1HlHdnlQPwOdg19nA1YlqHap1LrrSp2d0i2I6GlNg6IbXXgYg
	 ZnRaoEWPKAMKlhAHhpj9eRBNIbqdaj4Kh5/+L1FTkM8s2xFABeHiWNzZB/jzuieWHYtnc
	 VrlV2vk1z+7r8mInc/ayn43x0RnJ78STlXs7Upmcfq0siVsZtAjQY1NSUkoWcCrfoTd26
	 PZkgHqGt45VbEZarIR4xqGeKXtGkr/vq1Cttl/KGdcsSrFK/27JYTzP3dFprnCHPtbg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793828131;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=vU/c/0uePzujK7v1NOnjtYZ+ZKlPYl0a62cy1nS5llQ=;
	b=RnTwC8yaG3o2Qyb9AEU1pJCaMCjgfSQNQP1SYnmu7HCwK6jOKWEsxzIbAuSi33IKfYiY
	 NnXBAxEwak8/c4DRbVxLsUJx0HI0sQkHhhlmePm93r83Ji6GDKP1RYG2OOmOXwx48g5vW
	 wPcN7niUix8XP+6eSu6C+NliTBzG1TpvoVIEcDL9XaQSEYpAtXLk7q7mhCQy0YC7lZ1CC
	 U97y5UpTd0o0ZP5UF/n7ZBE7uEuYlRdk70f6sxCLyD1v8rCptBP4N5toJx3wczRC42+cO
	 Kuvyb4HMKeyCfzOxzHxZ9No8iDwpzPYXz62OCpsYr0uWEzR3S3UmPil1kZ17vXzD6tg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="cYh0y1L/";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 524F7606C93E
	for <linux-perf-users@vger.kernel.org>; Wed,  4 Nov 2026 21:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cYh0y1L/
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B85A41F000C1;
	Wed,  4 Nov 2026 21:35:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793828130;
	bh=vU/c/0uePzujK7v1NOnjtYZ+ZKlPYl0a62cy1nS5llQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=cYh0y1L/SIyeloJUXD088gibXxFTOded6sQiVlDxAAu4zHxsCI+ey+1eZrvOYC9hN
	 sHKouiiPAfabCaoAsnJaXYB26BxxKZmBFlEsn7YyhfnAA/seNPVsWJAIst7JN6jpHZ
	 +wODcZrYdQtKy9iN6s1yk+GJ8adLaz9qzKZNHfm0roWh26DRpucKF2lZI5tXzMCkCY
	 DbUJWiFCq0SsluLnVwGyxHsy/U9kmQ6sjCX1qOHmOua6IuR+++NWlnz4eu+uBMfLzW
	 kW208nqx2/4/x9sr+SAMdk5uDq6E2UEHU3+rKnNroo/HqxSsNOKY8WMQEafyR9N/Yj
	 qZhO8t8QOXkaQ==
Message-ID: <sashiko-outbox-198121@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 19/19] perf maps: Add context analysis annotations
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261104205909.2078411-20-irogers@google.com>
References: <20261104205909.2078411-1-irogers@google.com>
 <20261104205909.2078411-20-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 04 Nov 2026 21:35:30 +0000
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261104205909.2078=
411-1-irogers@google.com?part=3D19

