Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794258896;
	b=Gib4ntoLy6NViqHlNlVUrDYZFtii6F8KOjBp5KZ95bT2Y/a75RJU9E4FdzNZvYun8d0S
	 eIrUxtWtm38LrJxBSuOqqGnQ1mNJWyGcLe7fNB7X8umF9/j8fZ5vwL8CYtX0liljEeb2q
	 Ao2M1OKWVoN1EEK5oN2xEPxShL5rwie329G31pourvWmC29oS9AojAZh8+1v2ZNDZDcxS
	 Wb1tGCb6DH5bSZA2vhujXtM/8OHTyx6Z1Fv5+wSivz7hx0lZM7gbas+MIHYNp05X7M+HQ
	 eBX8rJ3rP6GCy0xtV2zfalavbFsejk5rBB2XXn3U4pqhXNrIFmiywdUBy5X8UVn3V2A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794258896;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=T/5cwoPT6ZOJ/rPWJ0qW3vMM/W6TadUCO7DS5DqAwuU=;
	b=S2Iiv0XrzJkfl7aBAJpdgXpFxuUgLinbjl8GBtR5SrHl1oPXBInGb+sBHPNhYS54hPhM
	 PqkvPMZca2AdZQg1QQc/Kx3IjobS64Lv1Y0od2nYDdpDDfZW/h2u593b8RWinwfEFGoXo
	 lSSlq7KGyxsKJ//Jux4tLA3YFPEAeq9Boi97/WQOIFpQoG5zOGGpMQYl8jCETEJfgiy6A
	 PXx5IjdEM7o3W7UnDbDDGIGTSuSHRHd9yyJ/WzAvKxltr9M48+k5ojE4IX4mWPdgbL/iZ
	 qb20sEs11TKjSKp2z4OS1nDqTOwC6IaP7BOArRESbdjD70RAyk7WzaJZOWEX4tSObiw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YVgQ2GbN;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CEBB606A32A
	for <linux-perf-users@vger.kernel.org>; Mon,  9 Nov 2026 21:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YVgQ2GbN
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0D561F0089F;
	Mon,  9 Nov 2026 21:14:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794258895;
	bh=T/5cwoPT6ZOJ/rPWJ0qW3vMM/W6TadUCO7DS5DqAwuU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=YVgQ2GbNMJIHCPGkE5e9W46BFpiZoKXDX4qAUMcL7uAvCGilbtnm26+gghGk0v4mq
	 ITAUm7ELoAtQse70qNSzDVtumztG7SZ66uyQfHBR+9RXHVJbS9BB70FBjAiLSQV6nX
	 sT5xyE8w9Yy4dTjSijQE1nkmMkAPUZ38Ce9sJuizwQXAniUK8iiS0Ul/tVVE6SwJ8l
	 UKF/hinfFeb5xUQFBM8WAe/ndzxds1/aC32OIsz4Zm1JkbvrkVSNOoO1jEcZ7UA4+T
	 Yv3U+E5Q4X7hMgXnwZ2c4TAjMoCTWeG8lSQiA60+ZxgIJb7+3lfD+3MO+vA9J8Y7aT
	 cRJlRLFOd7FDw==
Message-ID: <sashiko-outbox-205652@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v11 11/20] perf dso: Use DEFINE_MUTEX for
 dso__data_open_lock
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261107044102.1506626-12-irogers@google.com>
References: <20261107044102.1506626-1-irogers@google.com>
 <20261107044102.1506626-12-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 09 Nov 2026 21:14:55 +0000
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261107044102.1506=
626-1-irogers@google.com?part=3D11

