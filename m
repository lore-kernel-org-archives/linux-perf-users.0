Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792517137;
	b=5LbEh6fJeUpcAOMJjXg43L2jWzFgiSz+SlZ63frV6t8xr3AtczGjxuJe7li+tEEPn+zo
	 Vi8gh0CfsrZbGGynRL4ZJxw+voRnXZzlW2Hjuh4u4yIhduMzpstx3WhH+5sY5TgFRvV/I
	 vNldQWBDi26v3jH2V7XMOjLGvS3vBtrvoOUIycUAFtScuIdA1yjPeLMI4NasIPDY5NMY/
	 Bm0MtQsD1CEy2d5d4nvMEIvn5S2ZTXCDnVAWc5LG1yC03fNKRPN3VF0W5vPcZKiQCuKd1
	 DWrpczwy4j4QGmwbWkhW1T4TqXTHZ0HRFVksc4lbb8NEFHV/BdvV3Z55OvSybF6AgyQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792517137;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=2q3uQjfIffUAaSA80CEHmeII7l3awivsPRqXL4KkFRM=;
	b=ieHP57XS9MVCA/Pmx2mKv+kSnJkzu/nPKWU5az8or+Rytyc6sx3C/cKKhLbZ2noyXwhT
	 +nL+XNx5YDQY6YBhE4I1N33lnUCC7es1VP2KuNf5U3Nb18BpTvieUaJTHkZ5Ex7L3kwdf
	 mDKgeTkQ7zS5haAt/C4T0GduU8sOJd7bOyhb7tkYnKrCf7CFTjymTPF6WWJdl6HQoA4M1
	 NIwzAVwLgkP9RouBjncaMovT8mqJkW79ljZcyK+V00r3zlfnQKJH5zZUbi9McwJmwln/U
	 4aHyXU831OLPtjf1X0Nu88V2uPEKivradf3omO7o51kX/WUqyeRjnWa87iTjp1jIFpA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=V4SoAp4L;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BC58606A319
	for <linux-perf-users@vger.kernel.org>; Tue, 20 Oct 2026 17:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=V4SoAp4L
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4F0C1F000C9;
	Tue, 20 Oct 2026 17:25:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792517137;
	bh=2q3uQjfIffUAaSA80CEHmeII7l3awivsPRqXL4KkFRM=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=V4SoAp4LuMXAYE+N0Cec0EghncpFeYJQLW8l6MhM623gsspNbtPjzYGP13uit3jhg
	 +T9AlROIciGh5aqk5K0xLxFEHzJVGRfzRz6P2dAV3jJLZKSlOsm3kfrelM40jJLt2n
	 xsgNxVGrEtDSEfyEPWFG2OZjv0vGY+EstFDECDduMgg9CApnKHRtqt1JPlAaPhC3wd
	 30EyC3YlCsuIaJJuCxGM9/vfj8w+Zki43IAyLvCfiY1st+owyCAv4brDYkL0UL0oja
	 3X6oIbAoOpuW7XiyxLJy1KMYQo7N8RB3fGG22pbeo/Urq8wOCtB7f1qdREUCeu8wYN
	 zRzT5gyKfnEhw==
Message-ID: <sashiko-outbox-179419@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/2] perf mmap: Preserve the consumed cursor in forward
 mode
Reply-To: sashiko-reviews@lists.linux.dev
To: "Paul Moses" <p@1g4.org>, linux-perf-users@vger.kernel.org
In-Reply-To: <20261020171946.3593127-3-p@1g4.org>
References: <20261020171946.3593127-1-p@1g4.org>
 <20261020171946.3593127-3-p@1g4.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 20 Oct 2026 17:25:36 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> perf_mmap__read_event() updates prev as it consumes forward-buffer
> records. perf_mmap__read_done() then overwrites prev with a fresh
> producer head, even when unread records remain.
>=20
> perf_kvm__mmap_read_idx() stops after 25 records per mmap and calls
> read_done(). If more records are pending, prev advances past them. The
> next drain starts at that new position and skips the unread remainder.
>=20
> An event arriving after the last empty read_event() and before
> read_done() can also be skipped. read_done() does not itself update the
> kernel's data_tail.
>=20
> Only refresh prev for overwrite buffers, which need the current head as
> the end of the next backward read. Leave the forward cursor at the
> consumed position.
>=20
> Fixes: 53172f9057e9 ("perf kvm: Switch to new perf_mmap__read_event() int=
erface")
> Signed-off-by: Paul Moses <p@1g4.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261020171946.3593=
127-1-p@1g4.org?part=3D2

