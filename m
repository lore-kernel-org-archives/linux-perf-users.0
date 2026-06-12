Received: from mail-dl1-f74.google.com (mail-dl1-f74.google.com [74.125.82.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F40D405C33
	for <linux-perf-users@vger.kernel.org>; Fri, 12 Jun 2026 18:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781287846; cv=none; b=TIX+xdbouoxtl0FweIN+7aagnnR8Olh7o9GxolGX8g9AFug5FC7Tc4Q7D2kcATsMuKXzT9kEtY1l/vT5O0KLd2unY+O0+ftvmP30csThHnulSv5Mb3YwwZ/ljZwKBzyIobLpnHo8DO10Y9XoswLH6kDMXFIn1ZOyTlYXmnTzVQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781287846; c=relaxed/simple;
	bh=qOf1Wd7zgs8S1zE2z0Om6/yIsdiCHCh+jtIDOS7g64M=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=YZyBfR0rsnB6X3OL2WdwsJJHGgO9ovGOs+OAy7bZQOwKnKG/Ha8LD6V6MYztsBuM4U1W0308RhZfOZ0N6llPKC/AbN+3jlDcRi+6Jmjdh/9fVKVayGzN6lp17yJYb//HjkDt6It41h3v6fGqW6XBlpbGthcRShfQlziQ3PdMDnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vKvu+pwa; arc=none smtp.client-ip=74.125.82.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vKvu+pwa"
Received: by mail-dl1-f74.google.com with SMTP id a92af1059eb24-13840d96f21so4722122c88.1
        for <linux-perf-users@vger.kernel.org>; Fri, 12 Jun 2026 11:10:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781287843; x=1781892643; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zOKcWEflCtB2iI3mAyKxrWp4CrQAheZW6CDWW+PkO+0=;
        b=vKvu+pwauKrLvrammx7Gbd5Vd89a+nb1oYYFNbI42kyXrLWvZY5CyyxIi7MJEny+Z6
         qzzroZBbrhxMTICZtfz3eXpc9Q4FeE+9x5TjA4OCBSyDXU7OSVr3XECX6L0AiEJAVEUO
         WiTIkfBU9Gie1bSrRXo12pDmveUezO6WBQsB2nVd5FsfF8cNj6c58ZsshxasEoKriBlk
         CBTpVSQCYv2ieErQkw6nrOYF5i17vX3k4AQSNj8mw/a7Ff8hWBWKnMnHluK8BXr9vJAV
         rimkvKmrpZnXLlAEJzapT54Aegre4aLDt2torjbG6QUwUZkRykOhPJaRFGO0AN7GkBk4
         t+DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781287843; x=1781892643;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=zOKcWEflCtB2iI3mAyKxrWp4CrQAheZW6CDWW+PkO+0=;
        b=bcCBYOvY3j5dJCr83MiqIZ8o1/U+t0mhEhIsv9bT5gVF9igmyDP52wi0881SGi9pMg
         XDnZPUBc87iPNQbAUazZcU37RO+dWKdrNAnwyRtym46+ZVWQEmWA/WsxXOkl0aJe4uOA
         x47lkrT4paLURe2J+QybKaQKSCR38iTOlsTQZvJvylm7d9BsIm8zyQfjDhRzZQJO2wbi
         HhBW80JNlS/HhOAEC2okxXxteHIQaHe3PQsud3of+4lllZF0iGzkXwcjHGO0sr04Ly1/
         Q7yrSz33UO9Q/sGFqL8IulxFpTRN7q7FX9wkCLF7cGMFbN+NiRuQx0bGZfWBghQ/wnDT
         c5kQ==
X-Forwarded-Encrypted: i=1; AFNElJ+79SUxJ0mPq3Z6evAsnomqS83nUswjInLGqpuzjx0DjafCCbrgO7nGRU3sdAgz66eBbh66qvba8VJVvIdkwAeC@vger.kernel.org
X-Gm-Message-State: AOJu0YwvHgBlxwAtU4keVCgv9DQV4xE43QoGZtTZt1frHRqQ29pW1wLv
	0xa5///sFvv2D4lm5L6QkfXp0S75ONLtRJWxGMZxAdHTrgXJPZfyx2VWEYHAnpML/ZRhKrp4HMh
	FZs46gqT7Vw==
X-Received: from dyhb19.prod.google.com ([2002:a05:7300:1493:b0:2ed:a84e:18d3])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7301:578b:b0:2c8:6361:ab2e
 with SMTP id 5a478bee46e88-3081ff81573mr2656188eec.8.1781287843044; Fri, 12
 Jun 2026 11:10:43 -0700 (PDT)
Date: Fri, 12 Jun 2026 11:09:56 -0700
In-Reply-To: <20260612180956.1105352-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260611224455.201994-1-irogers@google.com> <20260612180956.1105352-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.1136.gdb2ca164c4-goog
Message-ID: <20260612180956.1105352-20-irogers@google.com>
Subject: [PATCH v14 19/19] perf python: Add LiveSession helper
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, namhyung@kernel.org
Cc: adrian.hunter@intel.com, alice.mei.rogers@gmail.com, 
	dapeng1.mi@linux.intel.com, james.clark@linaro.org, leo.yan@linux.dev, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	mingo@redhat.com, peterz@infradead.org, tmricht@linux.ibm.com
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
 tools/perf/python/perf_live.py             | 55 ++++++++++++++++++++++
 tools/perf/tests/shell/lib/setup_python.sh | 13 +++++
 2 files changed, 68 insertions(+)
 create mode 100755 tools/perf/python/perf_live.py

diff --git a/tools/perf/python/perf_live.py b/tools/perf/python/perf_live.p=
y
new file mode 100755
index 000000000000..fd049933a052
--- /dev/null
+++ b/tools/perf/python/perf_live.py
@@ -0,0 +1,55 @@
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
+                            break
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

