Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46D4526B743
	for <linux-perf-users@vger.kernel.org>; Tue, 24 Jun 2025 23:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750807150; cv=none; b=kmrrLmdNRVjH7GhhzictpzjH49MhIstfwEXwH0wjboBwsJhsMKHwoIJdHLZvvYYUKUYH2wLDmqdrT5CIhkWaOw9XmRGb7kB6OJAqLF/T+ECd+EiEnD17j7awcUPnZ96TK8ZeFJZCPdx2e1UgZacqMTPZlrm3VVGtJl/GgYLtj1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750807150; c=relaxed/simple;
	bh=Ov7KYM5urbb+duQlFNaUQMctYTgtbQGKJ1mEoTEkiAk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=O3vqIK2mnQGuDnrp0dmGsiw0EdfPZ5ywobnwh0bVp3mgm86IPOaljFBUECE5B8wwX56U7mXPEdYwFKoclCx1oVV7MUrb9idlLEr5gx8+DL+yaorb253lWymxO8x70/BEzhtZO4JuOZaDtx1xB8wjE74seO2G4iElKvomZ4cs7ck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=StgIEZNo; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="StgIEZNo"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-740774348f6so536905b3a.1
        for <linux-perf-users@vger.kernel.org>; Tue, 24 Jun 2025 16:19:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1750807148; x=1751411948; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=B1kPy2JCJb4zSJWeggG32MlvxkW2zq73XjOq2Ztu1jk=;
        b=StgIEZNotgRr9KbKx1Hkb8wAaV2I80CrDLcL8H+MAojsJn6LXNJ1iKHEyYiGeypeij
         HTKFJsQ1FA/4jqcKChjtGrxjQY37MngWgANyuvZLwAWHLGi8vwy7e/Y7nPaTdjh40FBi
         TzS9L8m51/MRflJ2WQk0QmJY6eK4nYyOTcKh2p9GsFGR28QMyOcJ7hBGk6XjxO5yr2CT
         wyYk/KLgfXN4W6mHBzEN/yQ9eEG+m2yVFqNtmTUJmJsvk4xrSu2UHavbQ6ORSLtNxG9I
         qXu2SDBDJUGnlU623uJbgzCgS/dq4XXtkSYrbGCnL90yJhSbNdlD6lITncc2B09YBVxl
         P+TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750807148; x=1751411948;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=B1kPy2JCJb4zSJWeggG32MlvxkW2zq73XjOq2Ztu1jk=;
        b=gHXAWTnXRvTShLNCyvWSXYaW5duVKsclId7b9vMECshnQFm3VbAhdvZywFg0qmxK66
         RE1LBIC7IRAF5iTFG+UotI+POOVYSZJ9plFCgViAsqhlaodGne9MxOcVxihXwBbLtq4t
         WsndenYwn4/MhurFxILDikArqtdkX0XZHzDSjQp3w3hxL6V349E7Kh+lzepAYR4XtlaT
         hA8rbspu36AxZUPuFTjF+XoEkLD+AWyt3xVkWgU/D6W8j4Ajx1A789eMDmXlHBY8YszR
         syeREnu6wdr/Y48/awMrBFY94aCCStND1DCPJPLh0vV9Ottks5uYNna+3/x9la22s7uA
         oTFA==
X-Forwarded-Encrypted: i=1; AJvYcCUB39/ogSzyRDlO2/+LBQHoL5pWgPMP3g+DB7n354qb+xgRGmqF4pzjDRJDCSuGT9ufrTwvdJgUpOHjVcSDvH/p@vger.kernel.org
X-Gm-Message-State: AOJu0YwcsPmJK2g7qs82iixn3QydQGSX6QaODjWkmRJLKRNREr/y7tHF
	O0b5lFz2MLtUFHXKLkiPH4cX3jUTZJ4nlGxXECGlx6R5wGvNhChREYv+gOOuQL85tLFB32cTa/a
	ZY2LfspNHAw==
X-Google-Smtp-Source: AGHT+IFM/3RFuKFIfuGzUEOUqlkqwyLCKg/Cqd+4H1d7Z9aSC+KCwBKw4SxuPZ/gbvXQWKoQuXWIxobHNqhB
X-Received: from pfbfa15.prod.google.com ([2002:a05:6a00:2d0f:b0:749:2cc7:bd89])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:1826:b0:748:fcfa:8bd5
 with SMTP id d2e1a72fcca58-74ad4462622mr1658511b3a.3.1750807148521; Tue, 24
 Jun 2025 16:19:08 -0700 (PDT)
Date: Tue, 24 Jun 2025 16:18:37 -0700
In-Reply-To: <20250624231837.179536-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250624231837.179536-1-irogers@google.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250624231837.179536-4-irogers@google.com>
Subject: [PATCH v4 3/3] perf tests: Add a DRM PMU test
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>, James Clark <james.clark@linaro.org>, 
	Weilin Wang <weilin.wang@intel.com>, Dominique Martinet <asmadeus@codewreck.org>, 
	Thomas Richter <tmricht@linux.ibm.com>, Junhao He <hejunhao3@huawei.com>, 
	Jean-Philippe Romain <jean-philippe.romain@foss.st.com>, matthew.olson@intel.com, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	dri-devel@lists.freedesktop.org
Cc: Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"

The test opens any DRM devices so that the shell has fdinfo files
containing the DRM data. The test then uses perf stat to make sure the
events can be read.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/shell/drm_pmu.sh | 78 +++++++++++++++++++++++++++++++
 1 file changed, 78 insertions(+)
 create mode 100755 tools/perf/tests/shell/drm_pmu.sh

diff --git a/tools/perf/tests/shell/drm_pmu.sh b/tools/perf/tests/shell/drm_pmu.sh
new file mode 100755
index 000000000000..e629fe0e8463
--- /dev/null
+++ b/tools/perf/tests/shell/drm_pmu.sh
@@ -0,0 +1,78 @@
+#!/bin/bash
+# DRM PMU
+# SPDX-License-Identifier: GPL-2.0
+
+set -e
+
+output=$(mktemp /tmp/perf.drm_pmu.XXXXXX.txt)
+
+cleanup() {
+  rm -f "${output}"
+
+  trap - EXIT TERM INT
+}
+
+trap_cleanup() {
+  echo "Unexpected signal in ${FUNCNAME[1]}"
+  cleanup
+  exit 1
+}
+trap trap_cleanup EXIT TERM INT
+
+# Array to store file descriptors and device names
+declare -A device_fds
+
+# Open all devices and store file descriptors. Opening the device will create a
+# /proc/$$/fdinfo file containing the DRM statistics.
+fd_count=3 # Start with file descriptor 3
+for device in /dev/dri/*
+do
+  if [[ ! -c "$device" ]]
+  then
+    continue
+  fi
+  major=$(stat -c "%Hr" "$device")
+  if [[ "$major" != 226 ]]
+  then
+    continue
+  fi
+  echo "Opening $device"
+  eval "exec $fd_count<\"$device\""
+  echo "fdinfo for: $device (FD: $fd_count)"
+  cat "/proc/$$/fdinfo/$fd_count"
+  echo
+  device_fds["$device"]="$fd_count"
+  fd_count=$((fd_count + 1))
+done
+
+if [[ ${#device_fds[@]} -eq 0 ]]
+then
+  echo "No DRM devices found [Skip]"
+  cleanup
+  exit 2
+fi
+
+# For each DRM event
+err=0
+for p in $(perf list --raw-dump drm-)
+do
+  echo -n "Testing perf stat of $p. "
+  perf stat -e "$p" --pid=$$ true > "$output" 2>&1
+  if ! grep -q "$p" "$output"
+  then
+    echo "Missing DRM event in: [Failed]"
+    cat "$output"
+    err=1
+  else
+    echo "[OK]"
+  fi
+done
+
+# Close all file descriptors
+for fd in "${device_fds[@]}"; do
+  eval "exec $fd<&-"
+done
+
+# Finished
+cleanup
+exit $err
-- 
2.50.0.727.gbf7dc18ff4-goog

