Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793940889;
	b=bbf1om7JzE4zvz5g81FOFhDp3NIIbltA8nOG7kNxm8vYOeb6iBfSRoeyOR28D1tMODOf
	 AWFjZ4vLpRf1CyfGyjxPboYtn6I1ikSGo1rnAeCl23ckMResj1zzh86sKSizO+SqH0nnp
	 MdWd2839B6U3nAZkIvpg+DOc4eRsIxdmQj7fhDRdvip/UHXZwF/3HXomiNVGzZHl7KPSS
	 XkPZKiy+pKXgftx20hesmybeQ+415hpQlwf69PyUAzkTSvTyaYBqPe225Zm6Z3iZPZdJK
	 0IiOPZWGyY8sb9B8yPgysqApeIsvw6CuHMRB7JTELySegiLG+N5vSwFrZTOgaUYj8Bw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793940889;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=gHuQASwUVAQLgTl1pSbO+e44/F4aPQxt57SJf2QLhig=;
	b=vyuL9tJxOgMyjKvMptasFlZ9kvg5Wh+4QzB7hL9v82wWJj/rdzT1MyOFUT2CgJ94WyRh
	 SJpp9ltBol5s6DM7Dtn3YoKUsar4tcVaBf4O7hmf1ISLnih6qsVwAj6/GQuy8pCS6KzaS
	 BKOW1FwZbV/QEysBcdOXHv0VhjWn5FUiKSoRi5Z4HSG2IXwLgfqUzGljR24xKZss21MLs
	 fw/JYUMSrOJD6nwQIFk/SfFlCAR7wEk1PRa65lkqrFiGYofTEfxyfhq3kKvV627XR38Wp
	 V/TASVvNaWCasRWSbxw66NTNMWHjfTJdUS80zeDkO5wRdsFMKXdCO1gVYc5AByMJnpg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oSX619cF;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B19CC606A31B
	for <linux-perf-users@vger.kernel.org>; Fri,  6 Nov 2026 04:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oSX619cF
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A0A41F008A1;
	Fri,  6 Nov 2026 04:54:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793940888;
	bh=gHuQASwUVAQLgTl1pSbO+e44/F4aPQxt57SJf2QLhig=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=oSX619cF+DRSAtBpI8PzfpBWSXXzrXdGcI4EzDzubZBkxT6LQpbAgj/x9sX4hqDKZ
	 A1uh8rRgejHM2qXDSwqAmfDMXKxQMgjbp2m8rbgCvkHIR7ql3KpvajmzSZpbJLx3f0
	 j/RamIUU/SMagUO1K8TST09M2ZnqCFkk1UnACeouUpVnveXAvHzkhyOrb2iDmMlf0u
	 PSo4kFPPQgb4or+0v+DYWdxH5rv7us1sXWbQgyTebt0SvwZ223yg0VNpg88pDZclJf
	 bImMXJ00+AmqhJOQ89oT9lbTw50yQ1Th7dVUWTOF/Xwpj8lwSVmtJv6/Vf1KVMkQcg
	 81xiYkGjmrCOA==
Message-ID: <sashiko-outbox-200778@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 06/14] alpha/perf: ignore overflow interrupts the
 counter does not account for
Reply-To: sashiko-reviews@lists.linux.dev
To: "Matt Turner" <mattst88@gmail.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261105-alpha-profileme-v7-6-c474e892abb0@gmail.com>
References: <20261105-alpha-profileme-v7-0-c474e892abb0@gmail.com>
 <20261105-alpha-profileme-v7-6-c474e892abb0@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 06 Nov 2026 04:54:47 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> The interrupt handler adds a full counter period to the count of the
> event on the counter that interrupted, which goes wrong in two cases.
>=20
> Rewriting a counter does not cancel its pending interrupt: wrperfmon has
> no way to, and PALcode clears the request only when delivering it. An
> interrupt pending when an event is reloaded, or when perf moves another
> event onto the counter, is then taken as an overflow of a counter that
> has not overflowed. It adds a bogus period to the count and can emit a
> false sample.
>=20
> And alpha_perf_event_update() already adds the period when a read finds
> that the counter overflowed before its interrupt was taken. The
> interrupt then adds it again.
>=20
> An overflow leaves the counter just past zero, below the value it was
> written with, while a counter that has not overflowed is at or above it.
> Ignore an interrupt for a counter in the latter state, unless a read
> has already counted the overflow, in which case add nothing. For this to
> hold, write the counters at most half their range below overflow, as
> armpmu_event_set_period() does. Counting events then take an interrupt
> every 2^19 events rather than every 2^20.
>=20
> Fixes: 979f867191f8 ("alpha: implement HW performance events on the EV67 =
and later CPUs")
> Suggested-by: Ian Rogers <irogers@google.com>
> Assisted-by: Claude:claude-opus-5-5
> Reviewed-by: Magnus Lindholm <linmag7@gmail.com>
> Tested-by: Magnus Lindholm <linmag7@gmail.com>
> Signed-off-by: Matt Turner <mattst88@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261105-alpha-prof=
ileme-v7-0-c474e892abb0@gmail.com?part=3D6

