Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4664368299
	for <linux-perf-users@vger.kernel.org>; Fri,  5 Jun 2026 19:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780688634; cv=none; b=t9+gKLfG3sam4FPcQN0GK56OvWi3dNM7TAz5GKJFgQKdo6eE5MsD8cuC/UV6xVZgcdIeuZHDXMWjH+1+L/Txwm8u58HZyV73mdso1gXCvS2HQsldi3XZMOTRAOQhKN4isB4pqlNaPlBFy+/znIJixOQPaFDIVLSfMCuiLvbrpdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780688634; c=relaxed/simple;
	bh=z7etLB5CBqvT/kgyGPFMBdHM24ktqkbBiFmEzoQ2D+0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=DZcWueKfx6sGn4yuRXlPXuzbdap0d85xuQ61yTuao0eCMjmExRfyN2gKcOsimGaGWw+ux49/ASiICm4LjBJJ6w8zKNzupckBohLCuAZIXvCN7mxAwB5gFD24W3ZIgIIWI7p25/st1SnSGDcUs5a8WWdKQbybBNoJl5XIeHfcJ8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oXk+eiVr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oXk+eiVr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 975EC1F00893;
	Fri,  5 Jun 2026 19:43:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780688633;
	bh=jdkg6szNHjqGRiXnl79pLAITtoK3QeLGQwxLwB2K1vg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=oXk+eiVrR00K8fTrSdSUBbWEiCY/wFJdM1cune+iPtERqyawuwQp/HDDvMNu7Ue68
	 dWI3h5zzUrsNlEqN/2mWInkZp3jUOTnIi4e6Q5JFWkHe+uzljYYptwJeMxbxpFpl8d
	 d+Yl/p5+X3J3Zb7buZw+LeqGGrv08WNrvAI89vM3M9+gpFZQOSLcqM0gmMcUG9HQaC
	 lqIzE5DulzxugWjwhx224/onIEewajtYui5qptEbxFd/OD+OU4F0YhtTioEoMzGvK4
	 QMVs6jr8SNH4qW6JrL5ZI7dBKC/r/oN7pkaIo4nCsNhICmOULy13rqk6uCVzzD2zpT
	 7jBBr4YSOgOEA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v11 19/19] perf python: Add LiveSession helper
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260605191500.2477026-20-irogers@google.com>
References: <20260605191500.2477026-20-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 05 Jun 2026 19:43:53 +0000
Message-Id: <20260605194353.975EC1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [Medium] Architecture-dependent string check for -EAGAIN masks other OS e=
rrors and causes crashes.
- [Medium] setup_python.sh logic fails to prioritize in-tree perf.so when P=
YTHONPATH is already set.
- [Medium] Breaking the event poll loop on TypeError stops reading events w=
hen an unsupported event type is encountered.
--

commit 23f3afcdbce401e6d045688edc6ad07c1c1dcc56
Author: Ian Rogers <irogers@google.com>

perf python: Add LiveSession helper

This commit adds a LiveSession class in python to support live event
collection using perf.evlist without requiring a perf.data file. It also
modifies setup_python.sh to configure PYTHONPATH.

> diff --git a/tools/perf/python/perf_live.py b/tools/perf/python/perf_live=
.py
> new file mode 100755
> index 0000000000000..10fb974879ca2
> --- /dev/null
> +++ b/tools/perf/python/perf_live.py

[ ... ]

> +    def run(self):
> +        """Run the live session."""

[ ... ]

> +            while True:
> +                # Poll for events with 100ms timeout
> +                try:
> +                    self.evlist.poll(100)
> +                except InterruptedError:
> +                    continue
> +                for cpu in self.cpus:
> +                    for _ in range(1000): # Limit to 1000 events per CPU=
 per poll to prevent starvation
> +                        try:
> +                            event =3D self.evlist.read_on_cpu(cpu)
> +                        except TypeError:
> +                            # CPU might be unmapped or offline
> +                            break

[Severity: Medium]
Does this inadvertently stop event processing when an unsupported event type
is encountered?

The C extension pyrf_evlist__read_on_cpu raises a TypeError not just for
unknown CPUs, but also for unexpected event header types. By catching
TypeError and breaking the loop, it abandons the rest of the CPU's events
for the current 100ms poll cycle whenever an unknown event type is parsed.
Could this cause unnecessary dropped events and ring buffer overflows?

> +                        except OSError as e:
> +                            # Ignore -EAGAIN on empty buffer
> +                            if "err=3D-11" in str(e):
> +                                break

[Severity: Medium]
Is it safe to hardcode -11 for EAGAIN?

EAGAIN is architecture-dependent (for example, it is 35 on Alpha), so this
might crash with an unhandled OSError on those architectures. Additionally,
would this substring check mistakenly match and break the loop for other
errors like -111 (ECONNREFUSED) or -116 (ESTALE)?

> +                            # OS/mmap errors are unrecoverable
> +                            raise e
> +
> +                        if event is None:
> +                            break

[ ... ]

> diff --git a/tools/perf/tests/shell/lib/setup_python.sh b/tools/perf/test=
s/shell/lib/setup_python.sh
> index a58e5536f2edd..86c523207c090 100644
> --- a/tools/perf/tests/shell/lib/setup_python.sh
> +++ b/tools/perf/tests/shell/lib/setup_python.sh

[ ... ]

> +# Set PYTHONPATH to find the in-tree built perf.so first, avoiding syste=
m-wide perf.so
> +if [ "x$PYTHONPATH" =3D "x" ]; then

[Severity: Medium]
Does this logic skip prioritizing the in-tree perf.so if PYTHONPATH is alre=
ady
set in the environment?

If an existing PYTHONPATH is detected, this check prevents appending the
build directory entirely. This means test environments with existing
PYTHONPATHs might mistakenly load the system-wide perf.so or fail to find
the module, which seems to go against the stated intent of the comment
above it.

> +  # If PERF_EXEC_PATH is set (pointing to the build directory), prioriti=
ze it
> +  if [ -n "$PERF_EXEC_PATH" ] && [ -d "$PERF_EXEC_PATH/python" ]; then
> +    export PYTHONPATH=3D"$PERF_EXEC_PATH/python"

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260605191500.2477=
026-1-irogers@google.com?part=3D19
