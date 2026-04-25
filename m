Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 711D8EEC0
	for <linux-perf-users@vger.kernel.org>; Sat, 25 Apr 2026 18:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777140585; cv=none; b=GoBeOuy0lBNXUFdw4/nBkJACSYbBKHNWCf074PwNopadJ1FRDt0yfPRf9kuIErfHqciSMhFW8+W4iMAjtf9/gkBArPz5Z+EZU/fvSLq7HrRnoDQMgGvRI78dcRhbDFstvRbN6W4WxSyo+izZhtdKV7LjkABoIH09uIylQCryfTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777140585; c=relaxed/simple;
	bh=DbxCJ+Z17lNC1J+6UFa9autGISW2+HK9mLwqBDFifAI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ejvZ94POKggl6yo6/K6hJcYkxl12qAFrkT+zqlPIqoa4jyMNOW2WFKESsQ74wg3GfiEThBBAI+CPkcZ6D2p9dSCT5b5WKY8IarofYSJWjL0kZd4gACBZxv7vGA/gsJjTGg+yUuydvS40zwnGR7TFOA2cNohEA+huLNa3fGEgTtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o8SOVYrx; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o8SOVYrx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0890BC2BCB0;
	Sat, 25 Apr 2026 18:09:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777140585;
	bh=DbxCJ+Z17lNC1J+6UFa9autGISW2+HK9mLwqBDFifAI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=o8SOVYrxe0ljSbDCIyKbq/060uykb0oy1iTsiuk57pwjvJHyjt3aOquRg3KhR19/W
	 +F8zrPxkl8HPkJM7CvfL6HV0ZBsBzPRfhrthqXxujMhOo55EIM2W/xNxuDtCSShsJr
	 lYw6Y1ppvLjkpbWEJKPLc/ym+GxsHSjYz9bqIbIwopOEz8n2wm+RG87x0845I8qwNW
	 0sR1ZUItAVW0luABXXnYKZFcbeAqHN9tMi/eKmFyQUGFpso+mvCK2/7Sd9Of8DG5jR
	 evAwuPgAculdgKGB4IsjOQpsETC8pAoH3tUS84T1frC9UTA6EzJIVHn5GXqE0FRSPP
	 XHlIeZ+VlhZiQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 29/59] perf futex-contention: Port futex-contention
 to use python module
Reply-To: sashiko@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260425174858.3922152-30-irogers@google.com>
References: <20260425174858.3922152-30-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 25 Apr 2026 18:09:44 +0000
Message-Id: <20260425180945.0890BC2BCB0@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Sashiko AI review found 1 potential issue(s):
- [Medium] Futex contention events are silently dropped and performance deg=
rades due to mishandled thread lookup exceptions.
--

commit fa57ea79589727dc084c228173fba34a0b5fa3d6
Author: Ian Rogers <irogers@google.com>

perf futex-contention: Port futex-contention to use python module

This commit rewrites the futex-contention python script to use the perf
python module. This avoids the overhead of executing through perf script
and improves performance significantly.

> diff --git a/tools/perf/python/futex-contention.py b/tools/perf/python/fu=
tex-contention.py
> new file mode 100755
> index 000000000000..1fc87ec0e6e5
> --- /dev/null
> +++ b/tools/perf/python/futex-contention.py
[ ... ]
> +def process_event(sample: perf.sample_event) -> None:
> +    """Process a single sample event."""
> +    def handle_start(tid: int, uaddr: int, op: int, start_time: int) -> =
None:
> +        if (op & FUTEX_CMD_MASK) !=3D FUTEX_WAIT:
> +            return
> +        if tid not in process_names:
> +            try:
> +                if session:
> +                    process =3D session.find_thread(tid)
> +                    if process:
> +                        process_names[tid] =3D process.comm()
> +            except (TypeError, AttributeError):
> +                return

Does this code silently drop futex wait events and degrade performance when=
 a
thread cannot be resolved?

If session.find_thread(tid) raises a TypeError, the exception is caught but
the early return skips recording the start_time:

> +        start_times[tid] =3D (uaddr, start_time)

Additionally, because the unresolved thread isn't added to process_names
(e.g., as 'unknown'), the slow lookup and exception handling are redundantly
executed on every event for that thread.

Since the output logic explicitly handles missing thread names:

[ ... ]
> +    for ((t, u), stats) in sorted(durations.items()):
> +        avg_ns =3D stats.avg()
> +        print(f"{process_names.get(t, 'unknown')}[{t}] lock {u:x} conten=
ded {stats.count} times, "
> +              f"{avg_ns:.0f} avg ns [max: {stats.max_time} ns, min {stat=
s.min_time} ns]")

Should the exception handler skip the early return, and should unresolved
threads be negatively cached to avoid repeated lookups?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260425174858.3922=
152-1-irogers@google.com?part=3D29
