Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BC953DB304
	for <linux-perf-users@vger.kernel.org>; Tue, 16 Jun 2026 06:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781591264; cv=none; b=ZWY+x1rn1/Odej8WstjRvTd1AlfBdDty/kMTOSKabgH6Eh35zuvxSTLHB8cCoySu1ymUF/qKzyuG28C3BlP6DfqmS7d7BfEyA0hqcfrpvFROnc7Lry/Ac6wcdMnXkh/pBI8DnNxavkQTZ1drk14MP+RSMbRcGO4UYutvm5od3GA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781591264; c=relaxed/simple;
	bh=mwMBbJRHZP8CIG1zR3Z3AA4r54y+M83fZ9M013oufnI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=mrJYEQ4rJfXt4dJdhgjUB28hNqkZe/2W0Pl+AwVWvhHyuU+zxpGqPa3OtI5hWzoxIoYnLcPa3qafHy/tm0Ef9y7YENJlOdTAO3QvXjJg51nlgqzKHE8pRVDJtaqSjDvHAvXkirEEtlEMPfjMiCjEFx+Gx6bZmSfjKuTlw8AjGOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iKeylVz0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iKeylVz0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F12D1F000E9;
	Tue, 16 Jun 2026 06:27:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781591263;
	bh=S2Imoy5/GDcX/F5ewzdnaQL5CbJ8SodB1oukbr1K/s4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=iKeylVz0T8F5AkmuLwiwXZYe+3mN3nu2TlBc4J6K+eATZpdhLoUiPGd2+tCKiWZbJ
	 Y6BNBavG1ll3hLpzEcphyzvfgrFkBBWBNx/ZeU7YO8+JxaZzMOnfnAaUMifi0pgJhg
	 YCTjHnw5BUNontkw8R7phSZGtV8ZQ/085Ze1/7MGil4tHS0/tMwdufb4+r2uK+UWWi
	 +XTI07bsY68qhqVcFRrFUNV7X5O4sanQKb9syASI/VamX4FoHhB8grwO1yI13U2tUz
	 l5uPkhmGJoH32TY9JEEISL1ONCsY0hBxFl4BcqeluyfQjeuqSy0IuWfxsPX3O9nEK3
	 MidjppvZCm4WA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 07/12] perf tests: Fix flakiness in trace record and
 replay test
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260616061404.41929-8-irogers@google.com>
References: <20260616061404.41929-8-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 16 Jun 2026 06:27:42 +0000
Message-Id: <20260616062743.1F12D1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] The `perf_record_with_retry` helper declares a `local logfile` w=
hich shadows the caller's `logfile` variable, breaking permission checks in=
 callers like `test_uid`.
- [Medium] The `perf_record_cleanup` function indiscriminately deletes all =
temporary log files globally, destroying test isolation for parallel runs.
--

commit 26fa367e5372dff196ce764853c2479a57a2ed92
Author: Ian Rogers <irogers@google.com>

perf tests: Fix flakiness in trace record and replay test
   =20
This commit updates the trace_record_replay.sh test to use a robust retry
loop for capturing the required nanosleep events. It generalizes the
perf_record_with_retry helper to support a custom command prefix via the
PERF_RECORD_CMD environment variable.

> diff --git a/tools/perf/tests/shell/lib/perf_record.sh b/tools/perf/tests=
/shell/lib/perf_record.sh
> index fe5721427e58b..2c705840d5547 100644
> --- a/tools/perf/tests/shell/lib/perf_record.sh
> +++ b/tools/perf/tests/shell/lib/perf_record.sh
> @@ -21,9 +21,14 @@ perf_record_with_retry() {
>    local duration
>    local first_run=3Dtrue
>    local ret=3D1
> +  local cmd_prefix=3D"perf record"
> +  if [ -n "${PERF_RECORD_CMD}" ]; then
> +    cmd_prefix=3D"${PERF_RECORD_CMD}"
> +  fi
> +
>    for duration in 0.01 0.1 0.3 1.0 2.0; do
>      rm -f "${perfdata}".old
> -    perf record "$@" -o "${perfdata}" ${testprog_base} ${duration} > "$l=
ogfile" 2>&1
> +    ${cmd_prefix} "$@" -o "${perfdata}" ${testprog_base} ${duration} > "=
$logfile" 2>&1

[Severity: Medium]
Does this code shadow the caller's logfile variable, breaking permission
checks in callers like test_uid()?

In perf_record_with_retry(), a local logfile is declared:

tools/perf/tests/shell/lib/perf_record.sh:perf_record_with_retry() {
  ...
  local logfile
  logfile=3D$(mktemp /tmp/__perf_record_retry.XXXXXX.log)
  ...
}

But the caller test_uid() attempts to verify the failure reason by reading
its own unwritten logfile:

tools/perf/tests/shell/record.sh:test_uid() {
  local logfile
  logfile=3D"/tmp/__perf_record_retry.$(id -u).$BASHPID.log"
  local ret=3D0
  perf_record_with_retry "${perfdata}" "check_uid" "perf test -w thloop" \
    -aB --synth=3Dno --uid "$(id -u)" || ret=3D$?
  if [ $ret -eq 2 ]; then
    if grep -q -E "libbpf.*EPERM|Access to performance monitoring|Permissio=
n denied|Failure to open any events" \
      "$logfile"
    ...
}

Because the local logfile in perf_record_with_retry() captures the output,
the grep in test_uid() silently fails.

> diff --git a/tools/perf/tests/shell/trace_record_replay.sh b/tools/perf/t=
ests/shell/trace_record_replay.sh
> index 88d30a03dcecb..f27e32b186978 100755
> --- a/tools/perf/tests/shell/trace_record_replay.sh
> +++ b/tools/perf/tests/shell/trace_record_replay.sh

[ ... ]

> @@ -6,16 +6,26 @@
> =20
>  # shellcheck source=3Dlib/probe.sh
>  . "$(dirname $0)"/lib/probe.sh
> +# shellcheck source=3Dlib/perf_record.sh
> +. "$(dirname $0)"/lib/perf_record.sh
> =20
>  skip_if_no_perf_trace || exit 2
>  [ "$(id -u)" =3D 0 ] || exit 2
> =20
>  file=3D$(mktemp /tmp/temporary_file.XXXXX)
> =20
> -perf trace record -o ${file} sleep 1 || exit 1
> -if ! perf trace -i ${file} 2>&1 | grep nanosleep; then
> +check_nanosleep() {
> +  perf trace -i "${file}" 2>&1 | grep -q nanosleep
> +}
> +
> +PERF_RECORD_CMD=3D"perf trace record" perf_record_with_retry "${file}" "=
check_nanosleep" "sleep"
> +err=3D$?
> +
> +perf_record_cleanup

[Severity: Medium]
Could calling perf_record_cleanup() here clobber the log files of other tes=
ts
running concurrently?

The perf_record_cleanup() function performs a wildcard deletion:

tools/perf/tests/shell/lib/perf_record.sh:perf_record_cleanup() {
  rm -f /tmp/__perf_record_retry.*.log
}

This will indiscriminately delete all temporary log files globally,
destroying test isolation and potentially leading to race conditions and
unpredictable flaky failures across the test suite (e.g., via perf test -p).

> +rm -f ${file}
> +
> +if [ $err -ne 0 ]; then
>  	echo "Failed: cannot find *nanosleep syscall"
>  	exit 1
>  fi

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260616061404.4192=
9-1-irogers@google.com?part=3D7
