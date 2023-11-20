Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TywSXqEv"
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 126FCD9
	for <linux-perf-users@vger.kernel.org>; Mon, 20 Nov 2023 11:04:14 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5c9f34703ebso21910667b3.1
        for <linux-perf-users@vger.kernel.org>; Mon, 20 Nov 2023 11:04:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1700507053; x=1701111853; darn=vger.kernel.org;
        h=cc:to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=NwegP4grp+NKVnXxnLCbPPhC1AoQpO7Vl3AwS2tf1V0=;
        b=TywSXqEvMpo5ZbZuXWqr18X4YXCVS6DIXbLqZQq38nST77LY4YihWyoVsW4V9hLNEN
         IU0m2q02LZeVounQQk5uMDWd+ky1U+qJAIAwI90ovxUpbxzLk2pkLyU9RRCuhp622qKA
         OKD+FU/kbYrL79cXE7g29//7sGIZb2bW0U6TStW2S0IKUiSGMYSjpWYrSyX3soKVTXcM
         D8kIbOwYzzPRBtaYxWW9XaAVmKevuE0rVKkpErAuVfWmapXB5Hl4chT4fHCTFcIlyheH
         /nNdmiKg7QnPpSomfOqfIcihXwxcTKmeZZvi0uxZW3we596GY3ps6SZt3W623SOciLxn
         AKqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700507053; x=1701111853;
        h=cc:to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NwegP4grp+NKVnXxnLCbPPhC1AoQpO7Vl3AwS2tf1V0=;
        b=whNl5E9vLYGLNmRKQUAOORlLKMX79VM77C8R0+cfhdfDK8dP28M8uxMOGPvdWQKLhm
         MZwXG2UcghGtq0GMUeQ3kvvmhbtruEblV5lBgq/jBwYlRPfA8MoiCW7kNGImORHC78/V
         uVjIzy5h+rS2oUInGlpdW4R9IekkneiUQTptVkWeK38upi3rYqV8Q/s0CY6gd/EZVDoX
         V+DNitfoWpfqIHxHjwbP4OCFpkgqczU7hr8udsNwFtFBb9knY1QSkSLEqqfAkPw5nr2D
         LRYci3Z6DpeSqXmB+NHmuXVHIi6dTlpTN3q8gzMs19qZaaqk5y0PNW8U9jJCkzrfWZaC
         5rnw==
X-Gm-Message-State: AOJu0YxDX8dT9JHg0dMNzut+FXFM2gQ7HkSlZ/tONj0KHfxpF6AraSge
	JHKtO1kcebUbonqty3YaV9vdXDezG2NF
X-Google-Smtp-Source: AGHT+IGW9SCeYhNevQuiBWINPc7ABYMlEDWVxjfLt0OfeZ0gvhANIZO2KmcWZfOBL//9RfVl2axpoFhRQ4f3
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:274d:270:40a9:df3f])
 (user=irogers job=sendgmr) by 2002:a81:6dc9:0:b0:59b:c6bb:bab9 with SMTP id
 i192-20020a816dc9000000b0059bc6bbbab9mr227590ywc.3.1700507053127; Mon, 20 Nov
 2023 11:04:13 -0800 (PST)
Date: Mon, 20 Nov 2023 11:04:08 -0800
Message-Id: <20231120190408.281826-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.43.0.rc1.413.gea7ed67945-goog
Subject: [PATCH v1] perf test: Add basic perf diff test
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	atrajeev@linux.vnet.ibm.com
Cc: Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"

There are some old bug reports on perf diff crashing:
https://rhaas.blogspot.com/2012/06/perf-good-bad-ugly.html

Happening across them I was prompted to add two very basic tests that
will give some perf diff coverage.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/shell/diff.sh | 101 +++++++++++++++++++++++++++++++++
 1 file changed, 101 insertions(+)
 create mode 100755 tools/perf/tests/shell/diff.sh

diff --git a/tools/perf/tests/shell/diff.sh b/tools/perf/tests/shell/diff.sh
new file mode 100755
index 000000000000..213185763688
--- /dev/null
+++ b/tools/perf/tests/shell/diff.sh
@@ -0,0 +1,101 @@
+#!/bin/sh
+# perf diff tests
+# SPDX-License-Identifier: GPL-2.0
+
+set -e
+
+err=0
+perfdata1=$(mktemp /tmp/__perf_test.perf.data.XXXXX)
+perfdata2=$(mktemp /tmp/__perf_test.perf.data.XXXXX)
+perfdata3=$(mktemp /tmp/__perf_test.perf.data.XXXXX)
+testprog="perf test -w thloop"
+testsym="test_loop"
+
+cleanup() {
+  rm -rf "${perfdata1}"
+  rm -rf "${perfdata1}".old
+  rm -rf "${perfdata2}"
+  rm -rf "${perfdata2}".old
+  rm -rf "${perfdata3}"
+  rm -rf "${perfdata3}".old
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
+make_data() {
+  file="$1"
+  if ! perf record -o "${file}" ${testprog} 2> /dev/null
+  then
+    echo "Workload record [Failed record]"
+    echo 1
+    return
+  fi
+  if ! perf report -i "${file}" -q | grep -q "${testsym}"
+  then
+    echo "Workload record [Failed missing output]"
+    echo 1
+    return
+  fi
+  echo 0
+}
+
+test_two_files() {
+  echo "Basic two file diff test"
+  err=$(make_data "${perfdata1}")
+  if [ $err != 0 ]
+  then
+    return
+  fi
+  err=$(make_data "${perfdata2}")
+  if [ $err != 0 ]
+  then
+    return
+  fi
+
+  if ! perf diff "${perfdata1}" "${perfdata2}" | grep -q "${testsym}"
+  then
+    echo "Basic two file diff test [Failed diff]"
+    err=1
+    return
+  fi
+  echo "Basic two file diff test [Success]"
+}
+
+test_three_files() {
+  echo "Basic three file diff test"
+  err=$(make_data "${perfdata1}")
+  if [ $err != 0 ]
+  then
+    return
+  fi
+  err=$(make_data "${perfdata2}")
+  if [ $err != 0 ]
+  then
+    return
+  fi
+  err=$(make_data "${perfdata3}")
+  if [ $err != 0 ]
+  then
+    return
+  fi
+
+  if ! perf diff "${perfdata1}" "${perfdata2}" "${perfdata3}" | grep -q "${testsym}"
+  then
+    echo "Basic three file diff test [Failed diff]"
+    err=1
+    return
+  fi
+  echo "Basic three file diff test [Success]"
+}
+
+test_two_files
+test_three_files
+
+cleanup
+exit $err
-- 
2.43.0.rc1.413.gea7ed67945-goog

