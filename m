Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794339164;
	b=bhjTRTwwwgjYmNmCdlNKXWt1Xx9Ca4/jUcynf4OY/jA75XRm4O7dY8t4Z3Zf9NNZyGQG
	 oJNJQ6mkqP5BwdBrq1fl0C6DVJJLLeQSdHgu4pwNxSyL6FDUQSPOqZZxtsZOwsSKQ2tBl
	 HK/RsBRdQecYAs2mCiYPLbD5YbHegFdaxEGV/b29cBaeIxIBSw/MJXSdFj/4eAhNcYi46
	 EhQk8GXzp+IHPJcDWlMu3uaZU0PS2jTdk97r0DU1Z5L+y6sdHUEHCgJKeVBhSWStz9M4Z
	 6O+9bVRzbwkFlleCi5eOSTXGQijdCo4+5RqbsppovbgQfLOyz/Zr+zFQ4lK6XrWdS8g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794339164;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=Jn45tYXQqVUT7g3yrECuqNpNCCv6hFPv1Ncs0b/RryY=;
	b=PX2yNqUjV6Ta6dHH6V7Ev09LHevkHVrSnNCH9FKZd7BA4GipVNaeD15EzhdgC1DOOlu0
	 4WtaGtY2hAKLMonkxzjPD7I4M2uDYNiYYdVWI6gwWpfdEguB+z1l6Bl3oBniBgCR2wPQS
	 XZ0GnPAGG0EKVP0cs1DV4ONzUaU7bFuYFqYtNDau+72sei1Du832Lo8awjV4mAdXet1LV
	 1/mr/5mwXT3A96MF5mZOOkc7g8Y6UsqucTFCfvAsZwKs7HsZRx7+pF8uvKl7hvexx1UJd
	 aRCAuNP/7zh90FtkUjldK7e1WE9nIfwdIq0gOkqmzZivMRIaKKOPab339jkfsoykY2A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=V3R6Aqlp;
	arc=none smtp.remote-ip=74.125.82.174
Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C08D606A32D
	for <linux-perf-users@vger.kernel.org>; Tue, 10 Nov 2026 19:32:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2C08D606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=V3R6Aqlp
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-36e99cf7bb3so3829396eec.0
        for <linux-perf-users@vger.kernel.org>; Tue, 10 Nov 2026 11:32:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794339163; x=1794943963; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Jn45tYXQqVUT7g3yrECuqNpNCCv6hFPv1Ncs0b/RryY=;
        b=V3R6AqlpBVjKaQ2mMwbtRey8m64XI/k7tMM2qc4os5k1vqGM3Vv9MFuYlM2nPWmyAD
         4SElPke6USYIrn5Hd1ftXAyDRCeSFfE8m7+rHj3N0laWba74dhcSlZSe91hApd8kGSlF
         Ie8M3yYHBLAcODaB2whTlrKDb2boYlqvwtokjhti77ykFSqlwyC0up3qw1Z64HE6fxfc
         yNJJAuXUCl8pa41XI2eo3Lrjv9msum5ks5XjfaH2gWbtCaHX629NpY3d9COx0o5KnwTZ
         PbbE1wui9uc24DKO2IdKWdo6fgaQbv6QvQpJIV3Tb9EHHrT24X9+nDEIeKYL7rFYtx0Y
         rEOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794339163; x=1794943963;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Jn45tYXQqVUT7g3yrECuqNpNCCv6hFPv1Ncs0b/RryY=;
        b=RFdsh8yKRsxMJubIHwOnFhfPMKucCxtN4C/KA2EuYgpLGno6KOhsdKwwRYVC6yjANn
         w1xmkTwFurBIo3HF4iNAm0WQB1xmwDPoBJQmR699TucwqJYNhWN0Z8rae2c/hB4bw+mN
         ibe3i0CqXfOZc7xOhgFqp4vizIq+j52RJH2e8l4GDQ8C/qaB1yHrTkn/TBRZXGFMvXhV
         9yHS731642Oa6Kn26xEQJNnidWT2X4AnL13n593bkuDaRITqeHbEG009jvVVoRk2fzGX
         6YoiheTYdtpxqnlYHuXo3+cN8MupIEWpt2QavPhljc/ULAabtPWd3l660FrmZ8VfGo+X
         1BZg==
X-Gm-Message-State: APuU4Z+c9337Mj9vs7WMwF6NKwF7fx5TvJMTeDKD6iyHfZNaUsQ7FW6C
	r6dxFGQpr/gngXSVoReac9oBXIQmyOVfsaGBVg3Zk7HSulZ8wibRXUzdEa67EA==
X-Gm-Gg: AYBFou3uXnfFFKMwgisQEF7INSFxmpo3EWM/UsNuuev01qK2+XJFyixfIFp2hMC0uJu
	GAkuK+jDkhafEsbN9FTm/Zm7cWL+vgpH8wV97/mJnHMc4YBIYcpYduCIMx32w6gf4JBb1Wmu58H
	TFu/vxNwyBn8ysFzA87JtgnUKtrKVOMnLlcRImP9H95/1a7Pg7GlT26b1wmcfLNopLI/bxEVhru
	KR4An9IPHV/9gKsvA7jmXBUa7lFnqdEHgDAeBEej4QPwlo81uMLympkqrqJmV1USydGrki4PjXR
	s/Vlj/XnIb4HNvTt7C7noR+bJgzRMBvQv5UpeTA7cYLmZoA3+ueZfz99Ivu3uMQvzk97Fpk/a+2
	c2oDELq27nvUBJGRkVFE/UhNbXpdsvZirJkZ9d/dBI8tasv6VqZQgZ5lPKh8tErKxIot4UxH5DW
	yIgLpDE+ehB4q0R9+2F/SmGbPTo7tQmbFPbiptuSCEqy9525XndBEhbuasKzMEpcGmeeA9fRhrk
	PXXCcNiPXY5VZX6W+wGx+Z6Q2oWwfxOb4+LdOmCcclT659M6dnL5OW4GbYRnrY/ATAD8XV58iqJ
	siuKcv3nXdd8IT5A3t6n
X-Received: by 2002:a05:693c:69c9:b0:34d:755b:d60b with SMTP id 5a478bee46e88-37686d341a3mr360718eec.34.1794339162640;
        Tue, 10 Nov 2026 11:32:42 -0800 (PST)
Received: from a1-free ([161.33.196.121])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3751fe2ff5dsm8810933eec.5.2026.11.10.11.32.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 11:32:42 -0800 (PST)
From: TAKANO Mitsuhiro <takano32@gmail.com>
To: linux-perf-users@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>
Cc: Ian Rogers <irogers@google.com>,
	linux-kernel@vger.kernel.org,
	TAKANO Mitsuhiro <takano32@gmail.com>,
	James Clark <james.clark@linaro.org>,
	John Garry <john.garry@linux.dev>
Subject: [PATCH] perf jevents: Check the JSON keys that jevents.py never reads
Date: Tue, 10 Nov 2026 19:32:39 +0000
Message-ID: <20261110193239.1741014-1-takano32@gmail.com>
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

jevents.py reads the fields it wants out of every JSON object by name:
jd.get('BriefDescription'), 'EventCode' in jd, the event_fields table.  A
key spelled differently from the name it looks for is never read, so the
object is built without whatever the field held, and nothing says so.

"BriefDescript6ion" in the three AMD tables (amdzen4/cache.json,
amdzen5/load-store.json, amdzen6/load-store.json) is the case that loses
something: those three events carry no BriefDescription at all, so the
generated table has an empty text field for them.  "PublicDescrition" in
AmpereOneX's mmu.json is the same mistake caught before it cost anything --
the value repeats BriefDescription, and jevents.py drops the long
description when the two are equal, so that table comes out the same either
way.

JsonEvent now remembers which keys of the object it was built from were
never looked at.  `jevents.py --check` reads the tables under <dir> and
reports, for each of those keys that is a near miss for a name jevents.py
reads, the likely spelling and the files carrying it:

  jevents: error: 19 object(s) in 4 file(s) carry a key that looks like a
  misspelling:
    'BriefDescript6ion', did you mean 'BriefDescription'? (3 object(s) in 3
    file(s)):
      x86/amdzen4/cache.json
      x86/amdzen5/load-store.json
      x86/amdzen6/load-store.json
    'PublicDescrition', did you mean 'PublicDescription'? (16 object(s)
    in 1 file(s)):
      arm64/ampere/ampereonex/mmu.json

The architecture and the model are the ones the build takes, and `all` for
both reads every table; the model only picks the tables a build needs, so a
check ignores it.  Naming an architecture reads that directory and the
common and test tables every build reads, and skips the rest.

Keys that are not near misses are left alone. The Intel tables carry
Counter, CountersNumFixed, CountersNumGeneric and Experimental, none of
which jevents.py reads, and Experimental is read by metric.py; a vendor
may add metadata for another reader tomorrow, and an allow list in
jevents.py would mean asking every one of them to edit perf's Python. So
the set of names jevents.py reads is the only list, and a name below the
similarity cutoff is not reported. Over this tree the tables carry 52
distinct key names and jevents.py reads 46 of them; the two misspellings
score 0.97 against the name each was meant to be, and the highest score
among the other unread names is Counter, at 0.78 against CounterMask -- so
any cutoff in that gap reports the same two names, and 0.8 is what this
uses. A key whose words are only reordered ('DescriptionBrief') falls
below it too, and so does a misspelling that lands on another name the
file already reads.

The exit status is 0 when the tree is clean, 1 when something was reported
and 2 when a table could not be read; a bad command line is 2 as well.
make turns either failure into its own status, so a script that has to tell
them apart should run pmu-events/jevents.py directly; for a person it is

  make -C tools/perf jevents-check

which reads the whole tree, and JEVENTS_CHECK_ARCH=x86 reads one
architecture.  That target fails on this tree until the misspellings above
are fixed, which is why they are posted separately and should go in first.

It reads every architecture, not just the one being built: a typo is
cheapest to fix by whoever reads that table next, and that reader may be
building something else.  It is deliberately not part of the build, where a
report about a table the build does not use would fail make for everyone,
and it costs nothing when it does not run, because the tracking is off
unless the check asked for it.  It reads the 973 json files under arch/
that jevents.py parses, and takes seconds of CPU to do it.

It is not a schema: it checks nothing about types, required fields or value
ranges, and it looks at key names only, so a misspelled description in a
value is out of scope.  It also does not read mapfile.csv, which has no
keys, or metricgroups.json, whose keys are group names.

Outside --check this changes two things, both on the failure path.  A table
that does not parse is now reported on stderr as "jevents: error: Exception
processing <path>" and the traceback ends in "Failure processing '<path>'",
where the path used to go to stdout and the traceback came straight from
the pool.  And the output file is now opened after the tables are read, so
a build that fails leaves it as it was instead of truncated to the header.

Written with Hermes Agent, an LLM assistant, which found the misspellings
and wrote this check and its changelog.  I ran the check over the whole
tree, compared the generated tables with those from an unpatched tree on
x86, arm64 and all architectures at once, and ran mypy on jevents.py.

Signed-off-by: TAKANO Mitsuhiro <takano32@gmail.com>
---
 tools/perf/Makefile              |  14 +-
 tools/perf/Makefile.perf         |   1 +
 tools/perf/pmu-events/jevents.py | 348 ++++++++++++++++++++++++++-----
 3 files changed, 314 insertions(+), 49 deletions(-)

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
index 080e04b51b8c..56859e983a4b 100755
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
@@ -453,6 +557,57 @@ class JsonEvent:
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
 _json_cache: Dict[Tuple[str, str], Sequence[JsonEvent]] = {}
 def _read_json_events_impl(path: str, topic: str) -> Sequence[JsonEvent]:
   """Read json events from the specified file."""
@@ -460,7 +615,8 @@ def _read_json_events_impl(path: str, topic: str) -> Sequence[JsonEvent]:
     with open(path, encoding='utf-8') as f:
       events = json.load(f, object_hook=JsonEvent)
   except BaseException:
-    print(f"Exception processing {path}")
+    if not _track:
+      print(f'jevents: error: Exception processing {path}', file=sys.stderr)
     raise
   metrics: list[Tuple[str, str, metric.Expression]] = []
   for event in events:
@@ -481,8 +637,12 @@ def read_json_events(path: str, topic: str) -> Sequence[JsonEvent]:
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
@@ -493,7 +653,10 @@ def preprocess_arch_std_files(archpath: str) -> None:
         if event.metric_name:
           _arch_std_events[event.metric_name.lower()] = event
     except Exception as e:
-        raise RuntimeError(f'Failure processing \'{item.name}\' in \'{archpath}\'') from e
+        failure = RuntimeError(f'Failure processing \'{item.name}\' in \'{archpath}\'')
+        if failures is None:
+          raise failure from e
+        failures.append((item.path, failure))
 
 
 def add_events_table_entries(item: os.DirEntry, topic: str) -> None:
@@ -1442,16 +1605,23 @@ def _parallel_worker_count(num_tasks: int) -> int:
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
@@ -1478,9 +1648,9 @@ def main() -> None:
       if item.is_dir():
         ftw(item.path, list(parents) + [item.name], action)
 
-  ap = argparse.ArgumentParser()
+  ap = argparse.ArgumentParser(description='Generate pmu-events.c from the json tables')
   ap.add_argument('arch', help='Architecture name like x86')
-  ap.add_argument('model', help='''Select a model such as skylake to
+  ap.add_argument('model', nargs='?', help='''Select a model such as skylake to
 reduce the code size.  Normally set to "all". For architectures like
 ARM64 with an implementor/model, the model must include the implementor
 such as "arm/cortex-a34".''',
@@ -1490,12 +1660,111 @@ such as "arm/cortex-a34".''',
       type=dir_path,
       help='Root of tree containing architecture directories containing json files'
   )
-  ap.add_argument(
-      'output_file', type=argparse.FileType('w', encoding='utf-8'), nargs='?', default=sys.stdout)
-  ap.add_argument(
-      'output_string_file', type=argparse.FileType('w', encoding='utf-8'), nargs='?', default=None)
+  ap.add_argument('output_file', nargs='?', default=None,
+                  help='file to write the tables to, default standard output; '
+                       'not written, and not opened, with --check')
+  ap.add_argument('output_string_file', nargs='?', default=None,
+                  help='file to write big_c_string to when it is to be kept '
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
+      print(f'jevents: error: {os.path.relpath(path, _args.starting_dir)}: {error}',
+            file=sys.stderr)
+    reported = _report_mistyped_keys()
+    if failed:
+      sys.exit(2)
+    sys.exit(1 if reported else 0)
+
+  # Opened here, and not by argparse, so that --check leaves the files it was
+  # given alone and a failure before the tables are written cannot empty one.
+  if _args.output_file in (None, '-'):
+    _args.output_file = sys.stdout
+  else:
+    try:
+      _args.output_file = open(_args.output_file, 'w', encoding='utf-8')
+    except OSError as e:
+      ap.error(f'argument output_file: {e}')
+  if _args.output_string_file == '-':
+    _args.output_string_file = sys.stdout
+  elif _args.output_string_file is not None:
+    try:
+      _args.output_string_file = open(_args.output_string_file, 'w', encoding='utf-8')
+    except OSError as e:
+      ap.error(f'argument output_string_file: {e}')
   _args.output_file.write(f"""/* SPDX-License-Identifier: GPL-2.0 */
 /* THIS FILE WAS AUTOGENERATED BY `jevents.py arch={_args.arch} model={_args.model}` ! */
 """)
@@ -1517,35 +1786,6 @@ struct pmu_table_entry {
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
@@ -1584,4 +1824,16 @@ struct pmu_table_entry {
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

base-commit: 7475ea8b58616b33c04afb976cf0fbaad9dd63fb
-- 
2.53.0

