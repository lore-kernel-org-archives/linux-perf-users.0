Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7E871DDC3F
	for <linux-perf-users@vger.kernel.org>; Mon,  8 Sep 2025 22:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757369854; cv=none; b=dYAakAOgk5Mp0uhxqXIaWlVNILun5widBf4BPhKm0htfWdhVxU/mcB+rmqmS06Q/Ejcyng1uo1+Cf1zT8NFVjcZeeERFR5khV2YstshkfkOXqdR6csYWGoGM/WjcUrFUowVVuqDn7T3Zj3PaNpuo5vLWtsoHj6nkFpQ71ox7WaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757369854; c=relaxed/simple;
	bh=WndRMlWecgqXJdWZzxmDcVkmqX6o2mWfQ4dYwq6lqhM=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Content-Type; b=bQPyQNNkjv9nwDzIVKPuEegS3Zs/3dTAroOQA/dl0QPI+48WPbktI9eIMfY/ChuIxF7udG/8eIOxg1i+7irof7o+wP+Oq0THeMVwbBvQjQdByqMC4MnyvAQcczjrQajzyX6pmFw+QirM8b+//WAobV5HFfGLxkjourz+gFxUroQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1qD6EDk5; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1qD6EDk5"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-329dfdc23d2so4482795a91.1
        for <linux-perf-users@vger.kernel.org>; Mon, 08 Sep 2025 15:17:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757369852; x=1757974652; darn=vger.kernel.org;
        h=to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=/dCimbPvR4vhV5Nmxpal2xln1XntuCrmnmbJs0wCG0s=;
        b=1qD6EDk5A445FEp47gIWlCVrkiwybp2pa7FJz00FaEDCCx8BUwDkLM9jNdE8t4sVoo
         GIiV8giQTuU4Ye9ZpVmQD8X1/lWhROpTVID/oQXmd2mE5aYIuSCyHyKC9UY2rrQkg08W
         zct1DT5UYfgqCRjpcIvT3yDV+feCC73PaT/LOYDqU2SDKI5ZQ+1iyIK7zv6ZysjokR9i
         JCGuEl/OhgR0jnYtmvTBYc0e+LqKsUBMGpvdnRzvQl8EGrVbuHJWlqlzRBOOvlJg9jPN
         x5PV2kiv5ig8vbpmD7x6D+Kyu6xop0dzy/AVem/pHU+FOCqDeDQFOk3nIulLolh1Q/4i
         ZXxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757369852; x=1757974652;
        h=to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/dCimbPvR4vhV5Nmxpal2xln1XntuCrmnmbJs0wCG0s=;
        b=W5zOWG5rDDO85M2hzc7JMelCBKStVKhLl6ZZCfgtaqT48oOaUTzT6fxkVxNwDyuuo8
         JH9t8+CnCa4wLV6+mqCz0NagSgwykKJckaYZXqaIiOEg0o3EP/0t7UQljGerO0sXS2JE
         lvU04C8rY86yj+jvnohX9t0r5cGbJ+lE+O0CiFSaiuvUidICA1aPf4Fw47j9XEN8ZQMA
         54awrR1VpkRmMnMz9P+x9lNbaDH9YWuzkswjEUkj41wgS3mHrRgBYG378huLrDd/0Jfa
         DKJdAYMZ88PkH+vd4/bePPbgARfwF0Z7NkNeMlXiLIdW960SJeYeReYX+7Fmcm5SqAAV
         jPcA==
X-Forwarded-Encrypted: i=1; AJvYcCXBPbVqjgNU+YsEQuDmI/5WzmkX+sl6hH4rdz2L3DPRgruOpm4ZJMaW3HDuvknCSpZ6S7dgKBkf3oW+VCkz+Q5n@vger.kernel.org
X-Gm-Message-State: AOJu0YwDmE69UP60zjgIktK/A3GvUgH/L14Kp9opFpQm7EhYvfU+Z7eY
	+x3xwdt1kJWxqCEQoM/Vy3JX4FPaEwnb0cmT9g3KeUMcMd5rYxMEeH/d7juL6VoFrDo/IioIHBp
	ZVEVFXHbc9Q==
X-Google-Smtp-Source: AGHT+IEcgU6r4iwOgODrs6lRVzJ3bq7FDwgc4bFP0nvQHLKfhCcLitrbLJ05jnazgRrvKIRHeL/oW3Veaqpx
X-Received: from pjbdy7.prod.google.com ([2002:a17:90b:6c7:b0:32b:92ac:cfb9])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:1343:b0:328:6a2:3fb0
 with SMTP id 98e67ed59e1d1-32d43f98ee2mr11446354a91.36.1757369851776; Mon, 08
 Sep 2025 15:17:31 -0700 (PDT)
Date: Mon,  8 Sep 2025 15:17:27 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.0.384.g4c02a37b29-goog
Message-ID: <20250908221727.3635572-1-irogers@google.com>
Subject: [PATCH v1] perf test: AMD IBS swfilt skip kernel tests if paranoia is >1
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

Some corrections to the kernel/user sample count test.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/shell/amd-ibs-swfilt.sh | 57 +++++++++++++++++-------
 1 file changed, 41 insertions(+), 16 deletions(-)

diff --git a/tools/perf/tests/shell/amd-ibs-swfilt.sh b/tools/perf/tests/shell/amd-ibs-swfilt.sh
index 7045ec72ba4c..80d5bf8db40c 100755
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
@@ -46,22 +57,36 @@ if [ $? -ne 0 ]; then
 fi
 
 # check system wide recording
-perf record -aB --synth=no -e ibs_op/swfilt/k -o /dev/null true
-if [ $? -ne 0 ]; then
-    echo "[FAIL] IBS op PMU cannot handle swfilt in system-wide mode"
-    exit 1
+if ! ParanoidAndNotRoot 1
+then
+    perf record -aB --synth=no -e ibs_op/swfilt/k -o /dev/null true
+    if [ $? -ne 0 ]; then
+        echo "[FAIL] IBS op PMU cannot handle swfilt in system-wide mode"
+        exit 1
+    fi
+else
+    echo "[SKIP] not root and perf_event_paranoid too high for exclude_user"
+    err=2
 fi
 
 echo "check number of samples with swfilt"
 
-kernel_sample=$(perf record -e ibs_op/swfilt/u -o- true | perf script -i- -F misc | grep -c ^K)
-if [ ${kernel_sample} -ne 0 ]; then
-    echo "[FAIL] unexpected kernel samples: " ${kernel_sample}
-    exit 1
-fi
-
-user_sample=$(perf record -e ibs_fetch/swfilt/k -o- true | perf script -i- -F misc | grep -c ^U)
+user_sample=$(perf record -e ibs_op/swfilt/u -o- true | perf script -i- -F misc | grep -c ^U)
 if [ ${user_sample} -ne 0 ]; then
     echo "[FAIL] unexpected user samples: " ${user_sample}
     exit 1
 fi
+
+if ! ParanoidAndNotRoot 1
+then
+    kernel_sample=$(perf record -e ibs_fetch/swfilt/k -o- true | perf script -i- -F misc | grep -c ^K)
+    if [ ${kernel_sample} -ne 0 ]; then
+        echo "[FAIL] unexpected kernel samples: " ${kernel_sample}
+        exit 1
+    fi
+else
+    echo "[SKIP] not root and perf_event_paranoid too high for exclude_user"
+    err=2
+fi
+
+exit $err
-- 
2.51.0.384.g4c02a37b29-goog

