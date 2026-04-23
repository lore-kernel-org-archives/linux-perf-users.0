Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9DF3359A74
	for <linux-perf-users@vger.kernel.org>; Thu, 23 Apr 2026 05:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776922296; cv=none; b=XOvc1VZpex56uvkVkr9cHX+alh8RuHWxQ5SqyJvtHb73cLEHE1lBmjpNTFI3ysj0Xi41kdHSpWY9y65JCWPKX++gNP6HGWo09evoefHDuKAM34+W1K3xQ1z2PvxJ665s7qzLabg3PAyi3x4UILRc9ENi3nvqKKU2SENu1g9zs4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776922296; c=relaxed/simple;
	bh=Dpnb+jB9yIGecfYSbCDn1RAXZm2i8UQJi+56vhXO3zY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=hQqWN//v7aidyxMOv3QFgt/bLL5ZqvAA4ASnPy1ZyzUKRDwEbDGlKaI5hvR08QF+EJ0whLvnedv7RiJCCwfqxsdkLSVKOrKUH3JQNgEw8/tIh2nah20YvXclSxzgNPNl6/agxvV63K5PrAb1eUQRAumO7iptRlsH86fVKmOxKic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F7NNrNhB; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F7NNrNhB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 679C9C2BCB2;
	Thu, 23 Apr 2026 05:31:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776922296;
	bh=Dpnb+jB9yIGecfYSbCDn1RAXZm2i8UQJi+56vhXO3zY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=F7NNrNhBP1Zl0AucUdKUyX3q0EAnkWsTO4BzUqIHBFpDUpivqAAyWGtyqsrvLH3uW
	 JhysLoud7dyFb7tQ6FaY+lWMWPEaQA0jJCg6kPF2tbscAu4SpBakhk9NS2yxHJICcc
	 e6JQ75xhg8Z2hSpAc4MkVjhhHDSi0fTL7Hzqqf/OUchdzSw1/63naO+fF3F7Q7/PhG
	 jgKsfujuNQIKT2t+2gfz3890EfG+NO8HMdd36kDG7741APFiChEnRQS7XpHHWLauoC
	 YVEr6O5EPqjp2kdifvkneHoXRONq5nvX6xB76Aj1SeTMmtlvvErUJsb1ezJdKK+6gd
	 F6LhgwWEssGfQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 57/58] perf Documentation: Update for standalone
 Python scripts and remove obsolete data
Reply-To: sashiko@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260423035526.1537178-58-irogers@google.com>
References: <20260423035526.1537178-58-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 23 Apr 2026 05:31:35 +0000
Message-Id: <20260423053136.679C9C2BCB2@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Sashiko AI review found 2 potential issue(s):
- [Medium] Incorrect Python API documentation for perf.data.__init__ causin=
g runtime errors
- [Low] Obsolete reference to 'report mode' in --show-info documentation
--

commit c8608ebf0770d6f59d09319da7fc7cb3688932bb
Author: Ian Rogers <irogers@google.com>

perf Documentation: Update for standalone Python scripts and remove obsolet=
e data

This commit removes obsolete perf script documentation for Perl and older P=
ython
modes, and updates the Python documentation to reflect the new standalone
script usage with the perf module.

> diff --git a/tools/perf/Documentation/perf-script-python.txt b/tools/perf=
/Documentation/perf-script-python.txt
> index 27a1cac6fe763..9293057cee8e2 100644
> --- a/tools/perf/Documentation/perf-script-python.txt
> +++ b/tools/perf/Documentation/perf-script-python.txt

[ ... ]

> +### `perf.data`
> =20
> -ev_name, comm, id, stream_id, pid, tid, cpu, ip, time, period, phys_addr,
> -addr, symbol, symoff, dso, time_enabled, time_running, values, callchain,
> -brstack, brstacksym, datasrc, datasrc_decode, iregs, uregs,
> -weight, transaction, raw_buf, attr, cpumode.
> +Represents a trace file.
> =20
> -Fields that may also be present:
> -
> - flags - sample flags
> - flags_disp - sample flags display
> - insn_cnt - instruction count for determining instructions-per-cycle (IP=
C)
> - cyc_cnt - cycle count for determining IPC
> - addr_correlates_sym - addr can correlate to a symbol
> - addr_dso - addr dso
> - addr_symbol - addr symbol
> - addr_symoff - addr symbol offset
> +- `__init__(filename, mode=3Dperf.DATA_MODE_READ)`: Opens a trace file.

Is the signature __init__(filename, mode=3Dperf.DATA_MODE_READ) consistent
with the underlying C extension implementation?

Looking at pyrf_data__init in python.c, it appears to use
PyArg_ParseTupleAndKeywords with the keyword list {"path", "fd", NULL} and
hardcodes the internal mode to PERF_DATA_MODE_READ.

It also seems DATA_MODE_READ is not exported as a constant to Python in the
perf__constants array. Additionally, the .pyi stubs specify
def __init__(self, path: str =3D ..., fd: int =3D ...).

If a user follows this documentation and passes mode=3Dperf.DATA_MODE_READ,
will their script crash with an AttributeError for the missing constant and=
 a
TypeError for the invalid keyword argument?

[ ... ]

> diff --git a/tools/perf/Documentation/perf-script.txt b/tools/perf/Docume=
ntation/perf-script.txt
> index 200ea25891d88..93ed1ea704c95 100644
> --- a/tools/perf/Documentation/perf-script.txt
> +++ b/tools/perf/Documentation/perf-script.txt

[ ... ]

> @@ -23,52 +20,9 @@ There are several variants of perf script:
>    'perf script' to see a detailed trace of the workload that was
>    recorded.
> =20
> -  You can also run a set of pre-canned scripts that aggregate and
> -  summarize the raw trace data in various ways (the list of scripts is
> -  available via 'perf script -l').  The following variants allow you to
> -  record and run those scripts:
> -
> -  'perf script record <script> <command>' to record the events required
> -  for 'perf script report'.  <script> is the name displayed in the
> -  output of 'perf script --list' i.e. the actual script name minus any
> -  language extension.  If <command> is not specified, the events are
> -  recorded using the -a (system-wide) 'perf record' option.
> -
> -  'perf script report <script> [args]' to run and display the results

Since the perf script report functionality is removed here, should the
documentation for the --show-info option also be updated?

Further down in this file, the documentation for --show-info currently
states: "It can only be used with the perf script report mode."

As this mode no longer exists and the option functions independently in the
C implementation, does leaving this text mislead users into thinking the
option is tied to a deprecated mode?

> -  of <script>.  <script> is the name displayed in the output of 'perf
> -  script --list' i.e. the actual script name minus any language
> -  extension.  The perf.data output from a previous run of 'perf script

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260423035526.1537=
178-1-irogers@google.com?part=3D57
