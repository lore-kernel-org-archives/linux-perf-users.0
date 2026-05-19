Received: from mail-dy1-f202.google.com (mail-dy1-f202.google.com [74.125.82.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D554C408032
	for <linux-perf-users@vger.kernel.org>; Tue, 19 May 2026 15:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779204453; cv=none; b=aIJHnMjgi4SxULYVwICn4tW3usdvFUp3nGq0fCZHzGrapj+JM9Qg+ADydTn/KaGAqLMlZNbznuZdlOcKyvNO+4Y1cjsTG6eB+F7wETJkDISZJe0hxJ3M7to5LeJjz0bXK4rqzrWt+vVGNx4jmHhfhq+AfT4MS5YVZmaa3OAjep4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779204453; c=relaxed/simple;
	bh=hdPQLbELoyYXCHOx/RYBPidYuoOvW8qQm7CvBoVMcZo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=FwfmUIlxWl3mVVmoQQWldyRW9H1S0VcIhJ/NxjUbRrkinAsef1Hpu3FsCoeDyQ6ui1eghHaePsIkdM59cRaboEiqMWFZBZGDLOC+BuGvTCuMaNy9UmnFqPTWFcvjoDXBXJAdwNg1uK3u4ELkAFe9ekJunF0wIlMXPV+0gVwMNsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cOY6a7nB; arc=none smtp.client-ip=74.125.82.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cOY6a7nB"
Received: by mail-dy1-f202.google.com with SMTP id 5a478bee46e88-2f5943ca81aso13908758eec.0
        for <linux-perf-users@vger.kernel.org>; Tue, 19 May 2026 08:27:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779204451; x=1779809251; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=mK1jYuMDB5WeEbtxhwS5vhYLwEQjF9HCTJl/UtbPre4=;
        b=cOY6a7nBP4QNbthX8rwU/k24CrqcIgsHv5VWfQrWT1Vhce1sxO1htdkgFNq58nqMye
         lf9V4QS4MIdnEmp/vH/Gq8wJxv5I/7WH3cEDTAFeRCs1bjMQH1RcjXC6rGaE5PSXERpx
         B6jvj81E5TxhrSd6QDu/aEDSF7SJ7awgoJ8GKsae2ocLWff+n7+hplMb9wijLm/MgolN
         SVNUCbVS/1xEDpJrQdcwvHnBzI6Utqv/mGDD7bOCgkDvWrLXbkMhp1g4iaVNqX5Nr8Zz
         rD29A+7n4R8mwDD3mMvD8ePrpVD004dpcfm2CEYuQGJiiZf7lb2cc70FYNPSnQEi0dk9
         BWKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779204451; x=1779809251;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mK1jYuMDB5WeEbtxhwS5vhYLwEQjF9HCTJl/UtbPre4=;
        b=ZhFlKCo6LoIXZF2j8qBIDPR4wQ/ran8OnUXXdWpBJs+29GYtgviszTXEeObiDIMF/v
         A6oDsTToS8u1XX4+bSA9ujhXCdiciN7f3u9JtCyvXCHEY2FGb9rqEgqAmdkrl4RJAQ3B
         9xAFOpBKHk4LeCd/X0IhnBLPLkJx9Qkf2yBMk+HRghrweTjHeWczpuN9CwunwV8ssIu9
         +8Yo5/WDCQZlJOyem9dKA3CrR6MvGMQjwrO3rzRPl2L0U2eZUa9EkBd37DFXO+nKs2Wm
         CHQCln5kE0dyilHlVOS6FcH7GC8MLVxhQAn3mZZ/r65s+9hLDkuzoy0YYdMu+5UkU66t
         tuIQ==
X-Forwarded-Encrypted: i=1; AFNElJ8x2lmZKVnaWBcxwUT5TM+2ouTIKRWw4NMToNfl79PiAjjchRHNCLB6QrbmyzkjoR7tNZ39YgHDpfBRV+gNoPFK@vger.kernel.org
X-Gm-Message-State: AOJu0Yziiu48KwO2ENdlVYpLjFxXdbo5u6Qi4vqa2mZFKP7NusZ/cqbT
	UHBIQEtDPZWUqUzs8kOTmN55ATwQsvPoagQbk50QjXYykXt/zQjNGhI75EfIXZnNOk4e8gMqP82
	FZpL2QtSJPw==
X-Received: from dyco28.prod.google.com ([2002:a05:7300:51dc:b0:303:2247:37b])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:a903:b0:2d1:d434:cfe3
 with SMTP id 5a478bee46e88-30397b7de6dmr9020627eec.0.1779204450792; Tue, 19
 May 2026 08:27:30 -0700 (PDT)
Date: Tue, 19 May 2026 08:27:16 -0700
In-Reply-To: <20260519152716.3464144-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260519050150.3144907-1-irogers@google.com> <20260519152716.3464144-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.631.ge1b05301d1-goog
Message-ID: <20260519152716.3464144-3-irogers@google.com>
Subject: [PATCH v4 2/2] perf test: Add stat metrics --for-each-cgroup test
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
  metric is reported for each cgroup.
- Dynamically pairs and verifies instructions and cycles counts to
  avoid false failures on idle cgroups.
- Tests both standard mode and BPF counters mode (if supported).

Assisted-by: Antigravity:gemini-3-flash
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/shell/stat_metrics_cgrp.sh | 200 ++++++++++++++++++++
 1 file changed, 200 insertions(+)
 create mode 100755 tools/perf/tests/shell/stat_metrics_cgrp.sh

diff --git a/tools/perf/tests/shell/stat_metrics_cgrp.sh b/tools/perf/tests/shell/stat_metrics_cgrp.sh
new file mode 100755
index 000000000000..d4226ee0ae98
--- /dev/null
+++ b/tools/perf/tests/shell/stat_metrics_cgrp.sh
@@ -0,0 +1,200 @@
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
+			local val1
+			val1=$(echo "${line}" | cut -d, -f1)
+
+			local event_name
+			event_name=$(echo "${line}" | cut -d, -f3)
+
+			local cycles_val=""
+			local inst_val=""
+
+			if echo "${event_name}" | grep -q -i "cycles"
+			then
+				cycles_val="${val1}"
+				# Find corresponding instructions event
+				local inst_event_name
+				inst_event_name="${event_name/cpu-cycles/instructions}"
+				inst_event_name="${inst_event_name/cycles/instructions}"
+
+				local inst_line
+				inst_line=$(echo "${output}" | \
+					grep -F ",${cgrp}," | \
+					grep -F "${inst_event_name}" || true)
+				inst_val=$(echo "${inst_line}" | cut -d, -f1)
+			elif echo "${event_name}" | grep -q -i "instructions"
+			then
+				inst_val="${val1}"
+				# Find corresponding cycles event (try cpu-cycles
+				# first, then cycles)
+				local cycles_event_name
+				cycles_event_name="${event_name/instructions/cpu-cycles}"
+				local cycles_line
+				cycles_line=$(echo "${output}" | \
+					grep -F ",${cgrp}," | \
+					grep -F "${cycles_event_name}" || true)
+
+				if [ -z "${cycles_line}" ]
+				then
+					# Try "cycles" instead of "cpu-cycles"
+					cycles_event_name="${event_name/instructions/cycles}"
+					cycles_line=$(echo "${output}" | \
+						grep -F ",${cgrp}," | \
+						grep -F "${cycles_event_name}" || true)
+				fi
+				cycles_val=$(echo "${cycles_line}" | cut -d, -f1)
+			fi
+
+			log_verbose "Cgroup '${cgrp}': event '${event_name}' \
+val '${cycles_val}', inst val '${inst_val}'"
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

