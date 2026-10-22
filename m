Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792708038;
	b=NOenTes/kWbHlxP7avWoyMJwu9Jju/oyzYAyoTvcQUx++ULW9BVzs0aPgLq3spVj6qIy
	 cXZQs11hKTgIn4OfNbagHNR0NIlOO09X0eI/pysLgxRwIBw1e7/+osAYQE4sv025TrrqX
	 yQEfnAKkxqpkBLEnIAYBDE+ndmN0egt66kQ82g+CmXt2RhoZC31GYWTnT21GfDEJk0kV4
	 1YMDG/PRU6MbY+ZlukgL9OEhXuVOpMzV7oshZDdNPmIjjlY/vX+3h35XN7XIOUQd5vYF1
	 EaE1ij+dhN5B/paJ0P5CjkWeKCHCp3ayjOoyqnwSWfyezcefff4Py5Fj134Z/QARjLg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792708038;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=c4Jk62lU82kiB3viB5v/zIJXmq5L89/j2YPrZFJdjjo=;
	b=oOfKNLJSznlDYD2sPK+igR3MRA5dzln9wek5oYXsNIZdX7Ak4vcSXRrWWaBElHAfSj92
	 1ZKA/kDZ0ziQ5bY6rYVdpAJXn8XtwlIDVVlfUuHiVm7sSdAncKJtdpT/jgb2XGJ5qaGH8
	 nNiQJbz8Ol2pNRReUXsqj4MgH56v5B0WH9ABaKipebhTskHtMAKNSADG+OYsnWIz3xz3A
	 1p6Hmf1ikSrKwhFFnbOQ2b5bHHqmNXFAxi4v5bfiKW9WT1Ic3t0tbS6ntNOPS/3RLprUd
	 iM3efbS7nIYLn074ISEbbHrdmb54A+3e28yQNiOfWXhnZkxciMQ8y5Kh62XL3xZOWfA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gJyDCOUm;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE6BA606A319
	for <linux-perf-users@vger.kernel.org>; Thu, 22 Oct 2026 22:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gJyDCOUm
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42F1A1F01825;
	Thu, 22 Oct 2026 22:27:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792708037;
	bh=c4Jk62lU82kiB3viB5v/zIJXmq5L89/j2YPrZFJdjjo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=gJyDCOUmZW6Vb7PJZtljz853TDaH2SsgDm1yHZ+P/A7Cuj+ApuJgTznQlAauVCw7E
	 lcXRqdLa0nHsBqu+R0uTdJUsu4NiiQwnQnO2a21hPbJuSdrlGrHIs0Xz4p8oxpwD4/
	 M3RXhjxkimBfL3a3XBmFLd589Eu6IQWUf98NeDS7pB4MA/zZqR21OpL8myUeARBjxU
	 o2p9Xl8jgQqAf7Opn7VTQdrr4WqipboVjOBM6Mi7P9FNermVxZ0Uz7+1XUWjKmUKub
	 9xJHApubnbGljVbl5Otd8dJWDbwCzxFEI6XU1iTdTbmhuzYvipYkxFbdOgUSCAj/Mz
	 8HeRQh2pwM3ZQ==
Message-ID: <sashiko-outbox-182120@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 3/3] perf test: Don't count mlock budget wait time
 towards test timeout
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261022222245.2064964-4-irogers@google.com>
References: <20261022210753.1851597-1-irogers@google.com>
 <20261022222245.2064964-1-irogers@google.com>
 <20261022222245.2064964-4-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 22 Oct 2026 22:27:16 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> When multiple parallel tests need room in kernel.perf_event_mlock_kb,
> they take turns acquiring the shared mlock_budget->lock mutex in
> run_test_case_mlocked() after being forked in start_test().
>=20
> Because child->start_time is recorded in start_test() when the child
> process is forked, any time a test spends waiting in the
> mlock_budget->lock queue would otherwise be counted against both its
> per-test timeout (causing tests later in the queue to time out before
> they even start) and its JUnit XML testcase elapsed time.
>=20
> Extend struct mlock_budget with a per-slot shared start_time and started
> flag populated in run_test_case_mlocked() once the child acquires
> mlock_budget->lock. In check_child_timeout(), skip tests that are still
> waiting for mlock_budget->lock and measure the timeout from the lock
> acquisition timestamp once started. Also use the post-lock start_time
> when computing the test's elapsed duration.
>=20
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261022222245.2064=
964-1-irogers@google.com?part=3D3

