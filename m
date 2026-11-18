Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794988761;
	b=Zae5BXntqXQdS7gELyh9nBEJJvul50F6u3Mx4eGLwrLLV35OcV3utvWGuYhZOsIKvwfP
	 D5Hq2IkBnRvBnwHKZ47zFSgIh8M5/xtGpUai8Sddz/rZrjm49zhjBXQ13jwgtqtkqmktO
	 e3MRI/uy/pRdq/TwJL7DayHe4khN4Wu8l200FXqvMQkVCgDhjMpRNrDLkIswVc1t4Z1WQ
	 JQVR9cd8ewlmCqQwoIgMel6LWHGpzoiEk9R64y1Ls2yzm6mgjSOQ+iMaiaTWZVWiH3VYI
	 0l0qGoJkIDXqcDQu1MElkpJmyDydYguJlVyY2MxWUP5Jd3NS3U9pC2J1r9rJM1ygM8A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794988761;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=vjttMht/XgcUJckTk9O14DXrr2+4Ar8OgvVpxv3rJuE=;
	b=PV9gUXQkjNMfwRWK/qqeRtPw3Q/KzcRB+SaniD4HEruzCkT97dUmN5exuJwd6uHP5F3+
	 XCZURrOx8No1sbpsKCHLDae/AU0hA8C1mxT+Kad7oKG4AqwIFg7haDWIqFJT0LiWVMXxD
	 wR4dHIdmJexrcjLAa9s6FJVF5VTk0Mtu7PurkfRsmaDv26GYw3ePQov/WsckT7iKD7XZx
	 C/LnbpzQNfE8IlkIajVX6I/8BHN/ucc9sKq30lrHKHTaXblwjO0Y4bjyhDt6fB72svXaq
	 qUvjeCLgm/mPxsm6FvBjDLQ7hYCbxiBXa5m1neFeMR+PGb45d+0/SvENPpWe5NVyfZg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HXgvu5QS;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 943BA606A31C
	for <linux-perf-users@vger.kernel.org>; Wed, 18 Nov 2026 07:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HXgvu5QS
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07B521F000C4;
	Wed, 18 Nov 2026 07:59:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794988761;
	bh=vjttMht/XgcUJckTk9O14DXrr2+4Ar8OgvVpxv3rJuE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=HXgvu5QStcl8V9iBLTP4mPDEJakogWkvlOX68qy+8qfp2y7l291TfmtWMrdliDtc+
	 +TF9Uaou7BndZ463SQapXzFeQW6vlfL+3XqnLnkGNtG/VAH2EKfDhuEwh50Kp2YIJM
	 HUREaEe9Zr4uwL086ddxr2XZc4F5T9IWvn4vLPSKR996auqkCqw4jzA9J4+SQIehfu
	 BEy1Supsy9nt3jUjzStB5ayTGS7ctxS3vjTaNKRR+d4MkaYHmDNXtuSzmkS51ctwFk
	 N5MBSoWAMJNv1NrvX8jiONOS/Ou+W63v82W0EpOSIKR/tcJCE3mrucXhFOXdLeRKXB
	 AmPxGP/jL9MeA==
Message-ID: <sashiko-outbox-220397@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 4/4] perf pmu: Free alias on error paths in
 perf_pmu__new_alias()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261118075516.1278903-5-irogers@google.com>
References: <20261118075516.1278903-1-irogers@google.com>
 <20261118075516.1278903-5-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 18 Nov 2026 07:59:20 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> In perf_pmu__new_alias(), alias is allocated with zalloc(), but if
> parse_double() fails on any of the retirement latency fields or
> io__getline() fails when reading sysfs alias terms, the function returns
> ret directly without freeing alias.
>=20
> Call perf_pmu_free_alias(alias) on both error paths, matching the
> existing perf_pmu__convert_scale() failure path.
>=20
> Fixes: 84bae3af20d0 ("perf pmu: Don't eagerly parse event terms")
> Fixes: fc807b6bde6a ("perf pmu-events: Add retirement latency to JSON eve=
nts inside of perf")
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261118075516.1278=
903-1-irogers@google.com?part=3D4

