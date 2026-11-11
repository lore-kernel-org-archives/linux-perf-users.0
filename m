Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794430887;
	b=AAiTCxB86nKZe8Y36esEd4Tu6Iy2V0P+R0ME3cgXjT7KV70zmXsequil+0WYyx4iG9N2
	 8NU7ekU6h3Eqynrg6eIoJM0TciUY20GG9Ckg+R0jHhB8pOmRm8a+L8+PPwywlngj/w2YJ
	 ojZgKn0gmI7GufB/0ZTtqph4Rb0hq8pifK4EA80lMEQiXJ1IbgfSirTvO1e3+jYCpKC5m
	 HopqFHDxzLCxOJpyebhUw3dgrfcfTpa0N+5rvLCdBFR2rTUqIgv9XCToZ9E6SyOEraOWN
	 uxo+q3IacdqoUjBTKM+aUyd8UeZjv5R0Mar1pHux6J14ol7Ee5yOPnH0pWcFRXGQSpA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794430887;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=EVAcZLQzMZ1JVP3wXddV+KRxrEHCIOXTPAdEs+oqKVY=;
	b=lSOd4fPM0DVbH61ZXE8DoVGXmKaZbWePk3EdPqHnvUy1GELeTmqv7qgaouQhhbn550wv
	 Lldy/1EOge6ORBAoUG7z7uyBwgxmCVnixEewOoMwzFDiWqzkMcoI+z+ER4pfSDUX6zSOk
	 kLcBDzRe+L/HHMuchkLuBEtBR9uK/o8day4xmO5Ad9k9nzWvaFspm/QL5Pubmmd+P7oez
	 RdNj9jz52kaLy+oBPs+5ckcCGOHei6GsrHDhqsz1UqRbhG44zBOsBEtyCfGjjs6vmuapw
	 HEmDVoS22dszZ7Yh97231Tnpfb4w37vVNGpLZVvNFujFpDUOgN4arbqZXYQsECuF2Pg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Dv3AgEsk;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BDD5606A31C
	for <linux-perf-users@vger.kernel.org>; Wed, 11 Nov 2026 21:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Dv3AgEsk
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98BEC1F00A05;
	Wed, 11 Nov 2026 21:01:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794430886;
	bh=EVAcZLQzMZ1JVP3wXddV+KRxrEHCIOXTPAdEs+oqKVY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Dv3AgEskqYzzI9gP981/0kbCuDfOl5soZjLEkryYaehrY6LmF72P6zIOtTtWMWDZO
	 OfOcB7NAk8G9flT7AwMtr27nyeXOEQ7HJItRWJ/tx2GbEI/t3BHoTuRDsY/bKDYzLW
	 jaR3AOfDMP0DA8YmmomDjgHq6Pt+An943G++FtYP9HD8azjic+k4wfMDDxowV8iYu+
	 mDpo10d8N3wIRwegL8btZ9+Hj56oUPYOmnMTanpxYDf+lwagrlCB5wI4ucVxvULg1z
	 JJCDHxEAvPnq2eU05PoRrgiZXAG0bvl28ztG8UXNHgvEnIyKKMyCjE4gLIVfaMsu2q
	 7Zx7NOMy8ZAqw==
Message-ID: <sashiko-outbox-209684@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v12 17/20] perf config, intel-tpebs, env: Add
 __guarded_by and __must_hold annotations
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261111174213.3526604-18-irogers@google.com>
References: <20261111174213.3526604-1-irogers@google.com>
 <20261111174213.3526604-18-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 11 Nov 2026 21:01:26 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> Add __guarded_by() and __must_hold() annotations to static parser and
> config state in util/config.c, TPEBS state in util/intel-tpebs.c, and
> bpf_progs and cgroups trees in struct perf_env.
>=20
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261111174213.3526=
604-1-irogers@google.com?part=3D17

