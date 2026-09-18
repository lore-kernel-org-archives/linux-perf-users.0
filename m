Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76AEC522F16
	for <linux-perf-users@vger.kernel.org>; Fri, 18 Sep 2026 21:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789767077; cv=none; b=tGJtPsH9NFbJ8b6Ws9fAR/xEyjM+xtO4PbVLDuiJe9RHWJlKE2VCx5kHYLCMkym9k0KP5Nm3wWmZq80FmsGsKO9toILzi/yEVfCwlI1I1ZN3UT2+UY03W4GcOso7fVrgVwlpcFuaCrOhFnhNwQvsjCEWbiDeJUsuLrwSbVQGrkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789767077; c=relaxed/simple;
	bh=SQvsS+QflurCJNWTBlbYzREnx/X41ad8vYDbrsifWoQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ZKqrcjMIXSySmlL8T9MEiI32L72Bbow0Y0f+MmGjhRfCQ+Vo1J6OL1HkM7e50jbf/CMg3Jc7aJSa4o1wWvAf+eMJ0fauHE2BQAOc2tH8XYQcIVFulg7CkPCIBjYXlVgcilv/nE1LHdadIj4HlfmX9Vu6xbopViW905TcxtvlLdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LBjG5evn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LBjG5evn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 310B31F000FF;
	Fri, 18 Sep 2026 21:31:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789767074;
	bh=SQvsS+QflurCJNWTBlbYzREnx/X41ad8vYDbrsifWoQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=LBjG5evnVdDdHrZ25CjYeRL+oRqvJnudtbkMfLU9mgUh0P4TuMeDeLkQOolxFYOgf
	 0H3wBBO29DVhi4ijPAn3YGv+y4RU7DK7dmyk+AuGvb7S0tbeHN0nzwv8MSQfOOtQsK
	 9QwSPktuU5BEm2z/fa21M2OkbFijTppSNFItGDDHWBZCPuhM1ZvbBL1285VOpNDNpC
	 zu3iBJlvCw4sdnuF5us6PnVdgM9jYmE9jE6DAcUuJq0DTpuUDoZnzyGswgx6JxJYv1
	 i7CZ7t1ptMM3FcHzCDkKDp1B8Wyo8JFZUQPEkdB8m7172Pbzh4WZ+fdQP1o/FT5rj3
	 pRL8KJO57h0jQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 16/18] perf test trace_btf_general: Drop
 --max-events=1 and make non-exclusive
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260918211932.2966061-17-irogers@google.com>
References: <20260918140659.2501976-1-irogers@google.com>
 <20260918211932.2966061-1-irogers@google.com>
 <20260918211932.2966061-17-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 18 Sep 2026 21:31:13 +0000
Message-Id: <20260918213114.310B31F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> trace_btf_general.sh used `--max-events=3D1` with `perf trace` on
> commands such as `mv`, `echo`, and `sleep`. When background activity
> occurs or tests run in parallel, `perf trace` can capture an event
> from an unrelated process and exit prematurely before recording the
> target command's syscalls.
>=20
> Drop `--max-events=3D1` and let tracing run until the command completes,
> checking for the expected output with grep (matching trace_btf_enum.sh).
> Remove the (exclusive) tag so the test runs in parallel.
>=20
> Running perf trace in parallel is only safe now that the probe tests no
> longer name their probes "vfs_getname...": perf trace opens everything
> matching a hardcoded "probe:vfs_getname*" wildcard, which used to pin
> those probes and make their cleanup fail with -EBUSY.
>=20
> Assisted-by: Antigravity:gemini-3.1-pro
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260918211932.2966=
061-1-irogers@google.com?part=3D16

