Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793826267;
	b=3Pa+d7+bonOVkSj0ufVOpXt/60ISttKbwVRUtLDztPO5hZh2AWIn9QhIP06FfJFxwn5R
	 FgUl20Ng0QEAexmbddprKjOqS0MUgrDrTOXQeaNYlIn2YAWUrf2+ZmlOC4pm15uTG/SkS
	 xgwyxSV0UhmssBrBQTm27vissi6q60dUM2co31hw1eQcAMEzu1LJJRBCAIXBZZ3gqtmLh
	 RbUA54UtthLW1v1VEeYp2qrYkBFkwYWJWEtiaBM5CEGLBcHyhWa3CFQ33IozT7LXaykP7
	 PoC+YptBMQbCpXsYswBBa54PdRKjEXRueGUSzSn6SVZDLu8csQB85uYCtwM6WqcHPaA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793826267;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=x6OYDUG6QH2Ja3rnqMYY9BZzWTIz0M/Gg8T0wE+a2Rs=;
	b=AYhCaRt1Z95EsPpeC9zsSOM8jDAeQdt2xtBzdVDhshBKXmdwOiTVzREcw8JmlxSpbq0B
	 0jzDcrUlrwjzkP9hRe/Acf3tJphAFrDnZwYW3Qp1u/K6JGcOC5+BFhoEEohufA251y1XT
	 BGtvYlQ7tHzBf2WcOo+8fB6XTl6vw6Pllp787RL1dM0zgTDrO+0FG8lA6noAoLmKw5myB
	 5hQfsYKTxShfbh0pfaAxrZyF/OamUvbMKW9u20xsEGq/RP1+vzlu7zzCzPJEBQQ2xMCWM
	 vduto6RdnAFLt/QA14hl5hU+Kw8itrQB5U/2RCY/b193XAWMxRgyjaHFWJjl6mt1QCg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KY23GYi+;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56673606D4C7
	for <linux-perf-users@vger.kernel.org>; Wed,  4 Nov 2026 21:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KY23GYi+
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C87991F000C1;
	Wed,  4 Nov 2026 21:04:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793826267;
	bh=x6OYDUG6QH2Ja3rnqMYY9BZzWTIz0M/Gg8T0wE+a2Rs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=KY23GYi+BPBb6uF6iHLic/DZfQBq6JQ3PJSQzSjQDG81ettRez1u4k2KYJK8bhj4C
	 6vQhzW249feO5jn4WqfwVMrncM92TOwuUAGvXDB0xa4HbERrODTokvO8A670yZRYVU
	 EWUbEoH6Vs/uyRZ+7Adcp/coOVXOj0iAZdhl1jtXiWIn0Tuwmtcxe6D/XQ0hJAUp9Z
	 mKF/JY1U9gdWMEDI33d+/6mDNyDdo+1x9WFPn1UkSaYf0716OXZ1NpkmL98lWl5hXq
	 4t1/kLHfRQGVgGxyjdGMlxcPYMA11iAGcIpaJOHxRHodK/QA10cCLrfHTkEVmCtGvy
	 HXfV5OjoE/eZQ==
Message-ID: <sashiko-outbox-198040@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 01/19] compiler-context-analysis: Avoid unused
 parameter warning in _context_unsafe_alias()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261104205909.2078411-2-irogers@google.com>
References: <20261104205909.2078411-1-irogers@google.com>
 <20261104205909.2078411-2-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 04 Nov 2026 21:04:26 +0000
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261104205909.2078=
411-1-irogers@google.com?part=3D1

