Received: from mail-dl1-f74.google.com (mail-dl1-f74.google.com [74.125.82.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40BBE372B57
	for <linux-perf-users@vger.kernel.org>; Fri,  5 Jun 2026 19:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780687484; cv=none; b=YsONQtoLlc7J7t33CfdaLuIv7CJmV8OCHuEosf+0st0gKZUDoezdBi0lXg8mGPpIoxEumauplwvh9GavZTjRXVRQjt2e0zAdTrHIndBPTCI6VF+ZPkCxgYYkaYhYE8zC6Se7vKHrt7mDo+/Vt3zR0gAXTl3yKkKQWf3DpDnftoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780687484; c=relaxed/simple;
	bh=EKtC/lvj/1x7foH7Gmv7h68D75QB3TnoOEUOZ0Aarac=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=nEsn2Jx6FBxb8mYUfn1zdtNb1PWa40c7AV+ciuy5dCz1QV8yxxkLWiErSzLgWE6KWqKK4s6C+TykKz8/F3xBE/NYIgrbaf2vHAggQQSPSejz4BtxGEpUPbNcYNtfre5iV29yCp3RHA1NoJkCHwRnbi4m7/0Mx175a2iJh2xTj2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LlKSk8tz; arc=none smtp.client-ip=74.125.82.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LlKSk8tz"
Received: by mail-dl1-f74.google.com with SMTP id a92af1059eb24-137dd3a60e8so2972981c88.0
        for <linux-perf-users@vger.kernel.org>; Fri, 05 Jun 2026 12:24:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780687481; x=1781292281; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=l+L+4ePAVYPRjEGmd/fjli1XPzR17aGwHmlHfUuUJqA=;
        b=LlKSk8tzfhaAi0T3+FblXDVi7SaJN+xjLA1ZmaQUryq3oTz385MRASbhTnco3h85RH
         WRz0Ez23LMA5XbvsD5rbOM+IyeFrhj001Z5aC7pHdGicaOTTdz7nPGmku3JARUu+gayv
         6iZ+tjEIUP6TA4A70fw0XbrGvSDoXhyZWiq1IMLXdjIlwkglWxlgZiICRCKL1qJleZiU
         KJ9fep3GQiEtYBI+6qPxvIkxN82uR9uk8LXGeIfO7yjdL9vb5mURfxVll1wiK+BY+RRv
         oDT8DnNqIEN+3lmqskXRinVQP0IAZ70YnWmdnAF6kyf0+ovrostQHuF8NykgH5WV8NMY
         jecw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780687481; x=1781292281;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=l+L+4ePAVYPRjEGmd/fjli1XPzR17aGwHmlHfUuUJqA=;
        b=ApCKs4/stlx51LvhtlJwyWzZcO9+it2OeM/wx9K0HX7uGs93hNR2AB2UmjMmAz+fZH
         16+CV8/wt/XP2g8o7I8Humtg6iGC+wrmbhzHtLjQ7FhnxwH0e0mqJEEuvFHfTqkhg0R9
         YuHP6bXMLWikIyIXdf+7mkZoKCBDE0QRGTpgzgS1kOoiE0Xm5k/hjpzvIQaap0j+zq3j
         /WDxW5/KGZrVSo+T6njs5iAEZNtn1JMMNFnFF8fPzq98gOM4ZYx0GDlctesNiPGKVL3S
         d0s/YMO1+XXGhKTLocCbe2BGFO31ynwMfKsIHMfx+fQ/PtkHUxTp2fDdUZ5SDcXZo0P0
         fZTg==
X-Forwarded-Encrypted: i=1; AFNElJ/Tegpr9rVNf8wti1fDrZF7bFhDVIN884CnkAcaNh1WgXf7JWw4qIjRfC88hE9GsGaRe/a8pIAGRyCiBwH8zGZf@vger.kernel.org
X-Gm-Message-State: AOJu0YxeaTl9oAhOQCp043tA4TqnBJlPX/H/MWNv/uGJNaDcci5mTzud
	3PR2ohohx26fHzfamWDSoWqGnDtzHDexmFaV2lpFHZkqo8RQTOcZb0odi8vVRqPkgLzC0R4eJwI
	NopG2GaCTLA==
X-Received: from dlbrh19.prod.google.com ([2002:a05:7022:f313:b0:137:ebca:4053])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:ef18:b0:136:c443:80e5
 with SMTP id a92af1059eb24-1380666051amr2449023c88.6.1780687480893; Fri, 05
 Jun 2026 12:24:40 -0700 (PDT)
Date: Fri,  5 Jun 2026 12:24:24 -0700
In-Reply-To: <20260605192425.2523260-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260605185215.2359881-1-irogers@google.com> <20260605192425.2523260-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.1032.g2f8565e1d1-goog
Message-ID: <20260605192425.2523260-5-irogers@google.com>
Subject: [PATCH v12 4/5] perf test: Add inject ASLR test
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, namhyung@kernel.org
Cc: adrian.hunter@intel.com, gmx@google.com, james.clark@linaro.org, 
	jolsa@kernel.org, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, mingo@redhat.com, peterz@infradead.org
Content-Type: text/plain; charset="UTF-8"

Add a new shell test  to verify the
feature. The test covers:
- Basic address remapping for user space samples.
- Pipe mode coverage for  piped into .
- Callchain address remapping.
- Consistency of  output before and after injection.
- Pipe mode report consistency.
- Dropping of samples that leak ASLR info (physical addresses).
- Kernel address remapping (utilizing a dedicated kernel-intensive VFS
  dd workload
  to guarantee continuous timer interrupts sampling flow inside kernel
  privilege states).
- Kernel report consistency with address normalization.

The test suite is hardened with global 'set -o pipefail' assertions to
catch pipeline failures, stream-consuming awk processors to handle
SIGPIPE signals, and a dedicated pipe output scenario validating raw
'perf inject -o -' stdout streams.

Assisted-by: Antigravity:gemini-3.5-flash
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/shell/inject_aslr.sh | 464 ++++++++++++++++++++++++++
 1 file changed, 464 insertions(+)
 create mode 100755 tools/perf/tests/shell/inject_aslr.sh

diff --git a/tools/perf/tests/shell/inject_aslr.sh b/tools/perf/tests/shell/inject_aslr.sh
new file mode 100755
index 000000000000..d8ded16ba905
--- /dev/null
+++ b/tools/perf/tests/shell/inject_aslr.sh
@@ -0,0 +1,464 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# perf inject --aslr test
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
+
+prog="perf test -w noploop"
+[ "$(uname -m)" = "s390x" ] && prog="$prog 3"
+err=0
+kprog="dd if=/dev/zero of=/dev/null bs=1M count=500"
+
+cleanup() {
+  local exit_code=${1:-$?}
+  trap - EXIT TERM INT
+  if [ "${exit_code}" -ne 0 ] || [ "${err}" -ne 0 ]; then
+    echo "Test failed! Preserving temp directory: ${temp_dir}"
+    return
+  fi
+  # Check if temp_dir is set and looks sane before removing
+  if [[ "${temp_dir}" =~ ^/tmp/perf-test-aslr\. ]]; then
+    rm -rf "${temp_dir}"
+  fi
+}
+
+trap_cleanup() {
+  local exit_code=$?
+  echo "Unexpected signal in ${FUNCNAME[1]}"
+  cleanup ${exit_code}
+  exit ${exit_code}
+}
+trap trap_cleanup EXIT TERM INT
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
+cleanup ${err}
+exit $err
-- 
2.54.0.1032.g2f8565e1d1-goog

