Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 916A018C933
	for <linux-perf-users@vger.kernel.org>; Mon, 21 Sep 2026 05:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789968456; cv=none; b=UzkCzM/nZqz+31AnfDdeIiDyZoyGss/AWyAzkxmLwBeOryUDrkOCnZoX4k5GInnBMN0hCHFQShXn7rzq8Ewz0qWVleiu9zz6+GLqc64nCLPba1nUzheMEgsJ1KgHoa0BnipHFABZt6CEYyt59eeAxpX44QCyyaqWDbsDRhKueFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789968456; c=relaxed/simple;
	bh=X809u7vrqBVQFZ+9CiE9QvYwUjffWIevAJvPHwJxaFI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=I52IQLmPT6Tr3ZncZvD0ImTvJ89cwei/yasnS9moitBsXWFbdEZoSaom2oKh933DFbnkucj1NK7MXZ6JG3Lx7Zrp93SNtWMf4b9s5PzkDl/bNQomjm0YYgmIll8FE04raCR62Cs8WGiiSwmBxjsnhnHx9kVvjX6xodO4TtUXnwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ouIpdhhg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ouIpdhhg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6785B1F000FF;
	Mon, 21 Sep 2026 05:27:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789968450;
	bh=lGO3I2K1IGd0D5NXvNb6JAlCyrmZrt/qZnPy/txes84=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ouIpdhhgpbQN2pOYzsA0BqsAl9WeRlVsWU8FEsalTONvEz0LdVLejOI/3tLwAHpPN
	 5VX9cBRoySHFD+jNG4g4jiiTEgUy7jJUJV6x1+8qvpKKynmcktCqpPavAPRDDZWbH5
	 QHAx6CLYq4Y1v9/Vaj+QMxAzh9UD/zklSXAbGqgsHJPdi7vRd90SuDFVtWwX7Vw2Zp
	 ybesXkwU+ljVUG8knnFKPNLWadEIZb+DVdDcajamSZkmQzkMszwPUEq99oe7OnohbP
	 ss1vQCRpSZ7DqZNjg877FmHPwglr3ls3fzv5Qycy7kgD3fXH1X8NaWICXV8MBlYk6L
	 7UVLYwWMdGHYA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 02/49] perf python: Update callchain stubs and
 session thread lookup
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <d438d782c7ffefb4dd3a86496a6e1723b5bc2097.1789966896.git.irogers@google.com>
References: <cover.1789966896.git.irogers@google.com>
 <d438d782c7ffefb4dd3a86496a6e1723b5bc2097.1789966896.git.irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 21 Sep 2026 05:27:30 +0000
Message-Id: <20260921052730.6785B1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> Update pyrf_session__find_thread() in util/python.c to accept an
> optional tid parameter (defaulting to pid) and return None instead of
> raising TypeError when a thread is not found in the session machines.
>=20
> Update perf.pyi to match:
> - Set session.find_thread() signature to (pid: int, tid: int =3D -1) ->
>   Optional[thread].
> - Update callchain_node.symbol and callchain_node.dso to str (the C
>   getters return "[unknown]" fallback strings rather than None) and add
>   __iter__() to callchain.
>=20
> Also update treport.py to handle Optional[thread] returned by
> session.find_thread().
>=20
> Assisted-by: Antigravity:gemini-3.1-pro
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1789966896.gi=
t.irogers@google.com?part=3D2

