Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDD55304BB2
	for <linux-perf-users@vger.kernel.org>; Sun, 20 Sep 2026 05:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789882778; cv=none; b=rc5NmSHoiEEBS47mFL00EOlh544HigjXccWE8IjkvBy+V7kyNOrWLWLWbMJ5MQHBxCFrfjUrYBh35kDB3xjDYaaWFvrlszOI52F5Z3W0MKDm8Ogn9VWM7yYSxCWiT5U8dgcVxNviI8rI2XqGkWSvLOIwx8KbWHL6iDekAELtOyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789882778; c=relaxed/simple;
	bh=jM2JousB1dME+q4j3BqLXcTquuobru8gosbnOS/YIjM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=cI0BR9iH1Qqi4C/pnv7bxJ0kcXEwPOG64VFxKinTWfKxRwo2Ak9XpSZ7J+Z48GHgViNEVIgQAi+S3I/vZePwdzqqlcXwmoUhHCOLGpw24vMqdLRCxpvgY4ed0eTPSXsb7LJhKTIn8kyDbo9EE3oXFFtvKkGDSNEPh9F5VBX6HeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YE0VJx0t; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YE0VJx0t"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58D4E1F00893;
	Sun, 20 Sep 2026 05:39:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789882773;
	bh=gCMtkIMU2V8S50vdrDuAov1xdANrT9j3LIygzi0dGl8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=YE0VJx0teB0AOSmYF4i/hv7jHorYo7gyZQuuZi3wqgv0Bn9NEi0Sf7wICxnhDbHBH
	 toqCyvfs+qJNlU7K0Dvo4yoFyRiTplNEOmFwo1Cw5x5W2GFiOFbDeymtV9Z1hgSjcY
	 1iWxU2/jAahw3mKP/cMC+VaSty+0aQ7nNPkyF3shl8qfJAXZbqRK/B1SpX27PG5m1D
	 hf4kUWwBIhRvzd0n3nNqaKEX++HCwOlVtqGjy6JWIP1161A3GicmM4MA/H1hD5TRoI
	 gJRHvwbM3nolxm5BL8DHWOxJmhvhuNu/GSnvqt+Jl6JroiV5ktaB5G1jDiKOnzricD
	 1jLlCJZO0iBVQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 26/49] perf python: Port sctop to perf module
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <96c37f9f9dae4a2109f272e1833095266b6fc028.1789880842.git.irogers@google.com>
References: <cover.1789880842.git.irogers@google.com>
 <96c37f9f9dae4a2109f272e1833095266b6fc028.1789880842.git.irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 20 Sep 2026 05:39:33 +0000
Message-Id: <20260920053933.58D4E1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] perf: sctop silently drops x32 ABI syscalls due to 0xffff limit
--

commit 1ef6e01194ef0771e0ca86661282a11b36de647e
Author: Ian Rogers <irogers@google.com>

perf python: Port sctop to perf module

This commit ports sctop.py to a standalone script in tools/perf/python/,
adding support for offline perf.data analysis and live monitoring. It also
updates the script to resolve architecture-aware syscall names and replaces
unsafe signal handlers with threading synchronization.

> diff --git a/tools/perf/python/sctop.py b/tools/perf/python/sctop.py
> new file mode 100755
> index 0000000000000..37c8328ef840b
> --- /dev/null
> +++ b/tools/perf/python/sctop.py
[ ... ]
> +    def process_event(self, sample: perf.sample_event) -> None:
> +        """Collect syscall events."""
> +        name =3D str(sample.evsel)
> +        syscall_id =3D getattr(sample, "id", -1)
> +        if syscall_id < 0 or syscall_id > 0xffff:
> +            syscall_id =3D getattr(sample, "__syscall_nr", -1)
> +        if syscall_id < 0 or syscall_id > 0xffff:
> +            syscall_id =3D getattr(sample, "nr", -1)
> +
> +        skip =3D False
> +        with self.lock:
[ ... ]
> +            is_enter =3D (name.startswith("evsel(raw_syscalls:sys_enter"=
) or
> +                        name.startswith("evsel(syscalls:sys_enter"))
> +            if not skip and is_enter and 0 <=3D syscall_id <=3D 0xffff:
> +                self.syscalls[syscall_id] +=3D 1

[Severity: Medium]
Does this condition unintentionally filter out legitimate x32 ABI syscalls
on x86_64?

When processing trace events from an x32 application, the syscall ID from
raw_syscalls:sys_enter includes the __X32_SYSCALL_BIT (0x40000000). Because
0x40000000 exceeds 0xffff, the script falls back through the attributes and
eventually skips incrementing the counter for that syscall. This causes
x32 ABI syscalls to be silently dropped from the output.

The legacy sctop.py script correctly stored and printed these IDs without
an artificial cap. Can this upper bound be removed or adjusted in
SCTopAnalyzer.process_event to accommodate x32 syscalls?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1789880842.gi=
t.irogers@google.com?part=3D26
