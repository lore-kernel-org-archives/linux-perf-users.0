Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792703569;
	b=ned2yca9fCjPKlSedyemD5z8T7Z7wRZM0QAtiWxTkRGt49UyyM4k67AHrIAS+vBSmy45
	 m9tBlKn7hKsiRnd/jzkrnIKALJmmZAS8MNcn+X7vnvnBicz1zFhndDW2FpHU73akSu3cJ
	 s51eD75GbYvNnRydzXZ+BtoIfKtVdFEF42VE0XpQdFG20vSA1ZgTGcr1loNNkescsqiF0
	 /ShJGXj44wxDFdp2tAD8AxdAbQ8q9HtkuF5VJYyLbqWG8xWw0lBcUUnkt+4NII5LnBNlx
	 IXJ3o2iad5qnd8J22WjR16cbrxWnYyHlLskzAmpvmzizaoqUrKSo/EviczCDDlTkSSA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792703569;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=lztKXzW5CGNIAtm3dfZLMbutgcx5pe12GXq2UmgTSa4=;
	b=0Rip8u996ByJeObL14jJVZNJMF20zQHjDu9B2+aOW7ooJKVeGd/N4d7Q9OJy2LMMqZDb
	 0GDqVhIwfzM/6t7v+aisJLVggsRbJl4xCyOpHokTrg9k9TaTzKrpqc3UFkgNlH28N1yEj
	 2+r8jfAanlxiRCix9Q0gqLRjbPnA49Gi6YH5ryCQGuh3+etKw82jQfgMTD7HLl8kcUaaQ
	 orQfQrArXKYq5acaI+c4Cuq2zoK3CcYWf31V0mG056NWNVb5nMhDN7GPKbKW/j/PxnvWY
	 dPj0csvMNRxAjyzvZho6/D2MkC0CULgqmd8M9WZY+4FMexKxjLqzsC5iG0tzB8TOPZw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YBNBKepe;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97FC1606A328
	for <linux-perf-users@vger.kernel.org>; Thu, 22 Oct 2026 21:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YBNBKepe
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EFF01F01829;
	Thu, 22 Oct 2026 21:12:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792703569;
	bh=lztKXzW5CGNIAtm3dfZLMbutgcx5pe12GXq2UmgTSa4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=YBNBKepeDniYnjobZxp5SDo4NPk3Ihxd/roT2xROgW9Cb9ASWQqke/M6vp6gUWuDw
	 dvPxOKmYdWtp2iYRDJn/nuFLZQOfoItKzRjd0gXN6xsxslpHwzmr4h6a0pTmKmMf3/
	 8yieWObYQz6XpL4HnFhtMNFtCjgJImlzGjDzmimrOXtiFcv9Q1ABG3h9K0T2KyBINh
	 xleZpmmHYdo6/okLKggK3XPcQLEsINcP/UuC0OL0/bi9xJz7qs5ft5tkERHvkjwDpV
	 /LJfUlEdDGCiz20pMuXyY7OoGuM1LVJ/vofNpIGNC8Gi2WlAneE6WjLyLQRoMqUCPe
	 nYZlTj32G9vVg==
Message-ID: <sashiko-outbox-182048@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 3/3] perf test: Don't count mlock budget wait time
 towards test timeout
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261022210753.1851597-4-irogers@google.com>
References: <20261012234724.721224-1-irogers@google.com>
 <20261022210753.1851597-1-irogers@google.com>
 <20261022210753.1851597-4-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 22 Oct 2026 21:12:48 +0000
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261022210753.1851=
597-1-irogers@google.com?part=3D3

