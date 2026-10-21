Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792623555;
	b=RJG9lfPm1RGdHv9yHrou1DTAnv4wFIjTZQwbQmp8IQU9+KonCrCDJeqycBnE6b7+dYCJ
	 Q66y81Wl/cbakmlDUB9LMq8sBalXCSroe4BYPPoa+Y08E+NJNF0BuOCO0uln28okWawOr
	 DsnioZKv3HZfCP8Pt9oBJWRfllXMAsO4tvLks5bnw58lfztvs+ul7Iowcy4RkyHAwUcXx
	 yjfIISJG+HlIgsuFP85XA5XIDwJRn7Lvyj1zkARZWyJzNddCAKxnsq4eY7qxhRylnUrL5
	 ZRKaDWxyq2Pd+QqsPOz18hAe+qybRT10GX+gfbpaL53FNobFs2tS9ryTAmg/BstSacw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792623555;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=s0NXjOpbFUe5RNrKGbhvv6NdGVKLe6qNldR78wpi/mg=;
	b=3wjal6PeZCAdCc2lcqZoqInqo6yt4YvyZy8rmpOMJctXA+Qq4DpygyJ9TCxYkul0de0V
	 vgGuhIYwY+4zun1AeJeH0QN9La30TNHLrzwq/OSYCQiK8g2mQYEXVUW6Gp4WBcbLsHz2U
	 ThdMznotM6xvHclpM4y0bBV0rJUPwghMu7QdwY+jSWBc64KCNcKw1VTERm+IQ9fmJgDCT
	 5REp0ZTUcX/0cBu5EfK62zn15fNLJ0vJ4KYldNQm+O5041DuZcCD0iuIMlQH/9pFWdBZ0
	 AmdK8XCb+5dtQDi4qkAuiiSTSGgPUHE5p44i14tMjNTexffQBLyoyNREpF6817L6nWw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JaAols7Y;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B06C3606A319
	for <linux-perf-users@vger.kernel.org>; Wed, 21 Oct 2026 22:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JaAols7Y
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3656E1F000C1;
	Wed, 21 Oct 2026 22:59:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792623554;
	bh=s0NXjOpbFUe5RNrKGbhvv6NdGVKLe6qNldR78wpi/mg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=JaAols7Ylwc7Afc4HYW1JmyW9ofKeT+I8KlCuRGHSYyijDx/PiHdDAiJ/mL6JD1VS
	 DgHeubJrSyTI//6oMnmYbSTqIiN01mDuXkkFtzdR1MyaPTx3exysx7bCQPS43wjpC9
	 saArn93iew0WHAtGx+Uo682EOXKqNNyas1bfa4oGIjFU5B686vKvT3ielhED4Rv7yt
	 iHGzq7OEsXRWkwg9iOWJM8VjVYtPoIiWx7UaDhQg+kV1VgdTSpbYTlghb0eGW3BtsX
	 fsBp9hrg2RVIenfCjA8lmsAzKw/RUAM8cTeS7h9gkfrZz76TbT+Zbrkvzvc/0TeJgh
	 bDBgsq+FdNPRw==
Message-ID: <sashiko-outbox-180752@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 07/17] perf vdso: Fix unlocked __dsos__add() and race
 in __machine__addnew_vdso()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261021223905.715051-8-irogers@google.com>
References: <20261021171044.155240-1-irogers@google.com>
 <20261021223905.715051-1-irogers@google.com>
 <20261021223905.715051-8-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 21 Oct 2026 22:59:13 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> __machine__addnew_vdso() called __dsos__add(&machine->dsos, dso) without
> holding machine->dsos.lock, and machine__findnew_vdso() and
> __machine__findnew_compat() initialized machine->vdso_info and created
> temporary VDSO files without synchronization. Acquire
> machine->dsos.lock in write mode across machine->vdso_info
> initialization, duplicate checking via __dsos__find(), temporary file
> creation, dso__set_long_name(), and __dsos__add().
>=20
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261021223905.7150=
51-1-irogers@google.com?part=3D7

