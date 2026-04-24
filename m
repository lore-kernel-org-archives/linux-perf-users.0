Received: from mail-dy1-f201.google.com (mail-dy1-f201.google.com [74.125.82.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFD2F3E5595
	for <linux-perf-users@vger.kernel.org>; Fri, 24 Apr 2026 16:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777049346; cv=none; b=r/Oe8O02tofUNTS73rWi9fbGblfntK4vTdYIo/sYaT1qBz7tmr8MTFUEeoP/fF0KohSjuoNca21wHiCTdnSdVlfinOBQTRClfFbTS9KQopZwmaZvp3Raa9fOg47Q3Ihrm9tKJbgef/QcLRv8nSjpETXuzUTQwXtpgWYp/PfhIQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777049346; c=relaxed/simple;
	bh=RIHvcOGCJ5VkOEXsRhSYQt+5+8GJ1w+w5PUFd9KqTRY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=h778xIzEYIFwhimDNkGXvUPv3N4zjtJybBoGt95MMrN5UeLiFE++MLetGZiT1HlA+w9RBP2pebaYr+MAIY+OEMcxRSzWVcMaBvirIBM1hQgsyyalxKGaKnvoydzlD5tdfrWCWifH/pz8Sx5cTl4OfbgJNV+VP/VH807OyO0+emA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=H5DgKMHW; arc=none smtp.client-ip=74.125.82.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="H5DgKMHW"
Received: by mail-dy1-f201.google.com with SMTP id 5a478bee46e88-2cc75e79b97so20876351eec.1
        for <linux-perf-users@vger.kernel.org>; Fri, 24 Apr 2026 09:49:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777049343; x=1777654143; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=P3iGz+S1qTKwgAP31G+zlBPsnpetuPLAyUnc0LPDcL4=;
        b=H5DgKMHWVjQ1avD+5g+CP//lTdj1/uHaeLoKMWZNxHFu6hpApeV3x1dBYW8u8Xoz+p
         GyCRbJ9M7r8EtHZIsu2YaOEJEXqqKCYQKlo3EfXq07j9W+vw868TBdUba3gUnaYxXWkw
         qQngoBm93I82FwJrEdYoSolb1mmHSUZn0f0JAbWw3A6WTijlTZAc5BDNrhJz7GJJLl+5
         yvOZSAUejGP/xsLolIR06Fug0Mf/0iyMnNlMsmr8J9ANuZtF/9+2wKPuwnY3LEs/2eyL
         6DhLKrHDjrDWoc+0CYc/9YRb8/KUIPiNqLKFTuIlJFYe1dlX9xum369tBJBNT0XO7h+h
         CU3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777049343; x=1777654143;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=P3iGz+S1qTKwgAP31G+zlBPsnpetuPLAyUnc0LPDcL4=;
        b=C6i1c+CUvdRaK0LSUOjLZ8e3sXcrQkI4xNpMER+FGATTUewHN84dllvgIGddHfoOU9
         EzNcgK3yty2pFKBbrEsxrBj/GGHALgytCiybrfIPUeS44FdwpaCXCMzRdE8Uncoi5EQP
         MaM0NMWnKQdv5IB0bDjhfxj4HFEHWw9//HSxAo3238ILKEBFNaeqLL3ypYQxc/a/ZVT4
         pvoazGd3yzOOEdCVIG/pDCvgdQR6DBtbc1ufybovQ9OJjCTMNbNx685MME1CdcaoZImd
         KMeFC2S8J5DsePr6n+SOgBUrUAJXfroto5YiRf/bmEespBl0x2PmULVqWYc2GywAhfDN
         gSJg==
X-Forwarded-Encrypted: i=1; AFNElJ9e6MZp1uE6HL8e3vMq8ttJDwanpBPRLWl4ffdu2F+0iaQ+mjTGPRgm2QjRpznZUEWJdwvnbLYAUm6ptnVOS3Ch@vger.kernel.org
X-Gm-Message-State: AOJu0YxSf8uqV65DKU0DD9QKAPFQxQkhi5c+TlwY3IbkKa5O6CjYzjwC
	UEPNSIO2lC0bnSS3g6u8dSnujl7lyHpInb2iMHP54deeGpWuil+jzQL83MbdE2cJ/wC25xOOh8d
	LuLXFmIc0kA==
X-Received: from dycnl10.prod.google.com ([2002:a05:7300:d10a:b0:2d9:6d60:48e5])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:1351:b0:2da:4216:7ea3
 with SMTP id 5a478bee46e88-2e478a2f09dmr17184867eec.14.1777049342731; Fri, 24
 Apr 2026 09:49:02 -0700 (PDT)
Date: Fri, 24 Apr 2026 09:46:59 -0700
In-Reply-To: <20260424164721.2229025-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260423163406.1779809-1-irogers@google.com> <20260424164721.2229025-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260424164721.2229025-38-irogers@google.com>
Subject: [PATCH v5 37/58] perf export-to-postgresql: Port export-to-postgresql
 to use python module
From: Ian Rogers <irogers@google.com>
To: acme@kernel.org, adrian.hunter@intel.com, james.clark@linaro.org, 
	leo.yan@linux.dev, namhyung@kernel.org, tmricht@linux.ibm.com
Cc: alice.mei.rogers@gmail.com, dapeng1.mi@linux.intel.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, mingo@redhat.com, peterz@infradead.org, 
	Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"

Ported from tools/perf/scripts/python/export-to-postgresql.py to use
the perf Python module API.

Key changes:
- Removed PySide2 dependency by using libpq via ctypes for all DB
  operations (DDL and COPY).
- Kept the high-performance binary file generation and COPY FROM STDIN
  approach.
- Implemented lazy population of lookup tables from sample data.

Assisted-by: Gemini:gemini-3.1-pro-preview
Signed-off-by: Ian Rogers <irogers@google.com>
---
v2:

1. Dynamic Library Loading: Used ctypes.util.find_library("pq") to
   locate the PostgreSQL client library, making it more portable.

2. COPY Cleanup: Added a loop to call PQgetResult() until it returns
   None after PQputCopyEnd() , properly clearing the connection state
   and avoiding "command in progress" errors.

3. SQL Injection / Hyphen Fix: Added double quotes around the database
   name in the CREATE DATABASE query.

4. Fixed struct.pack Error: Added missing length prefixes for fields
  in write_sample to match the format string required by PostgreSQL's
  binary COPY format.

5. Fixed Cache Logic: Added a separate cache for comm_threads to
  ensure associations are written even when threads share a command
  name.

6. Fixed File I/O Order: Moved close_output_file() to happen after
   copy_output_file() .

7. Added Cleanup on Failure: Added logic to clean up the temporary
   directory if an exception occurs during processing, using
   shutil.rmtree .
---
 tools/perf/python/export-to-postgresql.py | 697 ++++++++++++++++++++++
 1 file changed, 697 insertions(+)
 create mode 100755 tools/perf/python/export-to-postgresql.py

diff --git a/tools/perf/python/export-to-postgresql.py b/tools/perf/python/export-to-postgresql.py
new file mode 100755
index 000000000000..d1fa87e1d2b1
--- /dev/null
+++ b/tools/perf/python/export-to-postgresql.py
@@ -0,0 +1,697 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: GPL-2.0
+r"""
+Export perf data to a postgresql database.
+
+This script has been ported to use the modern perf Python module and
+libpq via ctypes. It no longer requires PySide2 or QtSql for exporting.
+
+The script assumes postgresql is running on the local machine and that the
+user has postgresql permissions to create databases.
+
+An example of using this script with Intel PT:
+
+	$ perf record -e intel_pt//u ls
+	$ python tools/perf/python/export-to-postgresql.py -i perf.data -o pt_example
+
+To browse the database, psql can be used e.g.
+
+	$ psql pt_example
+	pt_example=# select * from samples_view where id < 100;
+	pt_example=# \d+
+	pt_example=# \d+ samples_view
+	pt_example=# \q
+
+An example of using the database is provided by the script
+exported-sql-viewer.py. Refer to that script for details.
+
+Tables:
+
+	The tables largely correspond to perf tools' data structures. They are
+	largely self-explanatory.
+
+	samples
+		'samples' is the main table. It represents what instruction was
+		executing at a point in time when something (a selected event)
+		happened. The memory address is the instruction pointer or 'ip'.
+
+	branch_types
+		'branch_types' provides descriptions for each type of branch.
+
+	comm_threads
+		'comm_threads' shows how 'comms' relates to 'threads'.
+
+	comms
+		'comms' contains a record for each 'comm' - the name given to the
+		executable that is running.
+
+	dsos
+		'dsos' contains a record for each executable file or library.
+
+	machines
+		'machines' can be used to distinguish virtual machines if
+		virtualization is supported.
+
+	selected_events
+		'selected_events' contains a record for each kind of event that
+		has been sampled.
+
+	symbols
+		'symbols' contains a record for each symbol. Only symbols that
+		have samples are present.
+
+	threads
+		'threads' contains a record for each thread.
+
+Views:
+
+	Most of the tables have views for more friendly display. The views are:
+
+		comm_threads_view
+		dsos_view
+		machines_view
+		samples_view
+		symbols_view
+		threads_view
+
+Ported from tools/perf/scripts/python/export-to-postgresql.py
+"""
+
+import argparse
+from ctypes import CDLL, c_char_p, c_int, c_void_p, c_ubyte
+import ctypes.util
+import os
+import shutil
+import struct
+import sys
+from typing import Any, Dict, Optional
+import perf
+
+# Need to access PostgreSQL C library directly to use COPY FROM STDIN
+libpq_name = ctypes.util.find_library("pq")
+if not libpq_name:
+    libpq_name = "libpq.so.5"
+
+try:
+    libpq = CDLL(libpq_name)
+except OSError as e:
+    print(f"Error loading {libpq_name}: {e}")
+    print("Please ensure PostgreSQL client library is installed.")
+    sys.exit(1)
+
+PQconnectdb = libpq.PQconnectdb
+PQconnectdb.restype = c_void_p
+PQconnectdb.argtypes = [c_char_p]
+PQfinish = libpq.PQfinish
+PQfinish.argtypes = [c_void_p]
+PQstatus = libpq.PQstatus
+PQstatus.restype = c_int
+PQstatus.argtypes = [c_void_p]
+PQexec = libpq.PQexec
+PQexec.restype = c_void_p
+PQexec.argtypes = [c_void_p, c_char_p]
+PQresultStatus = libpq.PQresultStatus
+PQresultStatus.restype = c_int
+PQresultStatus.argtypes = [c_void_p]
+PQputCopyData = libpq.PQputCopyData
+PQputCopyData.restype = c_int
+PQputCopyData.argtypes = [c_void_p, c_void_p, c_int]
+PQputCopyEnd = libpq.PQputCopyEnd
+PQputCopyEnd.restype = c_int
+PQputCopyEnd.argtypes = [c_void_p, c_void_p]
+PQgetResult = libpq.PQgetResult
+PQgetResult.restype = c_void_p
+PQgetResult.argtypes = [c_void_p]
+PQclear = libpq.PQclear
+PQclear.argtypes = [c_void_p]
+
+
+def toserverstr(s: str) -> bytes:
+    """Convert string to server encoding (UTF-8)."""
+    return bytes(s, "UTF_8")
+
+
+def toclientstr(s: str) -> bytes:
+    """Convert string to client encoding (UTF-8)."""
+    return bytes(s, "UTF_8")
+
+
+
+class PostgresExporter:
+    """Handles PostgreSQL connection and exporting of perf events."""
+
+    def __init__(self, dbname: str):
+        self.dbname = dbname
+        self.conn = None
+        self.session: Optional[perf.session] = None
+        self.output_dir_name = os.getcwd() + "/" + dbname + "-perf-data"
+
+        self.file_header = struct.pack("!11sii", b"PGCOPY\n\377\r\n\0", 0, 0)
+        self.file_trailer = b"\377\377"
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
+        self.files: Dict[str, Any] = {}
+        self.unhandled_count = 0
+
+    def connect(self, db_to_use: str) -> None:
+        """Connect to database."""
+        conn_str = toclientstr(f"dbname = {db_to_use}")
+        self.conn = PQconnectdb(conn_str)
+        if PQstatus(self.conn) != 0:
+            raise RuntimeError(f"PQconnectdb failed for {db_to_use}")
+
+    def disconnect(self) -> None:
+        """Disconnect from database."""
+        if self.conn:
+            PQfinish(self.conn)
+            self.conn = None
+
+    def do_query(self, sql: str) -> None:
+        """Execute a query and check status."""
+        res = PQexec(self.conn, toserverstr(sql))
+        status = PQresultStatus(res)
+        PQclear(res)
+        if status not in (1, 2):  # PGRES_COMMAND_OK, PGRES_TUPLES_OK
+            raise RuntimeError(f"Query failed: {sql}")
+
+
+    def open_output_file(self, file_name: str):
+        """Open intermediate binary file."""
+        path_name = self.output_dir_name + "/" + file_name
+        f = open(path_name, "wb+")
+        f.write(self.file_header)
+        return f
+
+    def close_output_file(self, f):
+        """Close intermediate binary file."""
+        f.write(self.file_trailer)
+        f.close()
+
+    def copy_output_file(self, f, table_name: str):
+        """Copy intermediate file to database."""
+        f.seek(0)
+        sql = f"COPY {table_name} FROM STDIN (FORMAT 'binary')"
+        res = PQexec(self.conn, toserverstr(sql))
+        if PQresultStatus(res) != 4:  # PGRES_COPY_IN
+            PQclear(res)
+            raise RuntimeError(f"COPY FROM STDIN PQexec failed for {table_name}")
+        PQclear(res)
+
+        f.seek(0)
+        data = f.read(65536)
+        while len(data) > 0:
+            c_data = (c_ubyte * len(data)).from_buffer_copy(data)
+            ret = PQputCopyData(self.conn, c_data, len(data))
+            if ret != 1:
+                raise RuntimeError(f"PQputCopyData failed for {table_name}")
+            data = f.read(65536)
+
+        ret = PQputCopyEnd(self.conn, None)
+        if ret != 1:
+            raise RuntimeError(f"PQputCopyEnd failed for {table_name}")
+
+        res = PQgetResult(self.conn)
+        while res:
+            PQclear(res)
+            res = PQgetResult(self.conn)
+
+
+
+    def setup_db(self) -> None:
+        """Create database and tables. MUST be called after init."""
+        os.mkdir(self.output_dir_name)
+
+        self.connect('postgres')
+        try:
+            self.do_query(f'CREATE DATABASE "{self.dbname}"')
+        except Exception as e:
+            os.rmdir(self.output_dir_name)
+            raise e
+        self.disconnect()
+
+        self.connect(self.dbname)
+        self.do_query("SET client_min_messages TO WARNING")
+
+        self.do_query("""
+            CREATE TABLE selected_events (
+                    id              bigint          NOT NULL,
+                    name            varchar(80))
+        """)
+        self.do_query("""
+            CREATE TABLE machines (
+                    id              bigint          NOT NULL,
+                    pid             integer,
+                    root_dir        varchar(4096))
+        """)
+        self.do_query("""
+            CREATE TABLE threads (
+                    id              bigint          NOT NULL,
+                    machine_id      bigint,
+                    process_id      bigint,
+                    pid             integer,
+                    tid             integer)
+        """)
+        self.do_query("""
+            CREATE TABLE comms (
+                    id              bigint          NOT NULL,
+                    comm            varchar(16),
+                    c_thread_id     bigint,
+                    c_time          bigint,
+                    exec_flag       boolean)
+        """)
+        self.do_query("""
+            CREATE TABLE comm_threads (
+                    id              bigint          NOT NULL,
+                    comm_id         bigint,
+                    thread_id       bigint)
+        """)
+        self.do_query("""
+            CREATE TABLE dsos (
+                    id              bigint          NOT NULL,
+                    machine_id      bigint,
+                    short_name      varchar(256),
+                    long_name       varchar(4096),
+                    build_id        varchar(64))
+        """)
+        self.do_query("""
+            CREATE TABLE symbols (
+                    id              bigint          NOT NULL,
+                    dso_id          bigint,
+                    sym_start       bigint,
+                    sym_end         bigint,
+                    binding         integer,
+                    name            varchar(2048))
+        """)
+        self.do_query("""
+            CREATE TABLE branch_types (
+                    id              integer         NOT NULL,
+                    name            varchar(80))
+        """)
+        self.do_query("""
+            CREATE TABLE samples (
+                    id              bigint          NOT NULL,
+                    evsel_id        bigint,
+                    machine_id      bigint,
+                    thread_id       bigint,
+                    comm_id         bigint,
+                    dso_id          bigint,
+                    symbol_id       bigint,
+                    sym_offset      bigint,
+                    ip              bigint,
+                    time            bigint,
+                    cpu             integer,
+                    to_dso_id       bigint,
+                    to_symbol_id    bigint,
+                    to_sym_offset   bigint,
+                    to_ip           bigint,
+                    period          bigint,
+                    weight          bigint,
+                    transaction_    bigint,
+                    data_src        bigint,
+                    branch_type     integer,
+                    in_tx           boolean,
+                    call_path_id    bigint,
+                    insn_count      bigint,
+                    cyc_count       bigint,
+                    flags           integer)
+        """)
+        self.do_query("""
+            CREATE TABLE call_paths (
+                    id              bigint          NOT NULL,
+                    parent_id       bigint,
+                    symbol_id       bigint,
+                    ip              bigint)
+        """)
+
+        self.files['evsel'] = self.open_output_file("evsel_table.bin")
+        self.files['machine'] = self.open_output_file("machine_table.bin")
+        self.files['thread'] = self.open_output_file("thread_table.bin")
+        self.files['comm'] = self.open_output_file("comm_table.bin")
+        self.files['comm_thread'] = self.open_output_file("comm_thread_table.bin")
+        self.files['dso'] = self.open_output_file("dso_table.bin")
+        self.files['symbol'] = self.open_output_file("symbol_table.bin")
+        self.files['branch_type'] = self.open_output_file("branch_type_table.bin")
+        self.files['sample'] = self.open_output_file("sample_table.bin")
+        self.files['call_path'] = self.open_output_file("call_path_table.bin")
+
+        self.write_evsel(0, "unknown")
+        self.write_machine(0, 0, "unknown")
+        self.write_thread(0, 0, 0, -1, -1)
+        self.write_comm(0, "unknown", 0, 0, 0)
+        self.write_dso(0, 0, "unknown", "unknown", "")
+        self.write_symbol(0, 0, 0, 0, 0, "unknown")
+        self.write_call_path(0, 0, 0, 0)
+
+    def write_evsel(self, evsel_id: int, name: str) -> None:
+        """Write event to binary file."""
+        name_bytes = toserverstr(name)
+        n = len(name_bytes)
+        fmt = "!hiqi" + str(n) + "s"
+        value = struct.pack(fmt, 2, 8, evsel_id, n, name_bytes)
+        self.files['evsel'].write(value)
+
+    def write_machine(self, machine_id: int, pid: int, root_dir: str) -> None:
+        """Write machine to binary file."""
+        rd_bytes = toserverstr(root_dir)
+        n = len(rd_bytes)
+        fmt = "!hiqiii" + str(n) + "s"
+        value = struct.pack(fmt, 3, 8, machine_id, 4, pid, n, rd_bytes)
+        self.files['machine'].write(value)
+
+
+    def write_thread(self, thread_id: int, machine_id: int, process_id: int,
+                     pid: int, tid: int) -> None:
+        """Write thread to binary file."""
+        value = struct.pack("!hiqiqiqiiii", 5, 8, thread_id, 8, machine_id,
+                            8, process_id, 4, pid, 4, tid)
+        self.files['thread'].write(value)
+
+
+    def write_comm(self, comm_id: int, comm_str: str, thread_id: int,
+                   time: int, exec_flag: int) -> None:
+        """Write comm to binary file."""
+        comm_bytes = toserverstr(comm_str)
+        n = len(comm_bytes)
+        fmt = "!hiqi" + str(n) + "s" + "iqiqiB"
+        value = struct.pack(fmt, 5, 8, comm_id, n, comm_bytes, 8,
+                            thread_id, 8, time, 1, exec_flag)
+        self.files['comm'].write(value)
+
+    def write_comm_thread(self, comm_thread_id: int, comm_id: int,
+                          thread_id: int) -> None:
+        """Write comm_thread to binary file."""
+        fmt = "!hiqiqiq"
+        value = struct.pack(fmt, 3, 8, comm_thread_id, 8, comm_id, 8, thread_id)
+        self.files['comm_thread'].write(value)
+
+
+    def write_dso(self, dso_id: int, machine_id: int, short_name: str,
+                  long_name: str, build_id: str) -> None:
+        """Write DSO to binary file."""
+        sn_bytes = toserverstr(short_name)
+        ln_bytes = toserverstr(long_name)
+        bi_bytes = toserverstr(build_id)
+        n1, n2, n3 = len(sn_bytes), len(ln_bytes), len(bi_bytes)
+        fmt = "!hiqiqi" + str(n1) + "si" + str(n2) + "si" + str(n3) + "s"
+        value = struct.pack(fmt, 5, 8, dso_id, 8, machine_id, n1,
+                            sn_bytes, n2, ln_bytes, n3, bi_bytes)
+        self.files['dso'].write(value)
+
+
+    def write_symbol(self, symbol_id: int, dso_id: int, sym_start: int,
+                      sym_end: int, binding: int, symbol_name: str) -> None:
+        """Write symbol to binary file."""
+        name_bytes = toserverstr(symbol_name)
+        n = len(name_bytes)
+        fmt = "!hiqiqiqiqiii" + str(n) + "s"
+        value = struct.pack(fmt, 6, 8, symbol_id, 8, dso_id, 8,
+                            sym_start, 8, sym_end, 4, binding, n, name_bytes)
+        self.files['symbol'].write(value)
+
+    def write_call_path(self, cp_id: int, parent_id: int, symbol_id: int,
+                         ip: int) -> None:
+        """Write call path to binary file."""
+        fmt = "!hiqiqiqiq"
+        value = struct.pack(fmt, 4, 8, cp_id, 8, parent_id, 8, symbol_id, 8, ip)
+        self.files['call_path'].write(value)
+
+
+    def write_sample(self, sample_id: int, evsel_id: int, thread_id: int,
+                      comm_id: int, dso_id: int, symbol_id: int,
+                      sample: perf.sample_event, call_path_id: int) -> None:
+        """Write sample to binary file."""
+        value = struct.pack(
+            "!hiqiqiqiqiqiqiqiqiqiqiiiqiqiqiqiqiqiqiqiiiBiqiqiqii",
+            25, 8, sample_id, 8, evsel_id, 8, 0, 8, thread_id, 8, comm_id,
+            8, dso_id, 8, symbol_id, 8, getattr(sample, 'sym_offset', 0),
+            8, sample.sample_ip, 8, sample.sample_time, 4, sample.sample_cpu,
+            8, 0, 8, 0, 8, 0, 8, 0,
+            8, getattr(sample, 'sample_period', 0) or 0,
+            8, getattr(sample, 'sample_weight', 0) or 0,
+            8, getattr(sample, 'transaction_', 0) or 0,
+            8, getattr(sample, 'data_src', 0) or 0,
+            4, 0,
+            1, getattr(sample, 'in_tx', 0) or 0,
+            8, call_path_id,
+            8, getattr(sample, 'insn_count', 0) or 0,
+            8, getattr(sample, 'cyc_count', 0) or 0,
+            4, getattr(sample, 'flags', 0) or 0
+        )
+        self.files['sample'].write(value)
+
+    def get_event_id(self, name: str) -> int:
+        """Get or create event ID."""
+        if name in self.caches['events']:
+            return self.caches['events'][name]
+        event_id = self.next_id['event']
+        self.write_evsel(event_id, name)
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
+        self.write_thread(thread_id, 0, pid, pid, tid)
+        self.caches['threads'][key] = thread_id
+        self.next_id['thread'] += 1
+        return thread_id
+
+    def get_comm_id(self, comm: str, thread_id: int) -> int:
+        """Get or create comm ID."""
+        if comm in self.caches['comms']:
+            comm_id = self.caches['comms'][comm]
+        else:
+            comm_id = self.next_id['comm']
+            self.write_comm(comm_id, comm, thread_id, 0, 0)
+            self.caches['comms'][comm] = comm_id
+            self.next_id['comm'] += 1
+
+        key = (comm_id, thread_id)
+        if 'comm_threads' not in self.caches:
+            self.caches['comm_threads'] = {}
+        if key not in self.caches['comm_threads']:
+            self.write_comm_thread(comm_id, comm_id, thread_id)
+            self.caches['comm_threads'][key] = True
+
+        return comm_id
+
+    def get_dso_id(self, short_name: str, long_name: str,
+                   build_id: str) -> int:
+        """Get or create DSO ID."""
+        if short_name in self.caches['dsos']:
+            return self.caches['dsos'][short_name]
+        dso_id = self.next_id['dso']
+        self.write_dso(dso_id, 0, short_name, long_name, build_id)
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
+        self.write_symbol(symbol_id, dso_id, start, end, 0, name)
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
+        self.write_call_path(call_path_id, parent_id, symbol_id, ip)
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
+        call_path_id = 0
+        if hasattr(sample, 'callchain') and sample.callchain:
+            parent_id = 0
+            for node in sample.callchain:
+                node_dso = getattr(node, 'dso', None) or getattr(node, 'map', None)
+                node_symbol = getattr(node, 'symbol', None) or getattr(node, 'sym', None)
+
+                dso_name = "Unknown_dso"
+                if node_dso:
+                    dso_name = getattr(node_dso, 'name', "Unknown_dso") or "Unknown_dso"
+
+                symbol_name = "Unknown_symbol"
+                if node_symbol:
+                    symbol_name = getattr(node_symbol, 'name', "Unknown_symbol") or "Unknown_symbol"
+
+                node_dso_id = self.get_dso_id(dso_name, dso_name, "")
+                node_symbol_id = self.get_symbol_id(node_dso_id, symbol_name, 0, 0)
+
+                parent_id = self.get_call_path_id(parent_id, node_symbol_id, node.ip)
+            call_path_id = parent_id
+
+        sample_id = self.next_id['event']
+        self.write_sample(sample_id,
+                          self.get_event_id(getattr(sample.evsel, 'name', str(sample.evsel))),
+                          thread_id, comm_id, dso_id, symbol_id, sample,
+                          call_path_id)
+        self.next_id['event'] += 1
+
+    def finalize(self) -> None:
+        """Copy files to database and add keys/views."""
+        print("Copying to database...")
+        for name, f in self.files.items():
+            table_name = name + "s" if name != "call_path" else "call_paths"
+            if name == "evsel":
+                table_name = "selected_events"
+            self.copy_output_file(f, table_name)
+            self.close_output_file(f)
+
+        print("Removing intermediate files...")
+        for name, f in self.files.items():
+            os.unlink(f.name)
+        os.rmdir(self.output_dir_name)
+
+        print("Adding primary keys")
+        self.do_query("ALTER TABLE selected_events ADD PRIMARY KEY (id)")
+        self.do_query("ALTER TABLE machines        ADD PRIMARY KEY (id)")
+        self.do_query("ALTER TABLE threads         ADD PRIMARY KEY (id)")
+        self.do_query("ALTER TABLE comms           ADD PRIMARY KEY (id)")
+        self.do_query("ALTER TABLE comm_threads    ADD PRIMARY KEY (id)")
+        self.do_query("ALTER TABLE dsos            ADD PRIMARY KEY (id)")
+        self.do_query("ALTER TABLE symbols         ADD PRIMARY KEY (id)")
+        self.do_query("ALTER TABLE branch_types    ADD PRIMARY KEY (id)")
+        self.do_query("ALTER TABLE samples         ADD PRIMARY KEY (id)")
+        self.do_query("ALTER TABLE call_paths      ADD PRIMARY KEY (id)")
+
+        print("Creating views...")
+        self.do_query("""
+            CREATE VIEW machines_view AS
+            SELECT id, pid, root_dir,
+            CASE WHEN id=0 THEN 'unknown' WHEN pid=-1 THEN 'host' ELSE 'guest' END AS host_or_guest
+            FROM machines
+        """)
+        self.do_query("""
+            CREATE VIEW dsos_view AS
+            SELECT id, machine_id,
+            (SELECT host_or_guest FROM machines_view WHERE id = machine_id) AS host_or_guest,
+            short_name, long_name, build_id
+            FROM dsos
+        """)
+        self.do_query("""
+            CREATE VIEW symbols_view AS
+            SELECT id, name,
+            (SELECT short_name FROM dsos WHERE id=dso_id) AS dso,
+            dso_id, sym_start, sym_end,
+            CASE WHEN binding=0 THEN 'local' WHEN binding=1 THEN 'global' ELSE 'weak' END AS binding
+            FROM symbols
+        """)
+        self.do_query("""
+            CREATE VIEW threads_view AS
+            SELECT id, machine_id,
+            (SELECT host_or_guest FROM machines_view WHERE id = machine_id) AS host_or_guest,
+            process_id, pid, tid
+            FROM threads
+        """)
+        self.do_query("""
+            CREATE VIEW samples_view AS
+            SELECT id, time, cpu,
+            (SELECT pid FROM threads WHERE id = thread_id) AS pid,
+            (SELECT tid FROM threads WHERE id = thread_id) AS tid,
+            (SELECT comm FROM comms WHERE id = comm_id) AS command,
+            (SELECT name FROM selected_events WHERE id = evsel_id) AS event,
+            to_hex(ip) AS ip_hex,
+            (SELECT name FROM symbols WHERE id = symbol_id) AS symbol,
+            sym_offset,
+            (SELECT short_name FROM dsos WHERE id = dso_id) AS dso_short_name,
+            to_hex(to_ip) AS to_ip_hex,
+            (SELECT name FROM symbols WHERE id = to_symbol_id) AS to_symbol,
+            to_sym_offset,
+            (SELECT short_name FROM dsos WHERE id = to_dso_id) AS to_dso_short_name,
+            (SELECT name FROM branch_types WHERE id = branch_type) AS branch_type_name,
+            in_tx, insn_count, cyc_count, flags
+            FROM samples
+        """)
+
+
+if __name__ == "__main__":
+    ap = argparse.ArgumentParser(
+        description="Export perf data to a postgresql database")
+    ap.add_argument("-i", "--input", default="perf.data",
+                    help="Input file name")
+    ap.add_argument("-o", "--output", required=True,
+                    help="Output database name")
+    args = ap.parse_args()
+
+    exporter = PostgresExporter(args.output)
+    exporter.setup_db()
+
+    session = None
+    error_occurred = False
+    try:
+        session = perf.session(perf.data(args.input),
+                               sample=exporter.process_event)
+        exporter.session = session
+        session.process_events()
+        exporter.finalize()
+        print(f"Successfully exported to {args.output}")
+    except Exception as e:
+        print(f"Error processing events: {e}")
+        error_occurred = True
+    finally:
+        exporter.disconnect()
+        if error_occurred:
+            if os.path.exists(exporter.output_dir_name):
+                shutil.rmtree(exporter.output_dir_name)
-- 
2.54.0.545.g6539524ca2-goog

