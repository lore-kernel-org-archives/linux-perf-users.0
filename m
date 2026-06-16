Received: from mail-dl1-f73.google.com (mail-dl1-f73.google.com [74.125.82.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEA8339182D
	for <linux-perf-users@vger.kernel.org>; Tue, 16 Jun 2026 01:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781572596; cv=none; b=ovMK+DPFe0NFVCb7GsfuhZKDhShVcZ1W2qKRaPXXq6fqqngHdC9lJoQ7/bCKd/fikQ99NWxofvUk27TTdjMlnt3JAu/fM9JkpIbAEF30iPDe3GsDHDx6JDOt3/aYyJbRYYwMQrVbf9Tz/d7agDEHqjKgILHDZAIb89A8h6U+V0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781572596; c=relaxed/simple;
	bh=4dLo4HpbrybbnBf8shD12wCKP55rLDF16HiWGceZngg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=aWayZtVn3IM7CtXEh+z0mkcrCIadMRAS7Q5bm88pvdPm89kmCfdJQUPN9Yqyqa4QeMumv4lwgMFft+9O29/gHu9f72OvkxIdaryfxT9r3vpvgyLUwSHQukuu+I5tGc9sGScC6KaXlD6VhAY47B91IpCNyFMaUL3N66pB/qh8BSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iTAKdicw; arc=none smtp.client-ip=74.125.82.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iTAKdicw"
Received: by mail-dl1-f73.google.com with SMTP id a92af1059eb24-137fc6f8e9fso4081543c88.1
        for <linux-perf-users@vger.kernel.org>; Mon, 15 Jun 2026 18:16:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781572594; x=1782177394; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=4JIEJjPFYpgehV0e0DCUgUFbnCz0JdtZUpoEiWCHJq8=;
        b=iTAKdicwEdA7xOpk2ocimCtGyvvR2k9vjEtpvyXR02d/1KC8jDPcTjFGYnq2Rtry19
         RuACQWb2zHpKyrx66qPbUB8S5SQZQ7BuZ0nPRAqIwerHITfKoNiUAXFWb0wtH6Zv4CwB
         xiADUTjOAoZJTj5iOZXIylxzfC5W+PU3qz/OSX3s6J66kHGqpqP+kFCgx5M8uVzyYn5D
         oS/gVbKi8H//wX/0JU/8Lbk2V7hQJPV4pozi+bxfTwE7PS4U2rtDtPYu7/3wuVuZzGrH
         gtDbF3yCeUWh6T/QRBp3axIcoSBbBiOzmy/QTRFkv2t5gcXGi8Ev+X6lWMITPtv7ufmI
         n5Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781572594; x=1782177394;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4JIEJjPFYpgehV0e0DCUgUFbnCz0JdtZUpoEiWCHJq8=;
        b=hrwF3ij1GhGP/i7eoFrL3lQDk0K2CJPvhKhB2mYLTv75km0vvMZE9ecZxuUsCcV2Q2
         LLgS26Xo4zivBJ6UyKE7b9WlS0RgpyYTa3a7RmUVrNpT1xMQPmIrrMBEMu9oMFP3TQCh
         EctBOqkM2jCuu7+xTN/t312DRJP5fqNYKVJR7GrVHEG1ZNpUeJGAKXnkUVK++U8EL6HK
         +Tqyfye2/oD5OaYxVwL62lfly+PN76Gplxo5VD2XIW4quHCpgtHQsZ2uLXn938XpiiQa
         Y0kPxPDnywsZ3rCIk+FLc8mIYSWjFtS+wl9UZFbCP8xor2xX2/bNqzQugFOTMzoZlqOt
         IPqg==
X-Forwarded-Encrypted: i=1; AFNElJ8nJVmkQZSKmpWk6QpTFpH5LooRvgAbSlDqNO6UV7Oa1QAcy9K6+5AgSvrE1vUL0elrOgwbhATZ8GR0WB26Sk1W@vger.kernel.org
X-Gm-Message-State: AOJu0YxbAhTbwvtYSgUYT4n5wDgVJMy2Jlc9LHPUFYyNeIDh1UOuoKeS
	IZMrDKEdT5ub7KLME5RIjICwsVLe7ZQCd5nGZndCU0LomJd8/8Qqni9AnlnH46tKdews+R/q3mq
	wA/5iGXQkkw==
X-Received: from dybff20.prod.google.com ([2002:a05:7300:bf14:b0:304:5761:e0e7])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:991:b0:136:9ebf:3bf4
 with SMTP id a92af1059eb24-13985f3338amr568239c88.26.1781572593938; Mon, 15
 Jun 2026 18:16:33 -0700 (PDT)
Date: Mon, 15 Jun 2026 18:15:43 -0700
In-Reply-To: <20260616011543.4037138-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260615223011.3873955-1-irogers@google.com> <20260616011543.4037138-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.1136.gdb2ca164c4-goog
Message-ID: <20260616011543.4037138-22-irogers@google.com>
Subject: [PATCH v21 21/21] perf python: Add LiveSession helper
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, namhyung@kernel.org
Cc: adrian.hunter@intel.com, alice.mei.rogers@gmail.com, 
	dapeng1.mi@linux.intel.com, james.clark@linaro.org, leo.yan@linux.dev, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	mingo@redhat.com, peterz@infradead.org, tmricht@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"

Add LiveSession class in tools/perf/python/perf_live.py to support
live event collection using perf.evlist and perf.parse_events,
avoiding the need to fork a separate perf record process.

Signed-off-by: Ian Rogers <irogers@google.com>
Assisted-by: Gemini:gemini-3.1-pro-preview
---
 tools/perf/python/perf_live.py             | 59 ++++++++++++++++++++++
 tools/perf/tests/shell/lib/setup_python.sh | 13 +++++
 2 files changed, 72 insertions(+)
 create mode 100755 tools/perf/python/perf_live.py

diff --git a/tools/perf/python/perf_live.py b/tools/perf/python/perf_live.py
new file mode 100755
index 000000000000..616b5f657463
--- /dev/null
+++ b/tools/perf/python/perf_live.py
@@ -0,0 +1,59 @@
+# SPDX-License-Identifier: GPL-2.0
+"""
+Live event session helper using perf.evlist.
+
+This module provides a LiveSession class that allows running a callback
+for each event collected live from the system, similar to perf.session
+but without requiring a perf.data file.
+"""
+
+import perf
+
+
+class LiveSession:
+    """Represents a live event collection session."""
+
+    def __init__(self, event_string: str, sample_callback):
+        self.event_string = event_string
+        self.sample_callback = sample_callback
+        # Create a cpu map for all online CPUs
+        self.cpus = perf.cpu_map()
+        # Parse events and set maps
+        self.evlist = perf.parse_events(self.event_string, self.cpus)
+        self.evlist.config()
+
+    def run(self):
+        """Run the live session."""
+        try:
+            self.evlist.open()
+            self.evlist.mmap()
+            self.evlist.enable()
+
+            while True:
+                # Poll for events with 100ms timeout
+                try:
+                    self.evlist.poll(100)
+                except InterruptedError:
+                    continue
+                for cpu in self.cpus:
+                    for _ in range(1000): # Limit to 1000 events per CPU per poll to prevent starvation
+                        try:
+                            event = self.evlist.read_on_cpu(cpu)
+                        except TypeError as e:
+                            if "Unknown CPU" in str(e):
+                                # CPU might be unmapped or offline, wait for mmap event
+                                break
+                            if "Unexpected header type" in str(e):
+                                # Ignore valid but unsupported event types
+                                continue
+                            raise
+
+                        if event is None:
+                            break
+
+                        if event.type == perf.RECORD_SAMPLE:
+                            self.sample_callback(event)
+        except KeyboardInterrupt:
+            pass
+        finally:
+            self.evlist.close()
diff --git a/tools/perf/tests/shell/lib/setup_python.sh b/tools/perf/tests/shell/lib/setup_python.sh
index a58e5536f2ed..2173215a0517 100644
--- a/tools/perf/tests/shell/lib/setup_python.sh
+++ b/tools/perf/tests/shell/lib/setup_python.sh
@@ -14,3 +14,16 @@ then
   echo Skipping test, python not detected please set environment variable PYTHON.
   exit 2
 fi
+
+# Set PYTHONPATH to find the in-tree built perf.so first, avoiding system-wide perf.so
+if [ -n "$PERF_EXEC_PATH" ] && [ -d "$PERF_EXEC_PATH/python" ]; then
+  PYTHONPATH_DIR="$PERF_EXEC_PATH/python"
+elif [ -d "$(dirname "$0")/../../python" ]; then
+  PYTHONPATH_DIR="$(dirname "$0")/../../python"
+elif [ -d "$(dirname "$0")/../python" ]; then
+  PYTHONPATH_DIR="$(dirname "$0")/../python"
+fi
+
+if [ -n "$PYTHONPATH_DIR" ]; then
+  export PYTHONPATH="$PYTHONPATH_DIR${PYTHONPATH:+:$PYTHONPATH}"
+fi
-- 
2.54.0.1136.gdb2ca164c4-goog

