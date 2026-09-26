Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D918838DC54
	for <linux-perf-users@vger.kernel.org>; Sat, 26 Sep 2026 06:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790404477; cv=none; b=FCbZxeQn3mgsJ43EN5fCoLISy+6HF3Dy3E6p9u7a5fgIQwF3fyI3/fwAYNBHAeCXZug1/FjjD6d2LAtQpiCXj6KP8Tp6FzwJKmDI8KGeEqMC8bBA9bzn2Wt4uM3oW7JN4dilIVMAoUDpMnLv3i17FqY/ZCPR8vbPiifKpGN+4mk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790404477; c=relaxed/simple;
	bh=osF/61HNLQadUD/S9dV7++jYkelZgxmzpF2Yxo23qS0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=moRxRQpIxDobjZXvQy7JG5iCS5F79HylM5RzVB+vT4k/PRVKiDjakPLB1LNJ16T/tjzMqc3QmJIaWlt/DOeeeipemBvhOxsLoE8RXxNOMXNES2KBfbOkvTo8XjugaXEE6xD9QkasTHefo3MgsU6PaS37uSM71YMdajkE0eVRnfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZTjG/Yx1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZTjG/Yx1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FDD21F000FF;
	Sat, 26 Sep 2026 06:34:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790404475;
	bh=kaaUzGubZ7RF2NmrRt1mILdG+fcrgzX1jtk2stKej8E=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ZTjG/Yx13ngVZcJoVPwbNcuZZTJLcgCguV8nrPs/xkZ0x49p2wxgcCywN9IOIDcsR
	 GHtxdIgPOWKkFD7Cem3Uh3OMMePNfMA+Y1gNbN9OTwbEbMfQj3w8GJo+w+wgqIe/lA
	 SSQfftUS12UKO+kHY2jUEc14G++GsrLYBkA0yEAJSxCGWuP9Nm3vESQ94FPu3Xg2yK
	 XDXmyEYAuO9DByFkCDuo9pkyPXvE0+/N7nL+3Mvkc7FRzr11RIHYNrhJ0J31ln86zV
	 xVkFceAwZGvjLTs00+S47FWo1Po8n+elT2FTqpCg1m4kIB4NbZL1HhgNBJ6DPFQe9j
	 jv7+l4lC/FXyA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 21/49] perf python: Port event_analyzing_sample to
 perf module
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260926062029.800743-22-irogers@google.com>
References: <20260923181213.3032038-1-irogers@google.com>
 <20260926062029.800743-1-irogers@google.com>
 <20260926062029.800743-22-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 26 Sep 2026 06:34:35 +0000
Message-Id: <20260926063435.5FDD21F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] perf python: SQLite journal symlink attack via shared temp directo=
ry
--

commit 69d795499ff20d3b762362308ad4405d0fa32d19
Author: Ian Rogers <irogers@google.com>

perf python: Port event_analyzing_sample to perf module

This commit ports the event_analyzing_sample.py script to a standalone scri=
pt
using the perf module and standard library sqlite3. It adds database
encapsulation and argparse options, while removing Python 2 compatibility
and adding type annotations.

> diff --git a/tools/perf/python/event_analyzing_sample.py b/tools/perf/pyt=
hon/event_analyzing_sample.py
> new file mode 100755
> index 0000000000000..15b47cff9fa30
> --- /dev/null
> +++ b/tools/perf/python/event_analyzing_sample.py

[ ... ]

> +def trace_begin(db_path: str | None =3D None) -> None:
> +    """Initialize database tables."""
> +    print("In trace_begin:\n")
> +    if not db_path:
> +        fd, db_path =3D tempfile.mkstemp(prefix=3D"perf_events_", suffix=
=3D".db")
> +        os.close(fd)
> +        _DB.temp_path =3D db_path
> +    con =3D sqlite3.connect(db_path)

[Severity: High]
Can this sequence open a race window for symlink attacks via SQLite journal
files?

When tempfile.mkstemp() creates the main database file in the shared /tmp
directory, it doesn't reserve paths for SQLite's auxiliary sidecar files
like -journal or -wal.

If a local attacker monitors /tmp and observes the newly created base filen=
ame,
could they immediately create a symlink for the -journal file pointing to an
arbitrary target before sqlite3.connect() writes to it?

If a privileged user runs the script without specifying a database path,
would SQLite follow the symlink and clobber the target file when writing
to the journal?

Would it be better to use tempfile.mkdtemp() to create a secure private
directory for the database (similar to export-to-sqlite.py)?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260926062029.8007=
43-1-irogers@google.com?part=3D21
