Received: from mail-dy1-f201.google.com (mail-dy1-f201.google.com [74.125.82.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3297C337B9D
	for <linux-perf-users@vger.kernel.org>; Mon,  9 Feb 2026 20:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770668538; cv=none; b=kNmOiZ1U0BIBJzR7dHaBpGn4Vr8e+s4GSGHWanEtBr2dbCFTZ3bQQL3RTMqrJdHWMLID0++mo+er57bBrOoOQ4+v3g//KlRkityLeWcrmGQrYuyBSqdCw8dNPd8X7Rv96Xp9uzXR5WRK+xzruNd3kS+r3fO7hRjhkzBnLvQGcnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770668538; c=relaxed/simple;
	bh=99vpJ8GhF7eNAqDOXeu+Fr9toiJJdQEGZfjkLvia1ng=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=oICfYkqEHyxJyzRnGKiMxSezb5h+xFOm6yNPQur5fnNYA9hcjvAU7TFDx+72UmfiqfK0ryGSjxFea1aWZc482UsTlm6lYIDpHtlEvLVBhIDP9pxPhIculC2RvAZxf8TbRiBx9XEz+UEL3NmjzU/8zMI+qqlG7NtoyuhixADg0BY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kDDua+kR; arc=none smtp.client-ip=74.125.82.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kDDua+kR"
Received: by mail-dy1-f201.google.com with SMTP id 5a478bee46e88-2ba6e8ac125so442687eec.0
        for <linux-perf-users@vger.kernel.org>; Mon, 09 Feb 2026 12:22:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1770668535; x=1771273335; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7betNIsJE10/NnsmMe+hD7nf/zhUEKUN9SyRdUo6KrU=;
        b=kDDua+kRerBxBeAb7/yZP6iAcjtRzVVuEbD3DqYYHwu7SJLLbDxryvaySnLxXNM14D
         ed2bXiPexGD198UGOm7UgEMaJOrPVosC1eQwS7i1Pz6pW6+znnzsD5luvLbUXr81fp1g
         e4pybYwMhAEjvLnJ3+nZDrKrPZ4pHH9EzhfhRGGmrF7UarBidBoSodsPcYewo03MFdUi
         +VdrFi5pInyIuFXncANWFGW+ehS/QmPsJbolFGKKfzdoguTuHWG5tGxRwXDYjHQveovt
         RIg/XoDyaY6+J6+i/uT2jffz5xzu2l4AYmhFycaxcN3OCaXsSK27pjyjppVh31odRG/l
         nBSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770668535; x=1771273335;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7betNIsJE10/NnsmMe+hD7nf/zhUEKUN9SyRdUo6KrU=;
        b=RA2Qr7O8n+0P9yr6Jjc+/iYPJGL4J7N521MOSYtPyeWtoJq7UuBs0AzdMGGsBL7HPU
         Ubhw4UVHZy0R1bRqk333a0WNvpdKv1sIjuiW+z/bVqLSUJ+lwF8sJlJ98fwVBolvm4xg
         2phDpl8rswCqiXshPt1+CncISuUH1Yh4178/df5miJNVSD1UEYDxWADhIvKYNRD/sUw7
         kOLy9RPR9zrgv99rUpFv49S7bcupauE2JzvZHULMqcxnxUivTVXOvmbxfQxk8nbmzuTY
         0tNwb7N/O6Sxei/qHGCamJKNtkye34nPEu4R6l10ZHkqVytuFLWmJm+GvnIDW+gfnFzN
         3VHA==
X-Forwarded-Encrypted: i=1; AJvYcCWzIB2GSim/6eUIVG4WDApuYI1XrsrPa1X55yXlGs/aPXV+Z6S+61eWhKTyFIky4XPSYBwIS6J3zBd7ijeLi+3r@vger.kernel.org
X-Gm-Message-State: AOJu0Yxkb+aqyOw9oKEkgGaP1g4uKh+Qgjnc75re5FDILIXaCQQuDK4P
	yWdstRGguppZ9FrGggFZ67JDq7kKC7KkYpGszf/nK/5FdgxGYxZ6IEWB1jnOU9pnXAN2PhWYnrB
	RA2RnKUN9GQ==
X-Received: from dybhk9.prod.google.com ([2002:a05:7301:2889:b0:2b6:bc40:5234])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:693c:2288:b0:2a4:3594:72ed
 with SMTP id 5a478bee46e88-2b8564ecb2cmr4777348eec.28.1770668535306; Mon, 09
 Feb 2026 12:22:15 -0800 (PST)
Date: Mon,  9 Feb 2026 12:22:07 -0800
In-Reply-To: <20260209202208.2027001-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260209202208.2027001-1-irogers@google.com>
X-Mailer: git-send-email 2.53.0.rc2.204.g2597b5adb4-goog
Message-ID: <20260209202208.2027001-3-irogers@google.com>
Subject: [PATCH v1 2/3] perf test script: Add perl script testing support
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, Sandipan Das <sandipan.das@amd.com>, Leo Yan <leo.yan@arm.com>, 
	Yujie Liu <yujie.liu@intel.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Basic coverage of perl script support from `perf script`. This is
disabled by default and so the test will most normally skip.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/shell/script_perl.sh | 102 ++++++++++++++++++++++++++
 1 file changed, 102 insertions(+)
 create mode 100755 tools/perf/tests/shell/script_perl.sh

diff --git a/tools/perf/tests/shell/script_perl.sh b/tools/perf/tests/shell/script_perl.sh
new file mode 100755
index 000000000000..b6d65b6fbda1
--- /dev/null
+++ b/tools/perf/tests/shell/script_perl.sh
@@ -0,0 +1,102 @@
+#!/bin/bash
+# perf script perl tests
+# SPDX-License-Identifier: GPL-2.0
+
+set -e
+
+# set PERF_EXEC_PATH to find scripts in the source directory
+perfdir=$(dirname "$0")/../..
+if [ -e "$perfdir/scripts/perl/Perf-Trace-Util" ]; then
+  export PERF_EXEC_PATH=$perfdir
+fi
+
+
+perfdata=$(mktemp /tmp/__perf_test_script_perl.perf.data.XXXXX)
+generated_script=$(mktemp /tmp/__perf_test_script.XXXXX.pl)
+
+cleanup() {
+  rm -f "${perfdata}"
+  rm -f "${generated_script}"
+  trap - EXIT TERM INT
+}
+
+trap_cleanup() {
+  echo "Unexpected signal in ${FUNCNAME[1]}"
+  cleanup
+  exit 1
+}
+trap trap_cleanup TERM INT
+trap cleanup EXIT
+
+check_perl_support() {
+	if perf check feature -q libperl; then
+		return 0
+	fi
+	echo "perf script perl test [Skipped: no libperl support]"
+	return 2
+}
+
+test_script() {
+	local event_name=$1
+	local expected_output=$2
+	local record_opts=$3
+
+	echo "Testing event: $event_name"
+
+	# Try to record. If this fails, it might be permissions or lack of support.
+	# We return 2 to indicate "skip this event" rather than "fail test".
+	if ! perf record -o "${perfdata}" -e "$event_name" $record_opts -- perf test -w thloop > /dev/null 2>&1; then
+		echo "perf script perl test [Skipped: failed to record $event_name]"
+		return 2
+	fi
+
+	echo "Generating perl script..."
+	if ! perf script -i "${perfdata}" -g "${generated_script}"; then
+		echo "perf script perl test [Failed: script generation for $event_name]"
+		return 1
+	fi
+
+	if [ ! -f "${generated_script}" ]; then
+		echo "perf script perl test [Failed: script not generated for $event_name]"
+		return 1
+	fi
+
+	echo "Executing perl script..."
+	output=$(perf script -i "${perfdata}" -s "${generated_script}" 2>&1)
+
+	if echo "$output" | grep -q "$expected_output"; then
+		echo "perf script perl test [Success: $event_name triggered $expected_output]"
+		return 0
+	else
+		echo "perf script perl test [Failed: $event_name did not trigger $expected_output]"
+		echo "Output was:"
+		echo "$output" | head -n 20
+		return 1
+	fi
+}
+
+check_perl_support || exit 2
+
+# Try tracepoint first
+test_script "sched:sched_switch" "sched::sched_switch" "-c 1" && res=0 || res=$?
+
+if [ $res -eq 0 ]; then
+	exit 0
+elif [ $res -eq 1 ]; then
+	exit 1
+fi
+
+# If tracepoint skipped (res=2), try task-clock
+# For generic events like task-clock, the generated script uses process_event()
+# which dumps data using Data::Dumper. We check for "$VAR1" which is standard Dumper output.
+test_script "task-clock" "\$VAR1" "-c 100" && res=0 || res=$?
+
+if [ $res -eq 0 ]; then
+	exit 0
+elif [ $res -eq 1 ]; then
+	exit 1
+fi
+
+# If both skipped
+echo "perf script perl test [Skipped: Could not record tracepoint or task-clock]"
+exit 2
-- 
2.53.0.rc2.204.g2597b5adb4-goog

