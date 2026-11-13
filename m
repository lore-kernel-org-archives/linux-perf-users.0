Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794600681;
	b=x7eejDtD0/B/Jqafxvx5XhK2jXjjJEsQnx1Snso38r8MurANbraZ9SSjL7TAwtCsB5lH
	 MYLqvsRb09xypEh+BrBA4RkKTq2aptRfMNmC6E8xTFmbmVNBZipbSjATs9u6svzxoqXud
	 094dPOxQeabgRzZ7U6h03dynCJ9M/immNPGRIjo8vZvr2jaex76zRCuiJuiHp4Q9QmIzS
	 6Q7vTd3JOdU1dCUA6YU9cfZn25UWAfOBAqKDHbATo2rNihcBwlASSEHBpZAQV38qdpuwp
	 5xQCi61IgByap3AYeNrAFeKUXjEWUFbFPyCUZuXW+2jYtaf8YLzHDlyzQezN2dwSj5g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794600681;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=i8YjXOSgDrtTMZ1VXJG72KiVMrIpnJds7B0E4V1XZIs=;
	b=IwXlNj6hmtSXfdspG8Qq+Zk+ckc+FQN3Rk9lM8NEeXIe61Lu+nvT7s8PSxNWvWVcWWPJ
	 N2mKbpJDmEHf7wFnIXDOfhntQVbujpstlhp7EjizIurYbgV+7Ka29NQbtClJqS3R5vccr
	 n5orvhOkPFGl/I91Xp8UC+DBDuiFJI4dKDuWWvU5W4FlWmw+xoQTy7SO360b1/jUAgBBn
	 L3mQ8HM/yURccZw6EaoS0RSBb61MQ+ATfnOIV+6nArWH990UJ+1GIeO5aS4wK37xJCJWr
	 J/kF6Vz3WZQKoBS1AgtcC1grlNwSdxOP/gJq4kDRSY8QStagkElQMNKPLoS1GQMH8JQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nkiOaTFA;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87670606A881
	for <linux-perf-users@vger.kernel.org>; Fri, 13 Nov 2026 20:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nkiOaTFA
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF78A1F000CD;
	Fri, 13 Nov 2026 20:11:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794600681;
	bh=i8YjXOSgDrtTMZ1VXJG72KiVMrIpnJds7B0E4V1XZIs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=nkiOaTFAz8xxqunuMy9btOJ5uKEhwQuGrA2LgXuBVqcsaxgp8jsUyqJh2qPrr1j0E
	 kO46bG0N78c9cdpvBjzeKk49ST4QHVv4VU4BRJtW1SMwhOD6sH3Yji1i8XyPTISwym
	 4giGWgwnVrve4zpfEwR+71oAjvJXZgVfSbl60kM9+Ym68DUOa6skX5EoNiCsFPKqD3
	 X3nRSfsCOR0S44bJzhp9D98cwz1eMRdRH3aLIrvuHx0wNpQZRjdDAs6/1WdZAJZ0Vm
	 q19k4EKyTIbmvRzNtv9nPbSPgGVC7syQ6298TidoQKcyvSdQSIfiwhlsUI9IrzYyH0
	 lER0KvlMIy5Qw==
Message-ID: <sashiko-outbox-213621@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 09/30] perf pmus: Pass struct perf_pmus to find
 helpers
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261113195335.2865725-10-irogers@google.com>
References: <20261113195335.2865725-1-irogers@google.com>
 <20261113195335.2865725-10-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Nov 2026 20:11:20 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> Update perf_pmus__find(), perf_pmus__find_by_type(), and
> perf_pmus__find_core_pmu() to take a struct perf_pmus * argument and
> update callers to pass the appropriate environment's PMUs.
>=20
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261113195335.2865=
725-1-irogers@google.com?part=3D9

