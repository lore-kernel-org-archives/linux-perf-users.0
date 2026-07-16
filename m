Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B33B38238C
	for <linux-perf-users@vger.kernel.org>; Thu, 16 Jul 2026 04:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784176399; cv=none; b=J8hbhfxBHdvKADrBwZUXTh9wR8Cy8CDsxHolttPdjRZjbX+n3eaqC72z3jn+lYl9CYQzx3iSOdzaHSVVNF+koBqm5LG7s8QuL1iSKjllh6NhYZLF39pKGvLKfJPbTT5nEJow18Za8VCqcVK62GkEHalxeRO0Vfha2gjAAVB+jGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784176399; c=relaxed/simple;
	bh=nTYCyrNr3Dopwvrdc9lhpjMUkBgrCvKzCBft9TlBxgs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ifdeR4ZjiRAUcEufbZCakN9skO66u/Vc54b3i0mw6m0nkO1xaZqY5RIHGY7nR2+yK63+eDyoWTif7yICyb0473t5em3t2jJI8aodj581qftNOblOaAj5sWTBFF9Z09B85eqKZafyTccOnZYNUvF7sbcpDaNXDGZTsVGbrtf1/ys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SZ0ULsGL; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SZ0ULsGL"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-cab041eced3so7036308a12.1
        for <linux-perf-users@vger.kernel.org>; Wed, 15 Jul 2026 21:33:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784176397; x=1784781197; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fhU3XiQPN4YP2a3S4XXH/u+7fM9ZJ52r4mxVp56qzW8=;
        b=SZ0ULsGLy83Bw4fU85pzIr/FlE5nYfKKLBro3FqDi/SsEJVdFiaA7Dfb6v+4TYjAYB
         2J4X6kq9P1ZiuJBE27wvNFexImW+XBllkGFcLQoERg37Hb+qckJRw5TiO6Nz4akA74vx
         YwHfXJAabLwfbbcwtk8gRvKzrzdX4Mz0DA1iEmtbMxZTme+8r2o9kOApPgL5utIzuQYr
         oAzuPB6FVI+mGbTwRnKhlhqMLtEgcUtuFrzgHRe2ELfur24lfRrbvAXyxzdElByujD4w
         1ZBajlXWlB/MDQlSuU+miSumx4Vj9BhZAf/KaA/rHN26GOqkmZxfFSzg7rWE+jksLVne
         bR1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784176397; x=1784781197;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fhU3XiQPN4YP2a3S4XXH/u+7fM9ZJ52r4mxVp56qzW8=;
        b=kuGvaDHtxWrF9muJ9j2Dj6XinCA1A9ZU4SAnqUoOPWtaezOgPiwYW28L4cKVKMOX5e
         MRhQkR9xgkB3KWAhHz38+LfEapZu6eqSVW53R0d7gyRf9pcmoz1J+3Ww/FTYqJEztZEt
         RwQaTOWQuM/XhenDCVBZqWNWlulYuWQqRWDBf5Ht6MgtqfyQGd8vFiaNVtNBaMMEbPMv
         n9I8S3qDx0VXBWuIx3isS+hc2aEzwsLN96Jlil52Nsj0B58rSG1J+B8IazK2KOMiviB0
         M0u+Fvj7o3OauTBtHtChbobHDOKuJGVEjOocZb3MZVkWvhSc+XPifJRibhxd5DlUzKX2
         2Hsw==
X-Forwarded-Encrypted: i=1; AHgh+RpW5PvjX1OnJ/o2sRtpBcXBrWlEoX+94tg2KceEvcaM4lUpCcZb3KKiVBJngWeUNMfJP9yLCv++UneFCr7B/Ykk@vger.kernel.org
X-Gm-Message-State: AOJu0Yyu9LfgzKRZnZ8e8tcFl3qJHUFf3DbDBBc5HAq2VpGR/nB6HzIX
	0uk8m3B7+bs5p4hukF8ctbB/5kSOwP2xFc+8l410TcBCjayXKlRuhDY76gxOU15kpqkchn70w+M
	/Fz/T/DrxuQ==
X-Received: from dleb2-n1.prod.google.com ([2002:a05:701b:4242:10b0:13c:d45f:48f9])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:9210:b0:3b4:8f18:33a
 with SMTP id adf61e73a8af0-3c35731da43mr11363765637.1.1784176397266; Wed, 15
 Jul 2026 21:33:17 -0700 (PDT)
Date: Wed, 15 Jul 2026 21:32:20 -0700
In-Reply-To: <20260716043223.388233-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260525231900.3527228-1-irogers@google.com> <20260716043223.388233-1-irogers@google.com>
X-Mailer: git-send-email 2.55.0.141.g00534a21ce-goog
Message-ID: <20260716043223.388233-12-irogers@google.com>
Subject: [PATCH v3 11/14] perf stat: Extend JSON output linter to test core
 aggregation checks
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, namhyung@kernel.org, 
	ctshao@google.com
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

