Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 713C11F94F
	for <linux-perf-users@vger.kernel.org>; Mon, 25 May 2026 02:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779674664; cv=none; b=N8nyGlmC/VBZWEYetdp7Z1k8/I75a/tHC3PaV5b4EEJGycVvKOvMYh5Ek4G3a36xHepKV852m0G7WileCnVldcQ0fCwKkSgpfYe2doNCmR9Y+KOHWrlcgQ2D1WMb9lpKSMizyoLvAnlR5PZgtSjqciYwn6HmLkOjk69Qs8P//i8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779674664; c=relaxed/simple;
	bh=h8cTCprN1JVU6cykn2LrOrzQOBAx6LbABmL8nI1W4w8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=qxy85LqYc7rZkuj/PrPjURNjsdgfmLb1zxip3fxwYxB0kyUNj3OkDsdYDE01ROmVpuNsqre2K2j3a2iv/SfhOt+q1Sz+XqpKmvX0q2BcvnYO2+zKF4k1vQbX7cuicZxDc0VjjhWd5RC6IrCzt2GrRyko6YzOHufa35MDbmj3pUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jEBSrmLo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jEBSrmLo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAE1C1F000E9;
	Mon, 25 May 2026 02:04:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779674663;
	bh=ktZkgDcxyO9XkHRLwjchuPCIG6b/EaRInR9rETfreSs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jEBSrmLoYSei+VKCeVwD5f7iKdsiTAEiJOI0CVFo7W0SwS+jofKxzCsLWi5WUOYSL
	 BRkl3BUvuaSLCjHv4ucOVrLGBlgvqykhwyFS6v+6K8OEMLPyoVf+m5mLzla3BHHkS0
	 BaMXMfSS/qurRlfBJWu/8yhVBdhz8rTu7KzAAn9DfGKJuqEq+Y5TZLZyHk8zil4C/T
	 Q2Ysg7RlRNWN09rnLK7QY+Qu77eG6+A8xf8z0POefPy0gbJtzgHoOBGAZ2LoAxpord
	 Gc+h3L4aN3A+v2gKT4RK7cNivz8KjILxl7cx7fYxJzxW72alagjt/G3vY3CavljFQ2
	 787/NuG0OhbWg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 29/29] perf test: Add truncated perf.data robustness
 test
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260525010550.1100375-30-acme@kernel.org>
References: <20260525010550.1100375-30-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 25 May 2026 02:04:22 +0000
Message-Id: <20260525020422.EAE1C1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] Unchecked `mktemp` failures lead to unintended file deletions an=
d false positive test results.
- [Low] The use of `dd bs=3D1` forces an excessive number of 1-byte system =
calls, causing unnecessary performance degradation.
--

commit 44bbb01cefd526160c464bb6e4d6a81af952c364
Author: Arnaldo Carvalho de Melo <acme@redhat.com>

perf test: Add truncated perf.data robustness test

This commit adds a shell test to verify that perf report handles truncated
perf.data files gracefully by exiting with an error code rather than
crashing. It records a simple workload and truncates the file at various
offsets, checking the exit code and stderr output for sanitizer violations
or crashes.

> diff --git a/tools/perf/tests/shell/data_validation.sh b/tools/perf/tests=
/shell/data_validation.sh
> new file mode 100755
> index 0000000000000..36b3ba508e4f2
> --- /dev/null
> +++ b/tools/perf/tests/shell/data_validation.sh
> @@ -0,0 +1,85 @@
> +#!/bin/bash

[ ... ]

> +cleanup() {
> +	rm -f "${perfdata}" "${perfdata}.old" "${truncated}" "${stderrfile}"
> +	trap - EXIT TERM INT
> +}
> +trap 'cleanup; exit 1' TERM INT
> +trap cleanup EXIT
> +
> +perfdata=3D$(mktemp /tmp/__perf_test.perf.data.XXXXX)
> +truncated=3D$(mktemp /tmp/__perf_test.perf.data.XXXXX)
> +stderrfile=3D$(mktemp /tmp/__perf_test.perf.data.XXXXX)

[Severity: Medium]
Are we missing checks for mktemp failures here?

If mktemp fails (for instance, due to a full or unwritable /tmp), the
perfdata, truncated, and stderrfile variables will remain empty.

When cleanup executes rm -f "${perfdata}.old", an empty variable causes
it to evaluate to rm -f .old, which destructively removes any file named
.old in the current working directory.

Additionally, if stderrfile is empty, the redirection 2> "${stderrfile}"
later in the script causes a bash syntax error, exiting with code 1.
The script interprets this non-zero exit code as a successful test, masking
the setup failure and falsely reporting a pass.

[ ... ]

> +for cut_at in 8 64 256 $((file_size * 3 / 4)); do
> +	if [ "${cut_at}" -ge "${file_size}" ]; then
> +		continue
> +	fi
> +	dd if=3D"${perfdata}" of=3D"${truncated}" bs=3D1 count=3D"${cut_at}" 2>=
/dev/null

[Severity: Low]
Does using bs=3D1 force an excessive number of system calls?

In the truncation loop, dd is invoked with bs=3D1 and count=3D${cut_at}, wh=
ich
forces dd to perform a 1-byte read() and 1-byte write() system call for
every byte. For example, truncating to 75% of a 100KB file would require
75,000 reads and writes.

While the noploop workload generates a small file, this is highly
inefficient and risks slowing down CI execution on emulators or slower
nodes. Could we use bs=3D"${cut_at}" count=3D1 or head -c instead, which
would read the entire chunk in one pass?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260525010550.1100=
375-1-acme@kernel.org?part=3D29
