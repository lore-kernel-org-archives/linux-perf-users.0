Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795324927;
	b=fqdUYNW8v1ZKBWNdGETjDmHgdN1yxwvca2o75DO0jg7JtVkjibiXhNu7S6WWH084Tfzd
	 RWCgwU4BGp6x0gkedaYIz+sHt5NW1ZTQy2uGSbNfo4Aq5550SFrJ8xxBDSQCmC4DjSke7
	 YgkDoS7nXLV4CuLH+ukg9b6DFzZu6tJMvJ6i9NpOZ1AgBtGOkYUHkwqOoVGTpLPjOWE+I
	 0Gd52cuh3vzASjuGybYesZWgRwIIsGtEo0r9ab+EUxsy8i++4hqQOrRVFn04VCe0Myars
	 An3jSsgqbWschOpqsXpeiAxw5JQWr9SU+BlIgMNv3h9r1ecZxJXJ1mLcvD4UBRMIypg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795324927;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=8FO+Ua4PCppDCQX5MOE3kCtW2eVyW1Us04kiOmATmQI=;
	b=0PpM/cKttTWst4oxey5f9AkmnZf4H7CtUX6Bboxx17ZFTzHRmLm4fGWzccUVOk9D17oy
	 y4UuKctOXB7qzE/9hJ8WJmi+s9sVS4ghPVFZFyRmdrDh1ARY/8Jq3lNWe5eWA6Y4hU/WF
	 hss8GG0kG1bYlTpRgf2fHYKkybm9Mg1D7SreoSBDza95l/xLk5DXpdq0KHyds50Ln8aNw
	 AG8dtTMlNm0PvHl0Vqia3AhFDjrVLK4KExDjKRpd5HyelqLtzO0H1YJ8QrZ6S490qd9Bz
	 5YArD3dtFVC6I+MGi+L/pXR4JfpN+8YbmfvEkktGJU8kqzFePjwT0nuzJTt/D7c2A1w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OAl6XJOe;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA54B606A320
	for <linux-perf-users@vger.kernel.org>; Sun, 22 Nov 2026 05:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OAl6XJOe
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1ADEB1F000C4;
	Sun, 22 Nov 2026 05:22:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795324927;
	bh=8FO+Ua4PCppDCQX5MOE3kCtW2eVyW1Us04kiOmATmQI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=OAl6XJOeFLHPH05by9Iy4yxseSKMQNcJO3w1o35i3vuA+WmpZNkiW/hvorUyII+Rf
	 ditqtrmxrJcBoUxDtbZWy/vdkiobw2DOhHOzoSOXUuWEtoXot3w79DBik4DqCUaMcQ
	 JGB014w6wiJOJl6Hh5L+mhK7WOpMKs8ZC71+F0hzp+U+3WzdWjjKtxvQ7Or0wp/233
	 vwl/9UyKUbxVGQMf1OggOjfYTRiTC37DxKd0n5cQ4cd1E8ffBtXOPRGzXzNMwED0+E
	 B1VnN4gyeRpLtXnin9vSrU569NuP13zdX7H2rU0HtKOgX5AAq00ar8SjwtKxdLxVsz
	 q5pDvMaoyc7Gw==
Message-ID: <sashiko-outbox-227740@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 00/10] perf symbol: Sorted arrays, DSO-owned
 lifetimes, and memory shrinking
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261122050405.80335-1-irogers@google.com>
References: <20261122050405.80335-1-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 22 Nov 2026 05:22:06 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

Sashiko has reviewed this 10-patch series and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261122050405.8033=
5-1-irogers@google.com
