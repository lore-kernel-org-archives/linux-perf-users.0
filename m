Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 069C6288AD
	for <linux-perf-users@vger.kernel.org>; Sat, 25 Apr 2026 23:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777159102; cv=none; b=VtyGKMFaOTNvlxZIg0mZUdcJs8tLPjFMARdonJXw8GdqnxatZi7eXuemmr3nYMPYBtVhDJEhreGEI9dGVV1hWhUm2P99XduJWVXK+Y/r0RS2qUiIkKM72aD/L+kEvqFM17hQ/4R5vUR5XxmAqSQZiwtiOI9oQg9bovrrkfSDEw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777159102; c=relaxed/simple;
	bh=DicDD34mrCewfButEhv1tq+uPDPruIg8PqBTSWhhpts=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=UAIBJhGk2foAGofeNIUNrmAwBMZtIkiKu2kON9ha8hojERXk8D/U2D+k0ny6Ra3x5Ajg939uDUi1jwzSdmbp2GxqX+/mPbA1XTT/OXlUmOaNd0yzW2seZn+4MtBLGhS9h961sfhVjHXw6t5NmfatOBIvrJRlECyrWc/nM3fFC/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bKBvgPbP; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bKBvgPbP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96076C2BCB0;
	Sat, 25 Apr 2026 23:18:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777159101;
	bh=DicDD34mrCewfButEhv1tq+uPDPruIg8PqBTSWhhpts=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=bKBvgPbPhmbnZT2/JElRKDjxCoa4OQxMamzLycg1nX1FCey77U/3l+ulAkllLbgwv
	 MeH5D3OgXb+jZTdKfhlx/cvyvewudzvU15YbRhpRWXvoZ8SVCeI/zRc0F7h4LhT4Yl
	 Nb+oiNn1j0zdJl0Y3CuQRduzIzRo+SFN3DggxwAlW7TahCDYUROA1wYdkK0CnhuORg
	 4VH28WHj4jCFaigUCG63Mj0lO3Uj+FXLGj42rQoaMEZeoMpxpHxej0MyzSwc7o12T7
	 7boDfgYKGqQzJe1e9CyITD+eIMcIBuEmC0dokrCGscqQ2rXGb2+Mbq/iYVmRQuHR0X
	 sGg3oIDmU1HMQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 57/59] perf Documentation: Update for standalone
 Python scripts and remove obsolete data
Reply-To: sashiko@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260425224951.174663-58-irogers@google.com>
References: <20260425224951.174663-58-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 25 Apr 2026 23:18:21 +0000
Message-Id: <20260425231821.96076C2BCB0@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Sashiko AI review found 3 potential issue(s):
- [Medium] Documentation for `find_thread(tid)` masks a data corruption bug=
 in the Python C extension
- [Low] Documentation for perf.data constructor documents an invalid signat=
ure and missing constant
- [Low] Python API documentation suggests unsupported keyword arguments and=
 None defaults
--

commit 6de02871e86f08211c8d4dbd0decc0fdb308b5bd
Author: Ian Rogers <irogers@google.com>

perf Documentation: Update for standalone Python scripts and remove obsolet=
e data

This commit updates the perf-script-python documentation to describe the
new standalone script usage with the perf module. It also removes obsolete
documentation for perl scripts.

> diff --git a/tools/perf/Documentation/perf-script-python.txt b/tools/perf=
/Documentation/perf-script-python.txt
> index 27a1cac6fe76..6bcf98e4e6c6 100644
> --- a/tools/perf/Documentation/perf-script-python.txt
> +++ b/tools/perf/Documentation/perf-script-python.txt

[ ... ]

> +### Module Functions
> +
> +- `config_get(name)`: Get a perf config value.
> +- `metrics()`: Returns a list of metrics represented as string values in=
 dictionaries.
> +- `tracepoint(subsystem, name)`: Get tracepoint config.
> +- `parse_events(string)`: Parse a string of events and return an `evlist=
`.
> +- `parse_metrics(string, pmu=3DNone)`: Parse a string of metrics or metr=
ic groups and return an `evlist`.
> +- `pmus()`: Returns a sequence of PMUs.
> +- `syscall_name(num, *, elf_machine=3DNone)`: Turns a syscall number to =
a string.
> +- `syscall_id(name, *, elf_machine=3DNone)`: Turns a syscall name to a n=
umber.

Are these keyword arguments and None defaults actually supported by the
underlying C extensions?

The C extensions, such as pyrf__parse_metrics, appear to use PyArg_ParseTup=
le
without PyArg_ParseTupleAndKeywords. This means keyword arguments are
unsupported and would cause a TypeError. Furthermore, passing None as a
positional argument to satisfy the default value might also cause a TypeErr=
or
because the C parser expects strict types like a string or an int.

[ ... ]

> +### `perf.session`
> +
> +Manages a trace session.
> +
> +- `__init__(data, sample=3DNone)`: Creates a new session. `data` is a `p=
erf.data` object. `sample` is a callback function called for each sample ev=
ent.
> +- `process_events()`: Reads the trace data and calls the sample callback=
 for each event.
> +- `find_thread(tid)`: Returns the thread associated with a TID.

Is it safe to use this find_thread(tid) method as documented?

The C extension pyrf_session__find_thread parses this single argument into a
pid variable and calls machine__find_thread(machine, pid, pid).

By passing the TID as both the Thread Group ID (PID) and the TID, it trigge=
rs
machine__update_thread_pid(machine, th, pid), which forcibly overwrites the
thread's actual PID with its TID if the PID was previously unresolved.

Will this cause the internal thread representation to become disassociated
from its process leader, leading to logic errors in scripts?

> +### `perf.data`
> +
> +Represents a trace file.
> +
> +- `__init__(filename, mode=3Dperf.DATA_MODE_READ)`: Opens a trace file.

Does the C extension pyrf_data__init support keyword arguments?

It seems to only accept positional path and fd arguments, and does not supp=
ort
kwargs. Also, is the perf.DATA_MODE_READ constant actually exported by the =
perf
module? If not, scripts relying on this documentation could fail with an
AttributeError or TypeError.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260425224951.1746=
63-1-irogers@google.com?part=3D57
