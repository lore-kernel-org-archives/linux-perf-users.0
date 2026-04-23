Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12667346E7B
	for <linux-perf-users@vger.kernel.org>; Thu, 23 Apr 2026 04:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776917737; cv=none; b=Pu7OfYpUzXSg15A5tWFAi4+2r+ENDID1TdvHGFLZqyg8pdb1j4BoOnlTh2rgk+JiLn7TKvdUY+yMtlSi/AzSE6jBMmEw1ZZitM20LkQjPJotQuhyGq61ZGqJi0aotWdOyEKS1oPOkL0N3Rqu7P6dq+dFiRlOhOojdSj/RSwNikY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776917737; c=relaxed/simple;
	bh=HkDKudZW7v8iFAxK4hSsfDKNZP9+t689r/qvGwh1Suc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=VqAp4UGEpvU3ZKD/1CBiRoWR1tB8CQzFfhC/KcuareiJJffNvHzLC3G8LxgGMZYZoa3kaz5Y7tLDXlTAGMjifihgkONm0uxAj/oanbE0Vo6aOphmMWhAhH1WWjJkGmsXuSLSu7l1D+gBX/fIv5e80rg+YlgiotXviLw/XL52GvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JJ8kkQlS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JJ8kkQlS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94085C2BCB2;
	Thu, 23 Apr 2026 04:15:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776917736;
	bh=HkDKudZW7v8iFAxK4hSsfDKNZP9+t689r/qvGwh1Suc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=JJ8kkQlS2pINSEah03h0ZPvg/OxAhZffrmAQVfgOewE9N0K0Q2k6mIhKJOEQwVDgt
	 jUvVBwiwjgh5Ak1b7YN4RNiTCbz/RdNzhmw0HLiDzsItNbC81d3cox/HghSCSGp+Dg
	 89ceCuG16jXXCalU3G29nypOD2BXc+sPBdTX5JJ8kwC7O6Sj8ROkz/vwIX01mynFgY
	 W/K6ElX/OMP4ek2r3wa6stI08lsHKZ5/jD5i6jzAY4PnD/ZMwWvUv000yPpuKJQFuN
	 9dOL6rnR6g0QCrQGekrTljUP/eX3EMVR9V21ZLn/+EfYSbHK1V7ay+vAE9hlnyspYB
	 eJjq7hz510Mcg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 42/58] perf powerpc-hcalls: Port powerpc-hcalls to
 use python module
Reply-To: sashiko@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260423035526.1537178-43-irogers@google.com>
References: <20260423035526.1537178-43-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 23 Apr 2026 04:15:35 +0000
Message-Id: <20260423041536.94085C2BCB2@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Sashiko AI review found 2 potential issue(s):
- [Medium] The script attempts to access the event timestamp via `sample.ti=
me`, which does not exist and will raise an `AttributeError`.
- [Medium] The script uses `sample_pid` (process ID) to track hypercalls, c=
ausing state collisions and data corruption for multi-threaded applications.
--

commit 513528145437ce5fa89bb95f8f8f46b59f1f4d00
Author: Ian Rogers <irogers@google.com>

perf powerpc-hcalls: Port powerpc-hcalls to use python module

This commit refactors the powerpc-hcalls script to use the perf.session
module instead of legacy tracepoint handlers. It introduces the
HCallAnalyzer class to encapsulate state and tracks hypervisor call entry
and exit to calculate durations and aggregate statistics.

> diff --git a/tools/perf/python/powerpc-hcalls.py b/tools/perf/python/powe=
rpc-hcalls.py
> new file mode 100755
> index 0000000000000..c4fa539174c9d
> --- /dev/null
> +++ b/tools/perf/python/powerpc-hcalls.py
[ ... ]
> +    def process_event(self, sample: perf.sample_event) -> None:
> +        """Process a single sample event."""
> +        name =3D str(sample.evsel)
> +        pid =3D sample.sample_pid

Does using sample_pid cause state collisions for multi-threaded
applications?

Since sample_pid maps to the process ID (TGID) in perf tools, concurrent
hypercalls from different threads in the same process would share the same
sample_pid. This could cause threads to overwrite each other's entry
records in the d_enter dictionary, leading to unmatched exits and incorrect
duration calculations.

Would it be safer to use sample_tid or sample_cpu (as the legacy script did
with common_cpu) to prevent these collisions?

> +        time =3D sample.time

Will accessing sample.time raise an AttributeError on the first event?

Looking at the perf Python C extension, the timestamp field for a
sample_event is explicitly exposed to Python as sample_time rather than
time. Since the tracepoint does not have a dynamic field named time, the
script might crash when attempting to read it.

> +        opcode =3D getattr(sample, "opcode", -1)
[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260423035526.1537=
178-1-irogers@google.com?part=3D42
