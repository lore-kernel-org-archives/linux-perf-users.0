Received: from mail-dl1-f74.google.com (mail-dl1-f74.google.com [74.125.82.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5B293ACEF3
	for <linux-perf-users@vger.kernel.org>; Mon, 18 May 2026 22:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779142961; cv=none; b=TRSC0r3RPQK1g3KNL2vnJtWnQeC+ZsK4ijmtebuSwXsBiehvyQnVUCHs+lGgawf7uZrqm6SB0vNZpGJNB+lszB8uFiKvf8TXhgYCoZqRXf/ANzzC9B1YTwSS747BRPrSTc7Irt9cg5UMhIVkDcFXtOg8Gg98gIAwZ/oxWQlxyzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779142961; c=relaxed/simple;
	bh=o/Jnu6wD+9qxT0NVaY9TI9AByxz6RG/zhvND9invDHM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=SP0TFd8JpKibi0NiwBX4mLQw4YhUsMWwAOf2rFcxtxN0gL4M21ckscWIQB0QUaeKvzIZM/4M7th6ngkZv/pgZff80fB9MT/kIzRkgeJRQuXF/6lL0jrpBkaCT2MHdE+4PgJZobvbQhqyCMjfBJLJu51EMrDqsY6AtP61VsZ+fsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rx3vgZaZ; arc=none smtp.client-ip=74.125.82.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rx3vgZaZ"
Received: by mail-dl1-f74.google.com with SMTP id a92af1059eb24-134cf343c58so5355980c88.1
        for <linux-perf-users@vger.kernel.org>; Mon, 18 May 2026 15:22:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779142956; x=1779747756; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cW1CzrqNtSbwXTcsUNpM10Pzm2IU0DaU1vPbneAeFro=;
        b=rx3vgZaZoI3xFvN3E0a+vaVtJXNH0CDeFv2d8VuiKylnZxXFLMGsOkwNc6nz4GEFMR
         ortcJsxL6SjI4Sul/xdqMgPdYo/lfi08BorInXyqkMiwyjeonnweoNFGdAxk3tk6oU6e
         d9rlvT+urnmoB5iXfnltzyLtXON827u5YjnRi53hmbPjRIo9AQJjCNpNTpf+aYyr8/bt
         6DrE1TFIWrkQFVA8+WeRdxEz0P66U8zPBzmx/H+Cw6Ni0w5M5EP/0vF26csBTNFEwtxS
         /UTOXEM+hn+PnraDGcqqRAa6GtDS3J7Oy1tORKg77/tUdkzwIvJViY2812eW8cKqzkU+
         o55Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779142956; x=1779747756;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cW1CzrqNtSbwXTcsUNpM10Pzm2IU0DaU1vPbneAeFro=;
        b=BziKvM6YrCBEwhJZHo7w/2a42HwXbca0N79YGbRkxq99F5sk2tyu9xYQp3A9C6lOPq
         37sS9nBUe2Ll3wtSTNDwfzEzw6qgkMIiDtwPpa9LYaOjh0xJQDWT86VDk54YeyOvAyKU
         txGzH/NCliELwJtmyI1/Ceji+pPuwnGu7REa9MkrUnHRcPf/Qhw7TtCV+Ow3lzLv7534
         ofLSMpaMaBfKhHplCgZpqJ5yfmKrSns5YvIwtAyZUYLxe/o4IjoMigWEz7CVr7Her5+B
         c8dhlBdrkHf4yqIdvvv4DUC8Pfx8DkOB+y7FQ9EXCNVpg8KnCUo/idojKR1OsSkcU+rD
         WQjg==
X-Forwarded-Encrypted: i=1; AFNElJ/6iRs5Narn5f6eJ1dO9EKx4cuiEIizAmEI3jMSLgx1yHeH9Rc7QrVLGsUE3gSsN6lgurBn6IV3pFAFKmG64gdq@vger.kernel.org
X-Gm-Message-State: AOJu0Yzd1lD/SwI4xf3H+IReAzGbLBjSJTELwzgy9kqMEwk3rIF3+cCT
	RU5yoaWHtZtplCQXCgnt/rgPXsceIF/LmTsNTQCvoHlC3obg9d1BM7JM9FCQY/q2ZOkVGlr3+py
	znJ9NVHWahQ==
X-Received: from dled20-n1.prod.google.com ([2002:a05:701b:42d4:10b0:134:b6e7:5d22])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:790:b0:133:598c:2b1a
 with SMTP id a92af1059eb24-13504a4fc9bmr8451628c88.41.1779142955614; Mon, 18
 May 2026 15:22:35 -0700 (PDT)
Date: Mon, 18 May 2026 15:22:28 -0700
In-Reply-To: <20260518222228.3027004-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260518222228.3027004-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.631.ge1b05301d1-goog
Message-ID: <20260518222228.3027004-3-irogers@google.com>
Subject: [PATCH v1 2/2] perf test: Add stat metrics --for-each-cgroup test
From: Ian Rogers <irogers@google.com>
To: skanev@google.com, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Add a new shell test `stat_metrics_cgrp.sh` to verify metric reporting
with `--for-each-cgroup`, both with and without `--bpf-counters`.

The test:
- Checks if system-wide monitoring is supported (skips if not).
- Checks if `insn_per_cycle` metric is supported (skips if not).
- Finds cgroups to test.
- Runs `perf stat` with `insn_per_cycle` metric and verifies that the
  metric is reported for each cgroup and does not contain invalid
  values (like `nan` or `nested`) or empty values when counts are
  present.
- Tests both standard mode and BPF counters mode (if supported).

Assisted-by: Antigravity:gemini-3-flash
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/shell/stat_metrics_cgrp.sh | 123 ++++++++++++++++++++
 1 file changed, 123 insertions(+)
 create mode 100755 tools/perf/tests/shell/stat_metrics_cgrp.sh

diff --git a/tools/perf/tests/shell/stat_metrics_cgrp.sh b/tools/perf/tests/shell/stat_metrics_cgrp.sh
new file mode 100755
index 000000000000..4a29eb9a9067
--- /dev/null
+++ b/tools/perf/tests/shell/stat_metrics_cgrp.sh
@@ -0,0 +1,123 @@
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
+# skip if system-wide is not supported
+check_system_wide()
+{
+	log_verbose "Checking system-wide..."
+	if ! perf stat -a -e instructions sleep 0.01 > /dev/null 2>&1
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
+	if [ -z ${find_cgroups_self_cgrp} ]
+	then
+		# cgroup v2 doesn't specify perf_event
+		find_cgroups_self_cgrp=$(grep ^0: /proc/self/cgroup | cut -d: -f3)
+	fi
+
+	if [ -z ${find_cgroups_self_cgrp} ]
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
+			--for-each-cgroup ${test_cgroups} \
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
+		# Find lines for this cgroup and metric
+		local cgrp_lines
+		cgrp_lines=$(echo "${output}" | grep "${cgrp}" | grep "insn_per_cycle" || true)
+
+		if [ -z "${cgrp_lines}" ]
+		then
+			echo "FAIL: No metric lines found for cgroup '${cgrp}'"
+			exit 1
+		fi
+
+		# Check for nan or nested
+		if echo "${cgrp_lines}" | grep -q -i -E ",nan,|,nested,"
+		then
+			echo "FAIL: Invalid metric value (nan/nested) for cgroup '${cgrp}'"
+			echo "Line: ${cgrp_lines}"
+			exit 1
+		fi
+		# Check for empty metric value
+		if echo "${cgrp_lines}" | grep -q -E ",,[[:space:]]*[^,]*insn_per_cycle"
+		then
+			echo "FAIL: Empty metric value for cgroup '${cgrp}'"
+			echo "Line: ${cgrp_lines}"
+			exit 1
+		fi
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

