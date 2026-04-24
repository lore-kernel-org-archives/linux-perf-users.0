Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D13AA2D780E
	for <linux-perf-users@vger.kernel.org>; Fri, 24 Apr 2026 17:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777051041; cv=none; b=chBobCT+lQVGfcJy6eM+hB0cDKCTnCC67IV+aLLCpvvVIjljHTIZ76s0uEdzIi1WLHaajyVxWj/JHaQ8T5b4JrO58Rk8kaduOJsgdNDr5kAEAkW4F3LggtELrUFCAIsut1smEfx7DfHXClAhlJz3yHzvNlInzbdYKsHE5mdQass=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777051041; c=relaxed/simple;
	bh=BCvKTs/hVaEPMURKYg/ZKPvljTrZFveVh3TIVHWZmSg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=EtQgjU3XG55k6QrylCcu+G7aGvraKWRF341nJWOSxSQ7yUDfLjfZGmltpmOVnEBGG5836akVCsUl+JCwfTPEng2gZuB8MkC/jLJkGkaxghiZDDJgbw61nvDMV4exq3JoEmUFnnHThJFfNbaeV9h0aQ19FyJNrzN8lIDu41i61J0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M6ndEPhp; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M6ndEPhp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E347C2BCB5;
	Fri, 24 Apr 2026 17:17:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777051041;
	bh=BCvKTs/hVaEPMURKYg/ZKPvljTrZFveVh3TIVHWZmSg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=M6ndEPhpZG+Axnd8xEXfp7h25wFAxnVgEy+C2xKiUttQ3s5TIvZaRLl4+jxCLZhfO
	 Cwkyl+IHgFY9mTm9FVCQRz8Rs0eZWK4dInbnYNBTkS/oJUYKlXQ7TPqIaR6Y4n5yv1
	 u+39fSia2Oe2TAE+DeBOe6Kzb7P7PMxtABRoa4xXoOhJRvQBqmeQ8xc7SVTWQxlgpn
	 pVekQbkW67PtWchEGUbYweRc5RkY7MFCUxVkunfEsJ/9uDYM1frBCxkgX+SmcZ6qjs
	 y0WX0ZG69QXtvZGHj71qvPQE8a1y9eHBdu1TVfENBE3LL50fI7tXLt+c6WPSjv8J4Y
	 R48i8qgq0s3lg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 36/58] perf export-to-sqlite: Port export-to-sqlite
 to use python module
Reply-To: sashiko@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260424164721.2229025-37-irogers@google.com>
References: <20260424164721.2229025-37-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 24 Apr 2026 17:17:20 +0000
Message-Id: <20260424171721.9E347C2BCB5@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Sashiko AI review found 6 potential issue(s):
- [High] The script silently drops sample data by querying incorrect or non=
-existent attributes from the perf.sample_event python object.
- [High] Callchain DSO and symbol names are unconditionally recorded as 'Un=
known_dso' and 'Unknown_symbol' due to improper attribute lookup on strings.
- [High] Insufficient cache keys for DB entities (`comms`, `dsos`, `symbols=
`) cause erroneous merging of distinct objects, leading to schema corruptio=
n and data loss.
- [High] The `process_id` in the `threads` table is incorrectly populated w=
ith the OS `pid` instead of the database primary key `id` of the main threa=
d, breaking relational joins.
- [Medium] The ported script drops support for branch samples, hardcoding b=
ranch targets and branch types to 0.
- [Medium] The attempt to fix a TOCTOU race condition when creating the dat=
abase file merely shifts the race window, leaving the script vulnerable to =
symlink attacks if run in an untrusted directory.
--

commit 3639169c4ea864d5644c2a97081aef058020783f
Author: Ian Rogers <irogers@google.com>

perf export-to-sqlite: Port export-to-sqlite to use python module

This commit ports the export-to-sqlite.py script to use the modern perf
Python module and the standard library sqlite3 module. It drops the
dependency on PySide2.QtSql.

> diff --git a/tools/perf/python/export-to-sqlite.py b/tools/perf/python/ex=
port-to-sqlite.py
> new file mode 100755
> index 00000000000000..a662b4f22cdb98
> --- /dev/null
> +++ b/tools/perf/python/export-to-sqlite.py

[ ... ]

> +    def get_thread_id(self, pid: int, tid: int) -> int:
> +        """Get or create thread ID."""
> +        key =3D (pid, tid)
> +        if key in self.caches['threads']:
> +            return self.caches['threads'][key]
> +        thread_id =3D self.next_id['thread']
> +        self.con.execute("INSERT INTO threads VALUES (?, ?, ?, ?, ?)",
> +                         (thread_id, 0, pid, pid, tid))

Are we inserting the OS pid into the process_id column here?

Looking at the database schema, the process_id column acts as a foreign key
pointing to the database-generated id of the process's main thread, not the
OS pid.

Since the auto-increment id space does not intersect with the OS pid
space, will this break downstream queries that attempt to group threads by
joining process_id =3D threads.id?

> +        self.caches['threads'][key] =3D thread_id
> +        self.next_id['thread'] +=3D 1
> +        return thread_id
> +
> +    def get_comm_id(self, comm: str, thread_id: int) -> int:
> +        """Get or create comm ID."""
> +        if comm in self.caches['comms']:
> +            return self.caches['comms'][comm]

Does caching exclusively by the command string cause relational data loss f=
or
comm_threads?

When multiple distinct threads execute the same command string, the cache
will return a hit for the first thread's comm_id.

This bypasses the INSERT INTO comm_threads execution for all subsequent
threads, omitting them from the comm_threads table entirely.

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

Does using only short_name as the cache key risk discarding the long_name
and build_id?

If a DSO is first encountered during a callchain traversal where those
fields are missing, future lookups for the same short_name will return
the cached ID without updating the database with the missing fields.

> +        dso_id =3D self.next_id['dso']
> +        self.con.execute("INSERT INTO dsos VALUES (?, ?, ?, ?, ?)",
> +                         (dso_id, 0, short_name, long_name, build_id))
> +        self.caches['dsos'][short_name] =3D dso_id
> +        self.next_id['dso'] +=3D 1
> +        return dso_id

[ ... ]

> +    def process_event(self, sample: perf.sample_event) -> None:
> +        """Callback for processing events."""

[ ... ]

> +        # Handle callchain
> +        call_path_id =3D 0
> +        if hasattr(sample, 'callchain') and sample.callchain:
> +            parent_id =3D 0
> +            for node in sample.callchain:
> +                node_dso =3D getattr(node, 'dso', None) or getattr(node,=
 'map', None)
> +                node_symbol =3D getattr(node, 'symbol', None) or getattr=
(node, 'sym', None)
> +
> +                dso_name =3D "Unknown_dso"
> +                if node_dso:
> +                    dso_name =3D getattr(node_dso, 'name', "Unknown_dso"=
) or "Unknown_dso"
> +
> +                symbol_name =3D "Unknown_symbol"
> +                if node_symbol:
> +                    symbol_name =3D getattr(node_symbol, 'name', "Unknow=
n_symbol") or "Unknown_symbol"

Will this result in callchain entries always being recorded as 'Unknown_dso'
and 'Unknown_symbol'?

In the perf Python API, pyrf_callchain_node__get_dso and
pyrf_callchain_node__get_symbol return Python strings, not objects.

Since Python strings do not have a name attribute, the getattr() calls here
will always fail and default to the unknown strings.

> +
> +                node_dso_id =3D self.get_dso_id(dso_name, dso_name, "")
> +                node_symbol_id =3D self.get_symbol_id(node_dso_id, symbo=
l_name, 0, 0)
> +
> +                parent_id =3D self.get_call_path_id(parent_id, node_symb=
ol_id, node.ip)
> +            call_path_id =3D parent_id
> +        else:
> +            call_path_id =3D 0
> +
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
> +            getattr(sample, 'sample_period', 0) or 0,
> +            getattr(sample, 'sample_weight', 0) or 0,
> +            getattr(sample, 'transaction_', 0),
> +            getattr(sample, 'data_src', 0),
> +            0,  # branch_type
> +            getattr(sample, 'in_tx', 0),
> +            call_path_id,
> +            getattr(sample, 'insn_count', 0),
> +            getattr(sample, 'cyc_count', 0),
> +            getattr(sample, 'flags', 0)
> +        ))

Are we querying the correct attributes from the perf.sample_event object?

The perf Python C-extension exposes these attributes with a sample_ prefix,
such as sample_insn_count, sample_cyc_count, and sample_data_src.

Because getattr(sample, 'insn_count', 0) and similar calls omit the prefix,
they will silently return the default value of 0. Furthermore, fields like
sym_offset, transaction_, in_tx, and flags are not exposed by the API at al=
l,
which might lead to silent loss of critical performance metrics and
transaction data.

Additionally, does this hardcoding drop support for branch samples?

The legacy script extracted branch data elements, but here the to_dso,
to_symbol, to_sym_offset, to_ip, and branch_type fields are hardcoded to 0.
The perf Python API exposes sample.brstack via pyrf_sample_event__get_brsta=
ck,
but it appears to be ignored here, which might break downstream branch trac=
ing
visualization.

> +
> +        self.sample_count +=3D 1
> +        if self.sample_count % 10000 =3D=3D 0:
> +            self.commit()

[ ... ]

> +if __name__ =3D=3D "__main__":
> +    ap =3D argparse.ArgumentParser(
> +        description=3D"Export perf data to a sqlite3 database")
> +    ap.add_argument("-i", "--input", default=3D"perf.data",
> +                    help=3D"Input file name")
> +    ap.add_argument("-o", "--output", default=3D"perf.db",
> +                    help=3D"Output database name")
> +    args =3D ap.parse_args()
> +
> +    try:
> +        fd =3D os.open(args.output, os.O_CREAT | os.O_EXCL | os.O_WRONLY)
> +        os.close(fd)
> +    except FileExistsError:
> +        print(f"Error: {args.output} already exists")
> +        sys.exit(1)
> +
> +    exporter =3D DatabaseExporter(args.output)

Is there a race condition between closing the file and opening the database?

The script safely creates the file with os.open(..., O_CREAT | O_EXCL) but
immediately closes the file descriptor.

It then delegates the database connection to sqlite3.connect() via the
DatabaseExporter constructor, which re-opens the file by path and follows
symlinks.

If executed in a shared directory like /tmp, could an attacker delete the
newly created file and replace it with a symlink before the connect() runs,
causing the SQLite initialization queries to overwrite the target file?

> +
> +    session =3D None
> +    error_occurred =3D False

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260424164721.2229=
025-1-irogers@google.com?part=3D36
