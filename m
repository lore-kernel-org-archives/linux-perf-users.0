Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793826446;
	b=wFLS+GSYHmvGYV8ZSzGFPWNB7HfYuFtSHCNharz9qmIGBfvSWVtXM++YCPLmYE7sQgvy
	 /eKIDs+ZBxvty7X3ElnVlGiK1ER8hFgGwfGMPElHWcuEpN877tYRPUmhlyR6k9SbyXB0/
	 2SWX123dSU9n0qQi+bggN7lAP5bt69k016YjIEQM39/Vvy6Z2vCw8nybZpznb4fEg1ZHw
	 fkTJjXrAX0v4eDgfbK58JQchxY24sZQeWv8yd0XzYwPECdXqZvzanjRL0V7sCSlDL8a9q
	 ukPjFKCswmTUL069byCOkfXq0Vsn/cVrmWA9xyKKhJQli7v0sj4pTTyMM7PoKsM2Y5Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793826446;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=dduMfx7xAjDnGBCi4v70G5YdRJKKHR5tVzVfQHjnaaI=;
	b=xvwEb+i6jLHbJx1+/AD1ednexLJVzbNdnhfowVk8RW7VrH3CDd8jDstzYPtf9A3tF6mJ
	 aooIC8Wao6vHfAlxVUb8gD4CegmMclgrjPnqehR9XJEFvNtQuniMWgl7pX0/kc313ICCX
	 gIQEIBPLuOArkxI+ReAUY9MysB6s/lOvDdWJaq3OabPdElBHgrsib3tuou/yo96lHmodx
	 5p2LndUcX9Fj+NsRVaGQz5TPUu0Dh5TUjMFEHjAlvy/CuIkBqXPUGlZ/3VdvAzTqSinHL
	 vbxnHVZPllEFwMgL8zJGhzX1jj6csw2owjg+HlohQEGKNHJb1kkkhTHOu/GEKmfhYgQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DYYvi1EB;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C811606A32E
	for <linux-perf-users@vger.kernel.org>; Wed,  4 Nov 2026 21:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DYYvi1EB
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E87E51F000C1;
	Wed,  4 Nov 2026 21:07:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793826446;
	bh=dduMfx7xAjDnGBCi4v70G5YdRJKKHR5tVzVfQHjnaaI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=DYYvi1EBhJLaP9qcPCPAjk6ac+TSsB0pT9WSAKaiuZjg4XzJ8Jvf123EHXREzCXZj
	 915pkrUYqH7zVCIRwCuPlswPtJpn/omj+FV0sTUWJQL3bPVXljqqPUqblHd1rfaPL8
	 hy4UZhTQfSuywHFaUP0sk1N3jr/YHJzf422cGCBPakrFOB8VgOeJ6Dbn9uzsAsuL0e
	 5AydRlrlsD4Kv43UblgYFA39t0+9sMGnUM238pVUYi38wxbSDv68KVgBUPkmeUw6EZ
	 4+dIGLuZXTH8XKOPmHTk19t1V0t4KrXPBBToq25Swny4tCaVVPz6Kfct3TjWiGFvMK
	 ur1Hn7dPlZIRg==
Message-ID: <sashiko-outbox-198043@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 03/19] tools headers: Synchronize
 linux/compiler-context-analysis.h with the kernel sources
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261104205909.2078411-4-irogers@google.com>
References: <20261104205909.2078411-1-irogers@google.com>
 <20261104205909.2078411-4-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 04 Nov 2026 21:07:25 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> Replace the no-op stub tools/include/linux/compiler-context-analysis.h
> with the full kernel implementation from
> include/linux/compiler-context-analysis.h and add it to
> tools/perf/check-headers.sh so future changes are tracked.
>=20
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261104205909.2078=
411-1-irogers@google.com?part=3D3

