Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794403598;
	b=PNnTW23cDq+uCJJsMjFs/VMXGKzIt8qwQnB5WovyyzXBAUfOdRaFAvkitdxQ80ZjkHcM
	 PhXKXB79t6n5tfM4qhKaT/Ra25SP0I62gu/kJ4z8S9UPFeboMFqX7C3c1ptho9Qtuj8+A
	 onTX5wS++RQQX+xp/LV9YvhLs4b6u/VGKNjEtG4p/Dkn7wybTaHIFizNIWleLi+esHTbF
	 KQ3+8SlQrhy9fxDpJxc04kk1oRXCYtn/nvEz31iIXISRtux2TgtWtSLZuZShePrD4lxh7
	 m6Zr4sEbD9DXfNC4OwKlNXqnE9bPb69JiZrvCdWq7SUNte/zrrnzW/lKxpZejOGMLew==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794403598;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Sz8hUM2xtmmCc5yU1puxr1VrF4UjsEcHsp+wnIRI+34=;
	b=LEMWXr5eT6wK/4sdA+3yVmm2Xi5mXXn3ZIqUl9MABOp4JxMNZZhPXuNLS285vWDVnU2g
	 UcWRR9VqFKU6t98hQXhyG4qtCwduLOOYCY3Vp8yE1aVwvTSheWfn3q89/W8/QIIdmK1pc
	 4bobRwbCXuhmQw9+xlAmyJ5R3Cbd9WQCsTjX31WWv3dqtMtSnOefRLNJ16dAcshDzqaUc
	 EGs1SnxZ6eO2/NGcN4saoUVwjEFT2Tc41j47FquoRaaQLrh14J0vn00wxC0gXt8D86jwa
	 sv+ygO9Eb6tyA528R695Eoty6SAMslqVgygHBNUEm00uugrKJepH30oDbSmg3w4iI6A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=cUh2CuxB;
	arc=none smtp.remote-ip=74.125.82.43
Received: from mail-dl1-f43.google.com (mail-dl1-f43.google.com [74.125.82.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C41EE606A8BE
	for <linux-perf-users@vger.kernel.org>; Wed, 11 Nov 2026 13:26:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C41EE606A8BE
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=cUh2CuxB
Received: by mail-dl1-f43.google.com with SMTP id a92af1059eb24-1a3c08d6928so5334998c88.0
        for <linux-perf-users@vger.kernel.org>; Wed, 11 Nov 2026 05:26:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794403597; x=1795008397; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Sz8hUM2xtmmCc5yU1puxr1VrF4UjsEcHsp+wnIRI+34=;
        b=cUh2CuxBXqE8XESbgw1YhXRrGfjQ76/Pj/GzB3/wUiBFXUgu5dizOGzJ+xhr0y+e7Y
         uB4gM1r3jEdBoZsAoboYjACh/xGqOi/3uQQoQVwGBmoOdlBTV6YHypgmh5gZrODhQApa
         VchmyeWtvnjl0IwNFDx+q8apNl21/HWjQrKFLzgQnPj9SBRtF3rvtJ5qESi4Bk8jU8qW
         ioTZjRSBLoua0MqyDU+tq4Mm34xPseMG8474iVTHmW8DV2Y8o4wa52EO3u3n974UHdji
         NjMuUHOX1u7zNt40LVLgE+qT/SmpeVxKlsa/czet/fIKWzMQako4DhHUZmIIo8qtq5ct
         y7Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794403597; x=1795008397;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Sz8hUM2xtmmCc5yU1puxr1VrF4UjsEcHsp+wnIRI+34=;
        b=CFwevO1CfIfA8fFjFjTDk3tRmeMjVUgQHIytOhvI/eZBzZGGjb1K1bHYQPOZAM8bGC
         QWcFPizUDLZ+qufid/pQDrN55qi361Z26qMlRUW2fy+6oK5lzDwJoFfWDtjr6MWdREbO
         7oBvJQgbXhblFSYSyKLRvDVTCCeh1Z8C/BhqRJ7TBT+gLuvc7uZaYhNApNJX8QXon8E+
         IWDhHAzKXuaEtmyaN8N0zyl3EDiSfWoYvaygg+KmQMuRm8TS/c2AQkqGTF4sxz8JwaeC
         VWtXq43eX2ePSu94AX3e+BUfX9CU/gGpmy0rkM/Kd20iNkI9bWP9MrXKmPcknkwDVQb4
         PsWA==
X-Gm-Message-State: APuU4Z/tVnYuBTgZa2WdAtAQnh3+09bwaf4FaAmEq1bRpyD7XPBVOxfo
	LmnmdWUvLd5t0Nsczqc9WZFjCdKsi4DQubzoAK864XEpXICyH9ixG84m7AHdHA4h
X-Gm-Gg: AYBFou0Q3WW5ifSpt6gUWtKl7mC/Zg4XB/kt+8PaSpzYj1ZM+56ZEq/HnMlmd1+iAN1
	QXPCEbLZd31DFJU62R6SeKzlJ80BrAwzPz3tymJhMmb7gOsC23WKC+QH0Y2f14HyIVn8yrVuSFh
	49T4WxUhYiBkXS06jWVSTeW46tMoTaGsDPKRd5KqGsAWCxAx6WAx0ourv5Ca7PqRcpNuNQQv8au
	BxrcIpXagHo0voN3u7+cm88d0TXP5LZpeaYmeW7ki5S9J+mGpXOW44p1k6qUXY8HSSUqbsHIvRt
	2qoeYYSr61JRWBcsC7mg+Wk5q8y7wLSSAMm+9ex/2r0/JVNJC4VNuzmGGj9bOn3903Gb91qPLZJ
	QF+DL2F79UMl3WqAF90j0LzUBYq/f0GmYhytq0IqdkD56S8VhXtEPIEfANaunyxPbKKlE7+YO1R
	noA4RB6TXflpBqbOS3+cGAuOQ8WFhBbMwqomYLo4dOezp1b3MnTzXgrrYAyzZHNx9enJek630yF
	TnZ3h0xOWA8wQ0g5Bs6JJF4W/EoMyJRIgQyLAbz5WIZSIBlW1XufvhpGA+gdaKL+HiO88TT7qxS
	dsd/zlaiu60IV8k4PTnZ
X-Received: by 2002:a05:701b:261c:b0:1b2:46ca:242e with SMTP id a92af1059eb24-1b3c02f34camr2395310c88.14.1794403596599;
        Wed, 11 Nov 2026 05:26:36 -0800 (PST)
Received: from a1-free ([161.33.196.121])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b3b5b2fc09sm33053502c88.10.2026.11.11.05.26.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 05:26:35 -0800 (PST)
From: TAKANO Mitsuhiro <takano32@gmail.com>
To: linux-perf-users@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>
Cc: Ian Rogers <irogers@google.com>,
	James Clark <james.clark@linaro.org>,
	John Garry <john.garry@linux.dev>,
	linux-kernel@vger.kernel.org,
	TAKANO Mitsuhiro <takano32@gmail.com>
Subject: [PATCH v5 3/3] perf jevents: Check the JSON keys a table may carry
Date: Wed, 11 Nov 2026 13:26:22 +0000
Message-ID: <20261111132622.2349165-4-takano32@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261111132622.2349165-1-takano32@gmail.com>
References: <20261111041045.2031464-1-takano32@gmail.com>
 <20261111132622.2349165-1-takano32@gmail.com>
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

jevents.py takes the fields it wants out of each JSON object by name -
jd.get('BriefDescription'), 'EventCode' in jd, jd['ExtSel'], and the
fourteen names in event_fields that it looks for with 'key in jd' - so a
key spelled another way is dropped without a word and the object is built
without whatever that field held.  Nothing in the build and nothing in the
generated table says so.

Two of those are in the tree.  "PublicDescrition" is in 16 of the 28
entries of arm64/ampere/ampereonex/mmu.json, where the long description
each of them lost repeated the BriefDescription, which is why it could sit
there unnoticed.  "BriefDescript6ion" is in one entry each of
amdzen4/cache.json, amdzen5/load-store.json and amdzen6/load-store.json,
and those objects carry no other description, so ls_inef_sw_pref.all is
generated with an empty text field on Zen 4, 5 and 6.

Check the tables against the keys they may carry instead of watching which
ones a run reads.  The list is 51 names: 47 of them this file reads, 33 by
name and 14 through event_fields; Experimental is read by metric.py; and
Counter, CountersNumFixed and CountersNumGeneric are read by nothing in
perf although the tables carry them, so a vendor that adds a field changes
one line here by agreement.  A JSON Schema would express the same list,
but perf's build would then require jsonschema, which it does not use
today and which is not in every builder's python, so the list lives in
this file and is the schema.  The name of a metricgroup is not a key: the
file that ends in metricgroups.json maps a name of its own choosing to a
description, and only that description is read.

Add --check, which reads every architecture under starting_dir, or the one
named by the first argument, names each key it does not accept with the
object that carries it on stderr, and exits 0 when the tree is clean, 1
when something was reported and 2 when a table could not be read or there
was nothing to read.  The name of an architecture is a name and not a
path, so ".." is refused rather than walking out of the tree, and an
architecture with no tables of its own is an error rather than a pass: a
name that was typed wrong is the first thing this is meant to catch.  An
object where a list belongs is reported too, because every key of it
would go unchecked.  A build does not run the check, and the generated
tables are byte identical: x86, arm64 and all architectures compared
against the same tree without this patch.

Add a "check-jevents" target next to check-headers, with
JEVENTS_CHECK_ARCH to check one architecture while working on it, and a
perf test for the cases that matter: a clean tree, a key the generator
does not read, and an architecture that is not there.

The two misspellings in the tree are fixed by separate patches; until they
are applied the target reports them, which is what it is for.

Signed-off-by: TAKANO Mitsuhiro <takano32@gmail.com>
---
v5: patch 3 says which keys a table may carry and checks the tree
    against that list, replacing the near-miss report that v4 had.
    The list is 51 names, 47 of which jevents.py reads; an architecture
    that is not there or is named as a path is an error (status 2)
    instead of a silent pass, and an object written without the list
    brackets is reported.  The name of a metricgroup is not treated as
    a key.  jsonschema is not used because perf's build would then
    require it, and the list holds the same names a schema would.
    The target is check-jevents, next to check-headers, and takes
    JEVENTS_CHECK_ARCH; a shell test covers a reported key, a clean
    tree and a missing architecture.

 tools/perf/Makefile                     |  13 ++-
 tools/perf/Makefile.perf                |   1 +
 tools/perf/pmu-events/jevents.py        | 148 +++++++++++++++++++++++-
 tools/perf/tests/shell/jevents_check.sh |  62 ++++++++++
 4 files changed, 220 insertions(+), 4 deletions(-)
 create mode 100755 tools/perf/tests/shell/jevents_check.sh

diff --git a/tools/perf/Makefile b/tools/perf/Makefile
index 00baf90e5bda..a1aac2fdf5e1 100644
--- a/tools/perf/Makefile
+++ b/tools/perf/Makefile
@@ -140,6 +140,17 @@ check-headers:
 sync-headers:
 	@./scripts/sync-headers.sh $(SYNC_HEADERS_ARGS)
 
+# The pmu-events tables are data, and a key that no parser reads is invisible
+# until a description goes missing, so the keys a table may carry are a fixed
+# list in jevents.py and this target checks the tree against it.  It reads the
+# source tree and needs no build.  Makefile.perf sets PYTHON for the build and
+# this wrapper does not include it, so default here and let PYTHON= on the
+# command line win when it is given.
+JEVENTS_CHECK_ARCH ?= all
+PYTHON ?= python3
+check-jevents:
+	@$(PYTHON) ./pmu-events/jevents.py --check $(JEVENTS_CHECK_ARCH) all pmu-events/arch
+
 #
 # All other targets get passed through:
 #
@@ -147,4 +158,4 @@ sync-headers:
 	$(print_msg)
 	$(make)
 
-.PHONY: all clean tags TAGS FORCE Makefile build-test build-test-tarball check-headers sync-headers
+.PHONY: all clean tags TAGS FORCE Makefile build-test build-test-tarball check-headers sync-headers check-jevents
diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index b74b534e1153..ec7dde9ec6e2 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -871,6 +871,7 @@ help:
 	@echo 'Perf maintainer targets:'
 	@echo '  clean			- clean all binary objects and build output'
 	@echo '  check-headers		- check which header copies are out of sync with the kernel'
+	@echo '  check-jevents		- check the pmu-events json tables against the keys they may carry'
 	@echo '  sync-headers		- sync those header copies with the kernel, creating commits'
 	@echo '			  (SYNC_HEADERS_ARGS="..." passes options to the script)'
 
diff --git a/tools/perf/pmu-events/jevents.py b/tools/perf/pmu-events/jevents.py
index f4dca47eb49b..1d114cb8ed29 100755
--- a/tools/perf/pmu-events/jevents.py
+++ b/tools/perf/pmu-events/jevents.py
@@ -7,7 +7,7 @@ import json
 import metric
 import os
 import sys
-from typing import (Callable, Dict, Optional, Sequence, Set, Tuple)
+from typing import (Callable, Dict, List, Optional, Sequence, Set, Tuple)
 import collections
 
 # Global command line arguments.
@@ -1456,6 +1456,136 @@ def _init_worker(std_events: dict) -> None:
   global _arch_std_events
   _arch_std_events = std_events
 
+# The keys a json object under arch/ may carry.  jevents.py reads 47 of them,
+# 33 by name and 14 through event_fields below; Experimental is read by
+# metric.py; Counter, CountersNumFixed and CountersNumGeneric are read by
+# nothing in perf, but the tables carry them, so a vendor that adds a field
+# changes one line here by agreement.  A key outside this set is a misspelling,
+# or a field that has to be agreed on and added here first: "PublicDescrition"
+# sat in 16 entries of an arm64 table and every one of them lost its long
+# description without a word.  This list is the whole schema - it says what may
+# exist in a table, not that the table uses it.
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
+
+def _check_tables(root: str, arch: str) -> int:
+  """Report the keys in the json tables under root that no reader looks for.
+
+  With arch "all" every architecture is read; otherwise that one is, together
+  with the common and test tables that a build of it reads as well.
+
+  Returns 0 when the tree is clean, 1 when something was reported and 2 when a
+  table could not be read or there was nothing to read, so that a script can
+  gate on the status.
+  """
+  reported = 0
+  unreadable = 0
+  files = 0
+  bad_files: Set[str] = set()
+
+  def report(path: str, what: str) -> None:
+    nonlocal reported
+    bad_files.add(path)
+    print(f'{path}: {what}', file=sys.stderr)
+    reported += 1
+
+  if arch == 'all':
+    roots = [root]
+    arch_root = None
+  else:
+    # arch names a directory under the tables, it is not a path: ".." or "x86/"
+    # would walk out of the tree and report on tables that are not part of it.
+    if not arch or '/' in arch or arch in ('.', '..'):
+      print(f'"{arch}" is not the name of a directory under the tables',
+            file=sys.stderr)
+      return 2
+    arch_root = os.path.join(root, arch)
+    if not os.path.isdir(arch_root):
+      print(f'{root}: there is no architecture "{arch}"', file=sys.stderr)
+      return 2
+    roots = [arch_root]
+    roots += [os.path.join(root, name) for name in ('common', 'test')
+              if name != arch and os.path.isdir(os.path.join(root, name))]
+
+  paths: List[str] = []
+  arch_tables = 0
+  for top in roots:
+    for dirpath, _, names in os.walk(top):
+      for name in sorted(names):
+        if name.endswith('.json'):
+          paths.append(os.path.join(dirpath, name))
+          if top == arch_root:
+            arch_tables += 1
+
+  # The common and test tables exist for every architecture, so an architecture
+  # with tables of its own is what makes a check of it meaningful.
+  if arch_root and not arch_tables:
+    print(f'{arch_root}: the tables of "{arch}" are missing', file=sys.stderr)
+    return 2
+
+  for path in sorted(paths):
+    files += 1
+    try:
+      with open(path, encoding='utf-8') as f:
+        data = json.load(f)
+    except (OSError, ValueError) as e:
+      print(f'{path}: cannot be read: {e}', file=sys.stderr)
+      unreadable += 1
+      continue
+    if path.endswith('metricgroups.json'):
+      # The name of a group is a name of its own choosing and only the
+      # description held under it is read, so there is no key to check here.  A
+      # list where an object belongs means the braces were left out.
+      if not isinstance(data, dict):
+        report(path, f'the table holds a {type(data).__name__}, not an object')
+      continue
+    if isinstance(data, dict):
+      # A list of objects written without its brackets: every key of the one
+      # object in it would go unchecked.
+      report(path, 'the table holds an object, not a list of objects')
+      continue
+    if not isinstance(data, list):
+      report(path, f'the table holds a {type(data).__name__}, '
+                   'not a list of objects')
+      continue
+    for index, obj in enumerate(data):
+      if not isinstance(obj, dict):
+        report(path, f'entry {index} is a {type(obj).__name__}, not an object')
+        continue
+      named = next((obj[k] for k in ('EventName', 'MetricName', 'ArchStdEvent')
+                    if isinstance(obj.get(k), str) and obj[k]), '')
+      what = f'entry {index} ({named})' if named else f'entry {index}'
+      for key in sorted(set(obj) - _TABLE_KEYS):
+        report(path, f'{what}: unknown key "{key}"')
+
+  if not files:
+    print(f'{root}: there are no tables to check', file=sys.stderr)
+    return 2
+  if unreadable:
+    print(f'{unreadable} table(s) could not be read', file=sys.stderr)
+  if reported:
+    print(f'{reported} problem(s) in {len(bad_files)} of {files} tables: a key '
+          'this file does not read is a misspelling, or a field to add to '
+          '_TABLE_KEYS', file=sys.stderr)
+  if unreadable:
+    return 2
+  return 1 if reported else 0
+
+
 def main() -> None:
   global _args
 
@@ -1497,12 +1627,24 @@ model must include the implementor such as "arm/cortex-a34".''',
       help='Root of tree containing architecture directories containing json files'
   )
   ap.add_argument('output_file', nargs='?', default=None,
-                  help='file to write the tables to, default standard output')
+                  help='file to write the tables to, default standard output; '
+                       'not opened with --check')
   ap.add_argument('output_string_file', nargs='?', default=None,
                   help='file to write big_c_string to when it is to be kept '
-                       'apart from the tables')
+                       'apart from the tables; ignored with --check')
+  ap.add_argument('--check', action='store_true',
+                  help='check the tables under starting_dir against the keys '
+                       'they are allowed to carry and exit without writing '
+                       'anything; arch selects the architecture to read, "all" '
+                       'reads every one, and model is not used.  The exit '
+                       'status is 0 when the tree is clean, 1 when something '
+                       'was reported and 2 when a table could not be read or '
+                       'there was nothing to read')
   _args = ap.parse_args()
 
+  if _args.check:
+    sys.exit(_check_tables(_args.starting_dir, _args.arch))
+
   archs = []
   for item in os.scandir(_args.starting_dir):
     if not item.is_dir():
diff --git a/tools/perf/tests/shell/jevents_check.sh b/tools/perf/tests/shell/jevents_check.sh
new file mode 100755
index 000000000000..311ca5f5ab15
--- /dev/null
+++ b/tools/perf/tests/shell/jevents_check.sh
@@ -0,0 +1,62 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+# perf jevents tests: --check reports a key the generator does not read, and an
+# architecture that is not there is an error rather than a clean tree.
+
+set -e
+
+shelldir=$(dirname "$0")
+jevents="${shelldir}/../../pmu-events/jevents.py"
+python=${PYTHON:-python3}
+tmpdir=$(mktemp -d "${TMPDIR:-/tmp}/jevents-check.XXXXXX") || exit 2
+trap 'rm -rf "${tmpdir}"' EXIT
+
+# An installed perf has the test but not the generator, and a python that cannot
+# run the generator is not a failure of the check.
+[ -r "${jevents}" ] || exit 2
+"${python}" -c 'import sys; sys.exit(sys.version_info[0] != 3)' 2>/dev/null ||
+	exit 2
+
+mkdir -p "${tmpdir}/x86/model" "${tmpdir}/empty" "${tmpdir}/common" \
+	"${tmpdir}/test"
+
+# The name of a metricgroup is not a key, even when it is spelled like one.
+printf '{"Unit": "a description"}\n' \
+	> "${tmpdir}/x86/model/events-metricgroups.json"
+printf '[{"EventName": "test", "EventCode": "0x1", "BriefDescription": "b"}]\n' \
+	> "${tmpdir}/x86/events.json"
+
+rc=0
+"${python}" "${jevents}" --check x86 all "${tmpdir}" 2>"${tmpdir}/stderr" ||
+	rc=$?
+if [ "${rc}" -ne 0 ]; then
+	cat "${tmpdir}/stderr"
+	echo "a clean tree was reported, status ${rc}"
+	exit 1
+fi
+
+printf '[{"EventName": "test", "BriefDeuxcription": "b"}]\n' \
+	> "${tmpdir}/x86/events.json"
+
+rc=0
+"${python}" "${jevents}" --check x86 all "${tmpdir}" 2>"${tmpdir}/stderr" ||
+	rc=$?
+if [ "${rc}" -ne 1 ]; then
+	cat "${tmpdir}/stderr"
+	echo "expected 1 for an unknown key, got ${rc}"
+	exit 1
+fi
+grep -q 'unknown key "BriefDeuxcription"' "${tmpdir}/stderr" ||
+	{ echo "the unknown key was not named"; exit 1; }
+
+for arch in x86typo .. empty; do
+	rc=0
+	"${python}" "${jevents}" --check "${arch}" all "${tmpdir}" 2>/dev/null ||
+		rc=$?
+	if [ "${rc}" -ne 2 ]; then
+		echo "expected 2 for the architecture '${arch}', got ${rc}"
+		exit 1
+	fi
+done
+
+exit 0
-- 
2.53.0

