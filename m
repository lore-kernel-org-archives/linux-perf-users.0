Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794350175;
	b=HSWeJJiE4MluW2K2yWZz3lyV+Bj7q2Tf92Ahc+osj6ZjPfGRUL4FtiC7zMiDQ8pH3QL8
	 5OU8NwojaPp1AhFn3D3UBZocelOw3996Jy9JoLK8ACGKE63Qd4MVhmREDSgs6AcKhX8j4
	 pfiVLYlDZtcWboxwxvZnGrDrhTH1QTZsVaG4x7tG7aQySpC+s90vBsyFFFNxuUbuLvqeb
	 bi/kIj6ZluRRP2s7q3ngdVCJ7mUK0d2rUkqRv37spSfGcowXlrC/ncZw9MWPMhCQGEy7b
	 PEuQFmrZ4Q3zrNaRaaB4M7MP0HSmx8coD5YZ04zILdPVzaq84y43x3P0do+peYFFS3g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794350175;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=0L5pmFWtqKu0Kt6qon+3wPHl3ngG2gOdTrWHTkXY0Ck=;
	b=O3zcyd1l5XgHbJSanl2yV/hVsY+svP5LcfTmXpuzRMuuLQG6ZmHkX2FpJcCKwggg6GJR
	 BsPRHTk4Jt4FrtTEhGc1EQsAGS4k/DmnKxtJtkwq3xP1GS5vkrZoL94PUasd3z032bj86
	 7JYWuodRtidORp0vE/NnqO6dqy8J2Z74Z4V3xOwUqpWz5JNuvenbM6XLoTQbJvGd4OP6E
	 mrxYa7936zV/ShIYngo/IX9Q2Fi+mzgxirNFc7fDYyZg32ST7CKxCrCdmPOlTZ+J7eb7P
	 PZlCyyF131jDjoaoscSZckU1Y7qvKdNO1gQgk6Hl2wnGLcUoDWQSGsmty2er5ODDWWQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PKuK2I4T;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22F17606A320
	for <linux-perf-users@vger.kernel.org>; Tue, 10 Nov 2026 22:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PKuK2I4T
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 465B61F008A2;
	Tue, 10 Nov 2026 22:36:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794350174;
	bh=0L5pmFWtqKu0Kt6qon+3wPHl3ngG2gOdTrWHTkXY0Ck=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=PKuK2I4TiKUh+NO1ttsxJ/g1Lb9HnQwVLQxgsA3LXbnij8diOjLqa57x9qtOC65EV
	 ejtsG+uRQUNeaHDXnevznSiuZpb+pdYwOmhI3zvbJ9A21SCTbehdlzpna3DxoUsyu6
	 hEDjZQ45JMVOZeqEPFmPYfNofjJ9KLf2+1Ng993dHirc4ad8PJ21+6RAvaQa+E5Srs
	 fEc2bVIkn/yVxH788smd5ebCJ/+IMxEl1TVDtlgs+LsRfA79B1JrX1d7ou/tdwm81W
	 gLm1dj14H4nRvIUse+RqttltrBMQ49+01Iy+DmzOwmLHR6J0PQq0WjzQUwVS0Q4JY0
	 Y4FJXAZolMZOg==
Message-ID: <sashiko-outbox-207834@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 14/20] perf symbol: Add accessor functions for struct
 symbol fields
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261110220803.2503416-15-irogers@google.com>
References: <20261027231513.816148-1-irogers@google.com>
 <20261110220803.2503416-1-irogers@google.com>
 <20261110220803.2503416-15-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 10 Nov 2026 22:36:13 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> Encapsulating struct symbol fields behind inline accessor functions
> decouples callers across tools/perf from struct symbol's internal layout
> as symbol storage and lazy loading evolve.
>=20
> Add inline accessor functions for struct symbol fields (symbol__start,
> symbol__set_start, symbol__end, symbol__set_end, symbol__name,
> symbol__namelen, symbol__arch_sym, symbol__set_arch_sym) and convert
> direct member accesses across tools/perf.
>=20
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261110220803.2503=
416-1-irogers@google.com?part=3D14

