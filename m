Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793949048;
	b=elIydLqu39zG+K8tGs/m1b8kGlv40qfklaJ35czB76PhQH1yX+ti1VPPJDWmWMLd+wN/
	 Kml92vPIKt+MygdAk+JpOWDa1KOlxNh8WepAg37gukrUHj1g5+hDKS+5uUTyDgHY4xoGf
	 u0pegKa0/PjKIVh9FIXCKmyRNnn3zaINSvNJxIpmqra34I0jt7lMwDBf5/J2oQIB7qRE8
	 fyXccgofI8euVqUFVV+Q8KZspee883iLSf2qR9klCOE56U4458qCEg0rNPaVA8sUyMGMh
	 1LtY+GhzV3MjINplho1D4VQKv4jpoTHWZRcxutCqtLEOmz9Ha4nh0qrUqCA6tXc/NZw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793949048;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=+6PkgPWcETlPW/tcTB4piQQ3vLvIrUexo7P/3qThifg=;
	b=cfqC259z5ye6FGu/TURZzEVb7XPhehEekglgik78K1wp80zG5hD5YgeurgRGBQUgS24U
	 kCrIVJHME25TVEnNa4MRUuV1n9HeyJlL6v6DEqckRuzy54o8lB31/nddi660p0MFngZxW
	 QqXdfZwcbaup+cunwnvI9WHBbbrmOuJXXf7CIzALH866sVcbpstsjHtaAZz212VpGRVJJ
	 w9JMq+BTOG9fscU/9YRbyUZGOgFjAoKcx2Wwh2cBobl6iaRYcJTtpgX3IJczWv9ctKJD8
	 MU3crmB5Em8V2L99DGj3KY5CUtI89vRgNSdE7BCHKOenWNQEoesujC0ONoz8SNBGwQg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DnwfIjAo;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D4CF606A326
	for <linux-perf-users@vger.kernel.org>; Fri,  6 Nov 2026 07:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DnwfIjAo
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76A7F1F0089F;
	Fri,  6 Nov 2026 07:10:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793949047;
	bh=+6PkgPWcETlPW/tcTB4piQQ3vLvIrUexo7P/3qThifg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=DnwfIjAoelXzXwRknuzrHpujpFbQVB7llvtDAEHZqhI4JqR+Xvuiqn++m3ia0PBHn
	 BuZQf1WxVgAc2hXVPYQaooBeScdaZKQuSW8W7hC62qDn0IVbehUWpzHP0zI/HyXlY8
	 FyX0f62nEJU0m4CtKVR09raEwZmYnpQUElmR4V7J+uNiz3fFYDP99PEigpSfhzDdqL
	 meSRQhGHIc+jRPcMEkS2YDwg9rwRFfZ5MC0l6glxS2dw3rrRwP1LIS1AQsUBcuF9Br
	 WU16yFioylhIQ9oaPJwA9BkclR9FV/nmPLye1UhrXNwZGSOvMYGer18JTZwyV9//2F
	 qMe+YDZ46Qk+w==
Message-ID: <sashiko-outbox-200967@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 06/20] perf comm: Add __guarded_by annotations to
 struct comm_strs
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261106070344.329897-7-irogers@google.com>
References: <20261106070344.329897-1-irogers@google.com>
 <20261106070344.329897-7-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 06 Nov 2026 07:10:47 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> Annotate strs, num_strs, and capacity in struct comm_strs with
> __guarded_by(&lock) and __pt_guarded_by(&lock) so Clang verifies all
> accesses hold comm_strs->lock.
>=20
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261106070344.3298=
97-1-irogers@google.com?part=3D6

