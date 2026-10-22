Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792701127;
	b=o1TP9VpVqjLdMYvcte/Rm9JPCKcqN3QSj9TusykFziRBnKGzsz5Q3a71q3AeGwnzzpKK
	 1mbgz7tydfWnBmm8L66e/1E4T7f2MrtIFrrVjLH+zI7V4RirZnboxDY3w/FabCIbhvpFE
	 TvYP7qp06G4XgaK5VJT6wFrf589tA8JDgSTwUxCKBiw0mHDOkG8osSedgC6gjmk9XdIy6
	 yCP3jIL/vfFG2voJ3jCSF0U5SKu2QJ9WzVQ0N+Pgx6C6EZThKpDWeboulhUBKbFFWt0H4
	 +tgSevG9N9jTvUumzOCG6t8KjblHnd61OmwbQGYZRPFJ/b/rg3MIvbvWdZy9bcc3YCw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792701127;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=Kz06GnUkY7sxKG0EXCJFfcWPrKHV4JzOAYQD5w66a3I=;
	b=vjvsMKmz0lgLYKRGLfC4hldpRVpBoi04eXvfnFg8Unc2dLYPm3nUg6mnJTMyhZr79s3s
	 mHo0WnCpNTId7JFow5q4ccOqPzzvW+dnTDwhNsGzNZ+LETKsM8Fgi3/R1TBoQGOy6IVG+
	 ChYZHPd3b1tfwrOvVGbD7Nwjo9F8t4WW0eyLthT9YQGFWNdm3LUrfjEbAk80a7XlhFeIQ
	 sWx1KHv1SlM78DhSkLxEvvoEeyqOsueo+NhrxBNLRZo/hKxR76V3CEJboRuf61jDF6jrD
	 KRsTgAvWc62M+9uxgBjYQqtAVGBkFaYcMC6C/Yubx75HcNCRdmSXDggMzbFUVq3lvMQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=T9N0ilyf;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DECC606A319
	for <linux-perf-users@vger.kernel.org>; Thu, 22 Oct 2026 20:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=T9N0ilyf
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D4251F01825;
	Thu, 22 Oct 2026 20:32:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792701126;
	bh=Kz06GnUkY7sxKG0EXCJFfcWPrKHV4JzOAYQD5w66a3I=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=T9N0ilyfHa4RLQ3/vk3Qzo6B4RtlBRF/q2fGecqn/PuXF91wLPgf0TZJHtKPXdnUh
	 4Q2BKFSKyyj5MlD/NmJ7tGfa/E0TB0nkvQyIXZ/hiAnSWbnSiBeMLVojrgU8a8EEHG
	 SZ9P9Nyt5ZUDKcGn7qqhrzQmTFIS+iCXBuEN+RHmZTOwkZBTpw1mlAWt+ROCcRkmOe
	 ldt7gZJRfYJClR/c6LHSsdlz+oPiV2MI9YLxh9WFYcpOh24BesVv+barJJkX2LSOP/
	 eyASX6/Z4qVCRrUnzEzKmlar8x1+wpd5cf707pEQvz6+WEMALEkMyueuj2Eze1sycp
	 2ZyERgkmLKmiw==
Message-ID: <sashiko-outbox-182010@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 05/19] perf build: Enable additional Clang
 thread-safety flags
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261022201453.1717523-6-irogers@google.com>
References: <20261021223905.715051-1-irogers@google.com>
 <20261022201453.1717523-1-irogers@google.com>
 <20261022201453.1717523-6-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 22 Oct 2026 20:32:06 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> Align tools/perf's Clang thread-safety flags with the kernel's
> scripts/Makefile.context-analysis by adding -Wthread-safety-pointer,
> -Wthread-safety-beta, and (when supported by the compiler)
> -fexperimental-late-parse-attributes.
>=20
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261022201453.1717=
523-1-irogers@google.com?part=3D5

