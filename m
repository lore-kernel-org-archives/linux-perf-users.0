Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42E361DE4EF
	for <linux-perf-users@vger.kernel.org>; Mon, 20 Apr 2026 00:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776644921; cv=none; b=GDBApt3k9zE9rA0YFoTIL4z+nJUK4tGhGNwh2iofaMU265aXJ4LLrsYOkHe6FSAR4YHJloPYOO94H6OclGCuHO/xWCJfoAL6ANmbY7uPDFNNKExI3xyq18cdXcI8js5Nxaro1+FARKK2pyKjF8v6lZGNSowhCb2tXwvrYBituiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776644921; c=relaxed/simple;
	bh=HruQRVy7gRDH2tGiQZYwlhztlZv/+uSU0tqo3AKFfYM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=WgSmiXGq0zSbtPJayU27JitWjYZMiiEzxV0++bJOgqeQkCjq82oPnYuQeEXWlWu/OSq/M3J4DTNOVrok5RwI9a6vsbuOfrofTDqCat8Ybe1l8biEQRmQh/QFrk55eX4O0QOf08KW1se85STcU9cRULyMJUvrM5P9ANhK9VbXuhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H8Z23L1d; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H8Z23L1d"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAA9CC2BCAF;
	Mon, 20 Apr 2026 00:28:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776644921;
	bh=HruQRVy7gRDH2tGiQZYwlhztlZv/+uSU0tqo3AKFfYM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=H8Z23L1dxdi+055k2Ekr4+oG90SIFofo3DOW8KWNt+ODKCUf0F83YI9ACLqDIqfAv
	 E1bK1DnW5qbCRztlj8QRwjcqgqhfSjD0VmBKyYRhO9MnKqzmkeChBqL5zBNpPu4mpA
	 qFyuE2QNUG/Cxq2hTRbizWxWj62o9yFk+MZMFIKZ/HPOy3ppfUkVUUBxxZQ7CvDPee
	 7Q5X/MYEat/liUFWt1nt39KudUphAoqh6ZLbICmSAu11EOY2lR6VzeGmsPtVPumf4A
	 a/Tat2jTGrmzke2gN33YHd/gvN1Wll+Wwjh4KIRNJJNpWHbNykSE2fHL2FT6rpswZ6
	 6d450tmH4L5kQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 37/58] perf export-to-postgresql: Port
 export-to-postgresql to use python module
Reply-To: sashiko@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260419235911.2186050-38-irogers@google.com>
References: <20260419235911.2186050-38-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 20 Apr 2026 00:28:40 +0000
Message-Id: <20260420002840.DAA9CC2BCAF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Sashiko AI review found 8 potential issue(s):
- [High] Immediate runtime crash in `write_sample` due to `struct.pack` arg=
ument mismatch.
- [High] `finalize()` attempts to read from closed files, causing an I/O er=
ror.
- [High] Missing `PQgetResult` after `PQputCopyEnd` leaves the PostgreSQL c=
onnection in a desynchronized state.
- [High] Caching command IDs solely by name drops relationships for differe=
nt threads executing the same command.
- [Medium] Temporary output directories and files are permanently leaked on=
 errors.
- [Medium] Unquoted database name in `CREATE DATABASE` query causes syntax =
errors.
- [Low] The `branch_types` lookup table is completely unpopulated.
- [Low] Hardcoding the specific shared library version 'libpq.so.5' reduces=
 portability.
--

commit b6c1a19bed966a424b4379f69e4ee67f64608381
Author: Ian Rogers <irogers@google.com>

perf export-to-postgresql: Port export-to-postgresql to use python module

This commit ports export-to-postgresql.py to use the perf Python module API
instead of PySide2. It uses libpq via ctypes for database operations while
keeping the high-performance binary file generation approach. Lazy populati=
on
of lookup tables from sample data is also implemented.

> diff --git a/tools/perf/python/export-to-postgresql.py b/tools/perf/pytho=
n/export-to-postgresql.py
> new file mode 100755
> index 0000000000000..f9de4b1ef0b19
> --- /dev/null
> +++ b/tools/perf/python/export-to-postgresql.py
> @@ -0,0 +1,666 @@
[ ... ]
> +import argparse
> +from ctypes import CDLL, c_char_p, c_int, c_void_p, c_ubyte
> +import os
> +import struct
> +import sys
> +from typing import Any, Dict, Optional
> +import perf
> +
> +# Need to access PostgreSQL C library directly to use COPY FROM STDIN
> +try:
> +    libpq =3D CDLL("libpq.so.5")

Is hardcoding "libpq.so.5" strictly required here?

On systems where the PostgreSQL client library uses a different naming
convention (e.g., libpq.so or libpq.so.6), this might fail to load.
Could we use ctypes.util.find_library('pq') to locate the library
dynamically?

[ ... ]
> +    def copy_output_file(self, f, table_name: str):
> +        """Copy intermediate file to database."""
> +        f.seek(0)
> +        sql =3D f"COPY {table_name} FROM STDIN (FORMAT 'binary')"
> +        res =3D PQexec(self.conn, toserverstr(sql))
> +        if PQresultStatus(res) !=3D 4:  # PGRES_COPY_IN
> +            PQclear(res)
> +            raise RuntimeError(f"COPY FROM STDIN PQexec failed for {tabl=
e_name}")
> +        PQclear(res)
> +
> +        f.seek(0)
> +        data =3D f.read(65536)
> +        while len(data) > 0:
> +            c_data =3D (c_ubyte * len(data)).from_buffer_copy(data)
> +            ret =3D PQputCopyData(self.conn, c_data, len(data))
> +            if ret !=3D 1:
> +                raise RuntimeError(f"PQputCopyData failed for {table_nam=
e}")
> +            data =3D f.read(65536)
> +
> +        ret =3D PQputCopyEnd(self.conn, None)
> +        if ret !=3D 1:
> +            raise RuntimeError(f"PQputCopyEnd failed for {table_name}")

After calling PQputCopyEnd(), is it necessary to call PQgetResult() until
it returns NULL?

The libpq C-API requires clearing the PGRES_COMMAND_OK status of the COPY
command. Failing to do so might leave the database connection in a busy
state, causing the next PQexec call (e.g., copying the next table) to fail
with an "another command is already in progress" error.

[ ... ]
> +    def setup_db(self) -> None:
> +        """Create database and tables. MUST be called after init."""
> +        os.mkdir(self.output_dir_name)
> +
> +        self.connect('postgres')
> +        try:
> +            self.do_query(f"CREATE DATABASE {self.dbname}")

Will this query fail if the user provides a database name with hyphens
(e.g., -o my-perf-data)?

PostgreSQL usually requires double-quoted identifiers for hyphens. This mig=
ht
break functionality for common naming conventions or expose the script to
SQL injection.

[ ... ]
> +        self.files['evsel'] =3D self.open_output_file("evsel_table.bin")
> +        self.files['machine'] =3D self.open_output_file("machine_table.b=
in")
> +        self.files['thread'] =3D self.open_output_file("thread_table.bin=
")
> +        self.files['comm'] =3D self.open_output_file("comm_table.bin")
> +        self.files['comm_thread'] =3D self.open_output_file("comm_thread=
_table.bin")
> +        self.files['dso'] =3D self.open_output_file("dso_table.bin")
> +        self.files['symbol'] =3D self.open_output_file("symbol_table.bin=
")
> +        self.files['branch_type'] =3D self.open_output_file("branch_type=
_table.bin")

The script initializes a binary file for the branch_types table, but is the=
re
logic to populate it?

It appears the table is completely unpopulated. Will queries relying on
joining against branch_types to map branch names consistently return NULL?

[ ... ]
> +    def write_sample(self, sample_id: int, evsel_id: int, thread_id: int,
> +                      comm_id: int, dso_id: int, symbol_id: int,
> +                      sample: perf.sample_event, call_path_id: int) -> N=
one:
> +        """Write sample to binary file."""
> +        value =3D struct.pack(
> +            "!hiqiqiqiqiqiqiqiqiqiqiiiqiqiqiqiqiqiqiqiiiBiqiqiqii",
> +            25, 8, sample_id, 8, evsel_id, 8, 0, 8, thread_id, 8, comm_i=
d,
> +            8, dso_id, 8, symbol_id, 8, getattr(sample, 'sym_offset', 0),
> +            8, sample.ip, 8, sample.time, 4, sample.cpu,
> +            8, 0, 8, 0, 8, 0, 8, 0,
> +            getattr(sample, 'period', 0),
> +            getattr(sample, 'weight', 0),
> +            getattr(sample, 'transaction_', 0),
> +            getattr(sample, 'data_src', 0),
> +            0,
> +            getattr(sample, 'in_tx', 0),
> +            call_path_id,
> +            getattr(sample, 'insn_count', 0),
> +            getattr(sample, 'cyc_count', 0),
> +            4, getattr(sample, 'flags', 0)
> +        )

Does this struct.pack format string match the number of provided arguments?

The format string requires 51 arguments to properly serialize the data into
PostgreSQL's binary COPY format, but starting around the period attribute,
the length prefix arguments seem to be omitted. Since only 42 arguments are
provided, won't this unconditionally raise a struct.error exception on the
first processed event?

[ ... ]
> +    def get_comm_id(self, comm: str, thread_id: int) -> int:
> +        """Get or create comm ID."""
> +        if comm in self.caches['comms']:
> +            return self.caches['comms'][comm]
> +        comm_id =3D self.next_id['comm']
> +        self.write_comm(comm_id, comm, thread_id, 0, 0)
> +        self.write_comm_thread(comm_id, comm_id, thread_id)
> +        self.caches['comms'][comm] =3D comm_id
> +        self.next_id['comm'] +=3D 1
> +        return comm_id

If a second thread executes the same command name, the cache lookup succeeds
and bypasses the write_comm_thread() call. Does this mean no comm_thread
relationship is written for the new thread?

This might silently omit associations for any thread that happens to share a
command name with an earlier thread.

[ ... ]
> +    def finalize(self) -> None:
> +        """Copy files to database and add keys/views."""
> +        print("Copying to database...")
> +        for name, f in self.files.items():
> +            self.close_output_file(f)
> +            table_name =3D name + "s" if name !=3D "call_path" else "cal=
l_paths"
> +            if name =3D=3D "evsel":
> +                table_name =3D "selected_events"
> +            self.copy_output_file(f, table_name)

Here finalize() calls self.close_output_file(f) which closes the file, and
then immediately passes it to self.copy_output_file().

Since copy_output_file() attempts to execute f.seek(0) and f.read(65536),
will this raise a ValueError for attempting I/O operations on a closed file?

[ ... ]
> +if __name__ =3D=3D "__main__":
> +    ap =3D argparse.ArgumentParser(
> +        description=3D"Export perf data to a postgresql database")
> +    ap.add_argument("-i", "--input", default=3D"perf.data",
> +                    help=3D"Input file name")
> +    ap.add_argument("-o", "--output", required=3DTrue,
> +                    help=3D"Output database name")
> +    args =3D ap.parse_args()
> +
> +    exporter =3D PostgresExporter(args.output)
> +    exporter.setup_db()
> +
> +    session =3D None
> +    try:
> +        session =3D perf.session(perf.data(args.input),
> +                               sample=3Dexporter.process_event)
> +        exporter.session =3D session
> +        session.process_events()
> +        exporter.finalize()
> +        print(f"Successfully exported to {args.output}")
> +    except Exception as e:
> +        print(f"Error processing events: {e}")
> +    finally:
> +        exporter.disconnect()

If an exception occurs during setup_db() or process_events(), the finalize()
method is bypassed.

Could this leak the temporary directory and binary trace files, causing
subsequent runs to fail with a FileExistsError on os.mkdir()?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260419235911.2186=
050-1-irogers@google.com?part=3D37
