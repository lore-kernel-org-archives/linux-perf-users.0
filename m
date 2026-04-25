Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6845C367F5B
	for <linux-perf-users@vger.kernel.org>; Sat, 25 Apr 2026 18:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777140637; cv=none; b=CSZy8pfqipjeIfuB4jE6dMWk0T+jID/Q897Fl3Y+C4gPozLAlvBDxQkGICP6ZprARFWh4LTqB4DJIlnpjqRY9F17VBgVNx5H4R+LyITdCVZxAIJQ6Whn+QnUZsVD0N9MVl2R3A/MclghHNcWwBMBv9ncryDxzbffINRdIq2Un/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777140637; c=relaxed/simple;
	bh=yBW3MXlW/i8B251tB+76tEfsBwX+ecFpsLIJP9d0UDE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=j1pRALdSdGdK6AzgKBFXCD4LQl+9PSNLQv5EkOdlFHDBtFK5+d7aSTg2JuJ0clUciE8IuzDcD16mpyTka5iNEL6Ow4kKPHgrgjhQnsudd1dmLfhDcrGwf4Nt31P9Cn52sGLL+AtbPfHJLp2q4wtUvy0yoPV9qVK8/AxHNjLp7P0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eyBqf12c; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eyBqf12c"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0581AC2BCB0;
	Sat, 25 Apr 2026 18:10:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777140637;
	bh=yBW3MXlW/i8B251tB+76tEfsBwX+ecFpsLIJP9d0UDE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=eyBqf12ccM0pR40DGL0axZxSLdMjDY3fm3zOyr5wyk+UYB2TcVyEKClk8riYFMe/e
	 o4OOObGobXfu/KUYtBlrdFoIZ+fA1xvLyx8YMkRHGaUnl1h5KhctApu+zeyrMx6Ece
	 jGAV1dB6QYKNj6X39KD4qMiegCQKfHl4YmMytj8mf0Y6QDP8uFDUi7/6iEzxFrgfQc
	 bIT1z0S8dFomz9NI0m/HzP1hiCJjUuBj92L0dZBzno/pMHxKqLTZpBJIaLPCxdJ7Dg
	 ygtS1fBQ+4BPPQkfdqHMUW07dnKz8nrSPK35Hs57/v6j98DazGlDVF2iZicRbgvceu
	 C8zBHgcvPGzeg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 34/59] perf compaction-times: Port compaction-times
 to use python module
Reply-To: sashiko@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260425174858.3922152-35-irogers@google.com>
References: <20260425174858.3922152-35-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 25 Apr 2026 18:10:36 +0000
Message-Id: <20260425181037.0581AC2BCB0@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Sashiko AI review found 2 potential issue(s):
- [Medium] The script crashes with a TypeError when encountering an untrack=
ed thread.
- [Medium] The script improperly aggregates by Process ID (TGID) instead of=
 Thread ID (TID), changing behavior and exacerbating thread lookup failures.
--

commit 3eb71aa9450a61af82498b54d33b431a8675a0ee
Author: Ian Rogers <irogers@google.com>

perf compaction-times: Port compaction-times to use python module

This commit adds a Python port of the compaction-times script that directly
uses the perf python module. This approach is intended to be faster by
avoiding the creation of intermediate dictionaries for all event fields.

> diff --git a/tools/perf/python/compaction-times.py b/tools/perf/python/co=
mpaction-times.py
> new file mode 100755
> --- /dev/null
> +++ b/tools/perf/python/compaction-times.py

[ ... ]

> +def process_event(sample: perf.sample_event) -> None:
> +    """Callback for processing events."""
> +    event_name =3D str(sample.evsel)
> +    pid =3D sample.sample_pid

Does using sample.sample_pid instead of sample.sample_tid change the
script's aggregation behavior from per-thread to per-process? The
original script used common_pid, which typically corresponds to the
thread ID.

> +    comm =3D session.find_thread(pid).comm() if session else "[unknown]"

Could this crash the script if it encounters an untracked or short-lived
thread?

When session.find_thread() fails to locate a thread in the machine's
thread map, it explicitly throws a TypeError. Because this exception is
not caught here, a missing thread could cause a fatal Python exception,
halting the entire trace processing.

Additionally, passing the TGID from sample_pid instead of the TID might
exacerbate this issue if a child thread triggers the event and the main
thread's metadata is absent.

> +    secs =3D sample.sample_time // 1000000000
> +    nsecs =3D sample.sample_time % 1000000000

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260425174858.3922=
152-1-irogers@google.com?part=3D34
