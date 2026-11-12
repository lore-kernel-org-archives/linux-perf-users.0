Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794504771;
	b=cGAh7VHwniuFeUZ69Cq3Kom9pZ3pPob+3usd0bL0BR6Uxtj5rUEpch6gfXsxTBgX23L8
	 Yvfm+uxAOluqEuFoR5sOVYG9PkDT+gLgyqA8LHXHoerQrSsJlt91Ujrlu8wj0B+AXYGDP
	 1ZFkEFBrLp7P8oxoSqO+R2Tv9t7uJizNVDwAfWguC4FI6iPZCHX8FU24SVmC0jnIyqDsV
	 9gV9+cMX9equWE8mfUjuGqQxOCDdmiaR5rucEQOWZzFiVvkiV0fNgiX5TlEfjHhXAG4+v
	 jAsaCz09d/iQdAKdpK5T7HtAgJSYOxPDFfMZggf57Vjt2U6DIlxKZvn7VmTrduz2ENA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794504771;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=SEUumPJHJkZeDnIM1ODuPZ5omuUgcXpheI3jyCf4At8=;
	b=IIE/Ms+RF3kIgRzpFwEOIYMlvtZMC30Sn6dK6oHQSdpYIoRCu1/y1gz3COhDRMhJ3AeW
	 yflcLXeso7mrlOiV/xpPaYcWK93LvDnorHV/pOV7/anjbyQspWCdMuhWg0163xPgU2C7J
	 p46+MFnTKTahM/pjuFtbiLD+cgmn/In0yJKQgWfPea6dB4xCPqD95eCs1If4fJ9V6NPDS
	 CLejsj9Hfi0Vew3TOLHKLmOJh3EkJ1epeztHmFfLeASBnYdHrXymdntPDOTeN5wWYdNPd
	 E88H65NfX2+xqwxdrRUUGCS8sr6dPvtARMcqYJHi0IsLMAJ65M0yNN1E1LvSyOlCyQA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=enGfzmdI;
	arc=none smtp.remote-ip=74.125.82.50
Received: from mail-dl1-f50.google.com (mail-dl1-f50.google.com [74.125.82.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43EB1606A884
	for <linux-perf-users@vger.kernel.org>; Thu, 12 Nov 2026 17:32:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 43EB1606A884
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=enGfzmdI
Received: by mail-dl1-f50.google.com with SMTP id a92af1059eb24-1b3b4944a0eso566254c88.0
        for <linux-perf-users@vger.kernel.org>; Thu, 12 Nov 2026 09:32:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794504770; x=1795109570; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SEUumPJHJkZeDnIM1ODuPZ5omuUgcXpheI3jyCf4At8=;
        b=enGfzmdIC/sa3AzTg64ECecRtkxMs6Y/hzNrtDwuNIEpDcCwb++0a7t7k2h1DBUBAC
         4JLAqsrLFI2SPhDUJprn2zNXIkhwgBPr19ZS7qU5yBWdgB5aROoNHKASqvaDDcqAD+Yg
         4P0Oqrz7+zFPXzHSacjHj8nrDVbBw5lTczL11Sag6EdFzBFF6Ewdu2S3I1VqxvhiU2+h
         r8cgerdVVYnBW7ov4bjS7jWHtsMZXhzyhBc6uT9+S2DBYal/BZMaef6fb9BOtqGGBL9V
         C6zSlA6SzkJYTtWBPbroDvacwDYrRfqczQo7R6E7/f7dDyoWOjKTLuNaUAef1Unu9FkU
         OIAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794504770; x=1795109570;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=SEUumPJHJkZeDnIM1ODuPZ5omuUgcXpheI3jyCf4At8=;
        b=F2cOEag4gcXJnqI2ST+IVWD7ZcnkCqqKbRxITf5UxgeKETZxiwdlCDQgSdu2RAc8iA
         6rrgPR16QPWERu7ZdZZTuX6EjGxLQ+9OW3g0CMwnciayn4LbSTM0VpScXw/C06c1QvRv
         k0r1dqDFvaU6eekQ5dEp8leglpebQEsgWDdaw6i9cS6SLIeAgOAlVXCXCMpVQ+LZGRPL
         EwzwpNkxhnDoJgY0vn5t//imVZbxKZRKQUTr3yTPtpkH1VtqUCTR0zONJT4znp/j0EZ3
         ZGxx0fGxEK7piaO1YmSQOKQZUnUB65/n0s2VCr6KP5N+Du7CgaHrkCzdeKJ4iNtE/ObF
         bsVw==
X-Gm-Message-State: APuU4Z/cM2PHMWSxMueFvyaufNCl+BzTKYTWNx7IeGaNBBAnk6iKCaPR
	P5P5l2LMgtkQMi41d9550t+mb7VG/hZyAQCoNgfbCe8oD4kwBoYbIoNdnstgBKxQ
X-Gm-Gg: AYBFou1nqDdtW/pLlsN0ITdtAgSgNs+HhX6+qyL/ENIR4QMSL7oAoRGIY2RbWoiY0PU
	8Qadee/GGDD9tidOVki0eVxqJlhqdqJ2jKUCrgj4pVFGqGduumRinfck8d2SkXiHwD+E3zY4TX9
	5Az7rHk4J5bVubgG4A6BUw/HoDvtUTIAGZ1O6Pu0QcIji+3TI/vCBy4Y72FLoOguYx4g9nRRx9B
	korlun7yC9Nb+vqKOPdcQWS1rxxnpZUERjeIsSL0XlElNtms3XZmT7nRSAnghc823FTaw/ZnsU7
	VbUhy/HlkCdgS8aeQRpkHrlnzBRDRk/tETAJbD1Gegr2lwDb2Py6Q/FYvzcfNYtnPNWk4NFPB51
	sKVRtu/DnL7AwHHsNtWD18GFwn+qsokKNKEWq3wARGtzLkFEtKWWWb6Q8y0In4Bdb+1XcZeNggO
	VO6Cs8pNdcOcVqMwj5CSPeBenic+c8tVYH3B7CIxaqnBdeld8AI8bC5PUoJAam74jTYS+cD4R+Z
	eehLGRFPNdl075zNl1D+qVP8d3gkBdvysoscojJiGzkH9j50DoK784X0NPtINoehHVlDYpvcvCv
	LaYnLVw9qFGd8kPckwPKhuV2FPl+MNei8lwSRf9OVA==
X-Received: by 2002:a05:7023:904:b0:1ac:2f6d:e1c6 with SMTP id a92af1059eb24-1b503068271mr243860c88.6.1794504770162;
        Thu, 12 Nov 2026 09:32:50 -0800 (PST)
Received: from a1-free ([161.33.196.121])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b50316e008sm379345c88.6.2026.11.12.09.32.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 09:32:48 -0800 (PST)
From: TAKANO Mitsuhiro <takano32@gmail.com>
To: linux-perf-users@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>
Cc: Ian Rogers <irogers@google.com>,
	James Clark <james.clark@linaro.org>,
	John Garry <john.garry@linux.dev>,
	linux-kernel@vger.kernel.org,
	TAKANO Mitsuhiro <takano32@gmail.com>
Subject: [PATCH v8 1/1] perf jevents: Check the keys of the JSON tables
Date: Thu, 12 Nov 2026 17:32:41 +0000
Message-ID: <20261112173241.197996-2-takano32@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261112173241.197996-1-takano32@gmail.com>
References: <20261112162823.139419-1-takano32@gmail.com>
 <20261112173241.197996-1-takano32@gmail.com>
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

jevents.py takes the fields it wants out of each JSON object by name and
ignores the rest, so a key that is spelled differently is dropped without
a word and the object is built without whatever that field held.  Two of
those are in the tree: "PublicDescrition" in 16 entries of an Arm table,
and "BriefDescript6ion" in one entry each of three AMD tables.

A table may carry 51 keys; 47 of them jevents.py reads, one more metric.py
reads, and three are read by nothing although the tables hold them
(Counter, CountersNumFixed, CountersNumGeneric).  A key outside that list
is reported with the file that carries it.  There is no cut-off, no
similarity and nothing that depends on what a run of the generator
happened to read.

The check is not a JSON schema because perf's build would then require
jsonschema, which it does not use today and which is not in every
builder's python.  It runs as a perf test, not as part of the build.

On the tree today it reports 19 keys in four tables.

Signed-off-by: TAKANO Mitsuhiro <takano32@gmail.com>
---
v8: --check takes the directory as its own argument, so it does not need
    the arch and model the generator takes; the test uses PYTHON and exits
    2 when the interpreter is missing.  The check is unchanged.

 tools/perf/pmu-events/jevents.py        | 41 +++++++++++++++++++++++++
 tools/perf/tests/shell/jevents_check.sh | 29 +++++++++++++++++
 2 files changed, 70 insertions(+)
 create mode 100755 tools/perf/tests/shell/jevents_check.sh

diff --git a/tools/perf/pmu-events/jevents.py b/tools/perf/pmu-events/jevents.py
index 080e04b51b8c..5daf92527573 100755
--- a/tools/perf/pmu-events/jevents.py
+++ b/tools/perf/pmu-events/jevents.py
@@ -7,6 +7,7 @@ import json
 import metric
 import os
 import sys
+from pathlib import Path
 from typing import (Callable, Dict, Optional, Sequence, Set, Tuple)
 import collections
 
@@ -1450,9 +1451,49 @@ def _init_worker(std_events: dict) -> None:
   global _arch_std_events
   _arch_std_events = std_events
 
+# The keys a json object under arch/ may carry.  jevents.py takes the fields it
+# wants by name and ignores the rest, so a key that is spelled differently is
+# dropped without a word; this is the list a table is allowed to contain.
+_TABLE_KEYS: Set[str] = {
+    'AggregationMode', 'AnyThread', 'ArchStdEvent', 'BriefDescription',
+    'Compat', 'ConfigCode', 'Counter', 'CounterMask',
+    'CountersNumFixed', 'CountersNumGeneric', 'Data_LA', 'DefaultMetricgroupName',
+    'DefaultShowEvents', 'Deprecated', 'EdgeDetect', 'EnAllCores',
+    'EnAllSlices', 'Errata', 'EventCode', 'EventidCode',
+    'EventName', 'Experimental', 'ExtSel', 'FCMask',
+    'Filter', 'Invert', 'LegacyCacheCode', 'LegacyConfigCode',
+    'MetricConstraint', 'MetricExpr', 'MetricGroup', 'MetricgroupNoGroup',
+    'MetricName', 'MetricThreshold', 'MSRIndex', 'MSRValue',
+    'NodeType', 'PEBS', 'PerPkg', 'PortMask',
+    'PublicDescription', 'RdWrMask', 'RetirementLatencyMax', 'RetirementLatencyMean',
+    'RetirementLatencyMin', 'SampleAfterValue', 'ScaleUnit', 'SliceId',
+    'ThreadMask', 'UMask', 'Unit',
+}
+
+def _check_tables(root: str) -> int:
+  """Report the keys in the tables under root that a table may not carry."""
+  bad = 0
+  for path in sorted(Path(root).rglob('*.json')):
+    if path.name.endswith('metricgroups.json'):
+      # A dictionary keyed by metric group name, not a list of events.
+      continue
+    for obj in json.loads(path.read_text(encoding='utf-8')):
+      if extra := set(obj) - _TABLE_KEYS:
+        print(f'{path}: {sorted(extra)}')
+        bad += 1
+  return 1 if bad else 0
+
 def main() -> None:
   global _args
 
+  # --check takes the directory to check and needs nothing else, so it is read
+  # before the parser below asks for the three positional arguments.
+  if '--check' in sys.argv:
+    ap = argparse.ArgumentParser()
+    ap.add_argument('--check', metavar='DIR', required=True,
+                    help='report the keys of the tables under DIR and exit')
+    sys.exit(_check_tables(ap.parse_args().check))
+
   def dir_path(path: str) -> str:
     """Validate path is a directory for argparse."""
     if os.path.isdir(path):
diff --git a/tools/perf/tests/shell/jevents_check.sh b/tools/perf/tests/shell/jevents_check.sh
new file mode 100755
index 000000000000..62ce70ef5d02
--- /dev/null
+++ b/tools/perf/tests/shell/jevents_check.sh
@@ -0,0 +1,29 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+# jevents_check: an unknown key in a table is reported (no_mlock)
+#
+# A key that is spelled differently is dropped without a word, so the keys of
+# the tables are checked against the list jevents.py reads.
+
+jevents=$(dirname "$0")/../../pmu-events/jevents.py
+python=${PYTHON:-python3}
+
+# An installed perf has the test but not the generator, and a python that
+# cannot run the generator is not a failure of the check.
+[ -r "${jevents}" ] || exit 2
+command -v "${python}" > /dev/null || exit 2
+
+tmp=$(mktemp -d)
+trap 'rm -rf "${tmp}"' EXIT
+tables="${tmp}/arch/x86/model"
+mkdir -p "${tables}"
+
+# Known keys pass.
+printf '[{"EventName": "a", "EventCode": "0x1"}]\n' > "${tables}/events.json"
+"${python}" "${jevents}" --check "${tmp}/arch" > /dev/null || exit 1
+
+# A key the generator does not read is reported.
+printf '[{"EventName": "a", "NotAKey": "x"}]\n' > "${tables}/events.json"
+"${python}" "${jevents}" --check "${tmp}/arch" > /dev/null && exit 1
+
+exit 0
-- 
2.53.0

