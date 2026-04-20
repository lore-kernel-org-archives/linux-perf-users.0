Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1BCE199D8
	for <linux-perf-users@vger.kernel.org>; Mon, 20 Apr 2026 00:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776645224; cv=none; b=B0fgTYmWROAYX5qztB77yDRW2WgSg2v9eUfKCEM1UQatf3xBLEHO9rKog8noVy8olc29pjyl4ti2ZEklixspyFhg9VTz4YPtDfSdjVdz/LEeMmPA6n4J1Q/xioKFpmqXzcO8d08+/QW5XYyOol195uthwNKVbGUF+sIY3ge7cXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776645224; c=relaxed/simple;
	bh=gm65kIHZNqYB2xgnjPk/9DETD8aTibSw9c0Ul+sz2Ms=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=awcDENho9M8wDywBpRXtZnYAXSwGqqwD7oa0ZpX51n/OfVnknzLrvOH7BQVyfcCoI12ZGL1CMDuUJyXQo8G1KkFXUEjnBypMuklgq8Z2CIqAb3KDKcSR2RNj7wqznsKSWg7SkEvm2hGEMKnO2v1RV3tz0NtRqPfg9s+rbA6461E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bSUtn4ZT; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bSUtn4ZT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29786C2BCAF;
	Mon, 20 Apr 2026 00:33:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776645224;
	bh=gm65kIHZNqYB2xgnjPk/9DETD8aTibSw9c0Ul+sz2Ms=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=bSUtn4ZT+0EDEX/MSfUAouH9kGeavbZyu0n4tMhvdc/W4uSvdRPp2ERzJdGSYI8JJ
	 C5p+EmAcdLsYilhweht8U8oSHRBuLan2RRY58f281+cKW5LEWQGrQzaonu3nNhp14J
	 78dUi8QbX0V6GVr10ngV4c55X+u4J+U4bSHWVAWYcGUOUPsG/cuYN4xycLX0SrnL6h
	 RnVk5+bxr1WdZy25Z3dqmpbU3X1fEXO6WrYf4wzU7nDGx5ye58LlUhEIjIJLTAPszi
	 n4E+lDUjSp9iYcXM1EEm6b/d8sKR0sAZqgseKOMuiGNHWVT/UIjr4SIhy9wMaPO6b/
	 hHgOKfdmzSSOg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 36/58] perf export-to-sqlite: Port export-to-sqlite
 to use python module
Reply-To: sashiko@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260419235911.2186050-37-irogers@google.com>
References: <20260419235911.2186050-37-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 20 Apr 2026 00:33:43 +0000
Message-Id: <20260420003344.29786C2BCAF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Sashiko AI review found 8 potential issue(s):
- [Critical] AttributeError crash on `sample.ip`, `sample.time`, and `sampl=
e.cpu` access.
- [High] Silent data loss of branch destinations, periods, and weights.
- [High] Missing SQL views breaking downstream tools and documentation.
- [High] Regression in support for power management events, calls, and cont=
ext switches.
- [Medium] `evsel` event names are improperly formatted with 'evsel()' pref=
ix.
- [Medium] `getattr` fallback behavior results in `NULL` database values fo=
r `dso` and `symbol`.
- [Low] Database file removed before connection is closed during error hand=
ling.
- [Low] Time-of-Check to Time-of-Use (TOCTOU) race condition when checking =
for existing database.
--

commit f1bba9aa8219f55def547da60006157b32630634
Author: Ian Rogers <irogers@google.com>

perf export-to-sqlite: Port export-to-sqlite to use python module
   =20
This commit ports the export-to-sqlite script to use the modern perf Python
module API and the standard library sqlite3. It implements lazy population
of lookup tables and adds callchain support.

> diff --git a/tools/perf/python/export-to-sqlite.py b/tools/perf/python/ex=
port-to-sqlite.py
> new file mode 100755
> index 0000000000000..ec39c1b1e04b3
> --- /dev/null
> +++ b/tools/perf/python/export-to-sqlite.py
> @@ -0,0 +1,351 @@
> +#!/usr/bin/env python3
> +# SPDX-License-Identifier: GPL-2.0
> +"""
[ ... ]
> +	$ sqlite3 pt_example
> +	sqlite> .header on
> +	sqlite> select * from samples_view where id < 10;

Is this example still valid? The script no longer contains CREATE VIEW
statements for samples_view, which might break downstream tools like
exported-sql-viewer.py that rely on these views to function.

Also, this script appears to drop support for tracking call and return
elapsed times, context switches, and power management events like ptwrite
or cbr. Are these features planned for a future follow-up?

[ ... ]
> +    def process_event(self, sample: perf.sample_event) -> None:
> +        """Callback for processing events."""
> +        thread_id =3D self.get_thread_id(sample.sample_pid, sample.sampl=
e_tid)
[ ... ]
> +        dso_id =3D self.get_dso_id(
> +            getattr(sample, 'dso', "Unknown_dso"),
> +            getattr(sample, 'dso_long_name', "Unknown_dso_long"),
> +            getattr(sample, 'dso_bid', "")
> +        )

Does this fallback logic work as expected? If pyrf_sample_event__get_dso
returns None instead of raising an AttributeError, getattr will return
None rather than the Unknown_dso string. This could lead to inserting
NULL into the database instead of the expected textual fallback.

[ ... ]
> +        # Insert sample
> +        self.con.execute("""
> +            INSERT INTO samples VALUES (
> +                NULL, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?,=
 ?, ?, ?, ?, ?, ?, ?
> +            )
> +        """, (
> +            self.get_event_id(str(sample.evsel)), 0, thread_id, comm_id,

Will str(sample.evsel) record the event name accurately? The string
representation of an evsel object typically returns a formatted string
like evsel(cycles). Should this use sample.evsel.name instead?

> +            dso_id, symbol_id, getattr(sample, 'sym_offset', 0),
> +            sample.ip, sample.time, sample.cpu,

Can accessing sample.ip, sample.time, and sample.cpu raise an AttributeError
here? The perf Python API exposes these properties with a sample_ prefix,
such as sample_ip, sample_time, and sample_cpu.

> +            0, 0, 0, 0,  # to_dso, to_symbol, to_sym_offset, to_ip
> +            getattr(sample, 'period', 0),
> +            getattr(sample, 'weight', 0),
> +            getattr(sample, 'transaction_', 0),
> +            getattr(sample, 'data_src', 0),
> +            0,  # branch_type

Does this logic intentionally drop branch destination fields and branch_type
by hardcoding them to 0? This might break hardware branch tracing use-cases
like Intel PT.

Additionally, will getattr(sample, 'period', 0) and getattr(sample,
'weight', 0) successfully retrieve the period and weight? The underlying
C-extension attributes are named sample_period and sample_weight, which
means getattr might silently fall back to 0 and lose this data.

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
> +    if os.path.exists(args.output):
> +        print(f"Error: {args.output} already exists")
> +        sys.exit(1)
> +
> +    exporter =3D DatabaseExporter(args.output)

Is there a race condition here between checking if the file exists and
creating the database connection? If a symbolic link is created at the
output path right after the check, it might be followed during
initialization.

[ ... ]
> +    except Exception as e:
> +        print(f"Error processing events: {e}")
> +        if os.path.exists(args.output):
> +            os.remove(args.output)
> +    finally:
> +        exporter.close()

Can removing the database file before calling exporter.close() cause issues?
Deleting the main SQLite database file while the connection is still active
could lead to permissions errors on some operating systems or leave behind
dangling auxiliary files like rollback journals.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260419235911.2186=
050-1-irogers@google.com?part=3D36
