Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C7FB47141D
	for <linux-perf-users@vger.kernel.org>; Fri, 21 Aug 2026 10:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787308813; cv=none; b=AmZ4k0sXL0FDTWZq43vN7PUMJHZrIdD8NczIP5o0CbU+EnTYvXgCKyPU47XGIZn26hpNZFvcVcTaoiPUj2FbW3n8/s6vKKD4TPDXq3rcurfkPKBlzNCMYDgRv0IU1wliUkkAyppjBWEFtlxQelXNG8ILu5YsUEMZ1SAp8cGcYtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787308813; c=relaxed/simple;
	bh=LYmsGIrUTcv9EeBCKMdZ4KXfZnaBP1p+INw9tM3p2Ds=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Ki3Wl/HjzkCWlWAqxsDwCgTS7T1LNkwY1C6K0Y1xlKTNqlhZGjFkN9WbKbuz0AlUptwT234sJq+W2TJTXHzbPbuwo0za5wX0NmruZg7M+u0bgCSwhZf9l3hV+SEg/Ug6k0yC4YiIBmS7eOGX6nrCNI8A35iXU5KFS89RJllyuzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GFaAZJyS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GFaAZJyS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 486061F000E9;
	Fri, 21 Aug 2026 10:40:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787308803;
	bh=M2Neq3M6lcVNuJTlRQhNl+8urNyru9FSgW5I2ldb0bM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=GFaAZJySZaLHFb+lGtpBCNaZOkvvuPyN3L7z1urEn0LnAundC6nKzMtsAw10DRe4c
	 4d+Bj8B/ogf1/n07H+UwqrEInecO4yepXjXvAw1QQkziZC7S1wllORFM6EhPfEeykF
	 GzXCI65fY7t68+ncOJTEWPRXY/2SsGSSTS0iyNmUVcc2FM1298EGXcA55xdbWljVZt
	 3PPkXib+Umr9OFTG2cno2389Qjlx3BH68wT+7zvrtiK0M0bYV5fAraQC6eq5tx5MfV
	 37ixuebZ7GkvgezYfqhIi4b6riahrcyyLN5lK4dnuKEBb8tuUsIzGtnvZxHEwSiER4
	 MsJwtlorwEMMg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 14/14] perf cs-etm: Test multiple per-thread threads
Reply-To: sashiko-reviews@lists.linux.dev
To: "James Clark" <james.clark@linaro.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260821-james-cs-unformatted-per-thread-fix-v2-14-00c4fd0701b4@linaro.org>
References: <20260821-james-cs-unformatted-per-thread-fix-v2-0-00c4fd0701b4@linaro.org>
 <20260821-james-cs-unformatted-per-thread-fix-v2-14-00c4fd0701b4@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 21 Aug 2026 10:40:02 +0000
Message-Id: <20260821104003.486061F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The script will abort prematurely on non-TRBE systems due to `se=
t -e` triggering on expected errors from `wait $perf` or `perf script`.
--

--- Patch [14]: [PATCH v2 14/14] perf cs-etm: Test multiple per-thread thre=
ads ---
commit 94423fa9c68e780595c834e59e6281ca36e48a32
Author: James Clark <james.clark@linaro.org>

perf cs-etm: Test multiple per-thread threads

This commit adds a test to verify that attaching to a process with multiple
child threads correctly records samples for all child threads using CoreSig=
ht.

> diff --git a/tools/perf/tests/shell/coresight/per-thread-multi.sh b/tools=
/perf/tests/shell/coresight/per-thread-multi.sh
> new file mode 100755
> index 0000000000000..ea525ed5e18bc
> --- /dev/null
> +++ b/tools/perf/tests/shell/coresight/per-thread-multi.sh
> @@ -0,0 +1,78 @@
> +#!/bin/bash -e

[ ... ]

> +kill $parent
> +wait $parent || true
> +unset parent
> +wait $perf

[Severity: Medium]
Will this script abort prematurely on non-TRBE systems?

As noted in the script's own comments, `perf record` is expected to fail
with `-EBUSY` on systems using shared sinks (non-TRBE) because two threads
try to use them simultaneously.

When this expected failure occurs, `perf record` exits with a non-zero
status. Because the script is running with `set -e` on the first line, the
unshielded `wait $perf` command will propagate this non-zero exit status,
causing the script to immediately abort.

This would prevent the script from reaching the intended TRBE skip logic
below. Could this be updated to `wait $perf || true` similar to the
`wait $parent || true` above?

> +unset perf
> +
> +echo "Decoding..."
> +perf script -i "$tmpdir/data" > "$tmpdir/script" 2>/dev/null

[Severity: Medium]
Similarly, will this unshielded `perf script` command also abort the script
under `set -e` if the `perf.data` file is missing or invalid due to the
preceding recording error?

> +
> +# Exit early unless there is a dedicated sink per core which only TRBE
> +# guarantees. This is because shared sinks will report BUSY if two threa=
ds try
> +# to use them at the same time
> +if ! ls /sys/bus/coresight/devices/trbe* > /dev/null 2>&1; then
> +	echo "No TRBE sinks, skipping output validation"
> +	exit 0
> +fi

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260821-james-cs-u=
nformatted-per-thread-fix-v2-0-00c4fd0701b4@linaro.org?part=3D14
