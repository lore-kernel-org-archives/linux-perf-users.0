Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F4293AF64D
	for <linux-perf-users@vger.kernel.org>; Tue, 23 Jun 2026 21:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782250141; cv=none; b=gOx53ixPr0DJjc/0/jqgZpcMTQ7kLajN426FybEW4f6mJE4mkg7v2WPftoPJR3CGXOqrt/FJdAV1VdhFHGVmYJXZ00zmHR6xcT+2dJBmwQLTwpdTzsJQB/mzgfSJXLOgP/PT5fZ1LV6o6GtKSNlQnoHNfYWsCmKSMi2ZBHyIezA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782250141; c=relaxed/simple;
	bh=o+ABm3dkiCUhLoTt96yKe7Xc1iDg0sm5q0uDAutw5/o=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=W55U6sdgVxzlCNamb5egHT6fm5jwcFjTbP22gOY0JfhJQvByqrvzLW5kyXNMYSIsVcuBdzbW2o/PFbwuHmzHi7e+q+dhs+7MS9/CLifFKzpRp9j+GTN542zzn536EsXhUlhi43tNR1DkuvnpzrFwmmGs47o0n4DtBTnMya01n4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TLUTRA9k; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TLUTRA9k"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A63D31F000E9;
	Tue, 23 Jun 2026 21:28:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782250139;
	bh=oNILxZGHc2b8wEOzil8RP7rCTro9MjFJwbjttJ373LQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=TLUTRA9k+7z4GfXCA/eWbZB1RZZJTrrbMIfWtbfmuwdYD+imXumqLMJ0vQ0kDuC1Q
	 +ny9Qky0thNZ4BJFcgWaQ1IKgN0F7DCRR3IowIBpZ4tflyGN8e0Th/+2XJ9VMuakfi
	 Mc2Iy6VQ4T2G7A3xMNIuv3VjQHL7b9KYiGHNv185X9kE9GWK2R6CAUoRRtY7YEyG1l
	 ZsGopT3PjCGD8kDS6ILWQtUSyW9vk7kfNwlsxHfY5QL8uMePuUlVgsFi2Spvia3OWb
	 5/hd3PXlrmlMrLGjDz52X9o76/O+zv9DqGxBSyMaFru5xy8I7RZXat39QACXhIX3bO
	 R0pWEauX5pxnQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 04/13] perf tests: Add robust record retry helper and
 use subsecond workloads
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260623012758.2291858-5-irogers@google.com>
References: <20260616164819.370939-1-irogers@google.com>
 <20260623012758.2291858-1-irogers@google.com>
 <20260623012758.2291858-5-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 23 Jun 2026 21:28:59 +0000
Message-Id: <20260623212859.A63D31F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [Medium] Commit message inaccuracy and incomplete refactoring regarding `=
pipe_test.sh` and `stat_all_pfm.sh`.
- [Medium] Synchronous command execution in `test_kvm_record_report` lacks =
error checking, causing fatal script aborts under `set -e`.
- [Medium] `perf_record_with_retry` permanently leaks and disables the glob=
al `set -e` (errexit) flag when invoked within an OR list.
--

commit d89e4e460291f1a110feac7d87fda40226859958
Author: Ian Rogers <irogers@google.com>

perf tests: Add robust record retry helper and use subsecond workloads

Introduce perf_record_with_retry and perf_record_cleanup in a shared
library tests/shell/lib/perf_record.sh to prevent record test failures
caused by transient recording or workload delays.

> Update record.sh, record_lbr.sh, pipe_test.sh, kvm.sh, and
> stat_all_pfm.sh to use this robust record retry logic. These tests now
> start with very short durations (e.g. 0.01 seconds) and scale up if the
> initial recording failed to capture samples, significantly improving test
> execution speed on success while remaining resilient to slow systems.

[Severity: Medium]
This isn't a bug, but the commit message states that stat_all_pfm.sh is upd=
ated=20
to use the robust retry logic, yet stat_all_pfm.sh isn't modified in this p=
atch.

> diff --git a/tools/perf/tests/shell/kvm.sh b/tools/perf/tests/shell/kvm.sh
> index f88e859025c42..a5396f8e6fe5c 100755
> --- a/tools/perf/tests/shell/kvm.sh
> +++ b/tools/perf/tests/shell/kvm.sh
[ ... ]
> @@ -60,22 +71,26 @@ test_kvm_stat() {
>  test_kvm_record_report() {
>  	echo "Testing perf kvm record/report"
> =20
> -	echo "Recording kvm profile for pid ${qemu_pid}..."
[ ... ]
> +	local duration
> +	local success=3Dfalse
> +	for duration in 1 2 4 8; do
> +		echo "Recording kvm profile for pid ${qemu_pid} (duration ${duration}s=
)..."
> +		rm -f "${perfdata}" "${perfdata}".old
> +
> +		perf kvm --host record -p "${qemu_pid}" -o "${perfdata}" \
> +			-e cpu-clock sleep ${duration}

[Severity: Medium]
Does this unguarded execution bypass the retry loop if it fails?

Since the kvm.sh script operates with `set -e` enabled globally, if=20
`perf kvm record` returns a non-zero exit code here, the script will immedi=
ately=20
abort entirely.

Should this be guarded, perhaps by appending `|| true` to prevent the fatal=
=20
abort so the retry loop can continue?

> +
> +		if [ -e "${perfdata}" ] && \
> +			perf kvm -i "${perfdata}" report --stdio 2>&1 | grep -q "Event count"=
; then
> +			success=3Dtrue
> +			break
> +		fi
> +		echo "No samples or report failed, retrying..."
> +	done

> diff --git a/tools/perf/tests/shell/lib/perf_record.sh b/tools/perf/tests=
/shell/lib/perf_record.sh
> new file mode 100644
> index 0000000000000..e137fa75370de
> --- /dev/null
> +++ b/tools/perf/tests/shell/lib/perf_record.sh
> @@ -0,0 +1,53 @@
> +# SPDX-License-Identifier: GPL-2.0
> +
> +PERF_RECORD_LOGS=3D()
> +
> +perf_record_with_retry() {
[ ... ]
> +  # Save the e flag state and disable it
> +  local save_e
> +  if [[ $- =3D=3D *e* ]]; then
> +    save_e=3D"set -e"
> +  else
> +    save_e=3D"set +e"
> +  fi

[Severity: Medium]
Does this logic permanently disable the `set -e` flag in the caller when=20
invoked within an OR list?

In bash, executing a function on the left side of an `||` operator temporar=
ily=20
suspends `errexit` and explicitly removes the `e` flag from `$-`.

For example, when `record.sh` invokes this function:
    perf_record_with_retry ... || ret=3D$?

`[[ $- =3D=3D *e* ]]` will evaluate to false, causing the function to save =
the state=20
as `set +e`. When the function finishes, it evaluates this saved state,=20
permanently disabling `set -e` globally for the remainder of the calling sc=
ript=20
and silently masking all subsequent command failures.

> +  set +e
> +
> +  local duration
> +  local first_run=3Dtrue
> +  local ret=3D1

> diff --git a/tools/perf/tests/shell/pipe_test.sh b/tools/perf/tests/shell=
/pipe_test.sh
> index e459aa99a9515..ce68d850c9838 100755
> --- a/tools/perf/tests/shell/pipe_test.sh
> +++ b/tools/perf/tests/shell/pipe_test.sh
> @@ -12,8 +12,8 @@ skip_test_missing_symbol ${sym}
> =20
>  data=3D$(mktemp /tmp/perf.data.XXXXXX)
>  data2=3D$(mktemp /tmp/perf.data2.XXXXXX)
> -prog=3D"perf test -w noploop"
> -[ "$(uname -m)" =3D "s390x" ] && prog=3D"$prog 3"
> +prog=3D"perf test -w noploop 0.1"
> +[ "$(uname -m)" =3D "s390x" ] && prog=3D"perf test -w noploop 3"

[Severity: Medium]
Will this hardcoded shorter duration make the test more brittle?

The commit message indicates this script was updated to use the robust retr=
y=20
logic, but it appears to only use a hardcoded 0.1s duration here. Relying o=
n a=20
single 0.1s run without retries might lead to transient failures on slow sy=
stems.

>  err=3D0
> =20
>  set -e

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260623012758.2291=
858-1-irogers@google.com?part=3D4
