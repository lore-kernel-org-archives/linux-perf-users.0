Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3252EA59
	for <linux-perf-users@vger.kernel.org>; Sat, 13 Sep 2025 00:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757721836; cv=none; b=VHXrNvho4ZKFQETWbBysaPQWSvp4ypBIaFron2CisNPjLoieZflryg+3NqLl2oBChLlePzRWfY0aqkLbSsPNjZEKCMsKtoi0KQZ6cUsC3JqI1IIPn8ZTS+5lxqNwkZsx8/U9xsJOvixpiMQLFL7Z7I52A+C3y84wxYKGKA2AhrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757721836; c=relaxed/simple;
	bh=xjuKjiVqJX6eHw8ecLDBYxZBLIMvaoJjU4fHBbv+9hI=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Content-Type; b=eY9uS4KL1wl6IkYqbpThZb8NA8Xqu9jEohQJVn61M3hOP6J7XM/CWshat/vdc3qfu829r39l6lW3TObD2X9M+iF778fmWW91eg1INfBgUOC2Bkg2xrIYoGmNMrgcQqJhdPtVJj18uvTj/FeO/boGIBEHCEviWjuOguhBSN6aE2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=y43Tsd7Y; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="y43Tsd7Y"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-329cb4c3f78so2149464a91.2
        for <linux-perf-users@vger.kernel.org>; Fri, 12 Sep 2025 17:03:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757721834; x=1758326634; darn=vger.kernel.org;
        h=to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=jr/ZyQpMuwCkS6hGWvr6Oh7/2P565uCcJHUQwJJxE/k=;
        b=y43Tsd7Yzh2fMCbej270dmBx+kSoc1T1I4xsSqd5j8aNPTN1m9VSSSGbqPzcGjEuGW
         FZLMz5/4zsFVI8YqGHLGUFcHiIaWkogRy29LdG1naQecicX5Dd9Rt6o9AU4zqA02k6/n
         0NF9nYE/zVzocNpiu4jqPOuyIPRUY11OypjVYQ4o/p+MhpG6M+RlX6tF4drOUUrXtirj
         jdAhW7FPyXf4fHnRhgSLQ6/BSXeqB6twQ8iUuv7thQjJuWXS0Wu2s9ZB3LgWyQzWIWQ+
         vW2mgaUM+1r205FXQ55AD95uThoaMROTXz7bwlqnvpFkBEbouXoVcHz2Cd2/5UcZded8
         cnSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757721834; x=1758326634;
        h=to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jr/ZyQpMuwCkS6hGWvr6Oh7/2P565uCcJHUQwJJxE/k=;
        b=LzHDDpP1RvkHUSd/Wrurm0j9prKAN7vn3CbTE24f/ny6pYgXYVKBQIP98w3URwOxuM
         KXeDW3f7aG8O9gVRlSgcjEn3VLtHRqYWrw7ESgNqkyps+IGYNbi6rOUvBYydZ72levQb
         F4jS5eqn8e7quuScRDYpxLQzXdMhsbeDlNuOFN8wMRxUZBhhAWaOvgE7z7m503CAS4JM
         E6Yjx1I796e2aELTKsh27R8nscLd6qsEqZ0uGn8hPMFJfwx8H0QeoPErqAdiLp/9/BhN
         GqGyT87U9PY0WD5l0fyUYbytiu7ripCXZoPMLHmPqbgITku4YwENCcBwLmJax1ATb9kx
         25lg==
X-Forwarded-Encrypted: i=1; AJvYcCU721gXmt3MyVqXaZNjm57Dapjzk2ZpWCxllNe9uefRzVL6vOsb3rrPnKjdGK8gmHbVdhRhFCO/vnGj8HGtHC7f@vger.kernel.org
X-Gm-Message-State: AOJu0YzQq3C9AwttGZtJsp0YrOTf1gVq1A0LGKUm8mda8CwgV6FtjjQm
	Hh6fZZ/TnDOivNzBEi8NB8Pt1bNbZ4sf+h7vkPVZCm+6GV+zE/pA1IrzCLOTCNdQ0WhjPLHPn3s
	K2IQWc7nxlA==
X-Google-Smtp-Source: AGHT+IGd9z4OG9fxaRSlyZXTQsGysodbz7W42EnwO0jhir+Q9KtpwhD8PisQnAt8cbntizhQ1gX/ZUJie2ep
X-Received: from pjwx7.prod.google.com ([2002:a17:90a:c2c7:b0:327:d54a:8c93])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:1dd1:b0:329:d85b:d9ee
 with SMTP id 98e67ed59e1d1-32de4f87a6emr5044153a91.23.1757721834482; Fri, 12
 Sep 2025 17:03:54 -0700 (PDT)
Date: Fri, 12 Sep 2025 17:03:50 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.0.384.g4c02a37b29-goog
Message-ID: <20250913000350.1306948-1-irogers@google.com>
Subject: [PATCH v3] perf test: AMD IBS swfilt skip kernel tests if paranoia is >1
From: Ian Rogers <irogers@google.com>
To: Ravi Bangoria <ravi.bangoria@amd.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Collin Funk <collin.funk1@gmail.com>, 
	James Clark <james.clark@linaro.org>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

If not root and the perf_event_paranoid is set >1 swfilt will fail to
open the event failing the test. Add check to skip the test in that
case.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/shell/amd-ibs-swfilt.sh | 51 ++++++++++++++++++------
 1 file changed, 38 insertions(+), 13 deletions(-)

diff --git a/tools/perf/tests/shell/amd-ibs-swfilt.sh b/tools/perf/tests/shell/amd-ibs-swfilt.sh
index 7045ec72ba4c..e7f66df05c4b 100755
--- a/tools/perf/tests/shell/amd-ibs-swfilt.sh
+++ b/tools/perf/tests/shell/amd-ibs-swfilt.sh
@@ -1,6 +1,10 @@
 #!/bin/bash
 # AMD IBS software filtering
 
+ParanoidAndNotRoot() {
+  [ "$(id -u)" != 0 ] && [ "$(cat /proc/sys/kernel/perf_event_paranoid)" -gt $1 ]
+}
+
 echo "check availability of IBS swfilt"
 
 # check if IBS PMU is available
@@ -16,6 +20,7 @@ if [ ! -f /sys/bus/event_source/devices/ibs_op/format/swfilt ]; then
 fi
 
 echo "run perf record with modifier and swfilt"
+err=0
 
 # setting any modifiers should fail
 perf record -B -e ibs_op//u -o /dev/null true 2> /dev/null
@@ -31,11 +36,17 @@ if [ $? -ne 0 ]; then
     exit 1
 fi
 
-# setting it with swfilt=1 should be fine
-perf record -B -e ibs_op/swfilt=1/k -o /dev/null true
-if [ $? -ne 0 ]; then
-    echo "[FAIL] IBS op PMU cannot handle swfilt for exclude_user"
-    exit 1
+if ! ParanoidAndNotRoot 1
+then
+    # setting it with swfilt=1 should be fine
+    perf record -B -e ibs_op/swfilt=1/k -o /dev/null true
+    if [ $? -ne 0 ]; then
+        echo "[FAIL] IBS op PMU cannot handle swfilt for exclude_user"
+        exit 1
+    fi
+else
+    echo "[SKIP] not root and perf_event_paranoid too high for exclude_user"
+    err=2
 fi
 
 # check ibs_fetch PMU as well
@@ -46,10 +57,16 @@ if [ $? -ne 0 ]; then
 fi
 
 # check system wide recording
-perf record -aB --synth=no -e ibs_op/swfilt/k -o /dev/null true
-if [ $? -ne 0 ]; then
-    echo "[FAIL] IBS op PMU cannot handle swfilt in system-wide mode"
-    exit 1
+if ! ParanoidAndNotRoot 0
+then
+    perf record -aB --synth=no -e ibs_op/swfilt/k -o /dev/null true
+    if [ $? -ne 0 ]; then
+        echo "[FAIL] IBS op PMU cannot handle swfilt in system-wide mode"
+        exit 1
+    fi
+else
+    echo "[SKIP] not root and perf_event_paranoid too high for system-wide/exclude_user"
+    err=2
 fi
 
 echo "check number of samples with swfilt"
@@ -60,8 +77,16 @@ if [ ${kernel_sample} -ne 0 ]; then
     exit 1
 fi
 
-user_sample=$(perf record -e ibs_fetch/swfilt/k -o- true | perf script -i- -F misc | grep -c ^U)
-if [ ${user_sample} -ne 0 ]; then
-    echo "[FAIL] unexpected user samples: " ${user_sample}
-    exit 1
+if ! ParanoidAndNotRoot 1
+then
+    user_sample=$(perf record -e ibs_fetch/swfilt/k -o- true | perf script -i- -F misc | grep -c ^U)
+    if [ ${user_sample} -ne 0 ]; then
+        echo "[FAIL] unexpected user samples: " ${user_sample}
+        exit 1
+    fi
+else
+    echo "[SKIP] not root and perf_event_paranoid too high for exclude_user"
+    err=2
 fi
+
+exit $err
-- 
2.51.0.384.g4c02a37b29-goog

