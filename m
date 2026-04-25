Received: from mail-dy1-f201.google.com (mail-dy1-f201.google.com [74.125.82.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C6F21FFC48
	for <linux-perf-users@vger.kernel.org>; Sat, 25 Apr 2026 02:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777082741; cv=none; b=b0HIAw4W1G+29M4COmCSkgaklviFE9nHLfA+L7x3v+jSZ1TM37iC1+PVfaeZk9Aa8HzJ4G0J7aFeEAAP9eCoZTq0imFGyTb5XmhPt95t9L+Xg6VGoUnmFdEuCvW0oM/4Z/tTyapqijnahjvYqcmHW5WrQ7CRSAQVkoxLeIaltw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777082741; c=relaxed/simple;
	bh=hx9KKJQ7PENY+qxdyUFCLFvcYr+6bSmURPnChQ7vaek=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=O8z6ISMiom76AE7/bDXbQZShznYVHB8uxP4u7OqrfHYk4BFl9F9VKsFpqD/u0WeUvHw15LPxcWygNV5fbK1m+ah+kLaV2G7HtKpWN90VTUxTQWb4sWMGCKzucKLuTGJKL6rbl2zfJ56f6kv2ax7pcJabLMDkZKOGKBt0W9SMERQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hTBjZLij; arc=none smtp.client-ip=74.125.82.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hTBjZLij"
Received: by mail-dy1-f201.google.com with SMTP id 5a478bee46e88-2d889997495so22200524eec.0
        for <linux-perf-users@vger.kernel.org>; Fri, 24 Apr 2026 19:05:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777082739; x=1777687539; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=27ooZSJSqX809abTI8ibD7ZPOaE+LcsGXpzPf6zna0U=;
        b=hTBjZLijui1SruUakQgWD9B/gVzIzvyq/nPIgx2iuzI4hPgqT2ZC4Cs7Izn3IORnSY
         IaIlsko3wEVZU6lvjKYIwqR57zhqNCj+aeXAQv/RWH3H1pt/Xaa5tzqxV+nTfqModRCy
         nsMtICEiyPm9kvM85rrDqjv3AyGuYvRui2sVRrdcnVnOtjpqcpV8KU13c1ykbPbE+UgF
         HxHmeEon08B+cicm8wrPp8omvQj9RTwHitr+gyzvNHxML977vkBRVAIyAeNtZEQZI147
         /UAkOzfNjQqZ6wnBfWcy8iNP0Ai0QhN2MjYor8rEpgcW6T8dnNTcOUS+EkxLMKkisJmW
         US3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777082739; x=1777687539;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=27ooZSJSqX809abTI8ibD7ZPOaE+LcsGXpzPf6zna0U=;
        b=qAS2ifkOPH9+sVzVZ0h+XG6CY3J8n8decsMHfSAZvmNEa9Cr4YasMwnmP+NQ+owCNn
         bKfeUS/OZwzRiHCaYzrRPEe3/s60eTKYuntjUoBrfUSO9SHZVEEAzqxo/jMX8kg4nNqa
         oSzrzYknTG06uN0TvMRoioXGVBIdGWwPqvUQHr+kjqEvjY3BsysUsqMle7JzvX5VfSe3
         ho1a8zUTQ5mYBYCslcCjSqM0+SruJmLwXvMH8GU0ZJI5USnVPYBFKZp1LZdrVQDXcyKe
         2ocl1N40IWDExCxEOpqUade0mNd0TJR3Y625xKcmMah+0XVmW0tWam/Ig0Cu/fk8xIzb
         Z45Q==
X-Forwarded-Encrypted: i=1; AFNElJ+8vLfpF8OEVLGTsTITyDw18l1qzgBT/8mnsa7QKFExII9TRPit37WBi+OQ8SRDHdFStbR05s+R8VNpMeiXavfJ@vger.kernel.org
X-Gm-Message-State: AOJu0Ywe5sXVMoF0jSgJEYwSTW9mQCfylilrEBvX3L0O1JmkpLjqmYYV
	nCyMKLBU1pxBUzia3NKOaAreWp/lMKmb6NxXubg9rQow+9woWSXR3tf0jBsretjopIbiqU7lM+7
	6BToUDcCDOQ==
X-Received: from dybta16.prod.google.com ([2002:a05:7301:6f10:b0:2d8:9b3:87f2])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7301:1693:b0:2d2:129a:1682
 with SMTP id 5a478bee46e88-2e4786460f9mr18736499eec.16.1777082739005; Fri, 24
 Apr 2026 19:05:39 -0700 (PDT)
Date: Fri, 24 Apr 2026 19:05:29 -0700
In-Reply-To: <20260425020529.3246331-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260424220519.2743472-1-irogers@google.com> <20260425020529.3246331-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260425020529.3246331-2-irogers@google.com>
Subject: [PATCH v2 2/2] perf test: Add inject ASLR test
From: Ian Rogers <irogers@google.com>
To: irogers@google.com
Cc: acme@kernel.org, adrian.hunter@intel.com, gmx@google.com, 
	james.clark@linaro.org, jolsa@kernel.org, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, mingo@redhat.com, namhyung@kernel.org, 
	peterz@infradead.org
Content-Type: text/plain; charset="UTF-8"

Add a new shell test `inject_aslr.sh` to verify the `perf inject --aslr`
feature. The test covers:
- Basic address remapping for user space samples.
- Pipe mode coverage for `perf record` piped into `perf inject --aslr`.
- Callchain address remapping.
- Consistency of `perf report` output before and after injection.
- Pipe mode report consistency.
- Dropping of samples that leak ASLR info (physical addresses).
- Kernel address remapping (skipping gracefully if permissions restrict
  recording the kernel map).
- Kernel report consistency with address normalization.

Assisted-by: Gemini:gemini-3.1-pro-preview
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/shell/inject_aslr.sh | 386 ++++++++++++++++++++++++++
 1 file changed, 386 insertions(+)
 create mode 100755 tools/perf/tests/shell/inject_aslr.sh

diff --git a/tools/perf/tests/shell/inject_aslr.sh b/tools/perf/tests/shell/inject_aslr.sh
new file mode 100755
index 000000000000..951809eecfd4
--- /dev/null
+++ b/tools/perf/tests/shell/inject_aslr.sh
@@ -0,0 +1,386 @@
+#!/bin/bash
+# perf inject --aslr test
+# SPDX-License-Identifier: GPL-2.0
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
+
+set -e
+
+cleanup() {
+  # Check if temp_dir is set and looks sane before removing
+  if [[ "${temp_dir}" =~ ^/tmp/perf-test-aslr\. ]]; then
+    rm -rf "${temp_dir}"
+  fi
+  trap - EXIT TERM INT
+}
+
+trap_cleanup() {
+  echo "Unexpected signal in ${FUNCNAME[1]}"
+  cleanup
+  exit 1
+}
+trap trap_cleanup TERM INT
+
+get_noploop_addr() {
+  local file=$1
+  perf script -i "$file" | awk '{for(i=1;i<=NF;i++) if($i ~ /noploop\+/) {print $(i-1); exit}}'
+}
+
+test_basic_aslr() {
+  echo "Test basic ASLR remapping"
+  local data
+  data=$(mktemp /tmp/perf.data.basic.XXXXXX)
+  local data2
+  data2=$(mktemp /tmp/perf.data2.basic.XXXXXX)
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
+    rm -f "${data}" "${data2}" "${data}.old" "${data2}.old"
+  fi
+}
+
+test_pipe_aslr() {
+  echo "Test pipe mode ASLR remapping"
+  local data
+  data=$(mktemp /tmp/perf.data.pipe.XXXXXX)
+  local data2
+  data2=$(mktemp /tmp/perf.data2.pipe.XXXXXX)
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
+    rm -f "${data}" "${data2}" "${data}.old" "${data2}.old"
+  fi
+}
+
+test_callchain_aslr() {
+  echo "Test Callchain ASLR remapping"
+  local data
+  data=$(mktemp /tmp/perf.data.callchain.XXXXXX)
+  local data2
+  data2=$(mktemp /tmp/perf.data2.callchain.XXXXXX)
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
+    # Also check that the full script output differs (to cover callchains)
+    orig_script=$(perf script -i "${data}" | grep -A 5 noploop | head -n 20)
+    new_script=$(perf script -i "${data2}" | grep -A 5 noploop | head -n 20)
+
+    if [ "$orig_script" = "$new_script" ]; then
+      echo "Callchain ASLR test [Failed - callchain output is identical]"
+      err=1
+    else
+      echo "Callchain ASLR test [Success]"
+      rm -f "${data}" "${data2}" "${data}.old" "${data2}.old"
+    fi
+  fi
+}
+
+test_report_aslr() {
+  echo "Test perf report consistency"
+  local data
+  data=$(mktemp /tmp/perf.data.report.XXXXXX)
+  local data2
+  data2=$(mktemp /tmp/perf.data2.report.XXXXXX)
+  local data_clean
+  data_clean=$(mktemp /tmp/perf.data.clean.XXXXXX)
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
+  grep '%' "${report1}" | grep -v '^#' | sort > "${report1_clean}"
+  grep '%' "${report2}" | grep -v '^#' | sort > "${report2_clean}"
+
+  diff -u -w "${report1_clean}" "${report2_clean}" > "${diff_file}" || true
+
+  if [ -s "${diff_file}" ]; then
+    echo "Report ASLR test [Failed - reports differ]"
+    echo "Showing first 20 lines of diff:"
+    head -n 20 "${diff_file}"
+    err=1
+  else
+    echo "Report ASLR test [Success]"
+  fi
+  rm -f "${data}" "${data2}" "${data_clean}" "${data}.old" "${data2}.old" "${data_clean}.old"
+}
+
+test_pipe_report_aslr() {
+  echo "Test pipe mode perf report consistency"
+  local data
+  data=$(mktemp /tmp/perf.data.pipe_report.XXXXXX)
+  local data2
+  data2=$(mktemp /tmp/perf.data2.pipe_report.XXXXXX)
+  local data_clean
+  data_clean=$(mktemp /tmp/perf.data.clean.XXXXXX)
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
+  grep '%' "${report1}" | grep -v '^#' | sort > "${report1_clean}"
+  grep '%' "${report2}" | grep -v '^#' | sort > "${report2_clean}"
+
+  diff -u -w "${report1_clean}" "${report2_clean}" > "${diff_file}" || true
+
+  if [ -s "${diff_file}" ]; then
+    echo "Pipe Report ASLR test [Failed - reports differ]"
+    echo "Showing first 20 lines of diff:"
+    head -n 20 "${diff_file}"
+    err=1
+  else
+    echo "Pipe Report ASLR test [Success]"
+  fi
+  rm -f "${data}" "${data2}" "${data_clean}" "${data}.old" "${data2}.old" "${data_clean}.old"
+}
+
+test_dropped_samples() {
+  echo "Test dropped samples (phys-data)"
+  local data
+  data=$(mktemp /tmp/perf.data.dropped.XXXXXX)
+  local data2
+  data2=$(mktemp /tmp/perf.data2.dropped.XXXXXX)
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
+  # Verify that samples are dropped.
+  samples_count=$(perf script -i "${data2}" | wc -l)
+
+  if [ "$samples_count" -gt 0 ]; then
+    echo "Dropped samples test [Failed - samples were not dropped]"
+    err=1
+  else
+    echo "Dropped samples test [Success]"
+    rm -f "${data}" "${data2}" "${data}.old" "${data2}.old"
+  fi
+}
+
+test_kernel_aslr() {
+  echo "Test kernel ASLR remapping"
+  local kdata
+  kdata=$(mktemp /tmp/perf.data.kernel.XXXXXX)
+  local kdata2
+  kdata2=$(mktemp /tmp/perf.data2.kernel.XXXXXX)
+  local log_file
+  log_file=$(mktemp /tmp/kernel_record.log.XXXXXX)
+
+  # Try to record kernel samples
+  if ! perf record -e task-clock:k -o "${kdata}" ${prog} > "${log_file}" 2>&1; then
+    echo "Skipping kernel ASLR test as recording failed (maybe no permissions)"
+    rm -f "${kdata}" "${log_file}"
+    return
+  fi
+
+  # Check for warning about kernel map restriction
+  if grep -q "Couldn't record kernel reference relocation symbol" "${log_file}"; then
+    echo "Skipping kernel ASLR test as kernel map could not be recorded (permissions restricted)"
+    rm -f "${kdata}" "${log_file}"
+    return
+  fi
+
+  perf inject -v --aslr -i "${kdata}" -o "${kdata2}"
+
+  # Check if kernel addresses are remapped.
+  orig_addr=$(perf script -i "${kdata}" | \
+    awk '{for(i=1;i<=NF;i++) if($i ~ /^ffff/) {print $i; exit}}')
+  new_addr=$(perf script -i "${kdata2}" | \
+    awk '{for(i=1;i<=NF;i++) if($i ~ /^ffff/) {print $i; exit}}')
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
+    rm -f "${kdata}" "${kdata2}" "${log_file}" "${kdata}.old" "${kdata2}.old"
+  fi
+}
+
+test_kernel_report_aslr() {
+  echo "Test kernel perf report consistency"
+  local kdata
+  kdata=$(mktemp /tmp/perf.data.kernel_report.XXXXXX)
+  local kdata2
+  kdata2=$(mktemp /tmp/perf.data2.kernel_report.XXXXXX)
+  local data_clean
+  data_clean=$(mktemp /tmp/perf.data.clean.XXXXXX)
+  local log_file
+  log_file=$(mktemp /tmp/kernel_report_record.log.XXXXXX)
+
+  # Try to record kernel samples
+  if ! perf record -e task-clock:k -o "${kdata}" ${prog} > "${log_file}" 2>&1; then
+    echo "Skipping kernel report test as recording failed (maybe no permissions)"
+    rm -f "${kdata}" "${log_file}"
+    return
+  fi
+
+  # Check for warning about kernel map restriction
+  if grep -q "Couldn't record kernel reference relocation symbol" "${log_file}"; then
+    echo "Skipping kernel report test as kernel map could not be recorded (permissions restricted)"
+    rm -f "${kdata}" "${log_file}"
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
+  grep '%' "${report1}" | grep -v '^#' > "${report1_clean}"
+  grep '%' "${report2}" | grep -v '^#' > "${report2_clean}"
+
+  # Normalize kernel DSOs and addresses in clean reports
+  # This allows kernel modules to be either a module or kernel.kallsyms
+  local report1_norm="${temp_dir}/report_kernel1.norm"
+  local report2_norm="${temp_dir}/report_kernel2.norm"
+
+  awk '{gsub(/\[[a-zA-Z0-9_.-]{2,}\](\.[a-zA-Z0-9_]+)?/, "[kernel]", $0); \
+        gsub(/0x[0-9a-f]+/, "[addr]", $0); \
+        gsub(/ffff[0-9a-f]+/, "[addr]", $0); \
+        gsub(/0000000000000000/, "[addr]", $0); \
+        print}' "${report1_clean}" > "${report1_norm}"
+  awk '{gsub(/\[[a-zA-Z0-9_.-]{2,}\](\.[a-zA-Z0-9_]+)?/, "[kernel]", $0); \
+        gsub(/0x[0-9a-f]+/, "[addr]", $0); \
+        gsub(/ffff[0-9a-f]+/, "[addr]", $0); \
+        gsub(/0000000000000000/, "[addr]", $0); \
+        print}' "${report2_clean}" > "${report2_norm}"
+
+  # Calculate sum of percentages for [kernel] samples
+  sum1=$(awk '/\[kernel\]/ {sum += $1} END {print sum}' "${report1_norm}")
+  sum2=$(awk '/\[kernel\]/ {sum += $1} END {print sum}' "${report2_norm}")
+
+  echo "Kernel report sums: sum1=$sum1, sum2=$sum2"
+
+  # Compare sums with tolerance
+  if awk -v s1="$sum1" -v s2="$sum2" \
+    'BEGIN {diff = s1 - s2; if (diff < 0) diff = -diff; if (diff < 0.05) exit 0; else exit 1}'; then
+    echo "Kernel Report ASLR test [Success]"
+  else
+    echo "Kernel Report ASLR test [Failed - sums differ too much]"
+    err=1
+  fi
+
+  rm -f "${kdata}" "${kdata2}" "${data_clean}" "${log_file}" \
+        "${kdata}.old" "${kdata2}.old" "${data_clean}.old"
+}
+
+test_basic_aslr
+test_pipe_aslr
+test_callchain_aslr
+test_report_aslr
+test_pipe_report_aslr
+test_dropped_samples
+test_kernel_aslr
+test_kernel_report_aslr
+
+cleanup
+exit $err
-- 
2.54.0.545.g6539524ca2-goog

