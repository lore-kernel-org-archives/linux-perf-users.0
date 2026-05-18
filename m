Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FA822F7EF5
	for <linux-perf-users@vger.kernel.org>; Mon, 18 May 2026 22:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779144207; cv=none; b=X+t/8lLmO38hgI6ng5Y+UCX7GYlPtxYAcLI231/XULcKJ8NbvV1veGL+OfU5nimGt77TPWfv9S1jvQsHYs/n7VfSZTxut9JmkCU/tG7Z40Bxs6Njtsl3v4yAoL7An7Zs8mZw4h2ECTDlonsnABZMUrw9+K9csTqgaTVA+6FZbeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779144207; c=relaxed/simple;
	bh=oVnn67zrCp9szLnBF+LyBv9xFxDjexzMBDDX0iSaLX4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ogwzQFVCHadPh2qNovoHegHYmH08B0xtpYogsKAdwc0K+PawOE12SQHZh32VdI3Waewa5jGlzWRCpxqSHdOeadPznT180HdUihX5J5P08p1yRPRW6XUg959nMGkIxpLjKFRaInkGysCVZjdqQlWoPkVAMiEuQ7RQQABwa3Y4mVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=URYwWsl5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="URYwWsl5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0470C2BCB7;
	Mon, 18 May 2026 22:43:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779144207;
	bh=oVnn67zrCp9szLnBF+LyBv9xFxDjexzMBDDX0iSaLX4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=URYwWsl5auzOwkPwF9X/TGo++lpY+A7FQBadI7FYykzz4rEYSNbADRG9ghT0Hr1UF
	 yz75wh4LMX6UM0Qwazbj7rb1r8eRiwl/jLaNfpdQUXXXggNo5jN/sDQgQenh+UuQUG
	 Bx9eiqABCTmcZBuwpq3uh3dp1xbnqaZfhe/O1d3uRf0PejvtZmBQdIfYHrsHPjqmy8
	 CUrcOl5H4GAqd46S+TFjALxTWcSWhccRpAGZchYlBa7a2u19QllgG7GvjVwoADcuXA
	 hESeM0UggCPg/rbc8yE+8fGprLlxgeU/5xT0wLYu0LzhRs2HFOv6W+MAN/epj29CRn
	 UmF/IhgwlKLLg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 2/2] perf test: Add stat metrics --for-each-cgroup
 test
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260518222228.3027004-3-irogers@google.com>
References: <20260518222228.3027004-3-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 18 May 2026 22:43:26 +0000
Message-Id: <20260518224326.C0470C2BCB7@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [Medium] Missing 'insn_per_cycle' metric support check contradicts the co=
mmit message and causes false-positive test failures.
- [Low] Unquoted variables in bash script can cause syntax errors and comma=
nd execution failures.
- [Low] Unsafe regex matching with `grep` for cgroup paths.
--

commit eeae523b4cc9fc618f3db63cdc5973fc899f15e2
Author: Ian Rogers <irogers@google.com>

perf test: Add stat metrics --for-each-cgroup test

This commit adds a new shell test stat_metrics_cgrp.sh to verify metric
reporting when using --for-each-cgroup. It tests metric outputs for cgroups
with and without BPF counters.

> The test:
> - Checks if system-wide monitoring is supported (skips if not).
> - Checks if insn_per_cycle metric is supported (skips if not).
> - Finds cgroups to test.

The commit message mentions checking if the insn_per_cycle metric is
supported, but the script only seems to check for system-wide support
using 'perf stat -a -e instructions'.

If the metric is unavailable on the test architecture, will the script fail
with exit code 1 ("No metric lines found") instead of gracefully skipping?

> diff --git a/tools/perf/tests/shell/stat_metrics_cgrp.sh b/tools/perf/tes=
ts/shell/stat_metrics_cgrp.sh
> new file mode 100755
> index 0000000000000..4a29eb9a90674
> --- /dev/null
> +++ b/tools/perf/tests/shell/stat_metrics_cgrp.sh
[ ... ]
> +	# try root and self cgroups
> +	find_cgroups_self_cgrp=3D$(grep perf_event /proc/self/cgroup | cut -d: =
-f3)
> +	if [ -z ${find_cgroups_self_cgrp} ]

This isn't a bug, but could this cause a bash syntax error ("too many
arguments") if the cgroup path happens to contain spaces? Enclosing the
variable in double quotes would prevent word splitting.

> +	then
> +		# cgroup v2 doesn't specify perf_event
> +		find_cgroups_self_cgrp=3D$(grep ^0: /proc/self/cgroup | cut -d: -f3)
> +	fi
> +
> +	if [ -z ${find_cgroups_self_cgrp} ]

Are double quotes also needed here to prevent word splitting?

> +	then
> +		test_cgroups=3D"/"
> +	else
> +		test_cgroups=3D"/,${find_cgroups_self_cgrp}"
> +	fi
[ ... ]
> +check_metric_reported()
> +{
> +	local opts=3D"$1"
> +	local output
> +
> +	log_verbose "Running check_metric_reported with opts '${opts}'..."
> +	# Run perf stat
> +	if ! output=3D$(perf stat -a ${opts} \
> +			--metrics=3Dinsn_per_cycle \
> +			--for-each-cgroup ${test_cgroups} \

Similarly, should ${test_cgroups} be quoted to ensure perf stat doesn't
misinterpret space-separated cgroup paths as commands?

> +			-x, sleep 0.1 2>&1)
> +	then
> +		echo "FAIL: perf stat failed with exit code $?"
> +		echo "Output: ${output}"
> +		exit 1
> +	fi
[ ... ]
> +	for cgrp in "${cgrps[@]}"; do
> +		# Find lines for this cgroup and metric
> +		local cgrp_lines
> +		cgrp_lines=3D$(echo "${output}" | grep "${cgrp}" | grep "insn_per_cycl=
e" || true)

Since cgroup names can contain dots (like "system.slice"), will grep
interpret the dot as a regex wildcard?

Using 'grep -F "${cgrp}"' might be safer to ensure a literal string match.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260518222228.3027=
004-1-irogers@google.com?part=3D2
