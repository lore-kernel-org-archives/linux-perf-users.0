Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.69
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795212977;
	b=ZV9eWMq+J5mG55kH/JLw0usCClpEkq6Oy6WPi6zvvk8s0o7TORaVWB467KXHnZsT0za1
	 uI2avHZoU/ti9HU6PopGMfSVKTfW0pvBOYMotyjhumds1jY/DO5RP9RW4jf1fg5Ci6Chp
	 w8zhoNFES2IDXThykVgDZ7BBe/3+dX+HCapSlBamPrluMsH3pBPJTiUbraqbAuGaYYUE9
	 2CXgRK8gPF0AhnO4aQ9OGbePhNfU5KADx9BuxNb82sU1+bddT9QP+diJ21UCP7UkXn7gV
	 dU/IdcVYSUyNV4e5DEbwk5CdkwVDEMSsMpKIX/YdSI5CvEDkqafnEJX9cH9MH9f4FAw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795212977;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Received:Date:In-Reply-To:Mime-Version:
	 References:X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=oHsRoybgY+Gjh4tRFzKxL6MY+fBFhB444U/1ojQ4iqU=;
	b=dHZPI/DmNfSkfepHb3cckPBjdm3ktd85J7/c3k31OLhnM9tpzJxeASY3RTcN+DwIArSj
	 6CqqfOo1JQ0kvWt5MO+coK4urkO2sGFqGivSQU42W0Q7N7yUUBk0pS4OKfc9RKvwxfwf0
	 wypu4YjY32iJLe7mAY+fvmy8+ysWlZE/PI8zzwYY/K8MzZhKMqnFNolfsvNeai4ZlWkAr
	 FjUcJbEMpF4kEP/S+KOIRdy5TcJRM9hlDIbTfYi/+JR6p7hflCK+ROeSswGElJ5IMcnQ5
	 dEz+6pXOlbA1GGe+fL9Cpy5Cxp96yHp69Q6TEC9V04JoVK4hTxC56RKKXV3GfnWDEdQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=ZMX5UBTX;
	arc=none smtp.remote-ip=74.125.82.69
Received: from mail-dl1-f69.google.com (mail-dl1-f69.google.com [74.125.82.69])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1954A606A6AC
	for <linux-perf-users@vger.kernel.org>; Fri, 20 Nov 2026 22:16:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1954A606A6AC
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=ZMX5UBTX
Received: by mail-dl1-f69.google.com with SMTP id a92af1059eb24-1383723dfddso1465347c88.0
        for <linux-perf-users@vger.kernel.org>; Fri, 20 Nov 2026 14:16:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795212972; x=1795817772; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=oHsRoybgY+Gjh4tRFzKxL6MY+fBFhB444U/1ojQ4iqU=;
        b=ZMX5UBTXxuSn9MZdULk5Boi+06w35jYg5kNVDlf23q8wAcj1XW8lydHenKwr/mg9EU
         NQ6luQhkTaxLIG/kqPGe3x8fNf6am5dZ+s5vAKx212qW3jrLhp0L4ccBgoETGCCIZIMa
         i3CKILUwdPcMs7U4fQJODz4cXtonAXqX0q2VYBNB/TklxG75M2vy411JHsOBO8Crs894
         Ps7UqnvEdzzCLDIo0dQRCH/7fRQXO6KAcF0p7++G9qqMZZqsA4QMknOxVJ+ACfNLCONq
         AKZHmOHCiXn5dOQp82dIsBjWgw9w5DF91GcIjsvoOZAcOJ6Iy/u57eDtE9c3SbIYuhFi
         pGpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795212972; x=1795817772;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=oHsRoybgY+Gjh4tRFzKxL6MY+fBFhB444U/1ojQ4iqU=;
        b=HCpEsfnSEavZI2SIiSEzpCsAml7SlY6CpTkLNmmysR9BNZu9/9SRXpYDnHHisfWVAf
         7dBBop/TCsLiJsAS5W1pWlhWQ6u1YVYRYP1GuovbPXx2U/Gps06eOVFeD/SKQZoQFvqN
         tbGiR9MMXQM6bTw3ww5Fo07YUsypD7ygmHbHSWmzFPg3d6nFcpvwwPe5JQqQsDBtCmTG
         LqfuUAkWohc9SaAlBmTf91NWtxYG3lBQQayVXiZSLSQSKyCmrE3eAnigVHqDdPkc+el9
         PPWxA97CTwEIlnySoy6WPq9TmFatqvs6jrnu3RrPQPljXNtTPW+meJOlnVDtnUx7HusC
         2ZoQ==
X-Gm-Message-State: APuU4Z8J2KV+Awir3KwfQR1Jt2OSrj9YI3qs6hQQCQN8J8NZzUFDcH5R
	tHAoLhddzVXoVKFj5siCtjH0Z2yEHtXU3s4hpLAS87TITjjtKT1irhPP3rCZ+jvsF0vq2bJlEhW
	X1vh2UCPx7g==
X-Received: from dlbrx25.prod.google.com ([2002:a05:7022:1719:b0:15f:5ef4:b896])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:3a0b:b0:1a2:fa1d:1de5
 with SMTP id a92af1059eb24-1b5568d861cmr4068875c88.20.1795212971463; Fri, 20
 Nov 2026 14:16:11 -0800 (PST)
Date: Fri, 20 Nov 2026 14:13:31 -0800
In-Reply-To: <20261120221332.2245191-1-irogers@google.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261120221332.2245191-1-irogers@google.com>
X-Mailer: git-send-email 2.56.1.750.gf70dc682cf-goog
Message-ID: <20261120221332.2245191-31-irogers@google.com>
Subject: [PATCH v3 30/30] perf test: Add stat record metrics test
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
2.56.1.750.gf70dc682cf-goog

