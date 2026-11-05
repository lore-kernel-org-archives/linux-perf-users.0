Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793881044;
	b=icXRdcVJVa9MkZ/RdfdUhtH1EUmmW6+ESUDl8ajzG6PDCZHxtP0sXZgTMIaV7inj00pZ
	 gMEWZMe9ND2IjdUmReu4TbruG++qDY4YmqdYK8rzVe17kzxS7tYFuoTK7UHJQ7sVLGXJC
	 OqF8ff3lqDwIRdap/DyJZNs6EF5tyNiBSGEK3zhISzx+Xwadaz+F0hS/vJYwIwRilQOiW
	 ej/Ih4M7eBU5zbAozUblhb7U7xQfJb3FeuM0bUsTqic6+qKLMp1qCz3lc/nndNO5OJITz
	 xn1nqDyN15ksM+IngjTlAOVL0tMSKKyU9n5zFj/OVBQUuR1dTJuAWyo38kdxB7b1Tfg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793881044;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=+7QxFp+tZWndcfJzYjZ2zsex65U6/QGrJlr/Ia3JE+w=;
	b=f7t6/ESlHS2os80mqhrwcj6jG58hiNnNX9Nzkkdt6f8Wckzw1QnSYaOWkJ1ACVqQPuPt
	 Flmn2SRWubCOWlVpCkclEOMp0MgsOYGd4SZtoapLbv68BkTwuiKHQl/12KqPMb5keiPnG
	 nQpzGCOnIekMRQk1YVEiWugZkMc45AvRmXSvI1KMglU8IIKwOKwIURSMijuCcFiYpvggr
	 jNgKaWeyAPNsg+yI/nr+98TKfiqkHVWn1Z4cZ/yhuKj9uIxtCpUsuSvXaKE0o1YvQoT8C
	 zMuTkw/ClwYWv5w3apPJeCvigUXjSzb5Dqjb3jesPrAXq6lV+TQRumNgo0yUVNflUbw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NPiggx3f;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8973B606A334
	for <linux-perf-users@vger.kernel.org>; Thu,  5 Nov 2026 12:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NPiggx3f
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4284E1F00A1F;
	Thu,  5 Nov 2026 12:17:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793881044;
	bh=+7QxFp+tZWndcfJzYjZ2zsex65U6/QGrJlr/Ia3JE+w=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=NPiggx3f4ALYriP0PZ6b9lxvMyVtfaIHrGHb3OUcMp4PM61mYHge0E+gphc20AQ/e
	 129QA2Q64mY39NWduQWQj78W7AEps6f4EBp1OR1hn5yRi8cMW05Ix0o3BXZYHy5kCh
	 nc9q6HhYgiK8ITywe+f0d8Nrg0/rvBdk+pCguMJ+/O+QcVQPKcLx7SHWkH6N6vJT8Y
	 tKbKfDUcfvM6tKl2td3NSRi3YKcC+PCfR7j+3F7xAVqvLA6TyMkwKkHymrwhvBbq/V
	 BvjDmzR+xA3cC9tyFczRz/1KADgr/U8EZm9GPBNQVALIg8gevJCkknRONs+7aKLI3B
	 ANoxHCV0CtiYQ==
Message-ID: <sashiko-outbox-199009@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 03/19] perf cs-etm: Turn on context packet timestamps
 in per-thread mode
Reply-To: sashiko-reviews@lists.linux.dev
To: "James Clark" <james.clark@linaro.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261105-james-cs-unformatted-per-thread-fix-v4-3-7759e0ce2449@linaro.org>
References: <20261105-james-cs-unformatted-per-thread-fix-v4-0-7759e0ce2449@linaro.org>
 <20261105-james-cs-unformatted-per-thread-fix-v4-3-7759e0ce2449@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 05 Nov 2026 12:17:23 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> Practically this costs nothing and preempts future changes that will be
> made to support decoding trace in order with Perf MMAP and JIT events.
> It also helps keep samples in order when we add support for multiple
> per-thread mode threads in the next commit.
>=20
> Reviewed-by: Leo Yan <leo.yan@arm.com>
> Tested-by: Leo Yan <leo.yan@arm.com>
> Signed-off-by: James Clark <james.clark@linaro.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261105-james-cs-u=
nformatted-per-thread-fix-v4-0-7759e0ce2449@linaro.org?part=3D3

