Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792428659;
	b=AZomy2w18G3smdKHCJ5HOvnkBbYDTyy5NYcOYoQDt028xGLqB44Io8XsuPN3Mk7IfQxI
	 T6xeQlRTaX/blSZNgwgV/X86KWsaUzTC4wRcGspAq0yuVn64Fsc77XMSZnznKfInzSHLd
	 CBWilSxxIhu6wiQBkMZ30KhSschB8ytTNw4b+T5FWuHOaDae0IyUXmKPLAKwWOWIL9ZX2
	 /ve7SYPbqMtk9UXb6g0ZNa49/CML+9+YGDm0SxS8hVhLU6jR5GT/R3OzlbQqZVgPLK8/b
	 u3L3mdY6yTAqxaRQvh2VR1gna9v+SzYiwwIE9q5AzuYul4/mmeViB72VU4IvEVVoquQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792428659;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=cRneVGUZAyBKmB0TvWsoXJ3ptJx0ZvSKzX0EaUDhnA0=;
	b=L9m6Pf8vGy6aqOXTLo7bKrMRRcBOWRf/7UKh5eYiHfDeyGFuv58IIIYkTmqCNjrnwe4R
	 qQ5cnXVvVblLNv0x5O8Rt/cJ1WtU/dfJHUxlQhTD+drQq0ce+5wPiWqpsTH7Geeu+aoYL
	 8z/p1O+/Vf9ynlxIlgQVHYVhuiJZziua6O+I5NgQUsZVBLEo+nIKxgDCSeTU5rE9GeF9P
	 S5N6Xoc18xY4+h7lDsreFiBvA+nTgEScvx00Vlo9Xq3OfMF10HaHQACnLwHlkNUBU9BEJ
	 vC39wswutCoOtrUuK+NnS1q+hr2YbfaPvYbMTFzq5+jz4bZ83zPryc98Pi3AEwoOOJQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jL726XO6;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D9EF606AED7
	for <linux-perf-users@vger.kernel.org>; Mon, 19 Oct 2026 16:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jL726XO6
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C318D1F000C4;
	Mon, 19 Oct 2026 16:50:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792428659;
	bh=cRneVGUZAyBKmB0TvWsoXJ3ptJx0ZvSKzX0EaUDhnA0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jL726XO6QucdQiBxBNhOepo/elp/77dD0vehGFXMyNnaM8WSBGfo/LBERT1XUxqbk
	 qRHggmFPcczGqdkbVzSNudVwUTCmJb52K4cEcBjA7yKV6Hmk5HR+1XPMF0wU6xTZMe
	 PqT0Z8Kmli4oy2p8JJHvJVqCI8TQrI1Asw+7tnZl1bIq5UsDUYg4Hld8yT6sWEwtCS
	 Q3MOasr/RVadbO68EVuKF2hpz8EEKRI8BKcqaibiA+HaOWdKTWgLkojANuOqBNZzhu
	 v2JGFw7VzrhW8YrolBzQecuwvOYjo6RqCAjRCdd25sLubJdXTXjyw5WUbSuNjHnqNP
	 M4XRWmy6T2bqw==
Message-ID: <sashiko-outbox-177953@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/6] perf jevents: Add support for NVIDIA Tegra410 PCIE
 PMU aliasing
Reply-To: sashiko-reviews@lists.linux.dev
To: "Besar Wicaksono" <bwicaksono@nvidia.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261019164241.403644-4-bwicaksono@nvidia.com>
References: <20261019164241.403644-1-bwicaksono@nvidia.com>
 <20261019164241.403644-4-bwicaksono@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 19 Oct 2026 16:50:58 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> Add alias support for NVIDIA Tegra410 PCIE PMU events and metrics.
>=20
> Signed-off-by: Besar Wicaksono <bwicaksono@nvidia.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261019164241.4036=
44-1-bwicaksono@nvidia.com?part=3D3

