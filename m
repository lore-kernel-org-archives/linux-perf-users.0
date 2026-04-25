Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 905CB38C438
	for <linux-perf-users@vger.kernel.org>; Sat, 25 Apr 2026 23:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777158577; cv=none; b=LR3SGPrQhsPrhN4kqnfetRJAJS12UmNvl9L9j4ht7LB3ODXapCTDe7+JK12nbCLOytlor2AYoaO25PeajPbCEFexFAJmIyzxY6iecLiafsWeV3tJhHcfn5pweijEFoyg6PW7px2jmevlgqZb0NElT/zz2mARaKYLs3CqaLX6Jy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777158577; c=relaxed/simple;
	bh=DVcU8D9RbP8/PrykEYAnkCoVnpgS13VCrN6TXK08UHY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Y+JYvemF2ClTa/jwTn3GsEA2t1p3iJqiiYQcPDVdNlJV8FMNYb0998V80goScMpU27p2HxlsJk5l37/tlzRr1kbWfRrdCw7Rs5gpNmEfA62YvEN1OPBoGTnLJFXtzwuN8NN0vUQCQ9EBt+2xMfRymHUy02n1NJHZ6r13BXxPvJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BETO9G06; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BETO9G06"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55EB5C2BCB0;
	Sat, 25 Apr 2026 23:09:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777158577;
	bh=DVcU8D9RbP8/PrykEYAnkCoVnpgS13VCrN6TXK08UHY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=BETO9G06xYtRL9dn36rXZsWgk3nWTZ3//im17ODkZkxVtc9BEAic2JrdjpBoAxsra
	 cuLsNKDRYx6UIfxiQRDZjd2t3zL8oniHpW2v0tGp9+eZKxTyk9/2Jng1shnltQJbJT
	 lv2EeEhYPG9kH4fc92CeQZhAyUa8G6PQzZTftxVhU0RrQQjUesSZPxH/KFBaDeWxj8
	 +hdCw8RAwQYZ9MIbnvjhoQLsMZ+W1jajNtT3BRZetnoi2QC2A26PLMLZkLg5jcodWm
	 f58Ezhx1HRv7qw7yIq6wzweYOpJOFEB/argtIgWPdYB5G3/u1cqbeDw4TviGnfAVFi
	 Mr78PJlKoUgYQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 27/59] perf syscall-counts: Port syscall-counts to
 use python module
Reply-To: sashiko@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260425224951.174663-28-irogers@google.com>
References: <20260425224951.174663-28-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 25 Apr 2026 23:09:36 +0000
Message-Id: <20260425230937.55EB5C2BCB0@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Sashiko AI review found 2 potential issue(s):
- [Medium] Exact string matching for `raw_syscalls:sys_enter` fails when ev=
ent modifiers are used.
- [Medium] Incorrect thread lookup using process ID instead of thread ID ca=
uses wrong `comm` resolution.
--

commit e1c06b28a740c4df695988f86705f8c023b5bea3
Author: Ian Rogers <irogers@google.com>

perf syscall-counts: Port syscall-counts to use python module

Rewrite tools/perf/scripts/python/syscall-counts.py to use the python
module and various style changes. By avoiding the overheads in the
perf script execution the performance improves by more than 4x.

> diff --git a/tools/perf/python/syscall-counts.py b/tools/perf/python/sysc=
all-counts.py
> new file mode 100755
> index 000000000000..ef2bd8c7b24c
> --- /dev/null
> +++ b/tools/perf/python/syscall-counts.py

[ ... ]

> +def process_event(sample):
> +    """Process a single sample event."""
> +    event_name =3D str(sample.evsel)
> +    if event_name =3D=3D "evsel(raw_syscalls:sys_enter)":

Will this exact string match fail if the event is recorded with a modifier?

If the event has a modifier like :k, str(sample.evsel) will include it
(e.g., evsel(raw_syscalls:sys_enter:k)). This would cause the exact equality
check to fail, and the events would be silently dropped, unlike the
subsequent startswith check for evsel(syscalls:sys_enter_ which correctly
handles suffixes.

> +        sc_id =3D getattr(sample, "id", -1)
> +    elif event_name.startswith("evsel(syscalls:sys_enter_"):
> +        sc_id =3D getattr(sample, "__syscall_nr", None)
> +        if sc_id is None:
> +            sc_id =3D getattr(sample, "nr", -1)
> +    else:
> +        return
> +
> +    if sc_id =3D=3D -1:
> +        return
> +
> +    comm =3D "unknown"
> +    try:
> +        if session:
> +            proc =3D session.find_thread(sample.sample_pid)

Does passing the process ID here misattribute events from child threads?

In perf, sample.pid (or sample_pid) represents the thread group leader ID
(TGID/process ID), while sample.tid represents the actual thread ID.

Passing the process ID means the script retrieves the comm of the main thre=
ad,
misattributing events from child threads that may have distinct names set v=
ia
prctl(PR_SET_NAME).

Should this use the thread ID (e.g., sample.sample_tid) to accurately resol=
ve
the thread and its comm?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260425224951.1746=
63-1-irogers@google.com?part=3D27
