Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B8BF282F3D
	for <linux-perf-users@vger.kernel.org>; Sat, 25 Apr 2026 23:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777158578; cv=none; b=nLLMcIBG8IRgtuNCUl5yLoxzEBdPHIUKjdl4Uguc9tp3kpa9pJi1ml+At7C96jtpcRILFP0mZxqU7Mgm5xsZ3W+AcaEnyLoapKG1jY/xjj5WnVpdt+cZ2c82bJrdq74mItjNE4vcz2c0KVfYgB/i7gDmuVTkpLF9oNsdEj6Dhik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777158578; c=relaxed/simple;
	bh=6Z7p0+K7mqEjuPWPUWAZmdJa8kqOvBhuOBV/byYTwY4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=vFbdWOWHmVczXAInk1TvZtbsFkZaxg5r35cpU8w/kPxrmK/iNqKSERQIaFCoYTqASS20HXysEq64cJqxAHmQk8MohYUjokVTv7FITda/NAnJz44D2eDcJBpX9YkUQh+vC0ru0/2ATsNJPYfnbdklEH8jykp3KtoYaz8jDiKBnMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pqxlvGck; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pqxlvGck"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26979C2BCB0;
	Sat, 25 Apr 2026 23:09:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777158578;
	bh=6Z7p0+K7mqEjuPWPUWAZmdJa8kqOvBhuOBV/byYTwY4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=pqxlvGckGE6y/RNRbboYipM7x5cod5YWhPS0z2cSpKHPArLyPhhibdilBjPJrGs4W
	 QB3umo7xbGI0PfxfIZNk8A5W8f9+ZaSCA2IUIccxQj5+m5uz7VoeXq5XT1TECMXFH/
	 cD1CVykfmd/bMs8G5f7xg9YZHqmhMKt2DD/7nAdsSmX2HtaLdmq9JgBciOnExZZcwS
	 WpBiod0SuyTXAqDt1/8GAUacxRoFfM8fLfmiHp+sGc4xQm0IuKBVlNjMec0cEMZroi
	 r+veIUcxeynQhtMEVLmfmWpoCftKpFDMI8s2F6ABmo69w2rxY9kGMS1Ttcr4r0bp9w
	 FjkiEZ0G4Ed5g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 48/59] perf rw-by-file: Port rw-by-file to use python
 module
Reply-To: sashiko@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260425224951.174663-49-irogers@google.com>
References: <20260425224951.174663-49-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 25 Apr 2026 23:09:37 +0000
Message-Id: <20260425230938.26979C2BCB0@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Sashiko AI review found 1 potential issue(s):
- [Medium] The script attempts to handle raw_syscalls by checking for non-e=
xistent tracepoints 'raw_syscalls:sys_enter_read' and 'raw_syscalls:sys_ent=
er_write'.
--

commit 6ba947a0e950d21d736be641eba61cb05dfe1d4d
Author: Ian Rogers <irogers@google.com>

perf rw-by-file: Port rw-by-file to use python module

This patch ports the legacy Perl script rw-by-file.pl to a python script
using the perf module. It tracks read and write activity by file descriptor
for a given program name, aggregating bytes requested/written and total cou=
nts.

> diff --git a/tools/perf/python/rw-by-file.py b/tools/perf/python/rw-by-fi=
le.py
> new file mode 100755
> index 000000000000..2103ac0412bb
> --- /dev/null
> +++ b/tools/perf/python/rw-by-file.py

[ ... ]

> +    def process_event(self, sample: perf.sample_event) -> None:
> +        """Process events."""
> +        event_name =3D str(sample.evsel)[6:-1]

[ ... ]

> +        if comm !=3D self.for_comm:
> +            return
> +
> +        if event_name in ("syscalls:sys_enter_read", "raw_syscalls:sys_e=
nter_read"):

Are raw_syscalls:sys_enter_read and raw_syscalls:sys_enter_write actual
tracepoints? The raw_syscalls subsystem typically only defines sys_enter
and sys_exit.

If the intent was to monitor raw_syscalls:sys_enter, wouldn't this require
intercepting raw_syscalls:sys_enter, checking the syscall number in the id
field, and parsing the arguments array?

> +            try:
> +                fd =3D sample.fd
> +                count =3D sample.count

It appears that raw_syscalls samples do not natively expose named properties
like sample.fd or sample.count.=20

Does this mean the script could simply check for syscalls:sys_enter_read and
syscalls:sys_enter_write instead?

> +                self.reads[fd]["bytes_requested"] +=3D count
> +                self.reads[fd]["total_reads"] +=3D 1
> +            except AttributeError:
> +                self.unhandled[event_name] +=3D 1
> +        elif event_name in ("syscalls:sys_enter_write", "raw_syscalls:sy=
s_enter_write"):
> +            try:
> +                fd =3D sample.fd
> +                count =3D sample.count
> +                self.writes[fd]["bytes_written"] +=3D count

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260425224951.1746=
63-1-irogers@google.com?part=3D48
