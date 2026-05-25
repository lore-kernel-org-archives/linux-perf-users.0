Received: from mail-dy1-f202.google.com (mail-dy1-f202.google.com [74.125.82.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D66623644DE
	for <linux-perf-users@vger.kernel.org>; Mon, 25 May 2026 23:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779751176; cv=none; b=SzcuZEWaGwFZ6luMc9QxdUcug1sy5qSvRG6TmV47qgMkzhFPtzOEiZSsuOue/XIhogUsCNGvlJnyi8N/CVV5rpwTeMXXPxm51uPdQG9V8JRxmwcyQEwI4qstbirnZicH0bWiU5mFYuUIUAw0PKz0Ls7bXxTDh49/TPUyoDxiBiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779751176; c=relaxed/simple;
	bh=CBcp3mjRjUXria6L/xOPhOG5ZcnbMunq5pBGmIbwDCQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=aLeKW7QsdnFFyOUBKDrpSb4mNu0omwWKnIG9myev9dQ4abq5Lg1YRFGbCvSEJCziikq7tHa8wpLedu7LrezzJa/wE/ywcWriU45ThrNjbHIn++A9Ko4jg7Qm98uTuN5HJqJEWgTsJF7KaBko1ncPrQozeF+65Q6Jg6nAMQl7XJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FgpKYCw/; arc=none smtp.client-ip=74.125.82.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FgpKYCw/"
Received: by mail-dy1-f202.google.com with SMTP id 5a478bee46e88-2fe1cf409a1so15671081eec.1
        for <linux-perf-users@vger.kernel.org>; Mon, 25 May 2026 16:19:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779751174; x=1780355974; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=9kqLDSTLjZL1UfE+kREvz0ReHAL/l7gQcB7q3yu1QaY=;
        b=FgpKYCw/b/zxOi6YHi9Vcgx9Ts1x39AGfgbl7TlWyXhNjPoHctD6tLbB4U3JzrppD1
         BxfMzL5zfn5NXNpP9Ml9ohFkYTyFQ7N3S5CKDemX+utFHRkFAuZxLvnQQq6pyJy13guv
         erSmjYiPHjCDaGMMohZEi8pLmNKfa2IqgOYS6mlCYq595EgnpXvlh4eL60S8fwIlRcHF
         g9RyjDcooqhMXEkxXCBmEhVhEE09gk4zrXPhjPf8/+Y+IL04InLBwBmoiX0gw8+Hrdzl
         3D36pgttpkRxMumKz2qYrV24X3o6EZjnI/Gef/wfjbGVflHhF6Brgpq+de90Xomspczc
         4rvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779751174; x=1780355974;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9kqLDSTLjZL1UfE+kREvz0ReHAL/l7gQcB7q3yu1QaY=;
        b=TgkE23rYDSHMtF9L1zrTCV6AqdyArZxmSY9ytJww9BQh/BQFgjqsG0AzHQmiDbGS98
         DFDColae/yVTT+baxK4AE5z+hIw5UXk7pOCSNw+mwRA34eKHgTxt9/N7OMha6Skap6M8
         ANV+wMYrjW9oRTpyXXPn+kEBQyQ0JpHCUoEr6hNAhvE3BvRNTWPf9uxsVjfuweuRJxfo
         37G1mQe74rLAa1Zecenh10LpE+JqyO+9GXjWhObpxLESPYtrFx34eLz45PyR8rv1Ok06
         wehrTWI66GFMTPvtPTBlQhJnRnFdkqUk/sajsd5LStF2HU0Q35q1VFw6JBcZg89ZAnQo
         cxTw==
X-Forwarded-Encrypted: i=1; AFNElJ+Et4RZGAdbnlaruSZZro/mTicr/tYuu3akpT8ztbfDzWPl/dMDguMuxaPokKx7gzwBYfZMqiWGpEM+7noMP1sR@vger.kernel.org
X-Gm-Message-State: AOJu0YyRu8zv/Pn1AnqGwoBm6GM8MCBa9GhPT0/dDBbs5uEQ/gr0HyWb
	Dn4H8CfOmldfN4qIbxaCcPAwoFO/+mWq95DMCXkmG0kxzsUvrPprcCc7YzyhtTGYcTmGHaNcBsT
	jMNxDvufLcA==
X-Received: from dycsz9.prod.google.com ([2002:a05:693c:3949:b0:2dd:3fe1:f5b2])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:cb86:b0:2be:1f58:32a3
 with SMTP id 5a478bee46e88-304491e075dmr7622939eec.29.1779751173724; Mon, 25
 May 2026 16:19:33 -0700 (PDT)
Date: Mon, 25 May 2026 16:18:57 -0700
In-Reply-To: <20260525231900.3527228-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260522223342.2393553-1-irogers@google.com> <20260525231900.3527228-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.794.g4f17f83d09-goog
Message-ID: <20260525231900.3527228-12-irogers@google.com>
Subject: [RFC PATCH v2 11/14] perf stat: Extend JSON output linter to test
 core aggregation checks
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, linux-perf-users@vger.kernel.org, 
	namhyung@kernel.org
Cc: adrian.hunter@intel.com, james.clark@linaro.org, jolsa@kernel.org, 
	linux-kernel@vger.kernel.org, mingo@redhat.com, peterz@infradead.org
Content-Type: text/plain; charset="UTF-8"

This patch extends tools/perf/tests/shell/stat+json_output.sh to run
all basic and standard CPU/thread aggregation checks under the --new
JSON print flag:

  - check_no_args
  - check_system_wide
  - check_interval
  - check_event
  - check_per_thread
  - check_per_node
  - check_system_wide_no_aggr
  - check_per_core
  - check_per_socket
  - check_per_die

This guarantees that JSON outputs produced by the decoupled, zero-allocation,
and streaming print callbacks are formally validated across standard and interval modes.

Signed-off-by: Ian Rogers <irogers@google.com>
Assisted-by: Antigravity:gemini-3.5-flash
---
 tools/perf/tests/shell/stat+json_output.sh | 71 ++++++++++++++--------
 1 file changed, 45 insertions(+), 26 deletions(-)

diff --git a/tools/perf/tests/shell/stat+json_output.sh b/tools/perf/tests/shell/stat+json_output.sh
index 85d1ad7186c6..8168b861ade7 100755
--- a/tools/perf/tests/shell/stat+json_output.sh
+++ b/tools/perf/tests/shell/stat+json_output.sh
@@ -13,6 +13,7 @@ shelldir=$(dirname "$0")
 . "${shelldir}"/lib/setup_python.sh
 pythonchecker=$(dirname $0)/lib/perf_json_output_lint.py
 
+perf_new_opt=""
 stat_output=$(mktemp /tmp/__perf_test.stat_output.json.XXXXX)
 
 cleanup() {
@@ -35,42 +36,42 @@ function ParanoidAndNotRoot()
 
 check_no_args()
 {
-	echo -n "Checking json output: no args "
-	perf stat -j -o "${stat_output}" true
+	echo -n "Checking $api_label: no args "
+	perf stat -j $perf_new_opt -o "${stat_output}" true
 	$PYTHON $pythonchecker --no-args --file "${stat_output}"
 	echo "[Success]"
 }
 
 check_system_wide()
 {
-	echo -n "Checking json output: system wide "
+	echo -n "Checking $api_label: system wide "
 	if ParanoidAndNotRoot 0
 	then
 		echo "[Skip] paranoia and not root"
 		return
 	fi
-	perf stat -j -a -o "${stat_output}" true
+	perf stat -j $perf_new_opt -a -o "${stat_output}" true
 	$PYTHON $pythonchecker --system-wide --file "${stat_output}"
 	echo "[Success]"
 }
 
 check_system_wide_no_aggr()
 {
-	echo -n "Checking json output: system wide no aggregation "
+	echo -n "Checking $api_label: system wide no aggregation "
 	if ParanoidAndNotRoot 0
 	then
 		echo "[Skip] paranoia and not root"
 		return
 	fi
-	perf stat -j -A -a --no-merge -o "${stat_output}" true
+	perf stat -j $perf_new_opt -A -a --no-merge -o "${stat_output}" true
 	$PYTHON $pythonchecker --system-wide-no-aggr --file "${stat_output}"
 	echo "[Success]"
 }
 
 check_interval()
 {
-	echo -n "Checking json output: interval "
-	perf stat -j -I 1000 -o "${stat_output}" true
+	echo -n "Checking $api_label: interval "
+	perf stat -j $perf_new_opt -I 1000 -o "${stat_output}" true
 	$PYTHON $pythonchecker --interval --file "${stat_output}"
 	echo "[Success]"
 }
@@ -78,110 +79,110 @@ check_interval()
 
 check_event()
 {
-	echo -n "Checking json output: event "
-	perf stat -j -e cpu-clock -o "${stat_output}" true
+	echo -n "Checking $api_label: event "
+	perf stat -j $perf_new_opt -e cpu-clock -o "${stat_output}" true
 	$PYTHON $pythonchecker --event --file "${stat_output}"
 	echo "[Success]"
 }
 
 check_per_core()
 {
-	echo -n "Checking json output: per core "
+	echo -n "Checking $api_label: per core "
 	if ParanoidAndNotRoot 0
 	then
 		echo "[Skip] paranoia and not root"
 		return
 	fi
-	perf stat -j --per-core -a -o "${stat_output}" true
+	perf stat -j $perf_new_opt --per-core -a -o "${stat_output}" true
 	$PYTHON $pythonchecker --per-core --file "${stat_output}"
 	echo "[Success]"
 }
 
 check_per_thread()
 {
-	echo -n "Checking json output: per thread "
+	echo -n "Checking $api_label: per thread "
 	if ParanoidAndNotRoot 0
 	then
 		echo "[Skip] paranoia and not root"
 		return
 	fi
-	perf stat -j --per-thread -p $$ -o "${stat_output}" true
+	perf stat -j $perf_new_opt --per-thread -p $$ -o "${stat_output}" true
 	$PYTHON $pythonchecker --per-thread --file "${stat_output}"
 	echo "[Success]"
 }
 
 check_per_cache_instance()
 {
-	echo -n "Checking json output: per cache_instance "
+	echo -n "Checking $api_label: per cache_instance "
 	if ParanoidAndNotRoot 0
 	then
 		echo "[Skip] paranoia and not root"
 		return
 	fi
-	perf stat -j --per-cache -a true 2>&1 | $PYTHON $pythonchecker --per-cache
+	perf stat -j $perf_new_opt --per-cache -a true 2>&1 | $PYTHON $pythonchecker --per-cache
 	echo "[Success]"
 }
 
 check_per_cluster()
 {
-	echo -n "Checking json output: per cluster "
+	echo -n "Checking $api_label: per cluster "
 	if ParanoidAndNotRoot 0
 	then
 		echo "[Skip] paranoia and not root"
 		return
 	fi
-	perf stat -j --per-cluster -a true 2>&1 | $PYTHON $pythonchecker --per-cluster
+	perf stat -j $perf_new_opt --per-cluster -a true 2>&1 | $PYTHON $pythonchecker --per-cluster
 	echo "[Success]"
 }
 
 check_per_die()
 {
-	echo -n "Checking json output: per die "
+	echo -n "Checking $api_label: per die "
 	if ParanoidAndNotRoot 0
 	then
 		echo "[Skip] paranoia and not root"
 		return
 	fi
-	perf stat -j --per-die -a -o "${stat_output}" true
+	perf stat -j $perf_new_opt --per-die -a -o "${stat_output}" true
 	$PYTHON $pythonchecker --per-die --file "${stat_output}"
 	echo "[Success]"
 }
 
 check_per_node()
 {
-	echo -n "Checking json output: per node "
+	echo -n "Checking $api_label: per node "
 	if ParanoidAndNotRoot 0
 	then
 		echo "[Skip] paranoia and not root"
 		return
 	fi
-	perf stat -j --per-node -a -o "${stat_output}" true
+	perf stat -j $perf_new_opt --per-node -a -o "${stat_output}" true
 	$PYTHON $pythonchecker --per-node --file "${stat_output}"
 	echo "[Success]"
 }
 
 check_per_socket()
 {
-	echo -n "Checking json output: per socket "
+	echo -n "Checking $api_label: per socket "
 	if ParanoidAndNotRoot 0
 	then
 		echo "[Skip] paranoia and not root"
 		return
 	fi
-	perf stat -j --per-socket -a -o "${stat_output}" true
+	perf stat -j $perf_new_opt --per-socket -a -o "${stat_output}" true
 	$PYTHON $pythonchecker --per-socket --file "${stat_output}"
 	echo "[Success]"
 }
 
 check_metric_only()
 {
-	echo -n "Checking json output: metric only "
+	echo -n "Checking $api_label: metric only "
 	if [ "$(uname -m)" = "s390x" ] && ! grep '^facilities' /proc/cpuinfo  | grep -qw 67
 	then
 		echo "[Skip] CPU-measurement counter facility not installed"
 		return
 	fi
-	perf stat -j --metric-only -M page_faults_per_second -o "${stat_output}" true
+	perf stat -j $perf_new_opt --metric-only -M page_faults_per_second -o "${stat_output}" true
 	$PYTHON $pythonchecker --metric-only --file "${stat_output}"
 	echo "[Success]"
 }
@@ -214,6 +215,7 @@ check_for_topology()
 }
 
 check_for_topology
+api_label="json output"
 check_no_args
 check_system_wide
 check_interval
@@ -232,5 +234,22 @@ then
 else
 	echo "[Skip] Skipping tests for system_wide_no_aggr, per_core, per_die and per_socket since socket id exposed via topology is invalid"
 fi
+# Run New API JSON basic and standard aggregation checks
+perf_new_opt="--new"
+api_label="json (New API)"
+check_no_args
+check_system_wide
+check_interval
+check_event
+check_per_thread
+check_per_node
+if [ $skip_test -ne 1 ]
+then
+	check_system_wide_no_aggr
+	check_per_core
+	check_per_die
+	check_per_socket
+fi
+
 cleanup
 exit 0
-- 
2.54.0.794.g4f17f83d09-goog

