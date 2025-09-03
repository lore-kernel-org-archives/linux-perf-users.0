Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E3BA368092
	for <linux-perf-users@vger.kernel.org>; Wed,  3 Sep 2025 18:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756924981; cv=none; b=ruPq55nTrdEbN2azecNAOrcdfYszyugUJywH+oEIDeDNJ4nkE7H/TJlJjEdiz5Ffkf0NdIg0mCM8hvkqphvb/vvOkV5YgL7LiaR3lhxxo1JwosbvwMjRQ1wNk61Rwrx0EmCsocrm/CcUt4iMd+ZCqjSfJsFxhjSX0kUwh1jDVHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756924981; c=relaxed/simple;
	bh=Dp47Bw4LhXp29qV4lfEDG5HOY3Q+6+YPzTiMrwpA2DA=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Content-Type; b=NPLPHqJDfhKimCxiMxQgiaRc+VQq7hSskjCq1GndMLAcnZMUIp78+64MKnFxxDYf9hbuvpMySkXNYoqouyCg4uZws7kGZYNpsT0JXMc17XhwC7pbq++oUfLinKT64ukwwmS+uAJ9VPgQSmGCt8gR8o0/Xr5W+gGolozifjKTVUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4Tn/UbA3; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4Tn/UbA3"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-32811874948so97571a91.2
        for <linux-perf-users@vger.kernel.org>; Wed, 03 Sep 2025 11:42:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756924979; x=1757529779; darn=vger.kernel.org;
        h=to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=l5aN7djIkkUT2sBdfyx1qSEcAbRYo6zyioJkgOjgjEc=;
        b=4Tn/UbA3LOeB5b6sjrsE7M+vzZAoP5N0HnjlMs43Kzq236kDoA/IpCfNQkbzntQkuM
         ++dYvMjPvcheBKSJOZ9GkKD90JcG4zAFlC920FcD7vG0cefq0vvg+kpVINuSeWbbG3Vu
         jZzSYnXVBn/tAHT51Dw+eHotTtfp4iR6PV9qNcc/be1RRhO+d8u4t8TUTj1KjCwFrO85
         8P3VgIJgyInBfML/LXriLQDzIPaaWMb601+RuGQXHq326c3SpeHUAHNwILcDBm/0DEj9
         eYWAcCaG91Ctu8WKm6pNfwA9yv65BfRb+8llYdkKt/Cz6PeBNEBFojBhN4pcoIYvE5hD
         G5eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756924979; x=1757529779;
        h=to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=l5aN7djIkkUT2sBdfyx1qSEcAbRYo6zyioJkgOjgjEc=;
        b=J6mOa2/iBpz+vx9bzWU6TudeWyEXd45+si0/I3rpkRkqV+wWRNJFTFPI8TSyAUwMG2
         xBeHMwy0Nc1qvFA2DKyD1vGNopvTOcSeJCBtJ9LdD8/GrZwukB9wFqRUhmX3EdyQLoJc
         6aev+ZJZws5JYZUTZJVZDyL4kXVDr+keP7GQXBmQEEOlLm/N6Pt16daHnEsOehP1c1mF
         usWYTUhnWAlRFrLIlGM4sXfbDYLAQIx5KCVbRBsjBqz7LCq5eiIJfuoQXY3cYztbpohQ
         J8cW4+V7YmPxoLMA0UH8PKNUrcoONH/ZMlh3GPxUW9qzhxLCrxUI6yVUt7wCZKpTdxCC
         Cvdw==
X-Forwarded-Encrypted: i=1; AJvYcCU7v8QpetkIcKHEDwyM6q46OjbS3lyQDwiMtCf+YdmeFhrDIiqmW8zkQwQrHT2TSXr5Pxu8Uqz8YRzl9V6RN615@vger.kernel.org
X-Gm-Message-State: AOJu0YwU+6JqhcoMXEpbFRgA7a1WQNs60qNiooCCqGXC5gp8J+Bl8z9j
	7P6gCilxPlIuTS91r7epqIw4ZPqLe7pir6J17nqPGzbieNDPcCOSDUobMHOSiTiln/H5BSnl7f9
	hsZQs1kSESQ==
X-Google-Smtp-Source: AGHT+IE82ZLItzbcwVjR6xjPMcTS9kABRExAjPt9nXLxYjTqAax/qoSHCG+MF4EpCY9h8hZnLVp7XgNX2Loz
X-Received: from pjad23.prod.google.com ([2002:a17:90a:1117:b0:329:7289:8bdb])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:1a8b:b0:327:e8d0:cb18
 with SMTP id 98e67ed59e1d1-328156cc9f7mr20206450a91.29.1756924978715; Wed, 03
 Sep 2025 11:42:58 -0700 (PDT)
Date: Wed,  3 Sep 2025 11:42:47 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.0.338.gd7d06c2dae-goog
Message-ID: <20250903184248.695267-1-irogers@google.com>
Subject: [PATCH v1 1/2] perf test: Add an 'import perf' test shell script
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@linaro.org>, 
	Collin Funk <collin.funk1@gmail.com>, Ravi Bangoria <ravi.bangoria@amd.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

The 'import perf' test needs to set up a path to the python module as
well as to know the python command to invoke. These are hard coded at
build time to be build a directory and the python used in the build,
which is less than desirable. Avoid the hard coded values by reusing
the existing shell script python setup and determine a potential built
python module via the path of the perf executable.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/shell/python-use.sh | 36 ++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)
 create mode 100755 tools/perf/tests/shell/python-use.sh

diff --git a/tools/perf/tests/shell/python-use.sh b/tools/perf/tests/shell/python-use.sh
new file mode 100755
index 000000000000..fd2ee5390060
--- /dev/null
+++ b/tools/perf/tests/shell/python-use.sh
@@ -0,0 +1,36 @@
+#!/bin/bash
+# 'import perf' in python
+# SPDX-License-Identifier: GPL-2.0
+# Just test if we can load the python binding.
+set -e
+
+shelldir=$(dirname "$0")
+# shellcheck source=lib/setup_python.sh
+. "${shelldir}"/lib/setup_python.sh
+
+MODULE_DIR=$(dirname "$(which perf)")/python
+
+if [ -d "$MODULE_DIR" ]
+then
+    CMD=$(cat <<EOF
+import sys
+sys.path.insert(0, '$MODULE_DIR')
+import perf
+print('success!')
+EOF
+    )
+else
+    CMD=$(cat <<EOF
+import perf
+print('success!')
+EOF
+    )
+fi
+
+echo -e "Testing 'import perf' with:\n$CMD"
+
+if ! echo "$CMD" | $PYTHON | grep -q "success!"
+then
+  exit 1
+fi
+exit 0
-- 
2.51.0.338.gd7d06c2dae-goog

