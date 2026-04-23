Received: from mail-dl1-f73.google.com (mail-dl1-f73.google.com [74.125.82.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61AEA3AE18F
	for <linux-perf-users@vger.kernel.org>; Thu, 23 Apr 2026 16:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776960685; cv=none; b=s8SlcAj+2+eFh5apf9qeCLLNq7AAxl5HRtInb+lbQsmTlLt5ic//hbuzJd3JldtgKhV10tqpHyh+qHD2PPoP+nNE77Y2AFLXQ3fMGHvtQUAQ3QohJ3mmdv/E3qAND9bmdo+ISMgLHH4fQTHuwpLuw1TUFac3aeC719Z+24Rp1PU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776960685; c=relaxed/simple;
	bh=5OrKvJbQ44/J3ddoUAAZT/rdjhaQ+ROgW2tRn9d/A5w=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=aMpQ57yPl6uck/9YSD1fnL8dYhyzYnw/J78XDxCBE4+AcNcYxIwK051M2Uw22W4Y9afQE5XKu/VeyHfvR9KIOhneIX81rk6/yE63Jow55BywFxcJVVGdBPn5Y38VB+THx8rQr0jb42CsoyWwre+omB0Q8yaxZVXfrwnYj2DbbfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dKLNj1zU; arc=none smtp.client-ip=74.125.82.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dKLNj1zU"
Received: by mail-dl1-f73.google.com with SMTP id a92af1059eb24-12c87ba0890so19219600c88.0
        for <linux-perf-users@vger.kernel.org>; Thu, 23 Apr 2026 09:11:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776960681; x=1777565481; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=hrU+KzP+zbk2dCP1XDSlm0MQd8HMtRiKS6fBRNLfd9I=;
        b=dKLNj1zUS+riLAIV29sqkCOzshnGHLXcOERc1zgkY7CpBJiPbTSV4fZMJJiDgFc5sV
         NPOFUoq8nYM8glyRGnsNa8S6+KUqFJ+igUYAuf1Ybr2lCfKkGEZijOdWhDCIxiGKvE8H
         NVRty7qst34CLhinKVtc7teVyYa7O4+LeHbQhR2zcXWE0pZbzaiw7xpDHcM4MP9rjsMI
         XgOdn9L1r7Y/ZAX6QDqRSq5bXb+A471cFUbLNB54qk2pDXqyvkGl24DZVtOn3TZKd3Iv
         jLIHZaP6opHPQv8cgPb8ZOiMdwtI1+e3zyyC4xX3J034zH5zxCdz9OQVgeo84UOrLST1
         WD8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776960681; x=1777565481;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hrU+KzP+zbk2dCP1XDSlm0MQd8HMtRiKS6fBRNLfd9I=;
        b=eLA8nnl136nWS5o32x+3CwjW/j1YvTjHe9cYGNHHTWYjw5+O3eEDIHRDBVwgCEz0iz
         Td7xNL0A6x3nExHdJlk308CuxIgNm+m0QwQQtFEPxhD7SQ9+caiYbr4DBFzbOfUZdaZY
         InmZPzHLdMVraJC2jGswcZcz7UpSXCI2xV+rd1hpNjcer/OQ9/d103OPqj4wJlxb2VvF
         JgYPVnVRAYDatvTjZMCEZzA+q64lsC4j69rcaGsDwdnB87++PEzPu/FK/aRmWUHbNIYP
         eF4dIwza5k2S7jz+IgospBw586XnSpbiJ2GquZtfQkuc20foYpC9T5MSRhsKnM+GDK88
         yuUw==
X-Forwarded-Encrypted: i=1; AFNElJ8hWOFV+exGGFBS2aM+1//2Nx35AGziZITOsCquab+VDdrebxEnDemIPpu0gP7soaJawsQbuem4hpMtA+/OhLtd@vger.kernel.org
X-Gm-Message-State: AOJu0Yzo2dC2b+TKoGh2ea4beNs1IA+vxkmLYGxJzH0ukJyYYUjNA0/R
	ZMXSirk0mSHZx5V0uPEkbk1Lqb2LXfOeFNyji87fjk1jq/jkmvjvWKfnHkpIxgyJKrPkY9p3cF5
	xTgCvDM3R1w==
X-Received: from dlae3.prod.google.com ([2002:a05:701b:2303:b0:12d:bcd0:59a4])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:23a5:b0:128:d752:e076
 with SMTP id a92af1059eb24-12c73f6c3dcmr16596172c88.3.1776960680905; Thu, 23
 Apr 2026 09:11:20 -0700 (PDT)
Date: Thu, 23 Apr 2026 09:09:41 -0700
In-Reply-To: <20260423161006.1762700-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260423035526.1537178-1-irogers@google.com> <20260423161006.1762700-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.rc2.533.g4f5dca5207-goog
Message-ID: <20260423161006.1762700-35-irogers@google.com>
Subject: [PATCH v3 34/58] perf event_analyzing_sample: Port
 event_analyzing_sample to use python module
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, adrian.hunter@intel.com, 
	james.clark@linaro.org, leo.yan@linux.dev, namhyung@kernel.org, 
	tmricht@linux.ibm.com
Cc: 9erthalion6@gmail.com, adityab1@linux.ibm.com, 
	alexandre.chartre@oracle.com, alice.mei.rogers@gmail.com, 
	ankur.a.arora@oracle.com, ashelat@redhat.com, atrajeev@linux.ibm.com, 
	blakejones@google.com, changbin.du@huawei.com, chuck.lever@oracle.com, 
	collin.funk1@gmail.com, coresight@lists.linaro.org, ctshao@google.com, 
	dapeng1.mi@linux.intel.com, derek.foreman@collabora.com, dsterba@suse.com, 
	gautam@linux.ibm.com, howardchu95@gmail.com, john.g.garry@oracle.com, 
	jolsa@kernel.org, jonathan.cameron@huawei.com, justinstitt@google.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, mike.leach@arm.com, mingo@redhat.com, 
	morbo@google.com, nathan@kernel.org, nichen@iscas.ac.cn, 
	nick.desaulniers+lkml@gmail.com, pan.deng@intel.com, peterz@infradead.org, 
	ravi.bangoria@amd.com, ricky.ringler@proton.me, stephen.s.brennan@oracle.com, 
	sun.jian.kdev@gmail.com, suzuki.poulose@arm.com, swapnil.sapkal@amd.com, 
	tanze@kylinos.cn, terrelln@fb.com, thomas.falcon@intel.com, 
	tianyou.li@intel.com, tycho@kernel.org, wangyang.guo@intel.com, 
	xiaqinxin@huawei.com, yang.lee@linux.alibaba.com, yuzhuo@google.com, 
	zhiguo.zhou@intel.com, zli94@ncsu.edu
Content-Type: text/plain; charset="UTF-8"

Add a port of the event_analyzing_sample script that uses the perf
python module directly. This approach is significantly faster than
using perf script callbacks as it avoids creating intermediate
dictionaries for all event fields.

Assisted-by: Gemini:gemini-3.1-pro-preview
Signed-off-by: Ian Rogers <irogers@google.com>
---
v2:

1. Dynamic Database Path: Moved DB_PATH to a command-line argument (
  -d / --database ) that defaults to "perf.db" .

2. Security: Avoided using /dev/shm by default to prevent symlink
   attacks, while retaining the performance suggestion in the help
   text.

3. Corrected Closure Call: Fixed the bug where it was trying to call
   .filter() on a closure.
---
 tools/perf/python/event_analyzing_sample.py | 296 ++++++++++++++++++++
 1 file changed, 296 insertions(+)
 create mode 100755 tools/perf/python/event_analyzing_sample.py

diff --git a/tools/perf/python/event_analyzing_sample.py b/tools/perf/python/event_analyzing_sample.py
new file mode 100755
index 000000000000..7507917e16be
--- /dev/null
+++ b/tools/perf/python/event_analyzing_sample.py
@@ -0,0 +1,296 @@
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
+
+import argparse
+import math
+import sqlite3
+import struct
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
+        flags, ip, ax, bx, cx, dx, si, di, bp, sp = struct.unpack('QQQQQQQQQQ', tmp_buf)
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
+        status, dla, dse, lat = struct.unpack('QQQQ', tmp_buf)
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
+con = None
+
+def trace_begin(db_path: str) -> None:
+    """Initialize database tables."""
+    print("In trace_begin:\n")
+    global con
+    con = sqlite3.connect(db_path)
+    con.isolation_level = None
+    assert con is not None
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
+    assert con is not None
+    if event.ev_type == EVTYPE_GENERIC:
+        con.execute("insert into gen_events values(?, ?, ?, ?)",
+                    (event.name, event.symbol, event.comm, event.dso))
+    elif event.ev_type == EVTYPE_PEBS_LL:
+        event.ip &= 0x7fffffffffffffff
+        event.dla &= 0x7fffffffffffffff
+        con.execute("insert into pebs_ll values (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)",
+                    (event.name, event.symbol, event.comm, event.dso, event.flags,
+                     event.ip, event.status, event.dse, event.dla, event.lat))
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
+            # FIXME: session.process() only takes one argument and uses it as both
+            # PID and TID in C. This means it only resolves main threads correctly.
+            # Sub-threads will get the main thread's comm.
+            proc = session.process(sample.sample_pid)
+            if proc:
+                comm = proc.comm()
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
+    show_general_events()
+    show_pebs_ll()
+    if con:
+        con.close()
+
+if __name__ == "__main__":
+    ap = argparse.ArgumentParser(description="Analyze events with SQLite")
+    ap.add_argument("-i", "--input", default="perf.data", help="Input file name")
+    ap.add_argument("-d", "--database", default="perf.db",
+                    help="Database file name (tip: use /dev/shm/perf.db for speedup)")
+    args = ap.parse_args()
+
+    trace_begin(args.database)
+    session = perf.session(perf.data(args.input), sample=process_event)
+    session.process_events()
+    trace_end()
-- 
2.54.0.rc2.533.g4f5dca5207-goog

