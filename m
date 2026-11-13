Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.198
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794599698;
	b=b8kPZmRUdLPkvemrkyPRH5Kd0PgupYZ3/ux9FhElZ9vgv2X7XKMEdeEpGJllsogMRa4P
	 unMlttg5lslYQ8x+ZpL+InA9vIPyL/vY9YQTINx7+91asxmI/3S1OYpJ7nuLsMn94SGWi
	 +Zsbbw/Jk7MGQUpviWJq8iMYGUqFnOatXOXrH5cPC8CLfKUlggovOPAUnBDQegh+UgKT/
	 Mwimthocz06OK8jCYw+9AxPzqWHh7Gu3ZTAOlraRLBqpVfvgCEdRFzUi8ta1zYLiky6MP
	 8rkJW7p9u0ykSt5J6pad1UPWHHknW1CaMGhFIWSGjoJiU4r7GfZsiEnsG22TCjU4f8Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794599698;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Received:Date:In-Reply-To:Mime-Version:
	 References:X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=O5gn7DpGqVLkw6L0o62VsOaohkIL3+2t2UU7bN7Ptag=;
	b=M6rQqrQzjAiV7xNAgsipOsF+p/iDN4xeZ3gyA6LYEXGGFJEyk3YZzja0HifudS7fkteI
	 AJCsfW9q2W0p8IvZq4wRyI2I9Q5pkEe2c2Hx+0jD3LvV3g2O0EK/s2uqiA7iUq/mUZFX3
	 kYnr6PnS9Mj9Kv0j/6houvJrivVDLh1Ucb+ji5IOx4q07HlYHq6qAa1CBdEa0RmP7YzRh
	 hIHnlZKA3z7dnUEtq4U3AymqrWir+zBXLaoSGo+i7rAUWRlY+pEK4pZfVyiLXkbrtZC5+
	 Z8Wwxjo5hxjCkCuVr46v/Rrtf/ppaB1fHlqvQrc8ABhmgzhVrNYlFmISwvkHYr2pqGw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Ws21NA6V;
	arc=none smtp.remote-ip=74.125.82.198
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com [74.125.82.198])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 633B7606BCDD
	for <linux-perf-users@vger.kernel.org>; Fri, 13 Nov 2026 19:54:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 633B7606BCDD
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Ws21NA6V
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-36f479b9819so1584766eec.1
        for <linux-perf-users@vger.kernel.org>; Fri, 13 Nov 2026 11:54:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794599697; x=1795204497; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=O5gn7DpGqVLkw6L0o62VsOaohkIL3+2t2UU7bN7Ptag=;
        b=Ws21NA6V39lbH7yhqH9X/hYmv2KZXJtvL7mSs0aRKtbgPTy46FQl+jNEBhzywm4Aom
         a0rvfEOWh3olfVlVc3v6Hth0AEhemiQJhg3wWHs9zGcI4QgprEVNtwRBnm1dPHBzzIwe
         Lf7ikYS+JxwhGSXFYVR5dQKNNY6nA3AxFyDaYn8hkdju7d9QDwrILREg+qn8C6ekoa3J
         o32NAt1xMVHBA1s6JDRxrRMGoQu0S1NJUQ7IAN5ehM1YtmVo/hjUZqQRyM/VLCu/JhpL
         qgU/cAXfU3F/OWRxIUTPo+rlFlDkSjKijEKrGm/z+wYS/Q0bn0+9jjBwEnFsSjsRsqmb
         4VUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794599697; x=1795204497;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=O5gn7DpGqVLkw6L0o62VsOaohkIL3+2t2UU7bN7Ptag=;
        b=XUchth3kK3XwK0Z/thnBRcQQm0W3WfbpkvP58e/cZkAaCb6EIF9EMpHxO4MJAgsG+B
         9y6wMRBevqBKixdei0pD50oIr/oQ2Bw4tpKswQeNsz2BR/lOkahTIG8W04XUwxkqTTKE
         iw2KGjatNjNvfp0QfpTagp0Ob6Z/cNwsvomDz12MSKFZIziUXqI3lpmZIne5AT7KCdAq
         t35QOIfnds7/UmC2Majlfu/eQMjeTJM/Kkh9I1phnZ/0UoI85hBI1Lmch9RmbVHKoPx4
         6peDB23MiEXPPQbEKWM1qo5RywQgS0m+FEa+BNRNbt1PpRig2B8BjUBq2ux9yWcC4OMk
         9+Rw==
X-Gm-Message-State: APuU4Z8EnCFLdsgw/ue+rNJrg5xztNXeRZZYJQT1gS4r8c+6rnOPtK7L
	BSjuBnUvBg/twdHSp9d7hFZPRrhyhPNaRRXm/1+dZJtEvmb6yaXo0p6aGDxtdbomqKkTlZf7vjz
	gV8Y7giSJ9w==
X-Received: from dyad23.prod.google.com ([2002:a05:693c:8357:b0:36a:120e:b9a])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:693c:895b:20b0:36f:5746:3364
 with SMTP id 5a478bee46e88-37967ce04e9mr2959152eec.28.1794599697197; Fri, 13
 Nov 2026 11:54:57 -0800 (PST)
Date: Fri, 13 Nov 2026 11:53:35 -0800
In-Reply-To: <20261113195335.2865725-1-irogers@google.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261113195335.2865725-1-irogers@google.com>
X-Mailer: git-send-email 2.56.1.703.gf848ed807c-goog
Message-ID: <20261113195335.2865725-31-irogers@google.com>
Subject: [PATCH v2 30/30] perf test: Add stat record metrics test
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Test that metrics measured by perf stat record are displayed by perf
stat report and perf script, and that events recorded with -e only
display matching JSON metrics in perf stat report and perf script when
--all-metrics, stat.all-metrics=true, or -M is used.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/shell/stat.sh | 133 +++++++++++++++++++++++++++++++++
 1 file changed, 133 insertions(+)

diff --git a/tools/perf/tests/shell/stat.sh b/tools/perf/tests/shell/stat.sh
index ac9e031831da..2e1d5978d55a 100755
--- a/tools/perf/tests/shell/stat.sh
+++ b/tools/perf/tests/shell/stat.sh
@@ -6,9 +6,25 @@ set -e
 
 err=0
 stat_output=$(mktemp /tmp/perf-stat-test-output.XXXXX)
+stat_data=""
+stat_config=""
+
+stat_record_metrics_cleanup() {
+  if [ -n "${stat_data}" ]
+  then
+    rm -f "${stat_data}" "${stat_data}.old"
+    stat_data=""
+  fi
+  if [ -n "${stat_config}" ]
+  then
+    rm -f "${stat_config}"
+    stat_config=""
+  fi
+}
 
 cleanup() {
   rm -f "${stat_output}"
+  stat_record_metrics_cleanup
   trap - EXIT TERM INT
 }
 
@@ -92,6 +108,122 @@ test_stat_record_script() {
   echo "stat record and script test [Success]"
 }
 
+test_stat_record_metrics() {
+  echo "stat record metrics test"
+  if ! perf stat -M insn_per_cycle true 2>&1 | grep -E -q "[0-9]+.*[[:space:]]+insn_per_cycle"
+  then
+    echo "stat record metrics test [Skipped insn_per_cycle metric unsupported]"
+    return
+  fi
+  stat_data=$(mktemp /tmp/perf-stat-test-data.XXXXX)
+  if ! perf stat record -o "${stat_data}" -M insn_per_cycle true > /dev/null 2>&1
+  then
+    echo "stat record metrics test [Failed record]"
+    stat_record_metrics_cleanup
+    err=1
+    return
+  fi
+  if ! perf stat report -i "${stat_data}" 2>&1 | grep -q "insn_per_cycle"
+  then
+    echo "stat record metrics test [Failed missing metric in perf stat report]"
+    stat_record_metrics_cleanup
+    err=1
+    return
+  fi
+  if ! perf script -i "${stat_data}" 2>&1 | grep -E -q "metric:.*insn_per_cycle"
+  then
+    echo "stat record metrics test [Failed missing metric in perf script]"
+    stat_record_metrics_cleanup
+    err=1
+    return
+  fi
+  if ! perf stat record -o "${stat_data}" -e instructions,cycles true > /dev/null 2>&1
+  then
+    echo "stat record metrics test [Failed record with events]"
+    stat_record_metrics_cleanup
+    err=1
+    return
+  fi
+  if perf stat report -i "${stat_data}" 2>&1 | grep -q "insn_per_cycle"
+  then
+    echo "stat record metrics test [Failed unexpected metric in perf stat report]"
+    stat_record_metrics_cleanup
+    err=1
+    return
+  fi
+  if ! perf stat report --all-metrics -i "${stat_data}" 2>&1 | grep -q "insn_per_cycle"
+  then
+    echo "stat record metrics test [Failed missing metric in perf stat report --all-metrics]"
+    stat_record_metrics_cleanup
+    err=1
+    return
+  fi
+  if perf script -i "${stat_data}" 2>&1 | grep -E -q "metric:.*insn_per_cycle"
+  then
+    echo "stat record metrics test [Failed unexpected metric in perf script]"
+    stat_record_metrics_cleanup
+    err=1
+    return
+  fi
+  if ! perf script --all-metrics -i "${stat_data}" 2>&1 | grep -E -q "metric:.*insn_per_cycle"
+  then
+    echo "stat record metrics test [Failed missing metric in perf script --all-metrics]"
+    stat_record_metrics_cleanup
+    err=1
+    return
+  fi
+  stat_config=$(mktemp /tmp/perf-stat-test-config.XXXXX)
+  printf "[stat]\nall-metrics = true\n" > "${stat_config}"
+  if ! PERF_CONFIG="${stat_config}" perf stat report -i "${stat_data}" 2>&1 | \
+    grep -q "insn_per_cycle"
+  then
+    echo "stat record metrics test [Failed stat report stat.all-metrics=true]"
+    stat_record_metrics_cleanup
+    err=1
+    return
+  fi
+  if ! PERF_CONFIG="${stat_config}" perf script -i "${stat_data}" 2>&1 | \
+    grep -E -q "metric:.*insn_per_cycle"
+  then
+    echo "stat record metrics test [Failed perf script stat.all-metrics=true]"
+    stat_record_metrics_cleanup
+    err=1
+    return
+  fi
+  rm -f "${stat_config}"
+  stat_config=""
+  if ! perf stat report -M insn_per_cycle -i "${stat_data}" 2>&1 | grep -q "insn_per_cycle"
+  then
+    echo "stat record metrics test [Failed missing metric in perf stat report -M insn_per_cycle]"
+    stat_record_metrics_cleanup
+    err=1
+    return
+  fi
+  if ! perf stat record -o "${stat_data}" true > /dev/null 2>&1
+  then
+    echo "stat record metrics test [Failed default record]"
+    stat_record_metrics_cleanup
+    err=1
+    return
+  fi
+  if ! perf stat report -i "${stat_data}" 2>&1 | grep -q "insn_per_cycle"
+  then
+    echo "stat record metrics test [Failed missing default metric in perf stat report]"
+    stat_record_metrics_cleanup
+    err=1
+    return
+  fi
+  if ! perf script -i "${stat_data}" 2>&1 | grep -E -q "metric:.*insn_per_cycle"
+  then
+    echo "stat record metrics test [Failed missing default metric in perf script]"
+    stat_record_metrics_cleanup
+    err=1
+    return
+  fi
+  stat_record_metrics_cleanup
+  echo "stat record metrics test [Success]"
+}
+
 test_stat_repeat_weak_groups() {
   echo "stat repeat weak groups test"
   if ! perf stat -e '{cycles,cycles,cycles,cycles,cycles,cycles,cycles,cycles,cycles,cycles}' \
@@ -601,6 +733,7 @@ test_null_stat
 test_offline_cpu_stat
 test_stat_record_report
 test_stat_record_script
+test_stat_record_metrics
 test_stat_repeat_weak_groups
 test_topdown_groups
 test_topdown_weak_groups
-- 
2.56.1.703.gf848ed807c-goog

