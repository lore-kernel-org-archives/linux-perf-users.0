Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 221BE4BD7A3
	for <linux-perf-users@vger.kernel.org>; Wed, 30 Sep 2026 13:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790774385; cv=none; b=d0S5czl45boAazxp856/dMb1T6zpnnGfB7eLycbXtmP2XSI8HLRhHvUlN7aEE9gpjCLPkU6hmRJWZOGjjF4vJQuTGdrk3Q+LlBhGVwHGRCQ6qszy0vBtge1zwVnvxUEyZHqRHb0LtsU3T+5IrDHZzZDMVgcKHaLYMLpte+6dKZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790774385; c=relaxed/simple;
	bh=LiQ5FXWkxHEna1jCMo8jj4JNEiXgJJahLpK87HVTX3o=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Bx4zB1elC0ErKOA/JRT3APpIIj1CE7uxJAjn8viuQsu1VW2k8AN3+7Chtlnevq1B+jtJWmmXZ5EfJGxqOYebGxyPSiF8Uav91zx0QSVAVKxW6QuUTAnCTkbNrjKLHgc8FTfy+nnDcyslYyJOMmOrKgYLvWWmT0eh2oWSRlmGuRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ds69v1AD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ds69v1AD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC5E71F000FF;
	Wed, 30 Sep 2026 13:19:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790774371;
	bh=LiQ5FXWkxHEna1jCMo8jj4JNEiXgJJahLpK87HVTX3o=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ds69v1ADVg0WMh/cW7iGkvG2kh9F3EDmxYPT4PwsB5hPbdu5PMUk06wpgkWFI9tSy
	 HrTJ+rHgy2mOPXyB4u1amzaYz6HpGFYiREb30bVLGG9wHn3iJ9XAzPSoZIxtOInj1y
	 Ppy1r884L5UxSKRER8dXSX32ifEOQgUZuHQyUq2OwuXpGupjv2ZVCsDWC2wYKU9mZc
	 JM3sddUzwxJW+bFVHnbozN/rhrdHIKJrmj9uLMi2f2PyEwsNMhXfRfxnfV5wvt0aOQ
	 S2AUY24sj/r8Quvfihq4KjY3oN/rd4wYyM11nE8gWgfVsN8bLn5OR3HgBdCfZiH2la
	 ludCPB9yA+5Ng==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/4] perf build: Build the Python extension before
 pylint consumers
Reply-To: sashiko-reviews@lists.linux.dev
To: "Leo Yan" <leo.yan@arm.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260930-perf_fix_pylint_errors-v2-1-945cd526576b@arm.com>
References: <20260930-perf_fix_pylint_errors-v2-0-945cd526576b@arm.com>
 <20260930-perf_fix_pylint_errors-v2-1-945cd526576b@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 30 Sep 2026 13:19:31 +0000
Message-Id: <20260930131931.BC5E71F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> Pylint checks for tests and standalone Python scripts can run before the
> perf Python extension is available. On a clean parallel build, an import
> error can stop make before the extension is built.
>=20
> Run the script and test pylint checks in separate sub-makes after the
> language bindings are built. Keep their rules in the respective Build
> files so the perf and perf-test C sub-makes can compile concurrently with
> util and the Python extension. An isolated make perf does not need to
> build the extension just for these checks.
>=20
> Fixes: 8a54784e708b ("perf build: Add pylint build tests")
> Reported-by: Aishwarya TCV <aishwarya.tcv@arm.com>
> Assisted-by: Codex:gpt-6
> Signed-off-by: Leo Yan <leo.yan@arm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260930-perf_fix_p=
ylint_errors-v2-0-945cd526576b@arm.com?part=3D1

