Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795628000;
	b=pYWGulHbLnDEr00o+Y6GSpt9chU/uQ6alyrBSylvC+c0z2Onie2lTvveLA044uxPgS5M
	 BW2RVHFsl3PsnWtHBjIY0J8YH8eEEKD97vXGyv/snA75WvSzYKOoyuMIlIVEbNMHXmVYH
	 pyISQiL3cHxw1pGgmjhKJQnoq7uPM13ms3f3JYEf3CLJaZPXyNwoNgG/dCU8WMiQMteD5
	 33MGGA3TBFNEWgfWzbJtK9Lkzotczrjm+ersZzNn9XAMkg+f4DB3y5+L/eVMo8+XOQIt/
	 AWfebBdtsAoPT6zaWNDkcR2eoRcLVZo4eASziZXYe+RrQTGl5hLwT3vuN93XSGAf31Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795628000;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=gEGLKKZSPIheBUE6mJYEzB53y8VIlfjMTA5tt2Toblk=;
	b=1HkyI63DC0s6NXUyhB4eP6dMmsKbMvrpN5Q6kSOHT3jnLgBf+LxWYMRldtNOf+CwWIP6
	 kTISVD0gvWV7WYX/6loW47zFdVhIBEW34UvKXETpLbyTPSxdxvAOFq/J98vdFmVPJRht4
	 quyVYF6SlIx9N9BvfME1CMxM9o23WXf0F9hUSDOr7nj8mjpdRX10aTEWMn0L+y3OBZ3+S
	 3Jsv6xkGS9P+q3a8cD64+GuGWGd7aNb69PTOf/Val75zXQi3rHT3SHM4UMwsKdB27wWBI
	 FN1efdrde5ICCFGDTo2CSAJaU2MxlQXATeJClzteK7RiOaweNb+17sgHhDIwpfY0S7g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hOrPdtjo;
	arc=none smtp.remote-ip=209.85.215.176
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8FA9606A327
	for <linux-perf-users@vger.kernel.org>; Wed, 25 Nov 2026 17:33:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A8FA9606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hOrPdtjo
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-cdddc79a4afso2511473a12.1
        for <linux-perf-users@vger.kernel.org>; Wed, 25 Nov 2026 09:33:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795627999; x=1796232799; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=gEGLKKZSPIheBUE6mJYEzB53y8VIlfjMTA5tt2Toblk=;
        b=hOrPdtjouJxarub8kBrBIoW2ixC3AN/njO/f2iDeXguw9r2boPblVBlEUPoGXI0QTr
         TyFCewjYnk11EyZEhsQjglg9+gB68JBUyTxorjFF0n9sBFLeXy2rf7irj6xNnakIhfKo
         s7BWAgwGiAAGKbY4yRclsXSli3KleT/KubdVL+2za7iAUtOQ9Mk4NWFbbAJeaduumN4T
         rNcoyYpvGdaYhWFQLxW+724IxmT1drN1hxU+/y8YywNTEtHuWQHCrLNru+uRRc73Gl/+
         QZSY8N9nG0qy10SG+WA73mWNFKUofqsB6VkWv8DiOGwiCwp/evuhQ7y0BzzyfI0Rto8l
         IS6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795627999; x=1796232799;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gEGLKKZSPIheBUE6mJYEzB53y8VIlfjMTA5tt2Toblk=;
        b=T38kQTKVspXGSdiLf0knM32lVeNHE1x3YngReSU1g+IDfXxflnosqiojSOPaK/rqTz
         4g7f8Epw0fDcuuiExla22COkGLnxE8sD+KLDfFNutfeE4aHSyYR+og7Gkb4aILEPqVBF
         nkkcymva9qO8u68jEaE96v2CPkol2AKO2QZTm6I8wh5a9CCLB7mUMvpRRIQCXTu1oUaO
         Cabr47oPdXzPxnhef3li1CbS+YNdjCgYzBTXNa2SAaWM6FWaigJI2YgFnqtPl//IefKw
         RrYyWsi842xn2TSwJRGye6sGly/dFbk8xE/wXGqFAOOyJfBt215m6/RRGFNlJuvDosV5
         Jtkw==
X-Forwarded-Encrypted: i=1; AL+hErFZk3p0kQLIwcAjD4edDc0Q0dfnAyuW9mkKHWbyRrXuHwFle/WasZ/LYYlfwTG0dR6zVAjHSv31ojPOsJ0V96UI@vger.kernel.org
X-Gm-Message-State: APuU4Z96HY2W3nHKAFdJwq001jU8sub5B/UUSfTGkK8yV3Wy7eqqB5wB
	h5SPhcZu3Hvo6M8wRcSTcFmERHmYkON88Ap2oKcTdgvKR3JRmmJrLhKT
X-Gm-Gg: AZFdTZeJ0BbwYGYbcUtJSaPTaQkk49cA1g26TiWOgJGMRm/vVThFCOqcTr2Oh0RzcoE
	D9pQ+c25WS7AoS1Y0Lf6K5wFO4tee2RJwFO4gq1Kf/6IWfZBsb4mhfMm8JX3rt7KcA5jNqjyJOz
	aKXm43LC1dI3UUs/ZUA1ad7gh/iw3vbsHUAVeNyS1HNYp1f2RUL7JeRoR7FyVT3qjGLhO+LU22v
	hENUycXWnAJg0I0bAEBiQcs4URq3lml96z5mGO4zzMi73cM6OjbdyRLtMlKDQT64OxTg04gT5z6
	6J9dMUAAFs28EC+VEpt7829osGswsUnDywF/8JuAG3JJRNIc2rrxHUrkMJHbTIFsKsalVsVRLZ7
	L4S9ByhAdFA9I5awpyOXmel9F/4yUbxkGOjJgWBvXcEIDr6BtyQyZiz+BLydHuGT7NpNqhQ9+9L
	ImCSqVU0zgy5fKS0qMlhJf5tlaWu3YGgFdjMMDaqWqBAgxN/fDFLN8wuoZS96Rmkn793X92+KYC
	ELUorppTmWz48eOJ+J5WSD20GuGjy34MGXbAzTWDfDsGgXqIoPqsCI674+EVV8CpAD6RYTV3nxU
	PE11DZSRzch1pl+P+jQe
X-Received: by 2002:a17:90b:3f10:b0:3ac:af8b:6f3 with SMTP id 98e67ed59e1d1-3b41cb0caa7mr14597812a91.52.1795627998826;
        Wed, 25 Nov 2026 09:33:18 -0800 (PST)
Received: from a1-free ([2603:c021:8021:f000:0:1865:8c38:18fc])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b44b792474sm13334633a91.3.2026.11.25.09.33.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 09:33:18 -0800 (PST)
From: TAKANO Mitsuhiro <takano32@gmail.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>
Cc: Ian Rogers <irogers@google.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Mark Rutland <mark.rutland@arm.com>,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	TAKANO Mitsuhiro <takano32@gmail.com>
Subject: [PATCH] perf build: Replace the deprecated FileType with a helper
Date: Wed, 25 Nov 2026 17:33:15 +0000
Message-ID: <20261125173315.2359128-1-takano32@gmail.com>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

pylint-tests and pylint-pmu-events hang off `all`, so with a pylint that
reports W4904 the build fails on a tree nobody has changed.  Measured on
7.4-rc4 with Python 3.14.9 and pylint 4.0.5, both targets exit 2 and
pylint reports:

  - W4904 deprecated-class, argparse.FileType: pmu-events/jevents.py:1494
    and :1496, tests/shell/lib/perf_json_output_lint.py:23

FileType is deprecated in the class's own terms - the docstring in 3.14
reads "Deprecated factory for creating file object types" - so the two
jevents call sites and the one in the JSON output linter are replaced by
a helper that opens the file, or hands back stdout or stdin for '-',
which is what FileType did.  The reader names its encoding, as the rest
of the Python in perf does.

Verification: pylint-tests and pylint-pmu-events exit 2 and 2 before this
change and 0 and 0 after it.  The generated pmu-events tables are byte
identical either side of the change, checked by running jevents.py for
arm64 and x86 over the same input tree and comparing pmu-events.c and
pmu-events-string.c.

Written with Hermes Agent, an LLM assistant; the author reviewed it and
ran the build and the generator as described.

Signed-off-by: TAKANO Mitsuhiro <takano32@gmail.com>
---
 tools/perf/pmu-events/jevents.py              | 19 ++++++++++++++++---
 .../tests/shell/lib/perf_json_output_lint.py  | 11 ++++++++++-
 2 files changed, 26 insertions(+), 4 deletions(-)

diff --git a/tools/perf/pmu-events/jevents.py b/tools/perf/pmu-events/jevents.py
index e083f7495e67..6974c58951a3 100755
--- a/tools/perf/pmu-events/jevents.py
+++ b/tools/perf/pmu-events/jevents.py
@@ -7,7 +7,7 @@ import json
 import metric
 import os
 import sys
-from typing import (Callable, Dict, Optional, Sequence, Set, Tuple)
+from typing import (Callable, Dict, Optional, Sequence, Set, TextIO, Tuple)
 import collections
 
 # Global command line arguments.
@@ -1450,6 +1450,19 @@ def _init_worker(std_events: dict) -> None:
   global _arch_std_events
   _arch_std_events = std_events
 
+def open_output(path: str) -> TextIO:
+  """Open path for writing, or hand back stdout for '-'.
+
+  argparse.FileType is deprecated (its own docstring says so in 3.14) and
+  pylint 4 reports it, which fails the pylint-pmu-events target `all` needs.
+  """
+  if path == '-':
+    return sys.stdout
+  try:
+    return open(path, 'w', encoding='utf-8')
+  except OSError as exc:
+    raise argparse.ArgumentTypeError(str(exc)) from exc
+
 def main() -> None:
   global _args
 
@@ -1491,9 +1504,9 @@ such as "arm/cortex-a34".''',
       help='Root of tree containing architecture directories containing json files'
   )
   ap.add_argument(
-      'output_file', type=argparse.FileType('w', encoding='utf-8'), nargs='?', default=sys.stdout)
+      'output_file', type=open_output, nargs='?', default=sys.stdout)
   ap.add_argument(
-      'output_string_file', type=argparse.FileType('w', encoding='utf-8'), nargs='?', default=None)
+      'output_string_file', type=open_output, nargs='?', default=None)
   _args = ap.parse_args()
 
   _args.output_file.write(f"""/* SPDX-License-Identifier: GPL-2.0 */
diff --git a/tools/perf/tests/shell/lib/perf_json_output_lint.py b/tools/perf/tests/shell/lib/perf_json_output_lint.py
index 8cde22ac9d97..9aafd03a8114 100644
--- a/tools/perf/tests/shell/lib/perf_json_output_lint.py
+++ b/tools/perf/tests/shell/lib/perf_json_output_lint.py
@@ -6,6 +6,15 @@ import argparse
 import sys
 import json
 
+def open_input(path):
+    """Open path for reading, or hand back stdin for '-'."""
+    if path == '-':
+        return sys.stdin
+    try:
+        return open(path, encoding='utf-8')
+    except OSError as exc:
+        raise argparse.ArgumentTypeError(str(exc)) from exc
+
 ap = argparse.ArgumentParser()
 ap.add_argument('--no-args', action='store_true')
 ap.add_argument('--interval', action='store_true')
@@ -20,7 +29,7 @@ ap.add_argument('--per-die', action='store_true')
 ap.add_argument('--per-node', action='store_true')
 ap.add_argument('--per-socket', action='store_true')
 ap.add_argument('--metric-only', action='store_true')
-ap.add_argument('--file', type=argparse.FileType('r'), default=sys.stdin)
+ap.add_argument('--file', type=open_input, default=sys.stdin)
 args = ap.parse_args()
 
 Lines = args.file.readlines()

base-commit: b6a9fa34ce4187cb69d3c588a4bbffc31ce5db8f
-- 
2.53.0

