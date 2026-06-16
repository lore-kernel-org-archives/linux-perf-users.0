Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 813763DA7C2
	for <linux-perf-users@vger.kernel.org>; Tue, 16 Jun 2026 06:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781591252; cv=none; b=L9oIU+6g1sfeNqz7HEgcWCxSRaF1Ls5Oj1yIeB0f9sNRS8cHF2YjLProUVWBSDJHh/D++Te9fHeTZYZT07umr3JR7ptdZ2ZqbIGSs+iR6qACPtQYMnlY54Dm6MD5EAaKMB4O7IAiRh5J5mG55FmaZWxWq+ulxmjsmyBg6IZyQlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781591252; c=relaxed/simple;
	bh=VkaHo3OjGu1uul9O54QnaMlWzU0FLsulv1MGGmQJ5oE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Y40ReWcrwsSHydlzW0NPuZFk4nmKMQlVmtzEmFE3WCHeovAQEaC+aTS5Th3+JN7rOW7R7xX+xuwDwgFdGaVk05rBlJ+YTBo6Wmk3gObxD3i9iK3gaUumNjqOsP+9diIaU9n/aGhl/du/goYMnkz19dFrBi1QXz2Olu6RnM5CXec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YcoIeHSC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YcoIeHSC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05AAA1F000E9;
	Tue, 16 Jun 2026 06:27:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781591251;
	bh=dhu1ci+fZbDzFt9VUo8J9rjXNRApXQcrra9KLWjqD/Q=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=YcoIeHSCpMMnNwsF8S7MtZlARLnl2SGGr6X9gG+Dz5opVGke/XKCiSzlWm/CHsgD2
	 BvwodHaV8/Xo4w5GMftBsufNf4ruqvXOoQA06Ubv9Y6mhEWV8fnMu0G8xP3c9xb62F
	 1lFrUMncLnulQVUs1VsxHUicvKIecTrzgM4l0hppciGX01AfcpMqKw5qB1skFQD84Q
	 QmvpyXeKIoKZGUsgCX2JaDDK4HAbtGpDtvongry8D+Ic3RvjSFN1Nrl+LmOGC/IrdT
	 vhbx2WmKwH9axGQcTCm0bIQ7cCPreo6jtSX32rXv7w5WK+NRgHZVMY1JHIbgXJioJx
	 +42ND86umMccQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 04/12] perf tests: Add robust record retry helper and
 use subsecond workloads
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260616061404.41929-5-irogers@google.com>
References: <20260616061404.41929-5-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 16 Jun 2026 06:27:30 +0000
Message-Id: <20260616062731.05AAA1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [Medium] GNU `mktemp` syntax error breaks the recording loop for all test=
s.
- [Medium] Local variable shadowing in `perf_record_with_retry` breaks `tes=
t_uid`'s permission check.
- [Medium] `perf_record_cleanup` uses a global wildcard deletion that clobb=
ers log files of concurrently executing tests.
--

commit d3b4c0d4db4697b810bf2709918c20b98619d0e1
Author: Ian Rogers <irogers@google.com>

perf tests: Add robust record retry helper and use subsecond workloads

Introduce perf_record_with_retry and perf_record_cleanup in a shared
library tests/shell/lib/perf_record.sh to prevent record test failures
caused by transient recording or workload delays.

> diff --git a/tools/perf/tests/shell/lib/perf_record.sh b/tools/perf/tests=
/shell/lib/perf_record.sh
> new file mode 100644
> --- /dev/null
> +++ b/tools/perf/tests/shell/lib/perf_record.sh
> @@ -0,0 +1,47 @@
> +# SPDX-License-Identifier: GPL-2.0
> +
> +perf_record_with_retry() {
> +  local perfdata=3D"$1"
> +  local check_cmd=3D"$2"
> +  local testprog_base=3D"$3"
> +  shift 3
> +
> +  local logfile
> +  logfile=3D$(mktemp /tmp/__perf_record_retry.XXXXXX.log)

[Severity: Medium]
Will this mktemp invocation fail because the X's are not at the end of the
template?

GNU mktemp requires the X characters to be at the absolute end of the templ=
ate
string (unless the --suffix option is used). Since this fails with 'too few
X's in template', the logfile variable is left empty.

[ ... ]

> +  local duration
> +  local first_run=3Dtrue
> +  local ret=3D1
> +  for duration in 0.01 0.1 0.3 1.0 2.0; do
> +    rm -f "${perfdata}".old
> +    perf record "$@" -o "${perfdata}" ${testprog_base} ${duration} > "$l=
ogfile" 2>&1

[Severity: Medium]
Can the empty logfile variable cause a syntax error here?

Because mktemp failed and logfile is empty, bash attempts to redirect the
output to an empty string. This aborts the command with a 'No such file or
directory' error and prevents perf record from running at all.

[ ... ]

> +perf_record_cleanup() {
> +  rm -f /tmp/__perf_record_retry.*.log

[Severity: Medium]
Could this wildcard deletion remove the log files of other concurrently
running tests?

Since perf test can execute tests in parallel, using a global wildcard
deletion like this can clobber the active temporary log files of other test=
s.
This breaks test isolation and can cause sporadic failures or masked errors.

> diff --git a/tools/perf/tests/shell/record.sh b/tools/perf/tests/shell/re=
cord.sh
> --- a/tools/perf/tests/shell/record.sh
> +++ b/tools/perf/tests/shell/record.sh
[ ... ]
> @@ -235,16 +240,19 @@ test_uid() {
>    echo "Uid sampling test"
> -  if ! perf record -aB --synth=3Dno --uid "$(id -u)" -o "${perfdata}" ${=
testprog} \
> -    > "${script_output}" 2>&1
> -  then
> -    if grep -q "libbpf.*EPERM" "${script_output}"
> +  local logfile
> +  logfile=3D"/tmp/__perf_record_retry.$(id -u).$BASHPID.log"
> +  local ret=3D0
> +  perf_record_with_retry "${perfdata}" "check_uid" "perf test -w thloop"=
 \
> +    -aB --synth=3Dno --uid "$(id -u)" || ret=3D$?
> +  if [ $ret -eq 2 ]; then
> +    if grep -q -E "libbpf.*EPERM|Access to performance monitoring|Permis=
sion denied|Failure to open any events" \
> +      "$logfile"

[Severity: Medium]
Is it possible the grep will fail to find the EPERM error because the logs
were written to a different file?

The perf_record_with_retry helper declares its own 'local logfile' and sets=
 it
to a dynamically generated mktemp path. This shadows the caller's logfile
variable without exporting the actual filename used.

When test_uid attempts to grep its own logfile path, it operates on a
non-existent file.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260616061404.4192=
9-1-irogers@google.com?part=3D4
