Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E9354D8CE
	for <linux-perf-users@vger.kernel.org>; Fri, 24 Apr 2026 22:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777070832; cv=none; b=S2wWNpPsKroK77vTBeT5x29Fskpmg/g6SwEqD6ZXYdXqoeD6jT6wpwGO9+lU230cbLALrY0dWKLT70jbmgEhBf8/SyZYWVdKPLtk2YAukVat7yJs+YSpW4MS75VOL9BpjqHGVNqnGeOHsQz0ovtuOrlkzemlOb+8Nx6c+F+MBDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777070832; c=relaxed/simple;
	bh=NO0NqqRzwYDmSvHXNmmth0YobtBbTVfx9rQo5vK76wA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=l9Inm+CAV0NBJqlIj+zqrkOmSzkHj82/piL3UZYRV1faWN+SBOMDreTtGmvnL8U2yhwHik9UtWWdcUeagzvCpqgjMfch2fZbISwaM4+dFhBB65nS2OD6s1fkO6ANXhtqo33e/v42Iaa7PQ5G7vtTsr4CnafnWRoso/38HsxPHes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vObKsd+j; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vObKsd+j"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A516EC19425;
	Fri, 24 Apr 2026 22:47:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777070831;
	bh=NO0NqqRzwYDmSvHXNmmth0YobtBbTVfx9rQo5vK76wA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=vObKsd+jmKhSe2NifuU4TRYdan8x1zCqat7jBF+fdzPplJAwoa7Pq9voeh115wYRR
	 RmETqvVjuarXxfWjtAkmPD2BVglmJqkPv3prwTIo8nJotp6yXSbJsVj5onHns2njc3
	 jbAXCD2nvMtrWwPwpH8P/9RxI28B2RGTsWLUSuUKq/R+DrTNeO6dSggrIVhsit/i/C
	 U/dG9yjMeXDDb2eQm32Vmad2oOMhquYezaIkcQfGU+sgYxsBa/jyxsk/NZkysMHBpj
	 beJzVzCL5hKhbDiVlJ9EGpwNtdU5OGIOGWCoGNwdSDaO7iG/RygN7Lp8z2eAORPz3N
	 CHOC81idau/bg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 2/2] perf test: Add inject ASLR test
Reply-To: sashiko@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260424220519.2743472-2-irogers@google.com>
References: <20260424220519.2743472-2-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 24 Apr 2026 22:47:11 +0000
Message-Id: <20260424224711.A516EC19425@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Sashiko AI review found 4 potential issue(s):
- [High] Hardcoded and insecure PERF binary path
- [Medium] Unhandled grep pipeline aborts script via set -e
- [Medium] Architecture assumption in kernel address parsing breaks 32-bit =
systems
- [Medium] Improper cleanup of temporary files and directories
--

commit 55c497e7d1e9a304b5ad52e13004ec9955f6ffcb
Author: Ian Rogers <irogers@google.com>

perf test: Add inject ASLR test

Add a new shell test inject_aslr.sh to verify the perf inject --aslr
feature.

> diff --git a/tools/perf/tests/shell/inject_aslr.sh b/tools/perf/tests/she=
ll/inject_aslr.sh
> new file mode 100755
> index 00000000000000..17544fe9ef6c02
> --- /dev/null
> +++ b/tools/perf/tests/shell/inject_aslr.sh
> @@ -0,0 +1,381 @@
> +#!/bin/bash
> +# perf inject --aslr test
> +# SPDX-License-Identifier: GPL-2.0
> +
> +shelldir=3D$(dirname "$0")
> +# shellcheck source=3Dlib/perf_has_symbol.sh
> +. "${shelldir}"/lib/perf_has_symbol.sh
> +
> +sym=3D"noploop"
> +
> +# Set path to built perf
> +PERF=3D"/tmp/perf3/perf"

Is this hardcoded path safe and portable? If the test is run as root, could=
 a
local user place a malicious executable at /tmp/perf3/perf and escalate
privileges?

Also, won't this break the test in standard CI environments?

[ ... ]

> +cleanup() {
> +  # Check if temp_dir is set and looks sane before removing
> +  if [[ "${temp_dir}" =3D~ ^/tmp/perf-test-aslr\. ]]; then
> +    rm -rf "${temp_dir}"
> +  fi
> +  trap - EXIT TERM INT
> +}
> +
> +trap_cleanup() {
> +  echo "Unexpected signal in ${FUNCNAME[1]}"
> +  cleanup
> +  exit 1
> +}
> +trap trap_cleanup TERM INT

Because the script uses set -e, should this also trap EXIT? Without an EXIT
trap, if a command fails and triggers an exit, temp_dir might be leaked.

[ ... ]

> +test_basic_aslr() {
> +  echo "Test basic ASLR remapping"
> +  local data
> +  data=3D$(mktemp /tmp/perf.data.basic.XXXXXX)

Should these temporary files be created inside temp_dir instead of directly
in /tmp?

[ ... ]

> +  if [ -z "$orig_addr" ]; then
> +    echo "Basic ASLR test [Failed - no noploop samples in original file]"
> +    err=3D1
> +  elif [ -z "$new_addr" ]; then
> +    echo "Basic ASLR test [Failed - could not find remapped address]"
> +    err=3D1
> +  elif [ "$orig_addr" =3D "$new_addr" ]; then
> +    echo "Basic ASLR test [Failed - addresses are not remapped]"
> +    err=3D1
> +  else
> +    echo "Basic ASLR test [Success]"
> +    rm -f "${data}" "${data2}" "${data}.old" "${data2}.old"
> +  fi
> +}

If the test fails and err=3D1 is set, won't these temporary files be perman=
ently
leaked?

This pattern appears in multiple test functions. Also, in
test_dropped_samples, if the test returns early due to unsupported
--phys-data, these files are also leaked.

[ ... ]

> +test_kernel_aslr() {
> +  echo "Test kernel ASLR remapping"
> +  local kdata
> +  kdata=3D$(mktemp /tmp/perf.data.kernel.XXXXXX)
> +  local kdata2
> +  kdata2=3D$(mktemp /tmp/perf.data2.kernel.XXXXXX)
> +  local log_file
> +  log_file=3D$(mktemp /tmp/kernel_record.log.XXXXXX)
> +
> +  # Try to record kernel samples
> +  if ! ${PERF} record -e task-clock:k -o "${kdata}" ${prog} > "${log_fil=
e}" 2>&1; then
> +    echo "Skipping kernel ASLR test as recording failed (maybe no permis=
sions)"
> +    rm -f "${kdata}" "${log_file}"
> +    return
> +  fi
> +
> +  # Check for warning about kernel map restriction
> +  if grep -q "Couldn't record kernel reference relocation symbol" "${log=
_file}"; then
> +    echo "Skipping kernel ASLR test as kernel map could not be recorded =
(permissions restricted)"
> +    rm -f "${kdata}" "${log_file}"
> +    return
> +  fi
> +
> +  ${PERF} inject -v --aslr -i "${kdata}" -o "${kdata2}"
> +
> +  # Check if kernel addresses are remapped.
> +  orig_addr=3D$(${PERF} script -i "${kdata}" | awk '{for(i=3D1;i<=3DNF;i=
++) if($i ~ /^ffff/) {print $i; exit}}')
> +  new_addr=3D$(${PERF} script -i "${kdata2}" | awk '{for(i=3D1;i<=3DNF;i=
++) if($i ~ /^ffff/) {print $i; exit}}')

Will this parsing work on 32-bit architectures? Kernel space typically resi=
des
at different offsets (such as 0xc0000000 or 0x80000000) on 32-bit platforms,
so hardcoding ^ffff might cause the test to spuriously fail there.

[ ... ]

> +test_kernel_report_aslr() {

[ ... ]

> +  ${PERF} report -i "${data_clean}" --stdio > "${report1}"
> +  ${PERF} report -i "${kdata2}" --stdio > "${report2}"
> +
> +  # Strip headers and compare lines with percentages
> +  grep '%' "${report1}" | grep -v '^#' > "${report1_clean}"
> +  grep '%' "${report2}" | grep -v '^#' > "${report2_clean}"

What happens if report1 contains no matching lines?

The second grep -v would receive empty input and exit with a status code of=
 1.
Since the script uses set -e and doesn't have || true on this pipeline, won=
't
this cause the script to abort immediately and silently?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260424220519.2743=
472-1-irogers@google.com?part=3D2
