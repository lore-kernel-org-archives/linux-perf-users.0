Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28D1F2FE05B
	for <linux-perf-users@vger.kernel.org>; Tue, 19 May 2026 05:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779169633; cv=none; b=ScHD9cjL/yaI4tMLGcKz4L6yj0kCHxAApNvRusoB59aOSGSCj2zIGnZgfYutRL0HSijYe6bDG1uMKiikgxnVDxeBrMpvmQO1JeN/NGZppJoXnqcOdiDI9F37ER8dr6+zUSTao84vaSirQ4RZh6gBN0ea1vliIw4TFADGg0TE/V4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779169633; c=relaxed/simple;
	bh=stgy6Em+UQ0rIIfY/1aS9c5FaxWovErE3YQhF+v82rU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=EiVjHUPMxLPHIQ11DQ2377N7Swgxrr/2kvYNod5EIix4R6F3Wdh+wy40Cn3ERx+xQMJdKBOH7oPuZC1bo4et1pFuIDeQprHxAyXsu72HixcmbLQ5IifSYHn/nxhA3caL9kTugv1ycalOJjsWU2YqQsJpafybohc4ekO6kcuUZ4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lciqfVJ3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lciqfVJ3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 544FAC2BCB3;
	Tue, 19 May 2026 05:47:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779169632;
	bh=stgy6Em+UQ0rIIfY/1aS9c5FaxWovErE3YQhF+v82rU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=lciqfVJ3HAmVOQrFq2N7WDaELVZaN4cSbE23Sd15GFm39RPRLD+RezKOaXyWn/DuH
	 7D2UXGu6zV51ZJfHKf+UftxGY78wrFWNRc7Sm+0T01ZC1UK55+8JwbRktc/UlHHjpf
	 umadNbR8+sbRTB0sElkeFCBbaOEhwBxLyMyQKF9XS8e1gcZHSUlQkQit0LGAxlJ7kH
	 dNUSLi6CIIPpIBcB19yMvXuWSfe4sRxvQWHs7vCjvP+bMkmYJicyFQ8cPqoyEqa40Y
	 XF89/OoCUF6vhs8dZH6drPX2B8aBTtDi+e7psbJitnnTUh/zxRHuBe5u4M5IFLhN7b
	 eCUMuHMYpVvXA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 2/2] perf test: Add stat metrics --for-each-cgroup
 test
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260519050150.3144907-3-irogers@google.com>
References: <20260519050150.3144907-3-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 19 May 2026 05:47:11 +0000
Message-Id: <20260519054712.544FAC2BCB3@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The test incorrectly reads the `instructions` event count for bo=
th `cycles_val` and `inst_val`, failing to verify if the `cycles` event was=
 actually counted before enforcing the metric check.
--

commit fb13ca0af650ea803b39745454aa3404e54a2239
Author: Ian Rogers <irogers@google.com>

perf test: Add stat metrics --for-each-cgroup test

This commit adds a new shell test to verify metric reporting with
the --for-each-cgroup flag in perf stat. It checks that metrics like
insn_per_cycle are properly reported per-cgroup and do not contain
invalid values when events are actively counted.

> diff --git a/tools/perf/tests/shell/stat_metrics_cgrp.sh b/tools/perf/tes=
ts/shell/stat_metrics_cgrp.sh
> new file mode 100755
> index 0000000000000..b413849193a0b
> --- /dev/null
> +++ b/tools/perf/tests/shell/stat_metrics_cgrp.sh
[ ... ]
> +	for cgrp in "${cgrps[@]}"; do
> +		# Find metric lines for this cgroup
> +		# We use exact cgroup match with surrounding commas
> +		local cgrp_lines
> +		cgrp_lines=3D$(echo "${output}" | grep -F ",${cgrp}," | grep "insn_per=
_cycle" || true)
[ ... ]
> +		# Parse each metric line
> +		while read -r line; do
> +			[ -z "${line}" ] && continue
> +
> +			local cycles_val
> +			cycles_val=3D$(echo "${line}" | cut -d, -f1)
> +
> +			local event_name
> +			event_name=3D$(echo "${line}" | cut -d, -f3)
> +
> +			# Find corresponding instructions event line
> +			local inst_event_name
> +			inst_event_name=3D"${event_name/cpu-cycles/instructions}"
> +			inst_event_name=3D"${inst_event_name/cycles/instructions}"
> +
> +			local inst_line
> +			inst_line=3D$(echo "${output}" | \
> +				grep -F ",${cgrp}," | \
> +				grep -F "${inst_event_name}" || true)
> +
> +			local inst_val
> +			inst_val=3D$(echo "${inst_line}" | cut -d, -f1)

Since cgrp_lines is filtered by insn_per_cycle earlier, the event_name
extracted from the third field will typically be instructions rather than
cycles.

Does this cause both cycles_val and inst_val to read the exact same
instructions count? If event_name is already instructions, the string
replacement leaves it unchanged, and inst_line will match the original line.

This could mean the script never actually verifies if the cycles event
itself was successfully counted before enforcing the metric check.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260519050150.3144=
907-1-irogers@google.com?part=3D2
