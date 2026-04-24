Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 225F033E355
	for <linux-perf-users@vger.kernel.org>; Fri, 24 Apr 2026 17:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777050672; cv=none; b=SNxLNBqMCzE9rL2gRfrATwBOWNQ4RWJGqKKE90EICTifWnq3DmBzSV26nZhnKgC+JsK3FzBP0qKER9Me6zJX1yhmLFsUHpAXsipSHMs3YrWcOZrUPXYGI4rS3uduBjIL/EQM8eci7LdvdQy6U0hsyGg1AHDbyFPTiWrlsuUEmS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777050672; c=relaxed/simple;
	bh=hqxDbQr6gNVCNTexinEB5C5AKMkAXBRL7cwHJc/3h70=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=BgQSXgjBfM+8cBbV9g+nXBjwm4KSXwkjF7JhHhMdgxbgrZJKrWleL3R+AM0gJMdGJCNiehX52cFf+IUd7e1ICYMXpcDTzDUT2HDrZv/6yqNFPH2Vl3fHQQBEcXVHf3embDnUiQvN+7mVhHDWDWoLbfdiR8oE+lAlHLuT6farFK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i0u6OGDK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i0u6OGDK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FAE0C19425;
	Fri, 24 Apr 2026 17:11:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777050671;
	bh=hqxDbQr6gNVCNTexinEB5C5AKMkAXBRL7cwHJc/3h70=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=i0u6OGDKx8nO8lbvX13eYbzJ2Yffz+i2WjEjOiI6nIzsaws1Ogq3KsJ8WZPoNs/Bb
	 B2CvQUBMZt061elY8ZDdcdzJaCuxmkNvm7ojnJMg999TtK+dvE8SlImIl7V6f/4jJD
	 JmZ61apiIKgmaOydlpP87LjHiEhgcNbSuETXHyfnpTnvei1TuVfXH+pvPqp1CA6noV
	 0AYN2yeNlEp9+APkF9pRcQXLuaAc5s0IBeTpLsGtPKpvTja7hKpqDw94w4+T38HL//
	 efyhBzfWzHsaA98Yw7SBvfLTBfocF5E+gY/uByIeEcazxZGIhYj+vkQU4gkRRl0jcu
	 now4ot6MJcfWw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 37/58] perf export-to-postgresql: Port
 export-to-postgresql to use python module
Reply-To: sashiko@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260424164721.2229025-38-irogers@google.com>
References: <20260424164721.2229025-38-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 24 Apr 2026 17:11:10 +0000
Message-Id: <20260424171111.9FAE0C19425@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Sashiko AI review found 5 potential issue(s):
- [High] Missing binary COPY file trailer causes PostgreSQL to reject the d=
ata, and silent error swallowing results in an empty database.
- [High] Incorrect ID assignment generates duplicate primary keys for the `=
comm_threads` table, causing database constraint violations.
- [Medium] Branch target and control flow data fields are hardcoded to 0, b=
reaking Intel PT trace analysis.
- [Medium] Exceptions during database setup bypass the cleanup handlers, le=
aking temporary directories and connections.
- [Low] The script uses the exact same ID sequence counter for both samples=
 and events.
--

commit ad2eda7d63401a755d355f71742fd43ef19eb5de
Author: Ian Rogers <irogers@google.com>

perf export-to-postgresql: Port export-to-postgresql to use python module

Ported from tools/perf/scripts/python/export-to-postgresql.py to use
the perf Python module API.

diff --git a/tools/perf/python/export-to-postgresql.py b/tools/perf/python/=
export-to-postgresql.py
new file mode 100755
index 00000000000000..d1fa87e1d2b1a2
--- /dev/null
+++ b/tools/perf/python/export-to-postgresql.py
@@ -0,0 +1,697 @@
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

Does PQgetResult need to check PQresultStatus here? It looks like if a
database error occurs during the copy operation, it would be silently
ignored.

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

Are the branch-related fields meant to be zeroed out here?

The commit message mentions using this script with Intel PT, but it
looks like the target branch data fields are currently hardcoded to 0.
Would this prevent proper analysis of Intel PT traces?

> +            8, getattr(sample, 'sample_period', 0) or 0,
> +            8, getattr(sample, 'sample_weight', 0) or 0,
[ ... ]
> +    def get_comm_id(self, comm: str, thread_id: int) -> int:
> +        """Get or create comm ID."""
[ ... ]
> +        key =3D (comm_id, thread_id)
> +        if 'comm_threads' not in self.caches:
> +            self.caches['comm_threads'] =3D {}
> +        if key not in self.caches['comm_threads']:
> +            self.write_comm_thread(comm_id, comm_id, thread_id)

When calling write_comm_thread, is the first parameter intended to be
comm_id?

Looking at write_comm_thread, the first parameter is comm_thread_id. If
comm_id is passed as the primary key here, threads that share the same
command might create rows with duplicate IDs. Could this cause a constraint
violation when the primary key is added later?

> +            self.caches['comm_threads'][key] =3D True
> +
> +        return comm_id
[ ... ]
> +    def process_event(self, sample: perf.sample_event) -> None:
> +        """Callback for processing events."""
[ ... ]
> +        sample_id =3D self.next_id['event']

Should this use a separate counter for sample IDs instead of
self.next_id['event']? Because get_event_id also increments
self.next_id['event'], this might unintentionally interleave the IDs
for samples and events.

> +        self.write_sample(sample_id,
> +                          self.get_event_id(getattr(sample.evsel, 'name'=
, str(sample.evsel))),
> +                          thread_id, comm_id, dso_id, symbol_id, sample,
> +                          call_path_id)
> +        self.next_id['event'] +=3D 1
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

Is it intentional to call copy_output_file before close_output_file?

Looking at close_output_file, it writes the mandatory PostgreSQL binary
trailer to the file. If copy_output_file streams the data to the database
first, won't the stream lack the EOF marker and cause PostgreSQL to abort
the copy command?

> +
> +        print("Removing intermediate files...")
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

If an exception occurs during setup_db (for example, if the database
already exists), does the script terminate immediately and bypass the
cleanup in the finally block?

It looks like this might leave orphaned temporary directories on the
disk since the try/finally block starts after setup_db.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260424164721.2229=
025-1-irogers@google.com?part=3D37
