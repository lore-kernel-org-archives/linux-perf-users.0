Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792602945;
	b=NjS1r/t+TY6jU0W4ndW0950JzS3ErSFZDbXnyCZP5BPdtu4UPt8q7bCigYeF8emoBtYf
	 5ceTd11Id2dkhaIt3XIMIDvjbg2n+giCMo28UyjBM195BW657Az2pt/4ZlOpFObRZm704
	 g5dtPmuaMAdNzDGbQ/8DIgAZGWf48xzvuCw/tJPFgVf9XvOgCFn17gNrHqUEFYhkiRpId
	 A5uoe5Y/TAN17BVGpunarwBGHSsG3T3H9Z/hvx1qJ0eGSUVekQt4viIuTO4ApOICsT0pP
	 SpoMVsQxBsPNBp2dKBC/BGljmH5W/qVoO3Faqfp+W9tOXhViLRMCmkCqSM1VcdxVkGQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792602945;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=AfnUTy4oJ3m32J6z+XmW68f/t+l2AIqOiUOzah0YrUA=;
	b=RqV46I/9cKCXVtxV+L+31xn0b6gWQUb1PoqTAy1f2UeQmWSW/9isKimfIcr1EW9CN424
	 RwaGY/VqYFkSNBAJXw5BSjp+FH9lRBwxY539tpyaPwuv5zOgrHG3Hs2dsjGkoV1etqnNG
	 BlKP25sf9ZbbFReHtb4XLFmhrZvK5SM0yRC6tptxnnmhigOkWel6eH7MotR8EEjpY203X
	 7Hb5Dn+0hCUj7wWwDJSpKM7O6FpOCXx8GoXHWz4A04DytvkWmPHGyjxu6O1NOt/edhkdj
	 WRXoOGlDUmnT/47ENIa/Zlx/GCcw0odbzw/bzXsvAsn68hzUx4dvhErLwuL7eqzhB+Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TqqhG8Tk;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BEBD606A31E
	for <linux-perf-users@vger.kernel.org>; Wed, 21 Oct 2026 17:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TqqhG8Tk
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E71511F000C1;
	Wed, 21 Oct 2026 17:15:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792602945;
	bh=AfnUTy4oJ3m32J6z+XmW68f/t+l2AIqOiUOzah0YrUA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=TqqhG8Tky1sbepfRWjBoF0od1fCcGKe6B4h+btYXSBJLiBEV1oiqRzitRuY1+Zr0p
	 902Il3hb03wO13lZdfJG14Ac+lJA3HoLaMyydz4JfrVnYGxDkHC1WKwIgKi84yFbDp
	 KMY0mYIn/PXtAqwafOUU1pA/vF43le/UWN+12PXSjsgxOhfgt9XjDPnt6JuplwmWA3
	 BZyGMmAEeIa6sftntRJQjbVvJ/HY3lQIAhC2PLsu8bAkL9eZhWXGLR9MFCtmkrBgnX
	 gdPSoZ3PQ7RjZv2X36OGG2KQMAaN0jQBP4W1eKbyYBcsCf2TZDgAnaT212VwwU+zjY
	 MHG3NGYh0ZEMQ==
Message-ID: <sashiko-outbox-180501@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 01/17] compiler-context-analysis: Avoid unused
 parameter warning in _context_unsafe_alias()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261021171044.155240-2-irogers@google.com>
References: <20261020163640.746159-1-irogers@google.com>
 <20261021171044.155240-1-irogers@google.com>
 <20261021171044.155240-2-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 21 Oct 2026 17:15:44 +0000
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261021171044.1552=
40-1-irogers@google.com?part=3D1

