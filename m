Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794873375;
	b=5jqQfKk9xCEVlp4Kl/Gcw9vsVQ4bXczn4MDHfS9x+ug81/fzK7Pv13skOKdIQx2eHqUO
	 lCnkndhbUk/X30toRSIcrBePOX64Np+uQyrZ+FVdVyI9eEa9veIAOm+bp4swyIIW8UZqR
	 CeVdUbTXqpMwBbyPwcEPdrmkmTVjtpw7sgOLZcMcnK+mGokiXWHPhx7rzgmRjB7MdSqJ3
	 hMf/rwz9aRCKuKI9m8MH0RKAJjxqOg8snQJzDDSNkn8sTpVAFofD/Duo6lT3c+2PKcUsU
	 fPF/qx6nEi8tZpd35VzBn8eK/L8Du0ku8MGI77qBFmVp6LCzlTvOfccjygarpUGxZsw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794873375;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=xP7wRTeo4HCf/CNNhCegur8W1umj16BIBy/nwzQQbvA=;
	b=ZEWwUQWyG5Xdfx+C0rBH9EXK/3hYePAv8nuednJVRwa5Ef599rs6lSQnffbMRADnwpqN
	 jH67sdg/XYs2hIvxMAWFydY6IkjNrCu3/fpz1aYxUojKfAbObL9nLAZl2p+0lm/Kddp+n
	 1R5WP7tzjtAeSyBwfaqR3pkQdryOl8VyUvjL/cBGkUTNrjSj/XbVzZV6EZo/AafbDPyYZ
	 bLZT4yuTw1VGDylco4XoqMrWmb4/yrFuUNMT/iuWyXds63f+GAq5DRqvOEw8qrkR9Ig0a
	 p51MpC3nwmBvAZPfNaYzzVZObrVz/qikp6fdtRF8ZxRw+fdaBvBLFJV9vRuS2bY60OA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Y6LPerj3;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65796606A32F
	for <linux-perf-users@vger.kernel.org>; Mon, 16 Nov 2026 23:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Y6LPerj3
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24C491F000C6;
	Mon, 16 Nov 2026 23:56:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794873375;
	bh=xP7wRTeo4HCf/CNNhCegur8W1umj16BIBy/nwzQQbvA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Y6LPerj3l1d+pXcua68ThnCTvC9TV/d022pa9st3fQNO3s7TJ/So3vj4GlJEi9Uxs
	 PtPV5TME4b51vV9XSXZpWjUc5TpQvXK4EAqrm5pBQXJFASjFI2Z4fJ0luZEDf0YsNT
	 cg/VBhUsb4zQgg/ePV3FIcaOQxKnKMuZqE9T9DTBD+UJmyRlwxpO8s+0AQYFfKZpkm
	 scvalh9fVhPfgPDi1PhPh9JFpxD/dOBm1VZrScdi/Jrz8JGqwCDecELNwF2yPzXViB
	 xj4QZ3tejAEJHvonumW6NprjxXLFbcJ+t6UAsHFOG4dIwn0lGlldOUNhcqmb589PRj
	 Wz5xPMBzgfpyw==
Message-ID: <sashiko-outbox-217946@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 11/12] perf test: Drop samples without an IP in the
 dlfilter test
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261116234659.3950531-12-acme@kernel.org>
References: <20261116234659.3950531-1-acme@kernel.org>
 <20261116234659.3950531-12-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 16 Nov 2026 23:56:14 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> From: Arnaldo Carvalho de Melo <acme@redhat.com>
>=20
> Since v7.3 the kernel zeroes PERF_SAMPLE_IP when a userspace-only event
> skids into kernel mode, so that kernel register state is not exposed to
> an unprivileged event (166f10836a653dfa "perf/core: Fix kernel register
> info leak via hardware skid").
>=20
> The test dlfilter keeps those samples, and the check that nothing but
> test_loop survives then trips on their lines: the comm column reads
> "perf".  Drop them, which is what the test wants, everything except
> test_loop must be filtered out.
>=20
> Fixes: 199d5e872a9ce737 ("perf tests script dlfilter: Add a dlfilter test=
")
> Reviewed-by: Ian Rogers <irogers@google.com>
> Cc: Ian Rogers <irogers@google.com>
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261116234659.3950=
531-1-acme@kernel.org?part=3D11

