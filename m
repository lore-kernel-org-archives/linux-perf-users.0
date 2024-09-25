Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 627331BC59
	for <linux-perf-users@vger.kernel.org>; Wed, 25 Sep 2024 17:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727285420; cv=none; b=BONSb2VQDt7hV6EXq+vuEJIb/r80KOEHj1Zs+3dUvfemMEiEQfUfAv08xcuvpLM1GwvJbQE1a7A9IrmXl4snoTSOlK8kNasuC3Vmg1rf/oRdzOTwJYTOEuFae7KedfT+RCY6xjuVePbEuEREoERQnpy2d1aoIsroeES40dP94K8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727285420; c=relaxed/simple;
	bh=6lMrxe8sCTgBy01/mf9iIpgXaSX/UU8ZeE/q0YQhcj4=;
	h=Date:Message-Id:Mime-Version:Subject:From:To:Content-Type; b=BWXcb+WV4YMFyUSJgqgDPBya0HAKejC1VLbcet2NOkzOhxi/ePjVnUnsq65iVYDY/ge4oWa/42yA0WRA7K+gpqVG5hl8pnB7Mt/o799gC5SIXrQ/z+TYEE9/3q4eecg/fovmxXHo+DKXoDzsuUllnY5oR+JldTuvt8j6AiZoLII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PrSwGy9S; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PrSwGy9S"
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e201a37e5a4so164765276.0
        for <linux-perf-users@vger.kernel.org>; Wed, 25 Sep 2024 10:30:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727285417; x=1727890217; darn=vger.kernel.org;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=o7mmItE13oyNMD526yrDEYQPSrEQwCMg1pQdM7EvhJM=;
        b=PrSwGy9SQzZJ91muSfew88JRed98LJr50YV/sIQG40NdjkUzZ4391Xok56sJLlLNyt
         S8cNn4ekjIIvQ0O7LZnxQepjHbp0s6peccS/vo93ywgIosWPb2eRKyNi/XjKL8TTXHTV
         NySj5hwukjN/zyJdPqvgRiH+xPjfeHo2hwRXnRTqIF7gouWskR+m8wBHb+oUsbSg1JzK
         qOI0cAK8zNhyxjENDrTqVcQmrhefGA5+H9KdNaLuTqbc9GCRL6V+YSaNzE2CQnBtBpad
         XmcnviCfq2Hb2/z+lQ1koT7eiV/xuU0EkRl7Z2r7MUMFyuvq8umUcbbagVeIFHN5adGF
         x3LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727285417; x=1727890217;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=o7mmItE13oyNMD526yrDEYQPSrEQwCMg1pQdM7EvhJM=;
        b=kXwMAKWklY67L75eK1ZaFoJR91MbiCFL4468Pfg3ZIwu7GjqOOJTtS5SmaElfVwSZ1
         Y9T0eLfKjGl0JQGp4ax7I7709UQoe6yHIEJfTnmhHM7Y01qbLXRPISt+E0hIxlBCyt38
         f4NiDoaDf8HfnYBmKQV0HZBMRynuv09c3Pf8NA05QsqD3TWrw74HKoygPMKlwz9Rh0co
         SELH5hLbe31grdyDe68R5JFe1F+E7I2jcjAi2GJEu/kfBJ25j8dBXof/yhzROmozpyqf
         piJ7GMp6Xi5Jz2OEduQ9NRFQgf99Igtvbsn7m4Cc3WEMfrj3P3gr23d1w42HBHvvazVB
         PuHw==
X-Forwarded-Encrypted: i=1; AJvYcCUyPAYG68uDBYeHRQ6dDnHEuHsh0uHzSWQq5Hm4A8bZ9RKFYe/CSFMlriSyBTYxx/MN2V3HR0roPbSX3FBtT/wl@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0PwXCRXEzElbQOywJVLw4WbtRDfdKEuJUv+66B3V/ed9R6lKF
	sN6c1GbEU5HQVEBkQGDJkcs/Y0t+Hrim4OHgdH8SZ/6MeLuY7zTNmstBtUW2uc9W2Zxy91qXe0E
	f+S9LTg==
X-Google-Smtp-Source: AGHT+IFzc5fJx3iARQ8up/ouMLSTHLgHfuFoYepAgqOopOfeUM/50KEXWyClxZLUzhVg2ZRNel7VH9IHzDjz
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:965e:4297:88a9:5902])
 (user=irogers job=sendgmr) by 2002:a05:6902:292:b0:e25:2491:d005 with SMTP id
 3f1490d57ef6-e252491d211mr2442276.8.1727285417021; Wed, 25 Sep 2024 10:30:17
 -0700 (PDT)
Date: Wed, 25 Sep 2024 10:30:13 -0700
Message-Id: <20240925173013.12789-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.46.0.792.g87dc391469-goog
Subject: [PATCH v1] perf test: Ignore security failures in all PMU test
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Colin Ian King <colin.i.king@gmail.com>, 
	Athira Jajeev <atrajeev@linux.vnet.ibm.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Refactor code to have some more error diagnosis on traps, etc. and to
do less work on each line. Add an ignore situation for security failures.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/shell/stat_all_pmu.sh | 52 ++++++++++++++++++++------
 1 file changed, 40 insertions(+), 12 deletions(-)

diff --git a/tools/perf/tests/shell/stat_all_pmu.sh b/tools/perf/tests/shell/stat_all_pmu.sh
index d2a3506e0d19..42456d89c5da 100755
--- a/tools/perf/tests/shell/stat_all_pmu.sh
+++ b/tools/perf/tests/shell/stat_all_pmu.sh
@@ -1,23 +1,51 @@
-#!/bin/sh
+#!/bin/bash
 # perf all PMU test
 # SPDX-License-Identifier: GPL-2.0
 
 set -e
+err=0
+result=""
+
+trap_cleanup() {
+  echo "Unexpected signal in ${FUNCNAME[1]}"
+  echo "$result"
+  exit 1
+}
+trap trap_cleanup EXIT TERM INT
 
 # Test all PMU events; however exclude parameterized ones (name contains '?')
-for p in $(perf list --raw-dump pmu | sed 's/[[:graph:]]\+?[[:graph:]]\+[[:space:]]//g'); do
+for p in $(perf list --raw-dump pmu | sed 's/[[:graph:]]\+?[[:graph:]]\+[[:space:]]//g')
+do
   echo "Testing $p"
   result=$(perf stat -e "$p" true 2>&1)
-  if ! echo "$result" | grep -q "$p" && ! echo "$result" | grep -q "<not supported>" ; then
-    # We failed to see the event and it is supported. Possibly the workload was
-    # too small so retry with something longer.
-    result=$(perf stat -e "$p" perf bench internals synthesize 2>&1)
-    if ! echo "$result" | grep -q "$p" ; then
-      echo "Event '$p' not printed in:"
-      echo "$result"
-      exit 1
-    fi
+  if echo "$result" | grep -q "$p"
+  then
+    # Event seen in output.
+    continue
+  fi
+  if echo "$result" | grep -q "<not supported>"
+  then
+    # Event not supported, so ignore.
+    continue
+  fi
+  if echo "$result" | grep -q "Access to performance monitoring and observability operations is limited."
+  then
+    # Access is limited, so ignore.
+    continue
+  fi
+
+  # We failed to see the event and it is supported. Possibly the workload was
+  # too small so retry with something longer.
+  result=$(perf stat -e "$p" perf bench internals synthesize 2>&1)
+  if echo "$result" | grep -q "$p"
+  then
+    # Event seen in output.
+    continue
   fi
+  echo "Error: event '$p' not printed in:"
+  echo "$result"
+  err=1
 done
 
-exit 0
+trap - EXIT TERM INT
+exit $err
-- 
2.46.0.792.g87dc391469-goog

