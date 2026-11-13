Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794606904;
	b=xP0z+8hpc45no2qDJowSC+nJj1CP/8s20YjemM0aJ9ltetyujSOXjLnbBtdLDHgnrfYg
	 siK4rKSx6TuxtarLtFnXThmhlfyO1JHA4tKYARa7L3z3r8amKjd+2I9AahSRx25Y/P4Z0
	 elbvXXNvDwk5MLxpOmFA3XVw0v9XsfX0WcsJlH+8BevDRMqNkkzKqo+Mnrcny7MJu1UIr
	 +Z9t+B2WXzy325zWjiMh3ClRbx3llIl21JEWKCmceoZ8I1giUqfwDkodw5tK39p6l4Aw7
	 OxADlelhOWhhpUqeFOZjmF1sKn59kK5i/XBsSu+OM+NEBm9rOvMZdg6HG46XBYOlO6A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794606904;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=uwN9RzFYCAX7o54kaK7j/i7H8RPY3mJYI9kOWQ1aMCc=;
	b=FBZOke7YY7kp4RVaopAZyg97tZihc8QNIInRoygn4/Huac60zzXRIHX9+ZqfxCTj0WVq
	 jRuu8fBZRz4oMHiCQYsf2288F6rKbbD7kAqvqwQYG+Ftalz0tIaRxTsTbvg0WHfqbDCpi
	 ss7dAVVCoi0aD4QQ36hJf1isQFm7/fBAUcL6EQHnbDifeqr25n5gk0BidApIPYjXIUUvF
	 YelPx7x3enBmhnFLkryioF74l2qz9F9JUve5K5y6BaADZPzm+d9ud07w00o5hjVd8nCKk
	 QMNlcuPc6cZo+qIoZnqHIeVzwo7s3RcO4xHIpT5nanPNHEE9Cf+9BwthccYqclOP2mw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EUhvAQUI;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1EEB606A337
	for <linux-perf-users@vger.kernel.org>; Fri, 13 Nov 2026 21:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EUhvAQUI
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6C971F000C4;
	Fri, 13 Nov 2026 21:55:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794606903;
	bh=uwN9RzFYCAX7o54kaK7j/i7H8RPY3mJYI9kOWQ1aMCc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=EUhvAQUIVUQGBJt7Ro+V0pxEQTMtV0Otrr44D31Lz+s3eQMlOoENwSFUTzXTQXOht
	 7HuYMdJ7ZYbhIWEippRmaySMZqQ8i8e+J6byXyXtXUDed+TMLamrXs/xnE7q+tVtey
	 epY8dT2wCQUc82G40aPXtyfjlBRAGEbvvUd07VPQ0bWy+6NhOFWuaKfSaCYMQgXjB9
	 0/zUPLdxfIKUhRwYBaNyl/GOqVdMP9nlm+T0l1wXeprOihjruMR+E+ypD2mEKxFbTi
	 BuLZLdsF3r52nz2PgzVNLTA3AMfGQwYMjD5sxpX+HUITWKmxnL9AIrHr7OOdqlB2cl
	 4dtP+ga9aEPwg==
Message-ID: <sashiko-outbox-213745@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 03/26] perf stat: Fix per_pkg_mask key leak on
 hashmap__add failure
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261113214850.3329699-4-irogers@google.com>
References: <20261113214850.3329699-1-irogers@google.com>
 <20261113214850.3329699-4-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Nov 2026 21:55:03 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> In check_per_pkg(), key is allocated with malloc() before checking
> whether the (die, socket) pair is already present in per_pkg_mask. If
> hashmap__find() misses and hashmap__add() fails (e.g. -ENOMEM), key is
> never freed.
>=20
> Free key when hashmap__add() fails.
>=20
> Fixes: 034f7ee130c1 ("perf stat: Fix wrong skipping for per-die aggregati=
on")
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261113214850.3329=
699-1-irogers@google.com?part=3D3

