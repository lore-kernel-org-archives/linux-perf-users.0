Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793738638;
	b=1CmHGY2Lks7ecXwJ9PzLC0IUB/gq657ThN2pLa/joIXK0O9rF44kw0wv9SmBc+TRzdn3
	 Ig4B3S5xVFZ0vUqNa2SHqwH2+FqrY8UvApKEXz+08H8f+VNpf58xqhNpK6HM0quzI4TGo
	 /yy2J4v+nfClvMvEvprNx5RfUVhJOZH03TwSSV6qnnVHc8ec2ZQtnfblgk6bS8WacggxP
	 /zV9LW2U8l14dRZ6rJHQsQDWgNbaxzu87whkue3IObn6IjntIq1JL95qGkYxhDV3vXLjc
	 3HJhP16C7w2fF+DsV7jNWRldTW7lHjjhwxSZBi0Oxwo5u/d/ozShceIMZLlrTvCay7Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793738638;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=ycg/FJoNDwWScet17Nm/UwZGshkzLJaAk0Crkj4hQ7c=;
	b=phymdAR+FozMgv5Mkj5XTDXzhWpknA1Rib72fj+GQjD+ZeEXOjtPx86MMIzMSoAggyO/
	 9524O+5NKjrGyPEeZVVQV3pWduUXc/eUma2Pi9PUVTmlMOcHyVqXyDq4RHkjIGXq2O4RF
	 wEu+yq8ZSoMhLbEgG0djuWL/Q96XOdThmc2DCOPoMuie6VOTmad0rQ9zLWwkXTPC8JznR
	 0Ogf1gnAfWM5BzpBY3Qo9UvbaWcbv++QGQXT26+RzN9ZUNv8zeKpr0c/NFoPDeg4pWe9y
	 cC5NY6nB89cY3RemHWbuMs1obk7Tv9ZUP1Qcv1nx+2svIM+ERo1kfrsnW8AuKuTYKGg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="J/BSFzBi";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D05A6606A31B
	for <linux-perf-users@vger.kernel.org>; Tue,  3 Nov 2026 20:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=J/BSFzBi
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E9F71F000C1;
	Tue,  3 Nov 2026 20:43:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793738637;
	bh=ycg/FJoNDwWScet17Nm/UwZGshkzLJaAk0Crkj4hQ7c=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=J/BSFzBiH9ctpIxmCBCJS1p78fDAPM/zaKHdUx1L1aOquFKVLHV60+UbWNopk3tDO
	 emNE4MzSgDb3q5PJgjH3NKt/WSn2VJbnOPugJZPNXqXfbhA4etznV8KjA4oV5GlcXV
	 4iMh5Da3749eEm4+iMRVVV3tXS4fUq5/OgpE8z9dgTmPaMgxTDipWjfE2pjAkx1jzP
	 N2ZmSEpxrh+J05M7Dre5IUcu0TdQWt85miat7XluOwD8Gda2GuAvLvH/ELYrM5oTRE
	 Ysmb8TREWp1edI+fvKCheMJLGvbIPb3EwBXxiMB+LCH1mDGXKeRrAbu/lYol6ySAOF
	 roW5gI2EvlnZw==
Message-ID: <sashiko-outbox-196008@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 10/11] alpha/perf: add ProfileMe sample filters
Reply-To: sashiko-reviews@lists.linux.dev
To: "Matt Turner" <mattst88@gmail.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261103-alpha-profileme-v5-10-bbe3937fbf3a@gmail.com>
References: <20261103-alpha-profileme-v5-0-bbe3937fbf3a@gmail.com>
 <20261103-alpha-profileme-v5-10-bbe3937fbf3a@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 03 Nov 2026 20:43:56 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> ProfileMe samples any fetched instruction, including those killed on a
> wrong path, and what happened to it is only in the PERF_SAMPLE_RAW data.
>=20
> Add three config1 bits that keep only the samples of instructions that:
>=20
>   retired     retired. VAL says so for an instruction that did not trap,
>               and the trap type for one that did.
>   mispredict  were mispredicted conditional branches.
>   trapped     trapped, mispredicts included, or caused an ITB miss,
>               Istream access violation or interrupt redirect.
>=20
> A sample must match every bit that is set, as with Arm SPE's
> event_filter. The driver drops the samples that do not, and they still
> count as interrupts for throttling and frequency mode.
>=20
> Suggested-by: Ian Rogers <irogers@google.com>
> Assisted-by: Claude:claude-opus-5-5
> Signed-off-by: Matt Turner <mattst88@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261103-alpha-prof=
ileme-v5-0-bbe3937fbf3a@gmail.com?part=3D10

