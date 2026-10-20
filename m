Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792539440;
	b=A509jtbCbZEZIhvXorMYu6GScA5ZAE0Tpawxm09lcU7HqIiohGP0v+Bv/cSP6cBgW5CD
	 Y2lRsUHSGdO+TubUmpcCNpQ8wPB0Az+xA14+1IUGI7di0PDa2t7xgatJ+Hc8E5XTYFOvc
	 ORB/4Sn1xSfRZLf/hzuxwdk5TQp1cMVtJxGl/n/7oqdKgG7YL9Y9yNLaWzDVNZgqxUOPu
	 jxBsWMVxVYBzvNJF3s0i3DX5lgupciGU4Ntbks40+OSyYcLZaeTxO6xx8Cxw7Cr8mBqAQ
	 4xb0oobnVMvS7PDj1wQRIMHWZ5duHh+0REo7sxIE5c9zYByEU7y29EQcoq9hGeHZN7g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792539440;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=S0cvST/eDfJfVjAdUbGvJ3IOD9n1Y2CL9cUDfNeNgD0=;
	b=e/1UU0AMoGE+Vl81aPZQzm2TzytyEJvpK13QSZL3dEOxQ8qd5NSjXvUhDCq0iD4Go02g
	 tTdSbc4J8Wp8YX54B7tcMcELY/PjryggYAkmSXyFtLNcoGJkL1waZklS2NjN3CAFsgjDq
	 hTIcgjIq+F8NXLI4NOpuNz2WEGEeOfgojLdmUa4KNPprPeLsIKRn379Kj/hfgRK1Us49p
	 Q+eo95+pzPGqNs9qm9GSFk4i7ur/H8NafDg+vSa/oB9r/Xp7/8C5UIRvYJG13T4xtlXHh
	 oqUgRs7gX/6xTdmnFjIwnSHE0VlcidXuA4lR5ajm4LL/Xg+lnUkdlamo9IqdUm8pChw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BAcx99N3;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0FAC606A319
	for <linux-perf-users@vger.kernel.org>; Tue, 20 Oct 2026 23:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BAcx99N3
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 193D11F000C9;
	Tue, 20 Oct 2026 23:37:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792539440;
	bh=S0cvST/eDfJfVjAdUbGvJ3IOD9n1Y2CL9cUDfNeNgD0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=BAcx99N3rzHapvyV4KJ8xy2wEacHxtCNHAGovwhWB5SDiWtYwPl3ddC75sqVCBMeV
	 z/xawedLVNUTelkhcaWb4/NCC41c7Dj0yYIU/a1AEUvZ9c3bShjfIQasuiyyGidblj
	 nCajVbnS80RqkyRDDsnp7jEDFEQHMWRUxmjdETRBkV/FVDvwJ5Nwldhu1Epo9m3peX
	 RWvw8XcKyiYl+FBYIJzJ69x5gCsHLcfDDUdmRxTuellj66ar0B0hckdRdHuX1vSLlp
	 Q6IMsvxFPr01PUuT+cQDT9zdIwVoFi+Pza0Bp55zHUpoiN3/RPK4ET9vTEHglTeYir
	 E17b/KM3tib2A==
Message-ID: <sashiko-outbox-179607@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 8/8] perf lock contention: Extend BPF lock contention
 to RCU and SRCU
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261020205859.1080743-9-irogers@google.com>
References: <20261019220915.3943592-1-irogers@google.com>
 <20261020205859.1080743-1-irogers@google.com>
 <20261020205859.1080743-9-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 20 Oct 2026 23:37:19 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> Extend 'perf lock contention --use-bpf' to track RCU and SRCU
> grace-period and barrier waits:
>=20
> - Attach fentry/fexit programs to synchronize_rcu(),
>   synchronize_rcu_expedited(), synchronize_rcu_tasks(), rcu_barrier(),
>   synchronize_srcu(), synchronize_srcu_expedited(), and srcu_barrier()
>   when available in BTF.
> - Support filtering by lock type ('-Y rcu', '-Y rcu:W', '-Y srcu',
>   '-Y srcu:W') and by lock name ('-L rcu' or specific srcu_struct
>   symbol names).
>=20
> Example usage:
>=20
>   # perf lock con -a -b -Y rcu,srcu -F wait_total,avg_wait -- sleep 1
>      total wait     avg wait         type   caller
>=20
>        35.12 ms      8.78 ms        rcu:W   cleanup_net+0x284
>         7.84 ms      3.92 ms       srcu:W   __fsnotify_parent+0x114
>=20
>   # perf lock con -a -b -l -L rcu -F wait_total,avg_wait -- sleep 1
>      total wait     avg wait            address   symbol
>=20
>        35.12 ms      8.78 ms   ffffffff83754dc0   rcu (rcu)
>=20
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261020205859.1080=
743-1-irogers@google.com?part=3D8

