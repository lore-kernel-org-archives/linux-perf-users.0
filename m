Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15129277C88
	for <linux-perf-users@vger.kernel.org>; Thu, 23 Apr 2026 04:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776917869; cv=none; b=r0+Pml/4Lv5Ij3wMc3N5410JKLE+qtvlO2/yWMi6roER6sBvxH7famIGTQ5YLwgLD/K2lqW/7fIvTmZDVpisbg+Ztj4/cja4MgMnIaog3WKKqNTP3i3QtaqWa15zmCe6bjm05g2boyjKZ8l4YQw4qIlWzKdBI8hZQ0VdEiOvTyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776917869; c=relaxed/simple;
	bh=9kwtNHyqv0eb5/ps2r8wb0W8yCSrcNde43YwR9Dnyd4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=O1p2ZbrRnPMgGmL3IPXgoc6tDw2OjOtwvNFMPoAF+b/CgbCIswMfnIZeYrOdAePCkaQmD9pAkZuu9mCcllQFkVx7qC+iuj00hWNNwoUATUqQyK05GM7cabpLGlnEeZbFIcZ1AEtLy46ieJGbkPjCrx5RHsGKuAdM56YpnQidZPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tkPacOTe; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tkPacOTe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B90FBC2BCB2;
	Thu, 23 Apr 2026 04:17:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776917868;
	bh=9kwtNHyqv0eb5/ps2r8wb0W8yCSrcNde43YwR9Dnyd4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=tkPacOTeE9L6YBid52yKhQm4gNseP4SDZW7GaKeSkCa+/DKd0did7u7sRuLgglwKJ
	 Lp9eZUrG/6PyVBoJlwOpM0EYcoEisqaS1A6JjBHQ/YdyZr9TfHsQK6RVk5hRTl5uU/
	 8pZdnjeV2V3OBcWIDh9B8iqgkIY5k96e7U8biiO4TXgxBTxb5lMOj9IoygtVe7TY0A
	 DgpmzXLfW4xAwx5ymHQ34lQCXtV4Rn8vHfKQQQAxysaI1hgltBSemexb5NtmjZ8OwX
	 nOkhuaUeQOdvFaqBnySI2IQFvX7F9A/NVYBXZoUDyRaJEotwbNpAfX4j/37+ORCCUl
	 5hSoAN6grO9fQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 45/58] perf stackcollapse: Port stackcollapse to use
 python module
Reply-To: sashiko@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260423035526.1537178-46-irogers@google.com>
References: <20260423035526.1537178-46-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 23 Apr 2026 04:17:48 +0000
Message-Id: <20260423041748.B90FBC2BCB2@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Sashiko AI review found 2 potential issue(s):
- [High] Unhandled TypeError crashes trace processing when a thread cannot =
be found.
- [High] Multi-threaded applications lose thread-specific comm breakdown du=
e to passing `sample_pid` to `session.process()`.
--

commit 8033337e08bc60a928a1c42fc1269626cb2e0069
Author: Ian Rogers <irogers@google.com>

perf stackcollapse: Port stackcollapse to use python module

Modernize the legacy stackcollapse.py trace script by refactoring it
into a class-based architecture. The script uses perf.session for event
processing and aggregates call stacks to produce output suitable for flame
graphs.

> diff --git a/tools/perf/python/stackcollapse.py b/tools/perf/python/stack=
collapse.py
> new file mode 100755
> index 0000000000000..fae0f0f503a35
> --- /dev/null
> +++ b/tools/perf/python/stackcollapse.py

[ ... ]

> +    def process_event(self, sample: perf.sample_event) -> None:
> +        """Collect call stack for each sample."""

[ ... ]

> +        if self.args.include_comm:
> +            if hasattr(self, 'session') and self.session:
> +                comm =3D self.session.process(sample.sample_pid).comm()

When a thread cannot be found in the perf session (due to dropped events
or late starting), the C implementation pyrf_session__process() raises a
TypeError.

Since there is no try...except block around this call, will this unhandled
exception abort the session.process_events() loop and crash the script?

Other ported scripts like syscall-counts.py wrap this in a check for
TypeError and AttributeError to handle missing threads safely.

Additionally, does passing sample.sample_pid to session.process() cause
multi-threaded applications to lose their thread-specific comm breakdown?

In Linux perf, sample_pid is the process ID (TGID). Passing it forces the
lookup to return the process's main thread.

Sub-threads will have their call stacks collapsed under the main process
comm instead of their actual thread names.

> +            else:
> +                comm =3D "Unknown"
> +            comm =3D comm.replace(" ", "_")

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260423035526.1537=
178-1-irogers@google.com?part=3D45
