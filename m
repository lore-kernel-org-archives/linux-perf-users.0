Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.70
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794812456;
	b=5LUIuiE1hKMJgxXbSRBVXr18W43yy7jjkRWyjf39Z9b0BSAtpxHUiWlelF7f/ceSub4d
	 7kvXBXpm7e+rxqJyfcxASJ5RwhJBmtT9hWL4ttNa+SorIj869+r3J8aVg3paZY2DSihRa
	 qFUFhSGp92nlTjpC2bgdhBDbtw5Fz2cvbGeLpJCtD86SCmfm80ylaakINc+ATXLSn6L0C
	 VQ+vK/4dx0E+Zz1QprCpsOP+ROUIT9dn7bFIcelpWuG8088cPrDRvV/pLZIXitdjP5ayK
	 X1/0C6e4wgFNlQC+n7mc+f8L1RemoL+Vo74FH+xINwnArkiHYK2h9Rt/yGiHPgBS6Cg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794812456;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=WhkVdE3Yqj04ATxJzl5Or1o01lW+JC8L1NPmORlGNGw=;
	b=zujfc+e0CHpoyZNHnEdVv1MnvOVH4IIle1sqbejrEK7haFjh3j6LCXzLtCf3VrxRI3FZ
	 f59Xn8JJhCxW+kqO8OFYWI0oiKrYC1iFCTY+LvJI8datctjbpU4ZbVY3dlIJVYAyb2SDR
	 f6J6B9bAw7H+ctdSC+VOTtbr88x46iCAfNGYqEUMTAiI/R043f1OawapMHnJrsdOVf6pg
	 JHwFd8MiRi9USJ9sPtfqSQKYKddid3CRtZ8eaZrcO9ZfcGRje2AJGxdkfYxsrSSYS1FdK
	 CmqTTsw+Ob++mzqUYOsr3/Jg9Q6ttSfPbeMAFzw0QdCXZEa/q1b5kT00QWkgoKLawOw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=HfkzI+dm;
	arc=none smtp.remote-ip=74.125.82.70
Received: from mail-dl1-f70.google.com (mail-dl1-f70.google.com [74.125.82.70])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D44B4606A880
	for <linux-perf-users@vger.kernel.org>; Mon, 16 Nov 2026 07:00:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D44B4606A880
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=HfkzI+dm
Received: by mail-dl1-f70.google.com with SMTP id a92af1059eb24-1a71dd190b0so3891728c88.1
        for <linux-perf-users@vger.kernel.org>; Sun, 15 Nov 2026 23:00:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794812455; x=1795417255; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WhkVdE3Yqj04ATxJzl5Or1o01lW+JC8L1NPmORlGNGw=;
        b=HfkzI+dm4lqsROOb+QkaPE0lnBt0T2KZuge6Y7S+XHT9ULlzhi5OsUDT9NhfmOI/6C
         7KZeDZwgmDaRAcAn18nxTH9ZNfHSAlOHl4kHDPdxedH0CA/ePgqeBnLXSKtRHQbZYNfr
         zrVNdG+IW3a7ryC+pgSjvC3or3Y588Bjy77kNebVC+UZ80Huxw/6UXGvZzgukkncYa+0
         NGDTikb4yOPdD/+oWnLOqPiAXUEvmTInrA+3bQCvzI2EmP0NdyuwMLhr2NuBiZ8f05Fd
         8eYMgg0VTfcSCGN4VHgCmLiYRGeYUWqUArD5y+VGo3p63JqXvfF9Pduh6ZZpZCzJyrjS
         z+wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794812455; x=1795417255;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=WhkVdE3Yqj04ATxJzl5Or1o01lW+JC8L1NPmORlGNGw=;
        b=T/WWL4eN2FXwxL0e/NPPHU59vV10cnHMLao9BTKntq211zuGQsRyit8M5cN2mGjmNq
         R8OQixxZXK902OV8WSDFunbTwnGVAxF0DjNUWxoU2lhBAOHc70lU7HfKR7ztzwwjdB19
         t+a4S4gDg2hV5Ax5ihYzpVUlcfP6QYZbRR6h/jhM39/CoOTAR9HpUO4PNC1Q47yIABh5
         +hXxnc9A2o1X3Qy4+x+GtxP26eRWGdxUz0Blel964pz1MsOo4vHUq9SPhCEumIEJhJxA
         c0acSKUqlumi9O1jz1AqfWi/An+r86gQG5T3roIyhVBkH9fV6WNj5DjCW9mGM1b+7CfI
         IaGw==
X-Forwarded-Encrypted: i=1; AL+hErGJQCM8Wx36REzHi/IJ+/V3AIxDUsJM7gLsYy0LpSxnpP4kWunZYMtFaIC5FbcDoIrTrUtm0GAuhq1Yb87AVdiM@vger.kernel.org
X-Gm-Message-State: APuU4Z9g/rG37u8iejkfhV0e1bKOLFmXF45d587xYXpEv5qwMWEYUg7/
	SoY3n1q5LoQeQl7Q/o/tkknRxe7GWHX2d/mMj7wcCvPo+YsUWQB81PPILeSN08PgLV9mY519Uci
	p5Z6DbauCRw==
X-Received: from dldz1-n2.prod.google.com ([2002:a05:701b:4181:20b0:1ad:2ffe:151b])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7023:a4b:20b0:1a4:3fa7:adef
 with SMTP id a92af1059eb24-1b5031bbaecmr10315261c88.47.1794812454563; Sun, 15
 Nov 2026 23:00:54 -0800 (PST)
Date: Sun, 15 Nov 2026 23:00:28 -0800
In-Reply-To: <20261116070038.2968725-1-irogers@google.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261116070038.2968725-1-irogers@google.com>
X-Mailer: git-send-email 2.56.1.703.gf848ed807c-goog
Message-ID: <20261116070038.2968725-2-irogers@google.com>
Subject: [PATCH v2 01/10] perf jevents: Store raw bytes in BigCString instead
 of C-escaped strings
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Ian Rogers <irogers@google.com>
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
 tools/perf/pmu-events/jevents.py | 153 +++++++++++++++----------------
 1 file changed, 75 insertions(+), 78 deletions(-)

diff --git a/tools/perf/pmu-events/jevents.py b/tools/perf/pmu-events/jevents.py
index 080e04b51b8c..3334140ba20e 100755
--- a/tools/perf/pmu-events/jevents.py
+++ b/tools/perf/pmu-events/jevents.py
@@ -11,7 +11,7 @@ from typing import (Callable, Dict, Optional, Sequence, Set, Tuple)
 import collections
 
 # Global command line arguments.
-_args = None
+_args: Optional[argparse.Namespace] = None
 # List of regular event tables.
 _event_tables: list[str] = []
 # List of event tables generated from "/sys" directories.
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
+    pmu_name_bytes = (pmu + '\0').encode('utf-8')
+    pmu_comment = bytes_to_c_literal(pmu_name_bytes).replace('*/', r'\*\/')
     _args.output_file.write(f"""\t{{
 \t\t.entries = {_pending_events_tblname}_{tbl_pmu},
 \t\t.num_entries = ARRAY_SIZE({_pending_events_tblname}_{tbl_pmu}),
-\t\t.pmu_name = {{ {_bcs.offsets[pmu_name]} /* {pmu_name} */ }},
+\t\t.pmu_name = {{ {_bcs.offsets[pmu_name_bytes]} /* {pmu_comment} */ }},
 \t}},
 """)
   _args.output_file.write('};\n\n')
@@ -612,11 +607,12 @@ def print_pending_metrics() -> None:
 static const struct pmu_table_entry {_pending_metrics_tblname}[] = {{
 """)
   for (pmu, tbl_pmu) in sorted(pmus):
-    pmu_name = f"{pmu}\\000"
+    pmu_name_bytes = (pmu + '\0').encode('utf-8')
+    pmu_comment = bytes_to_c_literal(pmu_name_bytes).replace('*/', r'\*\/')
     _args.output_file.write(f"""\t{{
 \t\t.entries = {_pending_metrics_tblname}_{tbl_pmu},
 \t\t.num_entries = ARRAY_SIZE({_pending_metrics_tblname}_{tbl_pmu}),
-\t\t.pmu_name = {{ {_bcs.offsets[pmu_name]} /* {pmu_name} */ }},
+\t\t.pmu_name = {{ {_bcs.offsets[pmu_name_bytes]} /* {pmu_comment} */ }},
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
-- 
2.56.1.703.gf848ed807c-goog

