Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D965B19C542
	for <linux-perf-users@vger.kernel.org>; Sat, 25 Apr 2026 23:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777159331; cv=none; b=oYUEU5oNtMCcPxqchQEyqvkVkVRi8K8BTCB620dEFSwSe3AjdDK0XaqAXgxmehMLZzhQupstYlAgqGJn5tbw3PJavIhUOyrS7dmxMfuvGZMLzsATuwCtM72ZJ3Nx+RR3o5bycRCxjeuh+iJGx4Kr38+pomlgccoLdHU6vhGfCLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777159331; c=relaxed/simple;
	bh=FSG7gRWNgZUTUg56VhbKeifv7FrD8+aqHDwwyg2WN24=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=DAMA87Mk7uGSn/RG3vA0V562xqhU0WYZjHtXlNL0xFY+VGsgL3sZ4CpiGtbckbpSRCTT8NEbXE+55Ygp6Oes9T0VP2lPM2grAnpgoamhzedfZ3vdJKw7nvOVkX6FP5xX6/ywlvaso3Fn9D4oVDWDtwp9QlTSLCt54Y9VFhvncI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Amm6CZ8s; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Amm6CZ8s"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 651C9C2BCB0;
	Sat, 25 Apr 2026 23:22:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777159331;
	bh=FSG7gRWNgZUTUg56VhbKeifv7FrD8+aqHDwwyg2WN24=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=Amm6CZ8s+ioRv7FQCxTMDla9diUUmH3P09w7KUG33veCpjUx3XRqdwQ/RLspU9D/t
	 FWx40qzDBlMWA+W7rBNsl/Olr2f2lAdDSaz3mjqyP7u++cejPC4RbMRsJc5B1YYEAP
	 qRlYp23TlRRjv5Y645Vgy+sZHDwPU9kh4oVHYfGFRm4jNU+SjROTCiCVZKnwoxSFb1
	 ybhPJtyZujVZHLXW7Oqo54u4UQ340dOzcQvfXvjtdr48StR3K1+YG6QGeNjxMSa/rr
	 LDEFBs4pmOIQtfkwQZqJmf1lqeR91S4A78gINgS7gaUfOLeSDHcJfGaPPZjuzFeBjf
	 zDR1XOhDEH9Jg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 34/59] perf compaction-times: Port compaction-times
 to use python module
Reply-To: sashiko@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260425224951.174663-35-irogers@google.com>
References: <20260425224951.174663-35-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 25 Apr 2026 23:22:10 +0000
Message-Id: <20260425232211.651C9C2BCB0@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Sashiko AI review found 3 potential issue(s):
- [Medium] Missing exception handling around session.find_thread() will cau=
se the script to crash on unknown threads.
- [Medium] Use of sample_pid instead of sample_tid alters aggregation seman=
tics, causing data corruption for multi-threaded processes.
- [Medium] The PID filter logic completely breaks for exact PID 0 matching,=
 silently allowing all PIDs.
--

commit 47200de1d5830a151f211537641e1e54a0558327
Author: Ian Rogers <irogers@google.com>

perf compaction-times: Port compaction-times to use python module

Add a port of the compaction-times script that uses the perf python module
directly. This approach is significantly faster than using perf script
callbacks as it avoids creating intermediate dictionaries.

> diff --git a/tools/perf/python/compaction-times.py b/tools/perf/python/co=
mpaction-times.py
> new file mode 100755
> index 000000000000..7f17c251ded7
> --- /dev/null
> +++ b/tools/perf/python/compaction-times.py

[ ... ]

> +def get_pid_filter(low_str: str, high_str: str) -> Callable[[int, str], =
bool]:
> +    """Returns a filter function based on PID range."""
> +    low =3D 0 if low_str =3D=3D "" else int(low_str)
> +    high =3D 0 if high_str =3D=3D "" else int(high_str)
> +
> +    def filter_func(pid: int, _comm: str) -> bool:
> +        return not (pid >=3D low and (high =3D=3D 0 or pid <=3D high))

Does this code handle filtering for PID 0 correctly?

If a user explicitly filters for PID 0, high will be assigned 0. The
condition then evaluates high =3D=3D 0, which will return True for all valid
PIDs >=3D low (0), effectively disabling the filter instead of restricting =
it
to PID 0.

[ ... ]

> +def process_event(sample: perf.sample_event) -> None:
> +    """Callback for processing events."""
> +    event_name =3D str(sample.evsel)
> +    pid =3D sample.sample_pid

Does this aggregation cause data corruption for multi-threaded processes?

In the perf_sample Python bindings, sample.sample_pid provides the process =
ID
(TGID), while sample.sample_tid provides the thread ID (TID). The original
script used common_pid, which corresponds to the TID.

If multiple threads in the same process run compaction concurrently, they w=
ill
share the same TGID, which could cause them to clobber each other's pending
state when mark_pending() overwrites self.pending.

> +    comm =3D session.find_thread(pid).comm() if session else "[unknown]"

Will this script crash if the thread cannot be found?

The C-extension function pyrf_session__find_thread() explicitly returns NULL
and raises a Python TypeError if the thread is missing from the machine's
thread map. Without a try...except TypeError block around this call,
encountering an unknown thread will abort trace processing entirely.

> +    secs =3D sample.sample_time // 1000000000

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260425224951.1746=
63-1-irogers@google.com?part=3D34
