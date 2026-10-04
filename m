Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 803BA3AFD12
	for <linux-perf-users@vger.kernel.org>; Sun,  4 Oct 2026 10:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791109638; cv=none; b=Spyq68/f5vu6HcKpqdUAt2sbp2LjQPe2QGRhQMh4x9vRZIfaj3SAi7BNy9njvFlc9r9pxxPUZHicKNyjCs8GbfUf/5KApsIhylMH3fOnzea55sCQQA5M0ugjTCcSzY+1alsdwU493TQJj/CWktW/LMh+XsaOXNC2J2YZ31NNZfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791109638; c=relaxed/simple;
	bh=6+XTZ6BabOreirf2XQHLbI73O+VJpAq7u5HNFPnB7H0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=DZOivjsyANH2+q55kFJW4K3w1tUYxWnW6+Ul2glHuj9+eRiW3AO4YlI2ZS2MI/xnrcD8SPQiPEsuvVhgrTU9MUqQXvJMHxLruMexa0WqDsnF51tUP254sx7TzxbChZysdq2OqizvTfmS6O8DbUTuUvc7zJWgfXlqH0Ddu5Szvuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W7fNVZJ9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W7fNVZJ9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09B151F000FF;
	Sun,  4 Oct 2026 10:27:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791109637;
	bh=6+XTZ6BabOreirf2XQHLbI73O+VJpAq7u5HNFPnB7H0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=W7fNVZJ9yBQeUkjSGUllQtLrCsooIJ8YOLdjFmk27bSlNcYMLGERDcmVvA1YHAqq7
	 eH1UUSiSBRnW0AktU51x9U+sd6fTYzD3cntgqS2cg176VxSRA2fXfXzgNthn/PnPA/
	 Dkuuc8lE4fRpGzD2i5R2sQPyBfARex/H/0j3UeBzjpimONvJfUs8+BRDfMaFX9AxNm
	 /vi46rVGxbODHMoe+MIWRydk9cp7Y6zoGwXNf6Q2f5HmF9ueEfSuFv9umbYrxqHjS+
	 OViHCbuDNd8zrOxVQIzHQu6R9AlxwNBECjixWO6Cu5EX/k5sNEZsuh5vBEts2YCkA5
	 rxIuu7KRmaNZA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 4/9] perf mutex: Add DO_ONCE() for one-time
 initialization
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261004102133.26392-5-acme@kernel.org>
References: <20261004102133.26392-1-acme@kernel.org>
 <20261004102133.26392-5-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 04 Oct 2026 10:27:16 +0000
Message-Id: <20261004102717.09B151F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> From: Arnaldo Carvalho de Melo <acme@redhat.com>
>=20
> For lazy init that more than one thread can race into, without
> pthread_once() so that it stays within perf's locking primitives and
> clang's -Wthread-safety keeps an eye on the mutexes involved.
>=20
> Mirrors the kernel's include/linux/once.h DO_ONCE(), dropping its
> static key fast path, unnecessary at these cold init paths: a per call
> site static bool plus a statically initialized mutex, double checked.
> As there, code reachable from more than one call site must go through
> a common helper.
>=20
> The lockless fast path reads ___done with an acquire, paired with a
> release store after fn(), so that fn()'s side effects are visible to
> threads taking the fast path, which the dropped static key used to
> guarantee.
>=20
> The __atomic builtins are used rather than smp_load_acquire()/
> smp_store_release() because ThreadSanitizer understands them,
> avoiding reports on ___done and on what fn() initialized.
>=20
> Assisted-by: LLM
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261004102133.2639=
2-1-acme@kernel.org?part=3D4

