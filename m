Received: from mail-dy1-f202.google.com (mail-dy1-f202.google.com [74.125.82.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90DCC3D0927
	for <linux-perf-users@vger.kernel.org>; Sat, 13 Jun 2026 05:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781328492; cv=none; b=XKkWBEh1uLaX5TbjpaH5QmId1cGBgdnXQS8SzvpCaKKUlCZn5vWRld2kh08Fo3MF+PQOx0BvQv3rEKOVMb3q9lqzEYO6BKezbvgRurn/H9OUYVsge/dhtHCb+5LBV56Gwg0Edx1Rkjnugrg5N5QJk2nQ4Uv8JMeQNT9Lq0tAOMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781328492; c=relaxed/simple;
	bh=qOf1Wd7zgs8S1zE2z0Om6/yIsdiCHCh+jtIDOS7g64M=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=lBnlXomXrweCz7odb+4RXC0AC/TWLl9bYv84YH6vtU61opWr0JdRuoXZI1zdRn8d5vA9V7UMQwJnZfeBSpKsXSRqG2xhZi330t0RRmuwCJBevrdw8d91toazUAfNlDen+3QHERNVeBTYKbPcxsS1UQR40TZun4li3hJIXjvNjEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IN7vXUHA; arc=none smtp.client-ip=74.125.82.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IN7vXUHA"
Received: by mail-dy1-f202.google.com with SMTP id 5a478bee46e88-3075fa5a407so854023eec.1
        for <linux-perf-users@vger.kernel.org>; Fri, 12 Jun 2026 22:28:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781328487; x=1781933287; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zOKcWEflCtB2iI3mAyKxrWp4CrQAheZW6CDWW+PkO+0=;
        b=IN7vXUHAQSxJwAT4EsCW6qPGXeN+P8TDXDU4ZKqZkDoS0HqSsMUTlmkfmM+EYQdLl5
         iMa/x0CIDkSrYT72q0UXq8e+VTZbpaLRSCtGugwUqu9SOZ6q213Kd54AvTVoQYGtVsSN
         vhy7oNQg7DTz+rMxcLkdZ4I/F2A2r3w54VlVrdPMD5F2Qvz6Mtm0hf2G3Q4mhmykcdfc
         EtbwXfB02LdGXQTEwOnQDhJ4ASxEfIls1sfbE7Dx/VnE7wRGPRg19iXzf7tHqjFuocpx
         USib59mXDYWvyuk66CRIUG44EvtNBP5zWaJzjLfnoz8fUnvgkfP/mFDexC+JiuckuRlZ
         Zm4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781328487; x=1781933287;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=zOKcWEflCtB2iI3mAyKxrWp4CrQAheZW6CDWW+PkO+0=;
        b=DHcwci37fRDwKGcct4LqPmSrts0RhXbv8bORGaFgzUxp1Nz6qGG29BnNUkfMmx/oYa
         Pz8LeI3TOdqwDFX6OOt1YxGPEC/PT8KvxdDpQaYuPQt6iE7EffhIybKZyXE6YCccXjvn
         eQEp+0J9SiGXBVmLp9i/9W+l80O+rFE4uvEab66I6IjhacieKUIriZ1lARQJhyec6VSN
         VCUI9uHrmT9qSQJf1yGXuwwpr0GUf4iZf4T9igR8N40s5SPkf7DjjsB/WD7x2YgcOmFH
         X0TL8gFP2YfoKnjkd28AYOJRgV0+cb2eEw5ravwJ8ZfffFKjhuMKPKmVY+xcyiPGclyO
         Mstg==
X-Forwarded-Encrypted: i=1; AFNElJ8vfZOt6CITj2+JWii2dWfk8rvAgixhfmojys9itqMja4f3uSE+w7ylk2T2JtNuuUGrIDT/JKWHRlLgzUTCXvKS@vger.kernel.org
X-Gm-Message-State: AOJu0YxmCbb1Kx0mgvNrLihPM5j1r2ZlCzTFfnS0L3oXstfqqZwXkCQA
	RajFtFxm6CSrQSIUvBEr49Foe48A7eGafshFS881hLBOg3c6aj1mUuGTu7QZ4AtHCmbEo5mJQBY
	ATBZr3TyF+Q==
X-Received: from dybcb9.prod.google.com ([2002:a05:7300:a509:b0:304:591d:1ede])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:693c:2d98:b0:304:5bee:f59d
 with SMTP id 5a478bee46e88-309413ae6fbmr1495333eec.29.1781328486266; Fri, 12
 Jun 2026 22:28:06 -0700 (PDT)
Date: Fri, 12 Jun 2026 22:27:21 -0700
In-Reply-To: <20260613052722.1424093-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260612221211.1221305-1-irogers@google.com> <20260613052722.1424093-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.1136.gdb2ca164c4-goog
Message-ID: <20260613052722.1424093-21-irogers@google.com>
Subject: [PATCH v16 20/20] perf python: Add LiveSession helper
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

