Received: from mail-dy1-f201.google.com (mail-dy1-f201.google.com [74.125.82.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EAB63603EB
	for <linux-perf-users@vger.kernel.org>; Fri, 24 Apr 2026 16:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777049342; cv=none; b=W2V9UQxo7oW4RcWstnJFgMGQRl2X1fSEq0352rJ4R1OnpYoajIwo0ovex8TLzwCJtyYHjCEIiVa4KiG5w4q5IpGlTGX/Ros23XqCpOrC6Q7aoV7JaC0E6aZpxtlYqg7uY8B7Cqy/T/y4GveJZsoDAShUUi5N+GWHN7H1TNnmSDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777049342; c=relaxed/simple;
	bh=haC9/TgZr5TSvcFgXuq686t3BFR9rpE/yVZ7gB/vqxE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Cqnc5nn8I47pMk5hyZAkkx2yNIYtS4pf/DQGJKdW7Pkf/TDHURmok/kwclTQnLrieE17EC6V24GteGKwV5RbEqDvCtqRHicFgGGSZwGsxX3PGkajgZ7qeYQri6qwbw+pcm7o8MBw3ms6c42x+RrbQNuKM3yYO+HaA9+S6JBm3z0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ng0smDNz; arc=none smtp.client-ip=74.125.82.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ng0smDNz"
Received: by mail-dy1-f201.google.com with SMTP id 5a478bee46e88-2d8c521be48so5716489eec.1
        for <linux-perf-users@vger.kernel.org>; Fri, 24 Apr 2026 09:49:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777049339; x=1777654139; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=85L8zXgH/1o7tR+GKFed6reKI1nU3A4j2IUu1iMN6N0=;
        b=Ng0smDNzqkEF+TZreGB9kN4QpBtW+DI/o/bNzsSG2VemQP/Ienlo7Nh7/Fqqddt+m/
         WjvmF4ACrK7FUyxh9RW2V2xH1Tk7fvZK6m2WmtDOON7mI2s6bh/BFo0Li2RkWGaANGoc
         MS0Yb3eyhETkSExyzzk6nxBcQWph7bREdlX0YdQjCbfPgvqGRcb1i+S/uyN4eUwPYU7L
         e3qp2PhCqXBPEpO+MItoxzJY9sh2qqoHvzBLzc+TcfsBjWJk8rt5MY3KJ+AeeFIyJAlp
         Q8ljzBeS6soU+6bc26P0xiaI0bajU8FzXmqe+Gi9bASppumXyyUkvDv2J2MnxykrE9pj
         CMzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777049339; x=1777654139;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=85L8zXgH/1o7tR+GKFed6reKI1nU3A4j2IUu1iMN6N0=;
        b=DW7GMLHYiiThlfIlXstr2bwf6oKlcC3YmG3MyTEt9TeDbKfqpRWVKIZ1tlOW3wUT3p
         xp4dLycFy+NOOw550ivjxnsEN6uPrP45ObTNUYob1r8+Yo/RtZ1Vd99x7BXIXPTz3kyQ
         NGvvhR1A4OedtwtGUkQ/Yg7XddttitJe2VhujdVZC8s3zcxw653R2+tnE33PNSWRX6pJ
         bc/Bp/jXISHYcRYjO05ThC8MRVShuD/UYwbzXUG7ROvxW7VQf3UUEgVrVp12witA1WbG
         y9Felul+YOQkuKp/Y2XOM3BKjtpcvxB4wValt/zbi3rYaJz/kt1UTj8V5/N2TpwpKKaX
         +6ng==
X-Forwarded-Encrypted: i=1; AFNElJ+oRKVg6Uvx1bu37zEXPA4em7GrswYIY+uQqdSVzQwwwfQfwD58C7LPUWlsnB0QN7vzbJQqhCe2cWwOVy/KETRx@vger.kernel.org
X-Gm-Message-State: AOJu0YxwU823eEKU+ZaXEfWEIRaP6XX38vW/hINg75CBYUgYDV3EacuK
	GN6pjqcPCa9/lUN4phjGXLnRK1MK2/DMqL4zMLyxJTWHaV4EHnjg50DviIoYYUsDv1gASbsIpzr
	T0KK8102eiQ==
X-Received: from dycui24.prod.google.com ([2002:a05:693c:6018:b0:2de:e63d:7daa])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:5711:b0:2c5:c532:1fe1
 with SMTP id 5a478bee46e88-2e42c15ceacmr15335710eec.3.1777049339037; Fri, 24
 Apr 2026 09:48:59 -0700 (PDT)
Date: Fri, 24 Apr 2026 09:46:57 -0700
In-Reply-To: <20260424164721.2229025-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260423163406.1779809-1-irogers@google.com> <20260424164721.2229025-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260424164721.2229025-36-irogers@google.com>
Subject: [PATCH v5 35/58] perf event_analyzing_sample: Port
 event_analyzing_sample to use python module
From: Ian Rogers <irogers@google.com>
To: acme@kernel.org, adrian.hunter@intel.com, james.clark@linaro.org, 
	leo.yan@linux.dev, namhyung@kernel.org, tmricht@linux.ibm.com
Cc: alice.mei.rogers@gmail.com, dapeng1.mi@linux.intel.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, mingo@redhat.com, peterz@infradead.org, 
	Ian Rogers <irogers@google.com>
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
2.54.0.545.g6539524ca2-goog

