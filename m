Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44436385D82
	for <linux-perf-users@vger.kernel.org>; Sat, 26 Sep 2026 06:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790404195; cv=none; b=FPr8oFMKie5sKzxxhDIHsm8cs/BWPwebHT9GmM3kkoWLi5JQVTvuT90nH3c08q6ozLPKX4vHLLtdKvk4BMPBGqDHb4T/JveW6S0IcUgQmEhLF1CihqDtsaEFUYAstpZapAfmoGqWnWZGnpSXOLQYankZvyWmNp5cT6ApoGIn+HQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790404195; c=relaxed/simple;
	bh=O0DtHGaF92QVVnpBuybLXNG3JjjottK72QMICBWcPqI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=fAJYr9OYjD/zFV4lHiz3EGH5Q2UdEF3JICGbXgfy4K5J5S8FKkIBVaqFlOya5a19VXoFV14chLbOBhxI/MUWm8elY9HBILqmm7ayLYw+Ol4iJQPIvQN/gZVjIdMO5K+xtcwx/+fbay10u0kq3cdj4oPfmnNS6h55OtKmMt8LTXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ugrqaes6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ugrqaes6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8B101F000FF;
	Sat, 26 Sep 2026 06:29:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790404193;
	bh=IXJKfBo+LWOg+8fDPWNnFWikRBHogDaG61NshBio8ow=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Ugrqaes6VN5OqLDsp3M1izCaiI7slSHbJmrAPsesgNiYGBxzepX0dlw//TqQxhwaV
	 Dmd3e9TzPMICMqTKqmWnp/wITFkscgShZjIWZqX0Fef19PVobnauXaqcNR+4+GnkhC
	 lC42kNJUmFsRk68meCV8ac6Y5MONDJio1oFxzZ4N4Wj3HE0mkvNM3hCHElfT+MgeNE
	 MZt8vJWcf3Ko5js/STLUpakyAbb47wgN2coH705mfv6jT+jUg/MLMHO0UeUZK5WwrI
	 1lh6Jkmr/fLC2gk0iu2dzHlsTSwuGvJixuq7eTXgfirriy6C40xR4mkitN5SYBseOp
	 bAfA6CrN9i+Vw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 24/49] perf python: Port failed-syscalls-by-pid to
 perf module
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260926062029.800743-25-irogers@google.com>
References: <20260923181213.3032038-1-irogers@google.com>
 <20260926062029.800743-1-irogers@google.com>
 <20260926062029.800743-25-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 26 Sep 2026 06:29:53 +0000
Message-Id: <20260926062953.C8B101F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> Port failed-syscalls-by-pid.py to a standalone script in
> tools/perf/python/ using the perf module:
> - Resolve architecture-aware syscall names using
>   perf.syscall_name(id, session.e_machine) instead of host python-audit
>   tables, supporting cross-architecture perf.data files without external
>   dependencies.
> - Translate negative syscall return values into symbolic E* error names
>   using perf.arch_strerrno(ret, session.e_machine), leveraging the
>   auto-generated trace beauty architecture errno tables.
> - Encapsulate aggregation in a SyscallAnalyzer class using
>   collections.defaultdict and add argparse filtering by comm, PID, and
>   -i/--input.
>=20
> Add a shell test (test_failed_syscalls_by_pid_python.sh) to verify the
> standalone script.
>=20
> Assisted-by: Antigravity:gemini-3.1-pro
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260926062029.8007=
43-1-irogers@google.com?part=3D24

