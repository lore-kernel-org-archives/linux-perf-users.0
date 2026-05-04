Received: from mail-dl1-f74.google.com (mail-dl1-f74.google.com [74.125.82.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 436C11EE7D5
	for <linux-perf-users@vger.kernel.org>; Mon,  4 May 2026 03:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777866706; cv=none; b=eudXSSoKqDJLHD5yTHsJZ3gRg+LCS8YaBayyIwTlx9cd+aeEy8ocGnVG168BBkIv1PIaxR07wj8VabU8bXms/fiOqjV1ozPTFJ4taykgZ1CiqrH+M/tSENJgRQdnxfM8kBD0fSyESQTUD4tRs4LRibwdr4c3W0gpJi4N7QnWgzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777866706; c=relaxed/simple;
	bh=QyFcM88uFzx8pRnt6O+TUgQvIHrG2uCDRqN+BLtSVwo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=bzSvvKrv3efHGKKIH0lxhrymp6BLvrir9l8rGqy47tPpcj1xcFbbqcY3U31NV+sKmNkNEDm8M26WwJAa1PIGIb0keYszXiJNdb6GnjmXtxlfWnFCLiag5xUo2Hbmna9c0QPccMeV+lEDnz0X69n2/C9WtwXrHjRbx4zQRCZDaR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Y8d3CpkG; arc=none smtp.client-ip=74.125.82.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Y8d3CpkG"
Received: by mail-dl1-f74.google.com with SMTP id a92af1059eb24-12c726f4055so6101418c88.1
        for <linux-perf-users@vger.kernel.org>; Sun, 03 May 2026 20:51:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777866703; x=1778471503; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=o4zjjwnheQuipa7JdIuX+je4jCogvp4p9A3GIGkvi3M=;
        b=Y8d3CpkGoqiLd17VWmJSOmKIBj/eS3B24kRu7m7nr78YlvutC6LSc8jNf/jU4a7TIG
         nUl2qOg8fbLncAsHRaG5daxUwcT/9U05uYlmQ8Hzh6KlSHbNYM0WvunfpnJXJwB1oTHx
         6dphrMpAZLaSrYEtWN1VQh+TaA6Geh/X/j3lkq63dNrABzabag7QKrNwhtSM5KXMkgoZ
         nyfpXVrfE3TC5F3brOktzMQSILZa+bh88oVnZPl1wxDn7rOhIdeES9+vvIwk313k6N6y
         GNnN5FBKUM0b5P4rPi2Of5/rEiLKyjcu7YwKDsA3DHcz1tGTtMPeaO5Op7AyzVXWEpwC
         X6NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777866703; x=1778471503;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=o4zjjwnheQuipa7JdIuX+je4jCogvp4p9A3GIGkvi3M=;
        b=ocNGQcORYlep0x6uExJD/YLP13uFThoQYQo3pCmbr+a1YTAdyqE6+OKcTKEJn0XXEz
         SkxBlTv6IBFYZ8yhjz13iDqnGBBRoDq/6gKAWg+XX42+XUb+v84m0gLIbWeMpzR/0XBB
         FlDge+21fequWb7LBSONMHWAaHrQXrHZ2aDzqHlP/TeOXNaILhbJURmbI2asR8zOfQ6I
         Vhqni5FWhurJtbYqzA2DgEIw4TCWeDTQouxYKdA4nIAD40Sfmjctgwx4Oo96rBFtgWJq
         lP/qwBQaMlZF1PA2yxffP26SiPL7YovahLEzsnB5/A0j+b3Xnps1nBrU/LY/YFupNk8/
         epeg==
X-Forwarded-Encrypted: i=1; AFNElJ+Ou9g5CWPkevKTzjfRVKwGwsowtyl0xiMtxgB8ITxI+K/ZsjLQmWZWGZx9ih/4ui2q4CnVj7tg9eTwwRFZrETA@vger.kernel.org
X-Gm-Message-State: AOJu0Yyv9toYSj/6H48waCzdqkknNw0q5SCDHfxJiBZS4jAxlZ+zRrCf
	lmfWzbkLmtMBKk8XbFqXlC4f5Z/Z/EGdIBq6rTR/0Dsw36UMBzIhbmm0rQTiBNOjZm9Xlpgc5XK
	gUXvlgi4mMQ==
X-Received: from dlae25.prod.google.com ([2002:a05:701b:2319:b0:12d:c516:f51])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:61a:b0:12d:ce34:3fa0
 with SMTP id a92af1059eb24-12dfd856b43mr3648296c88.32.1777866703246; Sun, 03
 May 2026 20:51:43 -0700 (PDT)
Date: Sun,  3 May 2026 20:51:25 -0700
In-Reply-To: <20260504035125.1851720-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260425020529.3246331-1-irogers@google.com> <20260504035125.1851720-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260504035125.1851720-5-irogers@google.com>
Subject: [PATCH v3 4/4] perf test: Add inject ASLR test
From: Ian Rogers <irogers@google.com>
To: acme@kernel.org, gmx@google.com, namhyung@kernel.org
Cc: adrian.hunter@intel.com, james.clark@linaro.org, jolsa@kernel.org, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	mingo@redhat.com, peterz@infradead.org, Ian Rogers <irogers@google.com>
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

The test suite is hardened with:
- Global 'set -o pipefail' pipeline checks to catch failures in perf script.
- Safe awk processing loop closures that consume whole streams to avoid SIGPIPE
  signal aborts.
- False success assertions to verify callchain data isn't dynamically dropped.
- Graceful error paths on empty sample records.
- Multi-arch support (32-bit and 64-bit address normalizations).

Assisted-by: Gemini-CLI:Google Gemini 3
Signed-off-by: Ian Rogers <irogers@google.com>
---
v3: Harden script with pipefail, SIGPIPE awk pipeline fixes, callchain empty
    data asserts, baseline sample verification, and grep report abort
    protections. Ensure grep report filters have || true suffixes. Reorder
    set -e/pipefail to prevent stack leaks in mktemp failures.
v2: Add sum comparison for kernel overhead and 32-bit math corrections. Add
    awk with gsub for trailing dots and brackets normalizations. Trap EXIT,
    prevent race conditions and avoid hardcoded perf binary.
---
 tools/perf/tests/shell/inject_aslr.sh | 423 ++++++++++++++++++++++++++
 1 file changed, 423 insertions(+)
 create mode 100755 tools/perf/tests/shell/inject_aslr.sh

diff --git a/tools/perf/tests/shell/inject_aslr.sh b/tools/perf/tests/shell/inject_aslr.sh
new file mode 100755
index 000000000000..fa7dd3b4c411
--- /dev/null
+++ b/tools/perf/tests/shell/inject_aslr.sh
@@ -0,0 +1,423 @@
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
+
+
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
+  if ! perf record -e task-clock:k -o "${kdata}" ${prog} > "${log_file}" 2>&1; then
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
+  if ! perf record -e task-clock:k -o "${kdata}" ${prog} > "${log_file}" 2>&1; then
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
+
+  awk '{gsub(/\[[a-zA-Z0-9_.-]{2,}\](\.[a-zA-Z0-9_]+)?/, "[kernel]", $0); \
+        print}' "${report1_clean}" > "${report1_norm}"
+  awk '{gsub(/\[[a-zA-Z0-9_.-]{2,}\](\.[a-zA-Z0-9_]+)?/, "[kernel]", $0); \
+        print}' "${report2_clean}" > "${report2_norm}"
+
+  # Calculate sum of percentages for [kernel] samples
+  sum1=$(awk '/\[kernel\]/ {sum += $1} END {print sum}' "${report1_norm}")
+  sum2=$(awk '/\[kernel\]/ {sum += $1} END {print sum}' "${report2_norm}")
+
+  echo "Kernel report sums: sum1=$sum1, sum2=$sum2"
+
+  # Compare sums with tolerance
+  if [ -z "$sum1" ] || [ -z "$sum2" ]; then
+    echo "Kernel Report ASLR test [Failed - no kernel data]"
+    err=1
+  elif awk -v s1="$sum1" -v s2="$sum2" \
+    'BEGIN {diff = s1 - s2; if (diff < 0) diff = -diff; if (diff < 0.05) exit 0; else exit 1}'; then
+    echo "Kernel Report ASLR test [Success]"
+  else
+    echo "Kernel Report ASLR test [Failed - sums differ too much]"
+    err=1
+  fi
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

