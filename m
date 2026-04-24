Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10AF93E1CE1
	for <linux-perf-users@vger.kernel.org>; Fri, 24 Apr 2026 17:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777051327; cv=none; b=fwrmKClM/Bd89lqJkqxifmBS7ew6L3I2zxXU+Bz4TpNLe2hGMJKGV05MGIldfr2xV8OcCeLqBrVRMe7RdIQmBZ3f73F2WOJ99bEgNsbmOldctjQLYNzfL2EpbI7SuhqngVes1Jg50um6m7u9Mts4NUTENpDDsulIjkGEnJ+Onp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777051327; c=relaxed/simple;
	bh=FnxO6i0pVIvOnjj6T6nn8A1U1brXgREj8WtHjCp+1l0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Aydp4NrKqtR3XwuXaM+vVwKc7GVyTEvKKvYzySPzlrILkLF8kexCG12PMYlJAP/4E/UwuP7lfXDpIjuIHqY6sYbHsJ06Gh0OuWv0cFsQZqFNEEWWTBlkEb6nMD1LNzwjt5fX/yyP0VZe4oD5QIk5/0oEzDLCQoIvzkN/Ln9MHIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nYtmYo71; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nYtmYo71"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C98E8C19425;
	Fri, 24 Apr 2026 17:22:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777051326;
	bh=FnxO6i0pVIvOnjj6T6nn8A1U1brXgREj8WtHjCp+1l0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=nYtmYo71MrnVZmaNOFFOYInJqScUzkjB0As6wO5+tprArsn97DStb1xvqNruWbk0E
	 7/KivmHWXHxqOv1Mt56rXae30/GENWmoXbY0OU461rGWduhji69JTFk3S/21J625sf
	 8CUlW5Mqz4f+6R3ab0CnoJV7IAK928FfM/132JU2FPI3GN2lmKO3EG/jRQJHRVX9UN
	 I/Pb9nvEwYlk9xbohmcaAXNSERIkd1nAfosarDd1yuoyuMal00t6DFGUI/VyDQdqXX
	 P8w4ZiaJNME8/e7Q11fWHIbUhdFgtVx3OiJfBoCJjb79ivJ+Da75lC/MVl9RlWc7TJ
	 +FOd/rrET7GQA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 42/58] perf powerpc-hcalls: Port powerpc-hcalls to
 use python module
Reply-To: sashiko@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260424164721.2229025-43-irogers@google.com>
References: <20260424164721.2229025-43-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 24 Apr 2026 17:22:06 +0000
Message-Id: <20260424172206.C98E8C19425@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Sashiko AI review found 2 potential issue(s):
- [Medium] The script will crash unconditionally with an AttributeError bec=
ause it accesses a non-existent `sample.time` attribute.
- [Medium] Tracking hypercall entry and exit using `sample.sample_pid` (Pro=
cess ID / TGID) causes state corruption and dropped events for multi-thread=
ed virtualization workloads.
--

commit 8faf550d56fb4a760cc8e05aa599b316511d58ed
Author: Ian Rogers <irogers@google.com>

perf powerpc-hcalls: Port powerpc-hcalls to use python module

This commit ports the powerpc-hcalls script to use a Python module structur=
e.
It introduces the HCallAnalyzer class to encapsulate state and processes ev=
ents
using perf.session to track hypervisor call statistics.

> diff --git a/tools/perf/python/powerpc-hcalls.py b/tools/perf/python/powe=
rpc-hcalls.py
> new file mode 100755
> index 00000000000000..c4fa539174c9dc
> --- /dev/null
> +++ b/tools/perf/python/powerpc-hcalls.py

[ ... ]

> +    def process_event(self, sample: perf.sample_event) -> None:
> +        """Process a single sample event."""
> +        name =3D str(sample.evsel)
> +        pid =3D sample.sample_pid

Does using sample_pid correctly track concurrent hypercalls for multi-threa=
ded
virtualization workloads?

In Linux perf, sample_pid corresponds to the Thread Group ID (Process ID).
Virtualization software like QEMU executes multiple Virtual CPUs as separate
threads within the same process, meaning all VCPUs share the same sample_pi=
d.

If concurrent hypercalls execute on different VCPUs, wouldn't they overwrite
each other's timestamps in the d_enter dictionary?=20

Could this instead use sample_tid or sample_cpu to safely isolate concurrent
operations like the legacy script did?

> +        time =3D sample.time

Will this script encounter an AttributeError when accessing the timestamp?

In the perf Python extension bindings in tools/perf/util/python.c, the event
timestamp is exposed as sample_time, not time. It appears assigning
time =3D sample.time will raise an exception on the first processed sample.

> +        opcode =3D getattr(sample, "opcode", -1)

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260424164721.2229=
025-1-irogers@google.com?part=3D42
