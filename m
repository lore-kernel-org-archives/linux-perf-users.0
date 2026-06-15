Received: from mail-dl1-f74.google.com (mail-dl1-f74.google.com [74.125.82.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FFA83C455B
	for <linux-perf-users@vger.kernel.org>; Mon, 15 Jun 2026 22:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781562674; cv=none; b=HsvqmpdD9ehMNxXBEInzZXup5ZckL1GtPlfycV44rgLD1BHszxxxWePPhOB8igtUj4Ft7e699ZqT1gTExuDYG9M5zbuV9GuyDKh8XJgIHUDgpyWOqeH1kBft7vk4b6+x/32tk0bY+sSm4ftPkYdBkjkfM9PuTDrb6DfQ/A+E1GY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781562674; c=relaxed/simple;
	bh=4dLo4HpbrybbnBf8shD12wCKP55rLDF16HiWGceZngg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=kainVua2NstWzJyLrf2qvwUG3y9lPdPRIThUNNC92rtR61RJdRSU+6vHxVCJ6pKc8s+r7v4vlat2DvblwOruKnTlVctrFjzNciBHHIG6B5qoY03xF4KN39I7H2p68tNx3DKfvtxfSWpFaUpBaLxQDq+sPb1Xk3ZgSk2qblU3oJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fQX6Jg/M; arc=none smtp.client-ip=74.125.82.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fQX6Jg/M"
Received: by mail-dl1-f74.google.com with SMTP id a92af1059eb24-137fe4a3640so6018800c88.0
        for <linux-perf-users@vger.kernel.org>; Mon, 15 Jun 2026 15:31:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781562671; x=1782167471; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=4JIEJjPFYpgehV0e0DCUgUFbnCz0JdtZUpoEiWCHJq8=;
        b=fQX6Jg/MdvuPyGbn4WDUMbzNfWmGaZrs36DS1FEYwO3Nr8l/UQQyH+1GifRi1/9vV9
         h4+NWJyOKSsuuvU2fqLQgep2NJ04Obxg6bbEPqOsF2QX7UqL2vgpGrqRQRSzlwZOlFFe
         XtXH5luG0QoEoJWjr7EblynWKso0gzA3bGzFatTLPq3Lv6lFjS6g4rpGbOsCNz5CJOq+
         WaPff7KvNZboQKfVTLwMSBh6sZTU7XxxQazwmHs0mqgSdzv5R7hckhw0527QbMG/RXJv
         CF3+8uIygm6598oBHaQ/MVSS/bdyhgmzQv67PVf58D3Y4f4afQJFTE3R16e3N//Tgxjt
         XQKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781562671; x=1782167471;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4JIEJjPFYpgehV0e0DCUgUFbnCz0JdtZUpoEiWCHJq8=;
        b=TKV+6NFxUDcFQNrUC47Yn5eRlwDfkt3Nel2gjY453IZ0lG5aer9qnxWQO9ISkw4Pne
         SrGTM/m4kLQH5dSQOk9KTClJCjXIorL5K0p9j5pf1jqqkHL8V1TOFByj+5de0VpKLo6y
         vly96oswTHHINVXvOKOpguHETXdiqRpxIBoyePGfUl8KZCFq7pmbOKUEn4nb8M9RH9Hk
         s2nJ66Kq8k7q6rtT/pRJM8rD/SdAc+URWs8YLVmwFqNT+UCS0uInUL1UfVy9pl6dXZ7r
         GriUw1e+UbrJGk7Mi9N9h+Mx0t3fA5CBDcjNMFx46Wv15HV/JZKxhhM4qomkGHDieTD7
         Rwyg==
X-Forwarded-Encrypted: i=1; AFNElJ/YguenWCoD5XyTTWY4/JIIRjrMI5GYDLI0ON1Uzhfm8W1o38zUYI4kb3XTf8jSLZEcJ8uOhTNstvxgEO9LqvdV@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5PqZ35eiWjSRWS05lVIA5ChUZHNqzhnQ7LdMxKP8vUJnlpK0U
	s57lylcsmUc10HWeqSTcPMtDSr39QRUvosts8Dn5VtTCcbNnoOL9DxvrYtF0UdzBzdEbHalFVO/
	ulX9l7zvWZQ==
X-Received: from dlbrh9.prod.google.com ([2002:a05:7022:f309:b0:138:7a2:6b03])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:6a3:b0:137:fc71:664e
 with SMTP id a92af1059eb24-13985eb2ea6mr461498c88.4.1781562670919; Mon, 15
 Jun 2026 15:31:10 -0700 (PDT)
Date: Mon, 15 Jun 2026 15:30:11 -0700
In-Reply-To: <20260615223011.3873955-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260615061631.2382079-1-irogers@google.com> <20260615223011.3873955-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.1136.gdb2ca164c4-goog
Message-ID: <20260615223011.3873955-22-irogers@google.com>
Subject: [PATCH v20 21/21] perf python: Add LiveSession helper
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

