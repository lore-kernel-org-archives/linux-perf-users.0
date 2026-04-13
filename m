Received: from mail-dy1-f201.google.com (mail-dy1-f201.google.com [74.125.82.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46BC3344D9A
	for <linux-perf-users@vger.kernel.org>; Mon, 13 Apr 2026 21:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776115989; cv=none; b=buHJHVshZy6klsfBj9JxBfKkMTnTvhvhJb7N71NgS1Iuqg4jIFKwRX+mM/M0DnandV+jVZAibm6UJZXJsTFOVBjALgJ+YXbsSHCbZ7suBKGSgT19sIo4cPUlXCA5gIfOIULcAgLjvdWS/L6cDkcT1RVkf0IEKSgRkFKXKGwYDXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776115989; c=relaxed/simple;
	bh=L5wdLLtC71o5HYo2FNT85NlRh0oOlEp8deQSNIgpReI=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Content-Type; b=L/onH6nsg55qxv5aqn6WW6CfJzkCc5jqWT/2zLVvkok5tuoYpPFdMU8pPR/hjxPM20hqwZrxs4a6FllF2BwBSrwz/2ZRn6mRB0Nsltf7Ep+UCKWrMF/gFnJY12dIBuG6PQAbU/2yBIiW1GRjhCr6KITAZmnr40db1+rCLW412tw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=INdx97PQ; arc=none smtp.client-ip=74.125.82.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="INdx97PQ"
Received: by mail-dy1-f201.google.com with SMTP id 5a478bee46e88-2d889997495so6348014eec.0
        for <linux-perf-users@vger.kernel.org>; Mon, 13 Apr 2026 14:33:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776115986; x=1776720786; darn=vger.kernel.org;
        h=to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=7vpQpsTn1PHgAG0dzZ7KPSfhIvgYpqRFoLMKJDWZlRY=;
        b=INdx97PQMMWQKufcYvMw/qWn5pJx1OZyspFyvIy8jS8nDaw2mNY6ZoM8H53oebUTqd
         4qksrfSLDH7qMAtCT4czgQhBRd+xfPhDyOmGjtgYpSphbiEX4Uz7ff81NVF6THuRzgb8
         VJldCZzai/u5+iOea48S4zNVo9V43p690rVA8MQXJDlr6SgZGZkZ6gDu5P4tMjXlhpHZ
         2m9rXrX6rcFO86Glu00bOB4F08gZzgiA2whjV+/U6uAhMXumfnAcegBP+YgKYONQaCY1
         ZsD3te9YPA8RWMrAjpMHUeaZYNXckff1xk+TpZh3et0S+Uxb447106aqd36/5JmWe9ER
         N/aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776115986; x=1776720786;
        h=to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7vpQpsTn1PHgAG0dzZ7KPSfhIvgYpqRFoLMKJDWZlRY=;
        b=e8WEP1c+iEvVDoziVfa0oBkNQceqT+51LxpMXewQFaOFnL93BxrBfJBCiHDlq+HND4
         +Jtf+yaxs/B+qgAAEEpzOUHHShq5wDmWtM45VSXiBv8bN/zTqF2zh2i944zuTsF63YIQ
         eleMYb8IjD5RbkC/aaaLfROmIRUzq5ZbNfWt+LGt6M+Wv9zLpjMes2aMk7CGDFdxJ9+X
         JhhPmit3RRd5BzyJQ3zxowWZyzhSZV8AxrZYhzpfTW8IbHobmnpFwfBy5mHZsP6TIsSD
         NTUmsu5DvrmeRCIYLsHsi5Bqjwh+yLIqTZbqvbgfhAc7vAoRAp8RrffE5pIf4X4TVv01
         CATA==
X-Forwarded-Encrypted: i=1; AFNElJ9OPW1Y9j/+fmfw2yy+OwctAKNzdreu7ONhjjC6R4C0ldrazjxkKwoNyAwmzMMh5u/GQT+2KBSej8o85KBlf0US@vger.kernel.org
X-Gm-Message-State: AOJu0Yzrx1RhAKoYEFyDrqgkbiFiEXRjXLZzjlVO220QjPVcqVOxZbV0
	WX00/OdPQqefgKXXeTZp442MlBwI1D/Ptoun4cmRJXhJavofERL7RPwaxIvhcg7zMTqj1CQ4NUt
	C5gEi/Z89iA==
X-Received: from dybeb10.prod.google.com ([2002:a05:7300:a2ca:b0:2d5:d26c:d4bc])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7301:2b89:b0:2d3:f43c:d684
 with SMTP id 5a478bee46e88-2d586384048mr8461679eec.2.1776115986136; Mon, 13
 Apr 2026 14:33:06 -0700 (PDT)
Date: Mon, 13 Apr 2026 14:33:00 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.rc0.605.g598a273b03-goog
Message-ID: <20260413213300.1700116-1-irogers@google.com>
Subject: [PATCH v1] perf tests: top/kvm don't depend on coreutils timeout
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

If the coreutils timeout command is missing on a minimal test system
then the kvm and top tests can fail. Provide a fallback bash
implementation for these systems.

Assisted-by: Gemini:gemini-3.1-pro-preview
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/shell/kvm.sh         |  6 ++++-
 tools/perf/tests/shell/lib/timeout.sh | 36 +++++++++++++++++++++++++++
 tools/perf/tests/shell/top.sh         |  7 +++++-
 3 files changed, 47 insertions(+), 2 deletions(-)
 create mode 100644 tools/perf/tests/shell/lib/timeout.sh

diff --git a/tools/perf/tests/shell/kvm.sh b/tools/perf/tests/shell/kvm.sh
index f88e859025c4..a27b3d6414e9 100755
--- a/tools/perf/tests/shell/kvm.sh
+++ b/tools/perf/tests/shell/kvm.sh
@@ -4,6 +4,9 @@
 
 set -e
 
+# shellcheck source=lib/timeout.sh
+. "$(dirname $0)"/lib/timeout.sh
+
 err=0
 perfdata=$(mktemp /tmp/__perf_kvm_test.perf.data.XXXXX)
 qemu_pid_file=$(mktemp /tmp/__perf_kvm_test.qemu.pid.XXXXX)
@@ -102,7 +105,8 @@ test_kvm_stat_live() {
 
         # Run perf kvm live for 5 seconds, monitoring that PID
 	# Use sleep to keep stdin open but silent, preventing EOF loop or interactive spam
-	if ! sleep 10 | timeout 5s perf kvm stat live -p "${qemu_pid}" > "${log_file}" 2>&1; then
+	if ! sleep 10 | bash_timeout 5s perf kvm stat live -p "${qemu_pid}" > "${log_file}" 2>&1
+	then
 		retval=$?
 		if [ $retval -ne 124 ] && [ $retval -ne 0 ]; then
 			echo "perf kvm stat live [Failed: perf kvm stat live failed to start or run (ret=$retval)]"
diff --git a/tools/perf/tests/shell/lib/timeout.sh b/tools/perf/tests/shell/lib/timeout.sh
new file mode 100644
index 000000000000..b4d2c0acf0e2
--- /dev/null
+++ b/tools/perf/tests/shell/lib/timeout.sh
@@ -0,0 +1,36 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+
+# A version of timeout in pure bash that doesn't require the timeout command.
+bash_timeout() {
+    # Check if the native 'timeout' command is available
+    if command -v timeout >/dev/null 2>&1; then
+        timeout "$@"
+        return $?
+    fi
+
+    local timeout_secs="$1"
+    shift
+    local command=("$@")
+
+    # Execute the target command in the background
+    "${command[@]}" &
+    local cmd_pid=$!
+
+    # Start a watcher process in the background
+    (
+        sleep "$timeout_secs"
+        kill -TERM "$cmd_pid" 2>/dev/null || true
+    ) &
+    local watcher_pid=$!
+
+    # Wait for the main command to complete (or be killed)
+    wait "$cmd_pid" 2>/dev/null
+    local exit_code=$?
+
+    # Clean up: Kill the watcher process if the main command finished early
+    kill "$watcher_pid" 2>/dev/null || true
+
+    # Return the exit status of the target command
+    return $exit_code
+}
diff --git a/tools/perf/tests/shell/top.sh b/tools/perf/tests/shell/top.sh
index ad7fccd09025..7741bca6b41f 100755
--- a/tools/perf/tests/shell/top.sh
+++ b/tools/perf/tests/shell/top.sh
@@ -4,6 +4,9 @@
 
 set -e
 
+# shellcheck source=lib/timeout.sh
+. "$(dirname $0)"/lib/timeout.sh
+
 err=0
 log_file=$(mktemp /tmp/perf.top.log.XXXXX)
 
@@ -35,7 +38,9 @@ test_basic_perf_top() {
 	# Use -d 1 to avoid flooding output
 	# Use -e cpu-clock to ensure we get samples
 	# Use sleep to keep stdin open but silent, preventing EOF loop or interactive spam
-	if ! sleep 10 | timeout 5s perf top --stdio -d 1 -e cpu-clock -p $PID > "${log_file}" 2>&1; then
+	if ! sleep 10 | \
+	     bash_timeout 5s perf top --stdio -d 1 -e cpu-clock -p $PID > "${log_file}" 2>&1
+	then
 		retval=$?
 		if [ $retval -ne 124 ] && [ $retval -ne 0 ]; then
 			echo "Basic perf top test [Failed: perf top failed to start or run (ret=$retval)]"
-- 
2.54.0.rc0.605.g598a273b03-goog

