Received: from mail-dy1-f202.google.com (mail-dy1-f202.google.com [74.125.82.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F6D0307AF4
	for <linux-perf-users@vger.kernel.org>; Tue, 19 May 2026 01:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779155478; cv=none; b=dNqP0MkHvmcF5qJHRYEBNxhNut2b8gtzSg/8PAOWDYKv6bUALyI4fy//5feyecRCjeSu9el7NEiFXtvzr+hZpQWtse8yAYmtG7ts4u1eEs5MCoWJD/JQ2gVgXhmqn0P8ccnfuOJwx8EgK9YKcBqrGkOgUu8gdUvqImUcUDu1kSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779155478; c=relaxed/simple;
	bh=frpKGqBbCZCqt0hWhzPxF2kYt7qbNOhThme+iYf42KY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=DcaB8J9Lu8NCJe95TkLVnuNkCcIqDVfJps2rIVwier4bqYpMuHpjLIIYKULNhpckt82XUaEuld+Kv1t8lrqpQ8Pr4Jbl1P5D0iANL4v8o2WInA96mVW8XL5zKhml9ILnJpTAX7hiB0tTnkBqXFvJIjao1Et8j/lWyV1u6jruESM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TKDppBEo; arc=none smtp.client-ip=74.125.82.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TKDppBEo"
Received: by mail-dy1-f202.google.com with SMTP id 5a478bee46e88-2ee5b73c5f2so1656231eec.0
        for <linux-perf-users@vger.kernel.org>; Mon, 18 May 2026 18:51:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779155476; x=1779760276; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=zVGDXUHhQDO1HqSBMoZiDiTOql87LxWaPwxH6I36Yng=;
        b=TKDppBEoU/Er++WEu1J+dOW1+coXr6Uf3nJ3j21ZUvAfc9K1JIXO7GmfA8DPFX9QFs
         Vs1nao5oUwpF2ehcfgyCBsuZqeDHu1L5IUIB0Px4O+/fV3P2yXL+huQCpW6tivzzeIpC
         1d2v2+hJzbBA7jw4wqVfEWKZ8MVQk6ITnrqpmll3xUPcHyprtsK3ECxDRlGqBlzwF8tN
         piYR84gRJ3+kxHOegK1do5k4m5KJOMTqeTblij8WIYeaJvRD96k/tjZnVFinEqcOMzfY
         N02eR4+hQNIZvl+jXQK2tXPILjiPoLKcfELzJyRBeCH+01tv5AJQBsSF/e/yLopSCh9M
         8OSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779155476; x=1779760276;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zVGDXUHhQDO1HqSBMoZiDiTOql87LxWaPwxH6I36Yng=;
        b=ArXGnwct1YfKPvIsIObsObkWC88wFLpd3Bvm0CQJHgG9Yk6C+1+FH5bblEf+A4SyWM
         WKbPmeSWRuo/m1w91vtRmuekOG1Xql0QiC9QL5wTYm/t+GmTUTKc0ofDqPBooSJIfwXU
         emu2xmLc/YtEFF+MBQ+N0IcmQl7cVzsLDDoCaX0xvyjBsQLnL8C3JbKWW2EecaSl1msE
         5c+0mBIfLVURftDq03XDAonexpWtqiV/GQW7xNacfnfyv3duTjgV4qFlhfKdzWon3c3W
         aZ6f846Uptkw01tfuvZKRR/v+c9ezK70FZWT9eSIbGZ9FzoehRoqUEdNnh8JoS5Lpmi1
         K2vw==
X-Forwarded-Encrypted: i=1; AFNElJ8FKYZjYxdpG1EQxryVxfbg0pyysNXADoXIhMKcsaUqBjPuc2I7qKuMlAFQRvtjxBpPQ//Opck/Z1DAVjmSvdbZ@vger.kernel.org
X-Gm-Message-State: AOJu0YwdttOS+Q+/m3vPIhlZ6hPBPadJfcFmEBtx9XLbKWYIjC8nStki
	PJLwEC8mFCAju+TzIGZDYctBiBrkl425z7qXyShdprmw7M7stFqIFSGBaxUqqo7QcFD78oSfY0w
	9+GycZaaEUQ==
X-Received: from dybrp22.prod.google.com ([2002:a05:7301:4616:b0:2e2:488c:4eba])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:ec11:b0:2c5:b23e:48a6
 with SMTP id 5a478bee46e88-303986a0862mr7736899eec.23.1779155476160; Mon, 18
 May 2026 18:51:16 -0700 (PDT)
Date: Mon, 18 May 2026 18:51:08 -0700
In-Reply-To: <20260519015108.3094513-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260518222228.3027004-1-irogers@google.com> <20260519015108.3094513-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.631.ge1b05301d1-goog
Message-ID: <20260519015108.3094513-3-irogers@google.com>
Subject: [PATCH v2 2/2] perf test: Add stat metrics --for-each-cgroup test
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
 tools/perf/tests/shell/stat_metrics_cgrp.sh | 123 ++++++++++++++++++++
 1 file changed, 123 insertions(+)
 create mode 100755 tools/perf/tests/shell/stat_metrics_cgrp.sh

diff --git a/tools/perf/tests/shell/stat_metrics_cgrp.sh b/tools/perf/tests/shell/stat_metrics_cgrp.sh
new file mode 100755
index 000000000000..2f74bd9e3f2e
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
+		# Find lines for this cgroup and metric
+		local cgrp_lines
+		cgrp_lines=$(echo "${output}" | grep -F "${cgrp}" | grep "insn_per_cycle" || true)
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

