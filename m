Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6D5C36682A
	for <linux-perf-users@vger.kernel.org>; Sat, 25 Apr 2026 18:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777140726; cv=none; b=rkzLsIRNw6UIIoP4FrvI1JUrdLN6pIdoDzwBt3n5OOUYMkKsq09ItHq++BoRWLXQJ0LpspQgMXhjZX2rJBZVTOXnxvO5CFD4pgqsZoZRYQhlQHIc/6avUKTpYjc9rKknJLHMYgNkH5OdKUAo2CmCq8aNd1TM+UI8uvgTcOkIROE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777140726; c=relaxed/simple;
	bh=itrT/+PCSljrYC1mS0a9BKegi3AzW9f11TONH01IZJI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=e3b8/zzTFTbuGey6yWWe7k0X+6470s9ku+KgPsmHGPk6QRzEJ15h7Mr8N56oY9PgblBa5D+1A3S080H+9trWCJVBs6icBoq+Fw9Wiq40wiAiQRTLsrCXXf9Aq+4Pxfvg/iExprN4WSc+w0tJJeBGGQbEl9mKce/hmZkbukCpbx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JrUdgXBb; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JrUdgXBb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99A1EC2BCB0;
	Sat, 25 Apr 2026 18:12:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777140726;
	bh=itrT/+PCSljrYC1mS0a9BKegi3AzW9f11TONH01IZJI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=JrUdgXBbwTnW2U9G2VxWr42bVJS/mYkSEA+WkO0oQuu5kdu/ULnKTg4v3mXDbHXjC
	 qCpNDngJWlGfiTd2tufWupAJcoVVj8gQdDVVf2zDcG6teuwPG9O5PorupBBiZ2Mafa
	 GbMf934cXdeQtpYeOAaJol0KGd/RCS8b2E632deJkS7YThQ1UoGnnIkrG92XoH0T3l
	 s+ik9sUfGh0Q2DYT854LiBt/1Rk9n1uiOoN7HyctdIUU5t156yiN5CP5EPcncuFnV2
	 RC49vEo0s2QkHzqAytwRghvIkRY8D4CmiUVigzhxq3p0V9UdgU2BqkIJoG4+ATra4X
	 HElFhZVwDNqwQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 36/59] perf export-to-sqlite: Port export-to-sqlite
 to use python module
Reply-To: sashiko@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260425174858.3922152-37-irogers@google.com>
References: <20260425174858.3922152-37-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 25 Apr 2026 18:12:06 +0000
Message-Id: <20260425181206.99A1EC2BCB0@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Sashiko AI review found 4 potential issue(s):
- [Critical] Runtime Crash / Integer Overflow on kernel addresses.
- [High] Silent Data Loss / Incorrect Attribute Names for Sample Metrics.
- [High] Silent Data Loss / Missing API Surface.
- [High] Feature Regression / Hardcoded Data for Branch Stack.
--

commit 0c8124c5cad0e09d1363bee787c58324149c0896
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

Are sym_offset, transaction_, in_tx, and flags actually exposed by the perf
python module? It looks like they might be missing from the
pyrf_sample_event__members definition, which would cause getattr() to
silently return 0.

> +            sample.sample_ip, sample.sample_time, sample.sample_cpu,

SQLite enforces a 64-bit signed integer limit for its INTEGER type. Will th=
is
cause an OverflowError if sample.sample_ip contains a kernel address (which
often has the high bit set, making it too large for a signed 64-bit integer=
)?

> +            0, 0, 0, 0,  # to_dso, to_symbol, to_sym_offset, to_ip

It looks like branch stack data is now completely hardcoded to 0. Does this
code skip processing the sample.brstack property, dropping branch analysis
data from the database?

> +            getattr(sample, 'sample_period', 0) or 0,
> +            getattr(sample, 'sample_weight', 0) or 0,
> +            getattr(sample, 'transaction_', 0),
> +            getattr(sample, 'data_src', 0),
> +            0,  # branch_type
> +            getattr(sample, 'in_tx', 0),
> +            call_path_id,
> +            getattr(sample, 'insn_count', 0),
> +            getattr(sample, 'cyc_count', 0),

Are the property names correct for data_src, insn_count, and cyc_count?

Looking at tools/perf/util/python.c, it seems these should be prefixed with
sample_ (e.g., sample_data_src, sample_insn_count, sample_cyc_count).

Without the prefix, won't getattr() silently fall back to 0?

> +            getattr(sample, 'flags', 0)
> +        ))

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260425174858.3922=
152-1-irogers@google.com?part=3D36
