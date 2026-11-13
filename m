Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.69
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794604118;
	b=pTReTYQr4OZtXzWxxEMd7IWK1h3+ze/dZ/UJkl19QyirOj7UMwJn+0+KK2Vcy273pjWt
	 zkTFPWxn4sTrnGBf0SXqI2BYy3bAREyrJgI5IrBiiQAksWtromBbRpNT0azFUa+OtodOy
	 vg2kqyZ8vvlUq42h5Xz4HoKiX9FpRskQgdHFLxCa3w40hDAVKg4cBkx/KXM2kawMiG955
	 KzGG444wXTzE60Q1KiTkVM/LJdd0mL3Bu0UWH0x7iw3Chu5tVpw/bmVeZniDyJSVClUnw
	 EjTeyE9KzP12IfadGhj+TMZ7SgpRTSOIT2U2P7GDsqehqQdbgqis96Ai9W9ElDFSAzA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794604118;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=n98WFEJvrY3FVhLvevHaMC7ZK+2TxHOhMVZeIfaPNiI=;
	b=5UXuGBgSHtnHiBceKEKpygRjSr01QR1a0MSFfYkmFO2fruyJ5P2TvWZxvO8crSCSDj+T
	 YL5cUUs3gyI/NaelILYouIlDkd6axV+cQdNnO5vscsrmPyYtvWN4jtWOwuGuQ+atpI/ub
	 hN5C0RLggbPkmts5KFmpfFiFia2FMvQrGDXd+aAKjQBCjUYCSiL1R3i+fdET6o9um0EdB
	 VleqY6xz2q/Jz+0KD4O7T2DkV49fvxkRCMlIdF48Db+r8pnRemcZOCBrvf6U92wt8/I25
	 oH6ABe4AMytf3Wdsvk8ZQNa8n3oC4HS5rOLhfwWjjOHxMND3aI3j0NejAR3fZuaSxNA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b="XZ/hw+25";
	arc=none smtp.remote-ip=209.85.216.69
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 036D1606A33D
	for <linux-perf-users@vger.kernel.org>; Fri, 13 Nov 2026 21:08:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 036D1606A33D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=XZ/hw+25
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-3b191f8a9b3so2015495a91.1
        for <linux-perf-users@vger.kernel.org>; Fri, 13 Nov 2026 13:08:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794604116; x=1795208916; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=n98WFEJvrY3FVhLvevHaMC7ZK+2TxHOhMVZeIfaPNiI=;
        b=XZ/hw+25HzIpM5YrLXneXx/FQEfAHC9UYoO6FEA50CJQA8J4Lx7tx479QZhqOUWKDn
         UfX10PEAaVwn1Izt8b8mcUJZmKjyLGczDrkSiXx1ZABiS2YbUs95YYhW5q1skOU8w1u8
         0H5W4POBYbT/8zp8uf+rcMkiLK4UKxPcwjM1swRZFpYyv79OxWugKcl8hadlcFaBdFj6
         dZEBwSYAM8gskwpbw5jGGzrRcilQ7owPACHKW5dA8fB9m3eSfJ1hEUfO7RSGJgSQBpWE
         woD1iIItEMjQ3hB0IIlkOrEMBLPap5ZT6qErIGCt8hXjhCvSyN38sQolSqBySDaKn/2n
         Evag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794604116; x=1795208916;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=n98WFEJvrY3FVhLvevHaMC7ZK+2TxHOhMVZeIfaPNiI=;
        b=FeMXkECYr2A6/MEVIgltXFApmi5TOSitqCPXaIlPL3/eh7zAOnX9aTWqR6tnGW/qAt
         S7j7wKj1CRPnMeZl33Ary/HeVR4pL3XBFLE+jEF/jvVFNSnN1fx7RgM+5U1kDKWH82Mc
         mGqa9vx5f8Fn7S+pikF9JhGOAOUF8BLOdELHSjqz++Wu9Twd9rb3EpkB8IQB1Opk1Ost
         sl1lP2/qiCzksdPQ3Q+ZFwpRj6fIf9Ue3rHGfGGwWj8KBgtr+NYp60KobWhoJ0fiif3/
         2fUSlEE9eENioTMFaAU6VpIr5btvwAqy8lsOtdKACr7p7uWCyB8cAhYAzIhUaniNXYxr
         Xg3w==
X-Forwarded-Encrypted: i=1; AL+hErGxMvwd9PrdfkrwalGFkiZ2i7hILcqj3QI1CnnN3X0sTK/Afz4V4U+FlUR57WX8IlwU5Y2b77IQYPmrmJA3bu0b@vger.kernel.org
X-Gm-Message-State: APuU4Z/L3m5kokaPulFjXvGCkJj0cbwX/kuLwG/n17p/+SYLUd3718AQ
	yN8Dkr6u/VSBt1+yhDGY0SBoKXb+YjB2i3JKJnfhR9DRhQ/YzWyU9Iouvil5GIElNDkfNcyV+Fp
	/FwibFQ/yPg==
X-Received: from pgca1-n1.prod.google.com ([2002:a05:6a02:6381:10b0:cdd:a60b:df36])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:2241:b0:3a7:3474:b1ee
 with SMTP id 98e67ed59e1d1-3b1b0b50042mr3579096a91.60.1794604116151; Fri, 13
 Nov 2026 13:08:36 -0800 (PST)
Date: Fri, 13 Nov 2026 13:08:13 -0800
In-Reply-To: <20261113210822.3112700-1-irogers@google.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261113210822.3112700-1-irogers@google.com>
X-Mailer: git-send-email 2.56.1.703.gf848ed807c-goog
Message-ID: <20261113210822.3112700-2-irogers@google.com>
Subject: [PATCH 01/10] perf jevents: Store raw bytes in BigCString instead of
 C-escaped strings
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, Kan Liang <kan.liang@linux.intel.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"

Previously BigCString stored C-escaped strings (with literal '\000',
'\n', '\"', '\\') and estimated their compiled byte length via
c_len(), which did not handle arbitrary escapes and caused both suffix
folding and metricgroups sorting to compare '\000' ('\\' == 0x5c)
rather than NUL (0x00). Notably, sorting metricgroup names with '\000'
placed 'BadSpec\000' ('S' == 0x53) before 'Bad\000' ('\\' == 0x5c),
breaking strcmp() binary search in describe_metricgroup("Bad").

Store raw NUL-delimited UTF-8 bytes directly in BigCString and
_metricgroups, compute offsets from len(b) directly, remove c_len(), and
escape bytes into C string literals only when emitting C source via
bytes_to_c_literal().

Fixes: 66c6e0c10027 ("perf jevents: Add support for metricgroup descriptions")
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/jevents.py | 151 +++++++++++++++----------------
 1 file changed, 74 insertions(+), 77 deletions(-)

diff --git a/tools/perf/pmu-events/jevents.py b/tools/perf/pmu-events/jevents.py
index 080e04b51b8c..0721c8b2551c 100755
--- a/tools/perf/pmu-events/jevents.py
+++ b/tools/perf/pmu-events/jevents.py
@@ -37,7 +37,7 @@ _pending_metrics_tblname: Optional[str] = None
 # Global BigCString shared by all structures.
 _bcs: "BigCString"
 # Map from the name of a metric group to a description of the group.
-_metricgroups: Dict[str, str] = {}
+_metricgroups: Dict[bytes, bytes] = {}
 # Order specific JsonEvent attributes will be visited.
 _json_event_attributes = [
     # cmp_sevent related attributes.
@@ -74,26 +74,24 @@ def file_name_to_table_name(prefix: str, parents: Sequence[str],
   return tblname.replace('-', '_')
 
 
-def c_len(s: str) -> int:
-  """Return the length of s a C string
+_C_ESCAPE_TABLE = str.maketrans({
+    '\\': '\\\\',
+    '"': '\\"',
+    '\n': '\\n',
+    '\r': '\\r',
+    '\t': '\\t',
+    **{chr(c): f'\\{c:03o}' for c in range(32) if chr(c) not in ('\n', '\r', '\t')},
+    chr(127): '\\177',
+})
+
+
+def bytes_to_c_literal(b: bytes) -> str:
+  """Convert UTF-8 bytes (with NUL terminators) to a C string literal body."""
+  return b.decode('utf-8').translate(_C_ESCAPE_TABLE)
 
-  This doesn't handle all escape characters properly. It first assumes
-  all \\ are for escaping, it then adjusts as it will have over counted
-  \\. The code uses \000 rather than \0 as a terminator as an adjacent
-  number would be folded into a string of \0 (ie. "\0" + "5" doesn't
-  equal a terminator followed by the number 5 but the escape of
-  \05). The code adjusts for \000 but not properly for all octal, hex
-  or unicode values.
-  """
-  try:
-    utf = s.encode(encoding='utf-8',errors='strict')
-  except:
-    print(f'broken string {s}')
-    raise
-  return len(utf) - utf.count(b'\\') + utf.count(b'\\\\') - (utf.count(b'\\000') * 2)
 
 class BigCString:
-  """A class to hold many strings concatenated together.
+  """A class to hold many byte strings concatenated together.
 
   Generating a large number of stand-alone C strings creates a large
   number of relocations in position independent code. The BigCString
@@ -105,12 +103,12 @@ class BigCString:
   strings are merged. If a longer string ends-with the same value as a
   shorter string, these entries are also merged.
   """
-  strings: Set[str]
+  strings: Set[bytes]
   big_string: Sequence[str]
-  offsets: Dict[str, int]
+  offsets: Dict[bytes, int]
   insert_number: int
-  insert_point: Dict[str, int]
-  metrics: Set[str]
+  insert_point: Dict[bytes, int]
+  metrics: Set[bytes]
 
   def __init__(self):
     self.strings = set()
@@ -118,21 +116,21 @@ class BigCString:
     self.insert_point = {}
     self.metrics = set()
 
-  def add(self, s: str, is_metric: bool) -> None:
-    """Called to add to the big string."""
-    if s not in self.strings:
-      self.strings.add(s)
-      self.insert_point[s] = self.insert_number
+  def add(self, b: bytes, is_metric: bool) -> None:
+    """Called to add NUL-terminated UTF-8 bytes to the big string."""
+    if b not in self.strings:
+      self.strings.add(b)
+      self.insert_point[b] = self.insert_number
       self.insert_number += 1
       if is_metric:
-        self.metrics.add(s)
+        self.metrics.add(b)
 
   def compute(self) -> None:
     """Called once all strings are added to compute the string and offsets."""
 
-    folded_strings = {}
+    folded_strings: Dict[bytes, bytes] = {}
     # Determine if two strings can be folded, ie. let 1 string use the
-    # end of another. First reverse all strings and sort them.
+    # end of another. First reverse all byte strings and sort them.
     sorted_reversed_strings = sorted([x[::-1] for x in self.strings])
 
     # Strings 'xyz' and 'yz' will now be [ 'zy', 'zyx' ]. Scan forward
@@ -140,16 +138,16 @@ class BigCString:
     # into, in the example rather than using 'yz' we can use'xyz' at
     # an offset of 1. We record which string can be folded into which
     # in folded_strings, we don't need to record the offset as it is
-    # trivially computed from the string lengths.
-    for pos,s in enumerate(sorted_reversed_strings):
+    # trivially computed from the byte lengths.
+    for pos, b in enumerate(sorted_reversed_strings):
       best_pos = pos
       for check_pos in range(pos + 1, len(sorted_reversed_strings)):
-        if sorted_reversed_strings[check_pos].startswith(s):
+        if sorted_reversed_strings[check_pos].startswith(b):
           best_pos = check_pos
         else:
           break
       if pos != best_pos:
-        folded_strings[s[::-1]] = sorted_reversed_strings[best_pos][::-1]
+        folded_strings[b[::-1]] = sorted_reversed_strings[best_pos][::-1]
 
     # Compute reverse mappings for debugging.
     fold_into_strings = collections.defaultdict(set)
@@ -157,36 +155,34 @@ class BigCString:
       if key != val:
         fold_into_strings[val].add(key)
 
-    # big_string_offset is the current location within the C string
+    # big_string_offset is the current byte location within the C string
     # being appended to - comments, etc. don't count. big_string is
-    # the string contents represented as a list. Strings are immutable
-    # in Python and so appending to one causes memory issues, while
-    # lists are mutable.
+    # the C string literal contents represented as a list.
     big_string_offset = 0
     self.big_string = []
     self.offsets = {}
 
-    def string_cmp_key(s: str) -> Tuple[bool, int, str]:
-      return (s in self.metrics, self.insert_point[s], s)
+    def string_cmp_key(b: bytes) -> Tuple[bool, int, bytes]:
+      return (b in self.metrics, self.insert_point[b], b)
 
     # Emit all strings that aren't folded in a sorted manner.
-    for s in sorted(self.strings, key=string_cmp_key):
-      if s not in folded_strings:
-        self.offsets[s] = big_string_offset
+    for b in sorted(self.strings, key=string_cmp_key):
+      if b not in folded_strings:
+        self.offsets[b] = big_string_offset
         self.big_string.append(f'/* offset={big_string_offset} */\n"')
-        self.big_string.append(s)
+        self.big_string.append(bytes_to_c_literal(b))
         self.big_string.append('"')
-        if s in fold_into_strings:
-          self.big_string.append(' /* also: ' + ', '.join(fold_into_strings[s]) + ' */')
+        if b in fold_into_strings:
+          also = [bytes_to_c_literal(x).replace('*/', r'\*\/')
+                  for x in sorted(fold_into_strings[b])]
+          self.big_string.append(' /* also: ' + ', '.join(also) + ' */')
         self.big_string.append('\n')
-        big_string_offset += c_len(s)
-        continue
+        big_string_offset += len(b)
 
     # Compute the offsets of the folded strings.
-    for s in folded_strings.keys():
-      assert s not in self.offsets
-      folded_s = folded_strings[s]
-      self.offsets[s] = self.offsets[folded_s] + c_len(folded_s) - c_len(s)
+    for b, folded_b in folded_strings.items():
+      assert b not in self.offsets
+      self.offsets[b] = self.offsets[folded_b] + len(folded_b) - len(b)
 
 _bcs = BigCString()
 
@@ -204,8 +200,7 @@ class JsonEvent:
       """Fix formatting issue for the desc string."""
       if s is None:
         return None
-      return s.removesuffix('.  ').removesuffix('. ').removesuffix('.').replace(
-          '\n', '\\n').replace('\"', '\\"').replace('\r', '\\r')
+      return s.removesuffix('.  ').removesuffix('. ').removesuffix('.')
 
     def convert_aggr_mode(aggr_mode: Optional[str]) -> Optional[str]:
       """Returns the aggr_mode_class enum value associated with the JSON string."""
@@ -425,21 +420,19 @@ class JsonEvent:
         s += f'\t{attr} = {value},\n'
     return s + '}'
 
-  def build_c_string(self, is_metric: bool) -> str:
+  def build_bytes(self, is_metric: bool) -> bytes:
+    """Encode the event or metric attributes as NUL-delimited UTF-8 bytes."""
     s = ''
     for attr in _json_metric_attributes if is_metric else _json_event_attributes:
       x = getattr(self, attr)
       if is_metric and x and attr == 'metric_expr':
-        # Convert parsed metric expressions into a string. Slashes
-        # must be doubled in the file.
-        x = x.ToPerfJson().replace('\\', '\\\\')
-      if is_metric and x and attr == 'metric_threshold':
-        x = x.replace('\\', '\\\\')
+        # Convert parsed metric expressions into a string.
+        x = x.ToPerfJson()
       if attr in _json_enum_attributes:
         s += x if x else '0'
       else:
-        s += f'{x}\\000' if x else '\\000'
-    return s
+        s += f'{x}\0' if x else '\0'
+    return s.encode('utf-8')
 
   def to_c_string(self, is_metric: bool) -> str:
     """Representation of the event as a C struct initializer."""
@@ -448,9 +441,10 @@ class JsonEvent:
         s = s.replace('*/', r'\*\/')
         return f'\t/* {s} */\n' if len(s) < 80 else f'\t/* {s[0:80]}... */\n'
 
-    s = self.build_c_string(is_metric)
+    b = self.build_bytes(is_metric)
+    s = bytes_to_c_literal(b)
     assert _bcs is not None
-    return f'{make_comment(s)}\t{{ { _bcs.offsets[s] } }},\n'
+    return f'{make_comment(s)}\t{{ { _bcs.offsets[b] } }},\n'
 
 
 _json_cache: Dict[Tuple[str, str], Sequence[JsonEvent]] = {}
@@ -556,11 +550,12 @@ def print_pending_events() -> None:
 static const struct pmu_table_entry {_pending_events_tblname}[] = {{
 """)
   for (pmu, tbl_pmu) in sorted(pmus):
-    pmu_name = f"{pmu}\\000"
+    pmu_name = (pmu + '\0').encode('utf-8')
+    pmu_comment = bytes_to_c_literal(pmu_name).replace('*/', r'\*\/')
     _args.output_file.write(f"""\t{{
 \t\t.entries = {_pending_events_tblname}_{tbl_pmu},
 \t\t.num_entries = ARRAY_SIZE({_pending_events_tblname}_{tbl_pmu}),
-\t\t.pmu_name = {{ {_bcs.offsets[pmu_name]} /* {pmu_name} */ }},
+\t\t.pmu_name = {{ {_bcs.offsets[pmu_name]} /* {pmu_comment} */ }},
 \t}},
 """)
   _args.output_file.write('};\n\n')
@@ -612,11 +607,12 @@ def print_pending_metrics() -> None:
 static const struct pmu_table_entry {_pending_metrics_tblname}[] = {{
 """)
   for (pmu, tbl_pmu) in sorted(pmus):
-    pmu_name = f"{pmu}\\000"
+    pmu_name = (pmu + '\0').encode('utf-8')
+    pmu_comment = bytes_to_c_literal(pmu_name).replace('*/', r'\*\/')
     _args.output_file.write(f"""\t{{
 \t\t.entries = {_pending_metrics_tblname}_{tbl_pmu},
 \t\t.num_entries = ARRAY_SIZE({_pending_metrics_tblname}_{tbl_pmu}),
-\t\t.pmu_name = {{ {_bcs.offsets[pmu_name]} /* {pmu_name} */ }},
+\t\t.pmu_name = {{ {_bcs.offsets[pmu_name]} /* {pmu_comment} */ }},
 \t}},
 """)
   _args.output_file.write('};\n\n')
@@ -646,23 +642,22 @@ def preprocess_one_file(parents: Sequence[str], item: os.DirEntry) -> None:
       metricgroup_descriptions = json.load(f)
     for mgroup in metricgroup_descriptions:
       assert len(mgroup) > 1, parents
-      description = f"{metricgroup_descriptions[mgroup]}\\000"
-      mgroup = f"{mgroup}\\000"
-      _bcs.add(mgroup, is_metric=True)
+      description = (metricgroup_descriptions[mgroup] + '\0').encode('utf-8')
+      mgroup_bytes = (mgroup + '\0').encode('utf-8')
+      _bcs.add(mgroup_bytes, is_metric=True)
       _bcs.add(description, is_metric=True)
-      _metricgroups[mgroup] = description
+      _metricgroups[mgroup_bytes] = description
     return
 
   topic = get_topic(item.name)
   for event in read_json_events(item.path, topic):
-    pmu_name = f"{event.pmu}\\000"
+    pmu_name = (event.pmu + '\0').encode('utf-8')
     if event.name:
       _bcs.add(pmu_name, is_metric=False)
-      _bcs.add(event.build_c_string(is_metric=False), is_metric=False)
+      _bcs.add(event.build_bytes(is_metric=False), is_metric=False)
     if event.metric_name:
-      pmu_name = f"{event.pmu}\\000"
       _bcs.add(pmu_name, is_metric=True)
-      _bcs.add(event.build_c_string(is_metric=True), is_metric=True)
+      _bcs.add(event.build_bytes(is_metric=True), is_metric=True)
 
 def process_one_file(parents: Sequence[str], item: os.DirEntry) -> None:
   """Process a JSON file during the main walk."""
@@ -1409,8 +1404,10 @@ static const int metricgroups[][2] = {
 """)
   for mgroup in sorted(_metricgroups):
     description = _metricgroups[mgroup]
+    mgroup_comment = bytes_to_c_literal(mgroup).replace('*/', r'\*\/')
+    desc_comment = bytes_to_c_literal(description).replace('*/', r'\*\/')
     _args.output_file.write(
-        f'\t{{ {_bcs.offsets[mgroup]}, {_bcs.offsets[description]} }}, /* {mgroup} => {description} */\n'
+        f'\t{{ {_bcs.offsets[mgroup]}, {_bcs.offsets[description]} }}, /* {mgroup_comment} => {desc_comment} */\n'
     )
   _args.output_file.write("""
 };

base-commit: 4af65363b11fc4fe65fcb497f68bbe4f3e3a4d2c
-- 
2.56.1.703.gf848ed807c-goog

