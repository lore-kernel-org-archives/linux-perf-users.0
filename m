Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89BC6343896
	for <linux-perf-users@vger.kernel.org>; Tue,  9 Jun 2026 14:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781016088; cv=none; b=E/3xKiBc5opejNJQjnBGxuqXl/o+f0dNZWrxmTm1ffU4qqywi3PBcEIk6Cvk/0TKAU1/K4Mu0Wdu9VHrG504sW/OvrWMzrlJFwJjNWKHSTajvIypYEachNdZ4CfL+OStgVXqKN9YfZKkKVPAQycf/SPNcXlIdP29lVKKCAo8lEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781016088; c=relaxed/simple;
	bh=Q2nLXzxSe5aK/3fMJJi0VjoD/OA4aUvx/XE9qVad78s=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=liX4oOUAZu+P4AKF7E4HVYl6JOCM/CnSSdavNiZ3dMbTYbpnM1+hCk1EMITd6DUnmo5MUbCJ64AqZ1bepX/5Johxwtw5iLxaBjN71CHyKaJU55+GgFICz1ZOiB1jWeYZX1bJ4WUAWu0zWl7uFGCVzSrxxTU6hFPOYWT2A1AwJx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d64yJTdM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d64yJTdM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 210E31F00893;
	Tue,  9 Jun 2026 14:41:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781016087;
	bh=H0rECGX8+ZG28WeWY2gjgvvDpyVUMYxCnQihU9pCijs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=d64yJTdMXCUf3YE4Nz65+t419ryb1cDLXZwgS5knmsmZYCEIU3Z4tGUCoBRmvmdTI
	 8knUM1DWlGVX0eLy4JEJFtt/y41mUmMAB+DIj0AIMbPJtw3W3/vUnD66ATkLo17T4B
	 L4amrcOMCOkp+J9GlOuOo52WsSVrP8wifH6hVmZf8ruhEU0+d8fafFZguphGGbv5Or
	 y3PJa7AML7D7IgEsE9U3dRoY2QuwrX9ypoKKDLFw2LFdwnfgBkkjHY/sFUBJPaga/E
	 465nNm3QvYWyBUUznbbWaVbmloqYYiCrFwQlNuu0I8xPuriZ5GrtX70HvBdH7qKD5J
	 1/SO1k8YKgf/w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 04/19] perf test cs-etm: Test process attribution
Reply-To: sashiko-reviews@lists.linux.dev
To: "James Clark" <james.clark@linaro.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260609-james-cs-context-tracking-fix-v4-4-44f9fb9e5c42@linaro.org>
References: <20260609-james-cs-context-tracking-fix-v4-4-44f9fb9e5c42@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 09 Jun 2026 14:41:26 +0000
Message-Id: <20260609144127.210E31F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The test script hardcodes CPU 0 for recording and pinning, causi=
ng false test failures on systems where CPU 0 is offlined or lacks a CoreSi=
ght ETM.
--

commit c50b8d82ea4d5dd7b4d85c01619bc432a03ea379
Author: James Clark <james.clark@linaro.org>

perf test cs-etm: Test process attribution

This commit adds a test to verify that CoreSight context switch workload
traces attribute symbols to the correct process when traced on a single CPU.

> diff --git a/tools/perf/tests/shell/coresight/context_switch_thread.sh b/=
tools/perf/tests/shell/coresight/context_switch_thread.sh
> new file mode 100755
> index 0000000000000..2b9c44b86c591
> --- /dev/null
> +++ b/tools/perf/tests/shell/coresight/context_switch_thread.sh
[ ... ]
> +cf=3D"$tmpdir/ctl"
> +af=3D"$tmpdir/ack"
> +mkfifo "$cf" "$af"
> +
> +# Pin to one CPU so the two threads alternate running but record into th=
e same
> +# trace buffer. Start disabled and use the control FIFO to only record t=
he
> +# workload and not startup.
> +perf record -o "$tmpdir/data" -e cs_etm/timestamp=3D0/u -C 0 -D -1 --con=
trol fifo:"$cf","$af" -- \
> +	taskset --cpu-list 0 perf test --record-ctl fifo:"$cf","$af" \
> +	-w context_switch_loop > /dev/null 2>&1

[Severity: Medium]
Will this test fail on systems where CPU 0 lacks a CoreSight ETM or is
currently offlined?

On some ARM architectures, ETMs are not guaranteed to be present on all CPU=
s.
Could we dynamically discover a CPU with an ETM via the sysfs event_source
devices instead of hardcoding CPU 0 for the record and taskset commands?

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260609-james-cs-c=
ontext-tracking-fix-v4-0-44f9fb9e5c42@linaro.org?part=3D4
