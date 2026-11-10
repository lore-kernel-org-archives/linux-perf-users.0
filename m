Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794349382;
	b=z0Wmbs1g1Fdkd+7WdvfsDH7RwL9yDlapVX9mdRvWjHzx8cdWKLJpQyyfq4LOp5p7Ihea
	 166l6FWIg6DJAFhIzkngq1OP904CClkAwIuffW0bKlmtSScYaIJTGSC/h/EUEk8DkjlU5
	 +WHj8UDrwMwUxsZv6b5Xv4ml2B/jqWI6jdBr+7I+PhJW8A7+0E/lJ/fPcbLOuMVr5VceK
	 IxtwQhIxUwd/WVTSrlySt1i4e4dPE6PMr07rZgvhLMmaale6PGV9am+CxoReznK/n7qWf
	 wCB3o1ya8BbCrcusxZr7Arnp4RMaqSDbgChWDX8K/EyUKkd1X+pE0LREGxAGXeeMNsA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794349382;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=h8A5Av6BvOrgD/Tc4XMWxQdeDbqXJmFeWsnMRuDQOlE=;
	b=sl5sZe5M2JYIj8kvSNXHSC5qorpqoZM7gvqwDfjz4LeH44OfcpR8M0T7O94FNxgKoVvX
	 6bxC5tLHUo0XDVbEZ0NLiEZh7grco4GxsQgHI3JIysJXY9akU0UaIcS116r53pP+cDQri
	 RGOshdAwWRZYfa7OCDbt22CZc7CFa5ZZ3bhTTtAlWj3H+Pw5lYReB6yJ71F4Qa98T+D+y
	 9d1rDgTylL6plcRA3/iVtxx2zF+fXMi7RN80/UJgQjpLmDr4X4laAN0LB0vNo/XU671u3
	 n5BnBGTXcqmym4GDo6KZNVYL1Fj731f5DB1kfvgUAflbPEdECGUYLP/mUsDmxP5sMMQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hCV70ko9;
	arc=none smtp.remote-ip=74.125.82.178
Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com [74.125.82.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C194606A336
	for <linux-perf-users@vger.kernel.org>; Tue, 10 Nov 2026 22:23:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0C194606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hCV70ko9
Received: by mail-dy1-f178.google.com with SMTP id 5a478bee46e88-37071c0f42aso4472144eec.0
        for <linux-perf-users@vger.kernel.org>; Tue, 10 Nov 2026 14:23:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794349381; x=1794954181; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=h8A5Av6BvOrgD/Tc4XMWxQdeDbqXJmFeWsnMRuDQOlE=;
        b=hCV70ko9ElH7Rp3RZYSKl8Mm5xC0aDClEUW327+t6ATODd3zlVHAzXiHaZ3fqsQtDx
         kDmMgS5LEHZQXCWwbzTiBx2cAtVX2mPjvauuycgKEU3GYULqi//bEiUSMal9vtTpqD4B
         +mnNvHP9KzIC7b5AayEM/zM0SWKkGC41lnVt7gFFjROMYX/i6uCsciMMd+GbEcURo4Hw
         tboAltUvJNFqEcc7atBu6P/rzwVtxGP/XTNz8Bv3IN3fy+FnGTM8L8CFuNQCnLYlAx/9
         2AwwAax7DaI0eTfpQ9O4f04YcNj0fwxiUX997lAfNsXqfSIrumCr6EoQWovtU+gRhYVI
         /gMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794349381; x=1794954181;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=h8A5Av6BvOrgD/Tc4XMWxQdeDbqXJmFeWsnMRuDQOlE=;
        b=h+4/1efnqLFCaql2lk9eq1oczvIvdS2JhBilKWXh4wzt8KO95Zu0kiquBL+taqSGN/
         rZuj68h/iYreA8UOQW+NT6zKv4GQdkrldWnlsGlT+Pc8ZnRbiBo1BpXFNAUYDGM/nIY1
         bQbhkpJepI12eOVx+JK3lAbte58OC4lYtokhW6ZKqu4G4/0RWfAacH8KVA8RV8Mhubjc
         8azS3g0KhqF/23rfpSnOHSbDWB+MOhPo6Z9Ro8z7+zjJq66JFn4w9U3mUnKBoAvZZiKC
         oM1xH7P/5VxeM9cHNrgvARshCFq/N5qXhz9MDL0HnQQkocE9S4AEHnAGFSSIJsLRX/TD
         Sj2A==
X-Gm-Message-State: APuU4Z8ZLQ72wOJkPoYnE0O+akjIp1th4p6UmeO8toie/VBa9PlgU6A9
	stLhxyE4QnEOITnK9n0S8WEZ9nB/1NXoaa1WZe03ol2blffcUXXoc4Ouf9sONNfk
X-Gm-Gg: AYBFou1PCJIzWkwSOBAkfzKt1DDBabCtnoCTYl0yG3FsESkj3dPtpTCKP3Qz35tlguM
	qQtrW2l2qD6kmu9KbGzkwKkDaETW7CqYSof0UCdDQmyz8VFEeJVXXXXQgtEloT5f0twbefhAdwb
	QyPj8zHu5GF1nF9nRikfQFXCce84BAgiEmDhDzUGpNe7qJF6v5sNFvWqztOGeSz2OlrSJmpmF0s
	T388y4qAEM2aCj1gLbdRjlWjLpbkGjDt906qEukYMWimyYVbtEDkT18x9ARJ1dBYQmT7mAphlJ0
	UNUVgtSoq8bzY+aFG5pUkkk5CML9xAqD5cOXpDYdHJMY9Rg3K58rB2u+hZtZ59KOoZDSDK8My77
	+kCo8Dj+HwxlZ3oUEcw/CHjlV1npDWJlPu4tFd2/x7yUOHu4JsjC5cZAajXlimRFypcxwqri8EY
	goqzCooPaNXSUX30e4SRNmng4lc8E5+hIadFgMnpjOhmCTXk8fwJpjgRoCEZu3K8vybBsQj8yBG
	3HyrbDgI1MhWzssE+cIemvFULupV/NAZy5A0PS/2Bd+UC2e656FHg5SZBZi6p/H3SPKIiIoJNdX
	6cJ8nAAXH/8Axw77n56E
X-Received: by 2002:a05:7301:6190:10b0:369:d8e1:7bb6 with SMTP id 5a478bee46e88-3768636de1fmr977373eec.25.1794349380763;
        Tue, 10 Nov 2026 14:23:00 -0800 (PST)
Received: from a1-free ([161.33.196.121])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-37520512b6asm9165030eec.10.2026.11.10.14.22.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 14:23:00 -0800 (PST)
From: TAKANO Mitsuhiro <takano32@gmail.com>
To: linux-perf-users@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>
Cc: Ian Rogers <irogers@google.com>,
	linux-kernel@vger.kernel.org,
	TAKANO Mitsuhiro <takano32@gmail.com>,
	James Clark <james.clark@linaro.org>,
	John Garry <john.garry@linux.dev>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH 3/3] perf jevents: Check the JSON keys that jevents.py never reads
Date: Tue, 10 Nov 2026 22:22:50 +0000
Message-ID: <20261110222250.1864777-4-takano32@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261110222250.1864777-1-takano32@gmail.com>
References: <20261110222250.1864777-1-takano32@gmail.com>
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

jevents.py takes the fields it wants out of each JSON object by name:
jd.get('BriefDescription'), 'EventCode' in jd, and the names in
event_fields. A key spelled another way is dropped without a word, and
the object is built without whatever that field held.

Two of those are in the tree now. "BriefDescript6ion" is in one entry
each of amdzen4/cache.json, amdzen5/load-store.json and amdzen6/load-
store.json, and since those objects carry no other description,
ls_inef_sw_pref.all is generated with an empty text field.
"PublicDescrition" was in 16 of the 28 entries of
arm64/ampere/ampereonex/mmu.json; nothing a user saw changed there,
because each of the 16 also had a BriefDescription with the same text,
which is why the typo could sit there unnoticed.

Add a --check mode that reads every architecture, not just the one being
built: a typo is cheapest to fix by whoever reads that table next, and
that reader may be building something else. It records the keys
JsonEvent was never asked for and reports the ones whose spelling is a
near miss for a name jevents.py does read (difflib ratio 0.8). In this
tree 52 distinct key names occur, jevents.py reads 46 of them, the two
misspellings score 0.97, and the highest score among the remaining
unread names is 0.78 (Counter against CounterMask), so any cutoff in
that gap reports the same two.

It also reports a metric that carries a name but no expression, by
metric name and however the lost MetricExpr key was spelled: the key
report needs the spelling to be close to a name jevents.py reads, and a
metric without its expression cannot be generated at all.

The tracking is off unless --check asked for it, so a build parses each
object exactly as before and the generated tables are byte-identical
(x86, arm64 and all architectures compared against the same tree without
this patch). The check itself reads the 973 json files under arch/ and
takes seconds of CPU.

Exit status is 0 when nothing was reported, 1 when something was, and 2
when a table could not be read or the command line was wrong; make folds
both failures into its own status, so a script that needs the difference
runs jevents.py directly. Status 0 means the tables under that directory
were read and no unread key looks like a name jevents.py reads. It is
not a promise that a build will succeed: mapfile.csv coverage, the model
that selects a subset of the tables, and the C generation are not part
of it.

It is not a schema either: it checks nothing about types, required
fields or value ranges, and looks at key names only, so a misspelled
description in a value is out of scope. It does not read mapfile.csv,
which has no keys, or metricgroups.json, whose keys are group names.
Names that only metric.py or the C code read are outside it too, so an
"Expermental" key is not reported, and file names and topics are not
keys.

The check runs from the new make target "make -C tools/perf jevents-
check" (JEVENTS_CHECK_ARCH=x86 narrows it to one architecture) and from
perf test: tests/shell/jevents_check.sh runs it over a fixture table and
checks the status for a clean table (0), a misspelled key (1) and a
table that does not parse (2), and skips with status 2 when pmu-events/
is not next to the binary.

Written with Hermes Agent, an LLM assistant, which found the
misspellings and wrote this check, its test and this changelog. I built
perf with it, ran the perf test above, ran the check over the whole
tree, compared the generated tables with those from an unpatched tree on
x86, arm64 and all architectures at once, and ran mypy on jevents.py.

Signed-off-by: TAKANO Mitsuhiro <takano32@gmail.com>
---
 tools/perf/Makefile                     |  14 +-
 tools/perf/Makefile.perf                |   1 +
 tools/perf/pmu-events/jevents.py        | 383 ++++++++++++++++++++----
 tools/perf/tests/shell/jevents_check.sh |  68 +++++
 4 files changed, 411 insertions(+), 55 deletions(-)
 create mode 100755 tools/perf/tests/shell/jevents_check.sh

diff --git a/tools/perf/Makefile b/tools/perf/Makefile
index 00baf90e5bda..0b13f1e12899 100644
--- a/tools/perf/Makefile
+++ b/tools/perf/Makefile
@@ -140,6 +140,18 @@ check-headers:
 sync-headers:
 	@./scripts/sync-headers.sh $(SYNC_HEADERS_ARGS)
 
+# The pmu-events tables are data, so a key nothing reads is invisible until a
+# description goes missing.  Named in the wrapper like check-headers: this is
+# a data check, not a build, so it needs neither config nor fixdep and reads
+# the source tree whatever O= says.  JEVENTS_CHECK_ARCH=x86 reads x86 and the
+# common and test tables every build reads.
+# Makefile.perf picks the interpreter for the build; the wrapper does not
+# include it, so default here and let PYTHON= win when it is given.
+JEVENTS_CHECK_ARCH ?= all
+PYTHON ?= python3
+jevents-check:
+	@$(PYTHON) ./pmu-events/jevents.py --check '$(JEVENTS_CHECK_ARCH)' all pmu-events/arch
+
 #
 # All other targets get passed through:
 #
@@ -147,4 +159,4 @@ sync-headers:
 	$(print_msg)
 	$(make)
 
-.PHONY: all clean tags TAGS FORCE Makefile build-test build-test-tarball check-headers sync-headers
+.PHONY: all clean tags TAGS FORCE Makefile build-test build-test-tarball check-headers sync-headers jevents-check
diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index b74b534e1153..a330cd9de0fc 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -871,6 +871,7 @@ help:
 	@echo 'Perf maintainer targets:'
 	@echo '  clean			- clean all binary objects and build output'
 	@echo '  check-headers		- check which header copies are out of sync with the kernel'
+	@echo '  jevents-check		- report the pmu-events json keys that jevents.py never reads'
 	@echo '  sync-headers		- sync those header copies with the kernel, creating commits'
 	@echo '			  (SYNC_HEADERS_ARGS="..." passes options to the script)'
 
diff --git a/tools/perf/pmu-events/jevents.py b/tools/perf/pmu-events/jevents.py
index 844fa82887bb..3063282599a0 100755
--- a/tools/perf/pmu-events/jevents.py
+++ b/tools/perf/pmu-events/jevents.py
@@ -3,15 +3,16 @@
 """Convert directories of JSON events to C code."""
 import argparse
 import csv
+import difflib
 import json
 import metric
 import os
 import sys
-from typing import (Callable, Dict, Optional, Sequence, Set, Tuple)
+from typing import (Any, Callable, Dict, List, Optional, Sequence, Set, Tuple)
 import collections
 
 # Global command line arguments.
-_args = None
+_args: Optional[argparse.Namespace] = None
 # List of regular event tables.
 _event_tables: list[str] = []
 # List of event tables generated from "/sys" directories.
@@ -190,11 +191,78 @@ class BigCString:
 
 _bcs = BigCString()
 
+# Names that some object in this process has been asked for.  Used only to
+# find the spelling an unread name was meant to be.  The set is per process
+# and the workers of the pool never share it, so a name is in it once some
+# object in the same worker has been built; every object asks for the same
+# names, so they are there before the first object is reported, but a read
+# that moved behind a condition would make a report depend on which worker
+# happened to build which file.
+_read_keys: Set[str] = set()
+
+# Unread name -> the names it could be a misspelling of, or () for none.  A table
+# repeats the same few names tens of thousands of times, and the name that
+# misses is the common case (Counter, many thousands of objects), so the
+# misses are kept too; _mark empties the cache when a name is read for the
+# first time, so a hint computed while _read_keys was still growing cannot
+# stick.
+_hints: Dict[str, Tuple[str, ...]] = {}
+
+# Whether the objects are wrapped at all.  Only the check reads what the
+# tracking records, so a build does not wrap anything.  Set in
+# main() and, because the workers may be fresh interpreters, passed to them
+# through _init_worker() rather than read from _args there.
+_track: bool = False
+
+
+class _JsonObject(dict):
+  """A JSON object that remembers which of its keys were looked at.
+
+  jevents.py picks the fields it wants out of each object by name and
+  ignores the rest, so a key it never names - a misspelled
+  "BriefDescript6ion", say - is dropped without a word and the event
+  silently loses its description.  Handing the parsed object to this
+  class and asking it afterwards which keys were never looked at makes
+  the misspelling visible.  Only get(), [] and 'in' are tracked: a read
+  through items(), values() or pop() would not be, so a new read of a
+  field belongs in one of the three.  The alternative, a list of the key names
+  jevents.py reads, would be a second copy of the code below that goes
+  stale the first time someone adds a field.
+  """
+
+  def __init__(self, jd: dict):
+    super().__init__(jd)
+    # dict.keys() rather than the object itself: iterating the object would
+    # go through __iter__, should that ever be hooked below.
+    self.unread: Set[str] = set(dict.keys(jd))
+
+  def _mark(self, key: str) -> None:
+    self.unread.discard(key)
+    if key not in _read_keys:
+      _read_keys.add(key)
+      _hints.clear()
+
+  def get(self, key: Any, default: Any = None) -> Any:
+    self._mark(key)
+    return dict.get(self, key, default)
+
+  def __getitem__(self, key: Any) -> Any:
+    self._mark(key)
+    return dict.__getitem__(self, key)
+
+  def __contains__(self, key: object) -> bool:
+    if isinstance(key, str):
+      self._mark(key)
+    return dict.__contains__(self, key)
+
+
 class JsonEvent:
   """Representation of an event loaded from a json file dictionary."""
 
   def __init__(self, jd: dict):
     """Constructor passed the dictionary of parsed json values."""
+    if _track:
+      jd = _JsonObject(jd)
 
     def llx(x: int) -> str:
       """Convert an int to a string similar to a printf modifier of %#llx."""
@@ -416,6 +484,42 @@ class JsonEvent:
         raise argparse.ArgumentTypeError('Cannot find arch std event:', arch_std)
 
     self.event = real_event(self.name, event)
+    # Keys of the JSON object that no code above looked at, set last so that
+    # the copy of an architecture standard event above does not overwrite it.
+    # A name that is a near miss for one the code reads, and whose name the
+    # object does not carry with the same text, is almost certainly a
+    # misspelling of it: the object lost the field the reader was looking for.
+    # A name that is not a near miss is left alone, because a table is free to
+    # carry metadata jevents.py has no use for.
+    self.mistyped: Optional[Dict[str, Tuple[str, ...]]] = None
+    if not _track:
+      return
+    assert isinstance(jd, _JsonObject)
+    unread = jd.unread
+    if unread:
+      found = {}
+      for key in unread:
+        if key not in _hints:
+          lowered = {name.lower(): name for name in _read_keys}
+          # Two names can be equally close - RetirementLatencyMax and its Min -
+          # and naming one of them would be a coin toss presented as an answer.
+          match = difflib.get_close_matches(key.lower(), sorted(lowered), n=2, cutoff=0.8)
+          _hints[key] = tuple(lowered[m] for m in match)
+        hints = _hints[key]
+        if not hints:
+          continue
+        # Nothing was lost if the object carries one of those names with the
+        # same text: that is a table with the field twice, not a misspelling.
+        # dict.__contains__ so that the look is not recorded as a read.
+        lost = True
+        for name in hints:
+          if dict.__contains__(jd, name) and dict.get(jd, key) == dict.get(jd, name):
+            lost = False
+            break
+        if lost:
+          found[key] = hints
+      if found:
+        self.mistyped = found
 
   def __repr__(self) -> str:
     """String representation primarily for debugging."""
@@ -453,6 +557,83 @@ class JsonEvent:
     return f'{make_comment(s)}\t{{ { _bcs.offsets[s] } }},\n'
 
 
+def _report_mistyped_keys() -> bool:
+  """Report the JSON keys that jevents.py did not look for.
+
+  jevents.py takes the fields it wants out of each object by name.  A key
+  spelled differently from the name it looks for is never read, the object is
+  built without whatever the field held, and the build says nothing; that is
+  how "BriefDescript6ion" in the AMD tables and "PublicDescrition" in the
+  AmpereOneX mmu table got in.  A name that is a near miss for one jevents.py
+  reads is reported, with the spelling it was probably meant to be and the
+  files carrying it.  A name that is not a near miss is not reported: a
+  table may carry metadata for another reader, and reporting it would mean
+  keeping a list of such names in this file that every vendor adding one
+  would have to edit.
+
+  A table that cannot be parsed is reported the same way and does not stop
+  the rest of the tree from being read, so one broken file does not hide the
+  misspellings in the other 1000.
+  """
+  assert _args is not None
+  found: Dict[str, collections.Counter] = {}
+  hints: Dict[str, Tuple[str, ...]] = {}
+  objects = 0
+  for (path, _), events in _json_cache.items():
+    for event in events:
+      if not event.mistyped:
+        continue
+      objects += 1
+      for key, hint in event.mistyped.items():
+        found.setdefault(key, collections.Counter())[path] += 1
+        hints.setdefault(key, hint)
+  if not found:
+    return False
+
+  paths = {path for files in found.values() for path in files}
+  start = _args.starting_dir
+  print(f'jevents: error: {objects} object(s) in '
+        f'{len(paths)} file(s) carry a key that looks like a misspelling:', file=sys.stderr)
+  for key in sorted(found):
+    files = found[key]
+    guess = ' or '.join(repr(name) for name in hints[key])
+    print(f'  {key!r}, did you mean {guess}? ({sum(files.values())} object(s) in '
+          f'{len(files)} file(s)):', file=sys.stderr)
+    where = sorted(os.path.relpath(path, start) for path in files)
+    for path in where[:5]:
+      print(f'    {path}', file=sys.stderr)
+    if len(where) > 5:
+      print(f'    ... and {len(where) - 5} more file(s)', file=sys.stderr)
+
+  return True
+
+
+def _report_metrics_without_expr() -> bool:
+  """Report the metrics that carry a name but no expression.
+
+  A MetricExpr key spelled another way is not read, so the object keeps its
+  name and loses its expression.  Unlike the key report above this does not
+  depend on how close a spelling is: a metric the rewrite cannot handle would
+  fail a build however the lost key was spelled.
+  """
+  assert _args is not None
+  start = _args.starting_dir
+  missing = sorted((os.path.relpath(path, start), event.metric_name)
+                   for (path, _), events in _json_cache.items()
+                   for event in events
+                   if event.metric_name and event.metric_expr is None)
+  if not missing:
+    return False
+  print(f'jevents: error: {len(missing)} metric(s) have a name but no '
+        f'expression, so their MetricExpr key is missing or misspelled:',
+        file=sys.stderr)
+  for where, name in missing[:20]:
+    print(f'  {name!r} in {where}', file=sys.stderr)
+  if len(missing) > 20:
+    print(f'    ... and {len(missing) - 20} more metric(s)', file=sys.stderr)
+  return True
+
+
 _json_cache: Dict[Tuple[str, str], Sequence[JsonEvent]] = {}
 def _read_json_events_impl(path: str, topic: str) -> Sequence[JsonEvent]:
   """Read json events from the specified file."""
@@ -460,17 +641,20 @@ def _read_json_events_impl(path: str, topic: str) -> Sequence[JsonEvent]:
     with open(path, encoding='utf-8') as f:
       events = json.load(f, object_hook=JsonEvent)
   except BaseException:
-    print(f'jevents: error: Exception processing {path}', file=sys.stderr)
+    if not _track:
+      print(f'jevents: error: Exception processing {path}', file=sys.stderr)
     raise
   metrics: list[Tuple[str, str, metric.Expression]] = []
   for event in events:
     event.topic = topic
     if event.metric_name and event.metric_expr is None:
       # A MetricName without a MetricExpr leaves nothing to put in the
-      # generated tables, whether or not the name has a dash, so the build
-      # must not go on.  Name the metric instead of letting the table printer
-      # assert on the None.
-      raise RuntimeError(f'Metric {event.metric_name!r} has no MetricExpr')
+      # generated tables, whether or not the name has a dash, so a build must
+      # not go on.  Name the metric instead of letting the table printer
+      # assert on the None; --check reports it and keeps reading the rest.
+      if not _track:
+        raise RuntimeError(f'Metric {event.metric_name!r} has no MetricExpr')
+      continue
     if event.metric_name and '-' not in event.metric_name:
       metrics.append((event.pmu, event.metric_name, event.metric_expr))
   updates = metric.RewriteMetricsInTermsOfOthers(metrics)
@@ -487,8 +671,12 @@ def read_json_events(path: str, topic: str) -> Sequence[JsonEvent]:
     _json_cache[key] = _read_json_events_impl(path, topic)
   return _json_cache[key]
 
-def preprocess_arch_std_files(archpath: str) -> None:
-  """Read in all architecture standard events."""
+def preprocess_arch_std_files(archpath: str, failures: Optional[List[Tuple[str, Exception]]] = None) -> None:
+  """Read in all architecture standard events.
+
+  A failure is raised, or appended to failures when the caller can carry on
+  without the table; either way the tables after it are still read.
+  """
   for item in os.scandir(archpath):
     if not item.is_file() or not item.name.endswith('.json'):
       continue
@@ -499,7 +687,10 @@ def preprocess_arch_std_files(archpath: str) -> None:
         if event.metric_name:
           _arch_std_events[event.metric_name.lower()] = event
     except Exception as e:
-      raise RuntimeError(f'Failure processing \'{item.name}\' in \'{archpath}\': {e}') from e
+        failure = RuntimeError(f'Failure processing \'{item.name}\' in \'{archpath}\': {e}')
+        if failures is None:
+          raise failure from e
+        failures.append((item.path, failure))
 
 
 def add_events_table_entries(item: os.DirEntry, topic: str) -> None:
@@ -1448,16 +1639,27 @@ def _parallel_worker_count(num_tasks: int) -> int:
   return max(1, min(getattr(os, 'process_cpu_count', os.cpu_count)() or 1,
                     _max_parallel_workers, num_tasks))
 
-def _parallel_read_json_events(task: Tuple[str, str]) -> Tuple[str, str, Sequence[JsonEvent]]:
+def _parallel_read_json_events(task: Tuple[str, str]) -> Tuple[str, str, Any]:
   path, topic = task
-  return path, topic, _read_json_events_impl(path, topic)
-
-def _init_worker(std_events: dict) -> None:
-  global _arch_std_events
+  try:
+    return path, topic, _read_json_events_impl(path, topic)
+  except Exception as e:
+    if not _track:
+      # The build stops here: keep the file and the reason in one message,
+      # the pool adds the traceback.
+      raise RuntimeError(f'Failure processing \'{path}\': {e}') from None
+    # Carried back rather than raised: the parent knows the tree and can
+    # report the file and keep going, which is the point of reading the
+    # tables this build does not use.
+    return path, topic, e
+
+def _init_worker(std_events: dict, track: bool) -> None:
+  global _arch_std_events, _track
   _arch_std_events = std_events
+  _track = track
 
 def main() -> None:
-  global _args
+  global _args, _track
 
   def dir_path(path: str) -> str:
     """Validate path is a directory for argparse."""
@@ -1484,12 +1686,12 @@ def main() -> None:
       if item.is_dir():
         ftw(item.path, list(parents) + [item.name], action)
 
-  ap = argparse.ArgumentParser()
+  ap = argparse.ArgumentParser(description='Generate pmu-events.c from the json tables')
   ap.add_argument('arch', help='Architecture name like x86')
   ap.add_argument('model', nargs='?', help='''Select a model such as skylake to
-reduce the code size.  Normally set to "all", and that is what an omitted
-model means. For architectures like ARM64 with an implementor/model, the
-model must include the implementor such as "arm/cortex-a34".''',
+reduce the code size.  Normally set to "all". For architectures like
+ARM64 with an implementor/model, the model must include the implementor
+such as "arm/cortex-a34".''',
                   default='all')
   ap.add_argument(
       'starting_dir',
@@ -1497,14 +1699,104 @@ model must include the implementor such as "arm/cortex-a34".''',
       help='Root of tree containing architecture directories containing json files'
   )
   ap.add_argument('output_file', nargs='?', default=None,
-                  help='file to write the tables to, default standard output')
+                  help='file to write the tables to, default standard output; '
+                       'not written, and not opened, with --check')
   ap.add_argument('output_string_file', nargs='?', default=None,
                   help='file to write big_c_string to when it is to be kept '
-                       'apart from the tables')
+                       'apart from the tables; ignored with --check')
+  ap.add_argument('--check', action='store_true',
+                  help='read the tables, report the keys that look like a '
+                       'misspelling of a name this file reads on standard '
+                       'error, and exit without writing any table; pass "all" '
+                       'as both arch and model to cover the whole tree.  '
+                       'Nothing is reported when every key is read and every '
+                       'table parses.  The exit status is 0 when the tree is '
+                       'clean, 1 when something was reported and 2 when a '
+                       'table could not be read, so it can gate a script')
   _args = ap.parse_args()
 
-  # Opened here, and not by argparse, so that a failure before the tables are
-  # written cannot empty a file the caller named.
+  if _args.check and (_args.output_file is not None or _args.output_string_file is not None):
+    ap.error('--check writes no table; drop the output arguments')
+  if _args.check:
+    if _args.arch == 'none':
+      ap.error('--check needs an architecture to read')
+    # The model only picks the tables a build needs; a check is about the
+    # tree, so it reads all of it and the model means nothing here.
+    _args.model = 'all'
+    _track = True
+
+  archs = []
+  for item in os.scandir(_args.starting_dir):
+    if not item.is_dir():
+      continue
+    if item.name == _args.arch or _args.arch == 'all' or item.name == 'test' or item.name == 'common':
+      archs.append(item.name)
+
+  if _args.check and _args.arch not in ('all', 'none') and _args.arch not in [
+      item.name for item in os.scandir(_args.starting_dir) if item.is_dir()]:
+    print(f'jevents: error: no architecture directory named \'{_args.arch}\' '
+          f'under \'{_args.starting_dir}\'', file=sys.stderr)
+    sys.exit(2)
+  if not archs and _args.arch != 'none':
+    raise IOError(f'Missing architecture directory \'{_args.arch}\'')
+
+  archs.sort()
+  import concurrent.futures
+  tasks = []
+  def collect_json(parents: Sequence[str], item: os.DirEntry) -> None:
+    if len(parents) == 0:
+      return
+    if item.is_file() and item.name.endswith('.json') and not item.name.endswith('metricgroups.json'):
+      tasks.append((item.path, get_topic(item.name)))
+
+  failed: List[Tuple[str, Exception]] = []
+  try:
+    for arch in archs:
+      arch_path = f'{_args.starting_dir}/{arch}'
+      preprocess_arch_std_files(arch_path, failed if _args.check else None)
+      ftw(arch_path, [], collect_json)
+
+    if not tasks:
+      print(f'jevents: error: no event table under \'{_args.starting_dir}\' '
+            f'matched arch \'{_args.arch}\'', file=sys.stderr)
+      sys.exit(2 if _args.check else 1)
+
+    with concurrent.futures.ProcessPoolExecutor(max_workers=_parallel_worker_count(len(tasks)),
+                                                initializer=_init_worker,
+                                                initargs=(_arch_std_events, _args.check)) as executor:
+      for path, topic, events in executor.map(_parallel_read_json_events, tasks):
+        if isinstance(events, Exception):
+          if not _args.check:
+            raise RuntimeError(f'Failure processing \'{path}\'') from events
+          failed.append((path, events))
+        else:
+          _json_cache[(path, topic)] = events
+  except (RuntimeError, ValueError, OSError, argparse.ArgumentTypeError) as e:
+    if not _args.check:
+      raise
+    failed.append((_args.starting_dir, e))
+
+  if _args.check:
+    # A table this check does not need is reported, not fatal: the check reads
+    # the whole tree and a caller only asked about one part of it.
+    for path, error in failed:
+      text = str(error)
+      # The architecture standard preprocess names the file and its directory
+      # already, so prefixing the path here only repeats it.
+      if text.startswith('Failure processing'):
+        print(f'jevents: error: {text}', file=sys.stderr)
+      else:
+        print(f'jevents: error: '
+              f'{os.path.relpath(path, _args.starting_dir)}: {text}',
+              file=sys.stderr)
+    reported = _report_mistyped_keys()
+    reported = _report_metrics_without_expr() or reported
+    if failed:
+      sys.exit(2)
+    sys.exit(1 if reported else 0)
+
+  # Opened here, and not by argparse, so that --check leaves the files it was
+  # given alone and a failure before the tables are written cannot empty one.
   if _args.output_file in (None, '-'):
     _args.output_file = sys.stdout
   else:
@@ -1540,35 +1832,6 @@ struct pmu_table_entry {
 };
 
 """)
-  archs = []
-  for item in os.scandir(_args.starting_dir):
-    if not item.is_dir():
-      continue
-    if item.name == _args.arch or _args.arch == 'all' or item.name == 'test' or item.name == 'common':
-      archs.append(item.name)
-
-  if len(archs) < 2 and _args.arch != 'none':
-    raise IOError(f'Missing architecture directory \'{_args.arch}\'')
-
-  archs.sort()
-  import concurrent.futures
-  tasks = []
-  def collect_json(parents: Sequence[str], item: os.DirEntry) -> None:
-    if len(parents) == 0:
-      return
-    if item.is_file() and item.name.endswith('.json') and not item.name.endswith('metricgroups.json'):
-      tasks.append((item.path, get_topic(item.name)))
-
-  for arch in archs:
-    arch_path = f'{_args.starting_dir}/{arch}'
-    preprocess_arch_std_files(arch_path)
-    ftw(arch_path, [], collect_json)
-
-  with concurrent.futures.ProcessPoolExecutor(max_workers=_parallel_worker_count(len(tasks)),
-                                              initializer=_init_worker,
-                                              initargs=(_arch_std_events,)) as executor:
-    for path, topic, events in executor.map(_parallel_read_json_events, tasks):
-      _json_cache[(path, topic)] = events
 
   for arch in archs:
     arch_path = f'{_args.starting_dir}/{arch}'
@@ -1607,4 +1870,16 @@ struct pmu_table_entry {
     _args.output_string_file.close()
 
 if __name__ == '__main__':
-  main()
+  try:
+    main()
+  except SystemExit:
+    raise
+  except KeyboardInterrupt:
+    raise
+  except BaseException as e:
+    # A build should see the traceback; a check gives its caller a status,
+    # and 2 is the one that says the tool could not do its job.
+    if _args is not None and getattr(_args, 'check', False):
+      print(f'jevents: error: {e}', file=sys.stderr)
+      sys.exit(2)
+    raise
diff --git a/tools/perf/tests/shell/jevents_check.sh b/tools/perf/tests/shell/jevents_check.sh
new file mode 100755
index 000000000000..2254bc96352c
--- /dev/null
+++ b/tools/perf/tests/shell/jevents_check.sh
@@ -0,0 +1,68 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Check that jevents.py reports unread json keys and refuses a broken table
+
+shelldir=$(dirname "$0")
+. "${shelldir}"/lib/setup_python.sh
+
+# The check reads the tables and needs no build and no hardware, but an
+# installed perf has no pmu-events/ next to the binary.
+pmudir=$(readlink -f "${shelldir}/../../pmu-events")
+if [ ! -f "${pmudir}/jevents.py" ] || [ ! -f "${pmudir}/metric.py" ]; then
+	echo "Skipping: no pmu-events/jevents.py under ${pmudir}"
+	exit 2
+fi
+
+workdir=$(mktemp -d /tmp/jevents_check.XXXXXX)
+trap 'rm -rf "${workdir}"' EXIT
+
+# A table with one key jevents.py reads and one event, so that a clean run
+# says nothing and exits 0.
+mkdir -p "${workdir}/arch/x86/model"
+cat > "${workdir}/arch/x86/model/events.json" <<'JSON'
+[
+  {
+    "EventName": "CHECK_TEST_EVENT",
+    "EventCode": "0x1",
+    "BriefDescription": "a table the check should accept"
+  }
+]
+JSON
+
+run_check() {
+	"${PYTHON}" "${pmudir}/jevents.py" --check x86 all "${workdir}/arch"
+}
+
+run_check
+if [ $? -ne 0 ]; then
+	echo "pmu-events json keys [Failed: a clean table was reported]"
+	exit 1
+fi
+
+# A near miss for a name jevents.py reads is reported, and the status is 1.
+sed -i 's/"BriefDescription"/"BriefDescript6ion"/' \
+	"${workdir}/arch/x86/model/events.json"
+output=$(run_check 2>&1)
+ret=$?
+case "${ret}" in
+1) ;;
+*)	echo "pmu-events json keys [Failed: a misspelled key exited ${ret}]"
+	exit 1 ;;
+esac
+if ! echo "${output}" | grep -q "BriefDescript6ion"; then
+	echo "pmu-events json keys [Failed: the misspelled key was not reported]"
+	exit 1
+fi
+
+# A table that does not parse is a failure of the check and not a finding:
+# the status is 2, which this script must not pass on as a skip.
+echo '{ "truncated": ' > "${workdir}/arch/x86/model/broken.json"
+run_check >/dev/null 2>&1
+ret=$?
+if [ "${ret}" -ne 2 ]; then
+	echo "pmu-events json keys [Failed: an unreadable table exited ${ret}]"
+	exit 1
+fi
+
+echo "pmu-events json keys [Success]"
+exit 0
-- 
2.53.0

