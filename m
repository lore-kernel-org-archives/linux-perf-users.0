Received: from mail-dl1-f73.google.com (mail-dl1-f73.google.com [74.125.82.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 446BF28688C
	for <linux-perf-users@vger.kernel.org>; Mon, 20 Apr 2026 00:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776643247; cv=none; b=pgTM7ykGzY8Keb2+A5bPLtr4UbVrijpSDsg2GqcjImwHs+hA7kN8V+W8cBVVhr33yx7Ivs38o/22ZRzeTs47jc551RuFGmcyGRomXDiJ4J8Ba3isqf8n2JEMuZZPGNlD3XQVHlbeb2L2nLbdbqw0gY4mn5sUHu2u0DcMIPjaGSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776643247; c=relaxed/simple;
	bh=UYRXPeuxrrrO2IR8CjxYz3I4Zm3xaJwuRy69J5GfSMk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=c8YPUBA/xxixOG4duJrrI7MIeoUinioAco17M8wynlzpxx2DpYza20qRZ5BvxiBDgjat1QO3xMHiXv44XMKR/C2825FcgE4Ws7b9IkSo0eNq2G7CjVaa3dVBOT2WP6OztawxzmFFkl/VfT4Bb1B/R9PVLCVDi7fee+GV/P0LxnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uvuHJBuv; arc=none smtp.client-ip=74.125.82.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uvuHJBuv"
Received: by mail-dl1-f73.google.com with SMTP id a92af1059eb24-1275c6fc58aso3247336c88.0
        for <linux-perf-users@vger.kernel.org>; Sun, 19 Apr 2026 17:00:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776643244; x=1777248044; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ptb3wnXhbBctK85UL+hEKiSgykiYNJbIGJmwLZm5X9Q=;
        b=uvuHJBuv5tt11Z0kcSoTcMSqfXNBtBl8H11knftuH2DM7pjTpoyU6tWZiO8feBgq2n
         1hn/9HQJm0xp3hvl2Vpv4aaWPi29zZIE7HjNcpwbmc58KAA5+2PMsUnPphbaVcAg6wIV
         x+r4+71JaiBk+7O5ZRFkKoUfLJqkFqoE8pVjeCZflH93mEwr5FfDhr1vPJc8ixb8DIDr
         WAnjDdLGVzdxN+Nv+0ieQOZXO36Vkzs82adD5Uhe6+hmNSPzIb/40NEr+rXHKeN0lfQK
         7VS2FVVfmkC202+ykV4v3aulE9xlxpHam2MNIT5OCiad/sLaVP2y1/x4M0KUu3DXtdqe
         yYow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776643244; x=1777248044;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ptb3wnXhbBctK85UL+hEKiSgykiYNJbIGJmwLZm5X9Q=;
        b=CrvfSZh5iwMuwpgORYTov/jvKMUmPD93RfvYrCBzEZwSs7LICH17jX7v8wN2jR/nVB
         hXAq2y7JRnD5V7ryWnedBCLtDN7BJZfpvwzeJs9Ei3FG5tn7AqZa02JXSSIo5GgpGiLI
         yNCL+IBQQgvLhZB7h5CVAeNb9ViBIGpUkWpXzRnrSXedm7FwCzoXc2nFxmqOdrPLM1Bh
         jtapJc72xU5aMilQV1ZwRa1TOHQp5nb9lCruTKtgKVwQd9hI2KUBRpoWwaWMGSpcEvSg
         U2JsaGAwpGvKi82CW4vYPwsbtp4wOK/ZdLqpPuB/SFBmX5sE7dO40V5N38PQbsr1AgGa
         XOAg==
X-Forwarded-Encrypted: i=1; AFNElJ+Yt/yomCPF1p8q7ZA7V3l3M8w7lSg7VzmhOLh+pOpZRUrud9UbF1qPrLwQWV4g2i0EP5EYI0KGw2J3wnfbRCir@vger.kernel.org
X-Gm-Message-State: AOJu0YyeHgbWcMF0ZPCx/zOtyN3go0qOtuG40XWVzON1qq6x+dDVkESU
	ffHGcRVSPETjsbvt/qmDQ0VCnpWS5lGxIrdU9X2lxHZxJu3eyBOrUgTFASGNLRzsZjhyzUtIQ3x
	NRx5ngXR8KQ==
X-Received: from dlbrh21.prod.google.com ([2002:a05:7022:f315:b0:12b:e024:e554])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:628c:b0:12a:8ea4:252
 with SMTP id a92af1059eb24-12c73f6d5ffmr5610791c88.4.1776643243831; Sun, 19
 Apr 2026 17:00:43 -0700 (PDT)
Date: Sun, 19 Apr 2026 16:58:48 -0700
In-Reply-To: <20260419235911.2186050-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260419235911.2186050-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.rc1.513.gad8abe7a5a-goog
Message-ID: <20260419235911.2186050-37-irogers@google.com>
Subject: [PATCH v1 36/58] perf export-to-sqlite: Port export-to-sqlite to use
 python module
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	Alice Rogers <alice.mei.rogers@gmail.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
	Mike Leach <mike.leach@arm.com>, John Garry <john.g.garry@oracle.com>, 
	Leo Yan <leo.yan@linux.dev>, Yicong Yang <yangyicong@hisilicon.com>, 
	Jonathan Cameron <jonathan.cameron@huawei.com>, Nick Terrell <terrelln@fb.com>, 
	David Sterba <dsterba@suse.com>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, Alexandre Chartre <alexandre.chartre@oracle.com>, 
	Dmitrii Dolgov <9erthalion6@gmail.com>, Yuzhuo Jing <yuzhuo@google.com>, 
	Blake Jones <blakejones@google.com>, Changbin Du <changbin.du@huawei.com>, 
	Gautam Menghani <gautam@linux.ibm.com>, Wangyang Guo <wangyang.guo@intel.com>, 
	Pan Deng <pan.deng@intel.com>, Zhiguo Zhou <zhiguo.zhou@intel.com>, 
	Tianyou Li <tianyou.li@intel.com>, Thomas Falcon <thomas.falcon@intel.com>, 
	Athira Rajeev <atrajeev@linux.ibm.com>, Collin Funk <collin.funk1@gmail.com>, 
	Dapeng Mi <dapeng1.mi@linux.intel.com>, Ravi Bangoria <ravi.bangoria@amd.com>, 
	Zecheng Li <zli94@ncsu.edu>, tanze <tanze@kylinos.cn>, 
	Thomas Richter <tmricht@linux.ibm.com>, Ankur Arora <ankur.a.arora@oracle.com>, 
	"Tycho Andersen (AMD)" <tycho@kernel.org>, Howard Chu <howardchu95@gmail.com>, 
	Sun Jian <sun.jian.kdev@gmail.com>, Derek Foreman <derek.foreman@collabora.com>, 
	Swapnil Sapkal <swapnil.sapkal@amd.com>, Anubhav Shelat <ashelat@redhat.com>, 
	Ricky Ringler <ricky.ringler@proton.me>, Qinxin Xia <xiaqinxin@huawei.com>, 
	Aditya Bodkhe <adityab1@linux.ibm.com>, Chun-Tse Shao <ctshao@google.com>, 
	Stephen Brennan <stephen.s.brennan@oracle.com>, Yang Li <yang.lee@linux.alibaba.com>, 
	Chuck Lever <chuck.lever@oracle.com>, Chen Ni <nichen@iscas.ac.cn>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org
Cc: Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"

Ported from tools/perf/scripts/python/export-to-sqlite.py to use the
perf Python module API.

Key changes:
- Switched from PySide2.QtSql to standard library sqlite3 for database
  operations.
- Implemented lazy population of lookup tables (threads, comms, dsos,
  symbols) from sample data.
- Added callchain support for building call paths.

Assisted-by: Gemini:gemini-3.1-pro-preview
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/python/export-to-sqlite.py | 351 ++++++++++++++++++++++++++
 1 file changed, 351 insertions(+)
 create mode 100755 tools/perf/python/export-to-sqlite.py

diff --git a/tools/perf/python/export-to-sqlite.py b/tools/perf/python/export-to-sqlite.py
new file mode 100755
index 000000000000..ec39c1b1e04b
--- /dev/null
+++ b/tools/perf/python/export-to-sqlite.py
@@ -0,0 +1,351 @@
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
+                proc = self.session.process(sample.sample_pid)
+                if proc:
+                    comm = proc.comm()
+        except TypeError:
+            pass
+        comm_id = self.get_comm_id(comm, thread_id)
+
+        dso_id = self.get_dso_id(
+            getattr(sample, 'dso', "Unknown_dso"),
+            getattr(sample, 'dso_long_name', "Unknown_dso_long"),
+            getattr(sample, 'dso_bid', "")
+        )
+
+        symbol_id = self.get_symbol_id(
+            dso_id,
+            getattr(sample, 'symbol', "Unknown_symbol"),
+            getattr(sample, 'sym_start', 0),
+            getattr(sample, 'sym_end', 0)
+        )
+
+        # Handle callchain
+        call_path_id = 0
+        if hasattr(sample, 'callchain') and sample.callchain:
+            parent_id = 0
+            for node in sample.callchain:
+                node_dso_id = self.get_dso_id(
+                    node.dso if node.dso else "Unknown_dso",
+                    node.dso if node.dso else "Unknown_dso",
+                    ""
+                )
+                node_symbol_id = self.get_symbol_id(
+                    node_dso_id,
+                    node.symbol if node.symbol else "Unknown_symbol",
+                    0, 0
+                )
+                parent_id = self.get_call_path_id(parent_id, node_symbol_id,
+                                                  node.ip)
+            call_path_id = parent_id
+
+        # Insert sample
+        self.con.execute("""
+            INSERT INTO samples VALUES (
+                NULL, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?
+            )
+        """, (
+            self.get_event_id(str(sample.evsel)), 0, thread_id, comm_id,
+            dso_id, symbol_id, getattr(sample, 'sym_offset', 0),
+            sample.ip, sample.time, sample.cpu,
+            0, 0, 0, 0,  # to_dso, to_symbol, to_sym_offset, to_ip
+            getattr(sample, 'period', 0),
+            getattr(sample, 'weight', 0),
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
+    if os.path.exists(args.output):
+        print(f"Error: {args.output} already exists")
+        sys.exit(1)
+
+    exporter = DatabaseExporter(args.output)
+
+    session = None
+    try:
+        session = perf.session(perf.data(args.input),
+                               sample=exporter.process_event)
+        exporter.session = session
+        session.process_events()
+        exporter.commit()
+        print(f"Successfully exported to {args.output}")
+    except Exception as e:
+        print(f"Error processing events: {e}")
+        if os.path.exists(args.output):
+            os.remove(args.output)
+    finally:
+        exporter.close()
-- 
2.54.0.rc1.513.gad8abe7a5a-goog

