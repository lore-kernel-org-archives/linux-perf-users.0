Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 089D214EC73
	for <linux-perf-users@vger.kernel.org>; Thu, 23 Apr 2026 04:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776917973; cv=none; b=qPc/U3XGDvKNc9yScYtSn1In+y9nJ6ACXC28/AaqG4Ib+sefQGYgGMmGSu/OuGDiDi5I15HXR/B+8LUcyIQX9NtKqB2q7hEQQWzMbcpnFdBT0Ywwm2A1sW9HvYg669kKLtyimzbwetzUwJdsYtrTb6H1VyOv7QB8XDaFgd2GESE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776917973; c=relaxed/simple;
	bh=Zy1cbTkQkQr0Z7xgr3p7BRhw6xuyuCh+1NNiwE20OHE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=e2HDhTiyxKjMcOhkP+PkBpXFniWrme1TYtuagn3hOEoi9mlax3wjNJc1j1l2ESV8J9T3NXCE15yuUJlecC9QExxv1g776dHvMfEZid4kunAkc07lrs0nEwwDWCLbSWKft2iJ857XkP6Cf5tMo40MA6RVDFzOkDdpI0q4YNfdIGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CdsYfsst; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CdsYfsst"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B9C2C2BCB2;
	Thu, 23 Apr 2026 04:19:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776917972;
	bh=Zy1cbTkQkQr0Z7xgr3p7BRhw6xuyuCh+1NNiwE20OHE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=CdsYfsstT5tFPM/5VC4kix4FAFUp+yfBRVmgSNWgsjWONSw1O8SYVXNC5jN0+eWQi
	 Ebofl3A5R7sQMQMjai2OtUsc6xxAdcJNIR/3PtcSznDRPk/eBTMHyXgRQNqG3a+g3a
	 W6wr9d03+N0AeoJ9BNMmEfIXq3YOD5rlWFY0n3kGKtLM3h+FDZVwu9twPC9l/cqqN1
	 +2ptLssaIMDPN9SmBIao4z6l2sydPpu4/AN2M/k8DYvGB+ILl2manmERwwuNR+7O/r
	 T+oKnuWkeLdynQnk8ArFhSI1yutFw/V1SI8kMrMLvQ5cunX8zW30bRcABdCjrOuQez
	 AZlwB3Ps1aTYA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 37/58] perf export-to-postgresql: Port
 export-to-postgresql to use python module
Reply-To: sashiko@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260423035526.1537178-38-irogers@google.com>
References: <20260423035526.1537178-38-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 23 Apr 2026 04:19:31 +0000
Message-Id: <20260423041932.8B9C2C2BCB2@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Sashiko AI review found 6 potential issue(s):
- [High] PostgreSQL COPY protocol violation due to missing binary trailer, =
resulting in data loss.
- [High] Silently masked PostgreSQL COPY failures.
- [High] Duplicate primary key generation for the `comm_threads` table.
- [Medium] Temporary directory leak on database initialization failure.
- [Medium] Incomplete implementation of `branch_types` table export.
- [Medium] Unsafe interpolation of database name leads to SQL and connectio=
n string injection.
--

commit f5bfc358753eb33c314fe5abffcb60f3ba6c4a00
Author: Ian Rogers <irogers@google.com>

perf export-to-postgresql: Port export-to-postgresql to use python module

This commit ports the export-to-postgresql script to use the perf Python
module API and libpq via ctypes, removing the PySide2 dependency. It keeps
the high performance binary file generation but implements lazy population
of lookup tables.

> diff --git a/tools/perf/python/export-to-postgresql.py b/tools/perf/pytho=
n/export-to-postgresql.py
> new file mode 100755
> index 0000000000000..d1fa87e1d2b1a
> --- /dev/null
> +++ b/tools/perf/python/export-to-postgresql.py
> @@ -0,0 +1,697 @@
[ ... ]
> +    def connect(self, db_to_use: str) -> None:
> +        """Connect to database."""
> +        conn_str =3D toclientstr(f"dbname =3D {db_to_use}")
> +        self.conn =3D PQconnectdb(conn_str)

Is it possible for a specially crafted database name to inject arbitrary
libpq connection parameters here?

[ ... ]
> +    def setup_db(self) -> None:
> +        """Create database and tables. MUST be called after init."""
> +        os.mkdir(self.output_dir_name)
> +
> +        self.connect('postgres')
> +        try:
> +            self.do_query(f'CREATE DATABASE "{self.dbname}"')

Could a crafted -o argument break out of these double quotes to execute
arbitrary SQL against the default database?

[ ... ]
> +        self.files['symbol'] =3D self.open_output_file("symbol_table.bin=
")
> +        self.files['branch_type'] =3D self.open_output_file("branch_type=
_table.bin")
> +        self.files['sample'] =3D self.open_output_file("sample_table.bin=
")
> +        self.files['call_path'] =3D self.open_output_file("call_path_tab=
le.bin")
> +
> +        self.write_evsel(0, "unknown")
> +        self.write_machine(0, 0, "unknown")
> +        self.write_thread(0, 0, 0, -1, -1)
> +        self.write_comm(0, "unknown", 0, 0, 0)
> +        self.write_dso(0, 0, "unknown", "unknown", "")
> +        self.write_symbol(0, 0, 0, 0, 0, "unknown")
> +        self.write_call_path(0, 0, 0, 0)

Is the branch_type_table.bin file ever populated?

It appears there is no write_branch_type method implemented, which means
the branch_types table will remain completely empty.

[ ... ]
> +    def copy_output_file(self, f, table_name: str):
> +        """Copy intermediate file to database."""
[ ... ]
> +        ret =3D PQputCopyEnd(self.conn, None)
> +        if ret !=3D 1:
> +            raise RuntimeError(f"PQputCopyEnd failed for {table_name}")
> +
> +        res =3D PQgetResult(self.conn)
> +        while res:
> +            PQclear(res)
> +            res =3D PQgetResult(self.conn)

Does this loop silently mask PostgreSQL server-side insertion failures?

If a COPY command fails on the server due to type mismatches or constraint
violations, PQresultStatus(res) would contain an error. Since the result
status is not checked before clearing, the script could leave the tables
empty while reporting a successful export.

[ ... ]
> +    def get_comm_id(self, comm: str, thread_id: int) -> int:
> +        """Get or create comm ID."""
> +        if comm in self.caches['comms']:
> +            comm_id =3D self.caches['comms'][comm]
> +        else:
> +            comm_id =3D self.next_id['comm']
> +            self.write_comm(comm_id, comm, thread_id, 0, 0)
> +            self.caches['comms'][comm] =3D comm_id
> +            self.next_id['comm'] +=3D 1
> +
> +        key =3D (comm_id, thread_id)
> +        if 'comm_threads' not in self.caches:
> +            self.caches['comm_threads'] =3D {}
> +        if key not in self.caches['comm_threads']:
> +            self.write_comm_thread(comm_id, comm_id, thread_id)

Does this use comm_id as the primary key for the comm_threads table?

If multiple threads share the same comm string, get_comm_id will pass the
same comm_id as the comm_thread_id parameter to write_comm_thread(). This
would result in multiple rows with identical IDs, causing a duplicate key
constraint violation when finalize() adds the primary key.

[ ... ]
> +    def finalize(self) -> None:
> +        """Copy files to database and add keys/views."""
> +        print("Copying to database...")
> +        for name, f in self.files.items():
> +            table_name =3D name + "s" if name !=3D "call_path" else "cal=
l_paths"
> +            if name =3D=3D "evsel":
> +                table_name =3D "selected_events"
> +            self.copy_output_file(f, table_name)
> +            self.close_output_file(f)

Could this cause a PostgreSQL COPY protocol violation resulting in data los=
s?

copy_output_file() reads the file up to EOF and streams it to the server.
However, close_output_file() appends the mandatory binary format trailer
(\377\377) to the file.

Since the trailer is written after the file has already been streamed, the
server will never receive it, which causes it to abort the COPY operation
and discard the inserted data.

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
> +        session =3D perf.session(perf.data(args.input),

If setup_db() raises an exception, will it leak the temporary data director=
y?

setup_db() creates the directory, but because it is called before the
try...finally block, an early failure (such as a database connection error)
will bypass the cleanup logic in the finally block and leave the directory
on the filesystem.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260423035526.1537=
178-1-irogers@google.com?part=3D37
