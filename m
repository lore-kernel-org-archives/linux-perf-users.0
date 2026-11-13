Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794600409;
	b=D8OIFGa7bVWQGpFTvN15PT8tigvEzGqy3A1aYELQ1i5OhHn7hTkQxKr33dUA8LvGBXCw
	 AAA5cGJ7QbmJ8iHw4KdhsTPgojqYtX6nTG5JbTWoXfOU1RcFkRN8cq1kLEE1X6sB3czBV
	 DyJ8qIPRaHp8PZioK/KfCk8IRkoUlW3VoGlhUhVHDhsBFX89BEFRY29YMsZXpKrZnD43f
	 ce8BuDLQ2G4tEZy3a608lep9YGHSMj2CXTZvtM1a13n9UfQHPZgqoNiP6jNsLl8u4Tu2O
	 i8zO/DQZLrz6QN3MGBLdIx+AisI057cxlKVzs3ZqfWGJl39IobJ/+f4WhG0INACM2Uw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794600409;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=x8m8goI7T3s0lhH6LqODvrO5KeM8Z1ocDjnuIXoMJgg=;
	b=pTg1fXX2YhVMRZVdUTucdvhn83K+UgWUA3lcbB5R785vlstN4CzC9Vm+58a+fxWxeChr
	 wTNKFIexKTzIA/fD0wMJDC6CakPtHnSfNaPzJA8CCZw5aorQPx0Yq0dUhtDH7pS2KLiYA
	 qcZil5++KtpJGE/fG3onuVj9/I0VywoTgTsPmlzO9leEz5nZNa2785q3u+IwbGXcr1wef
	 H9DxGQtVherBdb8Y9npdUOPqxS+S9qYn85FglYIQ6jxiwwOpQi4gI/HifwsEdLwd47fhm
	 3jB04cQ4SEA0ZZs67Nvg89GuYdQey977gs2/wTZrYFgor/tV9oZSs5ND0e6wvdiTXmg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PatdwQrc;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D1DA606A335
	for <linux-perf-users@vger.kernel.org>; Fri, 13 Nov 2026 20:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PatdwQrc
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C1D61F000C4;
	Fri, 13 Nov 2026 20:06:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794600409;
	bh=x8m8goI7T3s0lhH6LqODvrO5KeM8Z1ocDjnuIXoMJgg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=PatdwQrcF5IF8dhRIO/aGhylJcg2As+n/P3GvCe+PRkRU/jAoh6BP3zm1bh/THv4+
	 IKel0rZ5iiyEh3fV+nzGAoAzw70aDCezIVApvojKv3Sp53/BG+U2qexG1/qmIprZEx
	 +PaAOrKmfVRWU/50dnH8RFhYkhZwb1MNZ3Vkub1ExOX/+wLPmoKPhQsIsaqmiB6Xkm
	 VKLwH5T1192bn9q4C7QSJ+3Y1DogOUIj6zp+1BFJxm7Bkh4FrzZLkmDQq+n69ut8TH
	 7oS8cV/WK0+InZX4nf2TeaXLpy1XMrDdTMHJyQC5lCDDCpN1n07QWaYaWImKEN+za8
	 Fh3eL4HCBPQ9w==
Message-ID: <sashiko-outbox-213614@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 10/30] perf pmus: Pass struct perf_pmus to scan
 helpers
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261113195335.2865725-11-irogers@google.com>
References: <20261113195335.2865725-1-irogers@google.com>
 <20261113195335.2865725-11-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Nov 2026 20:06:48 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> Update perf_pmus__scan() and perf_pmus__scan_core() to take a
> struct perf_pmus * argument and update callers to pass the appropriate
> environment's PMUs.
>=20
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261113195335.2865=
725-1-irogers@google.com?part=3D10

