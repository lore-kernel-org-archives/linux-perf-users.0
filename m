Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE83C3845B7
	for <linux-perf-users@vger.kernel.org>; Sat, 25 Apr 2026 23:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777158865; cv=none; b=giet0ljTdM9Vk9vGxo14IEoE+4ARZDPx012gOHXGqOqFycCKer2R3mZyOkcqo/YF6ZXl2LRIo5mp2u7YHv3nPnhTj51a8Mk59qIfkr8YVYPjT408RYejku2MbyWoiUElsH4yPzyQVjtaSEUnAHJv/9Glaw2ztUpjpQDA/7uxmtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777158865; c=relaxed/simple;
	bh=2SpUNzAP1qViN0J+8u24UQ2Rcj9Xl/oxL7YyJRVEsjk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=pTi5dKlYx2D0rl8Yu1G08C7A1Of3m+Por630pviCt1FjItCy4R6NqzC6pDD0yk8Xt9DaaqwGjNI2bN5o3ycKi2qrbhenbXGfM/bCIPynYwbVy0efvbOBNQC+/ZkBzL6K59iB0OU2b03dCPZ/5WxtBSBo9M6VkhVb2Ioy/W8gQlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k4wmzV0p; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k4wmzV0p"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83774C2BCB0;
	Sat, 25 Apr 2026 23:14:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777158865;
	bh=2SpUNzAP1qViN0J+8u24UQ2Rcj9Xl/oxL7YyJRVEsjk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=k4wmzV0pcXeUjlAVVJYeJKDKSgK0mAcYwhnBlbIeZCnEdY6PsR/K0wMxdJ+8Oe0je
	 9+i86jat/+C0xgHFeJ7hpG/DQJyKpalV4K4+0RS7Vn6vmCelLND47xf80W3nNgbws4
	 4XRc2MBsrN86eKFyphO/gXTfArs9wL8IgxTFRG1GWziPSMvJnOftUHA0D8JBx8jkRi
	 5blxctaTbzkHaxjwW0aCvfICwWUEYNgUxAKdMfkKuOXTOnbeWJgMlcYciyUrTW5C3X
	 ksBpTHw+t4yeHTO1r3loxCtDW2AcV70+4gQ9WL1yo/HEtyOs1vpA9JRwuzWCPbJUO4
	 sofuhWRDxbu3A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 36/59] perf export-to-sqlite: Port export-to-sqlite
 to use python module
Reply-To: sashiko@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260425224951.174663-37-irogers@google.com>
References: <20260425224951.174663-37-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 25 Apr 2026 23:14:24 +0000
Message-Id: <20260425231425.83774C2BCB0@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Sashiko AI review found 6 potential issue(s):
- [High] The `comms` and `dsos` caches use overly broad keys, erroneously m=
erging independent entities and breaking database relationships.
- [High] The call path hierarchy is constructed upside down in the database=
, breaking downstream analysis tools.
- [High] The script silently drops critical tables and views for Intel PT e=
vents, context switches, and calls, severely degrading functionality.
- [High] Branch target information is hardcoded to 0 for all samples, destr=
oying branch profiling capabilities.
- [High] `get_thread_id` inserts the OS-level pid into the `process_id` col=
umn, corrupting the foreign key relationship to the threads table.
- [High] The script uses incorrect Python attribute names for instruction/c=
ycle counts and data sources, causing them to always record as 0.
--

commit 138bb15600adb0810965d6d12fdc0d8dab81d4e5
Author: Ian Rogers <irogers@google.com>

perf export-to-sqlite: Port export-to-sqlite to use python module

This commit ports the export-to-sqlite.py script to use the modern perf
Python module and the standard library sqlite3 module. It drops the
dependency on PySide2.QtSql.

> diff --git a/tools/perf/python/export-to-sqlite.py b/tools/perf/python/ex=
port-to-sqlite.py
> new file mode 100755
> index 000000000000..736b56ff8d59
> --- /dev/null
> +++ b/tools/perf/python/export-to-sqlite.py
> @@ -0,0 +1,372 @@
[ ... ]
> +    def create_tables(self) -> None:
> +        """Create database tables."""
> +        self.con.execute("""
> +            CREATE TABLE IF NOT EXISTS selected_events (
> +                    id      INTEGER         NOT NULL        PRIMARY KEY,
> +                    name    VARCHAR(80))
> +        """)

[ ... ]

> +        self.con.execute("""
> +            CREATE VIEW IF NOT EXISTS samples_view AS
> +            SELECT s.id, e.name as event, t.pid, t.tid, c.comm,
> +                   d.short_name as dso, sym.name as symbol, s.sym_offset,
> +                   s.ip, s.time, s.cpu
> +            FROM samples s
> +            JOIN selected_events e ON s.evsel_id =3D e.id
> +            JOIN threads t ON s.thread_id =3D t.id
> +            JOIN comms c ON s.comm_id =3D c.id
> +            JOIN dsos d ON s.dso_id =3D d.id
> +            JOIN symbols sym ON s.symbol_id =3D sym.id;
> +        """)

Are we missing the database tables and views required for Intel PT profilin=
g?

The commit message advertises Intel PT support and points users to
exported-sql-viewer.py, but this script appears to omit all database views
except samples_view (such as comm_threads_view or context_switches_view).

It also drops tables for context switches, the calls table, and Intel PT
synthetic events (like ptwrite, mwait, pwre, exstop) which were present
in the original script. Won't this break features in downstream viewers
and remove the advertised Intel PT profiling capabilities?

[ ... ]

> +    def get_thread_id(self, pid: int, tid: int) -> int:
> +        """Get or create thread ID."""
> +        key =3D (pid, tid)
> +        if key in self.caches['threads']:
> +            return self.caches['threads'][key]
> +        thread_id =3D self.next_id['thread']
> +        self.con.execute("INSERT INTO threads VALUES (?, ?, ?, ?, ?)",
> +                         (thread_id, 0, pid, pid, tid))

Does inserting the operating system pid into the process_id column break the
foreign key relationship?

In the standard perf sqlite export schema, the process_id column is a forei=
gn
key representing the database primary key (id) of the main thread. Because
the raw operating system pid (e.g., 1234) does not match the script's inter=
nal
auto-incrementing database id, won't downstream joins fail and break thread
groupings?

> +        self.caches['threads'][key] =3D thread_id
> +        self.next_id['thread'] +=3D 1
> +        return thread_id
> +
> +    def get_comm_id(self, comm: str, thread_id: int) -> int:
> +        """Get or create comm ID."""
> +        if comm in self.caches['comms']:
> +            return self.caches['comms'][comm]

Does caching solely by the string comm break the database relationship?

If multiple distinct threads use the same command name (e.g., python), won't
the second thread hit the cache, receive the exact same comm_id, and bypass
the database insertion that links its thread_id to that comm_id in the
comm_threads table? Should the cache key include the thread_id?

> +        comm_id =3D self.next_id['comm']
> +        self.con.execute("INSERT INTO comms VALUES (?, ?, ?, ?, ?)",
> +                         (comm_id, comm, thread_id, 0, 0))
> +        self.con.execute("INSERT INTO comm_threads VALUES (?, ?, ?)",
> +                         (comm_id, comm_id, thread_id))
> +        self.caches['comms'][comm] =3D comm_id
> +        self.next_id['comm'] +=3D 1
> +        return comm_id
> +
> +    def get_dso_id(self, short_name: str, long_name: str,
> +                   build_id: str) -> int:
> +        """Get or create DSO ID."""
> +        if short_name in self.caches['dsos']:
> +            return self.caches['dsos'][short_name]

Similar to the comms cache, will caching solely by short_name cause issues?

If two different libraries share the same short name but have different long
names or build IDs, it looks like they will be incorrectly merged into a si=
ngle
DSO database record. Should the cache key also include the long_name and
build_id?

[ ... ]

> +        # Handle callchain
> +        call_path_id =3D 0
> +        if hasattr(sample, 'callchain') and sample.callchain:
> +            parent_id =3D 0
> +            for node in sample.callchain:

Are we building the call path hierarchy upside down?

In perf database exports, call_path trees are conventionally structured from
root to leaf, where the main function (caller) is the root (parent_id =3D 0=
).

Since the Python binding for sample.callchain returns frames in the default
order (innermost frame first), iterating without reversing the chain assigns
parent_id =3D 0 to the callee and sets it as the parent of its caller. Will=
 this
flip the callgraph upside down when visualized in tools like
exported-sql-viewer.py?

[ ... ]

> +        # Insert sample
> +        self.con.execute("""
> +            INSERT INTO samples VALUES (
> +                NULL, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?,=
 ?, ?, ?, ?, ?, ?, ?
> +            )
> +        """, (
> +            self.get_event_id(getattr(sample.evsel, 'name', str(sample.e=
vsel))),
> +            0, thread_id, comm_id,
> +            dso_id, symbol_id, getattr(sample, 'sym_offset', 0),
> +            sample.sample_ip, sample.sample_time, sample.sample_cpu,
> +            0, 0, 0, 0,  # to_dso, to_symbol, to_sym_offset, to_ip

Will hardcoding these branch target columns to 0 prevent branch profiling?

The samples table schema includes branch target columns which are used
for tracing control flow. Shouldn't we extract these target addresses from
sample.brstack or other properties instead of dropping them?

> +            getattr(sample, 'sample_period', 0) or 0,
> +            getattr(sample, 'sample_weight', 0) or 0,
> +            getattr(sample, 'transaction_', 0),
> +            getattr(sample, 'data_src', 0),
> +            0,  # branch_type
> +            getattr(sample, 'in_tx', 0),
> +            call_path_id,
> +            getattr(sample, 'insn_count', 0),
> +            getattr(sample, 'cyc_count', 0),

Are we using the correct Python attribute names for the hardware counters?

As defined in tools/perf/util/python.c, the Python perf.sample_event
object exposes these properties with a sample_ prefix (e.g.,
sample_insn_count, sample_cyc_count, sample_data_src).

Because the requested attributes (insn_count, cyc_count, data_src) do
not exist without the prefix, won't getattr silently fall back to 0 and
break instructions per cycle calculation and memory profiling?

> +            getattr(sample, 'flags', 0)
> +        ))

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260425224951.1746=
63-1-irogers@google.com?part=3D36
