Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F15ED2C11E2
	for <linux-perf-users@vger.kernel.org>; Fri, 24 Apr 2026 17:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777050877; cv=none; b=rnDrioKXvmOdrtM5bFWv1if2LRKxa7UxhNrMDiXjxL/XTcjjuLmRnVVgyTzk8+MrNo6+NaR4DarrQKG2DrnDM0KAJgt/oN2jhv1WegaQudPDNooA8RGe+D58cP0crDVsE+ltizm9ZuiYY+KcIrO8WtAr6qxctQDMHOm09ZKR/aU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777050877; c=relaxed/simple;
	bh=ppnmkfDXkttEI7RLeUHVI6U5vDpmpQlfo2T2OlqC2kM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=lIKlEw6KxNj+qROafQp2GaF+567BDknQGXNT6Ac0CrPVl/1shkOiJEM1Xj0d7k0TVYs7e/TPzvaq+ArXI6JJAOE6pHPId72YTKclS/oZ4KKaOoH4RIVUpFL9Ju/fXM6OoYggN8tumHINPbvIqrDys2eM6mZnhklx68bARMLhgMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WQIZMoy/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WQIZMoy/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DCB4C19425;
	Fri, 24 Apr 2026 17:14:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777050876;
	bh=ppnmkfDXkttEI7RLeUHVI6U5vDpmpQlfo2T2OlqC2kM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=WQIZMoy/8gf7/dvD2kWVE6uXA0OammIetqFqs4QF9VeRSbZEs44lyRQoUW7CrKZRR
	 9NuIYmOFJ9Wf/chxDlx3lsXjsZEW5nmazVhZXKyeSwknKyKkDLbrINHCtGS9DiRYhe
	 cxAoH+WgVug383zdbEEziXI3Ub2pRzzh3vQ8qjhPPkmbL0m1bR0gEjHfejk1YVS03d
	 qD8rXI11fxFkzjviP1Szfuv6J1RC+2RaTKnSoT8uinUIkezJHwqzca9BHtHv4qbdss
	 AI/zBo2d/bBIKo/DGcsuDz0foCnJ3MwE2JiPPvPSeTK44KHlcn5c/PDjfHoEjmtuWb
	 IQ5fyTI9XS0SQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 33/58] perf check-perf-trace: Port check-perf-trace
 to use python module
Reply-To: sashiko@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260424164721.2229025-34-irogers@google.com>
References: <20260424164721.2229025-34-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 24 Apr 2026 17:14:35 +0000
Message-Id: <20260424171436.7DCB4C19425@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Sashiko AI review found 2 potential issue(s):
- [High] The script crashes with an unhandled TypeError if an event's threa=
d is not found in the thread map, and incorrectly uses sample_pid instead o=
f sample_tid.
- [Medium] Substring matching incorrectly routes `kmem:kmalloc_node` events=
 to the `kmem:kmalloc` handler.
--

commit 88d07d08354cf3878fe6e4a135b0948803fe0d76
Author: Ian Rogers <irogers@google.com>

perf check-perf-trace: Port check-perf-trace to use python module
   =20
This commit adds a port of the check-perf-trace script that uses the perf
python module directly. This approach is significantly faster than using pe=
rf
script callbacks as it avoids creating intermediate dictionaries for all
event fields.

> diff --git a/tools/perf/python/check-perf-trace.py b/tools/perf/python/ch=
eck-perf-trace.py
> new file mode 100755
> index 00000000000000..4c05540bdc057b
> --- /dev/null
> +++ b/tools/perf/python/check-perf-trace.py

[ ... ]

> +def print_header(event_name: str, sample: perf.sample_event) -> None:
> +    """Prints common header for events."""
> +    secs =3D sample.sample_time // 1000000000
> +    nsecs =3D sample.sample_time % 1000000000
> +    comm =3D session.process(sample.sample_pid).comm() if session else "=
[unknown]"

Could this crash when encountering short-lived or untracked threads?

The underlying Python C extension raises a TypeError if the thread is not
found in the thread map.

Should this also use sample.sample_tid instead of sample.sample_pid to
correctly look up non-leader threads?

> +    print(f"{event_name:<20} {sample.sample_cpu:5} {secs:05}.{nsecs:09} "
> +          f"{sample.sample_pid:8} {comm:<20} ", end=3D' ')

[ ... ]

> +def process_event(sample: perf.sample_event) -> None:
> +    """Callback for processing events."""
> +    event_name =3D str(sample.evsel)
> +    if event_name =3D=3D "evsel(irq:softirq_entry)":
> +        irq__softirq_entry(sample)
> +    elif "evsel(kmem:kmalloc)" in event_name:

Will this substring match inadvertently catch evsel(kmem:kmalloc_node) even=
ts?

Using exact equality, similar to the irq:softirq_entry check above, might
prevent kmalloc_node events from bypassing trace_unhandled() and misreporti=
ng
the event type while silently dropping their node field.

> +        kmem__kmalloc(sample)
> +    else:
> +        trace_unhandled(event_name)

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260424164721.2229=
025-1-irogers@google.com?part=3D33
