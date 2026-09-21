Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CA7136EAAC
	for <linux-perf-users@vger.kernel.org>; Mon, 21 Sep 2026 05:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789967282; cv=none; b=cBC0/lS7zT3O+oy8HReaeM+3bEuafOpBrvduIcL58PG6RuC+yULFi24l0oS+XOKOG/LtK0L83TJ/wSDWzE28t+L2NBsZNHcQI5Es4lIGkI03GFZ0Pdyu/1kQkdLUCCB9Iug6CXZl5glmfA7OS3Z0n2HTLKIb/S41ksEWG0WkIQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789967282; c=relaxed/simple;
	bh=CVFC5Oc8OrX6BYpRhXqwopKVQiM6qOMDezPGUV4NIz0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=MsVDfizDusI7Kg60h4sVojMGYLMss1DeRscpa8qd30BIcf+1kgyEKaLo1Jhvj/zdcCVqknEYe4jWnqlZXPs6VeLWQyPgKZOMgSD3XPoJxamDk6s7KxxSodvezMapWR4JtzADHz26w3Bmb/CjxCLDz4iBbIRbJjzvLO/XTz+ZIR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qypTrI0q; arc=none smtp.client-ip=209.85.216.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qypTrI0q"
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-39de4e72b33so4877900a91.2
        for <linux-perf-users@vger.kernel.org>; Sun, 20 Sep 2026 22:07:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789967279; x=1790572079; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YiMqlFDwW7z5apZFaPOilsG57ssfSTIODLHfg74as9Q=;
        b=qypTrI0qZVOZZx+Pv1BCK3SST/3UsJFurkVfeywbvKZvqhLfLwCa/6cXWWmNL2gIgL
         bWCPjf11mWGJ5/YYYIw3kxvd6rHnNe0sW7GLkG+nMl+KXv4bojEAcGg6PdKSmeoolwM/
         AW3GlnkU1BMsJRHWUKzPPPqBQJePpL2S7UtYwtAe/MiaSpxKv4xj8jZomdL1ePSMRfck
         6Edo6JxQSBf/pettuA6tllcFcT8nLmwYcF8t9+n2b6Kpy4tkDzDFw1BlVw9ib3mOXpGq
         XSCsUJTrjdOQDMkijrFjDbNTOOPRz1Ew44036hLGTdZQSSAKVykVWwiGUM0MBUpEx55g
         pZrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789967279; x=1790572079;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YiMqlFDwW7z5apZFaPOilsG57ssfSTIODLHfg74as9Q=;
        b=VVBQ+nRwKrICcgAagabPLP4ZHu5/timXnSFAsD+BZYnsXK4NKCMiYbBCMgdAoEcx4b
         lY0AbD1HG6qsiNhAIJSXPm5qOF55smwsud23Oipyrg5VGUmXoeTvKeTbGHe+w9gDbKcX
         nAgTUWFZOrJoqysjl985/S2rVnyY54IrolM6mMeOZAYO5bJNszIM3y2TxSyU8BpLBVhB
         Rih4hR4ObdRil89mSNhPAYOzJMcKvrhdLS5AMUGy652DbUVbyElElSbXb6Kr8nDy+7Ws
         HD30hoZD4EinkaV+Es80cmEHUrtE5+qMo+/WjYa06UkdaLDW2V8AVAgGj0eFjo/+oa6q
         Fjeg==
X-Forwarded-Encrypted: i=1; AKwUvBxYJ8gSaiP6eSVRZcHQJ6A/se0bnbsiGgofnJpYt4jKOlC4tGhgvFiyzl95Fn7vp1LuMF462chNhBxNHu0vDw1K@vger.kernel.org
X-Gm-Message-State: AFuF++nd5RCZUvXtHxJU2WSIN8Fde5F3DLVwcdTO2buF877UZ7Ax1TC7
	9LyOoYorY7QoS2YplElEi0Q0ZvfVXmAxsENKbIHb9jWvt319LEE+QH9LtCq9EaKDMNoYTx4mfsl
	Lw5VxMG+rXQ==
X-Received: from dycaa4.prod.google.com ([2002:a05:7301:5404:b0:33c:1d41:326])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:56c5:b0:39d:f247:bab
 with SMTP id 98e67ed59e1d1-39e54b66f85mr16058030a91.6.1789967279013; Sun, 20
 Sep 2026 22:07:59 -0700 (PDT)
Date: Sun, 20 Sep 2026 22:06:39 -0700
In-Reply-To: <cover.1789966896.git.irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1789966896.git.irogers@google.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Message-ID: <dd5d083461aa41e9a88e36bb079f223e17edfb0f.1789966896.git.irogers@google.com>
Subject: [PATCH v2 21/49] perf python: Port event_analyzing_sample to perf module
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, alice.mei.rogers@gmail.com, 
	linux-perf-users@vger.kernel.org, namhyung@kernel.org
Cc: adrian.hunter@intel.com, dapeng1.mi@linux.intel.com, 
	james.clark@linaro.org, leo.yan@linux.dev, linux-kernel@vger.kernel.org, 
	mingo@redhat.com, peterz@infradead.org, tmricht@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"

Port event_analyzing_sample.py to a standalone script in
tools/perf/python/ using the perf module and standard library sqlite3
module.

Improvements compared to the legacy script:
- Encapsulate database state in a _DB container instead of mutating
  module-level globals, and ensure temporary SQLite database files are
  cleaned up on exit.
- Add argparse CLI options (-i/--input and -d/--db) while preserving
  PerfEvent, PebsEvent, and PebsNHM binary raw_buf unpacking and
  symbol/DSO histogram reporting.
- Remove Python 2 compatibility code and add type annotations.

Add a shell test (test_event_analyzing_sample_python.sh) to verify the
standalone script.

Assisted-by: Antigravity:gemini-3.1-pro
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/python/event_analyzing_sample.py   | 321 ++++++++++++++++++
 .../test_event_analyzing_sample_python.sh     |  58 ++++
 2 files changed, 379 insertions(+)
 create mode 100755 tools/perf/python/event_analyzing_sample.py
 create mode 100755 tools/perf/tests/shell/test_event_analyzing_sample_python.sh

diff --git a/tools/perf/python/event_analyzing_sample.py b/tools/perf/python/event_analyzing_sample.py
new file mode 100755
index 000000000000..3ec1cf2bda85
--- /dev/null
+++ b/tools/perf/python/event_analyzing_sample.py
@@ -0,0 +1,321 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: GPL-2.0
+"""
+General event handler in Python, using SQLite to analyze events.
+
+The 2 database related functions in this script just show how to gather
+the basic information, and users can modify and write their own functions
+according to their specific requirement.
+
+The first function "show_general_events" just does a basic grouping for all
+generic events with the help of sqlite, and the 2nd one "show_pebs_ll" is
+for a x86 HW PMU event: PEBS with load latency data.
+
+Ported from tools/perf/scripts/python/event_analyzing_sample.py
+"""
+from __future__ import annotations
+
+import argparse
+import math
+import os
+import sqlite3
+import struct
+import tempfile
+from typing import Any
+import perf
+
+# Event types, user could add more here
+EVTYPE_GENERIC  = 0
+EVTYPE_PEBS     = 1     # Basic PEBS event
+EVTYPE_PEBS_LL  = 2     # PEBS event with load latency info
+EVTYPE_IBS      = 3
+
+#
+# Currently we don't have good way to tell the event type, but by
+# the size of raw buffer, raw PEBS event with load latency data's
+# size is 176 bytes, while the pure PEBS event's size is 144 bytes.
+#
+def create_event(name, comm, dso, symbol, raw_buf):
+    """Create an event object based on raw buffer size."""
+    if len(raw_buf) == 144:
+        event = PebsEvent(name, comm, dso, symbol, raw_buf)
+    elif len(raw_buf) == 176:
+        event = PebsNHM(name, comm, dso, symbol, raw_buf)
+    else:
+        event = PerfEvent(name, comm, dso, symbol, raw_buf)
+
+    return event
+
+class PerfEvent:
+    """Base class for all perf event samples."""
+    event_num = 0
+    def __init__(self, name, comm, dso, symbol, raw_buf, ev_type=EVTYPE_GENERIC):
+        self.name       = name
+        self.comm       = comm
+        self.dso        = dso
+        self.symbol     = symbol
+        self.raw_buf    = raw_buf
+        self.ev_type    = ev_type
+        PerfEvent.event_num += 1
+
+    def show(self):
+        """Display PMU event info."""
+        print(f"PMU event: name={self.name:12s}, symbol={self.symbol:24s}, "
+              f"comm={self.comm:8s}, dso={self.dso:12s}")
+
+#
+# Basic Intel PEBS (Precise Event-based Sampling) event, whose raw buffer
+# contains the context info when that event happened: the EFLAGS and
+# linear IP info, as well as all the registers.
+#
+class PebsEvent(PerfEvent):
+    """Intel PEBS event."""
+    pebs_num = 0
+    def __init__(self, name, comm, dso, symbol, raw_buf, ev_type=EVTYPE_PEBS):
+        tmp_buf = raw_buf[0:80]
+        flags, ip, ax, bx, cx, dx, si, di, bp, sp = struct.unpack('<QQQQQQQQQQ', tmp_buf)
+        self.flags = flags
+        self.ip    = ip
+        self.ax    = ax
+        self.bx    = bx
+        self.cx    = cx
+        self.dx    = dx
+        self.si    = si
+        self.di    = di
+        self.bp    = bp
+        self.sp    = sp
+
+        super().__init__(name, comm, dso, symbol, raw_buf, ev_type)
+        PebsEvent.pebs_num += 1
+        del tmp_buf
+
+#
+# Intel Nehalem and Westmere support PEBS plus Load Latency info which lie
+# in the four 64 bit words write after the PEBS data:
+#       Status: records the IA32_PERF_GLOBAL_STATUS register value
+#       DLA:    Data Linear Address (EIP)
+#       DSE:    Data Source Encoding, where the latency happens, hit or miss
+#               in L1/L2/L3 or IO operations
+#       LAT:    the actual latency in cycles
+#
+class PebsNHM(PebsEvent):
+    """Intel Nehalem/Westmere PEBS event with load latency."""
+    pebs_nhm_num = 0
+    def __init__(self, name, comm, dso, symbol, raw_buf, ev_type=EVTYPE_PEBS_LL):
+        tmp_buf = raw_buf[144:176]
+        status, dla, dse, lat = struct.unpack('<QQQQ', tmp_buf)
+        self.status = status
+        self.dla = dla
+        self.dse = dse
+        self.lat = lat
+
+        super().__init__(name, comm, dso, symbol, raw_buf, ev_type)
+        PebsNHM.pebs_nhm_num += 1
+        del tmp_buf
+
+session: Any = None
+
+class _DB:
+    con: sqlite3.Connection | None = None
+    temp_path: str | None = None
+
+def trace_begin(db_path: str | None = None) -> None:
+    """Initialize database tables."""
+    print("In trace_begin:\n")
+    if not db_path:
+        fd, db_path = tempfile.mkstemp(prefix="perf_events_", suffix=".db")
+        os.close(fd)
+        _DB.temp_path = db_path
+    _DB.con = sqlite3.connect(db_path)
+    con = _DB.con
+    assert con is not None
+
+    # Drop any pre-existing tables so repeated runs do not accumulate duplicate events.
+    con.execute("drop table if exists gen_events;")
+    con.execute("drop table if exists pebs_ll;")
+
+    # Will create several tables at the start, pebs_ll is for PEBS data with
+    # load latency info, while gen_events is for general event.
+    con.execute("""
+        create table if not exists gen_events (
+                name text,
+                symbol text,
+                comm text,
+                dso text
+        );""")
+    con.execute("""
+        create table if not exists pebs_ll (
+                name text,
+                symbol text,
+                comm text,
+                dso text,
+                flags integer,
+                ip integer,
+                status integer,
+                dse integer,
+                dla integer,
+                lat integer
+        );""")
+
+def insert_db(event: Any) -> None:
+    """Insert event into database."""
+    con = _DB.con
+    assert con is not None
+    if event.ev_type == EVTYPE_GENERIC:
+        con.execute("insert into gen_events values(?, ?, ?, ?)",
+                    (event.name, event.symbol, event.comm, event.dso))
+    elif event.ev_type == EVTYPE_PEBS_LL:
+        ip = event.ip - 0x10000000000000000 if event.ip > 0x7fffffffffffffff else event.ip
+        dla = event.dla - 0x10000000000000000 if event.dla > 0x7fffffffffffffff else event.dla
+        con.execute("insert into pebs_ll values (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)",
+                    (event.name, event.symbol, event.comm, event.dso, event.flags,
+                     ip, event.status, event.dse, dla, event.lat))
+
+def process_event(sample: perf.sample_event) -> None:
+    """Callback for processing events."""
+    # Create and insert event object to a database so that user could
+    # do more analysis with simple database commands.
+
+    # Resolve comm, symbol, dso
+    comm = "Unknown_comm"
+    try:
+        if session is not None:
+            proc = session.find_thread(sample.sample_pid, sample.sample_tid)
+            if proc:
+                comm = proc.comm() or "Unknown_comm"
+    except TypeError:
+        pass
+
+    # Symbol and dso info are not always resolved
+    dso = sample.dso if hasattr(sample, 'dso') and sample.dso else "Unknown_dso"
+    symbol = sample.symbol if hasattr(sample, 'symbol') and sample.symbol else "Unknown_symbol"
+    name = str(sample.evsel)
+    if name.startswith("evsel("):
+        name = name[6:-1]
+
+    # Create the event object and insert it to the right table in database
+    try:
+        event = create_event(name, comm, dso, symbol, sample.raw_buf)
+        insert_db(event)
+    except (sqlite3.Error, ValueError, TypeError) as e:
+        print(f"Error creating/inserting event: {e}")
+
+def num2sym(num: int) -> str:
+    """Convert number to a histogram symbol (log2)."""
+    # As the event number may be very big, so we can't use linear way
+    # to show the histogram in real number, but use a log2 algorithm.
+    if num <= 0:
+        return ""
+    snum = '#' * (int(math.log(num, 2)) + 1)
+    return snum
+
+def show_general_events() -> None:
+    """Display statistics for general events."""
+    con = _DB.con
+    assert con is not None
+    count = con.execute("select count(*) from gen_events")
+    for t in count:
+        print(f"There is {t[0]} records in gen_events table")
+        if t[0] == 0:
+            return
+
+    print("Statistics about the general events grouped by thread/symbol/dso: \n")
+
+    # Group by thread
+    commq = con.execute("""
+        select comm, count(comm) from gen_events
+        group by comm order by -count(comm)
+    """)
+    print(f"\n{ 'comm':>16} {'number':>8} {'histogram':>16}\n{'='*42}")
+    for row in commq:
+        print(f"{row[0]:>16} {row[1]:>8}     {num2sym(row[1])}")
+
+    # Group by symbol
+    print(f"\n{'symbol':>32} {'number':>8} {'histogram':>16}\n{'='*58}")
+    symbolq = con.execute("""
+        select symbol, count(symbol) from gen_events
+        group by symbol order by -count(symbol)
+    """)
+    for row in symbolq:
+        print(f"{row[0]:>32} {row[1]:>8}     {num2sym(row[1])}")
+
+    # Group by dso
+    print(f"\n{'dso':>40} {'number':>8} {'histogram':>16}\n{'='*74}")
+    dsoq = con.execute("select dso, count(dso) from gen_events group by dso order by -count(dso)")
+    for row in dsoq:
+        print(f"{row[0]:>40} {row[1]:>8}     {num2sym(row[1])}")
+
+def show_pebs_ll() -> None:
+    """Display statistics for PEBS load latency events."""
+    con = _DB.con
+    assert con is not None
+    # This function just shows the basic info, and we could do more with the
+    # data in the tables, like checking the function parameters when some
+    # big latency events happen.
+    count = con.execute("select count(*) from pebs_ll")
+    for t in count:
+        print(f"There is {t[0]} records in pebs_ll table")
+        if t[0] == 0:
+            return
+
+    print("Statistics about the PEBS Load Latency events grouped by thread/symbol/dse/latency: \n")
+
+    # Group by thread
+    commq = con.execute("select comm, count(comm) from pebs_ll group by comm order by -count(comm)")
+    print(f"\n{'comm':>16} {'number':>8} {'histogram':>16}\n{'='*42}")
+    for row in commq:
+        print(f"{row[0]:>16} {row[1]:>8}     {num2sym(row[1])}")
+
+    # Group by symbol
+    print(f"\n{'symbol':>32} {'number':>8} {'histogram':>16}\n{'='*58}")
+    symbolq = con.execute("""
+        select symbol, count(symbol) from pebs_ll
+        group by symbol order by -count(symbol)
+    """)
+    for row in symbolq:
+        print(f"{row[0]:>32} {row[1]:>8}     {num2sym(row[1])}")
+
+    # Group by dse
+    dseq = con.execute("select dse, count(dse) from pebs_ll group by dse order by -count(dse)")
+    print(f"\n{'dse':>32} {'number':>8} {'histogram':>16}\n{'='*58}")
+    for row in dseq:
+        print(f"{row[0]:>32} {row[1]:>8}     {num2sym(row[1])}")
+
+    # Group by latency
+    latq = con.execute("select lat, count(lat) from pebs_ll group by lat order by lat")
+    print(f"\n{'latency':>32} {'number':>8} {'histogram':>16}\n{'='*58}")
+    for row in latq:
+        print(f"{str(row[0]):>32} {row[1]:>8}     {num2sym(row[1])}")
+
+def trace_end() -> None:
+    """Called at the end of trace processing."""
+    print("In trace_end:\n")
+    try:
+        if _DB.con:
+            _DB.con.commit()
+            show_general_events()
+            show_pebs_ll()
+            _DB.con.close()
+            _DB.con = None
+    finally:
+        if _DB.temp_path and os.path.exists(_DB.temp_path):
+            try:
+                os.remove(_DB.temp_path)
+            except OSError:
+                pass
+            _DB.temp_path = None
+
+if __name__ == "__main__":
+    ap = argparse.ArgumentParser(description="Analyze events with SQLite")
+    ap.add_argument("-i", "--input", default="perf.data", help="Input file name")
+    ap.add_argument("-d", "--db", "--database", dest="database", default=None,
+                    help="Database file name (defaults to a temporary file cleaned up on exit)")
+    args = ap.parse_args()
+
+    try:
+        trace_begin(args.database)
+        session = perf.session(perf.data(args.input), sample=process_event)
+        session.process_events()
+    finally:
+        session = None
+        trace_end()
diff --git a/tools/perf/tests/shell/test_event_analyzing_sample_python.sh b/tools/perf/tests/shell/test_event_analyzing_sample_python.sh
new file mode 100755
index 000000000000..dbd2c20588d4
--- /dev/null
+++ b/tools/perf/tests/shell/test_event_analyzing_sample_python.sh
@@ -0,0 +1,58 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# event_analyzing_sample python test
+
+set -e
+
+shelldir=$(dirname "$0")
+# shellcheck source=lib/setup_python.sh
+. "${shelldir}"/lib/setup_python.sh
+
+# If we don't have the perf python module, we can't test
+if ! "$PYTHON" -c 'import perf' > /dev/null 2>&1; then
+	echo "Skipping test, perf python module not found"
+	exit 2
+fi
+
+script_dir="$(dirname "$0")/../../python"
+script_path="${script_dir}/event_analyzing_sample.py"
+
+if [ ! -f "$script_path" ]; then
+	echo "Skipping test, event_analyzing_sample.py not found at $script_path"
+	exit 2
+fi
+
+err=0
+temp_data=""
+temp_db=""
+
+cleanup() {
+	rm -f "${temp_data}" "${temp_db}"
+}
+
+trap 'cleanup' EXIT TERM INT
+
+temp_data=$(mktemp /tmp/perf.data.XXXXXX)
+temp_db=$(mktemp /tmp/perf.db.XXXXXX)
+
+test_file_mode() {
+	echo "Testing event_analyzing_sample.py..."
+
+	# Generate some events
+	if ! perf record -o "${temp_data}" -- perf test -w noploop >/dev/null 2>&1; then
+		echo "Skipping test, perf record failed"
+		exit 2
+	fi
+
+	# Run the script
+	if ! "$PYTHON" "$script_path" -i "${temp_data}" -d "${temp_db}" >/dev/null; then
+		echo "File mode test failed."
+		err=1
+	else
+		echo "File mode test passed."
+	fi
+}
+
+test_file_mode
+
+exit $err
-- 
2.55.0.1082.g2b9226bbc0-goog

