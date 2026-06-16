Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F3813A8FE6
	for <linux-perf-users@vger.kernel.org>; Tue, 16 Jun 2026 15:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781622534; cv=none; b=tvmq9pL7HGyNKCxd3GU6ODDqSS1MG1+E3VEPqUBtAGqQF7o7esStt/Q7cJB2Mk2yOoUEWQm33xlytgR/F3WwTLtXBTjvUxUqo7e3PhiJjgsSzVricf8eaUaI6W1saxbXJTwFTet1TQYouPtSaJmI5+PlYs+jOpS1eGjjw8oWhm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781622534; c=relaxed/simple;
	bh=4kAUHj7i3l3c8gchrw6Ff+GFZ/t2C2cCAsFul08pBPE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=JPmWI0Cp9XYtJNOdGvwCVQf/nWNyX69/1Mg1MErSm7J1JUagAHRBc3UbNQS97UNB3W3/nScVYrh7WSCGAd0UOPRc4+WGP7qnqycF2a12f3b0Qo7JqBkqiml5iIFL0qYIDpVxogdyvnh61H5VUrDnC3LUPBDeDyZ69ftIXGFz3mw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D6bRshSW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D6bRshSW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2C371F000E9;
	Tue, 16 Jun 2026 15:08:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781622533;
	bh=D+6pj+wU/cBFwtRnqG8SZyEiXaR52KILliM4YnrpYkw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=D6bRshSWeexYKMisdKm+DNeyn7bo3XlJper7P5vjRbJ0yhxKK/83SJOEIaD7qCPVt
	 kE6oXn1gURhKK8GDbvP6jMmn3a8hunpjtgxCG+GT88YmkqoU3ndezUCO3VYfV7ilRu
	 RDPOSxLoZFsJCHNa9dd2V4bhMWbW6zcuCiMZsmoW3YTJOzBuPHisHfbT8Re59nNAkj
	 ld1aEWMiYMutXkpOe7scCO6erqxA2JX+52a9xriOQaqHA6Lk67mNcJS5e/iOmu9lAh
	 GcPxJWp+/lJmS6y6MHrCoJzvP38Z+rgi2Cni1UClTM872RtGuF8bIYWEJ41spDuOtl
	 HO+jX6GUyhd7A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 9/9] perf test: Add Arm CoreSight callchain test
Reply-To: sashiko-reviews@lists.linux.dev
To: "Leo Yan" <leo.yan@arm.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260616-b4-arm_cs_callchain_support_v1-v9-9-f8fad931c413@arm.com>
References: <20260616-b4-arm_cs_callchain_support_v1-v9-9-f8fad931c413@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 16 Jun 2026 15:08:52 +0000
Message-Id: <20260616150852.D2C371F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] Rigid callchain regexes combined with instruction sampling artif=
acts will cause spurious test failures.
- [Medium] Checking for hardware event availability using `grep -Pzq` silen=
tly ties test coverage to PCRE support.
--

commit 533d8fca0c044c3396ca892c47d0539a4a5063b3
Author: Leo Yan <leo.yan@arm.com>

perf test: Add Arm CoreSight callchain test

Add a CoreSight shell test for synthesized callchains. The test uses the new
callchain workload to generate trace and decodes it with synthesis callchai=
n.

> diff --git a/tools/perf/tests/shell/coresight/callchain.sh b/tools/perf/t=
ests/shell/coresight/callchain.sh
> new file mode 100755
> index 0000000000000..13cca7dc11184
> --- /dev/null
> +++ b/tools/perf/tests/shell/coresight/callchain.sh
> @@ -0,0 +1,172 @@
[ ... ]
> +skip_if_system_is_not_ready()
> +{
> +	perf list | grep -Pzq 'cs_etm//' || {

[Severity: Medium]
Will this grep command fail on embedded systems where grep (like BusyBox)
might lack Perl-Compatible Regular Expression (-P) support?

If grep fails due to a lack of PCRE support, will this mistakenly report
"[Skip] cs_etm event is not available" and skip the test even when the
hardware is present? Should this use a standard POSIX grep -q instead, or
explicitly report a missing PCRE requirement?

> +		echo "[Skip] cs_etm event is not available" >&2
> +		return 2
> +	}
[ ... ]
> +check_callchain_flow()
> +{
> +	local file=3D"$1"
> +	local l1 l2 l3 l4 l5 l6 l7
> +
> +	# Callchain push
> +	l1=3D$(find_after_line "$(callchain_regex_1)" "$file" 1) || return 1
> +	l2=3D$(find_after_line "$(callchain_regex_2)" "$file" "$((l1 + 1))") ||=
 return 1
> +	l3=3D$(find_after_line "$(callchain_regex_3)" "$file" "$((l2 + 1))") ||=
 return 1
> +	l4=3D$(find_after_line "$(callchain_regex_4)" "$file" "$((l3 + 1))") ||=
 return 1
> +
> +	# Callchain pop
> +	l5=3D$(find_after_line "$(callchain_regex_3)" "$file" "$((l4 + 1))") ||=
 return 1
> +	l6=3D$(find_after_line "$(callchain_regex_2)" "$file" "$((l5 + 1))") ||=
 return 1

[Severity: Medium]
Since this test relies on a 3-instruction sampling interval
(--itrace=3Dg16i3il64), is there a risk of completely missing the return
epilogue of callchain_do_syscall() if the compiler generates an epilogue
shorter than 3 instructions?

For example, on ARM32 or certain AArch64 builds, the epilogue could be just
two instructions like "pop {r11, lr}; bx lr". Since the workload executes
exactly once, is there a chance this will fail to capture an instruction
sample where callchain_do_syscall is the top frame on the return path,
causing a spurious test failure?

> +	l7=3D$(find_after_line "$(callchain_regex_1)" "$file" "$((l6 + 1))") ||=
 return 1

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260616-b4-arm_cs_=
callchain_support_v1-v9-0-f8fad931c413@arm.com?part=3D9
