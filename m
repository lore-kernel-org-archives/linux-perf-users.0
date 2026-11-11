Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794428443;
	b=2NEg2udorN+BqRtGT83n8QwqkfOQsuUH+eSc9+x8kjeHHAOmp0OP7eQ3z9PwfkR4K0YI
	 ww7Db2bN25tQolWrb0+XMzHQ9CDpaZ2k247UD3Bo9EX/0urtotRNx3tqx6X7VG38rgaGY
	 n4cQbZfUNlwisx02BikcBU7hKYWqZRQ0LfgrWD4y4+RxnezwQJPWV6S1Fh53uHzl02qmP
	 JIU0RPDa52hmTbIkzMKHxsFrIQJ0PfoZeCaf34fztUSJYekMiwltd6RZ1HAZpHsGlV9b0
	 hVcrXDdXnosMdDClmswdKugVvJofMmMihe/Qriew7yvuM/pVBsGVVh+ThP6i2HLBWag==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794428443;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=gCNTIETK7VHnwNQlbBQi7TowCNMyZ5M8Dz3PaZsD+X8=;
	b=OLXifYCSsRTVIIenQ5z2EwoHutlD2vRAjz/N1OvKCceIQW330MmheSWY7tZmnC2lDmUF
	 5MqN0ngZGkzJTdyPmLZoIWSvSR9l0PrbQRMk2bB1LizNsPfIGg1cmVAJ00oABXbhp8kQC
	 fQqHZ9XaMsY3bSPgpTEXZt7GYRqctjI+RV+dyq8PMw1QEA+UJneVgY+RbXLYVnJUd+aao
	 qFwpxHkAJjVOztKmoyvtW0QlaDQBmU+UbysEhug3h1btsyjR482SmkEKFuTtpFbZa/FX2
	 TRUFz9rAIIEuzYHxMcXyGRtSjNebCoJxLfJLjgq+/K+ADLnY5Xwozq4dHDn2dqRDvUw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=doltuFqe;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45804606A31C
	for <linux-perf-users@vger.kernel.org>; Wed, 11 Nov 2026 20:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=doltuFqe
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE3051F00A05;
	Wed, 11 Nov 2026 20:20:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794428442;
	bh=gCNTIETK7VHnwNQlbBQi7TowCNMyZ5M8Dz3PaZsD+X8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=doltuFqeYydHuzN2HoXwtzaaKRT46LqoyyeqeOHGTt0e9rjOzhQUapDkRWR00ESHd
	 WB/hP59aFDLoHtHPlDL/WgZYLqBOw3oV+TeSZc0XQO1Erxwoh7XCjtDKeOhAT5EOSw
	 j+tLLxuJtcctJTgHprQsQRDWYOwJKV090zjnUo2XJ+Rhz91vXRvigCVYRTmJXcu9T7
	 8Z1C3zelrB9rqT+VL4xQfKg/QWcGFDFQMh954AtyTt1TCjDfC5NsZUFCgYmvRq0LNL
	 v0+oRqIIgIE1cb74eUNsIZJqNlxB5JabYKgowMk4MjFX4zTSmPkKTaso0g30j+1FfN
	 EF8Dmp3uiPeXg==
Message-ID: <sashiko-outbox-209634@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v12 12/20] perf dsos: Use read lock fast path in
 dsos__findnew_id()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261111174213.3526604-13-irogers@google.com>
References: <20261111174213.3526604-1-irogers@google.com>
 <20261111174213.3526604-13-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 11 Nov 2026 20:20:42 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> In dsos__findnew_id(), try finding the DSO under the read lock first and
> only acquire the write lock when a new DSO must be inserted or an
> existing DSO needs its ID updated (checked via dso__needs_improve_id()).
>=20
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261111174213.3526=
604-1-irogers@google.com?part=3D12

