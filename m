Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CA004EF130
	for <linux-perf-users@vger.kernel.org>; Thu, 17 Sep 2026 16:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789663676; cv=none; b=QFhwxGqlIu5U4GFnPBKeAab7IMISJYHEukTHgccMJdBCKMveVMjDw3OIY/JINbNaeUmZ6H0HCxEg03+kKJEI33A++RXYAhynBeKtNfD3NjDvqY9tYtAWcoykl7KXHx+FAFEs6M+j5/PKWeyD1A3FFpp/dKb0Erv7xMBzxq0H/yQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789663676; c=relaxed/simple;
	bh=sDPtlGfdXMoXoBHj5adMzR8kADLJxD5BlsRmggTxSAw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=opZpgbN1+YkTc97JADGFq9Xf0mAHYEm8j+U3jEBw55r2rn4eB5Pr/5FnptNdhkFplR+h9rKBFIqQCoGU8WgkBaI2qyxSGOkz/iU7Z2xumv0FOG7qK0L/ICZox6wczU0rbMixWUs+TspIjRAPpxaTtMMlWB4cxdt1DmhmeEq7nzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SPgaJ6zO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SPgaJ6zO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 761B61F000FF;
	Thu, 17 Sep 2026 16:47:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789663674;
	bh=sDPtlGfdXMoXoBHj5adMzR8kADLJxD5BlsRmggTxSAw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=SPgaJ6zOi+n1m2ijOqJ3RIo36Jn3xiSPJ0ZYpbrCiozH/vwt5nJpgeUAjh/6TMkxK
	 PCaZmTPT0IQTCduxrj0gi08DEv8erb79q5KaY8Xhu4P7M0QtbZvO2VQeWdSo/w++Un
	 FXWyzqCRcROKcxl2cu6QcF2emswog/01GgCxbvWF30Q/8ff+SVgXshB+eqpcYLrXIA
	 0GOjYhZ7vbIHlWgV4qXoCG6CLEjfwEmiKL1i7RjtCiV7swkxqmadUCg4WDeHtUkFft
	 C+oCAet8I3QsKrT9XZJzqgr6AKZYCWCVrguB+qwm80HHSw7iqdB29FzUjptBlhFhYL
	 VmJnaTekxsdkQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 07/14] perf test test_task_analyzer: Isolate in
 temporary directory and make non-exclusive
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <a42dfdda29f2c43bf6760294cd324a8418acd917.1789662556.git.irogers@google.com>
References: <cover.1789662556.git.irogers@google.com>
 <a42dfdda29f2c43bf6760294cd324a8418acd917.1789662556.git.irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 17 Sep 2026 16:47:54 +0000
Message-Id: <20260917164754.761B61F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> test_task_analyzer.sh writes perf.data and temporary files directly into
> the current working directory, causing collisions when running tests in
> parallel.
>=20
> As a temporary measure until `perf script report` supports an input file
> option, resolve perfdir to an absolute path, change directory into $tmpdir
> for the test duration, and clean up in the exit trap. Remove the
> (exclusive) tag so the test runs in parallel.
>=20
> perfdir is derived from $0, which may be relative, so it has to be
> resolved before the cd into $tmpdir, otherwise both PERF_EXEC_PATH and
> the cleanup trap point at paths that no longer exist.
>=20
> Assisted-by: Antigravity:gemini-3.1-pro
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1789662556.gi=
t.irogers@google.com?part=3D7

