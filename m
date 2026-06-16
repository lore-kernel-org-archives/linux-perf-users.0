Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 908CD37882A
	for <linux-perf-users@vger.kernel.org>; Tue, 16 Jun 2026 01:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781573882; cv=none; b=rq172TGOwJd1NAmfoA5zK0XEZpYY71cyCWXURVIfB7gC3JjYW1EQA2WwCzBAu+kV+RGemG2m873XaTib6AjKehQNzMImE9W7bZc19CVQnM677R+wUnLlhpdmk43FzTf1eGW/kk/RwHq/6HL6fnrnpCaT+BYF3hl13i2rIFOYkCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781573882; c=relaxed/simple;
	bh=5F6BKI67Dl+I6DKbTyzRFnXzuCDYqkq9ezL7bOBFMyk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=mIpHmzT2qMSG94tWCWWDF1rW9qirBPCNh8Zocycm9TWWlS5jcnTyI2SRTCj6SfmcUhYc5eDjWN4vlfVu19LLQT9jz1c85pELHxDT9DQ031CQfrLR/6NSr5aqpLFV2BhYUABKk7EXaUf5kFCL51DBBpihVZbAxwN0hNT2iCMTKKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m+e6YDm6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m+e6YDm6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A8351F000E9;
	Tue, 16 Jun 2026 01:38:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781573881;
	bh=m7HjnZXJc4O2TJ+O6npIyp0rDHqKbqO06T4+azE4i8k=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=m+e6YDm6b27Nb/N6EWnEw/2/pJBaz6OsqkANTrJFr+1EPfvrw0+1tRh8h9Vvoq/m1
	 gAcpXeiVEPQXcVK8pgNTHjCXixITeGnQyxOrwWsmO1bkfiRucOQcqlKNqTuMyrnPZY
	 SjYcuEMuoCLVvS/D47Pi7wkeLqipNAnVsfKHlqlOnQRD265EMMptco8avIZB7vDeqt
	 h8RmvkveEz3lt0GYRbFaxSJMcDnIqF2cRpTRpJKierk/N5H8yGTlx2uGmBIG6kfyAh
	 16MMc0SoNTuofwD6lWZkmEVFFBR1fBdAtYBtbpcl9nkI0LNAO5H8zsOZTVFV4+axSq
	 rRoJaNJV88uFQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 04/12] perf tests: Add robust record retry helper and
 use subsecond workloads
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260616012744.4049193-5-irogers@google.com>
References: <20260616012744.4049193-5-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 16 Jun 2026 01:38:00 +0000
Message-Id: <20260616013801.0A8351F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Predictable temporary file path in a world-writable directory allo=
ws local privilege escalation via symlink attack.
--

commit c60696a6dd47d2ab5c2a513da9f459f6cbd7d660
Author: Ian Rogers <irogers@google.com>

perf tests: Add robust record retry helper and use subsecond workloads

This commit introduces a retry helper in tests/shell/lib/perf_record.sh to
prevent transient failures during perf record tests. It updates several
existing tests to use this helper and scales durations up if initial runs
fail.

> diff --git a/tools/perf/tests/shell/lib/perf_record.sh b/tools/perf/tests=
/shell/lib/perf_record.sh
> new file mode 100644
> --- /dev/null
> +++ b/tools/perf/tests/shell/lib/perf_record.sh
> @@ -0,0 +1,47 @@
> +# SPDX-License-Identifier: GPL-2.0
> +
> +perf_record_with_retry() {
[ ... ]
> +  local logfile
> +  logfile=3D"/tmp/__perf_record_retry.$(id -u).$BASHPID.log"

[Severity: High]
Could this predictable filename in a world-writable directory allow a symli=
nk
attack?

Because BASHPID is easily guessable, a local attacker could pre-create a
symlink with this name.

[ ... ]
> +  local duration
> +  local first_run=3Dtrue
> +  local ret=3D1
> +  for duration in 0.01 0.1 0.3 1.0 2.0; do
> +    rm -f "${perfdata}" "${perfdata}".old
> +    perf record "$@" -o "${perfdata}" ${testprog_base} ${duration} > "$l=
ogfile" 2>&1

Since these tests are often run as root to access performance counters,
could this shell redirection follow the attacker's symlink and overwrite
arbitrary system files?

Using mktemp instead would safely generate and create this temporary file.

[ ... ]
> diff --git a/tools/perf/tests/shell/record.sh b/tools/perf/tests/shell/re=
cord.sh
> --- a/tools/perf/tests/shell/record.sh
> +++ b/tools/perf/tests/shell/record.sh
[ ... ]
> +test_uid() {
>    echo "Uid sampling test"
> -  if ! perf record -aB --synth=3Dno --uid "$(id -u)" -o "${perfdata}" ${=
testprog} \
> -    > "${script_output}" 2>&1
> -  then
> -    if grep -q "libbpf.*EPERM" "${script_output}"
> +  local logfile
> +  logfile=3D"/tmp/__perf_record_retry.$(id -u).$BASHPID.log"

[Severity: High]
Does this duplicate the predictable path logic from perf_record_with_retry(=
)?

If the shared helper is updated to use mktemp, this hardcoded path check
in test_uid() will also need to be updated to match the securely generated
filename.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260616012744.4049=
193-1-irogers@google.com?part=3D4
