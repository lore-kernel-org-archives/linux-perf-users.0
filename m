Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46E3638D69D
	for <linux-perf-users@vger.kernel.org>; Thu, 16 Jul 2026 07:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784185415; cv=none; b=kpK5OfmuupF6fFnzxOU9SllLpOdFlW5wPjcKKcd5xi101SpdNjZTTUWzqU6goqI8dPxtLmuibWH45lUlEYuipykO5qGfpdhU19Z4PtLkna1bW+gMJS8bEl4+RFJSAVMYo5uffu/xbmwZPKiftxGLocD2HITMGZtX/LltbIb9/gw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784185415; c=relaxed/simple;
	bh=FGW7ZR9yoomli7lZ8GOfioH5oDYhOp4P4xkrcpJjkpE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=QS3U0GF7tCy1WhCO79tw3lvgxKysL1OeULpJoO8P0LHIqF1jSLZIOmAkQWTMcWzuLhjRp++yWHIzYlv8W41CQEqywf/sHWvxbmujBVahRjQvOXyYiHp90sJ+eYfL4R+HHAZAD3AeLGxq4pDgi03SAnTED4jQrxr42EnfY/yCAmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gm43uGVA; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gm43uGVA"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-c916d17dd43so10388216a12.3
        for <linux-perf-users@vger.kernel.org>; Thu, 16 Jul 2026 00:03:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784185413; x=1784790213; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=c2WNQJI5LKocnmbHS2DrLyD6ql7IEqENaBv126GRlho=;
        b=gm43uGVAreCVHisYr2cNCN89u0O4C5jQn1QkdhXKAeF5HKru9IXElEi4qYzDm1AlDV
         eQVkJeXnMNrEd7Bo/eCIYiSGyaVnUCsfrs6LfByofiQkt9SM35HCSuHtQI3oSsgbfn/w
         pzKokPV+ivvfYiNcT9zwtEsvX9LWC9S9XHKONbZPvq9y8xq8eXioY6rnMChjzvD2sFv2
         GWgO8Z5JNaCgySLuLYG4VK+GXGZYz1p+gwsAK7cdACUWa+vd2D+n8cFhCOjA7ITkpR8i
         DyEQfnlEjLUFWM9Tfpl6XyaDPY96tE1Yk/Xuz9hz5UXYFmYAey43L40q7nditiKdoO8e
         bC2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784185413; x=1784790213;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=c2WNQJI5LKocnmbHS2DrLyD6ql7IEqENaBv126GRlho=;
        b=N/AoIQsVnX7gqRtStD3fBKPCd4HvaE5XIHk8fwI+5jysxf99awVMLgKKQ+wUyxwkt+
         raqutXBjdyGMtHFofghmEOPUyHBsapnTGuYkkBSucMPP6Y5ngAV5sPfqJUWjBAaEgytw
         RzBTcyFOfBRoCpXojAAZCMYcUB2Tao6x26MJ4RiaZ1zVm0VLceYnPnLUglotRPeUlAG9
         qB3n3+Vx1nK+QD26W4FHNh9T+kKqV8/MRshV1ZPi1XAtFs5BUMTXDRDjCJt266ebA5eP
         AXn4+Uw22ISdfZ/iuoiuSozkGpXqY2gsoe84EZgGJY8ntv26+oEdmpfcm+Je2N+K2fnX
         0oqQ==
X-Forwarded-Encrypted: i=1; AHgh+RqgznCDnvbcR6G8HYREQECCu6g4Ir30C/zB+KI7oyjxUykPjuodTiPwMYUFA9/E95JrEtrDxvbpLgXTsYn9C4c3@vger.kernel.org
X-Gm-Message-State: AOJu0YzVme8+4HBULNxnUgbTXOnnAWQgueMIhC5xHH1w8nQD0Wcq63zt
	Rels6GgQt31LuaN1uYkYhQH/DbyD0txtrtm/0oYZ+pffiV/cwJcnkDGUQL/2GHgKwxWvtpwE+aT
	0hkOOmrQi8w==
X-Received: from dybmi5.prod.google.com ([2002:a05:7301:f85:b0:30f:2f43:117b])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:3d22:b0:3c0:9c19:65b7
 with SMTP id adf61e73a8af0-3c36c433382mr6914165637.63.1784185413200; Thu, 16
 Jul 2026 00:03:33 -0700 (PDT)
Date: Thu, 16 Jul 2026 00:03:00 -0700
In-Reply-To: <20260716070303.507066-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260716043223.388233-1-irogers@google.com> <20260716070303.507066-1-irogers@google.com>
X-Mailer: git-send-email 2.55.0.141.g00534a21ce-goog
Message-ID: <20260716070303.507066-12-irogers@google.com>
Subject: [PATCH v4 11/14] perf stat: Extend JSON output linter to test core
 aggregation checks
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, ctshao@google.com, 
	namhyung@kernel.org
Cc: adrian.hunter@intel.com, james.clark@linaro.org, jolsa@kernel.org, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	mingo@redhat.com, peterz@infradead.org
Content-Type: text/plain; charset="UTF-8"

This patch extends tools/perf/tests/shell/stat+json_output.sh to run all
basic and standard CPU/thread aggregation checks under the --new JSON
print flag:

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

This guarantees that JSON outputs produced by the decoupled,
zero-allocation, and streaming print callbacks are formally validated
across standard and interval modes.

Signed-off-by: Ian Rogers <irogers@google.com>
Assisted-by: Antigravity:gemini-3.5-flash
Acked-by: Chun-Tse Shao <ctshao@google.com>
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
2.55.0.141.g00534a21ce-goog

