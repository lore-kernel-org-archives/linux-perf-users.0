Received: from mail-dl1-f74.google.com (mail-dl1-f74.google.com [74.125.82.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D413237E2FE
	for <linux-perf-users@vger.kernel.org>; Fri,  8 May 2026 08:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778228868; cv=none; b=Dd0eMTwX0k5TjVfSCqNyQrn5zIVLjNqskA+kQnfUt2OOqKwUZATc3BI7TUy/LVwLg+7iElHYHKPEGQoKSQjAbtMtqAYXsPo/bp0eLg1r1KCYzHoavKrX3xBgjfUCojUIakJQRncOQAczVb1Xi9Gy3WpGhcKQeXAbWgB7oUZBGnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778228868; c=relaxed/simple;
	bh=7HirJ5qVLpmiuMokh9RUjY1fMBiUDXEHVgWcYLXfZYg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=UPR7lEI3pNxFkgOQ2xxcLejE/bhmzOb0RLZeMWQ/HYUSQG8xffjbtrZECMqbL8sa9aUOhAnHidszirIszRzRLFoJAqCpJF/5kAyC/48CuLAHpAmBKWG2C/YLYUhII1J1M+2N7cX+iKZLgI3D6/BwvrDeYthgbfHRDZMeUc2FbMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=amkR2y0Q; arc=none smtp.client-ip=74.125.82.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="amkR2y0Q"
Received: by mail-dl1-f74.google.com with SMTP id a92af1059eb24-1270dcd11c1so4189270c88.0
        for <linux-perf-users@vger.kernel.org>; Fri, 08 May 2026 01:27:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778228862; x=1778833662; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=d3Q+Xfl919I3XIbYdD+dydaVK24AehCNTI3/JjAsIrU=;
        b=amkR2y0Q4i6ZGPiUV/nVDkZ/NdH9qJlN092siBwPJQpTVqul8Y5aHILKte78dObDtb
         zKK/DEWo9a1KH+KRFWsEjGUf6/iHViBoqDsS/Xg8ORkgfyU4dr+vsEKvckW0r9EoMCG+
         A8FHIsI9P3Ej+HqlGeLkimEi13lHtqFSY+M/RGbx45MyNA4/S/H9cBcgeKLE8ziQagZj
         3qib7iXIZp06isNAAJ2OfJ22r/CUN7A53YtJQ8ic7oI/NQdmQORbsnhzPoVQw594Uhmu
         oxtRatAcgI0+u8AfIjSRY+Sb6dcO2e5qbgTRMuQy4PlTyBmK3mxTVv9krF7ljop9CSaC
         Sc9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778228862; x=1778833662;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=d3Q+Xfl919I3XIbYdD+dydaVK24AehCNTI3/JjAsIrU=;
        b=ITs1uvacnKLRVxGJoeWT+78+jWzAsUvJIeHE4pJPwFAcYd6/kK5a7tlf15IXkPo0Xu
         FkQnQSfutdJ2MKqFJX8QsmDTeHEvi50bOAfGknBbd2NR+JrIUNp4unuzXFrLLrWYqMdZ
         8i+0JSF6to9gklo24pZ2+S4M1M3+QsItVUG8tis3EnhyCxOUHF0KJB79kwrZuSKhXy7D
         gcT/OzqhJ7TCWgwZJn+QZzBdMF2j+woOXCeJNyF9W9HJHgvch03cZY5lEFwzg2qBwmU0
         onNIluaO4ltqFjvG0mwfhi7ItTvfrkwpQ3APY3J3lzPGVD6MP7C6h22XQ7DnNxYersv7
         V5+A==
X-Forwarded-Encrypted: i=1; AFNElJ9t+J9X28D2putS1tjRndXX7cDveItumQc3zP8z+nqoqH7qE22u8xBGzGr26gb/gTJQm+ZLhf/BcWbUxIboIMeZ@vger.kernel.org
X-Gm-Message-State: AOJu0YykTAiCrkMgvDGNvwa8+rBI6P61nwnP4mH2v+HEAPLlnTpDY3tQ
	cOL9xi8tWWW4k3+7dTzkkkOwdiboPnGXOfcd9nJYbidc9J8SUav7FCMd+JlKeIC6qUo+WAh193v
	7BXyg447yXA==
X-Received: from dlbrx17.prod.google.com ([2002:a05:7022:1711:b0:12c:8ccc:748c])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:f212:b0:129:fe5:117e
 with SMTP id a92af1059eb24-1319cf5953fmr5721412c88.26.1778228861718; Fri, 08
 May 2026 01:27:41 -0700 (PDT)
Date: Fri,  8 May 2026 01:27:25 -0700
In-Reply-To: <20260508082726.2795191-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260506004546.3140141-1-irogers@google.com> <20260508082726.2795191-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260508082726.2795191-6-irogers@google.com>
Subject: [PATCH v6 5/6] perf test: Add inject ASLR test
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, gmx@google.com, 
	james.clark@linaro.org, namhyung@kernel.org
Cc: adrian.hunter@intel.com, jolsa@kernel.org, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, mingo@redhat.com, peterz@infradead.org
Content-Type: text/plain; charset="UTF-8"

Add a new shell test `inject_aslr.sh` to verify the `perf inject --aslr`
feature. The test covers:
- Basic address remapping for user space samples.
- Pipe mode coverage for `perf record` piped into `perf inject --aslr`.
- Callchain address remapping.
- Consistency of `perf report` output before and after injection.
- Pipe mode report consistency.
- Dropping of samples that leak ASLR info (physical addresses).
- Kernel address remapping (utilizing a dedicated kernel-intensive VFS dd workload
  to guarantee continuous timer interrupts sampling flow inside kernel privilege states).
- Kernel report consistency with address normalization.

The test suite is hardened with global 'set -o pipefail' assertions to catch
pipeline failures, stream-consuming awk processors to handle SIGPIPE signals,
and a dedicated pipe output scenario validating raw 'perf inject -o -' stdout
streams.

Assisted-by: Gemini-CLI:Google Gemini 3
Signed-off-by: Ian Rogers <irogers@google.com>
---
v6: Refactor kernel-space sampling test cases to utilize a dedicated
    system-call intensive VFS dd workload (kprog) instead of purely
    userspace-bound tight loops, guaranteeing high-density kernel
    privilege state sampling streams and eliminating intermittent
    execution flakiness dropouts.

v5: Harden test suite verification pipelines by upgrading report
    checks to strict sorted line-by-line diff comparisons to
    accommodate remapped pointer shifts. Append || true fallback
    operators to grep-v filtering pipelines to prevent the shell test
    from spuriously aborting under set -o pipefail on empty inputs,
    ensuring graceful failure checks trigger correctly.

v4: Reorder set -e/pipefail to prevent temp file leakage in root
    directory on unprivileged record failures when run as root. Ensure
    grep report filters have || true suffixes to avoid aborts under
    pipefail. Add comprehensive pipe stdout injection attributes
    validation case.

v3: Harden script with pipefail, SIGPIPE awk pipeline fixes, callchain
    empty data asserts, baseline sample verification, and grep report
    abort protections. Reorder set -e/pipefail to prevent stack leaks
    in mktemp failures.

v2: Add sum comparison for kernel overhead and 32-bit math corrections. Add
    awk with gsub for trailing dots and brackets normalizations. Trap EXIT,
    prevent race conditions and avoid hardcoded perf binary.
---
 tools/perf/tests/shell/inject_aslr.sh | 460 ++++++++++++++++++++++++++
 1 file changed, 460 insertions(+)
 create mode 100755 tools/perf/tests/shell/inject_aslr.sh

diff --git a/tools/perf/tests/shell/inject_aslr.sh b/tools/perf/tests/shell/inject_aslr.sh
new file mode 100755
index 000000000000..6363a0f69d2b
--- /dev/null
+++ b/tools/perf/tests/shell/inject_aslr.sh
@@ -0,0 +1,460 @@
+#!/bin/bash
+# perf inject --aslr test
+# SPDX-License-Identifier: GPL-2.0
+
+set -e
+set -o pipefail
+
+shelldir=$(dirname "$0")
+# shellcheck source=lib/perf_has_symbol.sh
+. "${shelldir}"/lib/perf_has_symbol.sh
+
+sym="noploop"
+
+skip_test_missing_symbol ${sym}
+
+# Create global temp directory
+temp_dir=$(mktemp -d /tmp/perf-test-aslr.XXXXXXXXXX)
+data="${temp_dir}/perf.data"
+data2="${temp_dir}/perf.data2"
+
+prog="perf test -w noploop"
+[ "$(uname -m)" = "s390x" ] && prog="$prog 3"
+err=0
+kprog="dd if=/dev/zero of=/dev/null bs=1M count=500"
+
+cleanup() {
+  # Check if temp_dir is set and looks sane before removing
+  if [[ "${temp_dir}" =~ ^/tmp/perf-test-aslr\. ]]; then
+    rm -rf "${temp_dir}"
+  fi
+}
+
+trap_cleanup() {
+  cleanup
+  exit 1
+}
+
+trap cleanup EXIT
+trap trap_cleanup TERM INT
+
+get_noploop_addr() {
+  local file=$1
+  perf script -i "$file" | awk '
+    BEGIN { found=0 }
+    {
+      for (i=1; i<=NF; i++) {
+        if ($i ~ /noploop\+/) {
+          if (!found) {
+            print $(i-1)
+            found=1
+          }
+        }
+      }
+    }'
+}
+
+test_basic_aslr() {
+  echo "Test basic ASLR remapping"
+  local data
+  data=$(mktemp "${temp_dir}/perf.data.basic.XXXXXX")
+  local data2
+  data2=$(mktemp "${temp_dir}/perf.data2.basic.XXXXXX")
+
+  perf record -e task-clock:u -o "${data}" ${prog}
+  perf inject -v --aslr -i "${data}" -o "${data2}"
+
+  orig_addr=$(get_noploop_addr "${data}")
+  new_addr=$(get_noploop_addr "${data2}")
+
+  echo "Basic ASLR: orig_addr=$orig_addr, new_addr=$new_addr"
+
+  if [ -z "$orig_addr" ]; then
+    echo "Basic ASLR test [Failed - no noploop samples in original file]"
+    err=1
+  elif [ -z "$new_addr" ]; then
+    echo "Basic ASLR test [Failed - could not find remapped address]"
+    err=1
+  elif [ "$orig_addr" = "$new_addr" ]; then
+    echo "Basic ASLR test [Failed - addresses are not remapped]"
+    err=1
+  else
+    echo "Basic ASLR test [Success]"
+  fi
+}
+
+test_pipe_aslr() {
+  echo "Test pipe mode ASLR remapping"
+  local data
+  data=$(mktemp "${temp_dir}/perf.data.pipe.XXXXXX")
+  local data2
+  data2=$(mktemp "${temp_dir}/perf.data2.pipe.XXXXXX")
+
+  # Use tee to save the original pipe data for comparison
+  perf record -e task-clock:u -o - ${prog} | tee "${data}" | perf inject --aslr -o "${data2}"
+
+  orig_addr=$(get_noploop_addr "${data}")
+  new_addr=$(get_noploop_addr "${data2}")
+
+  echo "Pipe ASLR: orig_addr=$orig_addr, new_addr=$new_addr"
+
+  if [ -z "$orig_addr" ]; then
+    echo "Pipe ASLR test [Failed - no noploop samples in original file]"
+    err=1
+  elif [ -z "$new_addr" ]; then
+    echo "Pipe ASLR test [Failed - could not find remapped address]"
+    err=1
+  elif [ "$orig_addr" = "$new_addr" ]; then
+    echo "Pipe ASLR test [Failed - addresses are not remapped]"
+    err=1
+  else
+    echo "Pipe ASLR test [Success]"
+  fi
+}
+
+test_callchain_aslr() {
+  echo "Test Callchain ASLR remapping"
+  local data
+  data=$(mktemp "${temp_dir}/perf.data.callchain.XXXXXX")
+  local data2
+  data2=$(mktemp "${temp_dir}/perf.data2.callchain.XXXXXX")
+
+  perf record -g -e task-clock:u -o "${data}" ${prog}
+  perf inject --aslr -i "${data}" -o "${data2}"
+
+  orig_addr=$(get_noploop_addr "${data}")
+  new_addr=$(get_noploop_addr "${data2}")
+
+  echo "Callchain ASLR: orig_addr=$orig_addr, new_addr=$new_addr"
+
+  if [ -z "$orig_addr" ]; then
+    echo "Callchain ASLR test [Failed - no noploop samples in original file]"
+    err=1
+  elif [ -z "$new_addr" ]; then
+    echo "Callchain ASLR test [Failed - could not find remapped address]"
+    err=1
+  elif [ "$orig_addr" = "$new_addr" ]; then
+    echo "Callchain ASLR test [Failed - addresses are not remapped]"
+    err=1
+  else
+    # Extract callchain addresses (indented lines starting with hex addresses)
+    orig_callchain=$(perf script -i "${data}" | awk '/^[[:space:]]+[0-9a-f]+/ {print $1}')
+    new_callchain=$(perf script -i "${data2}" | awk '/^[[:space:]]+[0-9a-f]+/ {print $1}')
+
+    if [ -z "$orig_callchain" ]; then
+      echo "Callchain ASLR test [Failed - no callchain samples in original file]"
+      err=1
+    elif [ -z "$new_callchain" ]; then
+      echo "Callchain ASLR test [Failed - callchain data was dropped]"
+      err=1
+    elif [ "$orig_callchain" = "$new_callchain" ]; then
+      echo "Callchain ASLR test [Failed - callchain addresses were not remapped]"
+      err=1
+    else
+      echo "Callchain ASLR test [Success]"
+    fi
+  fi
+}
+
+test_report_aslr() {
+  echo "Test perf report consistency"
+  local data
+  data=$(mktemp "${temp_dir}/perf.data.report.XXXXXX")
+  local data2
+  data2=$(mktemp "${temp_dir}/perf.data2.report.XXXXXX")
+  local data_clean
+  data_clean=$(mktemp "${temp_dir}/perf.data.clean.XXXXXX")
+
+  perf record -e task-clock:u -o "${data}" ${prog}
+  # Use -b to inject build-ids and force ordered events processing in both
+  perf inject -b -i "${data}" -o "${data_clean}"
+  perf inject -v -b --aslr -i "${data}" -o "${data2}"
+
+  local report1="${temp_dir}/report1"
+  local report2="${temp_dir}/report2"
+  local report1_clean="${temp_dir}/report1.clean"
+  local report2_clean="${temp_dir}/report2.clean"
+  local diff_file="${temp_dir}/diff"
+
+  perf report -i "${data_clean}" --stdio > "${report1}"
+  perf report -i "${data2}" --stdio > "${report2}"
+
+  # Strip headers and compare lines with percentages
+  grep '%' "${report1}" | grep -v '^#' | sort > "${report1_clean}" || true
+  grep '%' "${report2}" | grep -v '^#' | sort > "${report2_clean}" || true
+
+  diff -u -w "${report1_clean}" "${report2_clean}" > "${diff_file}" || true
+
+  if [ ! -s "${report1_clean}" ]; then
+    echo "Report ASLR test [Failed - no samples captured]"
+    err=1
+  elif [ -s "${diff_file}" ]; then
+    echo "Report ASLR test [Failed - reports differ]"
+    echo "Showing first 20 lines of diff:"
+    head -n 20 "${diff_file}"
+    err=1
+  else
+    echo "Report ASLR test [Success]"
+  fi
+}
+
+test_pipe_report_aslr() {
+  echo "Test pipe mode perf report consistency"
+  local data
+  data=$(mktemp "${temp_dir}/perf.data.pipe_report.XXXXXX")
+  local data2
+  data2=$(mktemp "${temp_dir}/perf.data2.pipe_report.XXXXXX")
+  local data_clean
+  data_clean=$(mktemp "${temp_dir}/perf.data.clean.XXXXXX")
+
+  # Use tee to save the original pipe data, then process it with inject -b
+  perf record -e task-clock:u -o - ${prog} | \
+    tee "${data}" | \
+    perf inject -b --aslr -o "${data2}"
+  perf inject -b -i "${data}" -o "${data_clean}"
+
+  local report1="${temp_dir}/report1"
+  local report2="${temp_dir}/report2"
+  local report1_clean="${temp_dir}/report1.clean"
+  local report2_clean="${temp_dir}/report2.clean"
+  local diff_file="${temp_dir}/diff"
+
+  perf report -i "${data_clean}" --stdio > "${report1}"
+  perf report -i "${data2}" --stdio > "${report2}"
+
+  # Strip headers and compare lines with percentages
+  grep '%' "${report1}" | grep -v '^#' | sort > "${report1_clean}" || true
+  grep '%' "${report2}" | grep -v '^#' | sort > "${report2_clean}" || true
+
+  diff -u -w "${report1_clean}" "${report2_clean}" > "${diff_file}" || true
+
+  if [ ! -s "${report1_clean}" ]; then
+    echo "Pipe Report ASLR test [Failed - no samples captured]"
+    err=1
+  elif [ -s "${diff_file}" ]; then
+    echo "Pipe Report ASLR test [Failed - reports differ]"
+    echo "Showing first 20 lines of diff:"
+    head -n 20 "${diff_file}"
+    err=1
+  else
+    echo "Pipe Report ASLR test [Success]"
+  fi
+}
+
+test_pipe_out_report_aslr() {
+  echo "Test pipe output mode perf report consistency"
+  local data
+  data=$(mktemp "${temp_dir}/perf.data.pipe_out_report.XXXXXX")
+  local data_clean
+  data_clean=$(mktemp "${temp_dir}/perf.data.clean.XXXXXX")
+
+  perf record -e task-clock:u -o "${data}" ${prog}
+  perf inject -b -i "${data}" -o "${data_clean}"
+
+  local report1="${temp_dir}/report1"
+  local report2="${temp_dir}/report2"
+  local report1_clean="${temp_dir}/report1.clean"
+  local report2_clean="${temp_dir}/report2.clean"
+  local diff_file="${temp_dir}/diff"
+
+  perf report -i "${data_clean}" --stdio > "${report1}"
+  perf inject -b --aslr -i "${data}" -o - | perf report -i - --stdio > "${report2}"
+
+  # Strip headers and compare lines with percentages
+  grep '%' "${report1}" | grep -v '^#' | sort > "${report1_clean}" || true
+  grep '%' "${report2}" | grep -v '^#' | sort > "${report2_clean}" || true
+
+  diff -u -w "${report1_clean}" "${report2_clean}" > "${diff_file}" || true
+
+  if [ ! -s "${report1_clean}" ]; then
+    echo "Pipe Output Report ASLR test [Failed - no samples captured]"
+    err=1
+  elif [ -s "${diff_file}" ]; then
+    echo "Pipe Output Report ASLR test [Failed - reports differ]"
+    echo "Showing first 20 lines of diff:"
+    head -n 20 "${diff_file}"
+    err=1
+  else
+    echo "Pipe Output Report ASLR test [Success]"
+  fi
+}
+
+test_dropped_samples() {
+  echo "Test dropped samples (phys-data)"
+  local data
+  data=$(mktemp "${temp_dir}/perf.data.dropped.XXXXXX")
+  local data2
+  data2=$(mktemp "${temp_dir}/perf.data2.dropped.XXXXXX")
+
+  # Check if --phys-data is supported by recording a short run
+  if ! perf record -e task-clock:u --phys-data -o "${data}" -- sleep 0.1 > /dev/null 2>&1; then
+    echo "Skipping dropped samples test as --phys-data is not supported"
+    return
+  fi
+
+  perf record -e task-clock:u --phys-data -o "${data}" ${prog}
+  perf inject --aslr -i "${data}" -o "${data2}"
+
+  # Verify that the original file actually contained samples!
+  orig_samples=$(perf script -i "${data}" | wc -l)
+  if [ "$orig_samples" -eq 0 ]; then
+    echo "Dropped samples test [Failed - no samples in original file]"
+    err=1
+  else
+    # Verify that samples are dropped.
+    samples_count=$(perf script -i "${data2}" | wc -l)
+
+    if [ "$samples_count" -gt 0 ]; then
+      echo "Dropped samples test [Failed - samples were not dropped]"
+      err=1
+    else
+      echo "Dropped samples test [Success]"
+    fi
+  fi
+}
+
+test_kernel_aslr() {
+  echo "Test kernel ASLR remapping"
+  local kdata
+  kdata=$(mktemp "${temp_dir}/perf.data.kernel.XXXXXX")
+  local kdata2
+  kdata2=$(mktemp "${temp_dir}/perf.data2.kernel.XXXXXX")
+  local log_file
+  log_file=$(mktemp "${temp_dir}/kernel_record.log.XXXXXX")
+
+  # Try to record kernel samples
+  if ! perf record -e task-clock:k -o "${kdata}" ${kprog} > "${log_file}" 2>&1; then
+    echo "Skipping kernel ASLR test as recording failed (maybe no permissions)"
+    return
+  fi
+
+  # Check for warning about kernel map restriction
+  if grep -q "Couldn't record kernel reference relocation symbol" "${log_file}"; then
+    echo "Skipping kernel ASLR test as kernel map could not be recorded (permissions restricted)"
+    return
+  fi
+
+  perf inject -v --aslr -i "${kdata}" -o "${kdata2}"
+
+  # Check if kernel addresses are remapped.
+  # Find the field that ends with :k: (the event name) and take the next field!
+  orig_addr=$(perf script -i "${kdata}" | awk '
+    BEGIN { found=0 }
+    {
+      for (i=1; i<NF; i++) {
+        if ($i ~ /:[k]+:?$/) {
+          if (!found) {
+            print $(i+1)
+            found=1
+          }
+        }
+      }
+    }')
+  new_addr=$(perf script -i "${kdata2}" | awk '
+    BEGIN { found=0 }
+    {
+      for (i=1; i<NF; i++) {
+        if ($i ~ /:[k]+:?$/) {
+          if (!found) {
+            print $(i+1)
+            found=1
+          }
+        }
+      }
+    }')
+
+  echo "Kernel ASLR: orig_addr=$orig_addr, new_addr=$new_addr"
+
+  if [ -z "$orig_addr" ]; then
+    echo "Kernel ASLR test [Failed - no kernel samples in original file]"
+    err=1
+  elif [ -z "$new_addr" ]; then
+    echo "Kernel ASLR test [Failed - could not find remapped address]"
+    err=1
+  elif [ "$orig_addr" = "$new_addr" ]; then
+    echo "Kernel ASLR test [Failed - addresses are not remapped]"
+    err=1
+  else
+    echo "Kernel ASLR test [Success]"
+  fi
+}
+
+test_kernel_report_aslr() {
+  echo "Test kernel perf report consistency"
+  local kdata
+  kdata=$(mktemp "${temp_dir}/perf.data.kernel_report.XXXXXX")
+  local kdata2
+  kdata2=$(mktemp "${temp_dir}/perf.data2.kernel_report.XXXXXX")
+  local data_clean
+  data_clean=$(mktemp "${temp_dir}/perf.data.clean.XXXXXX")
+  local log_file
+  log_file=$(mktemp "${temp_dir}/kernel_report_record.log.XXXXXX")
+
+  # Try to record kernel samples
+  if ! perf record -e task-clock:k -o "${kdata}" ${kprog} > "${log_file}" 2>&1; then
+    echo "Skipping kernel report test as recording failed (maybe no permissions)"
+    return
+  fi
+
+  # Check for warning about kernel map restriction
+  if grep -q "Couldn't record kernel reference relocation symbol" "${log_file}"; then
+    echo "Skipping kernel report test as kernel map could not be recorded (permissions restricted)"
+    return
+  fi
+
+  # Use -b to inject build-ids and force ordered events processing in both
+  perf inject -b -i "${kdata}" -o "${data_clean}"
+  perf inject -v -b --aslr -i "${kdata}" -o "${kdata2}"
+
+  local report1="${temp_dir}/report_kernel1"
+  local report2="${temp_dir}/report_kernel2"
+  local report1_clean="${temp_dir}/report_kernel1.clean"
+  local report2_clean="${temp_dir}/report_kernel2.clean"
+
+  perf report -i "${data_clean}" --stdio > "${report1}"
+  perf report -i "${kdata2}" --stdio > "${report2}"
+
+  # Strip headers and compare lines with percentages
+  grep '%' "${report1}" | grep -v '^#' > "${report1_clean}" || true
+  grep '%' "${report2}" | grep -v '^#' > "${report2_clean}" || true
+
+  # Normalize kernel DSOs and addresses in clean reports
+  # This allows kernel modules to be either a module or kernel.kallsyms
+  local report1_norm="${temp_dir}/report_kernel1.norm"
+  local report2_norm="${temp_dir}/report_kernel2.norm"
+  local diff_file="${temp_dir}/diff_kernel"
+
+  grep -v -E '0x[0-9a-f]{8,}|0000000000000000' "${report1_clean}" | \
+    awk '{gsub(/\[[a-zA-Z0-9_.-]{2,}\](\.[a-zA-Z0-9_]+)?/, "[kernel]", $0); print}' | \
+    sort > "${report1_norm}" || true
+  grep -v -E '0x[0-9a-f]{8,}|0000000000000000' "${report2_clean}" | \
+    awk '{gsub(/\[[a-zA-Z0-9_.-]{2,}\](\.[a-zA-Z0-9_]+)?/, "[kernel]", $0); print}' | \
+    sort > "${report2_norm}" || true
+
+  diff -u -w "${report1_norm}" "${report2_norm}" > "${diff_file}" || true
+
+  if [ ! -s "${report1_norm}" ]; then
+    echo "Kernel Report ASLR test [Failed - no samples captured]"
+    err=1
+  elif [ -s "${diff_file}" ]; then
+    echo "Kernel Report ASLR test [Failed - reports differ]"
+    echo "Showing first 20 lines of diff:"
+    head -n 20 "${diff_file}"
+    err=1
+  else
+    echo "Kernel Report ASLR test [Success]"
+  fi
+}
+
+test_basic_aslr
+test_pipe_aslr
+test_callchain_aslr
+test_report_aslr
+test_pipe_report_aslr
+test_pipe_out_report_aslr
+test_dropped_samples
+test_kernel_aslr
+test_kernel_report_aslr
+
+cleanup
+exit $err
-- 
2.54.0.563.g4f69b47b94-goog

