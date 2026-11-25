Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795623591;
	b=GEzVv8w1Sc7t407YIv49lBa/YZCiUe6BVykySaWoOOgBbwrK46DWkNP3NegY355ixb2A
	 9vLvda6NgZLirkVLN55EfIwhT4lvOKpjsknuYppf1PIJUKzZ7oMmTwTDQ8xH4RLDpszkN
	 dTqMpmZHVXBkIG6ET9TkuHgI8CyzND3uoUcErDUoYyGlzezCs2vWNM7GBeNw2N2S4d5vh
	 LmTbFzWz4kvDuuEU1UnAD2e/1QETXL56RU4Ves1XrhbDGy/eubrco0iwVfBv3f+d5dlTz
	 ghe+2jYcnlPs1tTtB5iqpk0KQeOLboReHTWSBv3xKX9wrVxEWFCJuG9fLFbEPYRkaYw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795623591;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=3zNUJSvt5n/U3whrTEEgqaREUNxpS8lUCFV5797dW9Q=;
	b=iZDR0PjbipljXOHeL5Bmbq+L+2vaPPGi3HRrONZkI8miy+PJ3iSY/BNxEm6cv+duTQi5
	 C22rIwkE3UxtxNy3pKCwvCHz0h2ot3dWx0Mj1rJgpuHxo19tamZQ7GpWEJwbAVfWsxxAP
	 fwTzbVwKdBXuWuH7YoaYHt6Y6hjiPmXhv6cvuupFn2wU0JGhVBL8U/kD7bXLywKt8pBUv
	 bxI92e20njRycE2wzrnHzDtAwBRULdVIOyo474lk8lJzkjBtK/p7fJF0lHEAh4Vn+vRee
	 /OkF2vRHzp7n3dW3NZNdb8gFWaZFka3U1xpOQDIfNJKgGUTiKYvGP11jfy8ecPL7zlA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=adt5UY0N;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65FEF606A321
	for <linux-perf-users@vger.kernel.org>; Wed, 25 Nov 2026 16:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=adt5UY0N
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F8261F000D0;
	Wed, 25 Nov 2026 16:19:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795623590;
	bh=3zNUJSvt5n/U3whrTEEgqaREUNxpS8lUCFV5797dW9Q=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=adt5UY0NyAG8LUHIDnlct/JpXpa5uUL4t23e98pd748BRp8JuyfVLvqbesJWEEe8q
	 ELIZmZQ9N6b+lLgHBsK2rLGol0x9CqzORwaS0F3bnF7wwbDehrn8/ZSQ+/WqG8lwUM
	 CGnfzDebbLVVNdRoFM8weROtMLV987j+TU1EB4SmzqihqeepRoAvHAeRBVW4KrrIGS
	 yDvTDwYpOY7tl2tH3J+x1dtii0+1rF0tcTNRl/m3DVaMk4DZT0JL/IsNdKqpqpt+2x
	 Nh17oY5Fio7BjDb2oJhBRGSWM054FQRHM6VAgP6cQ1+dVvZm6OBHKxUwdiIUXXaiTd
	 cN5J83YsbC1YQ==
Message-ID: <sashiko-outbox-233742@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] perf/arm-cmn: Use at least 2 bits per XP coordinate in
 node IDs
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sylvain Chouleur" <schouleur@snap.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261125-arm-cmn-xyidbits-v1-1-6f7bee891859@snap.com>
References: <20261125-arm-cmn-xyidbits-v1-1-6f7bee891859@snap.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 25 Nov 2026 16:19:50 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> From: Sylvain Chouleur <schouleur@snap.com>
>=20
> The X and Y coordinates in a CMN/CI-700 node ID are encoded in 2 bits
> each for any mesh up to 4x4 (7-bit node IDs), and in 3 bits each for
> larger meshes (9-bit node IDs). The width does not shrink for smaller
> meshes: a 2x2 mesh still uses 2 bits per coordinate.
>=20
> arm_cmn_xyidbits() derives the width from the actual mesh dimensions,
> which yields 1 bit for a mesh with both dimensions <=3D 2. On such a
> mesh arm_cmn_node_to_xp() then decodes every device on the X=3D1 column
> into the wrong XP: X=3D1,Y=3D0 devices are attributed to XP (0,1), and
> X=3D1,Y=3D1 devices to an index past the end of the XP array. Their PMU
> events end up programmed into another XP's DTM, with the port/device
> select of the intended XP, so the counters silently read zero while
> the rest of the mesh works.
>=20
> Observed on a CI-700 r3 with a 2x2 mesh (part 0x43a), where the SBSX
> and HN-D nodes on the X=3D1 column never counted although the XP flit
> counters showed the traffic. Forcing a minimum of 2 coordinate bits
> matches the documented node ID format and makes all nodes count;
> the minimum had been there until the node ID refactor dropped it.
>=20
> Fixes: e79634b53e39 ("perf/arm-cmn: Refactor node ID handling. Again.")
> Cc: stable@vger.kernel.org
> Signed-off-by: Sylvain Chouleur <schouleur@snap.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261125-arm-cmn-xy=
idbits-v1-1-6f7bee891859@snap.com?part=3D1
