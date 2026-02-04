Received: from mail-dy1-f201.google.com (mail-dy1-f201.google.com [74.125.82.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 617CA34C981
	for <linux-perf-users@vger.kernel.org>; Wed,  4 Feb 2026 04:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770179204; cv=none; b=aza0eor5rHkYShkIstdKuPU8AxZhE7i0O4QAA2KUzuX1hDORDaKT9h6fvXl5s1PBgpl3xx0FAOgCq/YsNcId2KlwjB2tr1Ks6SioKRTQk7A8JQHYyLZyx06yuKVl5tejqKtHRa4WSj9ekAEgmCE4PCls3rlU7LBc+kEBXXVIKlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770179204; c=relaxed/simple;
	bh=azcVgxgY4NYs+Ot90qlOg8G+66v8hTISyc5hmyiQPwc=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Content-Type; b=XgNKFjPkeB/bGawhpnZwsLt7q2qj2V9zpV/TK+2G/gAFtBYx0y3Eznc/HWw0fR/O3R8VXDDZALHe0bfmxfDSqKd2PD0rEVXQDqSdwv1pkLCbirIfw0H6LW8CXAps54fsQPZTfkILjR+OpcVpJriibWO2lfY9Gs+NfX0RA7TCIaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3zjHJwv7; arc=none smtp.client-ip=74.125.82.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3zjHJwv7"
Received: by mail-dy1-f201.google.com with SMTP id 5a478bee46e88-2b83787af4cso1675671eec.1
        for <linux-perf-users@vger.kernel.org>; Tue, 03 Feb 2026 20:26:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1770179202; x=1770784002; darn=vger.kernel.org;
        h=to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=kT55jtil6v5CyUBqucg6MzXL+/ps9/MbCKBo9xAzepg=;
        b=3zjHJwv7lZcgmnGjI+a8s9oZoyfId0Po4MQoh9bzfPFwfVknpzMmuEyyMN6C5JlZ9t
         IFhAd3/zYk7rX3xOZX0FK49w4BR6kcZxF3Pz+DyYEJPquRKSKSTlKW9VggHd0/R4XQGN
         QeTZ8BvUWwUEqxl707WLodbhEcwd+FTOASt2T4cHcGPt1btzQZL5G60+6foEFHuedkmV
         rGw1pxIykPkYKdXkwfwOoJq8L8lPeCPLgyirR1B9IWF4Zz6dRrQFyMYZYQZJQHpV3VTN
         damwcQEwYDyVQiBwk89aZkjMOVbVoQhBOMnOW4MON1CKl35XWG1HABeoRpBAKTdVxlMb
         QXKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770179202; x=1770784002;
        h=to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kT55jtil6v5CyUBqucg6MzXL+/ps9/MbCKBo9xAzepg=;
        b=KdSnI3872oCLvTcbyvsqE43afaq3oonfpijENfQaBfxGOrUZydDTczw22xwokAm6PE
         wT5thwy+DRNKtwdTr/f2KWprsSm5alHZY1KrCUU7I3SpxUiBzRE4eQWBbFXmwDJetrhj
         NWcpLeekjFM6Plg/pnUJxsEiSslj+bnBaP6EVArBynNG6GMhzSDLO8Eyldr91Ne6PqxP
         C7MmjgFc65zsai8/980oVbjld17lzX5QeRM5wJACZ6QsqiWfIZxug4Od87j4IoaOmRzK
         eKZzN+riNBWtMcEr2c9WBlLkobiJnl6nri1kSwLwG/WiResOZZLyjI9L+bxydq4h3h5J
         bCvQ==
X-Forwarded-Encrypted: i=1; AJvYcCXoPy8VyRnIjejik+MAqxDW2fUoXmdtC6zvEXs63zJiv1NtU5v47h0n8redzr0UOU+/UdeAgmT8+Xy2LlM/gLa3@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1rpCO0Qvxm6wjJjf6PQ1K/HkCuS3HnbZ6+QYbOheBMtAZ12eO
	eyoJ5O+ncsGNE8h7sXcWGoGgHhxufcU43fTrvR505/hRwszt/kjhHUvygtjxcyTzSlbQnSRoZIf
	Y9CTD/3/P+Q==
X-Received: from dlbdm27.prod.google.com ([2002:a05:7022:6b9b:b0:123:291f:3e5b])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:24a5:b0:11e:353:57af
 with SMTP id a92af1059eb24-126f48db9e5mr970721c88.49.1770179202401; Tue, 03
 Feb 2026 20:26:42 -0800 (PST)
Date: Tue,  3 Feb 2026 20:26:29 -0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.53.0.rc2.204.g2597b5adb4-goog
Message-ID: <20260204042629.1376-1-irogers@google.com>
Subject: [PATCH v1] perf tests: Additional perf stat tests
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, Thomas Richter <tmricht@linux.ibm.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Andres Freund <andres@anarazel.de>
Content-Type: text/plain; charset="UTF-8"

Recently perf stat regressed in per CPU mode [1]. Let's expand test
coverage to catch the same breakage again as well as to test the
repeat, pid, detailed and no aggregation options.

[1] https://lore.kernel.org/linux-perf-users/cgja46br2smmznxs7kbeabs6zgv3b4olfqgh2fdp5mxk2yom4v@w6jjgov6hdi6/

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/shell/stat.sh | 242 +++++++++++++++++++++++++++++++++
 1 file changed, 242 insertions(+)

diff --git a/tools/perf/tests/shell/stat.sh b/tools/perf/tests/shell/stat.sh
index 792a0b79f6b8..4edb04039036 100755
--- a/tools/perf/tests/shell/stat.sh
+++ b/tools/perf/tests/shell/stat.sh
@@ -5,6 +5,21 @@
 set -e
 
 err=0
+stat_output=$(mktemp /tmp/perf-stat-test-output.XXXXX)
+
+cleanup() {
+  rm -f "${stat_output}"
+  trap - EXIT TERM INT
+}
+
+trap_cleanup() {
+  echo "Unexpected signal in ${FUNCNAME[1]}"
+  cleanup
+  exit 1
+}
+
+trap trap_cleanup EXIT TERM INT
+
 test_default_stat() {
   echo "Basic stat command test"
   if ! perf stat true 2>&1 | grep -E -q "Performance counter stats for 'true':"
@@ -248,6 +263,226 @@ test_hybrid() {
   echo "hybrid test [Success]"
 }
 
+test_stat_cpu() {
+  echo "stat -C <cpu> test"
+  # Test the full online CPU list (ranges and lists)
+  online_cpus=$(cat /sys/devices/system/cpu/online)
+  if ! perf stat -C "$online_cpus" -a true > "${stat_output}" 2>&1
+  then
+    echo "stat -C <cpu> test [Failed - command failed for cpus $online_cpus]"
+    cat "${stat_output}"
+    err=1
+    return
+  fi
+
+  if ! grep -E -q "Performance counter stats for" "${stat_output}"
+  then
+    echo "stat -C <cpu> test [Failed - missing output for cpus $online_cpus]"
+    cat "${stat_output}"
+    err=1
+    return
+  fi
+
+  # Test each individual online CPU
+  for cpu_dir in /sys/devices/system/cpu/cpu[0-9]*; do
+    cpu=${cpu_dir##*/cpu}
+    # Check if online
+    if [ -f "$cpu_dir/online" ] && [ "$(cat "$cpu_dir/online")" -eq 0 ]
+    then
+      continue
+    fi
+
+    if ! perf stat -C "$cpu" -a true > "${stat_output}" 2>&1
+    then
+      echo "stat -C <cpu> test [Failed - command failed for cpu $cpu]"
+      cat "${stat_output}"
+      err=1
+      return
+    fi
+    if ! grep -E -q "Performance counter stats for" "${stat_output}"
+    then
+      echo "stat -C <cpu> test [Failed - missing output for cpu $cpu]"
+      cat "${stat_output}"
+      err=1
+      return
+    fi
+  done
+
+  # Test synthetic list and range if cpu0 and cpu1 are online
+  c0_online=0
+  c1_online=0
+  if [ -d "/sys/devices/system/cpu/cpu0" ]
+  then
+    if [ ! -f "/sys/devices/system/cpu/cpu0/online" ] || [ "$(cat /sys/devices/system/cpu/cpu0/online)" -eq 1 ]
+    then
+      c0_online=1
+    fi
+  fi
+  if [ -d "/sys/devices/system/cpu/cpu1" ]
+  then
+    if [ ! -f "/sys/devices/system/cpu/cpu1/online" ] || [ "$(cat /sys/devices/system/cpu/cpu1/online)" -eq 1 ]
+    then
+      c1_online=1
+    fi
+  fi
+
+  if [ $c0_online -eq 1 ] && [ $c1_online -eq 1 ]
+  then
+    # Test list "0,1"
+    if ! perf stat -C "0,1" -a true > "${stat_output}" 2>&1
+    then
+      echo "stat -C <cpu> test [Failed - command failed for cpus 0,1]"
+      cat "${stat_output}"
+      err=1
+      return
+    fi
+    if ! grep -E -q "Performance counter stats for" "${stat_output}"
+    then
+      echo "stat -C <cpu> test [Failed - missing output for cpus 0,1]"
+      cat "${stat_output}"
+      err=1
+      return
+    fi
+
+    # Test range "0-1"
+    if ! perf stat -C "0-1" -a true > "${stat_output}" 2>&1
+    then
+      echo "stat -C <cpu> test [Failed - command failed for cpus 0-1]"
+      cat "${stat_output}"
+      err=1
+      return
+    fi
+    if ! grep -E -q "Performance counter stats for" "${stat_output}"
+    then
+      echo "stat -C <cpu> test [Failed - missing output for cpus 0-1]"
+      cat "${stat_output}"
+      err=1
+      return
+    fi
+  fi
+
+  echo "stat -C <cpu> test [Success]"
+}
+
+test_stat_no_aggr() {
+  echo "stat -A test"
+  if ! perf stat -A -a true > "${stat_output}" 2>&1
+  then
+    echo "stat -A test [Failed - command failed]"
+    cat "${stat_output}"
+    err=1
+    return
+  fi
+
+  if ! grep -E -q "CPU" "${stat_output}"
+  then
+    echo "stat -A test [Failed - missing CPU column]"
+    cat "${stat_output}"
+    err=1
+    return
+  fi
+  echo "stat -A test [Success]"
+}
+
+test_stat_detailed() {
+  echo "stat -d test"
+  if ! perf stat -d true > "${stat_output}" 2>&1
+  then
+    echo "stat -d test [Failed - command failed]"
+    cat "${stat_output}"
+    err=1
+    return
+  fi
+
+  if ! grep -E -q "Performance counter stats" "${stat_output}"
+  then
+    echo "stat -d test [Failed - missing output]"
+    cat "${stat_output}"
+    err=1
+    return
+  fi
+
+  if ! perf stat -dd true > "${stat_output}" 2>&1
+  then
+    echo "stat -dd test [Failed - command failed]"
+    cat "${stat_output}"
+    err=1
+    return
+  fi
+
+  if ! grep -E -q "Performance counter stats" "${stat_output}"
+  then
+    echo "stat -dd test [Failed - missing output]"
+    cat "${stat_output}"
+    err=1
+    return
+  fi
+
+  if ! perf stat -ddd true > "${stat_output}" 2>&1
+  then
+    echo "stat -ddd test [Failed - command failed]"
+    cat "${stat_output}"
+    err=1
+    return
+  fi
+
+  if ! grep -E -q "Performance counter stats" "${stat_output}"
+  then
+    echo "stat -ddd test [Failed - missing output]"
+    cat "${stat_output}"
+    err=1
+    return
+  fi
+
+  echo "stat -d test [Success]"
+}
+
+test_stat_repeat() {
+  echo "stat -r test"
+  if ! perf stat -r 2 true > "${stat_output}" 2>&1
+  then
+    echo "stat -r test [Failed - command failed]"
+    cat "${stat_output}"
+    err=1
+    return
+  fi
+
+  if ! grep -E -q "\([[:space:]]*\+-.*%[[:space:]]*\)" "${stat_output}"
+  then
+    echo "stat -r test [Failed - missing variance]"
+    cat "${stat_output}"
+    err=1
+    return
+  fi
+  echo "stat -r test [Success]"
+}
+
+test_stat_pid() {
+  echo "stat -p test"
+  sleep 1 &
+  pid=$!
+  if ! perf stat -p $pid > "${stat_output}" 2>&1
+  then
+    echo "stat -p test [Failed - command failed]"
+    cat "${stat_output}"
+    err=1
+    kill $pid 2>/dev/null || true
+    wait $pid 2>/dev/null || true
+    return
+  fi
+
+  if ! grep -E -q "Performance counter stats" "${stat_output}"
+  then
+    echo "stat -p test [Failed - missing output]"
+    cat "${stat_output}"
+    err=1
+  else
+    echo "stat -p test [Success]"
+  fi
+  kill $pid 2>/dev/null || true
+  wait $pid 2>/dev/null || true
+}
+
 test_default_stat
 test_null_stat
 test_offline_cpu_stat
@@ -258,4 +493,11 @@ test_topdown_groups
 test_topdown_weak_groups
 test_cputype
 test_hybrid
+test_stat_cpu
+test_stat_no_aggr
+test_stat_detailed
+test_stat_repeat
+test_stat_pid
+
+cleanup
 exit $err
-- 
2.53.0.rc2.204.g2597b5adb4-goog

