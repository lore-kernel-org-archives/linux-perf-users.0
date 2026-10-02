Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2D1547A888
	for <linux-perf-users@vger.kernel.org>; Fri,  2 Oct 2026 10:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790936924; cv=none; b=Cxco+ZiA4/Exdx+yApDvMGmrKrJF/WE9wr6+lZ/W6XRjJRUxC9rTbFfheeWdxG/EkCmNmxMZxwRvUro2iEw0dyv+XzH27oJydSd2fMFFgXEqmG95tQeWQk1kQkazhnTJFmIS8fstfxObFIWopHJFVhmc1BuxSPQMdFHtGKVHBDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790936924; c=relaxed/simple;
	bh=H761m7g6PKfbicOZbuE4i/Jc2OEJhkpo/MRRpRjl6Co=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=VpSYbOtVYJobMog3MmZqWWdBjdx8tOhdwhXYILCi//r5AV34CJNcCMnsE3CjJtdycoOVt7XNXKnITmIzh2A6c0o5fb0/z21Zyk319XNuCaIwIW6FyiqVo7qk55Omz8uX/N89CJSQwaudXsDPZiOhpgltD/fli+G7BoXxdfqCxts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=erQA3QtV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="erQA3QtV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FA911F000FF;
	Fri,  2 Oct 2026 10:28:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790936922;
	bh=H761m7g6PKfbicOZbuE4i/Jc2OEJhkpo/MRRpRjl6Co=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=erQA3QtVj5acVQCwUJVpLjt7Xp8Sg6wKmbfIRMhaWYO8iesvupvDPRzbpF4sSfwur
	 mdtZgZ7KCAqZjmdEhrgFCE3QQG8bh6CvW86DO6cGi2yamWG1IoB1h6+AcqaXHFOLfE
	 9nCPCokLCjd8hNp0O1eNbRiAqHf6ImhVYJ2ZEqD2xf8eLES7WILslB5TDPk8lqHRW9
	 vZCCBdk94/G8Zvf9tqnsBh1Wh9fzWHfUvGPsdm5nLaep2njJxnfhbFJGe5Kk/4YCpI
	 4mThsyBNH1fB8Odh0oPKxzkpB+3P8vHusczjZllDXRuHL4gK1xKtHrsTvw7aGjHjgY
	 r8RGPR9jD1YEw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 4/9] perf mutex: Add DO_ONCE() for one-time
 initialization
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261002102110.27587-5-acme@kernel.org>
References: <20261002102110.27587-1-acme@kernel.org>
 <20261002102110.27587-5-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 02 Oct 2026 10:28:42 +0000
Message-Id: <20261002102842.7FA911F000FF@smtp.kernel.org>
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
> The lockless fast path reads ___done with
> __atomic_load_n(..., __ATOMIC_ACQUIRE), paired with the
> __atomic_store_n(..., __ATOMIC_RELEASE) store after fn(), so that its
> side effects are visible to threads that take the fast path; the
> __atomic builtins over the smp_load_acquire()/smp_store_release()
> variants because ThreadSanitizer understands the builtins, avoiding
> reports on ___done and on what fn() initialized.
>=20
> Assisted-by: LLM
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261002102110.2758=
7-1-acme@kernel.org?part=3D4

