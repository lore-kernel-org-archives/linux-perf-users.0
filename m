Received: from mail-dy1-f201.google.com (mail-dy1-f201.google.com [74.125.82.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4945D4DB579
	for <linux-perf-users@vger.kernel.org>; Thu, 11 Jun 2026 22:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781217941; cv=none; b=rMLxy9jLaBXW4AFdTFC6ZSvePF2mcR8qQ1bx3sCHzJa1Ci1o66ZofIBzAeRwx0I2WQzbnEd3hicsc9UVtCg6VHqlBuz7Z5DULHYecXft4IfJhn44q/Y5T/tTsdndVel2FiOJF+ijDQF8Wf9VvJbmRLKRKeHGpNeEJ9jW3Ym7LF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781217941; c=relaxed/simple;
	bh=p8oIONdzVrlfJr1SJZe3A/QVqrVWmzS0BQoKisqexlQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=T/wfD1eXvbvjckktnUjvNXXaxbgUCmDdfyemA6DtQ8+JzlujTg9Y0iyt/1viuFArsAwdNdY0MwIfN5C0/xl4gRzuyNveJwm2YMbGEZzpzXHYyZmcRPZ1jHXXnP7kMKwzWTpbUwcRuspyBCquR20tMDlgxzXpGhaghu3pz3JZHuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=S1EYqIQy; arc=none smtp.client-ip=74.125.82.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="S1EYqIQy"
Received: by mail-dy1-f201.google.com with SMTP id 5a478bee46e88-3074d4102a9so1132617eec.0
        for <linux-perf-users@vger.kernel.org>; Thu, 11 Jun 2026 15:45:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781217939; x=1781822739; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8aQcbdma71h7K8kHl773QM35IjB3UaGYzxNEo2WcOAg=;
        b=S1EYqIQyBAbUY8oeS7qUpANLKqSWL2XEMdksr1eljd83DccRV+ZAyFYdOctk9p6IA0
         HlVttAWnBuMZXKy+sC2llhY09F6CFGjP4C7PECif8RkGk12DXMlWPfA8iMTxAj5BgPFS
         KzaEn5Z7M4lgfDwVFRMl5YSK1DwhE1C/QGC3xp4FbOrZCI7A4MVJvRccmsvd31FTrd2W
         4Zi5sVpGaZ6Jt1zVkGyiFro9CaOfq7gb1UeJeVNNfbM9qgGunCT5UtnyRbQGd7h4VAyX
         LH5hfHctMc5BbBF7IaWNkwHzEwxBtmjqUwwz6IUIHpdlMUNPR/WTBExLb7K1yydNupSR
         rQwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781217939; x=1781822739;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=8aQcbdma71h7K8kHl773QM35IjB3UaGYzxNEo2WcOAg=;
        b=aieXZsuu1DO+SE9GHUgVcasyOf9G2/vf/44FNqCS6E6de4S/Hqsdq2SrPzfCnL8Uid
         vvc87eWJ6L11kUpEBvmUxboqKE62skrdJCjgdJEbCOSAtQHuwZqAnd4hg3RdqsS6AlmA
         g7jXZtdvFRuAJ4hWVD0TrbXO5XjVlFeuD4Arg3+pQlS+aVIDtCZMxfgMXkYns1735AY8
         P+vm/G1FVmThrhDWgDIPz6P2jfSlscXGC6ma3hTuR7bw2SoCD/m+DcOoYf893Wtu/5za
         Xiw87O/99nNirSx32pc/KF+gzIajcpz+fNVD88t18TwktXmYFEA/PtVrs6vQzfybl79V
         72Nw==
X-Forwarded-Encrypted: i=1; AFNElJ/AwpFeEqvsC2L/caCU9IPli+iRH3OTxJLauGGnDQ6yXbD5JH9My6x5gHSujCgP1BreG4Fj9j6j4bGlanDHgdVR@vger.kernel.org
X-Gm-Message-State: AOJu0YzV9n5kHc4md11PgqOTd8l/IVIIUK0KnUBfrWIBk0oGyrF69aZA
	Yy0RUUHV6CZKPyoKqgvUahrMOlX/nadVE8d2Xh38AyN2QB7q45NOai+S+zw0gJy3ttL6kPInK32
	XgofuDmSCfg==
X-Received: from dyji23.prod.google.com ([2002:a05:7300:7a17:b0:2f6:ff42:df28])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:320a:b0:307:2e1c:17f1
 with SMTP id 5a478bee46e88-308201deb6fmr240340eec.25.1781217939168; Thu, 11
 Jun 2026 15:45:39 -0700 (PDT)
Date: Thu, 11 Jun 2026 15:44:55 -0700
In-Reply-To: <20260611224455.201994-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260611171756.4008769-1-irogers@google.com> <20260611224455.201994-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.1136.gdb2ca164c4-goog
Message-ID: <20260611224455.201994-20-irogers@google.com>
Subject: [PATCH v13 19/19] perf python: Add LiveSession helper
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

