Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794582810;
	b=X05zOBIhi3YVG/IAOvodRF2aQAsRGOZwwT71ECRQzopP34RuAy0TWoC1NZifHn0DHZUn
	 rST0gFkx2ab14rDzg1QWG5fLleuA0C+meWbq3ghN+0ziSNH8263zdjZi99mypokTkO542
	 ZllVXw6l82BDEAfJyJ5R3oqUhRc5VweXyWqpnMRdGyX/HWJ1OLQd67l8OhXnP1PEmw4e9
	 NFuakDx5YCx5JBSeTt/je9bYN5ihQk8ETYbe4Kf9AmuChLKFOG/tl1NNYeJnssUxQuXSf
	 SorR/44d/q1zzFB5dizKQJ0lWndw3DvUAvdoAYbIh02hNU846Oiu/h05rw5MXqsL8HA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794582810;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=MoP2S/ZlEQAlYawBhX7E6bsTOIUofYk8sFHL1XHC1yA=;
	b=fpaPBX5tLVhBuQnxJT38GxFGzESMxVI0zzYB2/tCbVPuDd3mToLYdtcOySkQMymyR2BZ
	 OgcpxaJEFcrwrBuAyMEyvHQa75KIeVY2RCNfJaxxgSm74e8Yv3yTkqN7ydYKT2c6Dv+b5
	 lwKX/SYSHjfd061VND6UVK+Qvj7Rcf6JHEJolvy9gJWwTkS9+TZ2ISuUDZsp+ZwVxmzb4
	 5l8oQarZxeD16aH8+JpaumMUKbU1RZ/r4b7NJRQTrN+SZF1PKLNcBH9NlaKuuCL9Cg3Rx
	 B6g91Zxt1j5NsryG6Fqw4h791dv6U5EGlwhkcQu03za//Bm6oHoBaX4iYGxGG+Kg61g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nVQ75YhV;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B77DD606A32D
	for <linux-perf-users@vger.kernel.org>; Fri, 13 Nov 2026 15:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nVQ75YhV
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2824B1F000C4;
	Fri, 13 Nov 2026 15:13:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794582810;
	bh=MoP2S/ZlEQAlYawBhX7E6bsTOIUofYk8sFHL1XHC1yA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=nVQ75YhV8tzeWYiQp/DsYeu/jFWjBE46nxelakn8jt6vH024nfYb5XZMjN+pLX91/
	 1YOcsQJ6aPgrG9yhK0RTTMf41yRdx9aoWx2g/btpIhNhYD1tL4UbX4nEZbkntQ9uHL
	 TXw0/6ap5IhTuHqsLjeaL+dFOCE9sUWV9GHsjtxfM8b2NsIO8fRbHnD9Wi4gDxoi3V
	 sXCI9IdDTWX/ePfAm7iQp+nueKQGy8UMlZXDD9K7SMSOuXDm4SeHdDTCMbwWovJm9e
	 n8fbcdRkRiMcAg9K/lzXLLeacIcIlDFNMRLEtC185WsRGTgIsEheXEdW0NiAN2lBGO
	 G1mWOnPZL90eQ==
Message-ID: <sashiko-outbox-213065@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 05/12] perf tests: Exercise data type resolution from
 a register
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261113150555.1163049-6-acme@kernel.org>
References: <20261113150555.1163049-1-acme@kernel.org>
 <20261113150555.1163049-6-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Nov 2026 15:13:29 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> From: Arnaldo Carvalho de Melo <acme@redhat.com>
>=20
> At -O2 a struct pointer lives in a register and DWARF describes it with
> a register location, while the unoptimized workloads the data type tests
> profile keep their variables on the stack.
>=20
> Build a workload with a noinline function that gets the pointer from a
> volatile global, which keeps it in a register, and check that its three
> member accesses are resolved from that location.
>=20
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261113150555.1163=
049-1-acme@kernel.org?part=3D5

