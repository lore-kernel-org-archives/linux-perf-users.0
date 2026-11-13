Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794606960;
	b=R3B5zI7BNMaTxvFS4ugxAo/OZWV8CNSqMnLvuf/fn1sZQ+dZXMA1HnO1nz6DH95gAozV
	 47kpE9Wn37MPPgLZ4kYthLHo5sTVvRr+JJtdz1wD9yJZ/Zr4hZAgeJVv7RxhHI3NX5TTW
	 9tSd/G7xycoULuNLYLRh2CXd4wEGhtKrL/EgQfA2mTOt943UjaWL3mbhg8ESRO1ZbBrmV
	 gcfM69lXNaKZgTis505qWo202CtAeVtXtMCnLptArD2O5DE859lP0AUcqq7NoJD0/l+R3
	 JW2fdQTvQJH2lOkFrKDbzg0FLmo+G748e9KV58UFAKF9sH7UbTqXHTjjvCsJpIlQ2bA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794606960;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=ANveWDw1h+3Rc/MB9inrPSt10v6KX6J2jiRaDMh72gM=;
	b=QjfYy3UkIaT+9iSF4kyDO0CGwiu6kvLPyl0PCFaCN6aydK1FQJULtwCPyrVlZbHwCpWp
	 OycbsE5E/nx9SPBTI7pcMhjrCQGyPX8FfvDBmeDxdiB4Nl7vntaAadXZq45RsMbxA8YnW
	 oIe4/1edr1zCdIoyVer3eDQBY2L6Xe5pLzvQwEond7YeOtiZBP9z2FrTFidQ9k+eQcqpg
	 gX4AKsTW/vcMVvoy5uIiiZTKZhFTn/ZulspkMMAej7HKJEb5KVAyIcpri1hgg9Z8qaUsa
	 rh+jT2kSUgE2lIvTjG9G6AqdpkiZbGBd1j5dxlJlnR9oVzsOtZ2HDvV5whQ6sFbH5cg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NSdElhnv;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5047606A332
	for <linux-perf-users@vger.kernel.org>; Fri, 13 Nov 2026 21:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NSdElhnv
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60F0D1F000C4;
	Fri, 13 Nov 2026 21:55:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794606959;
	bh=ANveWDw1h+3Rc/MB9inrPSt10v6KX6J2jiRaDMh72gM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=NSdElhnvVbqZVGpSlt5iUy3iYPDkKpHVJkTrPVXC2cOEzzz2p2FJ6a93yiXvhsb9j
	 mPKc9oLexZY4w1HtB8p8v8mCOd7RdZUOKJ8mA1/x3FEJwtzPCwXp10KXkoH/xsZ3OX
	 ItxHS6iypnCAw6HgJKE9oKW5xP8wAlrVdppSxZzYUKne1TPalFT0l7e+TAdu0IuG/u
	 74tqOfOxtnjqAeD5Enq74HCBAlVsizfOUZCDW0cv2RFcl6CaCkwWfIiIVRpeHo24Pj
	 I63DkNkcArKQYPhKocGmsANOjGLuMsIJiLWZASIvjuDNYmZMu6Dr4TdbAtByEuA5Xj
	 Qk3qlpQBOjnOg==
Message-ID: <sashiko-outbox-213746@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 05/26] perf hashmap: Always build perf's hashmap and
 avoid libbpf symbol conflict
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261113214850.3329699-6-irogers@google.com>
References: <20261113214850.3329699-1-irogers@google.com>
 <20261113214850.3329699-6-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Nov 2026 21:55:58 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> Previously tools/perf/util/hashmap.o was only compiled when libbpf was
> disabled or linked dynamically; with static libbpf.a, perf linked
> against libbpf's internal hashmap symbols.
>=20
> To allow perf's hashmap implementation to diverge from libbpf's without
> colliding with libbpf.a's global hashmap symbols or churning callers:
> - Always build util/hashmap.o in tools/perf/util/Build.
> - Rename the backing C functions in util/hashmap.c to __hashmap__*
>   (__hashmap__init, __hashmap__new, __hashmap__clear, __hashmap__free,
>   __hashmap__size, __hashmap__capacity, __hashmap__insert,
>   __hashmap__find, and __hashmap__delete, along with the internal
>   __hashmap__* helpers).
> - Keep the existing struct hashmap and hashmap__* header wrappers in
>   util/hashmap.h forwarding to those functions, and update the single
>   direct hashmap_find() call in hwmon_pmu.c to hashmap__find().
>=20
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261113214850.3329=
699-1-irogers@google.com?part=3D5

