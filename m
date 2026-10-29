Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793265728;
	b=UgaSqo2E27LVGXAj4L7mFt4J2GUS4Uh0zn9Xje8DcsahyMCVXIKPah7drB94mOhkRGAw
	 MuKQr9hQfOiK25KN24a6muJH3BXuvVVwgUXAwidKMawDeMQcQ6XeNpv+7avIFCEloQLxZ
	 7aHDdsT9mu8ko2RksaA5ih+Oue9qtBruGkD+OYk8+tLqJj/wid47kiC/gK50xJkqH63vl
	 N1LTezNHScqsiwQwXLImJozHHdR17WN+IU8Jc2EfQQ9uJiaINTx7u6K9QS5KVtkNj8Kn9
	 W05pNWUZDq8c2fHOds958HcoHda5wZ3URi3BZE54Vp9uIkLeR4nZqd9/DHfQWIeIRug==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793265728;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=/kUNB630FmPpWNpPEw4HdSfKYLKciTP09qqyDiMJh3U=;
	b=rAc2o3+a5gHbgpTVVrm0c346bc3G47PTZiS7U9MWBg1Jr/mUe0PRb4QPOHkhtwQ0C2Cg
	 uplydhytUL7zzy5NUzsYJOrv/UcJ/6i2YuOTUR6c0fVeqOpWd6c1NkQOtooUglCP0YvT+
	 F16GYBsMUp3AW21HyICW0fTcfCfEbHCOwIcT1RLBuefSgjOu71m5urjH5XQZXkPiLZ78a
	 ag6jXOwSJ4FJPk9nLRwAxeJIYVhoWeEEK6rOFGDcU6hf/YejclRIjFBDXHvCwSIzYYB7N
	 Xdk/C/muZvrGn3vivbsuuC3KhtTUhn9mkc8WmbLvs8W/QUWyRkac7CXOv4wAAREkd+g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Lt2ufeE2;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4E20606A31D
	for <linux-perf-users@vger.kernel.org>; Thu, 29 Oct 2026 09:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Lt2ufeE2
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A0AC1F01825;
	Thu, 29 Oct 2026 09:22:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793265727;
	bh=/kUNB630FmPpWNpPEw4HdSfKYLKciTP09qqyDiMJh3U=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Lt2ufeE2tJYZ1SNOYOTcRterx+bzII+bzg1DXuMxup1XLQ0RaKly6MKZwQJ2KIkoY
	 zvGXmF8cBqFqYmBMMBw/A1oaTLB3tsuAChIHCHGv8pVRUB5QBGkG37Gw8BVqRj5P2t
	 WtvsTIvV7lvNjc2Xy5ECM+WAuM49NGWOmT9IB6IqyyVg7dWiHSoxxv/6wyHdSHuUYv
	 VkezN+RszQGBlTapqbu7F4CyoRZ+ulUnXg0yN3xn+4OfC1zCOLjYRm7KZMadio5/VG
	 1yK+gBz8/R8D408ZywIVnGTf9RVnh0GpyHjdhiZwTmbo8wnm/j04jZJredh05yypxQ
	 zrsiJq6wEbrfw==
Message-ID: <sashiko-outbox-189028@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/2] tools/include/linux/jhash.h: replace
 __get_unaligned_cpu32 in jhash function
Reply-To: sashiko-reviews@lists.linux.dev
To: "Julian Vetter" <julian@outer-limits.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261029091736.28742-3-julian@outer-limits.org>
References: <20261029091736.28742-1-julian@outer-limits.org>
 <20261029091736.28742-3-julian@outer-limits.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 29 Oct 2026 09:22:06 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> __get_unaligned_cpu32() is deprecated. So, replace it with the more
> generic get_unaligned() and just cast the input parameter, like it was
> done for the kernel copy of jhash.h.
>=20
> linux/unaligned/packed_struct.h used to pull in linux/kernel.h, which
> provides the byte order helpers needed by linux/unaligned.h, so include
> it explicitly.
>=20
> With jhash.h converted, the tools copy of packed_struct.h has no users
> left, so remove it. Also drop the packed_struct.h and "#pragma GCC
> diagnostic" in check-headers.sh.
>=20
> Signed-off-by: Julian Vetter <julian@outer-limits.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261029091736.2874=
2-1-julian@outer-limits.org?part=3D2

