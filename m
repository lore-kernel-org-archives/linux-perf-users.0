Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6760E324B16;
	Mon, 11 May 2026 07:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778484893; cv=none; b=DAdMjAfSWtltaaJLAK9C0+6Yc0EmR12FGgSaTXbkn3MjqApeNL87b5jeUpUM419ln/a8jYZ/E4jJHBP/XQxucHehtMU1Tkrzgh7Re+lMF8x90LQk6x5TBziDOY643m6fGetG8/F7cCvtZYQXpfg0PmldqmN3Bw/kpgB8trqqhEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778484893; c=relaxed/simple;
	bh=jKWt/oveFInx1RhNyuqZ5Jpen/iEvJU8SFD0dXtmcw8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YipLbP5IvTicgocM1iNYR28CWm33IREuib5+HagjEHVGNDRIh/CLX7Gd8WApC3o8ePKxU2BUMgVm1krSytn+3nUWOc5+xAd8zk+7m79WU2IAHaYU/Da7MQBsOFSEpSf4Qk1jPPIqMR3jZMIHk7nSeRnC/I4XrZi0FANR1y9KzGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K+oGopmB; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K+oGopmB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A521DC2BCB0;
	Mon, 11 May 2026 07:34:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778484893;
	bh=jKWt/oveFInx1RhNyuqZ5Jpen/iEvJU8SFD0dXtmcw8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=K+oGopmBiefViapXQY+YYTIfW6YwtwOp99BuoeETKPsvERcCjU4BSh79hJmWLOAuL
	 +KtBCvR6TtR8NmB6tWFQ0WDh0rMn4C4Y7/IfHkcOBLuADrl7vaRZxCDs/Z/BX0hb/q
	 +toP6f7uZBSRfA/cjlMk8YWh41GA/+RTOfzlUQS8onmZ3HMAMNAZnZBNzLtbtHSGUO
	 AsMUBcZFTe0jyFbha8als9DDtcHtTYpfKo4ZjEGaH7X2y2ZyqqujsguF5qM3QkbMnv
	 gjGyv18m+OTNNhmLWmXeUcq4FdIGjhfnYe6XKL9PD0s/zuxEI6or8zCkJZ6dA7C2Xb
	 hvK203++VpBCQ==
Date: Mon, 11 May 2026 00:34:51 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: acme@kernel.org, gmx@google.com, james.clark@linaro.org,
	adrian.hunter@intel.com, jolsa@kernel.org,
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
	mingo@redhat.com, peterz@infradead.org
Subject: Re: [PATCH v6 5/6] perf test: Add inject ASLR test
Message-ID: <agGGm-QVsBb_apge@z2>
References: <20260506004546.3140141-1-irogers@google.com>
 <20260508082726.2795191-1-irogers@google.com>
 <20260508082726.2795191-6-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260508082726.2795191-6-irogers@google.com>

On Fri, May 08, 2026 at 01:27:25AM -0700, Ian Rogers wrote:
> Add a new shell test `inject_aslr.sh` to verify the `perf inject --aslr`
> feature. The test covers:
> - Basic address remapping for user space samples.
> - Pipe mode coverage for `perf record` piped into `perf inject --aslr`.
> - Callchain address remapping.
> - Consistency of `perf report` output before and after injection.
> - Pipe mode report consistency.
> - Dropping of samples that leak ASLR info (physical addresses).
> - Kernel address remapping (utilizing a dedicated kernel-intensive VFS dd workload
>   to guarantee continuous timer interrupts sampling flow inside kernel privilege states).
> - Kernel report consistency with address normalization.
> 
> The test suite is hardened with global 'set -o pipefail' assertions to catch
> pipeline failures, stream-consuming awk processors to handle SIGPIPE signals,
> and a dedicated pipe output scenario validating raw 'perf inject -o -' stdout
> streams.
> 
> Assisted-by: Gemini-CLI:Google Gemini 3
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
> v6: Refactor kernel-space sampling test cases to utilize a dedicated
>     system-call intensive VFS dd workload (kprog) instead of purely
>     userspace-bound tight loops, guaranteeing high-density kernel
>     privilege state sampling streams and eliminating intermittent
>     execution flakiness dropouts.
> 
> v5: Harden test suite verification pipelines by upgrading report
>     checks to strict sorted line-by-line diff comparisons to
>     accommodate remapped pointer shifts. Append || true fallback
>     operators to grep-v filtering pipelines to prevent the shell test
>     from spuriously aborting under set -o pipefail on empty inputs,
>     ensuring graceful failure checks trigger correctly.
> 
> v4: Reorder set -e/pipefail to prevent temp file leakage in root
>     directory on unprivileged record failures when run as root. Ensure
>     grep report filters have || true suffixes to avoid aborts under
>     pipefail. Add comprehensive pipe stdout injection attributes
>     validation case.
> 
> v3: Harden script with pipefail, SIGPIPE awk pipeline fixes, callchain
>     empty data asserts, baseline sample verification, and grep report
>     abort protections. Reorder set -e/pipefail to prevent stack leaks
>     in mktemp failures.
> 
> v2: Add sum comparison for kernel overhead and 32-bit math corrections. Add
>     awk with gsub for trailing dots and brackets normalizations. Trap EXIT,
>     prevent race conditions and avoid hardcoded perf binary.
> ---
>  tools/perf/tests/shell/inject_aslr.sh | 460 ++++++++++++++++++++++++++
>  1 file changed, 460 insertions(+)
>  create mode 100755 tools/perf/tests/shell/inject_aslr.sh
> 
> diff --git a/tools/perf/tests/shell/inject_aslr.sh b/tools/perf/tests/shell/inject_aslr.sh
> new file mode 100755
> index 000000000000..6363a0f69d2b
> --- /dev/null
> +++ b/tools/perf/tests/shell/inject_aslr.sh
> @@ -0,0 +1,460 @@
> +#!/bin/bash
> +# perf inject --aslr test
> +# SPDX-License-Identifier: GPL-2.0
> +
> +set -e
> +set -o pipefail
> +
> +shelldir=$(dirname "$0")
> +# shellcheck source=lib/perf_has_symbol.sh
> +. "${shelldir}"/lib/perf_has_symbol.sh
> +
> +sym="noploop"
> +
> +skip_test_missing_symbol ${sym}
> +
> +# Create global temp directory
> +temp_dir=$(mktemp -d /tmp/perf-test-aslr.XXXXXXXXXX)
> +data="${temp_dir}/perf.data"
> +data2="${temp_dir}/perf.data2"
> +
> +prog="perf test -w noploop"
> +[ "$(uname -m)" = "s390x" ] && prog="$prog 3"
> +err=0
> +kprog="dd if=/dev/zero of=/dev/null bs=1M count=500"
> +
> +cleanup() {
> +  # Check if temp_dir is set and looks sane before removing
> +  if [[ "${temp_dir}" =~ ^/tmp/perf-test-aslr\. ]]; then
> +    rm -rf "${temp_dir}"
> +  fi
> +}
> +
> +trap_cleanup() {
> +  cleanup
> +  exit 1
> +}
> +
> +trap cleanup EXIT
> +trap trap_cleanup TERM INT
> +
> +get_noploop_addr() {
> +  local file=$1
> +  perf script -i "$file" | awk '
> +    BEGIN { found=0 }
> +    {
> +      for (i=1; i<=NF; i++) {
> +        if ($i ~ /noploop\+/) {
> +          if (!found) {
> +            print $(i-1)
> +            found=1
> +          }
> +        }
> +      }
> +    }'
> +}
> +
> +test_basic_aslr() {
> +  echo "Test basic ASLR remapping"
> +  local data
> +  data=$(mktemp "${temp_dir}/perf.data.basic.XXXXXX")
> +  local data2
> +  data2=$(mktemp "${temp_dir}/perf.data2.basic.XXXXXX")

Why not use the globally defined data and data2 here and below?

Thanks,
Namhyung

> +
> +  perf record -e task-clock:u -o "${data}" ${prog}
> +  perf inject -v --aslr -i "${data}" -o "${data2}"
> +
> +  orig_addr=$(get_noploop_addr "${data}")
> +  new_addr=$(get_noploop_addr "${data2}")
> +
> +  echo "Basic ASLR: orig_addr=$orig_addr, new_addr=$new_addr"
> +
> +  if [ -z "$orig_addr" ]; then
> +    echo "Basic ASLR test [Failed - no noploop samples in original file]"
> +    err=1
> +  elif [ -z "$new_addr" ]; then
> +    echo "Basic ASLR test [Failed - could not find remapped address]"
> +    err=1
> +  elif [ "$orig_addr" = "$new_addr" ]; then
> +    echo "Basic ASLR test [Failed - addresses are not remapped]"
> +    err=1
> +  else
> +    echo "Basic ASLR test [Success]"
> +  fi
> +}
> +
> +test_pipe_aslr() {
> +  echo "Test pipe mode ASLR remapping"
> +  local data
> +  data=$(mktemp "${temp_dir}/perf.data.pipe.XXXXXX")
> +  local data2
> +  data2=$(mktemp "${temp_dir}/perf.data2.pipe.XXXXXX")
> +
> +  # Use tee to save the original pipe data for comparison
> +  perf record -e task-clock:u -o - ${prog} | tee "${data}" | perf inject --aslr -o "${data2}"
> +
> +  orig_addr=$(get_noploop_addr "${data}")
> +  new_addr=$(get_noploop_addr "${data2}")
> +
> +  echo "Pipe ASLR: orig_addr=$orig_addr, new_addr=$new_addr"
> +
> +  if [ -z "$orig_addr" ]; then
> +    echo "Pipe ASLR test [Failed - no noploop samples in original file]"
> +    err=1
> +  elif [ -z "$new_addr" ]; then
> +    echo "Pipe ASLR test [Failed - could not find remapped address]"
> +    err=1
> +  elif [ "$orig_addr" = "$new_addr" ]; then
> +    echo "Pipe ASLR test [Failed - addresses are not remapped]"
> +    err=1
> +  else
> +    echo "Pipe ASLR test [Success]"
> +  fi
> +}
> +
> +test_callchain_aslr() {
> +  echo "Test Callchain ASLR remapping"
> +  local data
> +  data=$(mktemp "${temp_dir}/perf.data.callchain.XXXXXX")
> +  local data2
> +  data2=$(mktemp "${temp_dir}/perf.data2.callchain.XXXXXX")
> +
> +  perf record -g -e task-clock:u -o "${data}" ${prog}
> +  perf inject --aslr -i "${data}" -o "${data2}"
> +
> +  orig_addr=$(get_noploop_addr "${data}")
> +  new_addr=$(get_noploop_addr "${data2}")
> +
> +  echo "Callchain ASLR: orig_addr=$orig_addr, new_addr=$new_addr"
> +
> +  if [ -z "$orig_addr" ]; then
> +    echo "Callchain ASLR test [Failed - no noploop samples in original file]"
> +    err=1
> +  elif [ -z "$new_addr" ]; then
> +    echo "Callchain ASLR test [Failed - could not find remapped address]"
> +    err=1
> +  elif [ "$orig_addr" = "$new_addr" ]; then
> +    echo "Callchain ASLR test [Failed - addresses are not remapped]"
> +    err=1
> +  else
> +    # Extract callchain addresses (indented lines starting with hex addresses)
> +    orig_callchain=$(perf script -i "${data}" | awk '/^[[:space:]]+[0-9a-f]+/ {print $1}')
> +    new_callchain=$(perf script -i "${data2}" | awk '/^[[:space:]]+[0-9a-f]+/ {print $1}')
> +
> +    if [ -z "$orig_callchain" ]; then
> +      echo "Callchain ASLR test [Failed - no callchain samples in original file]"
> +      err=1
> +    elif [ -z "$new_callchain" ]; then
> +      echo "Callchain ASLR test [Failed - callchain data was dropped]"
> +      err=1
> +    elif [ "$orig_callchain" = "$new_callchain" ]; then
> +      echo "Callchain ASLR test [Failed - callchain addresses were not remapped]"
> +      err=1
> +    else
> +      echo "Callchain ASLR test [Success]"
> +    fi
> +  fi
> +}
> +
> +test_report_aslr() {
> +  echo "Test perf report consistency"
> +  local data
> +  data=$(mktemp "${temp_dir}/perf.data.report.XXXXXX")
> +  local data2
> +  data2=$(mktemp "${temp_dir}/perf.data2.report.XXXXXX")
> +  local data_clean
> +  data_clean=$(mktemp "${temp_dir}/perf.data.clean.XXXXXX")
> +
> +  perf record -e task-clock:u -o "${data}" ${prog}
> +  # Use -b to inject build-ids and force ordered events processing in both
> +  perf inject -b -i "${data}" -o "${data_clean}"
> +  perf inject -v -b --aslr -i "${data}" -o "${data2}"
> +
> +  local report1="${temp_dir}/report1"
> +  local report2="${temp_dir}/report2"
> +  local report1_clean="${temp_dir}/report1.clean"
> +  local report2_clean="${temp_dir}/report2.clean"
> +  local diff_file="${temp_dir}/diff"
> +
> +  perf report -i "${data_clean}" --stdio > "${report1}"
> +  perf report -i "${data2}" --stdio > "${report2}"
> +
> +  # Strip headers and compare lines with percentages
> +  grep '%' "${report1}" | grep -v '^#' | sort > "${report1_clean}" || true
> +  grep '%' "${report2}" | grep -v '^#' | sort > "${report2_clean}" || true
> +
> +  diff -u -w "${report1_clean}" "${report2_clean}" > "${diff_file}" || true
> +
> +  if [ ! -s "${report1_clean}" ]; then
> +    echo "Report ASLR test [Failed - no samples captured]"
> +    err=1
> +  elif [ -s "${diff_file}" ]; then
> +    echo "Report ASLR test [Failed - reports differ]"
> +    echo "Showing first 20 lines of diff:"
> +    head -n 20 "${diff_file}"
> +    err=1
> +  else
> +    echo "Report ASLR test [Success]"
> +  fi
> +}
> +
> +test_pipe_report_aslr() {
> +  echo "Test pipe mode perf report consistency"
> +  local data
> +  data=$(mktemp "${temp_dir}/perf.data.pipe_report.XXXXXX")
> +  local data2
> +  data2=$(mktemp "${temp_dir}/perf.data2.pipe_report.XXXXXX")
> +  local data_clean
> +  data_clean=$(mktemp "${temp_dir}/perf.data.clean.XXXXXX")
> +
> +  # Use tee to save the original pipe data, then process it with inject -b
> +  perf record -e task-clock:u -o - ${prog} | \
> +    tee "${data}" | \
> +    perf inject -b --aslr -o "${data2}"
> +  perf inject -b -i "${data}" -o "${data_clean}"
> +
> +  local report1="${temp_dir}/report1"
> +  local report2="${temp_dir}/report2"
> +  local report1_clean="${temp_dir}/report1.clean"
> +  local report2_clean="${temp_dir}/report2.clean"
> +  local diff_file="${temp_dir}/diff"
> +
> +  perf report -i "${data_clean}" --stdio > "${report1}"
> +  perf report -i "${data2}" --stdio > "${report2}"
> +
> +  # Strip headers and compare lines with percentages
> +  grep '%' "${report1}" | grep -v '^#' | sort > "${report1_clean}" || true
> +  grep '%' "${report2}" | grep -v '^#' | sort > "${report2_clean}" || true
> +
> +  diff -u -w "${report1_clean}" "${report2_clean}" > "${diff_file}" || true
> +
> +  if [ ! -s "${report1_clean}" ]; then
> +    echo "Pipe Report ASLR test [Failed - no samples captured]"
> +    err=1
> +  elif [ -s "${diff_file}" ]; then
> +    echo "Pipe Report ASLR test [Failed - reports differ]"
> +    echo "Showing first 20 lines of diff:"
> +    head -n 20 "${diff_file}"
> +    err=1
> +  else
> +    echo "Pipe Report ASLR test [Success]"
> +  fi
> +}
> +
> +test_pipe_out_report_aslr() {
> +  echo "Test pipe output mode perf report consistency"
> +  local data
> +  data=$(mktemp "${temp_dir}/perf.data.pipe_out_report.XXXXXX")
> +  local data_clean
> +  data_clean=$(mktemp "${temp_dir}/perf.data.clean.XXXXXX")
> +
> +  perf record -e task-clock:u -o "${data}" ${prog}
> +  perf inject -b -i "${data}" -o "${data_clean}"
> +
> +  local report1="${temp_dir}/report1"
> +  local report2="${temp_dir}/report2"
> +  local report1_clean="${temp_dir}/report1.clean"
> +  local report2_clean="${temp_dir}/report2.clean"
> +  local diff_file="${temp_dir}/diff"
> +
> +  perf report -i "${data_clean}" --stdio > "${report1}"
> +  perf inject -b --aslr -i "${data}" -o - | perf report -i - --stdio > "${report2}"
> +
> +  # Strip headers and compare lines with percentages
> +  grep '%' "${report1}" | grep -v '^#' | sort > "${report1_clean}" || true
> +  grep '%' "${report2}" | grep -v '^#' | sort > "${report2_clean}" || true
> +
> +  diff -u -w "${report1_clean}" "${report2_clean}" > "${diff_file}" || true
> +
> +  if [ ! -s "${report1_clean}" ]; then
> +    echo "Pipe Output Report ASLR test [Failed - no samples captured]"
> +    err=1
> +  elif [ -s "${diff_file}" ]; then
> +    echo "Pipe Output Report ASLR test [Failed - reports differ]"
> +    echo "Showing first 20 lines of diff:"
> +    head -n 20 "${diff_file}"
> +    err=1
> +  else
> +    echo "Pipe Output Report ASLR test [Success]"
> +  fi
> +}
> +
> +test_dropped_samples() {
> +  echo "Test dropped samples (phys-data)"
> +  local data
> +  data=$(mktemp "${temp_dir}/perf.data.dropped.XXXXXX")
> +  local data2
> +  data2=$(mktemp "${temp_dir}/perf.data2.dropped.XXXXXX")
> +
> +  # Check if --phys-data is supported by recording a short run
> +  if ! perf record -e task-clock:u --phys-data -o "${data}" -- sleep 0.1 > /dev/null 2>&1; then
> +    echo "Skipping dropped samples test as --phys-data is not supported"
> +    return
> +  fi
> +
> +  perf record -e task-clock:u --phys-data -o "${data}" ${prog}
> +  perf inject --aslr -i "${data}" -o "${data2}"
> +
> +  # Verify that the original file actually contained samples!
> +  orig_samples=$(perf script -i "${data}" | wc -l)
> +  if [ "$orig_samples" -eq 0 ]; then
> +    echo "Dropped samples test [Failed - no samples in original file]"
> +    err=1
> +  else
> +    # Verify that samples are dropped.
> +    samples_count=$(perf script -i "${data2}" | wc -l)
> +
> +    if [ "$samples_count" -gt 0 ]; then
> +      echo "Dropped samples test [Failed - samples were not dropped]"
> +      err=1
> +    else
> +      echo "Dropped samples test [Success]"
> +    fi
> +  fi
> +}
> +
> +test_kernel_aslr() {
> +  echo "Test kernel ASLR remapping"
> +  local kdata
> +  kdata=$(mktemp "${temp_dir}/perf.data.kernel.XXXXXX")
> +  local kdata2
> +  kdata2=$(mktemp "${temp_dir}/perf.data2.kernel.XXXXXX")
> +  local log_file
> +  log_file=$(mktemp "${temp_dir}/kernel_record.log.XXXXXX")
> +
> +  # Try to record kernel samples
> +  if ! perf record -e task-clock:k -o "${kdata}" ${kprog} > "${log_file}" 2>&1; then
> +    echo "Skipping kernel ASLR test as recording failed (maybe no permissions)"
> +    return
> +  fi
> +
> +  # Check for warning about kernel map restriction
> +  if grep -q "Couldn't record kernel reference relocation symbol" "${log_file}"; then
> +    echo "Skipping kernel ASLR test as kernel map could not be recorded (permissions restricted)"
> +    return
> +  fi
> +
> +  perf inject -v --aslr -i "${kdata}" -o "${kdata2}"
> +
> +  # Check if kernel addresses are remapped.
> +  # Find the field that ends with :k: (the event name) and take the next field!
> +  orig_addr=$(perf script -i "${kdata}" | awk '
> +    BEGIN { found=0 }
> +    {
> +      for (i=1; i<NF; i++) {
> +        if ($i ~ /:[k]+:?$/) {
> +          if (!found) {
> +            print $(i+1)
> +            found=1
> +          }
> +        }
> +      }
> +    }')
> +  new_addr=$(perf script -i "${kdata2}" | awk '
> +    BEGIN { found=0 }
> +    {
> +      for (i=1; i<NF; i++) {
> +        if ($i ~ /:[k]+:?$/) {
> +          if (!found) {
> +            print $(i+1)
> +            found=1
> +          }
> +        }
> +      }
> +    }')
> +
> +  echo "Kernel ASLR: orig_addr=$orig_addr, new_addr=$new_addr"
> +
> +  if [ -z "$orig_addr" ]; then
> +    echo "Kernel ASLR test [Failed - no kernel samples in original file]"
> +    err=1
> +  elif [ -z "$new_addr" ]; then
> +    echo "Kernel ASLR test [Failed - could not find remapped address]"
> +    err=1
> +  elif [ "$orig_addr" = "$new_addr" ]; then
> +    echo "Kernel ASLR test [Failed - addresses are not remapped]"
> +    err=1
> +  else
> +    echo "Kernel ASLR test [Success]"
> +  fi
> +}
> +
> +test_kernel_report_aslr() {
> +  echo "Test kernel perf report consistency"
> +  local kdata
> +  kdata=$(mktemp "${temp_dir}/perf.data.kernel_report.XXXXXX")
> +  local kdata2
> +  kdata2=$(mktemp "${temp_dir}/perf.data2.kernel_report.XXXXXX")
> +  local data_clean
> +  data_clean=$(mktemp "${temp_dir}/perf.data.clean.XXXXXX")
> +  local log_file
> +  log_file=$(mktemp "${temp_dir}/kernel_report_record.log.XXXXXX")
> +
> +  # Try to record kernel samples
> +  if ! perf record -e task-clock:k -o "${kdata}" ${kprog} > "${log_file}" 2>&1; then
> +    echo "Skipping kernel report test as recording failed (maybe no permissions)"
> +    return
> +  fi
> +
> +  # Check for warning about kernel map restriction
> +  if grep -q "Couldn't record kernel reference relocation symbol" "${log_file}"; then
> +    echo "Skipping kernel report test as kernel map could not be recorded (permissions restricted)"
> +    return
> +  fi
> +
> +  # Use -b to inject build-ids and force ordered events processing in both
> +  perf inject -b -i "${kdata}" -o "${data_clean}"
> +  perf inject -v -b --aslr -i "${kdata}" -o "${kdata2}"
> +
> +  local report1="${temp_dir}/report_kernel1"
> +  local report2="${temp_dir}/report_kernel2"
> +  local report1_clean="${temp_dir}/report_kernel1.clean"
> +  local report2_clean="${temp_dir}/report_kernel2.clean"
> +
> +  perf report -i "${data_clean}" --stdio > "${report1}"
> +  perf report -i "${kdata2}" --stdio > "${report2}"
> +
> +  # Strip headers and compare lines with percentages
> +  grep '%' "${report1}" | grep -v '^#' > "${report1_clean}" || true
> +  grep '%' "${report2}" | grep -v '^#' > "${report2_clean}" || true
> +
> +  # Normalize kernel DSOs and addresses in clean reports
> +  # This allows kernel modules to be either a module or kernel.kallsyms
> +  local report1_norm="${temp_dir}/report_kernel1.norm"
> +  local report2_norm="${temp_dir}/report_kernel2.norm"
> +  local diff_file="${temp_dir}/diff_kernel"
> +
> +  grep -v -E '0x[0-9a-f]{8,}|0000000000000000' "${report1_clean}" | \
> +    awk '{gsub(/\[[a-zA-Z0-9_.-]{2,}\](\.[a-zA-Z0-9_]+)?/, "[kernel]", $0); print}' | \
> +    sort > "${report1_norm}" || true
> +  grep -v -E '0x[0-9a-f]{8,}|0000000000000000' "${report2_clean}" | \
> +    awk '{gsub(/\[[a-zA-Z0-9_.-]{2,}\](\.[a-zA-Z0-9_]+)?/, "[kernel]", $0); print}' | \
> +    sort > "${report2_norm}" || true
> +
> +  diff -u -w "${report1_norm}" "${report2_norm}" > "${diff_file}" || true
> +
> +  if [ ! -s "${report1_norm}" ]; then
> +    echo "Kernel Report ASLR test [Failed - no samples captured]"
> +    err=1
> +  elif [ -s "${diff_file}" ]; then
> +    echo "Kernel Report ASLR test [Failed - reports differ]"
> +    echo "Showing first 20 lines of diff:"
> +    head -n 20 "${diff_file}"
> +    err=1
> +  else
> +    echo "Kernel Report ASLR test [Success]"
> +  fi
> +}
> +
> +test_basic_aslr
> +test_pipe_aslr
> +test_callchain_aslr
> +test_report_aslr
> +test_pipe_report_aslr
> +test_pipe_out_report_aslr
> +test_dropped_samples
> +test_kernel_aslr
> +test_kernel_report_aslr
> +
> +cleanup
> +exit $err
> -- 
> 2.54.0.563.g4f69b47b94-goog
> 
