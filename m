Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42CFA183098
	for <linux-perf-users@vger.kernel.org>; Thu,  8 Aug 2024 05:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723096014; cv=none; b=DlMhuXm6+kkmoT+KHaF7k7ZZvTub3bD8RXdrZZsSF0OYqCbk1hIlh4gMTOorRtRrDangnaYR/PKzdPj+9yq3r7z+juaKaI2X+VuA6cRfDFE/WLqYpDbPalOUABdNu/ru32q3Aee7JHhVSOkCSm4IMzkd1u4YEVLzwAoWpSiVEEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723096014; c=relaxed/simple;
	bh=1xM/obalM1Zz/Qgs0+hW+TUUWAOW2S/SDCArn56ZLuY=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=Zpputdwuxu3vD1pSMNcqkIvL83EEP7lq0KvD2voz7GiP+rXq4gL2w/VQ3gp8Xct/tsSkw/tdiv1emcron38askKi6iTuJLmPaKxuca8umjfP/K93ocAstAyB10rJPXuaVio56TvUP3AcMF1znnQo5i/YrCVOlem7DifHhMF8860=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zGpda7uX; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zGpda7uX"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-654d96c2bb5so13134027b3.2
        for <linux-perf-users@vger.kernel.org>; Wed, 07 Aug 2024 22:46:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723096011; x=1723700811; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xhM04XOuy0Npad0DaVUlBDWgqhxXjCFufiJExS1b808=;
        b=zGpda7uXm02C6mBL72Yau0EccRjGzwuq17ZFTVy7EZzMO1ImFAIAxXqehlbYqxSb8Q
         ly6DHF4zxavfCta/6WZSJKsIgJcYf73ev5JkG02mTbcM6iTcGMazI1FDUfhgDUfQGlUw
         2iE1pg3wl3UppCjj27NECxuiskil8HzOZHYsElL3LAUhDxJc+sLuzxGVJhFYkQMw8xfg
         P8rvHQ0k5UDx6xfOrBGCzPkZRlZpKUk2CELVKPO0qenAQyOX4FwGGpVtyX90lYGwlY4V
         wJ1VsYl/IGGTr3cYBNsumDgGpwwGOxsylNPCdtqE9s+lJV/6MMJWfpyx9HwVniNI0Kob
         1PKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723096011; x=1723700811;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xhM04XOuy0Npad0DaVUlBDWgqhxXjCFufiJExS1b808=;
        b=rdleCjzuSTqDuefm3OfGHu8iDhqHhtiXehNd/Y3gqBJfXmp/JCo2FI/1R+7wHVkPNN
         O0JA9yENlmx4JYrH9AwF+ip1XScQj9A0XU5zWsyeRuqVMhm0wsrSHkj7cOnOo0Y77LHy
         MmJjyqJN1MKFFbfIjePsaToTs576ORwV+zJ91Qqfd7cZyIySA/bcdFck80Bd12C7BbNv
         m3o2UFp6+oUQBh0vJeyqrKytvAPchEwXrLBwgu7BBI7SNzAEKuUjqBcVkbCNOsDAdUbX
         rhQijG4bVPPw4OFXtEE90TIhzNEaE869MMyxDPIC+OiTMKY7jYOWC8ONXwjxL3MsuvNp
         rO3A==
X-Forwarded-Encrypted: i=1; AJvYcCU+eDT3cJt69+UDlgcLQ0E0qQ6SUOkjEPHuSzjDri8XbQlSpGuMWu5fQRnQDK6xXS1vfGPa9J58rHNpRU5PKbTQ@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1zn+N2Fgp+Rm7cZTZhRZ2v+ULNyZjsZcOr2qhVsMQjlQSnB1b
	CBuZIDF2GrtH//CQQ2tB0+6VnqzIC+H5PPA/emFJI1J8Ke3wGNNMfOf2KDexsuJK6+izi+I+REn
	NW36Bwg==
X-Google-Smtp-Source: AGHT+IE7F+fXcgGfS593aciFSAJIuK69gAAk1Ygg943wWj2kCII1jjYfAXNtT1xgN7qTAer0RD197wqazTeK
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:b5fd:72d8:6b88:65f6])
 (user=irogers job=sendgmr) by 2002:a81:ae25:0:b0:64a:8adc:f95c with SMTP id
 00721157ae682-69bfbf958bcmr230557b3.8.1723096011145; Wed, 07 Aug 2024
 22:46:51 -0700 (PDT)
Date: Wed,  7 Aug 2024 22:46:44 -0700
In-Reply-To: <20240808054644.1286065-1-irogers@google.com>
Message-Id: <20240808054644.1286065-2-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240808054644.1286065-1-irogers@google.com>
X-Mailer: git-send-email 2.46.0.rc2.264.g509ed76dc8-goog
Subject: [PATCH v1 2/2] perf test: Add set of perf record LBR tests
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Anne Macedo <retpolanne@posteo.net>, 
	Changbin Du <changbin.du@huawei.com>, Andi Kleen <ak@linux.intel.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Adds coverage for LBR operations and LBR callgraph.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/shell/record_lbr.sh | 161 +++++++++++++++++++++++++++
 1 file changed, 161 insertions(+)
 create mode 100755 tools/perf/tests/shell/record_lbr.sh

diff --git a/tools/perf/tests/shell/record_lbr.sh b/tools/perf/tests/shell/record_lbr.sh
new file mode 100755
index 000000000000..baf168d0ddbb
--- /dev/null
+++ b/tools/perf/tests/shell/record_lbr.sh
@@ -0,0 +1,161 @@
+#!/bin/bash
+# perf record LBR tests
+# SPDX-License-Identifier: GPL-2.0
+
+set -e
+
+if [ ! -f /sys/devices/cpu/caps/branches ]
+then
+  echo "Skip: only x86 CPUs support LBR"
+  exit 2
+fi
+
+err=0
+perfdata=$(mktemp /tmp/__perf_test.perf.data.XXXXX)
+
+cleanup() {
+  rm -rf "${perfdata}"
+  rm -rf "${perfdata}".old
+  rm -rf "${perfdata}".txt
+
+  trap - EXIT TERM INT
+}
+
+trap_cleanup() {
+  cleanup
+  exit 1
+}
+trap trap_cleanup EXIT TERM INT
+
+
+lbr_callgraph_test() {
+  test="LBR callgraph"
+
+  echo "$test"
+  if ! perf record -e cycles --call-graph lbr -o "${perfdata}" perf test -w thloop
+  then
+    echo "$test [Failed support missing]"
+    if [ $err -eq 0 ]
+    then
+      err=2
+    fi
+    return
+  fi
+
+  if ! perf report --stitch-lbr -i "${perfdata}" > "${perfdata}".txt
+  then
+    cat "${perfdata}".txt
+    echo "$test [Failed in perf report]"
+    err=1
+    return
+  fi
+
+  echo "$test [Success]"
+}
+
+lbr_test() {
+  local branch_flags=$1
+  local test="LBR $2 test"
+  local threshold=$3
+  local out
+  local sam_nr
+  local bs_nr
+  local zero_nr
+  local r
+
+  echo "$test"
+  if ! perf record -e cycles $branch_flags -o "${perfdata}" perf test -w thloop
+  then
+    echo "$test [Failed support missing]"
+    perf record -e cycles $branch_flags -o "${perfdata}" perf test -w thloop || true
+    if [ $err -eq 0 ]
+    then
+      err=2
+    fi
+    return
+  fi
+
+  out=$(perf report -D -i "${perfdata}" 2> /dev/null | grep -A1 'PERF_RECORD_SAMPLE')
+  sam_nr=$(echo "$out" | grep -c 'PERF_RECORD_SAMPLE' || true)
+  if [ $sam_nr -eq 0 ]
+  then
+    echo "$test [Failed no samples captured]"
+    err=1
+    return
+  fi
+  echo "$test: $sam_nr samples"
+
+  bs_nr=$(echo "$out" | grep -c 'branch stack: nr:' || true)
+  if [ $sam_nr -ne $bs_nr ]
+  then
+    echo "$test [Failed samples missing branch stacks]"
+    err=1
+    return
+  fi
+
+  zero_nr=$(echo "$out" | grep -c 'branch stack: nr:0' || true)
+  r=$(($zero_nr * 100 / $bs_nr))
+  if [ $r -gt $threshold ]; then
+    echo "$test [Failed empty br stack ratio exceed $threshold%: $r%]"
+    err=1
+    return
+  fi
+
+  echo "$test [Success]"
+}
+
+parallel_lbr_test() {
+  err=0
+  perfdata=$(mktemp /tmp/__perf_test.perf.data.XXXXX)
+  lbr_test "$1" "$2" "$3"
+  cleanup
+  exit $err
+}
+
+lbr_callgraph_test
+
+# Sequential
+lbr_test "-b" "any branch" 2
+lbr_test "-j any_call" "any call" 2
+lbr_test "-j any_ret" "any ret" 2
+lbr_test "-j ind_call" "any indirect call" 2
+lbr_test "-j ind_jmp" "any indirect jump" 100
+lbr_test "-j call" "direct calls" 2
+lbr_test "-j ind_call,u" "any indirect user call" 100
+lbr_test "-a -b" "system wide any branch" 2
+lbr_test "-a -j any_call" "system wide any call" 2
+
+# Parallel
+parallel_lbr_test "-b" "parallel any branch" 100 &
+pid1=$!
+parallel_lbr_test "-j any_call" "parallel any call" 100 &
+pid2=$!
+parallel_lbr_test "-j any_ret" "parallel any ret" 100 &
+pid3=$!
+parallel_lbr_test "-j ind_call" "parallel any indirect call" 100 &
+pid4=$!
+parallel_lbr_test "-j ind_jmp" "parallel any indirect jump" 100 &
+pid5=$!
+parallel_lbr_test "-j call" "parallel direct calls" 100 &
+pid6=$!
+parallel_lbr_test "-j ind_call,u" "parallel any indirect user call" 100 &
+pid7=$!
+parallel_lbr_test "-a -b" "parallel system wide any branch" 100 &
+pid8=$!
+parallel_lbr_test "-a -j any_call" "parallel system wide any call" 100 &
+pid9=$!
+
+for pid in $pid1 $pid2 $pid3 $pid4 $pid5 $pid6 $pid7 $pid8 $pid9
+do
+  set +e
+  wait $pid
+  child_err=$?
+  set -e
+  if ([ $err -eq 2 ] && [ $child_err -eq 1 ]) || [ $err -eq 0 ]
+  then
+    err=$child_err
+  fi
+done
+
+cleanup
+exit $err
-- 
2.46.0.rc2.264.g509ed76dc8-goog

