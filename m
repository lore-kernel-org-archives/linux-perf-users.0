Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792729399;
	b=pKezR1FSNfmYylB5mehVSTQtYd5XvWANkrJQs9S0lpcO0qgxSLgPbTMYJEFt5jMMU4G8
	 IoqxW3pkJ1zDBlhalzg5icePiC8SR4jdln9/Q8vZx8gu4qo1k5/czjv2qr/IXEIx9YXb7
	 YCSTyISz8IAgN0PlL5+v3GxvZPOIvgtA9uzpmJlQ0TJC8wTlyVyZ4ikmhoV0/GbU2ygEZ
	 A/Fw+fwjn2WACZ32Id6XIxrwnVIYGqzFHjyY+jf9VLrHMyk/Ex1YywvTcqZgHXvzmMF4L
	 fnlYz2teXloEPuvqea/Ivc2OTWWFxqnHh/xEl+LywNJ1ne5CleNQfILsFclM/nBqBeg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792729399;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=EwtlzD+X2Uk43kNVn/9NdSHG4JpVuJRkpsVGACm2x0U=;
	b=Kb+Rs4xjy4l3gMk4Hbdr96cssvrF0wE2F6lxJwldRYOUJoZsLjuTNk5Wwq8sPFZdHLKY
	 ZCYQOlzXLVZKySsyYZyzTdO6BlxFG4WbM5MeOYjoBXa+eP6diuP9DMg8vGkGFp4x6+TRk
	 YbiazzxX68zHdRawRQlZH6GoIA2FuPJHnaIA4j4AF9bslEmbtLfi6uA9qjWJvdn3/SKjm
	 GQwbyoIQnkZfc9Lqyilvnma90BYo6TlnmdL05QCM4HXcr2G5hwd3COkfj/6YX1r6p+skj
	 dg58zzdtK1W8hnbGeqm1i/V6BBKyC5SvvaHHDL7JXpAnXym++H+zVtZZOJFYh8xUY4w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AaQoUqkz;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4F57606A319
	for <linux-perf-users@vger.kernel.org>; Fri, 23 Oct 2026 04:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AaQoUqkz
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 422D71F01825;
	Fri, 23 Oct 2026 04:23:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792729398;
	bh=EwtlzD+X2Uk43kNVn/9NdSHG4JpVuJRkpsVGACm2x0U=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=AaQoUqkz4oFShLlSQSsLXs65yjFD0kYc02a1FByVakG6Nf8dCzKmTPMTVF+UO7KEc
	 tTwAjhRDLg+r5saptgpWQQX1jRmjp9s5nv5EvkNG3IwnbUWPkQ33XkXwFUOV0I1yFX
	 5WRL2s1A9/3jjhs4n8TqHs8A3y4XOMwA5o9m5pPdEV/2Yw1uc9u+XdB197DI3tHYn4
	 I87r119FjFoidIAu9AYudKeC9+lKAu5Wf9XbRIuBVDCOfcO5uq1u2K55dRSnuWFfPj
	 olHN34AGA91Jsycx6IOMqRDNguuD6V5GNNE0Q4JLj3GfY3AiuBqdlD59Y5Bm8EBDTI
	 ZXdsah4Hc098g==
Message-ID: <sashiko-outbox-182276@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 2/2] perf test: Test perf timechart --live
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261023041819.2361900-3-irogers@google.com>
References: <20261014042249.2379829-1-irogers@google.com>
 <20261023041819.2361900-1-irogers@google.com>
 <20261023041819.2361900-3-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 23 Oct 2026 04:23:17 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> From: Alice Rogers <alice.mei.rogers@gmail.com>
>=20
> Extend test_ttimechart_python.sh to cover --live option validation,
> LiveRecorder's perf record subprocess, control pipe and -o output file,
> a synthetic live UI test exercising the rolling window, pruning,
> pause/resume and zoom following, and a live workload recording test when
> scheduler tracepoints are accessible.
>=20
> Assisted-by: Antigravity:gemini-3.1-pro
> Signed-off-by: Alice Rogers <alice.mei.rogers@gmail.com>
> Co-developed-by: Ian Rogers <irogers@google.com>
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261023041819.2361=
900-1-irogers@google.com?part=3D2

