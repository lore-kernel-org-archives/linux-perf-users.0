Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792602966;
	b=Rvo3FwaCKPeDy9uRzlpeY6xatIY31xyaxreUKl4kESPEZVa5a2xkbIhW8Ln/RjfhwLrF
	 Ehly2lLwHfMMJDRTLLKDd7715a2TWbbDIT2unT8CarT0Di9c8w6cuZQ9nlKJrWlHjWz0/
	 8KA/QL9HZi96waGNkJ/rRivhfQZww+dm/Z13mtFw79EVNrRyA30P4htu0Drm1KRBWM+Kx
	 MYjvI3APQM6H787rEIWlGWGyQn8l54JocSA5qYbV5DJtIV4x+Av7ldv7EZ9JfwLTgMZzo
	 /veqaAQUxDGhJWGa8b1pKulaqAaj9pvAv+G3B8xg3YD1oCm8X4+JnijtR0NeW3kgppg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792602966;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=AwbNcwzcz3CSVUL868NcC0/X7ls6gUKvQe7lEmCCFgA=;
	b=EB+oYykDRNrSn5z57wusEKCB9fSPdCFBeXr9EkPDSvSn+YmRjWPbDQ2ok0uwkcUTuFAd
	 FLM1yvw5VCdmMYojz8+npH9fZelI6H2vUn8VyaivFr/1iH84YIKQMVm7EoAQmTqsqWAcT
	 8J1Zw7ap2HT1MrR0Rsp9TxGC0qZ55OGL60iZWn+VWFE8KmjQsHmzvE2l6kyFEcJc44ERL
	 c8taRTwqZuP5+41Pmxorg1MgEFDFpVH9VBj6WP6N1DjfWLtfic3MI3xur6cNugrMs6zLC
	 AgMnHUMZ+jNyBc694CvvF/9Q2IgWKUMccbIgPppI/Tex2xO/wp4yRvlGHp9YavNQ5CQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YIMnYStM;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40782606A31E
	for <linux-perf-users@vger.kernel.org>; Wed, 21 Oct 2026 17:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YIMnYStM
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEA6A1F000C1;
	Wed, 21 Oct 2026 17:16:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792602965;
	bh=AwbNcwzcz3CSVUL868NcC0/X7ls6gUKvQe7lEmCCFgA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=YIMnYStM05MsTs6ketyDcGWuNH0L5E12I0x77qn5Fn06ntiT3ZSV9OjljElEZ7FlO
	 A5fhJnQE8XNC2UQUGcw1dIib+stf2Wbkh70G9ZytIc0lMJ91bG+5C1CTvps1zlbXxv
	 ooN6lIP7q29TzvaBgSyq3xbWHvtOSRw0wFVZCBLF3Q0L+BB6RlE7fix7HROu1L5Hpj
	 t4EcT54yEp0VbKW5LkAuwK4ngmkOqG97MUNhCsFZecJxvyNNQD/Q9Ab2oiNs6FXQDr
	 skYyt1qK/LZp83qi2tGyskGG7viD6YGOAPYE2PeUpmbV+eePbG+B1oUBlvMaKCAawy
	 Bbzl89cPn6Umg==
Message-ID: <sashiko-outbox-180502@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 14/17] perf intel-tpebs: Use DEFINE_MUTEX for
 tpebs_mtx
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261021171044.155240-15-irogers@google.com>
References: <20261020163640.746159-1-irogers@google.com>
 <20261021171044.155240-1-irogers@google.com>
 <20261021171044.155240-15-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 21 Oct 2026 17:16:05 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> Replace tpebs_mtx_get() and its pthread_once() initialization helper
> tpebs_init() with DEFINE_MUTEX(tpebs_mtx) and static initializers for
> control_fd and ack_fd.
>=20
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261021171044.1552=
40-1-irogers@google.com?part=3D14

