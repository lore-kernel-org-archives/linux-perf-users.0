Received: from mail-dl1-f73.google.com (mail-dl1-f73.google.com [74.125.82.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74ED2406269
	for <linux-perf-users@vger.kernel.org>; Tue, 28 Apr 2026 07:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777360856; cv=none; b=WCaQmtWO+kJ/fci6nw7lyBOdxAaZZqa4t1ZeJ06uXrCVUccNbeKCGCxtltXENLM7GrAqG4lXSG82im976OSvhbWiQ5x5/EjqygxWnI2sNaL/vlRn14Fkq0gyAyCHkXdjO9ST2Yr1g17f8HUCN2d2QrXagjVUsZNtZHL922kdzLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777360856; c=relaxed/simple;
	bh=HIj/4KwQviJzAdb5/BAWEjqXZ2sYv3oOaIee/0kObPI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=kXpp/Mc2P4lIIAkd2V+UHU5kHxyvr7D8WACNFJdHedBuMbcwIUHLJ4gV3Lr8ly/Qhodjymbu4BoIRD7RpMNrqx9TjZX5hJeniRXHlMsylJ60T3mY1W7tTDbHhm60IGB5chUm/g3m0tgGVfXuJIFgd7/H5myWyjrWjCBRYghGlk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BfgErzmr; arc=none smtp.client-ip=74.125.82.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BfgErzmr"
Received: by mail-dl1-f73.google.com with SMTP id a92af1059eb24-12c21dbc9c1so42619781c88.0
        for <linux-perf-users@vger.kernel.org>; Tue, 28 Apr 2026 00:20:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777360854; x=1777965654; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=22aR7BdMkfc4F5hxQy/Qmu6pnO70TcMwJUmCFfE13QY=;
        b=BfgErzmrpiGcW3eBlHVklXoO9pM82U1F93IK9rZLHpyhYiU0M3oz56eNCJOVAvs9w1
         priut+pLmTz6rrmdIYxN6OhrWXBSwKM9lHK4eah/8nMUPUePEXM3jcw9P28k6y2pWo5F
         Csw6oHq8YewIRSpWdEdwhADJAqDWBeLVPNLskvRqPFXq/0l4GEM82Gb302CqdQ271LmT
         FllLXc4kgJzkc+tepU9O8lPW6kMDNRgXbuOvqTdAix/FUVF7YPRx0LS7xlpoEv3i/WVe
         8xk94Uw0g119HQmWR19JFjTHoG73Y53Z0T/1ezSBl4ec1DVh2Q5+fkwt5Idi3FBLrB1P
         beig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777360854; x=1777965654;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=22aR7BdMkfc4F5hxQy/Qmu6pnO70TcMwJUmCFfE13QY=;
        b=fltuv3t/Twi4pLKwqxJi9K2HyapOelPy1TAIUDex6qmx6G2ya3ag5OSB763Uzxy4JO
         UqikFBueG5iyM9TSFbZRD7ANs/zUta9evZ/anvSPbyfdsSh4qqk3zdnDjalN3bnnVAyr
         LiXg2GMEcXqUFGego8YRbVpaPyaZVIZe2bT8gBWlNgIXGMTEd3bjILykhnkhT6Oo+tMD
         z8h56BG2aVV2a3u8Gl9adxqpNThjmml5QuRM7q2MFMtsx2jzOEwtalLuBzmO1D1EjI54
         ZJLJ1dFXXUd6xnIhynNu1PS2Yfnr7TKzdxutrpX6s6JR/WLLLf+0gAMBZ/amzW1VX2Ph
         jyDw==
X-Forwarded-Encrypted: i=1; AFNElJ+34pWt/gVOREibVvV558RGEnOnm2VGLzEgZUE/4seDgny5zDMAfvACEKZbHHZ4RBfNbBtNdvGq6MsBl7Tu67Bv@vger.kernel.org
X-Gm-Message-State: AOJu0YysgG02KRpAyh7PLkCYeWzKtJxq/yOzoHxWt0fCCRZAK2lq3jYX
	CrjzFZ+ck8mG+0qH5Dzu9FpSB6f3QKqfsJkAyHUqN262AduvkpfiZ2CfgJFTNQ2cS+qwTfKSv0b
	aKlhXKyUHpQ==
X-Received: from dlbvg6.prod.google.com ([2002:a05:7022:7f06:b0:12d:b396:eadf])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:4188:b0:11b:1c7e:27d0
 with SMTP id a92af1059eb24-12ddd8b0339mr1040319c88.0.1777360853370; Tue, 28
 Apr 2026 00:20:53 -0700 (PDT)
Date: Tue, 28 Apr 2026 00:18:52 -0700
In-Reply-To: <20260428071903.1886173-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260425224951.174663-1-irogers@google.com> <20260428071903.1886173-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260428071903.1886173-48-irogers@google.com>
Subject: [PATCH v8 47/58] perf failed-syscalls: Port failed-syscalls to use
 python module
From: Ian Rogers <irogers@google.com>
To: acme@kernel.org, namhyung@kernel.org
Cc: adrian.hunter@intel.com, alice.mei.rogers@gmail.com, 
	dapeng1.mi@linux.intel.com, james.clark@linaro.org, leo.yan@linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, mingo@redhat.com, peterz@infradead.org, 
	tmricht@linux.ibm.com, Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"

Port the legacy Perl script failed-syscalls.pl to a python script
using the perf module in tools/perf/python.

The new script uses a class-based architecture and leverages the
perf.session API for event processing, making it a standalone script
that reads perf.data files.

It filters for sys_exit events, checks for failed syscalls (where
return value ret < 0), and aggregates counts per command name.

Complications:
- The script is designed for file-based processing using perf.session.
- pylint warns about the module name not being snake_case, but it is
  kept for consistency with the original script name.

Assisted-by: Gemini:gemini-3.1-pro-preview
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/python/failed-syscalls.py | 78 ++++++++++++++++++++++++++++
 1 file changed, 78 insertions(+)
 create mode 100755 tools/perf/python/failed-syscalls.py

diff --git a/tools/perf/python/failed-syscalls.py b/tools/perf/python/failed-syscalls.py
new file mode 100755
index 000000000000..c3b58664eb57
--- /dev/null
+++ b/tools/perf/python/failed-syscalls.py
@@ -0,0 +1,78 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: GPL-2.0
+"""Failed system call counts."""
+
+import argparse
+from collections import defaultdict
+import sys
+from typing import Optional
+import perf
+
+class FailedSyscalls:
+    """Tracks and displays failed system call totals."""
+    def __init__(self, comm: Optional[str] = None) -> None:
+        self.failed_syscalls: dict[str, int] = defaultdict(int)
+        self.for_comm = comm
+        self.session: Optional[perf.session] = None
+        self.unhandled: dict[str, int] = defaultdict(int)
+
+    def process_event(self, sample: perf.sample_event) -> None:
+        """Process sys_exit events."""
+        event_name = str(sample.evsel)
+        if not event_name.startswith("evsel(syscalls:sys_exit_") and \
+           not event_name.startswith("evsel(raw_syscalls:sys_exit_"):
+            return
+
+        try:
+            ret = sample.ret
+        except AttributeError:
+            self.unhandled[event_name] += 1
+            return
+
+        if ret >= 0:
+            return
+
+        pid = sample.sample_pid
+        assert self.session is not None
+        try:
+            comm = self.session.find_thread(pid).comm()
+        except Exception: # pylint: disable=broad-except
+            comm = "unknown"
+
+        if self.for_comm and comm != self.for_comm:
+            return
+
+        self.failed_syscalls[comm] += 1
+
+    def print_totals(self) -> None:
+        """Print summary table."""
+        print("\nfailed syscalls by comm:\n")
+        print(f"{'comm':<20s}  {'# errors':>10s}")
+        print(f"{'-'*20}  {'-'*10}")
+
+        for comm, val in sorted(self.failed_syscalls.items(),
+                                key=lambda kv: (kv[1], kv[0]), reverse=True):
+            print(f"{comm:<20s}  {val:10d}")
+
+    def run(self, input_file: str) -> None:
+        """Run the session."""
+        self.session = perf.session(perf.data(input_file), sample=self.process_event)
+        self.session.process_events()
+        self.print_totals()
+
+def main() -> None:
+    """Main function."""
+    parser = argparse.ArgumentParser(description="Trace failed syscalls")
+    parser.add_argument("comm", nargs="?", help="Filter by command name")
+    parser.add_argument("-i", "--input", default="perf.data", help="Input file")
+    args = parser.parse_args()
+
+    analyzer = FailedSyscalls(args.comm)
+    try:
+        analyzer.run(args.input)
+    except IOError as e:
+        print(e, file=sys.stderr)
+        sys.exit(1)
+
+if __name__ == "__main__":
+    main()
-- 
2.54.0.545.g6539524ca2-goog

