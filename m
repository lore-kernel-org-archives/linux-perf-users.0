Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10DE02770B
	for <linux-perf-users@vger.kernel.org>; Tue, 13 May 2025 21:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747173578; cv=none; b=eZ142CuLroLnWybJJFN9CT7zsQ+bdfbC0r+IKyWFY2LM6mXv8vhIB5+OgJLU6B/c2FvCsZPwuhspAgS7VzSG4hDZFwdsjHhDymRNdqw3cYNHILp3X20Am510TLkq33wfeUIZBU1tlFuBZe/As5866PbRBdnGi37QdVM4Jh6dkms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747173578; c=relaxed/simple;
	bh=59VlnNQcrQbF9VoPWx9rTK6gSiYi9D6flZRl8TqbiJY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=fk8DO8e2aNp7U+/iLzbI1WQGND8+un5Da/R3ufXxy5IfjGUi/vjmqmrrYe1NUTA6VEnnM2tYCqtGGvb9+onAGgyrT6Lh1rg626qQptYeP1RDQhNDlPIhJ9pDvVrW9tF+XBPz7LuXn1mQQAd2iZ6VUf73QfGgpdpai8OYhs2UU2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ctshao.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4qV0C8/t; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ctshao.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4qV0C8/t"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-30df7c1287fso1700006a91.1
        for <linux-perf-users@vger.kernel.org>; Tue, 13 May 2025 14:59:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747173576; x=1747778376; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=wxh9BxVjJTo5yVA2IRbpjDRptGFFtiq3WHv5MWVzf+Y=;
        b=4qV0C8/tT6O+knwEpeIO6kRsCio/5PHP4L/R5DgB9wHl/ooJit4qxP323el0Yt4d5s
         S1qcGuz/Wmu6bZNQmd5AOXA58CO4waXL2GK2b0uEnpuhhwL4vSSvfBGsDWQDDd9VnfGI
         Ez8Qitq7tHQJKXEzsvMdWLusOxA8reRxMqCZ8NDK6qJv5S+24PTiVDONjY0NPDgDxd4+
         USUprfFbVXKuwQPoXULHFBUkfkimiHZo2JBjBKbyJzbajlZQhJ6kxYmPaJpx2UQaatlB
         UsjY2PmZO1A1iUewHZQb+kuTXKRjPjYJJXrn0O9bDwQSJ0fuQO0MZu6YFO2qijxe4qjn
         UWcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747173576; x=1747778376;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wxh9BxVjJTo5yVA2IRbpjDRptGFFtiq3WHv5MWVzf+Y=;
        b=JtSi0X1AbDnPnnjQr0VEwGbRSKINPzss7WcyfKALmB0raa1Kfk70NJ1+6qulR/LW1U
         UXrZrjuVDrPlvys+Oxu+PkKYPS402rJ4tYuLgZetJ0whhW0uzxbC56bPU3cIHAKD8+UG
         rzbKUQ/CwhGnk4wRrDKQeODT59+Pr4JcisU+L35manZKWrBUnIlZ+aSilDlD8LHmPoWb
         LVYKqRiTA440nXT+xOb4hYe91uJuCjtxxkccOYUNOtbBYc6a44vuP6hJGfWN1aVoyCGP
         IORlEHL7w35h75NpUZ1lxCERGS6UzcWpIUEjMLtFdKdC/BoapzZJmRm7tN9UtpgwMoWj
         PbUw==
X-Forwarded-Encrypted: i=1; AJvYcCVqZlaEBIpgW4tGqZO10vE0QKbArHBsq9MXbQoA9tHEo70OsLGbJNpyRL7x7uQItJN1wJOU/HOZlgCNYK4XhvJC@vger.kernel.org
X-Gm-Message-State: AOJu0YxXouRsgi1Ei6WS4JJtTFU3x40GWq7/QggL+jhLOT4NnCNlEk08
	z/RbL3y67j4J9la72MAjkKbDcBYQa07nebeTekslhPufC4g/ALS4HFS3IEOruyyQ+FRl89gtxGc
	2Fg==
X-Google-Smtp-Source: AGHT+IGjzCvvWC24UQLYpGjqozDFlayOjAbZNXIhc9Bx7yZY6KP50LdqPlIhi5YtpGxNXqNDP6O+tXNP1C4=
X-Received: from pjk3.prod.google.com ([2002:a17:90b:5583:b0:308:65f7:9f24])
 (user=ctshao job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3bce:b0:305:2d68:8d39
 with SMTP id 98e67ed59e1d1-30e2e5e6ca8mr1988712a91.12.1747173576315; Tue, 13
 May 2025 14:59:36 -0700 (PDT)
Date: Tue, 13 May 2025 14:45:03 -0700
In-Reply-To: <20250513215401.2315949-1-ctshao@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250513215401.2315949-1-ctshao@google.com>
X-Mailer: git-send-email 2.49.0.1045.g170613ef41-goog
Message-ID: <20250513215401.2315949-4-ctshao@google.com>
Subject: [PATCH v4 3/3] perf test: Add stat uniquifying test
From: Chun-Tse Shao <ctshao@google.com>
To: linux-kernel@vger.kernel.org
Cc: Chun-Tse Shao <ctshao@google.com>, peterz@infradead.org, mingo@redhat.com, 
	acme@kernel.org, namhyung@kernel.org, mark.rutland@arm.com, 
	alexander.shishkin@linux.intel.com, jolsa@kernel.org, irogers@google.com, 
	adrian.hunter@intel.com, kan.liang@linux.intel.com, howardchu95@gmail.com, 
	linux@treblig.org, yeoreum.yun@arm.com, ak@linux.intel.com, 
	james.clark@linaro.org, weilin.wang@intel.com, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

The `stat+uniquify.sh` test retrieves all uniquified `clockticks` events
from `perf list -v clockticks` and check if `perf stat -e clockticks -A`
contains all of them.

Signed-off-by: Chun-Tse Shao <ctshao@google.com>
---
 .../tests/shell/stat+event_uniquifying.sh     | 69 +++++++++++++++++++
 1 file changed, 69 insertions(+)
 create mode 100755 tools/perf/tests/shell/stat+event_uniquifying.sh

diff --git a/tools/perf/tests/shell/stat+event_uniquifying.sh b/tools/perf/tests/shell/stat+event_uniquifying.sh
new file mode 100755
index 000000000000..5ec35c52b7d9
--- /dev/null
+++ b/tools/perf/tests/shell/stat+event_uniquifying.sh
@@ -0,0 +1,69 @@
+#!/bin/bash
+# perf stat events uniquifying
+# SPDX-License-Identifier: GPL-2.0
+
+set -e
+
+stat_output=$(mktemp /tmp/__perf_test.stat_output.XXXXX)
+perf_tool=perf
+err=0
+
+test_event_uniquifying() {
+  # We use `clockticks` to verify the uniquify behavior.
+  event="clockticks"
+
+  # If the `-A` option is added, the event should be uniquified.
+  #
+  # $perf list -v clockticks
+  #
+  # List of pre-defined events (to be used in -e or -M):
+  #
+  #   uncore_imc_0/clockticks/                           [Kernel PMU event]
+  #   uncore_imc_1/clockticks/                           [Kernel PMU event]
+  #   uncore_imc_2/clockticks/                           [Kernel PMU event]
+  #   uncore_imc_3/clockticks/                           [Kernel PMU event]
+  #   uncore_imc_4/clockticks/                           [Kernel PMU event]
+  #   uncore_imc_5/clockticks/                           [Kernel PMU event]
+  #
+  #   ...
+  #
+  # $perf stat -e clockticks -A -- true
+  #
+  #  Performance counter stats for 'system wide':
+  #
+  # CPU0            3,773,018      uncore_imc_0/clockticks/
+  # CPU0            3,609,025      uncore_imc_1/clockticks/
+  # CPU0                    0      uncore_imc_2/clockticks/
+  # CPU0            3,230,009      uncore_imc_3/clockticks/
+  # CPU0            3,049,897      uncore_imc_4/clockticks/
+  # CPU0                    0      uncore_imc_5/clockticks/
+  #
+  #        0.002029828 seconds time elapsed
+
+  echo "stat event uniquifying test"
+  uniquified_event_array=()
+
+  # Check how many uniquified events.
+  while IFS= read -r line; do
+    uniquified_event=$(echo "$line" | awk '{print $1}')
+    uniquified_event_array+=("${uniquified_event}")
+  done < <(${perf_tool} list -v ${event} | grep "\[Kernel PMU event\]")
+
+  perf_command="${perf_tool} stat -e $event -A -o ${stat_output} -- true"
+  $perf_command
+
+  # Check the output contains all uniquified events.
+  for uniquified_event in "${uniquified_event_array[@]}"; do
+    if ! cat "${stat_output}" | grep -q "${uniquified_event}"; then
+      echo "Event is not uniquified [Failed]"
+      echo "${perf_command}"
+      cat "${stat_output}"
+      err=1
+      break
+    fi
+  done
+}
+
+test_event_uniquifying
+rm -f "${stat_output}"
+exit $err
-- 
2.49.0.1045.g170613ef41-goog

