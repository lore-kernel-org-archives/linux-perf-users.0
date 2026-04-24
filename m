Received: from mail-dy1-f201.google.com (mail-dy1-f201.google.com [74.125.82.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CF77355F32
	for <linux-perf-users@vger.kernel.org>; Fri, 24 Apr 2026 22:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777068337; cv=none; b=tg9UZLUGLgzpjjEADqgpmmvxSx1xNmn/DFpMVOiXYv1B0WgFAZcvF2TOz9SU2YnYAcYwKZs+W9Q8vC8IPHwWTQ6q5XvLP7WyGvMqzMdXJknute4sRIQhxahaUE5NsATf2Twfs2AMYDX3B2BuQE0+c+JkJv7Oea/jkJpS/ESetX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777068337; c=relaxed/simple;
	bh=PIbggqJ5Md6AuWQ397v2W3howXvfXZUDyHOb2jduvA4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=p+MnoyI09fiJKeOUc2CRzKVwFNSapwNzDFWOwyJGcFjwIWJfkYdSaHqIl89YvyWr6Wl17tWXUjPzhcZchFaF+/8KET2NQvZo4YmBzCT7mhaJcaFsnAWQY9NcyCO6ZcdFObbgNXdmmQZjC9i4LJN4VBwBDpRUZ1KUs5Vn5aFYDNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=t0+5/VvM; arc=none smtp.client-ip=74.125.82.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="t0+5/VvM"
Received: by mail-dy1-f201.google.com with SMTP id 5a478bee46e88-2de07c12745so21591059eec.1
        for <linux-perf-users@vger.kernel.org>; Fri, 24 Apr 2026 15:05:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777068334; x=1777673134; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2C/xamTo7yJmyeXU2HjmjqBkcT9poi2uQvVonVohrjE=;
        b=t0+5/VvMSwN38tdyo1gz9jQPBlryhBrHlp0PitsFt3VrACmI3jq3JY6Pi6pqajUhGc
         WrWCTbyIF4HJ8h0MQQ8lsrHw9huAmhmwNtDRv9BlY/ms0Y3FiU/FwtJm7bxz4z1oZTni
         dRZM2aHSdwxCg50tsv5y/LjxcqDX1PJJqP6MEnfpVHHq+jInCSqaoXzCnBCJfSu6+qsi
         EesOfvnT7rGC65M4hiReHltvN9TiT2ArAgMfNrRkSNSdhK2DNBnnGvzPDa2YOY2gvcUs
         Lrd1VDK893YFyXE3i4fU1VW3IKXutelLaRuQ74GNvGnGQ7l9+WXPQhDSHuuULB8g/BGe
         Y4jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777068334; x=1777673134;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2C/xamTo7yJmyeXU2HjmjqBkcT9poi2uQvVonVohrjE=;
        b=jYOC0Fh6z75xaVTf4xuGz4BhvKB0dseN4TWrzQKf+/l1qim74S1blIPDIpMLkKtoRP
         y0xS4fItVFXW4zkk6tnaYnoBAro3jMMk/4TcAm6jCUZwzIFWEzvDWUJ4ws17aAQ5TX/x
         DiwGkKR5P4UkGOCDQHCixIKwSpxl0ShUXZYnETqGFR0P1O9bJII/Ewb+VIk97xPNWEXf
         ZP1shChVsOJjn/DQYkHpWv0vrCmQO2oMw6cdKozSbNJO3xPQ7qoWVkqxtmaD2TVSbGTi
         pynuVlJZevhHDgTbY8miJ36Tn3DMW4nEgutr3YQ0pxGCUJ6HCErqiiIWxeRI/Pp5NKPC
         FQmQ==
X-Forwarded-Encrypted: i=1; AFNElJ8+hnaslAKtoblJ1LtElQlZaB7TeHZqwqKLE1TG4whEj8l0FfSGiRO/blCGVi27xH8uFFPPDJeUC2ABE6kAG3q5@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1OKJ3O6wrfz1nkp+IeNRlJgCI9kmVSF0cnkSeE0Omh6eeJeDE
	qrA9ZtdUiApQWpdN1DwXzbGFaUFbKBg+xhSfmPkn1X8/UvMwDWGFmFxa17YX2mpf4yxoRYJ05Ay
	DZ10tsXIerQ==
X-Received: from dycal20.prod.google.com ([2002:a05:7301:1c94:b0:2d7:ab9e:d123])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:d706:b0:2c7:2c0b:f33b
 with SMTP id 5a478bee46e88-2e479d07dcamr20745564eec.20.1777068334285; Fri, 24
 Apr 2026 15:05:34 -0700 (PDT)
Date: Fri, 24 Apr 2026 15:05:19 -0700
In-Reply-To: <20260424220519.2743472-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260424220519.2743472-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260424220519.2743472-2-irogers@google.com>
Subject: [PATCH v1 2/2] perf test: Add inject ASLR test
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, Gabriel Marin <gmx@google.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
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
 tools/perf/tests/shell/inject_aslr.sh | 381 ++++++++++++++++++++++++++
 1 file changed, 381 insertions(+)
 create mode 100755 tools/perf/tests/shell/inject_aslr.sh

diff --git a/tools/perf/tests/shell/inject_aslr.sh b/tools/perf/tests/shell/inject_aslr.sh
new file mode 100755
index 000000000000..17544fe9ef6c
--- /dev/null
+++ b/tools/perf/tests/shell/inject_aslr.sh
@@ -0,0 +1,381 @@
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
+# Set path to built perf
+PERF="/tmp/perf3/perf"
+
+skip_test_missing_symbol ${sym}
+
+# Create global temp directory
+temp_dir=$(mktemp -d /tmp/perf-test-aslr.XXXXXXXXXX)
+data="${temp_dir}/perf.data"
+data2="${temp_dir}/perf.data2"
+
+prog="${PERF} test -w noploop"
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
+  ${PERF} script -i "$file" | awk '{for(i=1;i<=NF;i++) if($i ~ /noploop\+/) {print $(i-1); exit}}'
+}
+
+test_basic_aslr() {
+  echo "Test basic ASLR remapping"
+  local data
+  data=$(mktemp /tmp/perf.data.basic.XXXXXX)
+  local data2
+  data2=$(mktemp /tmp/perf.data2.basic.XXXXXX)
+
+  ${PERF} record -e task-clock:u -o "${data}" ${prog}
+  ${PERF} inject -v --aslr -i "${data}" -o "${data2}"
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
+  ${PERF} record -e task-clock:u -o - ${prog} | tee "${data}" | ${PERF} inject --aslr -o "${data2}"
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
+  ${PERF} record -g -e task-clock:u -o "${data}" ${prog}
+  ${PERF} inject --aslr -i "${data}" -o "${data2}"
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
+    orig_script=$(${PERF} script -i "${data}" | grep -A 5 noploop | head -n 20)
+    new_script=$(${PERF} script -i "${data2}" | grep -A 5 noploop | head -n 20)
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
+  ${PERF} record -e task-clock:u -o "${data}" ${prog}
+  # Use -b to inject build-ids and force ordered events processing in both
+  ${PERF} inject -b -i "${data}" -o "${data_clean}"
+  ${PERF} inject -v -b --aslr -i "${data}" -o "${data2}"
+
+  local report1="${temp_dir}/report1"
+  local report2="${temp_dir}/report2"
+  local report1_clean="${temp_dir}/report1.clean"
+  local report2_clean="${temp_dir}/report2.clean"
+  local diff_file="${temp_dir}/diff"
+
+  ${PERF} report -i "${data_clean}" --stdio > "${report1}"
+  ${PERF} report -i "${data2}" --stdio > "${report2}"
+
+  # Strip headers and compare lines with percentages
+  grep '%' "${report1}" | grep -v '^#' | sort > "${report1_clean}"
+  grep '%' "${report2}" | grep -v '^#' | sort > "${report2_clean}"
+
+  diff -u "${report1_clean}" "${report2_clean}" > "${diff_file}" || true
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
+  ${PERF} record -e task-clock:u -o - ${prog} | \
+    tee "${data}" | \
+    ${PERF} inject -b --aslr -o "${data2}"
+  ${PERF} inject -b -i "${data}" -o "${data_clean}"
+
+  local report1="${temp_dir}/report1"
+  local report2="${temp_dir}/report2"
+  local report1_clean="${temp_dir}/report1.clean"
+  local report2_clean="${temp_dir}/report2.clean"
+  local diff_file="${temp_dir}/diff"
+
+  ${PERF} report -i "${data_clean}" --stdio > "${report1}"
+  ${PERF} report -i "${data2}" --stdio > "${report2}"
+
+  # Strip headers and compare lines with percentages
+  grep '%' "${report1}" | grep -v '^#' | sort > "${report1_clean}"
+  grep '%' "${report2}" | grep -v '^#' | sort > "${report2_clean}"
+
+  diff -u "${report1_clean}" "${report2_clean}" > "${diff_file}" || true
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
+  if ! ${PERF} record -e task-clock:u --phys-data -o "${data}" -- sleep 0.1 > /dev/null 2>&1; then
+    echo "Skipping dropped samples test as --phys-data is not supported"
+    return
+  fi
+
+  ${PERF} record -e task-clock:u --phys-data -o "${data}" ${prog}
+  ${PERF} inject --aslr -i "${data}" -o "${data2}"
+
+  # Verify that samples are dropped.
+  samples_count=$(${PERF} script -i "${data2}" | wc -l)
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
+  if ! ${PERF} record -e task-clock:k -o "${kdata}" ${prog} > "${log_file}" 2>&1; then
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
+  ${PERF} inject -v --aslr -i "${kdata}" -o "${kdata2}"
+
+  # Check if kernel addresses are remapped.
+  orig_addr=$(${PERF} script -i "${kdata}" | awk '{for(i=1;i<=NF;i++) if($i ~ /^ffff/) {print $i; exit}}')
+  new_addr=$(${PERF} script -i "${kdata2}" | awk '{for(i=1;i<=NF;i++) if($i ~ /^ffff/) {print $i; exit}}')
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
+  if ! ${PERF} record -e task-clock:k -o "${kdata}" ${prog} > "${log_file}" 2>&1; then
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
+  ${PERF} inject -b -i "${kdata}" -o "${data_clean}"
+  ${PERF} inject -v -b --aslr -i "${kdata}" -o "${kdata2}"
+
+  local report1="${temp_dir}/report_kernel1"
+  local report2="${temp_dir}/report_kernel2"
+  local report1_clean="${temp_dir}/report_kernel1.clean"
+  local report2_clean="${temp_dir}/report_kernel2.clean"
+  local diff_file="${temp_dir}/diff_kernel"
+
+  ${PERF} report -i "${data_clean}" --stdio > "${report1}"
+  ${PERF} report -i "${kdata2}" --stdio > "${report2}"
+
+  # Strip headers and compare lines with percentages
+  grep '%' "${report1}" | grep -v '^#' > "${report1_clean}"
+  grep '%' "${report2}" | grep -v '^#' > "${report2_clean}"
+
+  # Normalize kernel DSOs and addresses in clean reports
+  # This allows kernel modules to be either a module or kernel.kallsyms
+  local report1_norm="${temp_dir}/report_kernel1.norm"
+  local report2_norm="${temp_dir}/report_kernel2.norm"
+  awk '{$3 = ($3 ~ /^\[.*\]$/ ? "[kernel]" : $3); \
+        for(i=1;i<=NF;i++) \
+          if($i ~ /^ffff/ || $i ~ /^0x/ || $i == "0000000000000000") \
+            $i = "[addr]"; \
+        print}' "${report1_clean}" | sort > "${report1_norm}"
+  awk '{$3 = ($3 ~ /^\[.*\]$/ ? "[kernel]" : $3); \
+        for(i=1;i<=NF;i++) \
+          if($i ~ /^ffff/ || $i ~ /^0x/ || $i == "0000000000000000") \
+            $i = "[addr]"; \
+        print}' "${report2_clean}" | sort > "${report2_norm}"
+
+  diff -u "${report1_norm}" "${report2_norm}" > "${diff_file}" || true
+
+  if [ -s "${diff_file}" ]; then
+    echo "Kernel Report ASLR test [Failed - reports differ]"
+    echo "Showing first 20 lines of diff:"
+    head -n 20 "${diff_file}"
+    err=1
+  else
+    echo "Kernel Report ASLR test [Success]"
+  fi
+  rm -f "${kdata}" "${kdata2}" "${data_clean}" "${log_file}" "${kdata}.old" "${kdata2}.old" "${data_clean}.old"
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

