Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7FEF1BC08F
	for <linux-perf-users@vger.kernel.org>; Mon, 20 Apr 2026 00:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776645327; cv=none; b=kD5G+VlrRGmfcqzW+zqKseVxF4L5FoirMeZLHGKcOKwn7tO9PAj+BVcilA+pIo9MT3aZdstNiflJ0Q8A21HNZ9ghk30CrLiLP0eL5jshIQlJ2MFSFgXi6kLwezGT/7pw++e8+yyla0/JIqTSEs3vSvbx7zeXyZS6DZXkh/F7I5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776645327; c=relaxed/simple;
	bh=nraB065AbdlIXU9gvUwshgx9dqWvmP2LByXO6X24d8E=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=K9Xb+rJK1+04N4RTZz2QqXxydkTDzsvgvjas0UU9Z8KRL212k3n1q2/PQJH+H1z2/WvBmNODob7qippCYfPxpn3bPWHSSLfuYUFWavfID5EGlr3Jz9r4z1JtDNi8piWPck8VZ4t+yY4wOT94hwjptEooh8qKbVaoqgTO4TfCLpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X4paf+ZR; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X4paf+ZR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34A2FC2BCAF;
	Mon, 20 Apr 2026 00:35:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776645327;
	bh=nraB065AbdlIXU9gvUwshgx9dqWvmP2LByXO6X24d8E=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=X4paf+ZRjlVDHuYfo258S7zr3ypl7MvYjbwU2EkgjFC9d9xDyHf433HCQjFAJYDkm
	 heUEVYeO189VCErj7TEnLGkn0cC8O9JBeP7aDa/JVXWc2xWDgazzoHTiiME9QmSm2E
	 mSD6zOzlEQL6KrZeONvvZ8fhft9KOkcYD+HbZNRVBBY2TGnA+ntRJcSCQ8By5jGxOe
	 kMOwQ8rpZJcu9oVTKhsvqReMDEHUhDt+mTqX8zP0p4A9jkyNI/WhLuomTLSWJAIref
	 p/8KC2Kkf44He0IHynnsu/TZhukIrO8kxwKvFntroR7Jl9yoaydxyjmfmKbVtEnnPB
	 dBWmz8uzBj3BQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 35/58] perf event_analyzing_sample: Port
 event_analyzing_sample to use python module
Reply-To: sashiko@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260419235911.2186050-36-irogers@google.com>
References: <20260419235911.2186050-36-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 20 Apr 2026 00:35:26 +0000
Message-Id: <20260420003527.34A2FC2BCAF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Sashiko AI review found 3 potential issue(s):
- [Critical] The script uses a hardcoded, predictable file path in a shared=
, world-writable directory (`/dev/shm/perf.db`), exposing a symlink attack =
vulnerability.
- [Medium] Event names in the database are wrapped in 'evsel(...)', alterin=
g the expected output and breaking compatibility.
- [Medium] Thread command name (comm) resolution fails or returns incorrect=
 values for sub-threads.
--

commit 3f169dabd50cb00496ff1c84ac713efcfbc9dee4
Author: Ian Rogers <irogers@google.com>

perf event_analyzing_sample: Port event_analyzing_sample to use python modu=
le

This commit adds a port of the event_analyzing_sample script to use the
perf python module directly. It aims to improve performance by avoiding
the creation of intermediate dictionaries for all event fields.

> diff --git a/tools/perf/python/event_analyzing_sample.py b/tools/perf/pyt=
hon/event_analyzing_sample.py
> new file mode 100755
> index 0000000000000..f437ea25c0db5
> --- /dev/null
> +++ b/tools/perf/python/event_analyzing_sample.py
> @@ -0,0 +1,291 @@

[ ... ]

> +session: Any =3D None
> +
> +# Database connection
> +# If the perf.data has a big number of samples, then the insert operation
> +# will be very time consuming (about 10+ minutes for 10000 samples) if t=
he
> +# .db database is on disk. Move the .db file to RAM based FS to speedup
> +# the handling, which will cut the time down to several seconds.
> +DB_PATH =3D "/dev/shm/perf.db" if os.path.exists("/dev/shm") else "perf.=
db"
> +con =3D sqlite3.connect(DB_PATH)

This was retained from the original script, but does this create a symlink
overwrite regression?

Since /dev/shm is world-writable, an unprivileged user could pre-create a
symlink at /dev/shm/perf.db pointing to an arbitrary system file. If a
privileged user runs this script, would sqlite3.connect() follow the symlink
and overwrite the target file?

[ ... ]

> +def process_event(sample: perf.sample_event) -> None:
> +    """Callback for processing events."""
> +    # Create and insert event object to a database so that user could
> +    # do more analysis with simple database commands.
> +
> +    # Resolve comm, symbol, dso
> +    comm =3D "Unknown_comm"
> +    try:
> +        if session is not None:
> +            proc =3D session.process(sample.sample_pid)

Does this code successfully resolve the command name for sub-threads?

Looking at the C extension's implementation, pyrf_session__process passes
the single sample_pid value to machine__find_thread() for both the pid and
tid arguments. This means it only finds the thread object if the TID equals
the PID.

Will this cause events originating from sub-threads to record the main
thread's comm or fail to resolve entirely, whereas the original callback
behavior resolved the specific sub-thread correctly?

> +            if proc:
> +                comm =3D proc.comm()
> +    except TypeError:
> +        pass
> +
> +    # Symbol and dso info are not always resolved
> +    dso =3D sample.dso if hasattr(sample, 'dso') and sample.dso else "Un=
known_dso"
> +    symbol =3D sample.symbol if hasattr(sample, 'symbol') and sample.sym=
bol else "Unknown_symbol"
> +    name =3D str(sample.evsel)

Does calling str() on the evsel object introduce a regression in how event
names are stored?

The python type implementation for evsel formats the string representation
as evsel(name). Unlike the original script which used the raw event name
like cycles, this code will record the string as evsel(cycles) in the
database's name column.

Will this implicit behavioral change break compatibility for downstream
database queries expecting the raw event name?

> +
> +    # Create the event object and insert it to the right table in databa=
se
> +    try:
> +        event =3D create_event(name, comm, dso, symbol, sample.raw_buf)

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260419235911.2186=
050-1-irogers@google.com?part=3D35
