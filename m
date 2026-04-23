Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82D271AE877
	for <linux-perf-users@vger.kernel.org>; Thu, 23 Apr 2026 04:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776917833; cv=none; b=pd0UVcEzWaEClHtaY6wNQ17liRRnmQ+Gxy/siYeDJuhixgy4vKn+ofr2KDW4owjQwjGBDUSr6WceOoC0ut5/Nf85tYxefRrHP2fN7zT2PESU/L3KqSvE7UwHeGNGNXdOle7+WvNdHtppyRkIiZwU9xGqMLTLWH6NSOFQ4ZYSUks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776917833; c=relaxed/simple;
	bh=HzWeehaemsC4CEv4KFoDmza1gNhUte5RsZ15HmARmG8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=YI/C9UDcLgjaH4pHzscWkzTMGTB1UqA5Svlv7de/WicGHHbn61/fBppUBywb9tbxvszpt26OXqnyrQTmLqwIfr+DdGI8+6ni/j8qDl0M8jW35XVII5U6z/kp6Rbsw2vX4GWC1gfYmFhDBBZ8HCUQ9UQOlyiCxUxq6nhwgIGiYPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tay76a6P; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tay76a6P"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6792C2BCB2;
	Thu, 23 Apr 2026 04:17:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776917833;
	bh=HzWeehaemsC4CEv4KFoDmza1gNhUte5RsZ15HmARmG8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=Tay76a6P05y84AA8MGHDOjMPwX2ujXo2yTcfeWJJPFd5ura86q95vds3LLNzz48wI
	 4Bjz7fbrMlm3yXZcelLXRzEpxopdvYP0QqAqlTYbnk06fMXeKFmevqvhSpLublXNbb
	 xpOHjBuYww12kSD5UTUsVkOhjRJKXnA4tBWoMHU3Rt5YpCdDc9RvbjlFnZeNn8bJWb
	 t7JfM0ykFL3nVajN/sBt1zEaGzGS0okqEymZFEkfuxH04dvyz0pKTeht3KN9+8k7v4
	 gvCb/ouwV0097RpWLQ2Bp6J6ljSOV7goTNZhQ+79u1r5vfdc6TXqpNVbC05JoVXeMp
	 mN39wzPbqhehg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 36/58] perf export-to-sqlite: Port export-to-sqlite
 to use python module
Reply-To: sashiko@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260423035526.1537178-37-irogers@google.com>
References: <20260423035526.1537178-37-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 23 Apr 2026 04:17:12 +0000
Message-Id: <20260423041712.E6792C2BCB2@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Sashiko AI review found 7 potential issue(s):
- [High] Silent data loss due to incorrect Python API attribute access for =
sample metrics.
- [High] Complete loss of branch tracing data, severely breaking Intel PT e=
xport capabilities.
- [High] Inverted construction of the call path tree during callchain parsi=
ng.
- [High] Command-to-thread mappings are silently dropped for threads sharin=
g command names.
- [High] Callchain processing poisons the symbol cache with zeroed boundari=
es.
- [High] DSO caching by short name aliases distinct binaries, corrupting lo=
ng names and build IDs.
- [High] TOCTOU race condition in database file creation allows arbitrary f=
ile overwrite.
--

commit 51a807dd8fd1bd35b3c7aa76d6a4147ba7d86cc5
Author: Ian Rogers <irogers@google.com>
Subject: perf export-to-sqlite: Port export-to-sqlite to use python module

This commit ports the export-to-sqlite.py script to use the perf Python
module API and the standard library sqlite3 module. It implements lazy
population of lookup tables and adds callchain support.

> diff --git a/tools/perf/python/export-to-sqlite.py b/tools/perf/python/ex=
port-to-sqlite.py
> new file mode 100755
> index 0000000000000..a662b4f22cdb9
> --- /dev/null
> +++ b/tools/perf/python/export-to-sqlite.py

[ ... ]

> +    def get_comm_id(self, comm: str, thread_id: int) -> int:
> +        """Get or create comm ID."""
> +        if comm in self.caches['comms']:
> +            return self.caches['comms'][comm]

Is it intentional that the cache key for comms only uses the command string,
ignoring the thread_id?

If multiple threads share the same command name, the second thread will hit
the cache and receive the first thread's comm_id. This prevents insertion
into the comm_threads table for the second thread, dropping the association.

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

Does caching only by short_name cause aliasing if distinct shared objects
share the same short name?

If two distinct objects share a short name (e.g., libc.so.6), the first DSO
encountered will dictate the long_name and build_id for all subsequent
queries. Should the cache key include long_name or build_id to differentiate
them?

> +        dso_id =3D self.next_id['dso']
> +        self.con.execute("INSERT INTO dsos VALUES (?, ?, ?, ?, ?)",
> +                         (dso_id, 0, short_name, long_name, build_id))
> +        self.caches['dsos'][short_name] =3D dso_id
> +        self.next_id['dso'] +=3D 1
> +        return dso_id
> +
> +    def get_symbol_id(self, dso_id: int, name: str, start: int,
> +                      end: int) -> int:
> +        """Get or create symbol ID."""
> +        key =3D (dso_id, name)
> +        if key in self.caches['symbols']:
> +            return self.caches['symbols'][key]

Will this cache key lead to missing symbol boundaries?

When processing callchains below, this is called with start and end as 0. If
the same symbol is later encountered as a primary sample target with real
boundaries, the cache hit will prevent the real boundaries from being store=
d.

> +        symbol_id =3D self.next_id['symbol']
> +        self.con.execute("INSERT INTO symbols VALUES (?, ?, ?, ?, ?, ?)",
> +                         (symbol_id, dso_id, start, end, 0, name))
> +        self.caches['symbols'][key] =3D symbol_id
> +        self.next_id['symbol'] +=3D 1
> +        return symbol_id

[ ... ]

> +        # Handle callchain
> +        call_path_id =3D 0
> +        if hasattr(sample, 'callchain') and sample.callchain:
> +            parent_id =3D 0
> +            for node in sample.callchain:

Does this loop construct the call tree inverted?

The perf Python module yields callchain frames from the innermost frame
(current instruction) outward. Because parent_id is assigned sequentially, =
the
innermost frame becomes the root, and the outermost frame becomes a deep le=
af.

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

Does this drop branch tracking information needed for Intel PT analysis?

The branch destination columns and branch_type are hardcoded to 0 instead of
extracting the data from sample.brstack.

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

Will these getattr calls silently return 0 and cause data loss for the samp=
le
metrics?

The perf Python module exposes the metrics as sample_data_src,
sample_insn_cnt, and sample_cyc_cnt, rather than data_src, insn_count, and
cyc_count. Additionally, transaction_, in_tx, and flags do not appear to be
exposed by the Python API at all.

> +        ))

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

Can an attacker exploit a time-of-check to time-of-use race here if the
database is created in a shared directory like /tmp?

The script securely creates the file with O_CREAT | O_EXCL to prevent
overwriting existing files, but immediately closes the file descriptor.

DatabaseExporter then calls sqlite3.connect(), which resolves the path again
by name. Between the close and the connect, the file could be deleted and
replaced with a symlink to a sensitive file, defeating the O_EXCL protectio=
n.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260423035526.1537=
178-1-irogers@google.com?part=3D36
