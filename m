Received: from mail-dy1-f201.google.com (mail-dy1-f201.google.com [74.125.82.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C044361DC8
	for <linux-perf-users@vger.kernel.org>; Mon,  9 Feb 2026 20:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770668539; cv=none; b=EzDtobBaXI7ndLXKi2SImwymfnfjUeW3M6f5AgseKJBtz5pjwBrp+XK+G1pMwUzj1G3wWOhNetaFkB/nuJ15KPU0JlXqW8PGU6VaZSrn4Ez2jDtHm1LkxJxO348uwngf1E7wVcPxOog/yTGKMfpDuSSfxuJSZucMORt9XZxv1FA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770668539; c=relaxed/simple;
	bh=WD07r+zXb1oQG7d6AS1Ukm/XofMWenplrDPBHy3EgUc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=eES/VWfehvzBz973FVXsl27owt5TGzQ2h2GFVrbdTDZc4qXX2t6fW+a2YowQ75VS1g4Ao0r/QSEwXZVyVwcLfBm8FGrddKzICNUnkE4CXPBJ1bGEvO14WFtwtFCGA9ax5BC5lsjXRzTnB81SM+RN+q9mK6T0KCguQiOUkYySwZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WB3GV2UY; arc=none smtp.client-ip=74.125.82.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WB3GV2UY"
Received: by mail-dy1-f201.google.com with SMTP id 5a478bee46e88-2b866e72c00so62162eec.1
        for <linux-perf-users@vger.kernel.org>; Mon, 09 Feb 2026 12:22:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1770668537; x=1771273337; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eg434dzqJzkiMn4Wl04ZGI19f2RXB1FpMi/xYmoSVd0=;
        b=WB3GV2UYeZDYjp4QJ5Gm1EYZz8rI0X9dLNiDJwyi7+sVvTn6TNfGkwHLuloL6t1dPS
         sk0ysBMnx/wFaYiPYsTMnBTE+28fiQxomr8lbuIOMAx4UtPY3bbLtdEzfeHo2FEwOL93
         05NEWb59nDyKvEjNzhFVl5tZ7Ey+Q11jehr7WvCG8yotLuxalwF+VETiJFTz7b8IxJVI
         YyYECkBqxCpM6X5ip7haMbEv6Xmk8Y9ntmHN9M0clye48erdLDI+Kdt3D98YkZxoKkHa
         2PlBOdKVrbNCQvwwoxAmHsQaZW2UQFzK84F6xAT3LZvNP8eK1hnqFfCyeqMPQ6HQBGPb
         vsCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770668537; x=1771273337;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eg434dzqJzkiMn4Wl04ZGI19f2RXB1FpMi/xYmoSVd0=;
        b=Jqy97YpvsutZXdnb25hXSZqllqSwbErm6ZMDzTiCoEopf97ktXDRDOYlbnWueKeYtD
         hKyrZY/osjSVO1BGHPSW2uCuziuCKHeNjZCcD3TbsZu6B22IF56oqCGQdMu/2WWg0m5J
         289KLHRQb5skVoam6DbbQgoiIeCDqX9iqkfom0BbfODIESz3S3y0x8qtplLkYWkAWEcu
         DGqTfT7Iufd0T5teV1OhW3+FhOpxQz0MYJTLuWFqKwr/l7JFUD6sNbIixK8ZHnNdMS47
         Df5/kTJf4g0sDUNVckcDy6hHYajVxMBZ/8bLUmkIFcxEdTnjWUwW2hEIvCOIPffSyITq
         tuoQ==
X-Forwarded-Encrypted: i=1; AJvYcCUaFl/oDWf1Rr1i5SeVVuH5DJZX9/ZFZEsmMZKq2FTWRkSmR8B1Rqn4U/oD5+arq3wtEIaMT+L7R7P6TUz1KFtT@vger.kernel.org
X-Gm-Message-State: AOJu0Yyb1X1Qv77DVcj3tKe/sRECDSn1EIu7ifhokno18mtEJ4Vt8MCb
	iD3ufeySruL6Cu2q/6t2ETCelP3Z5eYNoRSMf3KttSkm6sCYrTVzLGosHykxOtsV+BKiMVDPUEY
	1SJTDi1QJyQ==
X-Received: from dyz14.prod.google.com ([2002:a05:693c:408e:b0:2ba:6448:ee87])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:6d07:b0:2ba:7b63:3f6e
 with SMTP id 5a478bee46e88-2ba7b635108mr972397eec.11.1770668537368; Mon, 09
 Feb 2026 12:22:17 -0800 (PST)
Date: Mon,  9 Feb 2026 12:22:08 -0800
In-Reply-To: <20260209202208.2027001-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260209202208.2027001-1-irogers@google.com>
X-Mailer: git-send-email 2.53.0.rc2.204.g2597b5adb4-goog
Message-ID: <20260209202208.2027001-4-irogers@google.com>
Subject: [PATCH v1 3/3] perf test script: Add python script testing support
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, Sandipan Das <sandipan.das@amd.com>, Leo Yan <leo.yan@arm.com>, 
	Yujie Liu <yujie.liu@intel.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Basic coverage of python script support from `perf script`.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/shell/script_python.sh | 113 ++++++++++++++++++++++++
 1 file changed, 113 insertions(+)
 create mode 100755 tools/perf/tests/shell/script_python.sh

diff --git a/tools/perf/tests/shell/script_python.sh b/tools/perf/tests/shell/script_python.sh
new file mode 100755
index 000000000000..6bc66074a31f
--- /dev/null
+++ b/tools/perf/tests/shell/script_python.sh
@@ -0,0 +1,113 @@
+#!/bin/bash
+# perf script python tests
+# SPDX-License-Identifier: GPL-2.0
+
+set -e
+
+# set PERF_EXEC_PATH to find scripts in the source directory
+perfdir=$(dirname "$0")/../..
+if [ -e "$perfdir/scripts/python/Perf-Trace-Util" ]; then
+  export PERF_EXEC_PATH=$perfdir
+fi
+
+
+perfdata=$(mktemp /tmp/__perf_test_script_python.perf.data.XXXXX)
+generated_script=$(mktemp /tmp/__perf_test_script.XXXXX.py)
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
+check_python_support() {
+	if perf check feature -q libpython; then
+		return 0
+	fi
+	echo "perf script python test [Skipped: no libpython support]"
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
+	# Try to record. If this fails, it might be permissions or lack of
+	# support. Return 2 to indicate "skip this event" rather than "fail
+	# test".
+	if ! perf record -o "${perfdata}" -e "$event_name" $record_opts -- perf test -w thloop > /dev/null 2>&1; then
+		echo "perf script python test [Skipped: failed to record $event_name]"
+		return 2
+	fi
+
+	echo "Generating python script..."
+	if ! perf script -i "${perfdata}" -g "${generated_script}"; then
+		echo "perf script python test [Failed: script generation for $event_name]"
+		return 1
+	fi
+
+	if [ ! -f "${generated_script}" ]; then
+		echo "perf script python test [Failed: script not generated for $event_name]"
+		return 1
+	fi
+
+	# Perf script -g python doesn't generate process_event for generic
+	# events so append it manually to test that the callback works.
+	if ! grep -q "def process_event" "${generated_script}"; then
+		cat <<EOF >> "${generated_script}"
+
+def process_event(param_dict):
+	print("param_dict: %s" % param_dict)
+EOF
+	fi
+
+	echo "Executing python script..."
+	output=$(perf script -i "${perfdata}" -s "${generated_script}" 2>&1)
+
+	if echo "$output" | grep -q "$expected_output"; then
+		echo "perf script python test [Success: $event_name triggered $expected_output]"
+		return 0
+	else
+		echo "perf script python test [Failed: $event_name did not trigger $expected_output]"
+		echo "Output was:"
+		echo "$output" | head -n 20
+		return 1
+	fi
+}
+
+check_python_support || exit 2
+
+# Try tracepoint first
+test_script "sched:sched_switch" "sched__sched_switch" "-c 1" && res=0 || res=$?
+
+if [ $res -eq 0 ]; then
+	exit 0
+elif [ $res -eq 1 ]; then
+	exit 1
+fi
+
+# If tracepoint skipped (res=2), try task-clock
+# For generic events like task-clock, the generated script uses process_event()
+# which prints the param_dict.
+test_script "task-clock" "param_dict" "-c 100" && res=0 || res=$?
+
+if [ $res -eq 0 ]; then
+	exit 0
+elif [ $res -eq 1 ]; then
+	exit 1
+fi
+
+# If both skipped
+echo "perf script python test [Skipped: Could not record tracepoint or task-clock]"
+exit 2
-- 
2.53.0.rc2.204.g2597b5adb4-goog

