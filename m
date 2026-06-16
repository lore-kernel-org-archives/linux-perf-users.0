Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30A753DA7F4
	for <linux-perf-users@vger.kernel.org>; Tue, 16 Jun 2026 06:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781591230; cv=none; b=ZdD63ubsbP69c4X1FMCITmTj8B19/NX6FIWiPUzuQ3QW2zmyTIY0MQ5XC19K/QkJmD5lMGSrPo06ITMpJ4fl0EfoieXcX0wN9Ig9EMaKJ8Ijabblqztv4MTGgxmLVFOXHjqlJYnprtXXG6lno0u7xHKgazYffe96ZuPxx9SPMik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781591230; c=relaxed/simple;
	bh=DhVEl31g58WiL38/L/VEbuu4cZ19NvlEVniaxLDR2io=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=C5a1OVSdvIp0b1HqiBxUlfAVUYiz+Tt7DDJ6ZHrnhkBQ6IOiAVxD9NTGN7H5sCOV3cHjKL2SPm9wrQFATAiOk4Oj+WGu82cEdgTk8gFHEGSFdHcRjwgg495gHmQVKy3qlIgWLtwfrfOMNkCm4+uV4iWQn+N/wddgz2qvxmiLXzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V31c2Gta; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V31c2Gta"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 024121F000E9;
	Tue, 16 Jun 2026 06:27:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781591229;
	bh=nKzXKBN4SReMeocU58USOo9v2vHsu45f1YtzYrb+dHI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=V31c2GtalpQ7J4gJiSPl10tY35tFrcu0tmKI1vt45t4upe42Nn0rLvy8OC5wc/OHd
	 MOhXitDEgPBQV+H2qqpwxHAP0MBWL3kNv7brWbI5rqE68tXi39SjH5KqhS2YUc10eH
	 TE7nFVz/mP2Q+SXp1vqiIhcq6qL1RpLIPTYinUTZL/Fb3oKkR+ChWaD2+OhQ1KY7iR
	 ZGQYA6Tn0Qob87VUzgwOCOt0zz19EF01vHqtWUK4sZfIGVzmwvvAx3I3D0lBA1Uifv
	 Ol/1vHhZSjVTDmpJ1RwDAsauRgYPi22B3uoHNwH8MKq3vzr9/vXT/L+sO/Ucc+Op9b
	 xQ40FuiNh9/CA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 06/12] perf tests: Fix Python JIT dump profiling test
 failure
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260616061404.41929-7-irogers@google.com>
References: <20260616061404.41929-7-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 16 Jun 2026 06:27:08 +0000
Message-Id: <20260616062709.024121F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Predictable temporary file name allows an attacker to perform a =
symlink attack leading to arbitrary file overwrite.
--

commit 5cc8bb6cfd6331b267045e9aa8e8f0e141a7441e
Author: Ian Rogers <irogers@google.com>

perf tests: Fix Python JIT dump profiling test failure

This commit fixes PID parsing in the Python JIT dump profiling test by
resolving duplicate space-separated values. It also introduces a retry loop
that scales from 1M to 100M iterations to ensure JIT stack trampoline
samples are successfully captured.

> diff --git a/tools/perf/tests/shell/jitdump-python.sh b/tools/perf/tests/=
shell/jitdump-python.sh
> index ae86203b14a22..dd4a401cd2455 100755
> --- a/tools/perf/tests/shell/jitdump-python.sh
> +++ b/tools/perf/tests/shell/jitdump-python.sh
[ ... ]
> @@ -33,9 +36,16 @@ trap_cleanup() {
> =20
>  trap trap_cleanup EXIT TERM INT
> =20
> -echo "Run python with -Xperf_jit"
> -cat <<EOF | perf record -k 1 -g --call-graph dwarf -o "${PERF_DATA}" \
> -		 -- ${PYTHON} -Xperf_jit
> +ALL_PIDS=3D""
> +NUM=3D0
> +for iterations in 1000000 10000000 50000000 100000000; do
> +    echo "Running with $iterations iterations..."
> +    rm -f "${PERF_DATA}.pid"
> +    cat <<EOF | perf record -k 1 -g --call-graph dwarf -o "${PERF_DATA}"=
 -- ${PYTHON} -Xperf_jit
> +import os
> +with open("${PERF_DATA}.pid", "w") as f:

[Severity: Medium]
Could this create a time-of-check to time-of-use race condition?

While the main perf data file is securely created using mktemp, this uses
a predictable filename in a shared directory for the PID file. Even though
the file is removed right before the python script runs:

    rm -f "${PERF_DATA}.pid"

Is there a risk that a malicious symlink could be recreated at the
predictable path in the window between the removal and the python open()
call?

If the symlink is recreated and followed during the python script execution:

    with open("${PERF_DATA}.pid", "w") as f:
        f.write(str(os.getpid()))

Does this allow arbitrary file overwrites with the python process PID?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260616061404.4192=
9-1-irogers@google.com?part=3D6
