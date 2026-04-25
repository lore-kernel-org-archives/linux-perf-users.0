Received: from mail-dy1-f201.google.com (mail-dy1-f201.google.com [74.125.82.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EDB937474F
	for <linux-perf-users@vger.kernel.org>; Sat, 25 Apr 2026 17:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777139416; cv=none; b=HPlmlPNOv3KUdMdJSNIxwP03HGZ1BsJO6hjKAwyVJPNeerbi5X8Cd+hLRUTDncqdatpJu6FAowEvesHjH7wbl35kz+RwoGlq5xzDrD77PqliWVdJKS2FfrgdB8OxCVUylRI1E30TWTX07la4sliXnzFOvlylXmgp2gXaSik/M+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777139416; c=relaxed/simple;
	bh=Kxda9I+GvLoC1sIZ48qz+oZCWo4LY6Bc6jAdB7bnXUY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=K5Wy6TfFyfZAKYnv0b67oOn/EKI4BzIkCsVuzhelEI65SNn0Nro9qutDWVX4dDim0YiGoUVkq+CKJ1xnZ/mKshSCHC62SN+Rk9r6k2xkgGuj++OGgn3ySG1Bhg6vPOGD0WKpQfDkEpHleFHrhStlaCNdiFEc55PLbML2gMBJUh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VxGxGr1V; arc=none smtp.client-ip=74.125.82.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VxGxGr1V"
Received: by mail-dy1-f201.google.com with SMTP id 5a478bee46e88-2ba8013a9e3so10250296eec.0
        for <linux-perf-users@vger.kernel.org>; Sat, 25 Apr 2026 10:50:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777139413; x=1777744213; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=N4Nf17+iE4TpFXICTEQCjer2ymy7/ZPQXwIyAydjrk8=;
        b=VxGxGr1VUVt/v8KF2Jw8lLXqMKmKYNsjO6oHRLgb6Mj+cF2jlmZSLqrfdgMDTphPjc
         l2BK+hHK9e5Saoj6TiOntDBMeRRr0Q1oocIWC70wChcoS7Hg1lE3CP0SBJDKPywcBU+k
         blE5BXfpj7QQdf7DCywwxoBr52/lWESKHxvrrZYqZSbPxlGLBmuTGrc51t1bJbvAhYSJ
         DEzDmAD1tfMhb35774ITKwwXaE2kp0UGzjkXcs0IdPHxmIA5OrG5mYYP1XTsw0eSf2zy
         NpGv5GfenA6OmpCf3KqsOzizdEc6zK+CzCzXo/9X5MAGhSTzm4jxD+YgSkzsfZE919N1
         /+4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777139413; x=1777744213;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=N4Nf17+iE4TpFXICTEQCjer2ymy7/ZPQXwIyAydjrk8=;
        b=g7hclPG9bFUcqqmcIpo3w1kUmT6Po15jeW6hUP2Ttw98+I5kI43wS+nKbjsSzqUivD
         yd7Senj/Qxe/XOOTYanNteFgw9r8sSEzwnBRsiPOHY4URHB0FaA254qMw2dG3NOi7JQr
         dDquw6aCy3DafCz6bkPKrbkH7feZgOJvwG/6kBP8B7DnAKZLMwzEAkLm06Y3Zt8u281B
         0q+Z15674BmyQQL0+lci2+8x7GnRlmtzvOM0oDMLRx79A1g+WQPqIgEZQlpf9m+LYMOW
         K369Akdq3IrqMliZ50v1I+sN00g+4dXWDpYayjuXLmXS3x2wFKEQhAMuPx0Ir9G62WPC
         4naw==
X-Forwarded-Encrypted: i=1; AFNElJ+2LWPHy+ADzwKdpxl5655sLF3+h0d77VGIAdJlA1kAvQqVAXUcHN6hL2hEp7mvxuJbpLMRLpALz7UF/3KTdkyb@vger.kernel.org
X-Gm-Message-State: AOJu0Ywf4FMcBGJxn/9wwt3mKIDj14DZyXdiBYWAo20VwUDgAnhGKSOY
	hdfK3dZnbPzYaIqykDxOqzmZS76qDjD9Zyuy2GKGohMOIdRmawPT40xfBp+mgJX6G+bN4Wljone
	Ba9hVCQbUzQ==
X-Received: from dybaz36.prod.google.com ([2002:a05:7300:6c24:b0:2da:2525:9f3])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7301:1693:b0:2d4:7656:4ec1
 with SMTP id 5a478bee46e88-2e47873a687mr20477594eec.17.1777139413032; Sat, 25
 Apr 2026 10:50:13 -0700 (PDT)
Date: Sat, 25 Apr 2026 10:48:34 -0700
In-Reply-To: <20260425174858.3922152-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260424164721.2229025-1-irogers@google.com> <20260425174858.3922152-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260425174858.3922152-37-irogers@google.com>
Subject: [PATCH v6 36/59] perf export-to-sqlite: Port export-to-sqlite to use
 python module
From: Ian Rogers <irogers@google.com>
To: acme@kernel.org, adrian.hunter@intel.com, james.clark@linaro.org, 
	leo.yan@linux.dev, namhyung@kernel.org, tmricht@linux.ibm.com
Cc: alice.mei.rogers@gmail.com, dapeng1.mi@linux.intel.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, mingo@redhat.com, peterz@infradead.org, 
	Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"

This commit ports the export-to-sqlite.py script to use the modern perf
Python module and the standard library sqlite3 module. It drops the
dependency on PySide2.QtSql.

Assisted-by: Gemini:gemini-3.1-pro-preview
Signed-off-by: Ian Rogers <irogers@google.com>
---
v5:
1. Fix Callchain Resolution: Corrected attribute lookups on callchain
   nodes. The `dso` and `symbol` properties already return strings, so
   attempting to get a `.name` attribute from them failed and caused
   fallback to "Unknown_...".
---
 tools/perf/python/export-to-sqlite.py | 372 ++++++++++++++++++++++++++
 1 file changed, 372 insertions(+)
 create mode 100755 tools/perf/python/export-to-sqlite.py

diff --git a/tools/perf/python/export-to-sqlite.py b/tools/perf/python/export-to-sqlite.py
new file mode 100755
index 000000000000..736b56ff8d59
--- /dev/null
+++ b/tools/perf/python/export-to-sqlite.py
@@ -0,0 +1,372 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: GPL-2.0
+"""
+Export perf data to a sqlite3 database.
+
+This script has been ported to use the modern perf Python module and the
+standard library sqlite3 module. It no longer requires PySide2 or QtSql
+for exporting.
+
+Examples of using this script with Intel PT:
+
+	$ perf record -e intel_pt//u ls
+	$ python tools/perf/python/export-to-sqlite.py -i perf.data -o pt_example
+
+To browse the database, sqlite3 can be used e.g.
+
+	$ sqlite3 pt_example
+	sqlite> .header on
+	sqlite> select * from samples_view where id < 10;
+	sqlite> .mode column
+	sqlite> select * from samples_view where id < 10;
+	sqlite> .tables
+	sqlite> .schema samples_view
+	sqlite> .quit
+
+An example of using the database is provided by the script
+exported-sql-viewer.py. Refer to that script for details.
+
+Ported from tools/perf/scripts/python/export-to-sqlite.py
+"""
+
+import argparse
+import os
+import sqlite3
+import sys
+from typing import Dict, Optional
+import perf
+
+
+class DatabaseExporter:
+    """Handles database connection and exporting of perf events."""
+
+    def __init__(self, db_path: str):
+        self.con = sqlite3.connect(db_path)
+        self.session: Optional[perf.session] = None
+        self.sample_count = 0
+
+        # Caches and counters grouped to reduce instance attributes
+        self.caches: Dict[str, dict] = {
+            'threads': {},
+            'comms': {},
+            'dsos': {},
+            'symbols': {},
+            'events': {},
+            'branch_types': {},
+            'call_paths': {}
+        }
+
+        self.next_id = {
+            'thread': 1,
+            'comm': 1,
+            'dso': 1,
+            'symbol': 1,
+            'event': 1,
+            'branch_type': 1,
+            'call_path': 1
+        }
+
+        self.create_tables()
+
+    def create_tables(self) -> None:
+        """Create database tables."""
+        self.con.execute("""
+            CREATE TABLE IF NOT EXISTS selected_events (
+                    id      INTEGER         NOT NULL        PRIMARY KEY,
+                    name    VARCHAR(80))
+        """)
+        self.con.execute("""
+            CREATE TABLE IF NOT EXISTS machines (
+                    id      INTEGER         NOT NULL        PRIMARY KEY,
+                    pid     INTEGER,
+                    root_dir VARCHAR(4096))
+        """)
+        self.con.execute("""
+            CREATE TABLE IF NOT EXISTS threads (
+                    id      INTEGER         NOT NULL        PRIMARY KEY,
+                    machine_id BIGINT,
+                    process_id BIGINT,
+                    pid     INTEGER,
+                    tid     INTEGER)
+        """)
+        self.con.execute("""
+            CREATE TABLE IF NOT EXISTS comms (
+                    id      INTEGER         NOT NULL        PRIMARY KEY,
+                    comm    VARCHAR(16),
+                    c_thread_id BIGINT,
+                    c_time  BIGINT,
+                    exec_flag BOOLEAN)
+        """)
+        self.con.execute("""
+            CREATE TABLE IF NOT EXISTS comm_threads (
+                    id      INTEGER         NOT NULL        PRIMARY KEY,
+                    comm_id BIGINT,
+                    thread_id BIGINT)
+        """)
+        self.con.execute("""
+            CREATE TABLE IF NOT EXISTS dsos (
+                    id      INTEGER         NOT NULL        PRIMARY KEY,
+                    machine_id BIGINT,
+                    short_name VARCHAR(256),
+                    long_name VARCHAR(4096),
+                    build_id VARCHAR(64))
+        """)
+        self.con.execute("""
+            CREATE TABLE IF NOT EXISTS symbols (
+                    id      INTEGER         NOT NULL        PRIMARY KEY,
+                    dso_id  BIGINT,
+                    sym_start BIGINT,
+                    sym_end BIGINT,
+                    binding INTEGER,
+                    name    VARCHAR(2048))
+        """)
+        self.con.execute("""
+            CREATE TABLE IF NOT EXISTS branch_types (
+                    id      INTEGER         NOT NULL        PRIMARY KEY,
+                    name    VARCHAR(80))
+        """)
+        self.con.execute("""
+            CREATE TABLE IF NOT EXISTS samples (
+                    id              INTEGER         NOT NULL        PRIMARY KEY,
+                    evsel_id        BIGINT,
+                    machine_id      BIGINT,
+                    thread_id       BIGINT,
+                    comm_id         BIGINT,
+                    dso_id          BIGINT,
+                    symbol_id       BIGINT,
+                    sym_offset      BIGINT,
+                    ip              BIGINT,
+                    time            BIGINT,
+                    cpu             INTEGER,
+                    to_dso_id       BIGINT,
+                    to_symbol_id    BIGINT,
+                    to_sym_offset   BIGINT,
+                    to_ip           BIGINT,
+                    period          BIGINT,
+                    weight          BIGINT,
+                    transaction_    BIGINT,
+                    data_src        BIGINT,
+                    branch_type     INTEGER,
+                    in_tx           BOOLEAN,
+                    call_path_id    BIGINT,
+                    insn_count      BIGINT,
+                    cyc_count       BIGINT,
+                    flags           INTEGER)
+        """)
+        self.con.execute("""
+            CREATE TABLE IF NOT EXISTS call_paths (
+                    id              INTEGER         NOT NULL        PRIMARY KEY,
+                    parent_id       BIGINT,
+                    symbol_id       BIGINT,
+                    ip              BIGINT)
+        """)
+        self.con.execute("""
+            CREATE VIEW IF NOT EXISTS samples_view AS
+            SELECT s.id, e.name as event, t.pid, t.tid, c.comm,
+                   d.short_name as dso, sym.name as symbol, s.sym_offset,
+                   s.ip, s.time, s.cpu
+            FROM samples s
+            JOIN selected_events e ON s.evsel_id = e.id
+            JOIN threads t ON s.thread_id = t.id
+            JOIN comms c ON s.comm_id = c.id
+            JOIN dsos d ON s.dso_id = d.id
+            JOIN symbols sym ON s.symbol_id = sym.id;
+        """)
+
+        # id == 0 means unknown. It is easier to create records for them than
+        # replace the zeroes with NULLs
+        self.con.execute("INSERT OR IGNORE INTO selected_events VALUES (0, 'unknown')")
+        self.con.execute("INSERT OR IGNORE INTO machines VALUES (0, 0, 'unknown')")
+        self.con.execute("INSERT OR IGNORE INTO threads VALUES (0, 0, 0, -1, -1)")
+        self.con.execute("INSERT OR IGNORE INTO comms VALUES (0, 'unknown', 0, 0, 0)")
+        self.con.execute("INSERT OR IGNORE INTO dsos VALUES (0, 0, 'unknown', 'unknown', '')")
+        self.con.execute("INSERT OR IGNORE INTO symbols VALUES (0, 0, 0, 0, 0, 'unknown')")
+
+    def get_event_id(self, name: str) -> int:
+        """Get or create event ID."""
+        if name in self.caches['events']:
+            return self.caches['events'][name]
+        event_id = self.next_id['event']
+        self.con.execute("INSERT INTO selected_events VALUES (?, ?)",
+                         (event_id, name))
+        self.caches['events'][name] = event_id
+        self.next_id['event'] += 1
+        return event_id
+
+    def get_thread_id(self, pid: int, tid: int) -> int:
+        """Get or create thread ID."""
+        key = (pid, tid)
+        if key in self.caches['threads']:
+            return self.caches['threads'][key]
+        thread_id = self.next_id['thread']
+        self.con.execute("INSERT INTO threads VALUES (?, ?, ?, ?, ?)",
+                         (thread_id, 0, pid, pid, tid))
+        self.caches['threads'][key] = thread_id
+        self.next_id['thread'] += 1
+        return thread_id
+
+    def get_comm_id(self, comm: str, thread_id: int) -> int:
+        """Get or create comm ID."""
+        if comm in self.caches['comms']:
+            return self.caches['comms'][comm]
+        comm_id = self.next_id['comm']
+        self.con.execute("INSERT INTO comms VALUES (?, ?, ?, ?, ?)",
+                         (comm_id, comm, thread_id, 0, 0))
+        self.con.execute("INSERT INTO comm_threads VALUES (?, ?, ?)",
+                         (comm_id, comm_id, thread_id))
+        self.caches['comms'][comm] = comm_id
+        self.next_id['comm'] += 1
+        return comm_id
+
+    def get_dso_id(self, short_name: str, long_name: str,
+                   build_id: str) -> int:
+        """Get or create DSO ID."""
+        if short_name in self.caches['dsos']:
+            return self.caches['dsos'][short_name]
+        dso_id = self.next_id['dso']
+        self.con.execute("INSERT INTO dsos VALUES (?, ?, ?, ?, ?)",
+                         (dso_id, 0, short_name, long_name, build_id))
+        self.caches['dsos'][short_name] = dso_id
+        self.next_id['dso'] += 1
+        return dso_id
+
+    def get_symbol_id(self, dso_id: int, name: str, start: int,
+                      end: int) -> int:
+        """Get or create symbol ID."""
+        key = (dso_id, name)
+        if key in self.caches['symbols']:
+            return self.caches['symbols'][key]
+        symbol_id = self.next_id['symbol']
+        self.con.execute("INSERT INTO symbols VALUES (?, ?, ?, ?, ?, ?)",
+                         (symbol_id, dso_id, start, end, 0, name))
+        self.caches['symbols'][key] = symbol_id
+        self.next_id['symbol'] += 1
+        return symbol_id
+
+    def get_call_path_id(self, parent_id: int, symbol_id: int,
+                         ip: int) -> int:
+        """Get or create call path ID."""
+        key = (parent_id, symbol_id, ip)
+        if key in self.caches['call_paths']:
+            return self.caches['call_paths'][key]
+        call_path_id = self.next_id['call_path']
+        self.con.execute("INSERT INTO call_paths VALUES (?, ?, ?, ?)",
+                         (call_path_id, parent_id, symbol_id, ip))
+        self.caches['call_paths'][key] = call_path_id
+        self.next_id['call_path'] += 1
+        return call_path_id
+
+    def process_event(self, sample: perf.sample_event) -> None:
+        """Callback for processing events."""
+        thread_id = self.get_thread_id(sample.sample_pid, sample.sample_tid)
+
+        comm = "Unknown_comm"
+        try:
+            if self.session is not None:
+                proc = self.session.find_thread(sample.sample_pid)
+                if proc:
+                    comm = proc.comm()
+        except TypeError:
+            pass
+        comm_id = self.get_comm_id(comm, thread_id)
+
+        dso_id = self.get_dso_id(
+            getattr(sample, 'dso', "Unknown_dso") or "Unknown_dso",
+            getattr(sample, 'dso_long_name', "Unknown_dso_long") or "Unknown_dso_long",
+            getattr(sample, 'dso_bid', "") or ""
+        )
+
+        symbol_id = self.get_symbol_id(
+            dso_id,
+            getattr(sample, 'symbol', "Unknown_symbol") or "Unknown_symbol",
+            getattr(sample, 'sym_start', 0) or 0,
+            getattr(sample, 'sym_end', 0) or 0
+        )
+
+        # Handle callchain
+        call_path_id = 0
+        if hasattr(sample, 'callchain') and sample.callchain:
+            parent_id = 0
+            for node in sample.callchain:
+                dso_name = getattr(node, 'dso', "Unknown_dso") or "Unknown_dso"
+                symbol_name = getattr(node, 'symbol', "Unknown_symbol") or "Unknown_symbol"
+
+                node_dso_id = self.get_dso_id(dso_name, dso_name, "")
+                node_symbol_id = self.get_symbol_id(node_dso_id, symbol_name, 0, 0)
+
+                parent_id = self.get_call_path_id(parent_id, node_symbol_id, node.ip)
+            call_path_id = parent_id
+        else:
+            call_path_id = 0
+
+        # Insert sample
+        self.con.execute("""
+            INSERT INTO samples VALUES (
+                NULL, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?
+            )
+        """, (
+            self.get_event_id(getattr(sample.evsel, 'name', str(sample.evsel))),
+            0, thread_id, comm_id,
+            dso_id, symbol_id, getattr(sample, 'sym_offset', 0),
+            sample.sample_ip, sample.sample_time, sample.sample_cpu,
+            0, 0, 0, 0,  # to_dso, to_symbol, to_sym_offset, to_ip
+            getattr(sample, 'sample_period', 0) or 0,
+            getattr(sample, 'sample_weight', 0) or 0,
+            getattr(sample, 'transaction_', 0),
+            getattr(sample, 'data_src', 0),
+            0,  # branch_type
+            getattr(sample, 'in_tx', 0),
+            call_path_id,
+            getattr(sample, 'insn_count', 0),
+            getattr(sample, 'cyc_count', 0),
+            getattr(sample, 'flags', 0)
+        ))
+
+        self.sample_count += 1
+        if self.sample_count % 10000 == 0:
+            self.commit()
+
+    def commit(self) -> None:
+        """Commit transaction."""
+        self.con.commit()
+
+    def close(self) -> None:
+        """Close connection."""
+        self.con.close()
+
+
+if __name__ == "__main__":
+    ap = argparse.ArgumentParser(
+        description="Export perf data to a sqlite3 database")
+    ap.add_argument("-i", "--input", default="perf.data",
+                    help="Input file name")
+    ap.add_argument("-o", "--output", default="perf.db",
+                    help="Output database name")
+    args = ap.parse_args()
+
+    try:
+        fd = os.open(args.output, os.O_CREAT | os.O_EXCL | os.O_WRONLY)
+        os.close(fd)
+    except FileExistsError:
+        print(f"Error: {args.output} already exists")
+        sys.exit(1)
+
+    exporter = DatabaseExporter(args.output)
+
+    session = None
+    error_occurred = False
+    try:
+        session = perf.session(perf.data(args.input),
+                               sample=exporter.process_event)
+        exporter.session = session
+        session.process_events()
+        exporter.commit()
+        print(f"Successfully exported to {args.output}")
+    except Exception as e:
+        print(f"Error processing events: {e}")
+        error_occurred = True
+    finally:
+        exporter.close()
+        if error_occurred:
+            if os.path.exists(args.output):
+                os.remove(args.output)
-- 
2.54.0.545.g6539524ca2-goog

