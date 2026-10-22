Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792700756;
	b=p5R4LH87NtGKEjAU3IDZKKzH8l8fYmEZu5TbHWWxYWqx6OJvnxBGoo2dhbynNabxGHdq
	 54z+g4SnnmJrHfzH3+aIRcOe8FpTT2ZLTOMVKwO/yCWuEJ427mBLxleyrcjGyZ7Lz2mbK
	 sZiz5GSYgHEpSD3V+N3n9PtGu+Gm3eJwG8HtK074NHrHCrvpEckLXDxLMxcEVQOGaQ7UC
	 GiFSv188BlS7Hw0PQBueIA/PkHwF9zhQ30BvEorO7v+02XwBG8hLSjNBLb4P5x87VZ5dT
	 nwHIM27igMWPTVvCKC0zJ5hvPtXx4qGCTe0yWOiq4ZU+ZIeY5EPq25gBiGf2qGkp0Nw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792700756;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=r4ghV7F/0g0T/mJcpqllSxJCELyIydq5ylmdXvZKSRM=;
	b=RXNo6PyC8YGZDqEBHzB4VJmaC2kAubLEXt/ZbgJi1ieOOQgkVaWwpv3T7QTZ1lC9s2Av
	 jPCl3eCrlXWMEiuZKijt4pq/ErvhZCjdSeWQZoZMNy+gIhY5tNDbu3/lh4rTsw+lEbfMa
	 6bxv+pBjiBEk6H/EV+qRB173I545dHzN2q31TQQmYrUiD2DMCEUQnF61TOVOr+ueK/jru
	 wQ4YAvq86PimnoI2z0CPdsN45d17YNaw0QutkXChHpzD1b37V/BVJ1O+41787hQvN/P7t
	 6IMtjOsA3LHCFwfLWuJfAoQ8ptR++4H0VnR1zkoclnTZx8SanQFTd/znwJaOZdHzZOg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kTBP3G+e;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9BA6606A31F
	for <linux-perf-users@vger.kernel.org>; Thu, 22 Oct 2026 20:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kTBP3G+e
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 331611F01828;
	Thu, 22 Oct 2026 20:25:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792700755;
	bh=r4ghV7F/0g0T/mJcpqllSxJCELyIydq5ylmdXvZKSRM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kTBP3G+eZlv3SjE31Ykoqufb46fpe0ggJWLteDUlVuGyqpad56CrISOMV/l6EW27T
	 oSgaIHGGTyLNZ/PcLRPSUv/OqW2lDvjUe8Ca+mauyYPONWUQ/xAi0CcK9L68cre/X7
	 Wn2z1xK/u+7odhd69GePIVmdg4SdOT0dpdlqNcFYY34ojJrrJI2Pjli4+s6jiOT9JQ
	 8xc+LRrx2/HDJz1c7b4SXJx+akwCAps2jsAQLsqAwuJ4CvQ4qmfm1+S313XgOd2Jiw
	 IqPf94arA0fXFwDiG/V1BTwr+LSle2mmm1gKz0mKO0abzfBePv+51ixi9vXnqrPEQT
	 axVN2cP1dpNaQ==
Message-ID: <sashiko-outbox-182000@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 18/19] perf maps: Fix lock inversion in
 maps__load_first() and bounds check in __maps__remove()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261022201453.1717523-19-irogers@google.com>
References: <20261021223905.715051-1-irogers@google.com>
 <20261022201453.1717523-1-irogers@google.com>
 <20261022201453.1717523-19-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 22 Oct 2026 20:25:54 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> In maps__load_first(), take a reference to the first map and drop
> maps__lock(maps) before calling map__load() to avoid a read-to-write
> self-deadlock when loading kernel maps inserts extra trampoline maps.
>=20
> In __maps__remove(), check that the index returned by
> maps__by_address_index() and maps__by_name_index() is within nr_maps
> before indexing and removing the entry, and remove from maps_by_name
> before calling map__put(maps_by_address[address_idx]) so that callers
> such as maps__remove_maps() that pass maps_by_address[i] as map do not
> use a freed handle in maps__by_name_index() under REFCNT_CHECKING.
>=20
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261022201453.1717=
523-1-irogers@google.com?part=3D18

