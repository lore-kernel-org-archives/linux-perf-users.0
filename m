Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794522333;
	b=AQYNAWKxKeURhy/mRtmLR2jcpP1oZgOFo2OtWrYZH66jM+MLZpv9zDKra819msMjwgua
	 eCI29CvIepG4frq5f1UI8QGiCuAyTulGbirmmu4EKu/hJ9Wn5/QPDuoUpALoy39QoKVC8
	 otysRA+M1JkgoDA4ilhie/uK8gtrujSEmxHSaMPE+MWt1WYA6JhzhzOs0utuDk0eAtRDw
	 DRebOQOG039GIvmKDKDA1bSD/GL2jYIpIy+E4H6K9jXLsdTVLhKx/pI1k21A5uE79/j4d
	 8QVVGOMtqspCIwnSgDTC2iyIAeoUvTlc+tDE0gkNRqqGIWn92NMSNA5ZW2H1A+br0cA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794522333;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=bC9E+Xy5lrGC1NjpEAmZOwXJIfoiDXgA93Wfzb0jhx0=;
	b=1lrVi4oXdwTWq7ntpwLgPwpfvfrjcXOQ1GOa4A+E9Niah2vgmf7ve3JPDPu7yDEG/8yV
	 h/U5mnv1KUUQLqOqNGSplXNC02htedMxN59lUX1hWqz1MNNH0/YW/BulqqMsaFptXO/3Z
	 y0T1Ga5k+5ja7n9JD5hqtR/Cd0JwbxmvERuat6oywHm8ZvaOBwl1jEKEqhckAWi/ZRhgX
	 YfyjVYXEmGouizQ5nnocEUiIsIpv/ITJcWEWTPIYxozD9H3USFYvA1zGDhq+1OykinPrq
	 YDRHYxAmZxvKou++i51gwLPX8XC9cOuGrHImj9sinIA3yCsKyWMWltyJhKj5jhle56Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=TxJrzCJu;
	arc=none smtp.remote-ip=74.125.82.44
Received: from mail-dl1-f44.google.com (mail-dl1-f44.google.com [74.125.82.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 920BC606A336
	for <linux-perf-users@vger.kernel.org>; Thu, 12 Nov 2026 22:25:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 920BC606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=TxJrzCJu
Received: by mail-dl1-f44.google.com with SMTP id a92af1059eb24-1b3beeaf6f9so268075c88.0
        for <linux-perf-users@vger.kernel.org>; Thu, 12 Nov 2026 14:25:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794522332; x=1795127132; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bC9E+Xy5lrGC1NjpEAmZOwXJIfoiDXgA93Wfzb0jhx0=;
        b=TxJrzCJugWJAEf0v8jFJ851gtCjp2mp1GqcXr9IRQi0ND8MzJMqxOBrieWhZ6bxzit
         IgbNOrVh1eaj5mhbOCj0gMQ/0joW71ua2ETw63NeO13NVM/PmYprMzv+0VeyqCBVrVSU
         I/s8Os3CbqHvY0wYQFO1tBkhRoMOLUpn9dlsVC3Pmg8gYaI5o1krTw7lZ+8CfpifrxiM
         7K959efGaJ1hAWqTuaqr97lOLQlpXhidwrwFJvYfzXvITJhnTJtEz9FQcpttn2SDRjEv
         LEhG5kIMxgZvgQjM2WARrYycQzLDkSx0lim4bSXnUepcIW2DIknyvd7myHDPoAOXyKjA
         ISNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794522332; x=1795127132;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=bC9E+Xy5lrGC1NjpEAmZOwXJIfoiDXgA93Wfzb0jhx0=;
        b=SKzc4m8CM6aTPYQrYc/qRZ17C3mJdifZQxTJuDmtNbUHH6n29izsatH+0JkhUJnCb8
         DXo3s0X17Lzx4O2sPfs6w4OtPwl/BX1d55FocdkDWO2OeVcG0aM5i3bdMK18xlUnHhAD
         DWE+MtgpWdzGduEjTeVVCVLZQGKc3dmamVG48yE9w5GNCqJKgHo1bOyOF/mN/gzUNCxS
         GSb4FKz5uNmpgl4O83sRd4xi4fFPYYfBxFpaNVqYHpYmg2f+kl7/iBTX2yFnLjX7Hlc0
         NZEieJzCYYa9udFu5LAoApgJJfGyeP/HRkxCcWcl2dt6Y2kmFyARCJkPchnh2/iFGOFH
         0y2Q==
X-Gm-Message-State: APuU4Z8lLsHMpcW/xpBk09w/MUcV+8cmUWmHkwdDoPSL0iFF4bzYM642
	6SVsbsGwYhLPWfhNxneTBLvKWimQNoq0+SqnRDa7FbJrG4/OkpGlg1GS8ZhctWus
X-Gm-Gg: AYBFou2P0YStcGBs5lc8nK7/ZCgcmKItqCqE8k1GhtUBZY3oRZW8fVUcPmUdlv41MXP
	P/ru+wbSG1Hk1ludzCzILSPa5hOPhot1uTBkqgUf4mzWwlZTBuyUtCNZuPi8HhLBymfEHO54Wjs
	KjN8sN40nv8InYpF5Mc3u+rL1QpLMHs7ZEWWUzUoYOKmPUwzj+8RUkggoOSzQ78QsObhdbRCq3h
	oU5eGL1OFIN1+I6m0UHrgmeYZCvS0P7R3QTZ1SvJEh4js2MewmPJ2fI0QWC48xhe41tv5dIkYzG
	ImKPyjBwJGonoM/f9mWZ7d+xpa3tidnPNJ96C5zNkvK9lY0fq4lIg16EByjLsu+xSocIipsTToO
	kvdo6OfZuniGEQIT6gusJEZsCm77MYunjqB2CVQmRf/YpViZnQqMgjcJDBkQdfXgm7nTOG4Qs2F
	iLU3hGDyqBAtWZq3HZu+jydwvUKeG6Y+tSwgNl2oJ5riyf1ob7kh7w/2vPHtKS3PvdX8Q4SNBFS
	UeCTTMuBNffxpjTtcyT5IE7ZIIB5y6Ai6wIQ2S3g7g1Muo3MqKySYyHF4THKxVGvGCXvkbz2usB
	9qptIkce/F5J4kcuVAob
X-Received: by 2002:a05:701b:240b:b0:1b2:6cba:7f88 with SMTP id a92af1059eb24-1b503169447mr734985c88.44.1794522331615;
        Thu, 12 Nov 2026 14:25:31 -0800 (PST)
Received: from a1-free ([161.33.196.121])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b50319e381sm1718526c88.12.2026.11.12.14.25.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 14:25:30 -0800 (PST)
From: TAKANO Mitsuhiro <takano32@gmail.com>
To: linux-perf-users@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>
Cc: Ian Rogers <irogers@google.com>,
	James Clark <james.clark@linaro.org>,
	John Garry <john.garry@linux.dev>,
	linux-kernel@vger.kernel.org,
	TAKANO Mitsuhiro <takano32@gmail.com>
Subject: [PATCH v9 1/1] perf jevents: Check the keys of the JSON tables
Date: Thu, 12 Nov 2026 22:25:26 +0000
Message-ID: <20261112222526.462146-2-takano32@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261112222526.462146-1-takano32@gmail.com>
References: <20261112173241.197996-1-takano32@gmail.com>
 <20261112222526.462146-1-takano32@gmail.com>
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
v9: --check reports a directory that is not there instead of passing it,
    and "--check=DIR" is accepted as well as "--check DIR".  The check
    itself is unchanged.

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

