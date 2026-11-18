Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795039388;
	b=0mnEKweRW/dtDgSluXiQmN5IfexN7g7U3/48AlS74g5+pnxPEXw0waErp1UF07Wci2vj
	 m13uJqjkw3si3LlHKXu3thhTLy3PQDhSBZhbaGyvkgQYBbZ+ukzURcn0RfnjqmHb5TCqm
	 u8WET6YdwM22rmpcNMyR4WMZQ/F++r44Pxz+cjHW+bmwbZfKtUBDJPyimHB3Xzyg/dsbA
	 +CRUJ0hYA7E5p74ykvdSHPsFQrep/+E8h1sgqSoH4H+wbEMG7I0AsaugsCEoKw9I3OsIL
	 vbIzrWlh9JgRBAq5J4jSgeWOBnHYSbZSlrKJYo+SeZTbRzZYVk7cG261mCNboW22OAw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795039388;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=LR+vaYSHZQipXC9LY04hBNXteg/Nll5vIohNm2JXKdE=;
	b=qQxBWHiRNFQvhrI9+Qcppqg/7P/MFMtaSYNpu1PI4WVbdPbNxjmXjcG3+eHoHlhUzxTl
	 U5VLKfGZ/AKRDFMrMwBdzYjdptwNbMJXFHM/e6LX9ee8vbxBTukB+08jTqpITIwKtbC59
	 oeaZGJxnM7LGhwicg7wzue2BE/KRuoC10q02/SrgMgTqp/swrHdIpN2xr4dQJZbuYhEuG
	 IxUjzDA4wjbE6cn75Ad7e9DTIzucjIMALhKA7CGQ+Y4S785dtAiYrH6n9EQIYFnj31M/T
	 8VxN6L5qtpMifuu7PDss6l00yxoUyb1Wsyp3QxayZb/5PagmUhcOjizZHB90fxie+8w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=odEYXg87;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D13C8606A320
	for <linux-perf-users@vger.kernel.org>; Wed, 18 Nov 2026 22:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=odEYXg87
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E0F51F000C4;
	Wed, 18 Nov 2026 22:03:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795039388;
	bh=LR+vaYSHZQipXC9LY04hBNXteg/Nll5vIohNm2JXKdE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=odEYXg87RLhK/pYww1gg8p290UvfHRxngVuqLEyZtR84b5qWTTJ57kTlhXzhOVsJ/
	 OBiK2YxHneGh93xvcHH8xGfkF7+E9WTbVSlDlMw9sznh6yOH4svWnaHhkcLuPgSvPb
	 BOuAoHeEB44cyLCZavSwcaxG0533k0M7MKQnspPWAL5S0xlg/Ns0t+9w56zYtyuwrn
	 TES/00PtdOZkQZLu5awbGgadT58NGAkP0NMxZsF8oEaScFTZSFudG5g5TT7Oe7Y3ke
	 ZA2sjr4il6r06syku6cMkLVjbbN/qbrHPiTzGf3YszfzxBy579BELOMx/zpk8Uh+yQ
	 EKLC/T23+VUUw==
Message-ID: <sashiko-outbox-222068@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 12/13] perf test: Drop samples without an IP in the
 dlfilter test
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261118215716.114868-13-acme@kernel.org>
References: <20261118215716.114868-1-acme@kernel.org>
 <20261118215716.114868-13-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 18 Nov 2026 22:03:07 +0000
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
> Since v7.3 the kernel zeroes PERF_SAMPLE_IP when a user-only event skids
> into kernel mode, so that kernel register state is not exposed to user
> space: commit 166f10836a653dfa ("perf/core: Fix kernel register info
> leak via hardware skid").
>=20
> The test records without an event modifier, which is user-only only when
> perf falls back to cycles:u for an unprivileged user, which is why root
> runs never saw it.  The dlfilter keeps those ip 0 samples, and the check
> that nothing but test_loop survives then trips on their lines: the comm
> column reads "perf".  Drop them, as everything except test_loop must be
> filtered out.
>=20
> Fixes: 199d5e872a9ce737 ("perf tests script dlfilter: Add a dlfilter test=
")
> Reviewed-by: Ian Rogers <irogers@google.com>
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261118215716.1148=
68-1-acme@kernel.org?part=3D12

