Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32DA73DB323
	for <linux-perf-users@vger.kernel.org>; Wed, 23 Sep 2026 18:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790188519; cv=none; b=EQ6uMWrSW/dlOVk+0yucpvbncCLT/8I8xtV8a0QBJ/w2NTgAbQYannVkhhRuKlOKTcNe/Yw2DkZE4wqRSdevZDHhHKqhPsbjON+FrqpeJ5uYzownXcPF3efEX+kOZ/j2zRPkj4h3M3+m2aQHRDFJIDLEbFMUAxZVF2yf8sQUJWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790188519; c=relaxed/simple;
	bh=w0Eg9g1jUlP7vvqHGkRRDqyuyDI5xDT0JEYUKB2XVlE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=qbZmJpFWTP/X/SU2PeUvePrJJcBlpM+jg74XCRc2kXwv2wwuFXEDfHOIudH21efJRUJDIzsM8ZwH3c3EIetUNNCAyYGybhM8RFxpCSwxgFT0ygJuVC5iXiyQZVuGEOLo9oJGsU5G5kJLJldoJk3NokSKcYEZXDbvpyBM/Z5VZ/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RwJRaso+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RwJRaso+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7290F1F000FF;
	Wed, 23 Sep 2026 18:35:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790188516;
	bh=o8JgJNMWmpsDJgf57IHpMZZeRBsTt2cWHnjHkjjtqiM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=RwJRaso+7pLlZAOR57QMhfz5csVu99h0/b9pUBhB5nXM1Smhai+n8xQY0aCcb0sRG
	 5hONj+bAmF2/k2e/AUy7YYrpdVyjsZk0YqcWBXmVaG8KfUAKSTlRBO6SQH/9kArl5+
	 QF4qYq+xJnR4qLrtF1lvEt63Qx68+PnM6EB/N6iVbgwGNNnkXv/SdKq0oVObtkDxyC
	 3q0Y/fp5HrFyitP9GDbSpP2w5J3Tl2cbe0Jo/IRy5pPR04xwQaiu4yqvVwZmCh9O+q
	 Sn0EtEpbWQch5lq8cBL/hFXvmlNjtPz5jubMIChTebLkHkD8XdSLixRD+aJe/4lyJh
	 AWqL6PicVloyQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 30/49] perf python: Port futex-contention to perf
 module
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260923181213.3032038-31-irogers@google.com>
References: <cover.1789966896.git.irogers@google.com>
 <20260923181213.3032038-1-irogers@google.com>
 <20260923181213.3032038-31-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 23 Sep 2026 18:35:15 +0000
Message-Id: <20260923183516.7290F1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> Port tools/perf/scripts/python/futex-contention.py to a standalone
> script in tools/perf/python/ using the perf module. Avoiding the
> embedded interpreter overhead improves execution speed by ~3.2x:
>=20
> ```
> $ perf record -e syscalls:sys_*_futex -a sleep 1
> ...
> $ time perf script tools/perf/scripts/python/futex-contention.py
> ...
> real    0m1.007s
> user    0m0.935s
> sys     0m0.072s
> $ time python3 tools/perf/python/futex-contention.py
> ...
> real    0m0.314s
> [ ... ]
> Add a shell test (test_futex_contention_python.sh) to verify the
> standalone script.
>=20
> Assisted-by: Antigravity:gemini-3.1-pro
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260923181213.3032=
038-1-irogers@google.com?part=3D30

