Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 959F0314D26
	for <linux-perf-users@vger.kernel.org>; Sat, 25 Apr 2026 23:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777158804; cv=none; b=Uul3UNOA3uIY8tmOHDC6ao3n1NNTFcgt1dAD0Bi9qJwBN3VNz0tgfLCrokVlo5J4BqHCsjeCCQAyjy44NHBt6P5BvlySLGRJdadfubWOoSockjAvC/sdC2EOxnoyZeX13qkpKJ+KLHtyoi/qtkNk7B0z8dA70+7nloA4H1FMeF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777158804; c=relaxed/simple;
	bh=x6HjfdQNtnHjl1onvRUhG4u59qkwrkDgKYrnafecGBw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=otTl+DmzblkRfq7dQoBGIvtDOtHw8KRPYBMtOST+sknkkLVef28zJPGHnQ4v8uyz1eIXt1uNVLbANRj1yVZWCbhKgraLMwgwTkoAv1hNdA3hRCni8sS4EUadKVp6p3sj7yNuvfLJvti2s7NwYYtK2VS+fSvl+1SamWZSlfURwZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UvEOImzc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UvEOImzc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6443BC2BCB0;
	Sat, 25 Apr 2026 23:13:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777158804;
	bh=x6HjfdQNtnHjl1onvRUhG4u59qkwrkDgKYrnafecGBw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=UvEOImzcoN+X/HkogWZzL1M9oOfoKMkbu8+JYRJEzAMW+PydyljrGne3suy76+Aiq
	 YgfcXVyCr4RrjQn2drVHzOr3uiRSsfz5NOsk8V6bLHtvr9NSzBMJDu5Tqz4S4dw+v8
	 8lY71nWPhR6PhYrehyCg1OJiQ5bNc481Uwl0vBWr4l+HUXNcx/N1M9Yl7fpg3b6Llc
	 Y0haC95O/xCGvoir5+Ub4dA/Pf29E5edZizcrItMsVGm6u80cQBefWAc+hlE1ighbO
	 SC9xA4WqGY3oDas0xUao/M8VP7a0GuAFKyvppsydRXc/BchUm7uuveDOD2SHPL8D8C
	 98GuhfWRbDlHg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 37/59] perf export-to-postgresql: Port
 export-to-postgresql to use python module
Reply-To: sashiko@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260425224951.174663-38-irogers@google.com>
References: <20260425224951.174663-38-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 25 Apr 2026 23:13:23 +0000
Message-Id: <20260425231324.6443BC2BCB0@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Sashiko AI review found 9 potential issue(s):
- [High] The script silently exports 0 for many critical sample fields due =
to incorrect attribute names and ignoring branch stacks.
- [High] The call path tree constructed for PostgreSQL is structurally inve=
rted, placing leaf functions at the root.
- [High] The script silently ignores the final result status of the Postgre=
SQL COPY FROM STDIN command, leading to silent data loss.
- [High] Using the 'q' (signed 64-bit integer) format character in struct.p=
ack for 64-bit memory addresses crashes the exporter on kernel samples.
- [High] The script completely drops the logic for exporting synthetic Inte=
l PT events and context switches, despite advertising Intel PT support.
- [Medium] String values are packed dynamically without length validation, =
leading to brittle behavior and database import failures.
- [Medium] The ported script drops all database foreign key constraints tha=
t were present in the original implementation.
- [Medium] The `comm_threads_view` view is documented in the file header bu=
t is never created.
- [Low] Exceptions in setup_db() bypass cleanup logic, leaving temporary di=
rectories on disk.
--

commit 6da42dc06630d58ef6cdd8bf94f7bec7384e8f74
Author: Ian Rogers <irogers@google.com>

perf export-to-postgresql: Port export-to-postgresql to use python module
   =20
Ported from tools/perf/scripts/python/export-to-postgresql.py to use
the perf Python module API.

> diff --git a/tools/perf/python/export-to-postgresql.py b/tools/perf/pytho=
n/export-to-postgresql.py
> new file mode 100755
> index 000000000000..0118dc348b1e
> --- /dev/null
> +++ b/tools/perf/python/export-to-postgresql.py
> @@ -0,0 +1,701 @@
> +#!/usr/bin/env python3
> +# SPDX-License-Identifier: GPL-2.0
> +r"""
> +Export perf data to a postgresql database.

[ ... ]

> +An example of using this script with Intel PT:
> +
> +	$ perf record -e intel_pt//u ls
> +	$ python tools/perf/python/export-to-postgresql.py -i perf.data -o pt_e=
xample

Does this script still support exporting synthetic Intel PT events and cont=
ext
switches? The docstring advertises an example with Intel PT, but the logic
and table schemas for ptwrite, cbr, mwait, pwre, exstop, pwrx, and
context_switches appear to be missing.

[ ... ]

> +Views:
> +
> +	Most of the tables have views for more friendly display. The views are:
> +
> +		comm_threads_view

This isn't a bug, but comm_threads_view is listed in the views documentation
here, but doesn't seem to be created in finalize().

[ ... ]

> +    def copy_output_file(self, path_name: str, table_name: str):
> +        """Copy intermediate file to database."""
> +        sql =3D f"COPY {table_name} FROM STDIN (FORMAT 'binary')"
> +        res =3D PQexec(self.conn, toserverstr(sql))

[ ... ]

> +        res =3D PQgetResult(self.conn)
> +        while res:
> +            PQclear(res)
> +            res =3D PQgetResult(self.conn)

Does this loop silently ignore the final result status of the PostgreSQL CO=
PY
command?

If PostgreSQL rejects the data due to a constraint violation, PQgetResult()
yields PGRES_FATAL_ERROR, but this loop clears the result without inspecting
PQresultStatus(), potentially masking silent data loss.

[ ... ]

> +    def write_comm(self, comm_id: int, comm_str: str, thread_id: int,
> +                   time: int, exec_flag: int) -> None:
> +        """Write comm to binary file."""
> +        comm_bytes =3D toserverstr(comm_str)
> +        n =3D len(comm_bytes)
> +        fmt =3D "!hiqi" + str(n) + "s" + "iqiqiB"
> +        value =3D struct.pack(fmt, 5, 8, comm_id, n, comm_bytes, 8,
> +                            thread_id, 8, time, 1, exec_flag)
> +        self.files['comm'].write(value)

Are the dynamically packed strings validated against the database schema
limits?

The comms table defines comm as varchar(16), but unbounded strings are pack=
ed
here. If a string exceeds the limit, will PostgreSQL abort the COPY FROM ST=
DIN
command?

[ ... ]

> +    def write_symbol(self, symbol_id: int, dso_id: int, sym_start: int,
> +                      sym_end: int, binding: int, symbol_name: str) -> N=
one:
> +        """Write symbol to binary file."""
> +        name_bytes =3D toserverstr(symbol_name)
> +        n =3D len(name_bytes)
> +        fmt =3D "!hiqiqiqiqiii" + str(n) + "s"
> +        value =3D struct.pack(fmt, 6, 8, symbol_id, 8, dso_id, 8,
> +                            sym_start, 8, sym_end, 4, binding, n, name_b=
ytes)
> +        self.files['symbol'].write(value)

Will using the 'q' (signed 64-bit integer) format character in struct.pack
crash the exporter when processing kernel-space instruction pointers?

Since kernel addresses can exceed the maximum positive value of a signed
64-bit integer, should the 'Q' (unsigned 64-bit) specifier be used instead?

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
> +            8, sample.sample_ip, 8, sample.sample_time, 4, sample.sample=
_cpu,
> +            8, 0, 8, 0, 8, 0, 8, 0,
> +            8, getattr(sample, 'sample_period', 0) or 0,
> +            8, getattr(sample, 'sample_weight', 0) or 0,
> +            8, getattr(sample, 'transaction_', 0) or 0,
> +            8, getattr(sample, 'data_src', 0) or 0,
> +            4, 0,
> +            1, getattr(sample, 'in_tx', 0) or 0,
> +            8, call_path_id,
> +            8, getattr(sample, 'insn_count', 0) or 0,
> +            8, getattr(sample, 'cyc_count', 0) or 0,
> +            4, getattr(sample, 'flags', 0) or 0
> +        )
> +        self.files['sample'].write(value)

Are the attribute names for the sample fields correct, and are branch targe=
ts
being handled?

The fields data_src, insn_count, and cyc_count differ from the actual
sample_data_src, sample_insn_count, and sample_cyc_count names. Additionall=
y,
the branch target fields (to_ip, to_dso_id, to_symbol_id, to_sym_offset) are
hardcoded to 0 instead of being extracted from sample.brstack.

Will this result in missing sample fields being silently exported as zeroes?

[ ... ]

> +    def process_event(self, sample: perf.sample_event) -> None:
> +        """Callback for processing events."""

[ ... ]

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
> +
> +                node_dso_id =3D self.get_dso_id(dso_name, dso_name, "")
> +                node_symbol_id =3D self.get_symbol_id(node_dso_id, symbo=
l_name, 0, 0)
> +
> +                parent_id =3D self.get_call_path_id(parent_id, node_symb=
ol_id, node.ip)
> +            call_path_id =3D parent_id

Is the call path tree constructed upside-down here?

By iterating sequentially over sample.callchain (from index 0 upwards) and
using the newly generated ID as the parent_id for the next frame, the caller
becomes a child of the callee. Should this be iterating in reverse to
properly build parent-child aggregation?

[ ... ]

> +    def finalize(self) -> None:
> +        """Copy files to database and add keys/views."""

[ ... ]

> +        print("Adding primary keys")
> +        self.do_query("ALTER TABLE selected_events ADD PRIMARY KEY (id)")
> +        self.do_query("ALTER TABLE machines        ADD PRIMARY KEY (id)")
> +        self.do_query("ALTER TABLE threads         ADD PRIMARY KEY (id)")
> +        self.do_query("ALTER TABLE comms           ADD PRIMARY KEY (id)")
> +        self.do_query("ALTER TABLE comm_threads    ADD PRIMARY KEY (id)")
> +        self.do_query("ALTER TABLE dsos            ADD PRIMARY KEY (id)")
> +        self.do_query("ALTER TABLE symbols         ADD PRIMARY KEY (id)")
> +        self.do_query("ALTER TABLE branch_types    ADD PRIMARY KEY (id)")
> +        self.do_query("ALTER TABLE samples         ADD PRIMARY KEY (id)")
> +        self.do_query("ALTER TABLE call_paths      ADD PRIMARY KEY (id)")

This isn't a bug, but were the foreign key constraints from the original
implementation intentionally dropped?

The previous script enforced relational integrity by adding foreign keys at
the end of the export, which seem to be missing here.

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
> +    error_occurred =3D False
> +    try:

Could exceptions in setup_db() bypass the cleanup logic?

If setup_db() fails, the script will terminate immediately without executing
the finally block, which might leave orphaned temporary directories on the
filesystem.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260425224951.1746=
63-1-irogers@google.com?part=3D37
