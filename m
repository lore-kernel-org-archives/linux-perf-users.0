Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C3D234AAE9
	for <linux-perf-users@vger.kernel.org>; Tue, 16 Jun 2026 06:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781591134; cv=none; b=gnCf2Ji106tJvtJGof4W3Y+OZ1itX87pxK3ieARF3IcDL4MZ3BQ0prUrDEcNfTdAWoYEFUrLZqJK2h+N3ba4zbJWaSkBPI6MPaukahD6EZIv/ncNPGDc/0uxU8ShoiFOiYk/lR7jmP3LClshm/jgoifjSoGi7KSloDF9bWD8Qqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781591134; c=relaxed/simple;
	bh=qFzWS0zyat7kvnEUGM6exlYqooFYrQb87Nt4KDfcoao=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=MAXBBBE6JXfl2HWCc5MHmggmATsRek1XmRzNi7psFx7sg3iMPhj9EUDu9PWqa6UOwOst1wfdUl0DsPnBDA6SSwJ9jlVI0Od6nRqKodWet+b2DSz8UCsAIz3Hlstv0/ZXzfBgBoMNEGBxQGeyJkH7vNG3FXl9jknGVJ48LeCt1w8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NZfcbUv5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NZfcbUv5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C46701F000E9;
	Tue, 16 Jun 2026 06:25:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781591132;
	bh=DAfb4lG0xk9ZymUj6bRpVwMIvj85b8//o/Qb4BpAQHQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=NZfcbUv5LliyaVmFrkFgljQaVbq0so18wWbumpRM6yMyV7MkfJXvOHfoJLCFGxgAg
	 rhVEN/8R3cCar27NvGm7asVAqjtWfjX01CxdIn+z4fG/WJkM/rdP+PEnMZDh2LtJRz
	 fl/yc/ifYsLJiDBnSdhtQWwzNmJEVB8rG7T3iP8w8H2CFQQTGJ+IMnIB1kMZKgFGB8
	 MxFsmeY0Q1t9cdr1Ln8SDfbC9Tw2cGT0j76A5Th2w+SwngGV6o2uiSLo68l16fBVTC
	 UWkY+K1IHVFkIiqFUF8dVdR/ZN/I3RouMlNE5kgU1sFj/F9sw6WyjYZvCSj2n2fLEz
	 ZgbTUFTpok6BQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 10/12] perf tests: Speed up off-cpu profiling tests
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260616061404.41929-11-irogers@google.com>
References: <20260616061404.41929-11-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 16 Jun 2026 06:25:32 +0000
Message-Id: <20260616062532.C46701F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The commit message inaccurately describes the new off-cpu thresh=
old values applied in the code.
--

commit 7c145dd0880cd69d24f8148542c77c20c1d72e64
Author: Ian Rogers <irogers@google.com>

perf tests: Speed up off-cpu profiling tests

This commit speeds up off-cpu profiling tests by scaling down the workload
durations and off-cpu threshold configurations, reducing the raw test
sleep overhead from 3.0s to 0.3s.

> - Change the above-threshold test to use `--off-cpu-thresh 99` and `sleep=
 0.1`.
> - Change the below-threshold test to use `--off-cpu-thresh 120` and `slee=
p 0.1`.

[Severity: Medium]
Are these threshold descriptions accurate?

Looking at test_offcpu_above_thresh() in
tools/perf/tests/shell/record_offcpu.sh, the implementation actually uses
a 50ms threshold:

    if ! perf record -e dummy --off-cpu --off-cpu-thresh 50 -o ${perfdata} =
-- sleep 0.1 2> /dev/null

Similarly, test_offcpu_below_thresh() implements a 500ms threshold instead
of 120ms:

    if ! perf record -e dummy --off-cpu --off-cpu-thresh 500 -o ${perfdata}=
 -- sleep 0.1 2> /dev/null

While these implemented values provide a safer margin against execution
jitter, could this commit message regression be updated to match the actual
code?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260616061404.4192=
9-1-irogers@google.com?part=3D10
