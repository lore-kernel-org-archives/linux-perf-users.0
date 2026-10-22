Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792700563;
	b=OqPXsHH2RJpUXKfR7wuQu738ITIHjNko6S2+GSmIr1E1rGk2ZOrApY2h/axgAYARatFH
	 uGTOKSU2lippnR9A3KqbM+uuFv2zaAQm3yepfyxLoRdEYjnoB49NpJMaB6tvYVNtI/Lag
	 8sOA+JnnxJs7UI7daLxVC/ZGEWUDm7wlmBWZ8QAU3Ra23PL8eItST3uHDyVsXfenWfJcW
	 W+ItTuxYB9yPr9ChWtv5NJnelHAsDcSYmifBmtKPgvB2kpYT+Ogq/hBbLoVhSd0GU2t0k
	 3n0TwSaZEgLCbkvOVh03o09zY8xAKLSSO3kePH2lP4msBRyM2ZUdk36XK+1WW8N1qSw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792700563;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=r3G0Bl8uTGYsSI4NZuzJIlmQ1HzXt7X8HCsoTOHSCVs=;
	b=Bau8W4VItUi6vW/s1AEmPBj4f60W+EvAp2YpTb1jvMQGBTjrg2iX3WbASNywtKbQmcyC
	 1lrsIXiKRA+3dgmJzjHGg8MwRYZgZOpSFs+7F+ZplSlgG/5zYwZZwRy78zRY0N/IYV2YO
	 qXNklujZv7rDI3ycbFPARnpru/+STdOxPl+uLmbXDIYXoasW86ZJdKVdVdmFQax2aqHj5
	 8urccbVj8dRix8+V6sweY0SF4RuKE57v/mP+SEVN0qYXYF3qsxK4cDUT15X9lbZ0zcJQ3
	 9arBPP605uAnhNtgDQHYUyshj4Y9OqtvTBp/gjIvxFC4HrDYI9WrELHngFBSFzu+Aow==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=laSvw640;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E81DD606A319
	for <linux-perf-users@vger.kernel.org>; Thu, 22 Oct 2026 20:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=laSvw640
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7ECC91F01825;
	Thu, 22 Oct 2026 20:22:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792700562;
	bh=r3G0Bl8uTGYsSI4NZuzJIlmQ1HzXt7X8HCsoTOHSCVs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=laSvw640dle82Q4iIONzwh2oyHz6CQFw6PKNNAESvoefrO9ngEqM03kNNDd3ub5b5
	 Jsxe9xsPk/E54dDfuqDJRBbmY8TPH6+M1D5XoMxhijlFNito5ZNnAGbMGMBxSopTed
	 fQBPQ0q3/QRl3Tv73xm36o1rkw7dcuHnDHWiuD+8sUfyIObDvDruNbFL3tzcEhmQRH
	 tBHdB2WoxJSbOsLlM7QU7YpYfe/xaH9r9yrnE9wFevauoRBXMB00sSyaRTboRr8WpP
	 0UI+8Mms/q0/RaombqLKu+tcgeQzxCb1ttD/VLoH9paE8qKdWgCxh9BQiAcr6V2wwU
	 WKJB9gv4qeTbg==
Message-ID: <sashiko-outbox-181991@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 01/19] compiler-context-analysis: Avoid unused
 parameter warning in _context_unsafe_alias()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261022201453.1717523-2-irogers@google.com>
References: <20261021223905.715051-1-irogers@google.com>
 <20261022201453.1717523-1-irogers@google.com>
 <20261022201453.1717523-2-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 22 Oct 2026 20:22:42 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> _context_unsafe_alias() does not use its parameter 'p', which triggers
> -Wunused-parameter when building code that enables -Wextra (such as
> tools/perf, tools/lib/perf, tools/lib/subcmd, and tools/lib/symbol).
> Explicitly cast 'p' to void to silence the warning, matching
> __assume_ctx_lock() and __assume_shared_ctx_lock().
>=20
> Reviewed-by: Marco Elver <elver@google.com>
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261022201453.1717=
523-1-irogers@google.com?part=3D1

