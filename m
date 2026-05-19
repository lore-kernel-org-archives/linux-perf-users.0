Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 514DA331A41
	for <linux-perf-users@vger.kernel.org>; Tue, 19 May 2026 02:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779159541; cv=none; b=BfkXOFkF1n/O940hUlMrdXPdtgzzRBgiqjKtUJ6pF2cFurg3BkmCKCXV/bL0mYoou42XFKbHC748QuBiQC1PfcbWCWXtXP0vZeBXFB+1v4AvLXMFPg1sef6ASstgfvM49KelIs8SbFd+qFw97yduNyHtEfbQ3GPB8eAyA7YWxAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779159541; c=relaxed/simple;
	bh=5Dm+uAJYunVpKe4Sjv33oEs/U7APjXnuzdHS09QLYs8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=donapg7lTBw6bvRot4rhHaRWkolxRc9HqJWN3eeEIVmaTeqRZoMXq5yJHf2Ziu1S4de+6opg4V+pQAH8Q2W+eA/qYucpF6UBbyxLR11H11gu2az0z3u98g3HSjKv0ag39K2RlD2BnJnki25OldhgADTW2ynLZFfjMBECZ9uuiyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LcM6J1vT; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LcM6J1vT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D05B3C2BCB7;
	Tue, 19 May 2026 02:59:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779159541;
	bh=5Dm+uAJYunVpKe4Sjv33oEs/U7APjXnuzdHS09QLYs8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=LcM6J1vT3r+kZFb8NzPKFAt72m95tcszmoyx+D/MumSpyaxC/fHJu27JNhZKVVKtj
	 xCXgTahi5xrfFNUqLWdqo7ZF5a/6Cv3vtDCPLRRECidnI76XGjI/rRBZWZAcCS5/d0
	 B+F6aOy8qeOpCSyniC+Exw3QPNs6Qg6rGNp87XjCtW3995GD6St+ovIfTeq5It7hYL
	 0lzy1iGhaSEPQXi49Q0k61RnahscoBoXf6E47qvFH8gNUdSsm6wDjFvgKOCYDlJLw3
	 cOW5PLr/Me/T7GANW/EE4efsbLohXdXZT64KHbQclB18o+bcIoCI9Go1Q/Qg+naQ2P
	 OAlTtjpMDw9Sg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/2] perf test: Add stat metrics --for-each-cgroup
 test
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260519015108.3094513-3-irogers@google.com>
References: <20260519015108.3094513-3-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 19 May 2026 02:59:00 +0000
Message-Id: <20260519025900.D05B3C2BCB7@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [Medium] The test will falsely fail on healthy systems if the tested cgro=
ups are idle.
- [Medium] The capability checks verify unrelated events instead of the tes=
ted metric, risking false failures on unsupported hardware.
- [Medium] A loose substring match causes the test to falsely pass if metri=
cs for the root cgroup are missing.
--

commit 87b9c1deb7ab23590530747e324c9b8bf5728b9d
Author: Ian Rogers <irogers@google.com>

perf test: Add stat metrics --for-each-cgroup test

This commit adds a new shell test stat_metrics_cgrp.sh to verify metric
reporting with --for-each-cgroup. It checks if system-wide monitoring is
supported and tests both standard mode and BPF counters mode.

> diff --git a/tools/perf/tests/shell/stat_metrics_cgrp.sh b/tools/perf/tes=
ts/shell/stat_metrics_cgrp.sh
> new file mode 100755
> index 0000000000000..2f74bd9e3f2ee
> --- /dev/null
> +++ b/tools/perf/tests/shell/stat_metrics_cgrp.sh
[ ... ]
> +# skip if system-wide is not supported
> +check_system_wide()
> +{
> +	log_verbose "Checking system-wide..."
> +	if ! perf stat -a -e instructions sleep 0.01 > /dev/null 2>&1
> +	then
> +		log_verbose "Skipping: system-wide monitoring not supported"
> +		exit 2
> +	fi
> +}

This check verifies the instructions event, but the test measures
insn_per_cycle which also requires cycles. If a test environment supports
instructions but lacks hardware support for cycles (such as in some virtual
environments), will this preliminary check pass but cause the actual test
to fail? Could this capability check use --metrics=3Dinsn_per_cycle instead?

[ ... ]
> +	# Split test_cgroups by comma
> +	IFS=3D',' read -r -a cgrps <<< "${test_cgroups}"
> +
> +	for cgrp in "${cgrps[@]}"; do
> +		# Find lines for this cgroup and metric
> +		local cgrp_lines
> +		cgrp_lines=3D$(echo "${output}" | grep -F "${cgrp}" | grep "insn_per_c=
ycle" || true)

When cgrp is / (the root cgroup), won't grep -F "/" match any sub-cgroup
containing a slash, like /user.slice? If perf stat fails to output metrics
for the root cgroup, it seems cgrp_lines might still be populated by the
child's metrics, potentially causing the test to pass and hide a failure.

> +
> +		if [ -z "${cgrp_lines}" ]
> +		then
> +			echo "FAIL: No metric lines found for cgroup '${cgrp}'"
> +			exit 1
> +		fi
> +
> +		# Check for nan or nested
> +		if echo "${cgrp_lines}" | grep -q -i -E ",nan,|,nested,"
> +		then
> +			echo "FAIL: Invalid metric value (nan/nested) for cgroup '${cgrp}'"
> +			echo "Line: ${cgrp_lines}"
> +			exit 1
> +		fi
> +		# Check for empty metric value
> +		if echo "${cgrp_lines}" | grep -q -E ",,[[:space:]]*[^,]*insn_per_cycl=
e"
> +		then
> +			echo "FAIL: Empty metric value for cgroup '${cgrp}'"

If a tested cgroup like user.slice is completely idle during the 0.1 second
sleep, its cycles and instructions counts will be 0. Would the insn_per_cyc=
le
metric evaluate to NaN and be output as an empty field in CSV mode?=20

If so, will this check cause the test to falsely fail on healthy systems
where the tested cgroups happen to be idle?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260519015108.3094=
513-1-irogers@google.com?part=3D2
