Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794807263;
	b=GVASQfbB0v+UVYDGDWZ9ZMzewi0Ldx7jqiBJi6OuOjiEQcLw11ZHohdlfzC93gwGutol
	 T6NR/b1mlOcNLiwUD1cwWAxcaIelesrp/A3UhlZwFAVh6LrNydzJEDBjAySuKdT3ksVAL
	 AQd1R9YZUaSbRMtgTHvD49gS4634+6l17XYHH5dIcQJgtXDTAsg/I0VfK5Hlqxtz5dsog
	 ai9K2FBAuGUmQ4cQl2rBok8WMjmDi8OkmTlZazZpZQtO53gJiwjjYXKROkqWHTtsWvSVt
	 P0RzlkdunLjMRx0ktKc08KdavO/M9YLdwLqkN9Fq0E7L0KzF/rhYeVHqJueoKyZu09g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794807263;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=Puhvu/VqKukUdpYrSeb/7sFhG19Gax7hqVqTtZ1a/VM=;
	b=1YGblr+9qJwtypx0/nOgx/4Q4tpIjjUrdzvQf0LnLsxLOmhJAMjCpx5p+01csh1cKw8n
	 T38LI09fkJe4uq4JidBEG2uRIMS77Jrxe472JDHcUbCh99kBktnl+DLu5XVT8TZJW9Nvu
	 cj5tmxbNDpq16sFA9bZ5ulJfvPFjsDVoVjpZjBgCxDh+Vh15aV+oDWottQz484gAGTw6x
	 J1+3rKKI6QNT6hhFk3O2u2Cy3mPSNEZUcH+BA71CEAmTxScaP6iwqYY3MF553EIH0ByW3
	 K/0s6sKBE2ffq/UTQ2aNNHbRoKReBaagxJGRJDsuXKS1zlIVdif9HPKThc1XvgRkepQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OO2MhFqh;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63E19606A888
	for <linux-perf-users@vger.kernel.org>; Mon, 16 Nov 2026 05:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OO2MhFqh
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD1D71F000C7;
	Mon, 16 Nov 2026 05:34:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794807263;
	bh=Puhvu/VqKukUdpYrSeb/7sFhG19Gax7hqVqTtZ1a/VM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=OO2MhFqhWqiPnsVlvZweM9Uul4mNdMlgf2/TLus1AhmLNdgW7Tk7QoPzW3eLw7RC5
	 Etug4UxGpUKyy8eATqXKNgjDeS3C7xFoFfn+HluENrlE+8BdZy3oyK5M2RALjovLA6
	 bjVqMbml+GSrJG0WIUQ+SQH8BWiHSUoez55BHM/qfsiC+097+TMQwLQL93GnosZ0/R
	 xr+OvHesjInniMHRyZLIF39CJ6wGtgg+FzRimLjs9ngQzKRtphXBB/gc0fsOmrZ8Rq
	 +H0etNsR23odIDjEORFSMw2g+ua4pJD1/nk2vO2YDFbpTKkE3UMgQ9oBrh3o3/LEil
	 tIqrUSgKL/rAg==
Message-ID: <sashiko-outbox-216214@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v20 05/11] x86: hw_breakpoint: Add a kconfig to clarify
 when a breakpoint fires
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?TWFzYW1pIEhpcmFtYXRzdSAoR29vZ2xlKQ==?= <mhiramat@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <179480681023.38065.9381486145352859573.stgit@devnote2>
References: <179480675130.38065.3086970856119381693.stgit@devnote2>
 <179480681023.38065.9381486145352859573.stgit@devnote2>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 16 Nov 2026 05:34:22 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
>=20
> Add CONFIG_HAVE_POST_BREAKPOINT_HOOK which indicates the hw_breakpoint
> on that architecture fires after the target memory has been modified.
> This is currently x86 only behavior.
>=20
> Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/179480675130.38065.=
3086970856119381693.stgit@devnote2?part=3D5

