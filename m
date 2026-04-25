Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 470CD2EC09B
	for <linux-perf-users@vger.kernel.org>; Sat, 25 Apr 2026 23:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777158368; cv=none; b=P/+CyuewbOnTNMbZ0GMRYKLx6XipM4c6MSDWLBKJEWEht9rM2Qk49IGzIs/ZM9VlUw/GDv9uE4HAzcZKYT4KdIIaCj9qfVR2q1KIV10xCEk4VFsGa7CjkgP7xnj42cn81uf0iekQYCouiT878jBGKhoVj92Wu9tOk6O+v4ozQuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777158368; c=relaxed/simple;
	bh=UpqV6rg68+qXKrEeMXeEewhVIvqZ241GAdoir3l5I1Y=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=VJJeyrGc6+wrYWXy+bnxjZ+czickbBNWLLslxUbdwzNeZwidgi5A3OtZOOQKKdhCvEnUpZS329dFe97Rjsm4VeJXxY7G47LZUtR/SSgPeUetiejzV0adbZVj2To5khfD/TwgKIHsP1CYVQmpE2mP5IrQknYnTCqV+iA79dpi/rA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tK1ihfsf; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tK1ihfsf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBE9EC4AF09;
	Sat, 25 Apr 2026 23:06:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777158368;
	bh=UpqV6rg68+qXKrEeMXeEewhVIvqZ241GAdoir3l5I1Y=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=tK1ihfsfFKoP9M1G8Dc6hOr2bF2fkQTrowecP6VJp8mrQRFGEFzjevbaocvnnGbr1
	 6QjtqHfIuj+0E1MXqKIgkfr0axq8N+B3SKJXqPtIYjI+kv6gYsw1QzzqM0p9y14WXR
	 xhhZqOTOQQZiRpM87PfCjMy4SHKfqF7AG/iLW+cBR7WPQyiMnGfQO3jfJyUSXwKcbj
	 sjBlJa64afBGkk5zAUJ8B+c3kmSKGzMf1dXVcbvGhdz7YK1yxwoMmk/5L9A21c+onu
	 4ztc5J8Z2QcBBkK2Gizx5gfd/d/ibPendudF5qMgdaQ8ABT6qtKOC7EkUtqq81M8KK
	 LQyhzIpUXf7IA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 33/59] perf check-perf-trace: Port check-perf-trace
 to use python module
Reply-To: sashiko@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260425224951.174663-34-irogers@google.com>
References: <20260425224951.174663-34-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 25 Apr 2026 23:06:07 +0000
Message-Id: <20260425230607.EBE9EC4AF09@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Sashiko AI review found 3 potential issue(s):
- [Medium] The script will crash with an unhandled TypeError when encounter=
ing samples for unknown or unsynthesized threads.
- [Low] The port silently drops the capability to decode kernel trace flags=
 and GFP flags into human-readable strings.
- [Low] Unhandled events are summarized with an extraneous format wrapper, =
logging the internal `evsel` object string representation rather than bare =
event names.
--

commit 63e7f17c5646bdcb4eaaeba2e09a639c736980e9
Author: Ian Rogers <irogers@google.com>
perf check-perf-trace: Port check-perf-trace to use python module

Add a port of the check-perf-trace script that uses the perf python module
directly. This avoids creating intermediate dictionaries for all event fiel=
ds,
which significantly improves the execution speed.

> diff --git a/tools/perf/python/check-perf-trace.py b/tools/perf/python/ch=
eck-perf-trace.py
> new file mode 100755
> index 000000000000..7c1c7632a091
> --- /dev/null
> +++ b/tools/perf/python/check-perf-trace.py
> @@ -0,0 +1,113 @@
[ ... ]
> +def flag_str(event_name: str, field_name: str, value: int) -> str:
> +    """Resolves flag values to strings."""
> +    if event_name =3D=3D "kmem__kmalloc" and field_name =3D=3D "gfp_flag=
s":
> +        return f"0x{value:x}"

Does this drop the capability to decode flags into human-readable strings?

The legacy script used C-provided scripting core helpers to translate
raw integers into text, for example translating gfp_flags to GFP_KERNEL.
It looks like this port now just dumps the raw hexadecimal value instead.

> +    return str(value)
> +
> +def print_header(event_name: str, sample: perf.sample_event) -> None:
> +    """Prints common header for events."""
> +    secs =3D sample.sample_time // 1000000000
> +    nsecs =3D sample.sample_time % 1000000000
> +    comm =3D session.find_thread(sample.sample_pid).comm() if session el=
se "[unknown]"

Will this crash with an unhandled TypeError for unknown threads?

Looking at pyrf_session__find_thread in tools/perf/util/python.c, the
underlying machine__find_thread lookup raises a TypeError instead of
returning None when a thread is not found.

Encountering a sample for an untracked PID seems like it would crash
the script here instead of falling back to "[unknown]".

> +    print(f"{event_name:<20} {sample.sample_cpu:5} {secs:05}.{nsecs:09} "
> +          f"{sample.sample_pid:8} {comm:<20} ", end=3D' ')
[ ... ]
> +def process_event(sample: perf.sample_event) -> None:
> +    """Callback for processing events."""
> +    event_name =3D str(sample.evsel)

Does this cause unhandled events to be printed with an extraneous wrapper?

The string representation method for the evsel wrapper, pyrf_evsel__str,
returns strings formatted like "evsel(sched:sched_switch)".

Since this wrapped string is passed to trace_unhandled(), it seems the
unhandled events summary will print the wrapper text instead of just the
bare event names that the legacy version printed.

> +    if event_name =3D=3D "evsel(irq:softirq_entry)":
> +        irq__softirq_entry(sample)
> +    elif "evsel(kmem:kmalloc)" in event_name:
> +        kmem__kmalloc(sample)
> +    else:
> +        trace_unhandled(event_name)

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260425224951.1746=
63-1-irogers@google.com?part=3D33
