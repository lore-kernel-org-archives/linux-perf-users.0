Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792623041;
	b=CeG35/gph9E5NKP6MkMayMZ8PIJCYJP+6DlhIepS3I+39KIKTLwsAYP8gK9lxgdvRXk9
	 NgrdkgUwLW7RYazR9eF8uV5lJoEzkkkNwYyVttA5mvuceMlmNV8hgvE4zmD25NB+ezWHk
	 KiSvXM9lkW3fB82td9NrZTNaXBFXKadLDEFOYVSRrOdKofRcCbDwzE6SA/lqr3I/J9imp
	 ohE9kkwvufohTbOReiuRdbrwsrGsXviQeoNB+PBzv1WtAhOqbmWx1kZdBK93UXg5CjKDA
	 DlPx/FJR9phKBhcBxAApRh2ACd04wjIo2Qmx63YxxwF8n3asRM84kQ95PgEk1cVQbtg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792623041;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=I9m+NROX+2l4RdrG5c7uEYb+NfB4E4zmQ7YJ8baEK7I=;
	b=GDOpbVbImK58MjpbOSIyU2sL2Xe3FqZutTUfXtQr7HENC5rG5jp/CPXYYmAvjinRGpqV
	 DJH0GjqN7mbkK+FQdBubgfrlwwl32GbmN8q0gY/u3Jmpaxy6fa5rp7oC7pHDcpZ4G635E
	 c+CTT1PVBLjim486+BfsveDN4oB94nKU+wsitLrL/iYFJuxOGv98mxy4vKXD45SoA706J
	 NlUwi79YLUO5mb+/5wpra3jL4r43Kj4cqoKzjN6jbDrYJ0HiIhvh8w3CGW4wV/syu0K1O
	 QTdGws2wz7Qnt1fx8IluVdujPcO+nBXiGuHAqD/Wr4GzX5DJEiMIhuTuMkSom6Fo2jg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=N1FzU0MS;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFDD1606A319
	for <linux-perf-users@vger.kernel.org>; Wed, 21 Oct 2026 22:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=N1FzU0MS
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AAEC1F000C1;
	Wed, 21 Oct 2026 22:50:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792623040;
	bh=I9m+NROX+2l4RdrG5c7uEYb+NfB4E4zmQ7YJ8baEK7I=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=N1FzU0MS/O4DQm+m7JwLTdn51aAfrcv6rSEjHL/v09WMtD2Hd6i5VOnrk2h78/9eN
	 NnZ2CfE9A8EYr2TGG6yORfj/hwFiii0RfxDsxq3ihEz2WBAq4qpvFW8aHPv8OxYTIQ
	 xoZzl7AQFUSZnCrSN8ZlIByLjZr25LB14o2s6+mEWvcWi4+PHi4WI/a/ShFxpkYLut
	 TeyZGEcPFCGDYRjzXf4FXCe6RG6qJhiQ/gU0gp7goJJPltUYA7EH7vG0K0xreOsWAL
	 6rKT/ovdwxM8rw3tJafigvu+KqTnyh86U8cxsztJDKsNm2+4KOWVovqJWTyRAnThyk
	 WHzh1IbzhR4TA==
Message-ID: <sashiko-outbox-180743@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 06/17] perf comm: Add __guarded_by annotations to
 struct comm_strs
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261021223905.715051-7-irogers@google.com>
References: <20261021171044.155240-1-irogers@google.com>
 <20261021223905.715051-1-irogers@google.com>
 <20261021223905.715051-7-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 21 Oct 2026 22:50:39 +0000
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261021223905.7150=
51-1-irogers@google.com?part=3D6

