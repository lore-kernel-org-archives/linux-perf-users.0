Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D97D652CCFC
	for <linux-perf-users@vger.kernel.org>; Fri, 18 Sep 2026 21:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789766924; cv=none; b=WWszoA//ugvFPYQOL7WleLGHBOnI47fELAA+O1a1RPqaQuKuhSYk3e3Wt79sNv2hBf4p2l4qac3B2fNJrZ6tSe4/If5gs+rU01RdJ/qq/n2bNJDY945V7pW4IxsSo03P1JK+NSX5BlDOVQakFDo9qlHhGJQwWKK0oJlaczU/dRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789766924; c=relaxed/simple;
	bh=vXZWfxFxN68W07ciVzSRba6pXBe0CpatlztaSSM5Zn0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=W3v6WF0T5bBQVpgrO6x/bf2TZNIpzAzBJEnbGX/mjVNENDaEqefX9HP69GyFvyu348PCG5U+Di0hXNkBUoo4D9m0NUMIc/aAcYhx5qNJyH7QVh/f8jfN3Ds61LhN+OjukUGpFnE3oXBK8VmSO8dJOrULG+CFJ5GKYfHH5BhQuHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bVnwTR3L; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bVnwTR3L"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B8A31F000FF;
	Fri, 18 Sep 2026 21:28:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789766919;
	bh=vXZWfxFxN68W07ciVzSRba6pXBe0CpatlztaSSM5Zn0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=bVnwTR3LQlWG23eAaqc/kboFvjhi5DV7aRG2pTmtDGQI/3l3VxLtRvbVy6GvN2hNU
	 4ubfgBld3DajuBBqWpeLWl6+HJHCjfbdUxHmicY7KjJLlDdv9cxnCi4kZRwlaquf+V
	 /7BpPZpVUp64K1r/qUWGVqNoFyx+pCNjXiMqzeXkgikWOGZ1yFktCeubye9j8txf63
	 jVQ+P+a3yHJbbTFDXYl1Yg/W4OrcUnqQOA3f9ukEhrSOwpWNdt6fD/u9gYAM4u8c7Q
	 8/WhnRDZ7+80MZ5JFg/zIvDrzIKNlfTsh4Uh88p51T3d8sqbUVM/KA7sk0GvmRQ2Or
	 rFIuWgoiyK8ZQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 02/18] perf trace: Free the whole evsel_trace in
 evsel__put_and_free_priv
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260918211932.2966061-3-irogers@google.com>
References: <20260918140659.2501976-1-irogers@google.com>
 <20260918211932.2966061-1-irogers@google.com>
 <20260918211932.2966061-3-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 18 Sep 2026 21:28:38 +0000
Message-Id: <20260918212839.4B8A31F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> Every evsel->priv in builtin-trace.c is a struct evsel_trace, allocated
> by evsel_trace__new(). It holds a syscall_arg_fmt array in its fmt
> member, which evsel__syscall_arg_fmt() allocates on demand for the
> syscalls:sys_{enter,exit}_SYSCALL tracepoints and for every other
> tracepoint that gets its arguments pretty printed.
>=20
> evsel__put_and_free_priv() only did zfree(&evsel->priv), releasing the
> evsel_trace itself and leaking that array. Use evsel_trace__delete(),
> which frees fmt first, exactly as the out_delete path of
> evsel__syscall_arg_fmt() already does.
>=20
> The current callers are all error paths that run before fmt can have
> been allocated, so nothing leaks in practice today, but the helper is
> the obvious thing to reach for whenever an evsel is discarded and it
> should be safe for that.
>=20
> Assisted-by: Antigravity:gemini-3.1-pro
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260918211932.2966=
061-1-irogers@google.com?part=3D2

