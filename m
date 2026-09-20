Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7231345ED9
	for <linux-perf-users@vger.kernel.org>; Sun, 20 Sep 2026 05:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789882490; cv=none; b=BAlvWLHYavSb5u/VcCcUwGUh4JyOJjjgAvNz9ZkF7HHw7Oyuo2RGoEybWpgBxJPs7gG33OMgsuVLVackmvhnn3L0Tz94H1JP1xvLrK/cWcYILdGlzoXikQGckClfVXgsTEu22cN0wAM21iYonFDJnGux5WkqAmQlxlkJjFAfYKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789882490; c=relaxed/simple;
	bh=eFO+BAONt9Buwjak9/V+gFg5Gzsjc8Ug/AtE59KQ3Cs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=txAbBMzfliVlSbfnDA8Vg1klEp9kw/2K8HKU+TzbXw2zF8QCv3z+rUSzrBu8uXLzYr3HpiosH81t/gRtQl4MklpxgkUWRKeikNqvTlz9ZNfywb4DIAHIbPHYlLSbdgPQs2UQpfpUEPkkd7cJvqtCBmmGrBOcYC/mdIeQrnV7vn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NK56I7am; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NK56I7am"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 189061F000FF;
	Sun, 20 Sep 2026 05:34:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789882489;
	bh=otBCIWlrZCX4DD2LzJuTOkrpfKCyoYjL2YEstIkUW6k=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=NK56I7amIMFqxuWteG2EULTOIyeC4E8WXDGOjBR7qP1KjXqdR/7eDZuzuoz3VJvFd
	 Olmi+lyCTFnysgXM1Y9oAfItXzVeP/YlvYEu5jjebULAPOcBr1jBiRHxUCl7N7eB6S
	 7Csz5l5rXHCXn+gtfrPHM2eRJJAODXolQIoiBor2RujCE/JVDuUnuH1zdxI1f/S3yR
	 he5T+gW2fvUxUVZI+JfTWS6jsPSYwTYgEQ8ic8tP0bpF53D4/crWvFZUzT3JLROVs4
	 VWeOuCvSZvuP9dBl0aUHz5Gg4p1lxzb6xxuBAhrjgcJF4YiZRU7xxbLQ5Gb/PYhpfB
	 20w5l0rDG3t+Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 24/49] perf python: Port failed-syscalls-by-pid to
 perf module
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <5259e3b062f459b38e8ced684c13f838227579d9.1789880842.git.irogers@google.com>
References: <cover.1789880842.git.irogers@google.com>
 <5259e3b062f459b38e8ced684c13f838227579d9.1789880842.git.irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 20 Sep 2026 05:34:48 +0000
Message-Id: <20260920053449.189061F000FF@smtp.kernel.org>
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
>   using errno.errorcode and architecture-specific session.e_machine
>   overrides.
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1789880842.gi=
t.irogers@google.com?part=3D24

