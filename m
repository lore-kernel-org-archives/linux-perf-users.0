Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B848738C2B0
	for <linux-perf-users@vger.kernel.org>; Sat, 25 Apr 2026 23:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777158467; cv=none; b=gULjsaLzr8r7aRlR0Fq2cPsGWC/2x6nAbM86MfkpefK0B21jKPXdDGWjXMmOrpw7fv4J/gsfKh6TvFJIlkSzGk7b85jZSFVDDO2KU+1lqhh2sBtHID7L4+ZgXhC+Zq9Eh3JjUki4zeT7qWxkkr4M1eAP0g/eN0guFrJy2l9anMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777158467; c=relaxed/simple;
	bh=BX+FZfRkjtQAWUogTJqoiefVIXHOLUBhPtjfLgZ+WRs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=jEVwCxrOZLHdIvmzTROUTcaYzPhTza0/c6Wv6FNvs8gJrHVna0PTomXW0SXHeZh1YiEirsB+1sJY9iyZ1KdFoXd7h1TbsL8Q0qo/ya6sumijyQMBIOhb0a5N7/bnUQE3TH/tEdDC8EHp6PedjNF9o1hTxjODEkGc6ahOYmjVe+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QiRPSISA; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QiRPSISA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F5EEC2BCB0;
	Sat, 25 Apr 2026 23:07:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777158467;
	bh=BX+FZfRkjtQAWUogTJqoiefVIXHOLUBhPtjfLgZ+WRs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=QiRPSISA0wx7ziKWYKr06QzViWlm+UGfBZ4s6XHNBVWBhjtXDdr3wnPpn2p3OGPOF
	 dz5kTFSCI/k3v5emPCnfwXAAzPsCcqKgx5Uobb+2vA/3n8qggsZzl9Ez/FG2odLugT
	 kkbzrx+TduDNN7PE7w4OkqmSyoHwncfCJodjG7EC0sDXHiZqH/nMZNibOAluqEIOQ4
	 U0K+BH3XlJD03wE1SPQhsIe+rqR8iHhLmYJ5XwFq4lkpoqm14z0hZHJ2X1uREV7Bin
	 bNfVu3Hv8q/a+qARZ1Ri9eLgilf4ye05NnZUkaldf6JoEn3Fq8UblpgUVki69BhMNH
	 s0HsS3DKRPlCg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 42/59] perf powerpc-hcalls: Port powerpc-hcalls to
 use python module
Reply-To: sashiko@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260425224951.174663-43-irogers@google.com>
References: <20260425224951.174663-43-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 25 Apr 2026 23:07:46 +0000
Message-Id: <20260425230747.5F5EEC2BCB0@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Sashiko AI review found 2 potential issue(s):
- [High] Accessing `sample.time` raises an `AttributeError`, causing the sc=
ript to fail on the very first event.
- [High] Tracking in-flight hypervisor calls by process ID (`pid`) instead =
of `cpu` corrupts statistics for multi-threaded applications.
--

commit 2cb59bf83787181fd674eab1ce36cd9e9c0c966a
Author: Ian Rogers <irogers@google.com>

perf powerpc-hcalls: Port powerpc-hcalls to use python module

This commit ports the powerpc-hcalls script to use the perf.session
python module. It refactors the code to use an HCallAnalyzer class for
state encapsulation and tracks hcall entry and exit to calculate
statistics.

> diff --git a/tools/perf/python/powerpc-hcalls.py b/tools/perf/python/powe=
rpc-hcalls.py
> new file mode 100755
> index 000000000000..c4fa539174c9
> --- /dev/null
> +++ b/tools/perf/python/powerpc-hcalls.py

[ ... ]

> +    def process_event(self, sample: perf.sample_event) -> None:
> +        """Process a single sample event."""
> +        name =3D str(sample.evsel)
> +        pid =3D sample.sample_pid
> +        time =3D sample.time

In the perf Python C extension, the timestamp attribute of a sample event
is exposed as sample_time, not time. Does accessing sample.time raise an
AttributeError here, causing the script to fail on the first event?

> +        opcode =3D getattr(sample, "opcode", -1)
> +
> +        if opcode =3D=3D -1:
> +            return
> +
> +        if name =3D=3D "evsel(powerpc:hcall_entry)":
> +            self.d_enter[pid] =3D (opcode, time)

Does tracking in-flight hypervisor calls by process ID (pid) corrupt
statistics for multi-threaded applications?

If multiple threads share the same PID and make concurrent hypervisor calls
on different CPUs, the second thread's entry will overwrite the first
thread's entry in self.d_enter[pid].

Since a single CPU can only execute one synchronous hypervisor call at a
time, would it be better to use sample.sample_cpu or sample.sample_tid as
the tracking key instead?

> +        elif name =3D=3D "evsel(powerpc:hcall_exit)":
> +            if pid in self.d_enter:
> +                opcode_entry, time_entry =3D self.d_enter[pid]
> +                if opcode_entry =3D=3D opcode:
> +                    diff =3D time - time_entry
> +                    del self.d_enter[pid]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260425224951.1746=
63-1-irogers@google.com?part=3D42
