Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793949001;
	b=pzRiNp5Zr3TmGi+iVdm2ksdkib2rT8O7Uaanrpj47kO3AEzhQKqIC/4pBroTJ6RQ5cn7
	 MPtUigY3L6nj8LlXNPyZ39bJTVLMXZ2Ny3xeSt3vAP2edzusRdLbHfGq7ND7w0nqQBGb8
	 xzhhrgJmUe9YfJKu7LKCvOo3QoKcShoOWKfNBDAp+p48y3fwm7VCIguioyN+oncMgalZS
	 il/ckxeZ6ZvQDiDQaD8ECGJ6yvopk1Umj3qU/QCEkoDdV6BQ17HmmvFGQW5ljBVHXGk9t
	 AkAY5HyhTkM0p8oGkPqauOOFoSnQVLCvp95NawY2zTfIYUGpLYwjtlqZexU0fZ+QbDw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793949001;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=gkndqebN8aRlFKvZwge8IV5ENapA92raFqWGkZf9ygo=;
	b=BUczYo9D1xKcDGu8IHeQPyUfprukp8AKeTV6wbuZFMN8/Xh+WRxpVT1zwwoY9u8YqBB8
	 GyfYYYHediTR4ZOmcNK+zlsD8Y6ZlJFDKZ1k7WVbFFAavTFepANyTvtI7fJ8rKz1pz0F9
	 diGYT8mGsVn6DS8glPeMz05j+aLg9j3mOVMzcUNnbvaz5L1pKjR9wsm4wGS0tWx/RTvYO
	 q0mj38daudwhCspVsOFAyusEIITGEuv9mPRNEi75hN3tpcVRNrURlN40Npcsxd8jFdac1
	 egj018r1BckNXUGxl2Ntt6jhSs3S8KBzG39Zorz2jWSe4pIE9HCTshI+yuXJ1xVYGmA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="V/0QhS5C";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB004606A32D
	for <linux-perf-users@vger.kernel.org>; Fri,  6 Nov 2026 07:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=V/0QhS5C
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 743D21F008A1;
	Fri,  6 Nov 2026 07:10:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793949000;
	bh=gkndqebN8aRlFKvZwge8IV5ENapA92raFqWGkZf9ygo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=V/0QhS5CiZQqWVJ2M89AEWfRHweE0oj3BkhTHVPWvgSfU9PYiDpKBaeTnD631KNx+
	 kDoLoTgQ/wzymbhf7d/vFLqDp0LUMF1AibByXylD7tqM5c0CBmsEACSRNFwJPcr1rW
	 gSBcVdoO0smOXc9U4rIbTI42657taKUUupV6hL/OgZJpbpFvpHaoCK1grYnA4GVA9Y
	 LXHMiegR3W9CTQuKqPvufu6HG0Akpx0mAbYeNLviGkxKfDSBRa6cg0Ex2Ft8Ww0HhO
	 HUQ80lzqTrZma5eAFqe82brRRSQ2nXhzmp2ANzCXS+AsOkHuObcmJt123I0injJeZj
	 SPBzrM7f60qYg==
Message-ID: <sashiko-outbox-200962@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 12/20] perf dsos: Use read lock fast path in
 dsos__findnew_id()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261106070344.329897-13-irogers@google.com>
References: <20261106070344.329897-1-irogers@google.com>
 <20261106070344.329897-13-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 06 Nov 2026 07:09:59 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> In dsos__findnew_id(), try finding the DSO under the read lock first and
> only acquire the write lock when a new DSO must be inserted or an
> existing DSO needs its ID updated (checked via dso__needs_improve_id()).
>=20
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261106070344.3298=
97-1-irogers@google.com?part=3D12

