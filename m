Received: from mail-dy1-f201.google.com (mail-dy1-f201.google.com [74.125.82.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30DA23E2765
	for <linux-perf-users@vger.kernel.org>; Tue, 28 Apr 2026 07:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777360816; cv=none; b=KRACSTFaUc+Oz4wmFxWGQl1VpngCJpoPpruKtJFIK1G3wVPKAVuIkRL6gUOWPsWyP3mWlty3SVP+s9/tEZMoyCjAZjaaEyDFQbeZowIj5zYyjMmqpWrR3taqKYZbDs5YTIRs3phLyBU22Uyy31kWW3N6/AKUwG8MkMyYtkeqSvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777360816; c=relaxed/simple;
	bh=tx0Y+ZL/2KY67zQgnrtOWDh6Wuqzo7a1zM65iqPR+1c=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=X0WlxLg80Orbm+lJKCaW71opbT4so5Qvtod1n3hWm2MQdlGxQvdzU8OCqvEL3Nk9gsEHneWQjEZv6r5Q5nKaPOCACH+UINybzYCocNiys3aYtX0tluwqHy0W6YSClP/cMMNcU+QqxREmrK4R8uItljKwgrf0SNayDph5wXmZUkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LaLvbgkC; arc=none smtp.client-ip=74.125.82.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LaLvbgkC"
Received: by mail-dy1-f201.google.com with SMTP id 5a478bee46e88-2da19227bc1so27363726eec.1
        for <linux-perf-users@vger.kernel.org>; Tue, 28 Apr 2026 00:20:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777360814; x=1777965614; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=FIUPQnj9Sm31hxCjwi2GzFaWFVwRkKGchfSFKojE+/g=;
        b=LaLvbgkC91YoOyJuCCLDYCVx6LmIUX0wM6WMBlfahACznw+nwmEEeL3yw4kvZtKrAm
         hnU5NMYr/Z+gDFKYqnmLIA16ucvJhQHuc/qSXJ/wmJ9jrvD/GQRt+j/wlsCyii/PFpbG
         Sw6hoaU4Kq7tmQi3TqUq8M+6tCcNmO092oAOZZdN4ZUQkN5oyreAk6+w+Ctz+GGGdAFT
         zQg20fW5f7Ur9ulgaM0AfYKaFfLlg4czozQT0phRvRahkJieb1M7+pczQaWEqqeFV2+k
         jq1lsqFKjoqcX8B7q4TmO53Csi1K0ppW/T5VMMJSMRgy/qu5sIJjRnpH/me834zflqvl
         zMWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777360814; x=1777965614;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FIUPQnj9Sm31hxCjwi2GzFaWFVwRkKGchfSFKojE+/g=;
        b=lGTyAHTvcaBEt/Kbug2VtkMpVVLLMD54VVPogzgvYO3lkQsi2MgiZVwGkSc6Pi9Xee
         86VU4ejpbgX27DWEIt68lv4+2gf8Ccky3zC1pFYh3ygXIoYKb0yuMe3kYgUwGgipjCNR
         cwDKSD8l073n+DHErAw31WnwumJUVCMCTEPdaZhtygnfREhtOgnM5Eezm1hIOW8CaHGj
         WkK49aeJZDTFB0Afa4/AZw3EbYp9eSrhyO5vqaNW/+i6hcPe4s4PVoGaEl2GNmWzS6oD
         P5mzIYnfTuMvCHT4oHwAQLuI2FzoAYZ9qJE9p0C2IAAvZz0tOZ4iljcmj9IAvv3xY6ZB
         IWlw==
X-Forwarded-Encrypted: i=1; AFNElJ9IZjaSGyFv4cJ9Gzv30Zu3UanjyN7BH4vYmQ3DTiP5Xm+wPRCw+0V6xOBl49EJrzb+/X1/IiBFGraEfsg62yy7@vger.kernel.org
X-Gm-Message-State: AOJu0Yzm2XvwlIC8VlxNR1VPRk/ZtctpMUsOqy2bGVLoCSadPBHM3509
	mTMgistU1FA1iFQ/NV6DvAQSE0clmkbWxr0//1XfAeDTsaSIfFNqxhw9/twvDyQ4ilepW514z20
	f7SRaaJd8wA==
X-Received: from dycoy3.prod.google.com ([2002:a05:7301:fc03:b0:2e0:fe68:96c7])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:3b06:b0:2e1:f72:3f18
 with SMTP id 5a478bee46e88-2ed09fe6f94mr1039140eec.1.1777360814160; Tue, 28
 Apr 2026 00:20:14 -0700 (PDT)
Date: Tue, 28 Apr 2026 00:18:33 -0700
In-Reply-To: <20260428071903.1886173-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260425224951.174663-1-irogers@google.com> <20260428071903.1886173-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260428071903.1886173-29-irogers@google.com>
Subject: [PATCH v8 28/58] perf syscall-counts-by-pid: Port syscall-counts-by-pid
 to use python module
From: Ian Rogers <irogers@google.com>
To: acme@kernel.org, namhyung@kernel.org
Cc: adrian.hunter@intel.com, alice.mei.rogers@gmail.com, 
	dapeng1.mi@linux.intel.com, james.clark@linaro.org, leo.yan@linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, mingo@redhat.com, peterz@infradead.org, 
	tmricht@linux.ibm.com, Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"

Rewrite tools/perf/scripts/python/syscall-counts-by-pid.py to use the
python module and various style changes. By avoiding the overheads in
the `perf script` execution the performance improves by more than 3.8x
as shown in the following (with PYTHON_PATH and PERF_EXEC_PATH set as
necessary):

```
$ perf record -e raw_syscalls:sys_enter -a sleep 1
...
$ time perf script tools/perf/scripts/python/syscall-counts-by-pid.py perf
Install the python-audit package to get syscall names.
For example:
  # apt-get install python3-audit (Ubuntu)
  # yum install python3-audit (Fedora)
  etc.

Press control+C to stop and show the summary
Warning:
1 out of order events recorded.

syscall events for perf:

comm [pid]/syscalls                            count
 ---------------------------------------  ----------

perf [3886080]
  1                                           538989
  16                                              32
  203                                             17
  3                                                2
  257                                              1
  204                                              1
  15                                               1
  0                                                1

perf [3886082]
  7                                                1

real    0m3.852s
user    0m3.512s
sys     0m0.336s
$ time python3 tools/perf/python/syscall-counts-by-pid.py perf
Warning:
1 out of order events recorded.

syscall events for perf:

comm [pid]/syscalls                           count
 --------------------------------------- -----------

perf [3886080]
  write                                      538989
  ioctl                                          32
  sched_setaffinity                              17
  close                                           2
  openat                                          1
  sched_getaffinity                               1
  rt_sigreturn                                    1
  read                                            1

perf [3886082]
  poll                                            1

real    0m1.011s
user    0m0.963s
sys     0m0.048s
```

Assisted-by: Gemini:gemini-3.1-pro-preview
Signed-off-by: Ian Rogers <irogers@google.com>
---
v2:

1. Removed Unused Variable: Removed id_keys which was assigned but
   never read.

2. Fallback for Unknown Syscalls: If perf.syscall_name() returns None
   for an unmapped ID, it now falls back to the numeric ID string to
   prevent TypeError crashes during string formatting.

3. Fallback for Syscall Number Attribute: It now checks for
   __syscall_nr first, and if missing, falls back to checking for nr .

4. Robust Process Resolution: Added a try-except block around
   session.process(sample.pid).comm() to handle untracked PIDs
   gracefully instead of crashing on a TypeError .

5. Restored PID Filtering: The script now attempts to parse the
   positional argument as an integer to filter by Process ID. If that
   fails, it treats it as a command name (COMM) string to filter by,
   restoring behavior from the original legacy script.

6. Support for Custom Input Files: Added a -i / --input command-line
   argument to support arbitrarily named trace files, removing the
   hardcoded "perf.data" restriction.
---
 tools/perf/python/syscall-counts-by-pid.py | 88 ++++++++++++++++++++++
 1 file changed, 88 insertions(+)
 create mode 100755 tools/perf/python/syscall-counts-by-pid.py

diff --git a/tools/perf/python/syscall-counts-by-pid.py b/tools/perf/python/syscall-counts-by-pid.py
new file mode 100755
index 000000000000..ff962334a143
--- /dev/null
+++ b/tools/perf/python/syscall-counts-by-pid.py
@@ -0,0 +1,88 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: GPL-2.0
+"""
+Displays system-wide system call totals, broken down by syscall.
+If a [comm] arg is specified, only syscalls called by [comm] are displayed.
+"""
+
+import argparse
+from collections import defaultdict
+import perf
+
+syscalls: dict[tuple[str, int, int], int] = defaultdict(int)
+for_comm = None
+for_pid = None
+session = None
+
+
+def print_syscall_totals():
+    """Print aggregated statistics."""
+    if for_comm is not None:
+        print(f"\nsyscall events for {for_comm}:\n")
+    elif for_pid is not None:
+        print(f"\nsyscall events for PID {for_pid}:\n")
+    else:
+        print("\nsyscall events:\n")
+
+    print(f"{'comm [pid]/syscalls':<40} {'count':>10}")
+    print("---------------------------------------- -----------")
+
+    sorted_keys = sorted(syscalls.keys(), key=lambda k: (k[0], k[1], k[2]))
+    current_comm_pid = None
+    for comm, pid, sc_id in sorted_keys:
+        if current_comm_pid != (comm, pid):
+            print(f"\n{comm} [{pid}]")
+            current_comm_pid = (comm, pid)
+        name = perf.syscall_name(sc_id) or str(sc_id)
+        print(f"  {name:<38} {syscalls[(comm, pid, sc_id)]:>10}")
+
+
+def process_event(sample):
+    """Process a single sample event."""
+    event_name = str(sample.evsel)
+    if event_name == "evsel(raw_syscalls:sys_enter)":
+        sc_id = getattr(sample, "id", -1)
+    elif event_name.startswith("evsel(syscalls:sys_enter_"):
+        sc_id = getattr(sample, "__syscall_nr", None)
+        if sc_id is None:
+            sc_id = getattr(sample, "nr", -1)
+    else:
+        return
+
+    if sc_id == -1:
+        return
+
+    pid = sample.sample_pid
+
+    if for_pid and pid != for_pid:
+        return
+
+    comm = "unknown"
+    try:
+        if session:
+            proc = session.find_thread(pid)
+            if proc:
+                comm = proc.comm()
+    except (TypeError, AttributeError):
+        pass
+
+    if for_comm and comm != for_comm:
+        return
+    syscalls[(comm, pid, sc_id)] += 1
+
+
+if __name__ == "__main__":
+    ap = argparse.ArgumentParser()
+    ap.add_argument("filter", nargs="?", help="COMM or PID to filter by")
+    ap.add_argument("-i", "--input", default="perf.data", help="Input file name")
+    args = ap.parse_args()
+
+    if args.filter:
+        try:
+            for_pid = int(args.filter)
+        except ValueError:
+            for_comm = args.filter
+
+    session = perf.session(perf.data(args.input), sample=process_event)
+    session.process_events()
+    print_syscall_totals()
-- 
2.54.0.545.g6539524ca2-goog

