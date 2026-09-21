Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE25A3451CD
	for <linux-perf-users@vger.kernel.org>; Mon, 21 Sep 2026 05:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789968805; cv=none; b=DrrJrLIuOcW+K1LEUkd8318JzC1MjXW/1poKpNIEwurCYJfskld1gER904QECg2M4U4XZZ0pK8EhWh6QAz5lLZy82+g/aNtrioRilBiRJMoa8YK3ouJr4a6hZzgg4zni3C1uyA5bLz++1wEatmKHw1iHFGCpTxYK7UKQD7afTbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789968805; c=relaxed/simple;
	bh=FCk4BdASdTGfOtCUh8U14WotnIo+3M9eUqT4/VsDCGU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Qx/2EcUrwr3R9N4KmzbpGiB0eY4BCCbhqU+2Te5ITRJhbQrjYCXAuvMVymnZvCbR2LYma6m8d+i66F1bckuLaP+TujEW0+SfoN8keqJ/uQRjFfyOF+ylaUe/K0ucMp2GlZ0GfhaE+hdFdkT5KhreaYjcGRHzK4X0S7dS2XSUrBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h81YBkSo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h81YBkSo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55FAA1F000FF;
	Mon, 21 Sep 2026 05:33:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789968804;
	bh=IlR8l3GRqhE6wQBZBVTMot6jN48BAzXV7O/XUdx5TdY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=h81YBkSok6bpyMM0Py9nNKfGmimLA/nQBq1I0U/LO/beXnuje4I2nDqQso3v/EKIG
	 VwpMymSvQB0/ILGnJNTI/84L3aCQ7vAhODK+noBpCF4TyflVewUq8dZPJhPPGOjxCn
	 5LhD46awcRBygLo8DqIiCM/xurYR1Fyd8/Ln9Chyk07HI9qLxqvlV+4FsIGpOVVWh2
	 K2+yvKS5PErOi9/kcuzUeYvvMRh4ea4wc0s45SmIN6KpF65fAuB2rnb2BORfN5Zomm
	 bT5VQBExJIJcLYt+u4KQMchBJ+TEmX0GQ01FIqMeXVBCBbX4qxbLjYoM2xpU360Xse
	 5+BG/S/DKrcAA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 23/49] perf python: Port syscall-counts-by-pid to
 perf module
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <5a832d20b1a04c97e8f3a68db4c89925516d5e81.1789966896.git.irogers@google.com>
References: <cover.1789966896.git.irogers@google.com>
 <5a832d20b1a04c97e8f3a68db4c89925516d5e81.1789966896.git.irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 21 Sep 2026 05:33:23 +0000
Message-Id: <20260921053324.55FAA1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> Port tools/perf/scripts/python/syscall-counts-by-pid.py to a standalone
> script in tools/perf/python/ using the perf module. Avoiding the
> embedded interpreter and per-event dictionary overhead improves
> execution speed by ~3.8x:
>=20
> ```
> $ perf record -e raw_syscalls:sys_enter -a sleep 1
> ...
> $ time perf script tools/perf/scripts/python/syscall-counts-by-pid.py perf
> ...
> real    0m3.852s
> user    0m3.512s
> sys     0m0.336s
> $ time python3 tools/perf/python/syscall-counts-by-pid.py perf
> ...
> [ ... ]
> Add a shell test (test_syscall_counts_by_pid_python.sh) to verify the
> standalone script.
>=20
> Assisted-by: Antigravity:gemini-3.1-pro
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1789966896.gi=
t.irogers@google.com?part=3D23

