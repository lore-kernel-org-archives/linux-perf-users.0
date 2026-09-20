Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C90FF33B970
	for <linux-perf-users@vger.kernel.org>; Sun, 20 Sep 2026 05:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789882634; cv=none; b=T0Ohvm/87NEKHjRxCzsMZUs+HzGMlwEegEFvlSaAB/gE7ytGqINMk1CxAv+FhspVBdFVEpRNvdb7EAp853KgUm+nRofAB/PCg5fXSCmYzYD0pX78D39HtZ4HgPn4weVQMlVIibzzJtzk7/57ZfPH+L8xF7r87Xxv2GTmTJtCcmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789882634; c=relaxed/simple;
	bh=uHLRmFQ4NwffI4HyNu4ygrEFVA/lBBPSLSgEBarP55c=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=rEbe9nnyuAlxMiKooU4GRVEQAcKkevMskl9Dbx0jjjraAK7Kq7vjEJ0idDN1gY1a416SB5gNSgdy7tptytLdnh1CJ7OIH3CDGiyYnPjaTZpjbTd1ckypMY+OG6FrhoioSXtJk62moNVB4GJLmr/I9jy0pfqp7yiu6jkmiq92GZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SIlvuXgR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SIlvuXgR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82EF21F000FF;
	Sun, 20 Sep 2026 05:37:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789882633;
	bh=ySQGI8P/9nm9p9DK7/VlzTqSUgm8b8rBc61RRnnyfsw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=SIlvuXgRdqMFgv7TN+m7n+CU8rwgsw+rb8ZO/WXH6PRtnQHQxawcZOBBVvzXlMQQt
	 0aFN6L3CxRIh3MxcR//hlmUz5ZoMll0+llMrxzXeULmNmfKfkk0UjdJ7pSQ018+IoH
	 0ddvmYyDwoeXKYX+AIXZEiWxo8zdKlf1qjcmvjs76wfS29s013SacDTMRYcgxzKAV8
	 wewkUsR0mwhLoFQtzLgVZfF+3S/nxpQZrzQC7BE7FAJOeKet4EJRBLNnxYJmd3d8bl
	 srXfKVJYy1fpApNGKhEOWytceLOh0o52d80SvysCGfLdGUZ4ssHnj0Lb/zBQ6PpKBL
	 Se0T0++WNMaEA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 23/49] perf python: Port syscall-counts-by-pid to
 perf module
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <beae673fc7309dcb3d51dfd729cc1b78ec97d97a.1789880842.git.irogers@google.com>
References: <cover.1789880842.git.irogers@google.com>
 <beae673fc7309dcb3d51dfd729cc1b78ec97d97a.1789880842.git.irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 20 Sep 2026 05:37:13 +0000
Message-Id: <20260920053713.82EF21F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] perf python: sample.id fallback bypasses syscall filter
--

commit 382862f26193c21e71a417f0682c83de767a4460
Author: Ian Rogers <irogers@google.com>

perf python: Port syscall-counts-by-pid to perf module

This commit ports the syscall-counts-by-pid script to a standalone script
in tools/perf/python/ using the perf module to improve execution speed. It
also resolves architecture-specific syscall names dynamically and supports
both raw_syscalls:sys_enter and syscalls:sys_enter_* tracepoints.

> diff --git a/tools/perf/python/syscall-counts-by-pid.py b/tools/perf/pyth=
on/syscall-counts-by-pid.py
> new file mode 100755
> index 0000000000000..6e340e8e71dfc
> --- /dev/null
> +++ b/tools/perf/python/syscall-counts-by-pid.py

[ ... ]

> +def process_event(sample):
> +    """Process a single sample event."""
> +    event_name =3D str(sample.evsel)
> +    if event_name.startswith("evsel(raw_syscalls:sys_enter"):
> +        sc_id =3D getattr(sample, "id", -1)
> +    elif event_name.startswith("evsel(syscalls:sys_enter"):
> +        sc_id =3D getattr(sample, "__syscall_nr", None)
> +        if sc_id is not None and (sc_id < 0 or sc_id > 0xffff):
> +            sc_id =3D None
> +        if sc_id is None:
> +            sc_id =3D getattr(sample, "nr", None)
> +            if sc_id is not None and (sc_id < 0 or sc_id > 0xffff):
> +                sc_id =3D None
> +            if sc_id is None:
> +                sc_id =3D getattr(sample, "id", -1)

[Severity: Medium]
When process_event() handles a syscalls:sys_enter_* tracepoint with an
invalid or missing __syscall_nr or nr, will getattr() retrieve the perf
event ID instead of the intended -1 fallback value?

Since the Python sample object has a built-in property id that maps to the
64-bit perf event ID, getattr(sample, "id", -1) will successfully read the
perf event ID rather than falling back to -1.

If the perf event ID happens to be <=3D 0xffff, could it bypass the subsequ=
ent
sc_id > 0xffff filter entirely and be incorrectly tallied as a valid syscal=
l?

> +    else:
> +        return
> +
> +    if sc_id < 0 or sc_id > 0xffff:
> +        return

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1789880842.gi=
t.irogers@google.com?part=3D23
