Received: from mail-dl1-f73.google.com (mail-dl1-f73.google.com [74.125.82.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22C813D5C07
	for <linux-perf-users@vger.kernel.org>; Fri, 12 Jun 2026 22:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781302395; cv=none; b=tIeQ/1Nj3QRK9nIS+ZlNaHYBXA0F//qDaDor33zCjiWfrJH99/3WLGg2N6jZ5hY1cXUOjNGJwGvldiEQ4VaZCxIDwIClrsePD7MvQftDsjEbnHt1OfJ3vP53oMTdgZBamh1Ijg1zQSOinxdeEwaNYLTD1+F+dMs122NJOBsACJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781302395; c=relaxed/simple;
	bh=qOf1Wd7zgs8S1zE2z0Om6/yIsdiCHCh+jtIDOS7g64M=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=CDWBxBQPdOPFSXUSY07dHN1kt4dpSU8+DOkwQKpadSR/RGBsuCpiwq/eIgWwEyRY2ok6rucUYG1vyi1WyN8j8dHHfMP74DGRycIXdrgt7YOskbuFDaRerx+qLe66Pf0yeRU91XzudFFh7XvX1xcYwSrgwkmE/+hJEz+XoVzo2vk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=so7vBzCl; arc=none smtp.client-ip=74.125.82.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="so7vBzCl"
Received: by mail-dl1-f73.google.com with SMTP id a92af1059eb24-1383678095cso5746906c88.0
        for <linux-perf-users@vger.kernel.org>; Fri, 12 Jun 2026 15:13:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781302393; x=1781907193; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zOKcWEflCtB2iI3mAyKxrWp4CrQAheZW6CDWW+PkO+0=;
        b=so7vBzClPKSHbpggOP7elwFzdDiWRINxZ3B0nyh9fTnNltPkkpyRvKl/pX+DiKYgNT
         pFfMXDFJ3SkZzP/ioarfxW9a3kiuID11c/PesPODtDegw0HYt1wzTCUOVcNP1zsXD/yR
         CF40upM39MnDdo7xVEQBiJfy8QZSiIpUUqY30FvxkddT85chwTF5jVcW36oRBUVlUBRz
         GhJnD/+rOePh75KxwIS4b/P+bY3cq4NvY+RECPlde0+KzDHtxlarz2ecKcdSY6nI+PbY
         RzjFwfw/dfVzVlT30K87d+F8ayksk8UwG5IkRZHJSwd73gC2X/Gq3KBshkdi3hhhCBCA
         fY9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781302393; x=1781907193;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=zOKcWEflCtB2iI3mAyKxrWp4CrQAheZW6CDWW+PkO+0=;
        b=EU0DZJBW7Nqq6n4tiCA3ChWG/ez63cQZ8eXKrcA3L1wlXac5FNU3kaNDSjzj5xxjjs
         /LqvTsyLKPsGaHWSdWB4wCRvKShnFiXpTHOEi3hUYccPP/oQtsOiJ46PxpZT1DRK6G7f
         7OZjrnVqoFbtG9sNmUycslv68GhSZpZgER5EMnA8uXdBOClhEluDTIBnYN4ySTRiRJhe
         y34FFs8k5fUf5XbPstipYF3ohsHbWdG2gheC8HuBXB2QNYSdhCiGO40gdUeGU5ZO3gaM
         eFs3BhAwFXUcWqCc/MJXUtNPQQ9FI3ktfofnFPngd5FrcBynYMimsLkWsM6y+vTckpYd
         699w==
X-Forwarded-Encrypted: i=1; AFNElJ+SbAssrTHCeVOGgDYZAW17cfu76ADXdSx2Sl1Is6q+HmFu/xtPqlwppOOLyTszQqRMQi+ZGwJG4zTNqTFqcgnm@vger.kernel.org
X-Gm-Message-State: AOJu0YzptvY0NDhsFuQ5M2oZF083zXUBLRRIyN7KOXsO4SAq/5KCzL58
	omTn4bMrPOqNkx7AIQWW6BlhtPGaUvIK6vFXEBrb/9lyxL90CxeQu6NgSEtw1/9UUvRTmY3jQeq
	AimeGdGNr5w==
X-Received: from dlbsi8.prod.google.com ([2002:a05:7022:b888:b0:138:5e8:1b36])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:6089:b0:138:407c:1d20
 with SMTP id a92af1059eb24-1384bb9446cmr2301133c88.35.1781302392754; Fri, 12
 Jun 2026 15:13:12 -0700 (PDT)
Date: Fri, 12 Jun 2026 15:12:11 -0700
In-Reply-To: <20260612221211.1221305-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260612180956.1105352-1-irogers@google.com> <20260612221211.1221305-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.1136.gdb2ca164c4-goog
Message-ID: <20260612221211.1221305-20-irogers@google.com>
Subject: [PATCH v15 19/19] perf python: Add LiveSession helper
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

