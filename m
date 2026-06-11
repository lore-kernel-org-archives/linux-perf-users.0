Received: from mail-dy1-f202.google.com (mail-dy1-f202.google.com [74.125.82.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF2812737F8
	for <linux-perf-users@vger.kernel.org>; Thu, 11 Jun 2026 17:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781198365; cv=none; b=NC/kIWUZUxuIOng4PCOocD9MWjlSNoqHsxWRutj47JNjMajZARojD81rV0cFxSyEiJwCzUSv3tTWT9VEIRCqv5B9Kx92ycc9rVGVQLqqCtUg474qXVNyztWAlLjhKNO9hKKOwvmgkKAQX0KGrFfSymyiioZzAxbAdLAL+ew4xew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781198365; c=relaxed/simple;
	bh=p8oIONdzVrlfJr1SJZe3A/QVqrVWmzS0BQoKisqexlQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=twIyHmcijwUbHVAShDspHLWDJfCYqqQzszLIhJSg3NzBaIU3Qizs4i4zFQr2CR5ZNZqFIibWM29FQ80tViusJwPqlD2jnFcFlvJyWNTI6v4iU6RqFYcg5TX6eCgzFMafGMu/xyQgAT/WbNmI9Qsp6/AR9kI7FmWfT6fMTQhan7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Z1N6sHBq; arc=none smtp.client-ip=74.125.82.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Z1N6sHBq"
Received: by mail-dy1-f202.google.com with SMTP id 5a478bee46e88-307fd7138b1so206658eec.0
        for <linux-perf-users@vger.kernel.org>; Thu, 11 Jun 2026 10:19:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781198358; x=1781803158; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8aQcbdma71h7K8kHl773QM35IjB3UaGYzxNEo2WcOAg=;
        b=Z1N6sHBqxfUbuwj78O2XBBLbphQlAzCotTQAyIWQ8Bm+UZh+rx+UzK8c0F1SmBBfz+
         3wfK+AbR6PL8ZbW+30o+sysB+1fq9Z1fK2NRFccsHJ8rySWrCGP8Kdk7zcbmQvwyboWg
         6LCb90h4oSDhWFx8RP4yk0NRKZebl+oNE7Vqy6oc/r0RYXXJUKNaNNlICK9VgyYVKTf1
         I6QtDKNohqFTDAk04xmILYbjaKQad/FiO7HCfVN3wudisGE2SJJBS6HFe/ygETihjQIs
         SVH5obZEkKqE98/kG5JEcGA64CPJ2+u0hETwONGfHn1mHjWR23Tm69nlCGE3oEWDJfXP
         0ZpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781198358; x=1781803158;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=8aQcbdma71h7K8kHl773QM35IjB3UaGYzxNEo2WcOAg=;
        b=LssK4/VUhYJxF7Tw/96T43UbGRxRSEMWMXWA1tqykQieJTy8R18U2ehFfpLFeA9DjQ
         LrDDGQOjsQFc1RI/KBahHvboPCLLTomnf/q/tvfYM7bzVul5IZBBtdw+NSm6bmkWp0q+
         bCHVgNLuF5NNzx91tAhW5kyv18d98DCN4IvIYZ8gGT2zaPIMSlKF4MXOnE/3h5nAZWCs
         PLXOnTp4NzMwQL67jGU2CuFL3VdWY2dqQHqXcRycElBi+QHxK+h1C7weiCZ0oayJj/pn
         Ntyxb5h5/LwD3sAUBiZorHFCagx5lTMhrEW4a2mSKwAm3/BM0l3SWOew9NeZvQQSJMTf
         3Yhw==
X-Forwarded-Encrypted: i=1; AFNElJ9VRbNno4N+FmOioYstVIKI8AGvXKpeIUEMqMTnlOQsDDE24MI4YwelPLy3Ed7oHHhj+XMnIlB6VwB2hdtPMcgC@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/ya+mWh/t++ewxfeNHbbC5AHE6hwgboBfpWghCmCGXVcQhq3B
	qi7kPZ/bb1selka+w35cl350o65ZwDuTO1GnI7UQONJFHKZZxTGDtd2i+cw6dx8PUCB/bxMPTly
	3NL+9Xv8FnA==
X-Received: from dlcip7.prod.google.com ([2002:a05:7023:c087:b0:138:d5:834e])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:983:b0:137:f4ec:29ff
 with SMTP id a92af1059eb24-138421c1295mr2069780c88.22.1781198357304; Thu, 11
 Jun 2026 10:19:17 -0700 (PDT)
Date: Thu, 11 Jun 2026 10:17:56 -0700
In-Reply-To: <20260611171756.4008769-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260605191500.2477026-1-irogers@google.com> <20260611171756.4008769-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.1136.gdb2ca164c4-goog
Message-ID: <20260611171756.4008769-20-irogers@google.com>
Subject: [PATCH v12 19/19] perf python: Add LiveSession helper
From: Ian Rogers <irogers@google.com>
To: irogers@google.com
Cc: acme@kernel.org, adrian.hunter@intel.com, alice.mei.rogers@gmail.com, 
	dapeng1.mi@linux.intel.com, james.clark@linaro.org, leo.yan@linux.dev, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	mingo@redhat.com, namhyung@kernel.org, peterz@infradead.org, 
	tmricht@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Add LiveSession class in tools/perf/python/perf_live.py to support
live event collection using perf.evlist and perf.parse_events,
avoiding the need to fork a separate perf record process.

Signed-off-by: Ian Rogers <irogers@google.com>
Assisted-by: Gemini:gemini-3.1-pro-preview
---
v12:
 - Replaced `except TypeError` with `continue` to ignore unmapped/offline C=
PUs instead of breaking the poll loop. Replaced hardcoded `-11` with `e.err=
no =3D=3D errno.EAGAIN` in `LiveSession.run()`. Fixed `setup_python.sh` `PY=
THONPATH` prepend logic to cleanly append to existing paths.

v2:

1. Fixed File Descriptor Leak: I moved self.evlist.mmap() inside the
   try block so that if it raises an exception, the finally block will
   still be executed and call self.evlist.close() , preventing file
   descriptor leaks.

2. Handled InterruptedError in poll() : I wrapped the poll() call in a
   try-except block to catch InterruptedError and continue the
   loop. This prevents the live session from crashing on non-fatal
   signals like SIGWINCH .

3. Added evlist.config() : I added a call to self.evlist.config() in
   the constructor after parse_events() . This applies the default
   record options to the events, enabling sampling and setting up
   PERF_SAMPLE_* fields so that the kernel will actually generate
   PERF_RECORD_SAMPLE events.

4. Enable the evlist and be robust to exceptions from reading unsupported
   events like mmap2.

v8:
- Drain all events from a CPU before moving to the next.
---
 tools/perf/python/perf_live.py             | 61 ++++++++++++++++++++++
 tools/perf/tests/shell/lib/setup_python.sh | 13 +++++
 2 files changed, 74 insertions(+)
 create mode 100755 tools/perf/python/perf_live.py

diff --git a/tools/perf/python/perf_live.py b/tools/perf/python/perf_live.p=
y
new file mode 100755
index 000000000000..7455f60d2115
--- /dev/null
+++ b/tools/perf/python/perf_live.py
@@ -0,0 +1,61 @@
+# SPDX-License-Identifier: GPL-2.0
+"""
+Live event session helper using perf.evlist.
+
+This module provides a LiveSession class that allows running a callback
+for each event collected live from the system, similar to perf.session
+but without requiring a perf.data file.
+"""
+
+import errno
+import perf
+
+
+class LiveSession:
+    """Represents a live event collection session."""
+
+    def __init__(self, event_string: str, sample_callback):
+        self.event_string =3D event_string
+        self.sample_callback =3D sample_callback
+        # Create a cpu map for all online CPUs
+        self.cpus =3D perf.cpu_map()
+        # Parse events and set maps
+        self.evlist =3D perf.parse_events(self.event_string, self.cpus)
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
+                    for _ in range(1000): # Limit to 1000 events per CPU p=
er poll to prevent starvation
+                        try:
+                            event =3D self.evlist.read_on_cpu(cpu)
+                        except TypeError:
+                            # CPU might be unmapped or offline, wait for m=
map event
+                            continue
+                        except OSError as e:
+                            # Ignore -EAGAIN on empty buffer
+                            if e.errno =3D=3D errno.EAGAIN:
+                                break
+                            # OS/mmap errors are unrecoverable
+                            raise e
+
+                        if event is None:
+                            break
+
+                        if event.type =3D=3D perf.RECORD_SAMPLE:
+                            self.sample_callback(event)
+        except KeyboardInterrupt:
+            pass
+        finally:
+            self.evlist.close()
diff --git a/tools/perf/tests/shell/lib/setup_python.sh b/tools/perf/tests/=
shell/lib/setup_python.sh
index a58e5536f2ed..2173215a0517 100644
--- a/tools/perf/tests/shell/lib/setup_python.sh
+++ b/tools/perf/tests/shell/lib/setup_python.sh
@@ -14,3 +14,16 @@ then
   echo Skipping test, python not detected please set environment variable =
PYTHON.
   exit 2
 fi
+
+# Set PYTHONPATH to find the in-tree built perf.so first, avoiding system-=
wide perf.so
+if [ -n "$PERF_EXEC_PATH" ] && [ -d "$PERF_EXEC_PATH/python" ]; then
+  PYTHONPATH_DIR=3D"$PERF_EXEC_PATH/python"
+elif [ -d "$(dirname "$0")/../../python" ]; then
+  PYTHONPATH_DIR=3D"$(dirname "$0")/../../python"
+elif [ -d "$(dirname "$0")/../python" ]; then
+  PYTHONPATH_DIR=3D"$(dirname "$0")/../python"
+fi
+
+if [ -n "$PYTHONPATH_DIR" ]; then
+  export PYTHONPATH=3D"$PYTHONPATH_DIR${PYTHONPATH:+:$PYTHONPATH}"
+fi
--=20
2.54.0.1136.gdb2ca164c4-goog

