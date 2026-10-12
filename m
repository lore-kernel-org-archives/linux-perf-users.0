Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57B2A3E49C1
	for <linux-perf-users@vger.kernel.org>; Mon, 12 Oct 2026 23:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791849403; cv=none; b=QPN/OiemV+8BnaKyOEG37xSO027x/ezh/XCIzeUVwwjNJAtUx9/kc34j2YATabG+nKvHOhGkVAK+hjZy5omi+26FWA4mAg2QA5xH2ZAYDnuIgARA5Q7fVD1/IYgPEqBMvj4QxMQEJQEIxSdBiL8PQiP7OYoI/F4MKbQn/W+lQfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791849403; c=relaxed/simple;
	bh=8r1AdYrCZPJnDuFkx/ODs38tqEqiMONXSAtpiQsbWs4=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=N58Af3IJnBqMXEbYlb5ARvFVTYfigfMfwkkGlWYkE6vAFL2NOzkxWFLCWQ3guMNu9hGuwJDujQ2rOeDM+6ifQy7KfqJEaOD65mceR23g+uHsMUYN8200JJxx/+bkGk0KimIU/rsL6xcf9UemC5PXxk0TS+tIQ8cwOQ2M8QHR8yQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eSf3j1Xa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eSf3j1Xa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6BCE1F0089B;
	Mon, 12 Oct 2026 23:56:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791849401;
	bh=lEqP9XZaBf8M2DH7dESS1CheICn7ZCZ5wUDC04IGasY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=eSf3j1XaydVVMGst29FiIX5fGVASnkzPMdSCwctLxGJU5K/H6C4tpR9quAU8UjzUZ
	 ceERy2wEraFHrxBMM7pG0WQlgtl6aBy3crJUYDcMaP03z0euXFL4bhb4CE453poIg9
	 mExNV4IRz5mAoKbYm3UQLBaa8xuuIXnsw1MgmArF5q5u9MYqHXOwEZBP0LGUhrMZBc
	 nt2/aNwMzjSXMsKhy4ZtZ1VfVsQcubraIE11/GEX+bhM4m0737MR8kvgjFQxlsNzcS
	 Kb5EZYF3LpDirMilxQE6ZGgNZb0YiEqdysJrc1L3vFXTNTwxq11KV0z5rL20wqMPlx
	 bT0Jd4W6ZXF2A==
Message-ID: <sashiko-outbox-168756@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 1/3] perf test: Add per-test timeout support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261012234724.721224-2-irogers@google.com>
References: <20260929025345.88829-1-irogers@google.com>
 <20261012234724.721224-1-irogers@google.com>
 <20261012234724.721224-2-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 12 Oct 2026 23:56:41 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> When a test hangs in 'perf test', the entire test run hangs and makes it
> difficult to inspect output from other tests.
>=20
> Add a new TEST_TIMEOUT result category and a per-test timeout (default
> 60 seconds, configurable via '-t'/'--timeout', with 0 to disable). When
> '-F' ('--dont-fork') is specified, timeouts are disabled.
>=20
> To enforce the timeout:
> - Place each forked test child into its own process group via
>   setpgid(0, 0) in the child and setpgid(pid, pid) in the parent so any
>   subprocesses spawned by shell or workload tests can be terminated
>   together.
> - Check elapsed child runtimes against test_timeout in the existing
>   finish_test() and finish_tests_parallel() polling loops, sending
>   SIGTERM first and escalating to SIGKILL after 1 second if the child
>   process group has not exited.
> - Report timed out tests in red ('TIMEOUT!'), track and display them in
>   the test summary, and emit '<error message=3D"TIMEOUT" type=3D"timeout"=
>'
>   counted under the 'errors' attribute in JUnit XML output.
> - Document '-t'/'--timeout' and '-F'/'--dont-fork' in perf-test.txt.
>=20
> Assisted-by: Antigravity:gemini-3.1-pro
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261012234724.7212=
24-1-irogers@google.com?part=3D1

