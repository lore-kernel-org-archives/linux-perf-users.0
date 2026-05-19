Received: from mail-dl1-f74.google.com (mail-dl1-f74.google.com [74.125.82.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EF3C3164BB
	for <linux-perf-users@vger.kernel.org>; Tue, 19 May 2026 05:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779166936; cv=none; b=AWeFuilifG2RGrPu9z1xc5Qy729AlGcqAGa0uJATmWiRXnv1M4mZtnONWZiUY/QhfLVZiKaMF1Hen3pZIBHjdKLfEe9UCuLsWFgkUHeOSsGMJ1Q9Dmu4bXZ4MM5G28RNjuMp0D1auOWL+c7sPK7cfYBGtJLoSFYG1c51VkIhDKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779166936; c=relaxed/simple;
	bh=duIREe4HG2vRqUYgC/o42t17tX3jdFwLjdjffAKPCQA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=cMyzEfxb/1hLuays6IZIoUGyNBNblRM6uMO8PWxMyfppvVnaJFdV5I9Lb0Yal6ZvWJXz9ybUUcYeNhdJVDuVH5KMMoapKT7IxOArThPkKLfyoeh6C83JXJ7pKX3H2JtcS8FgYET3GuqmMdpsyReC/PVmYkklrbuYPUQizTtT/eA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NgJeWqrl; arc=none smtp.client-ip=74.125.82.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NgJeWqrl"
Received: by mail-dl1-f74.google.com with SMTP id a92af1059eb24-130aab78a09so3261048c88.0
        for <linux-perf-users@vger.kernel.org>; Mon, 18 May 2026 22:02:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779166934; x=1779771734; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=0aoZoCjQzbjQWWo0j3ADTrlwfj8g1NrK/ci8EJbhSMQ=;
        b=NgJeWqrlQXKftaWrKhSKpDkWzwh4O9777gb3gwPz80Iub7VjV84OPTUbQ34YuT/sn6
         Cf7j3tiJWimMV5fCC9ozj+vkDJVAI3Q2kOZiCOG703LA2jextOTu+J+oae0E+uS6HPfJ
         o2RoBUldEpgZQQJC+IFHF62WbJtQNML6sp5kWhDcTWuLJXIHwhsi2DRrhZktFZqg/8dM
         c4AEMUpjtiYUGmlI4nOV02F1yLmrNasXMOkAUr29Lmt8pYLRrAoJ779e8TEA2lo6O8rd
         gee1JXB+Gd3yZwLbgYlG0TM/JFZT86ktHQuhNrTTwD4SYGumcBg4UFMtOXmSHcMJ9QwO
         bL0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779166934; x=1779771734;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0aoZoCjQzbjQWWo0j3ADTrlwfj8g1NrK/ci8EJbhSMQ=;
        b=BrW2Bqj7VIuFoP+aoNJXcMTyrvt9C8GBzgFVt9NOCRuEt/C/yvjkXP1fpJWrs1SyGx
         L+3C5HhApyiIpealzr5sfCK0RcyfIbw2917o+n9igpqXnZDGbtA4Wbwn9TLWScB3c/lP
         1VPv3If8dj7SGgroc5Fbc5xJIi6++/lKfSvZA8LS9bfHW9tfJUYwvRHB/ODiNpc/7FH7
         HBoh0N5IICnIBLlCBPzTTG8ov6DKh86RLyTaqQ5iqyxUFdxEZxmQRjZEWmZ7ZyxneeuS
         ihNetMvhdjX+KDLLDxTETpo2V/5vlJa76pphHpdcT4ADZ7sVFGsa5g+CjbZ9Cl0zw7mP
         GK3A==
X-Forwarded-Encrypted: i=1; AFNElJ+iPuhN/YZ6rzfF07nTjUxSYHxhJxVvuuaEaCoejCPC1YasJifwZyJwm7FQynVh1iOsiWcN1jl3YufK9P3Bx40g@vger.kernel.org
X-Gm-Message-State: AOJu0YzmD8P1ITgHqJYgErh0+Krnr5rrpptFk2yWclq2eA+5M3yRYzxR
	QEQN1tPP4tOCXujjzD2RX0jIR+YmB+ZTPfIUjRMVQF5FznU6Qv5/cL5vPVZ6HdIY5UNUTOi2Pyp
	fdRF889uLuA==
X-Received: from dlzz26.prod.google.com ([2002:a05:7022:49a:b0:135:b9d2:2b2a])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:128c:b0:134:def6:e751
 with SMTP id a92af1059eb24-1350484238emr7611746c88.30.1779166933465; Mon, 18
 May 2026 22:02:13 -0700 (PDT)
Date: Mon, 18 May 2026 22:01:50 -0700
In-Reply-To: <20260519050150.3144907-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260519015108.3094513-1-irogers@google.com> <20260519050150.3144907-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.631.ge1b05301d1-goog
Message-ID: <20260519050150.3144907-3-irogers@google.com>
Subject: [PATCH v3 2/2] perf test: Add stat metrics --for-each-cgroup test
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, namhyung@kernel.org
Cc: adrian.hunter@intel.com, james.clark@linaro.org, jolsa@kernel.org, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	mingo@redhat.com, peterz@infradead.org, skanev@google.com
Content-Type: text/plain; charset="UTF-8"

Add a new shell test `stat_metrics_cgrp.sh` to verify metric reporting
with `--for-each-cgroup`, both with and without `--bpf-counters`.

The test:
- Checks if system-wide monitoring is supported (skips if not).
- Finds cgroups to test.
- Runs `perf stat` with `insn_per_cycle` metric and verifies that the
  metric is reported for each cgroup and does not contain invalid
  values (like `nan` or `nested`) or empty values when counts are
  present.
- Tests both standard mode and BPF counters mode (if supported).

Assisted-by: Antigravity:gemini-3-flash
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/shell/stat_metrics_cgrp.sh | 174 ++++++++++++++++++++
 1 file changed, 174 insertions(+)
 create mode 100755 tools/perf/tests/shell/stat_metrics_cgrp.sh

diff --git a/tools/perf/tests/shell/stat_metrics_cgrp.sh b/tools/perf/tests/shell/stat_metrics_cgrp.sh
new file mode 100755
index 000000000000..b413849193a0
--- /dev/null
+++ b/tools/perf/tests/shell/stat_metrics_cgrp.sh
@@ -0,0 +1,174 @@
+#!/bin/bash
+# perf stat metrics --for-each-cgroup test
+# SPDX-License-Identifier: GPL-2.0
+
+set -e
+
+test_cgroups=
+
+log_verbose() {
+	echo "$1"
+}
+
+is_numeric_and_non_zero() {
+	local val="$1"
+	if [[ "${val}" =~ ^[0-9]+$ ]] && [ "${val}" -gt 0 ]
+	then
+		return 0 # True
+	fi
+	return 1 # False
+}
+
+# skip if system-wide is not supported
+check_system_wide()
+{
+	log_verbose "Checking system-wide..."
+	if ! perf stat -a --metrics=insn_per_cycle sleep 0.01 > /dev/null 2>&1
+	then
+		log_verbose "Skipping: system-wide monitoring not supported"
+		exit 2
+	fi
+}
+
+# find two cgroups to measure
+find_cgroups()
+{
+	log_verbose "Finding cgroups..."
+	# try usual systemd slices first
+	if [ -d /sys/fs/cgroup/system.slice ] && [ -d /sys/fs/cgroup/user.slice ]
+	then
+		test_cgroups="system.slice,user.slice"
+		log_verbose "Found cgroups: ${test_cgroups}"
+		return
+	fi
+
+	# try root and self cgroups
+	find_cgroups_self_cgrp=$(grep perf_event /proc/self/cgroup | cut -d: -f3)
+	if [ -z "${find_cgroups_self_cgrp}" ]
+	then
+		# cgroup v2 doesn't specify perf_event
+		find_cgroups_self_cgrp=$(grep ^0: /proc/self/cgroup | cut -d: -f3)
+	fi
+
+	if [ -z "${find_cgroups_self_cgrp}" ]
+	then
+		test_cgroups="/"
+	else
+		test_cgroups="/,${find_cgroups_self_cgrp}"
+	fi
+	log_verbose "Found cgroups: ${test_cgroups}"
+}
+
+# Check if metric is reported for each cgroup
+# $1: extra options (e.g. --bpf-counters)
+check_metric_reported()
+{
+	local opts="$1"
+	local output
+
+	log_verbose "Running check_metric_reported with opts '${opts}'..."
+	# Run perf stat
+	if ! output=$(perf stat -a ${opts} \
+			--metrics=insn_per_cycle \
+			--for-each-cgroup "${test_cgroups}" \
+			-x, sleep 0.1 2>&1)
+	then
+		echo "FAIL: perf stat failed with exit code $?"
+		echo "Output: ${output}"
+		exit 1
+	fi
+
+	log_verbose "perf stat output:"
+	log_verbose "${output}"
+
+	# Split test_cgroups by comma
+	IFS=',' read -r -a cgrps <<< "${test_cgroups}"
+
+	for cgrp in "${cgrps[@]}"; do
+		# Find metric lines for this cgroup
+		# We use exact cgroup match with surrounding commas
+		local cgrp_lines
+		cgrp_lines=$(echo "${output}" | grep -F ",${cgrp}," | grep "insn_per_cycle" || true)
+
+		if [ -z "${cgrp_lines}" ]
+		then
+			echo "FAIL: No metric lines found for cgroup '${cgrp}'"
+			exit 1
+		fi
+
+		# Parse each metric line
+		while read -r line; do
+			[ -z "${line}" ] && continue
+
+			local cycles_val
+			cycles_val=$(echo "${line}" | cut -d, -f1)
+
+			local event_name
+			event_name=$(echo "${line}" | cut -d, -f3)
+
+			# Find corresponding instructions event line
+			local inst_event_name
+			inst_event_name="${event_name/cpu-cycles/instructions}"
+			inst_event_name="${inst_event_name/cycles/instructions}"
+
+			local inst_line
+			inst_line=$(echo "${output}" | \
+				grep -F ",${cgrp}," | \
+				grep -F "${inst_event_name}" || true)
+
+			local inst_val
+			inst_val=$(echo "${inst_line}" | cut -d, -f1)
+
+			log_verbose "Cgroup '${cgrp}': event '${event_name}' \
+val '${cycles_val}', inst event '${inst_event_name}' val '${inst_val}'"
+
+			# Only enforce metric check if both cycles and
+			# instructions have non-zero numeric counts
+			if is_numeric_and_non_zero "${cycles_val}" && \
+			   is_numeric_and_non_zero "${inst_val}"
+			then
+				log_verbose "Enforcing metric check for cgroup '${cgrp}' \
+event '${event_name}'"
+				# Check for nan or nested in the metric value (7th field)
+				# Actually we can just check the whole line for simplicity
+				if echo "${line}" | grep -q -i -E ",nan,|,nested,"
+				then
+					echo "FAIL: Invalid metric value (nan/nested) \
+for cgroup '${cgrp}'"
+					echo "Line: ${line}"
+					exit 1
+				fi
+				# Check for empty metric value (2 consecutive
+				# commas before the unit)
+				if echo "${line}" | grep -q -E ",,[[:space:]]*[^,]*insn_per_cycle"
+				then
+					echo "FAIL: Empty metric value for cgroup '${cgrp}'"
+					echo "Line: ${line}"
+					exit 1
+				fi
+			else
+				log_verbose "Skipping metric check for cgroup '${cgrp}' \
+event '${event_name}' (idle or not counted)"
+			fi
+		done <<< "${cgrp_lines}"
+	done
+	log_verbose "check_metric_reported passed for opts '${opts}'"
+}
+
+check_system_wide
+find_cgroups
+
+# Test 1: Without BPF counters
+check_metric_reported ""
+
+# Test 2: With BPF counters (if supported)
+log_verbose "Checking BPF support..."
+if perf stat -a --bpf-counters --for-each-cgroup / true > /dev/null 2>&1
+then
+	log_verbose "BPF supported, running Test 2..."
+	check_metric_reported "--bpf-counters"
+else
+	log_verbose "BPF not supported, skipping Test 2"
+fi
+
+exit 0
-- 
2.54.0.631.ge1b05301d1-goog

