Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794500910;
	b=b9oipEmnDeOL+ERccqULIxXxuIcIKl4xypiZHhS1jsAZUXzlzy75G6QjmoVEItORGTbU
	 kHN9OG/DsxCkNLuCcMbTZkn4DRxWwJGCRrvsEubnUWM2ogJ/WBkahkbA+Cgcdi5TaLJUT
	 bXIA+GpFPRkbffeIRgLNKAf+bffnBqRlu/40hV6CWMlX0QhjlqHta1O6vMTiS1dfSqGdz
	 R7fzbpCJDmXq7YE3HDZLHXSKVeoABaS2GebzVLE+QEQ9ABfyVJQYuPWw5ElolYArRQLOB
	 J7QxGGgDPOetQofgeoTyrGE0y0+MKsLgoCpmEa5R08owwEM4+SUqQxRQNzf3bi1Jh3w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794500910;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=t9y8aiDtqIYr2UUcNo+ETnhfWQ+ZQeLMTEENsKtwAjA=;
	b=yx+6L0+ZES2FRSA0wdF498Tt8GnM5kbiO1xXYsSLzIyPEM7OB/Xwa58akqYytZCsUJPt
	 oIUx2AuwguKEAng7g9VZidXJOeCamCN5Ipl+Z92OqySIhlDHBKL6iFsEQPZqgJ0hrEp5+
	 hI8rHfE+imRCkvDtCDWLtsBVB9GJr5SifIWVrMpIi93xDlEH+HjGk/VFbqjmIvBYS96Is
	 UFzaQqLjSqRsRryRXhr3WfoSmnypk8Jv8a+9aIuAaQJKSILmlTVZDuZ9sUIRIcv1iknDI
	 AERGHdxXVjhEuz6Y9eZVnrUM/o14wGbFxP55xvLZYTVfFd/91W4ZBhrhu7O/k8RsMjg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="tI/NFp1h";
	arc=none smtp.remote-ip=74.125.82.174
Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 732B1606A32D
	for <linux-perf-users@vger.kernel.org>; Thu, 12 Nov 2026 16:28:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 732B1606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=tI/NFp1h
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-36f8cdd30beso67951eec.1
        for <linux-perf-users@vger.kernel.org>; Thu, 12 Nov 2026 08:28:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794500909; x=1795105709; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=t9y8aiDtqIYr2UUcNo+ETnhfWQ+ZQeLMTEENsKtwAjA=;
        b=tI/NFp1hQeR16D14Ri0Ql75GM+ezI8Kl3EbcTLdm0bOlY/HOkPDEPCksyRYdbdtRP+
         Hj+x5MYdsL0Xrq5PXPBQYijJX5Cz0YZa6XEeapV2PZOkU10tNa3oQ/T6REavFp6/tfQ+
         a/QLZXe66uXolB70KglHBI5FC369sZi1bULRazQV/P2uswT5Pt5Uf3Lq/notP7eZJYvT
         tCOXKop9WkDF/8KiBc4e4s74ASR5XV4JROP2lt7fpeHI4AadW7cQQJBBNSmt3dXDGK3p
         yi0z6OP5KFsHIGn7mqELadV+nNggYYvFbTz4HYZJadkT+eJoHt65MVYCj8Qhj5AX04FB
         V/Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794500909; x=1795105709;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=t9y8aiDtqIYr2UUcNo+ETnhfWQ+ZQeLMTEENsKtwAjA=;
        b=2vnmvT0meobrVhXSf1KXoPQ6QOuo0pxeONlpXe1sWyjLXCLGpGarxcKmJDEf5HaJo8
         vGJvscdhlErQnaiO/7i0LrjyqCXyIyso0+4bm9Nn7uIYk4IiHjcwA2VW4G/ODSswuofA
         J4E7HXgIvbRQB/bT+Fv5BE+XWfbAUCFynz1F9IMdi+4FNDk5f8o3mRS1uWScfUX1/od8
         LcmBplI4RFTU53C2IdKru7p2N5nEcRZDkRzGXr8O48CDSxTsExDp0GATBohKIZV5auny
         nowlpNL3GJsoSYX3dHEwQD/Pd0qUwrbXxBpxKZy3kfDVz0djC3v90pvPT+SFHput63vv
         mt1w==
X-Gm-Message-State: APuU4Z9FX/Yu4Nw1LvnJ2UA6OzOSpa42ohBFRusQ+rqyXwy1mEv/8PKu
	P5VKnySvAfs+SDLmxUH8tnNDgbPsADlZ3sYgd5f0+nzIXK1TT0IKVD00whyW+y7S
X-Gm-Gg: AYBFou0gWBrNdM/4w6nmTk6bMTDImEi8iAHj+JKx9MLcmPxu+oY4fVYU4EyFFncKJSm
	pHKAFNxFG6tkEXIP78fF63GvQxchIP2mbRCFxFe5+W6t2MNeTeaTlYKQWOsBAtKCeEyWDnQGakR
	hXf4orB4yHIF+dc+tuLMmKMfK+Iwq6sZvSTcisDuWtfwKoCaSKAyahN+f8JYWJ5hkbilUFF9/yu
	96NpAGwxMuupTvW7ScIhMOZMP0maftLsGK+HbIrIm3rql7/CvVijkwPzYqIB6pf07S2D+RN0Tyc
	WLIS2lHXg7MHHk067v/gNv/XtGQZ1Nwa7G8fxTQFMGHILN5CsIhd+cbeUIaCJfGPbiliVfpK+MI
	kizEiuB9JCNedK229etNF4ij5zs2YUGwN2IrE5nq79WCflslMkWpSPAAXfBzdF6BA85Yq9D3RMt
	hsB7Aazz9IMFlExZxomcGmlxVi8Jo0oSl9VsLZCJfj6A1X84KtNY4AmIuVL4DvyxAee7AMtOh0B
	5/eVoDAIvZmWDXo3BUePcOT1zft0FR06xfyPlTBE3dIDlxtUQ4XvD8/pb56Yv7sfah88BuU6ha5
	RsK12ADpLU/kRWeVwXVL
X-Received: by 2002:a05:693c:69d4:b0:36d:25e:1961 with SMTP id 5a478bee46e88-37686660c99mr6096366eec.22.1794500909214;
        Thu, 12 Nov 2026 08:28:29 -0800 (PST)
Received: from a1-free ([161.33.196.121])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-37926251a09sm705997eec.23.2026.11.12.08.28.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 08:28:28 -0800 (PST)
From: TAKANO Mitsuhiro <takano32@gmail.com>
To: linux-perf-users@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>
Cc: Ian Rogers <irogers@google.com>,
	James Clark <james.clark@linaro.org>,
	John Garry <john.garry@linux.dev>,
	linux-kernel@vger.kernel.org,
	TAKANO Mitsuhiro <takano32@gmail.com>
Subject: [PATCH v7 1/1] perf jevents: Check the keys of the JSON tables
Date: Thu, 12 Nov 2026 16:28:23 +0000
Message-ID: <20261112162823.139419-2-takano32@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261112162823.139419-1-takano32@gmail.com>
References: <20261111150920.2383157-1-takano32@gmail.com>
 <20261112162823.139419-1-takano32@gmail.com>
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
v7: one patch instead of three.  Patches 1 and 2 are dropped with the
    Makefile target, the arch filter, the summary line and the handling
    of tables that hold a single object; what is left is the walk, the
    set difference against the list, and the file the object is in.

 tools/perf/pmu-events/jevents.py        | 38 +++++++++++++++++++++++++
 tools/perf/tests/shell/jevents_check.sh | 24 ++++++++++++++++
 2 files changed, 62 insertions(+)
 create mode 100755 tools/perf/tests/shell/jevents_check.sh

diff --git a/tools/perf/pmu-events/jevents.py b/tools/perf/pmu-events/jevents.py
index 080e04b51b8c..397b4fc97749 100755
--- a/tools/perf/pmu-events/jevents.py
+++ b/tools/perf/pmu-events/jevents.py
@@ -7,6 +7,7 @@ import json
 import metric
 import os
 import sys
+from pathlib import Path
 from typing import (Callable, Dict, Optional, Sequence, Set, Tuple)
 import collections
 
@@ -1450,6 +1451,38 @@ def _init_worker(std_events: dict) -> None:
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
 
@@ -1494,8 +1527,13 @@ such as "arm/cortex-a34".''',
       'output_file', type=argparse.FileType('w', encoding='utf-8'), nargs='?', default=sys.stdout)
   ap.add_argument(
       'output_string_file', type=argparse.FileType('w', encoding='utf-8'), nargs='?', default=None)
+  ap.add_argument('--check', action='store_true',
+                  help='check the keys of the tables under starting_dir and exit')
   _args = ap.parse_args()
 
+  if _args.check:
+    sys.exit(_check_tables(_args.starting_dir))
+
   _args.output_file.write(f"""/* SPDX-License-Identifier: GPL-2.0 */
 /* THIS FILE WAS AUTOGENERATED BY `jevents.py arch={_args.arch} model={_args.model}` ! */
 """)
diff --git a/tools/perf/tests/shell/jevents_check.sh b/tools/perf/tests/shell/jevents_check.sh
new file mode 100755
index 000000000000..eb3125e1486a
--- /dev/null
+++ b/tools/perf/tests/shell/jevents_check.sh
@@ -0,0 +1,24 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+# jevents_check: an unknown key in a table is reported (no_mlock)
+#
+# A key that is spelled differently is dropped without a word, so the keys of
+# the tables are checked against the list jevents.py reads.
+
+jevents=$(dirname "$0")/../../pmu-events/jevents.py
+[ -r "${jevents}" ] || exit 2
+
+tmp=$(mktemp -d)
+trap 'rm -rf "${tmp}"' EXIT
+tables="${tmp}/arch/x86/model"
+mkdir -p "${tables}"
+
+# Known keys pass.
+printf '[{"EventName": "a", "EventCode": "0x1"}]\n' > "${tables}/events.json"
+python3 "${jevents}" x86 all "${tmp}/arch" --check > /dev/null || exit 1
+
+# A key the generator does not read is reported.
+printf '[{"EventName": "a", "NotAKey": "x"}]\n' > "${tables}/events.json"
+python3 "${jevents}" x86 all "${tmp}/arch" --check > /dev/null && exit 1
+
+exit 0
-- 
2.53.0

