Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794540574;
	b=RhRF6wjoGCmH9lYKyjHOsoUDQO/7oCWiFX692h1e6UOeQY855/NK6fCYzSWRN9CfphLo
	 Lu/n1SuAoEap3LKjrjLKfNMd+cNGW++hrKKFpP0wdBoX76fZB6Sw8a34cLLDq3L/WQFNY
	 Uq5zy7IzOdrOP8PrrSc8Ktt3mX/JdmDCxWFVma39QAiXCGc0IBOV71nCjI4mWo0EJBPUd
	 ZRPDUvSJGKp/eDOSroU7f3hVmDsuC7RXTK7+/amjRQhf+3qcTmjV5vKe4Mv4ZFwAdPQ6Q
	 2HJ67w+5wuniXmLQONcNlpbN/rMbeoTjoMgSJxCcj9rA5ClR0eyrjGBpareoazY/5zw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794540574;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=nwrxOe/glF1Pq2cxsA4bK6k2mkf6sPrkS844eYud2JQ=;
	b=uYoClD6cISIzncJqpzQHWulG0HBu1B/o4h9Ry8WQhPG7WwVydc83a5Byb4hK3eZKFklR
	 YsNN5qtt7NcsICl9SzqT2as6csKxOBUOm8PszbOH1SS+fpCyFz4qa7DUHU/wWrVV2xKWe
	 7zYN5JYgufw3Yg87G9WH2J9OvgkqozZfrw/6WdDPGVZaqPAmzeKRN5SmZgVLQsB6mUgBh
	 IxGwPSt0i/uI4y+eMkOrGCDa4cg2J6AgNvacg+PCVLva7PiGn9N3K2U4Dtc/zMaDhNibN
	 XWihN036KHoKn9namRRuTQ1HeqLAzuIiOiLHqZIS+duEqCeWe9nDgdb5545wU+rjjKg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=NZ9Cb7Xx;
	arc=none smtp.remote-ip=74.125.82.54
Received: from mail-dl1-f54.google.com (mail-dl1-f54.google.com [74.125.82.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2E8F606A884
	for <linux-perf-users@vger.kernel.org>; Fri, 13 Nov 2026 03:29:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E2E8F606A884
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=NZ9Cb7Xx
Received: by mail-dl1-f54.google.com with SMTP id a92af1059eb24-1a2761c69fbso1077001c88.0
        for <linux-perf-users@vger.kernel.org>; Thu, 12 Nov 2026 19:29:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794540573; x=1795145373; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nwrxOe/glF1Pq2cxsA4bK6k2mkf6sPrkS844eYud2JQ=;
        b=NZ9Cb7XxiACGHxeJ9PjL2gqTYg7MmPZSxeLtP12HL0s2lJLnOureIM4MKomYqSGt0M
         /TJ/wRH17VKvTvHcgBHQANwLWQfT6HhJG6XdR6QQ/44X4mpjMkDmuCbm1UhLx5ceH1nz
         r90eE0Vfec+6UvkcGTc8K8m4YPt1dqgE8VMljn+aKwkoWNMa9mQNejRXCGahmgBh105+
         mYTSVbFVZ/ktwhm+wqwj/CX+uQ9pvSwA2FvR6F5bt3XG+aFCzfKPEkLwKcrl6gSeykkM
         ytrzR2tyb4LU+9lAB+Vtxa2KMoSxPHttdyBFmSuB5btsrGHHMGJJWsyinC1WFb8hQaUl
         lxpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794540573; x=1795145373;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=nwrxOe/glF1Pq2cxsA4bK6k2mkf6sPrkS844eYud2JQ=;
        b=bDPrP7PXksddncEwWjZvBuP7NpFzBO33pgjs4v7Goe4JEyX3U5JIncA2mqeYIUa0OU
         bOguX54fnu7vhinW9rkpvuHw0AsNa/G7umrgu0h49SpRNoL6gPkx64I838bsoQTCLDAi
         f+KZ6VanuRkxbZXQXMv/eQEn3fvVKdajv1SNk0pjnixqy9JSD6HmegScuyYLc5LOIrIq
         d+3yv7C2hwRe8bFtTtuUxfLhEz+hN+tK/fNeeO8wOfH7vLNh3btlsIdB+9pOrt4uZQI8
         LTptwD/+fmhnk9mEQEclU2JN2ebl2a6sRp1ulFSeuSbwBF8ussfg305HErN2/bgNTdVs
         xCUA==
X-Gm-Message-State: APuU4Z/hKFsCD8Yl3t91tXF+GA4SxeipScTUm5Kfm12TUMj9QTNiHZEI
	TJZtUXMm16Do2Z+aYbnESIG0LY6j0fxCUZlot/hfWKA7JJ1gx/K+rD927YCiKA==
X-Gm-Gg: AYBFou0vTPOAmJLJtaEZYzGNbTtoPBkIZ37trnQ8PiJDQjAkmBrPFb04HLLmELEeBUQ
	Ngk0/rA0bQy4CkvsVxDDRmZgxU7DX9n+bVRll60F0NSLJMMumm5IfZ4iMnSXyqt+I/VnBXfgas3
	PSLCKujElb0txh+fi4mKvIs+M2I+Yn+JSZ/K9xQ86uEIEK1yz1upzBJnzzMB8p5eMXu6o+JMRxJ
	OBTRIGbB69gN720tqU0QnTRoWqp8nG9idmfpuhBLe19vS796OokEZNRo3qZtu97seaEXb8xoC61
	nWulpSRpFhkyrF0hf6z+TFaouJYkyJbSwU/yuU97nwq1IcrtiCTGSDVJBD1sYGQBqDKUKE7mwCa
	0Q0vLSPHW9pt8lwzu3xNv6b+81YSPy3hC6hFAPMRr2NrLRqHMSxVbrpv88Md/A6eZCC4tSOAjnR
	bET1OIOhBLhy6I3/D0aNH5EBlK7cw/06ciT5r1/1qOt/i5kZkEA2JWXdWMRskat82QNU9+mJBQA
	3rwmpoychm7lmbFo7sCu0k+y/lP5IMXvYqWXKEA00IS6Gsy/GV2SXAbL5qaDKFSbQ2fzv6o/hQi
	rRYEnEE1tN90F25SBpBj
X-Received: by 2002:a05:7023:a4b:20b0:1a4:3fa7:adef with SMTP id a92af1059eb24-1b5031bbaecmr1435822c88.47.1794540572777;
        Thu, 12 Nov 2026 19:29:32 -0800 (PST)
Received: from a1-free ([161.33.196.121])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b50309b27dsm3029718c88.2.2026.11.12.19.29.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 19:29:32 -0800 (PST)
From: TAKANO Mitsuhiro <takano32@gmail.com>
To: linux-perf-users@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>
Cc: Ian Rogers <irogers@google.com>,
	James Clark <james.clark@linaro.org>,
	John Garry <john.garry@linux.dev>,
	linux-kernel@vger.kernel.org,
	TAKANO Mitsuhiro <takano32@gmail.com>
Subject: [PATCH v10 1/1] perf jevents: Check the keys of the JSON tables
Date: Fri, 13 Nov 2026 03:29:27 +0000
Message-ID: <20261113032927.634183-2-takano32@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261113032927.634183-1-takano32@gmail.com>
References: <20261112222526.462146-1-takano32@gmail.com>
 <20261113032927.634183-1-takano32@gmail.com>
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

--check reads its directory before the parser asks for the three
positional arguments, so it needs no dummy architecture and model, and it
takes "--check=DIR" as well as "--check DIR".  A directory that is not
there is reported instead of passed, since nothing found under it would
otherwise read as a clean tree.

On the tree today it reports 19 keys in four tables.

Signed-off-by: TAKANO Mitsuhiro <takano32@gmail.com>
---
v10: the two fixes v9 described were missing from the diff v9 carried;
     they are in this one.  The check itself is unchanged.

 tools/perf/pmu-events/jevents.py        | 48 +++++++++++++++++++++++++
 tools/perf/tests/shell/jevents_check.sh | 36 +++++++++++++++++++
 2 files changed, 84 insertions(+)
 create mode 100755 tools/perf/tests/shell/jevents_check.sh

diff --git a/tools/perf/pmu-events/jevents.py b/tools/perf/pmu-events/jevents.py
index 080e04b51b8c..4bbaba7086c5 100755
--- a/tools/perf/pmu-events/jevents.py
+++ b/tools/perf/pmu-events/jevents.py
@@ -7,6 +7,7 @@ import json
 import metric
 import os
 import sys
+from pathlib import Path
 from typing import (Callable, Dict, Optional, Sequence, Set, Tuple)
 import collections
 
@@ -1450,9 +1451,56 @@ def _init_worker(std_events: dict) -> None:
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
+  if not os.path.isdir(root):
+    print(f'{root}: not a directory', file=sys.stderr)
+    return 2
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
+  # before the parser below asks for the three positional arguments.  Both
+  # "--check DIR" and "--check=DIR" are accepted.
+  for i, arg in enumerate(sys.argv[1:]):
+    if arg != '--check' and not arg.startswith('--check='):
+      continue
+    if arg.startswith('--check='):
+      root = arg.split('=', 1)[1]
+    else:
+      root = sys.argv[i + 2] if len(sys.argv) > i + 2 else ''
+    sys.exit(_check_tables(root))
+
   def dir_path(path: str) -> str:
     """Validate path is a directory for argparse."""
     if os.path.isdir(path):
diff --git a/tools/perf/tests/shell/jevents_check.sh b/tools/perf/tests/shell/jevents_check.sh
new file mode 100755
index 000000000000..b596f8bc509d
--- /dev/null
+++ b/tools/perf/tests/shell/jevents_check.sh
@@ -0,0 +1,36 @@
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
+# A directory that is not there is an error, not a clean tree.
+"${python}" "${jevents}" --check "${tmp}/nodir" > /dev/null 2>&1 && exit 1
+
+# The key is an option, so "--check=DIR" works the same as "--check DIR".
+printf '[{"EventName": "a", "EventCode": "0x1"}]\n' > "${tables}/events.json"
+"${python}" "${jevents}" "--check=${tmp}/arch" > /dev/null || exit 1
+
+exit 0
-- 
2.53.0

