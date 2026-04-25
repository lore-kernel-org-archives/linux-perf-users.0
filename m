Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CFD136897E
	for <linux-perf-users@vger.kernel.org>; Sat, 25 Apr 2026 18:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777140764; cv=none; b=Tlt3h3P7ISfHVqtDUHeXYKCbSI2x+PaOlh7sevszBHSEOvphElzdT4QDn/hhiqWdCRkCAi42++RmyajItPNXfVgoHo1+JIJu842WfFwjFuKiOjhZfkCmwgjL8qpCpdgLs3GrESxqtECTQaBTSFK+kHtbMzXTDr++K2pSXHjUWHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777140764; c=relaxed/simple;
	bh=hJ4Yw8M32b+tgMlLStL/ObRoC7BU7Kd21hGxrczmLjI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=uAoo1n4kjWiLpJtQUFbFd1v2laiNe51+or50MbWr1mEPFX+rCEIw/eb/sh7sbaLiWC7lQIE2u/kVggtYzzDkiZFxhqJjhJnnshGo7XBrY8CHQrizDyKSmCOrdr3rT3dmXWhFKKI9PFt4cTIwpnAndUVqq5pslJ4tmQZNTqP9Lqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G7TkbGHk; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G7TkbGHk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2B99C2BCB0;
	Sat, 25 Apr 2026 18:12:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777140764;
	bh=hJ4Yw8M32b+tgMlLStL/ObRoC7BU7Kd21hGxrczmLjI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=G7TkbGHkyRFWbaOL/RdDIoidLFP70cF85esCkiP3lOrwNCEMPsZEdFfiq/IOPh9kq
	 GrdNxLZjLxXh14vn614mA/t1QrvKr+qnnH5b7UYd/QpCFIDCT/N7kOg/Y06qsv46zc
	 zkT1sJnxmV32rfNisT8eQI6vP2OBVIC1mNkXjTpPpwOx5NpJe6BvHpgZQhW6ZajHwy
	 9/IF/+0yMy8O/Pa47YgTjT93SX1gI0TTseDIayFpQeyGUvF32KNoYgZThLO5hqUh3W
	 QEbKbx58ymc0NYk/O/zkQC99qf0Nv8GgFHcLfRLceigdHPjOrOjCOTKAZIsfWUh4qN
	 ulQ0caNlfcHxw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 37/59] perf export-to-postgresql: Port
 export-to-postgresql to use python module
Reply-To: sashiko@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260425174858.3922152-38-irogers@google.com>
References: <20260425174858.3922152-38-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 25 Apr 2026 18:12:43 +0000
Message-Id: <20260425181243.F2B99C2BCB0@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Sashiko AI review found 7 potential issue(s):
- [High] Critical branch target metrics hardcoded to zero and branch_types =
table empty.
- [High] Missing Ported Features causing data loss.
- [High] ctypes Type Error causes immediate runtime crash when writing to D=
B.
- [High] KeyboardInterrupt permanently leaks massive intermediate directori=
es.
- [High] DSOs are incorrectly cached using only short_name.
- [Medium] setup_db() exceptions permanently leak the intermediate director=
y.
- [Medium] Script exits with code 0 on failure, breaking automated tools.
--

commit 530a5874e47c51699eb3a71fb80415e9c17f6d7e
Author: Ian Rogers <irogers@google.com>

perf export-to-postgresql: Port export-to-postgresql to use python module

This commit ports the export-to-postgresql.py script to use the modern perf
Python module API instead of PySide2 and QtSql. It relies on libpq via ctyp=
es
and exports the perf data to a local PostgreSQL database.

> diff --git a/tools/perf/python/export-to-postgresql.py b/tools/perf/pytho=
n/export-to-postgresql.py
> new file mode 100755
> index 000000000000..0118dc348b1e
> --- /dev/null
> +++ b/tools/perf/python/export-to-postgresql.py

[ ... ]

> +	symbols
> +		'symbols' contains a record for each symbol. Only symbols that
> +		have samples are present.
> +
> +	threads
> +		'threads' contains a record for each thread.
> +
> +Views:

The original QtSql-based script exported several specialized tables like
calls, context_switches, ptwrite, mwait, cbr, pwre, exstop, and pwrx.

Will omitting the parsing and export of these tables break downstream
scripts like exported-sql-viewer.py that might rely on them?

[ ... ]

> +    def copy_output_file(self, path_name: str, table_name: str):
> +        """Copy intermediate file to database."""
> +        sql =3D f"COPY {table_name} FROM STDIN (FORMAT 'binary')"
> +        res =3D PQexec(self.conn, toserverstr(sql))
> +        if PQresultStatus(res) !=3D 4:  # PGRES_COPY_IN
> +            PQclear(res)
> +            raise RuntimeError(f"COPY FROM STDIN PQexec failed for {tabl=
e_name}")
> +        PQclear(res)
> +
> +        with open(path_name, "rb") as f:
> +            data =3D f.read(65536)
> +            while len(data) > 0:
> +                c_data =3D (c_ubyte * len(data)).from_buffer_copy(data)
> +                ret =3D PQputCopyData(self.conn, c_data, len(data))

PQputCopyData expects a c_void_p for the second argument. Is passing a
ctypes Array instance directly here going to raise a ctypes.ArgumentError?

Would we need to cast it or use ctypes.byref(c_data)?

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

Branch-related data such as to_dso_id, to_symbol_id, to_sym_offset, to_ip,
and branch_type appear to be hardcoded to 0 here instead of being extracted
from the sample event.

Are we silently dropping the branch stack data here?

Also, no data is written to branch_type_table.bin, leaving the branch_types
table completely empty.

[ ... ]

> +    def get_dso_id(self, short_name: str, long_name: str,
> +                   build_id: str) -> int:
> +        """Get or create DSO ID."""
> +        if short_name in self.caches['dsos']:
> +            return self.caches['dsos'][short_name]

Is it safe to cache DSOs using only their short_name? This might conflate
distinct libraries that share the same basename (like libc.so.6 from a host
vs. container).

Could this merge distinct executables into the same dso_id?

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

If exporter.setup_db() fails here (e.g. database connection error), the
script exits immediately.

Are we leaving the intermediate directory created by setup_db() orphaned
on the filesystem since the cleanup block below is never reached?

> +
> +    session =3D None
> +    error_occurred =3D False
> +    try:
> +        session =3D perf.session(perf.data(args.input),
> +                               sample=3Dexporter.process_event)
> +        exporter.session =3D session
> +        session.process_events()
> +        exporter.finalize()
> +        print(f"Successfully exported to {args.output}")
> +    except Exception as e:

Will this except clause miss catching KeyboardInterrupt (which inherits from
BaseException)?

If the user aborts with Ctrl+C, error_occurred would remain False, which
might prevent shutil.rmtree() from running and permanently leak the
intermediate directory.

Also, if an error is caught here, the script still exits with a status of 0.

Should the script return a non-zero exit code on failure to prevent breaking
automated tools or CI pipelines that rely on exit codes?

> +        print(f"Error processing events: {e}")
> +        error_occurred =3D True
> +    finally:
> +        exporter.disconnect()
> +        if error_occurred:
> +            if os.path.exists(exporter.output_dir_name):
> +                shutil.rmtree(exporter.output_dir_name)

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260425174858.3922=
152-1-irogers@google.com?part=3D37
