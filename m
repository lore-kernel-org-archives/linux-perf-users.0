Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 530BB30C164
	for <linux-perf-users@vger.kernel.org>; Sun, 20 Sep 2026 05:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789883191; cv=none; b=tlhLodEhU16FxBrwhW4lTrntdJJU6QKrvIbqrydbK4ezMzhJaA36uy5YXEtLaJwT24XGDgEH+DEwipknvVeKUzssC3b9/73uGDlWHkhCA+vNcsejvtFyLaPiRRhSLXhQ6gmk8l5KY8inM4j1MPW9+UwrpM4kNGIwvT7gP3KmKRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789883191; c=relaxed/simple;
	bh=GB4NOBNtK44T46anYTmLF0GVTBUwvFbZnxbKAHCuc/c=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=bhI30MfIwx7WKfanV4ZxVx6jT6NCwLRsps2VDvpsa2WNdcX0nC1Qo4qugka03u/9yhsi+MMOjVxsHwrW5AHdC0dZyBmXhdWanw4YLXO2ULmLPQVBvEROr2by7U071C8OvDnncq+Rp04go8nja6IbLErlsyqOIgCq1JeP2FlLt8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VaKCf4Sa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VaKCf4Sa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE8D81F000FF;
	Sun, 20 Sep 2026 05:46:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789883188;
	bh=Yyw1hKox/3pJRitEXQ4vWabJNxawoG4jGNVyzgoxjbw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=VaKCf4SaphqAe1SSPcqcGrnUCN/ak+jKM3Nzb9ocpiZBxonutzSGCWzDiiAhHeiGp
	 E6LfalAQP6Lzl2zYDH+MNx5obmQc6M8wlWGkp0xul9z0q8pQT588dOVhdx5KOceQPQ
	 4MUTOhjB+++anerNO6uqFraVY1OIzX1oBzM6lkZ2Bf8GSUddfqaVfxLcnOoVT9EO3q
	 CykW11eK/Ki1qzOnwLqPKE0ixs3nLRozX0iSjbHHeHVpx53EgzMtigkqmBytsInWoF
	 InlXjv1K7rN3g6J9mpJTfqIOF4k6D8ltIWhSkDoGUxNPdS+i59iHS6zp+XfRHgjRvM
	 w17PySmRz0cHg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 42/49] perf python: Port export-to-sqlite to perf
 module
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <1658c569d58e088619fda50e89f750d43ad15968.1789880842.git.irogers@google.com>
References: <cover.1789880842.git.irogers@google.com>
 <1658c569d58e088619fda50e89f750d43ad15968.1789880842.git.irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 20 Sep 2026 05:46:28 +0000
Message-Id: <20260920054628.BE8D81F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [Medium] perf: empty branch_types table breaks exported-sql-viewer.py joi=
ns
- [Medium] perf: missing SQL indexes on calls table causes severe UI perfor=
mance regression
- [Low] perf: omitted has_calls column in comms table degrades UI filtering
--

commit a80e324a7b5b00cd92bb49c8ff407245a5f07096
Author: Ian Rogers <irogers@google.com>

perf python: Port export-to-sqlite to perf module
   =20
Port export-to-sqlite.py to a standalone script in tools/perf/python/
using the perf module and Python's standard library sqlite3 module.

> diff --git a/tools/perf/python/export-to-sqlite.py b/tools/perf/python/ex=
port-to-sqlite.py
> new file mode 100755
> index 0000000000000..34a4840b42df5
> --- /dev/null
> +++ b/tools/perf/python/export-to-sqlite.py
[ ... ]
> +    def create_tables(self) -> None:
> +        """Create database tables."""
[ ... ]
> +        self.con.execute("""
> +            CREATE TABLE IF NOT EXISTS comms (
> +                    id      INTEGER         NOT NULL        PRIMARY KEY,
> +                    comm    VARCHAR(16),
> +                    c_thread_id BIGINT,
> +                    c_time  BIGINT,
> +                    exec_flag BOOLEAN)
> +        """)

[Severity: Low]
Is the has_calls column missing here? The schema definition lacks the
has_calls boolean column, and the subsequent ALTER TABLE and UPDATE steps to
backfill this filtering metadata are also omitted.

Will this cause the UI viewer to be unable to filter out commands that have
no recorded calls, leading to a cluttered interface?

[ ... ]
> +        self.con.execute("""
> +            CREATE TABLE IF NOT EXISTS branch_types (
> +                    id      INTEGER         NOT NULL        PRIMARY KEY,
> +                    name    VARCHAR(80))
> +        """)

[Severity: Medium]
Does this table need to be populated with default branch types? Leaving it =
as
an empty dimension table appears to break subsequent SQL joins.

For instance, when exporting perf data with branch information and opening =
it,
will the UI viewer exported-sql-viewer.py fail to display branch data becau=
se
it relies on an INNER JOIN branch_types clause which yields zero rows?

[ ... ]
> +    def commit(self) -> None:
> +        """Commit transaction."""
> +        self.con.commit()

[Severity: Medium]
Are we missing the creation of SQL indexes on the calls table here? The
ported script omits the CREATE INDEX pcpid_idx ON calls (parent_call_path_i=
d)
and CREATE INDEX pid_idx ON calls (parent_id) steps that were present in
the legacy version.

Without these indexes, will the exported-sql-viewer.py interface experience
severe lag and timeouts because expanding call paths requires full table sc=
ans
on the calls table?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1789880842.gi=
t.irogers@google.com?part=3D42
