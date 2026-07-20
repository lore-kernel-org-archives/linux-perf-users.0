Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6EA62F7EF4
	for <linux-perf-users@vger.kernel.org>; Mon, 20 Jul 2026 11:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784546270; cv=none; b=b9BnZDcoI2Kpv3vr9qu2Va3lcSpbIn4Wpqkfkz/EIPg7Ilnr/nq0s/Qy5PCC9PwCNdsp8sz+NukIjJzzsu3curR6CjUTmGMvbNcf8ViNPFf5eGgyQK3Q1coKen1stkcIVkLrL6ShAI8vzaWdrqvLz0ihDiwHZtA47wJX2o7hQho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784546270; c=relaxed/simple;
	bh=hrTthkQlZKyPmvGVXJh+uqOSpT5H9PMRLty/rKa330o=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=aecmH1v08KF57UELBcAK/x58stOGKhKynjOySpKLYcRhn2lDUe8K1M7xPmRJAng8SxES+CmHVUjDw1Z8Tl1Sn7k0XwTpUKSaCBLo+Bs7VcsLuwDbhp6C0TSoV5IoHGSDeY8T1Ml19qb1Kt/6fK1xlsSEtU69Iytn1IYdjh+HZAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hRKwzGMs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hRKwzGMs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95D4A1F00A3D;
	Mon, 20 Jul 2026 11:17:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784546268;
	bh=UH/xXqseWCKCltw8swEjeFIhmSrrhA4QkffCy8TkXCY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=hRKwzGMslKyDnx7cRYAP8ORMhNHlSP5ctNvz1beYpft3emgpbzI4kq8CcOhP6oEv3
	 av4Tx5BepDmKVWVyr3may3DWN8GIbGJQttLGKlhShIVQomRCqbHDbK9yYc/lKxvmcP
	 ZF+5mSk7ry3WvHIt1ZwXvf+PmnWjvplIQkxVzrlHGxi3TSLmuy7JwduQjAPjbLLieq
	 /9fViL+q+QtmLT7Phstk4RTDVFwRn0G5K2EV0rM1a0RtGqbd8hXM8dEL7vcehdXor5
	 wlSzlkC6GYAjFmRiH1XWsFeKa5MuQ5RT2rRfN1s6e9UKYt9nAlMtqvX+F5Qnnbbt5S
	 z/kzximqsADiA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH V2 6/6] powerpc/perf/htm: Add documentation for Hardware
 Trace Macro PMU
Reply-To: sashiko-reviews@lists.linux.dev
To: "Athira Rajeev" <atrajeev@linux.ibm.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260720104447.11843-7-atrajeev@linux.ibm.com>
References: <20260720104447.11843-1-atrajeev@linux.ibm.com>
 <20260720104447.11843-7-atrajeev@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 20 Jul 2026 11:17:48 +0000
Message-Id: <20260720111748.95D4A1F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [Medium] The documentation states that `perf record` or `perf report -D` =
generates specific binary output files (`htm.bin.*` and `translation.*`), b=
ut this functionality does not exist in the upstream `tools/perf` codebase.
- [Medium] The commit message claims to document `htmdecode` usage and note=
s on PMU restrictions, but these sections are entirely missing from the doc=
umentation text.
- [Low] There are several grammatical errors, typos, and inconsistencies in=
 the newly added documentation text.
--

--- Patch [6]: [PATCH V2 6/6] powerpc/perf/htm: Add documentation for Hardw=
are Trace Macro PMU ---
commit 630c94afa3c07b9d61db47792f5a5e0b40edd107
Author: Athira Rajeev <atrajeev@linux.ibm.com>

powerpc/perf/htm: Add documentation for Hardware Trace Macro PMU

This commit extends the HTM documentation with a new section covering the
perf PMU interface. It describes event configuration, syntax, basic usage
examples, and expected output files.

>     The added documentation covers:
>    =20
>       - How to open HTM events using perf record, including the event
>         syntax (nodalchipindex, nodeindex, htm_type, cpu=3DN) and the
>         required AUX buffer size (-m,256).
>    =20
>       - The two output files produced by perf report:
>           htm.bin.nX.pX.cX     raw bus-trace AUX data
>           translation.nX.pX.cX memory-configuration records
>    =20
>       - How to pass the output files to htmdecode for trace decoding.
>    =20
>       - Notes on system-wide collection (-a) vs CPU-pinned collection
>         (-C N) and the one-event-per-target PMU restriction.

[Severity: Medium]
The commit message claims to document htmdecode usage, as well as notes on
system-wide vs CPU-pinned collection and PMU restrictions, but these sectio=
ns
appear to be missing entirely from the added documentation text. Did these =
get
dropped during patch iteration?

> diff --git a/Documentation/arch/powerpc/htm.rst b/Documentation/arch/powe=
rpc/htm.rst
> index fcb4eb6306b16..d574fd2225ea5 100644
> --- a/Documentation/arch/powerpc/htm.rst
> +++ b/Documentation/arch/powerpc/htm.rst
[ ... ]
> @@ -94,7 +95,137 @@ This trace file will contain the relevant instruction=
 traces
>  collected during the workload execution. And can be used as
>  input file for trace decoders to understand data.
> =20
> -Benefits of using HTM debugfs interface
> +HTM perf interface usage
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[ ... ]
> +- event: "config:0-27"
> +- htm_type: "config:0-3"
> +- nodeindex: "config:4-11"
> +- nodalchipindex: "config:12-19"
> +- coreindexonchip: "config:20-27"
> +
> +1) nodeindex, nodalchipindex, coreindexonchip: this specifies
> +   which partition to configure the HTM for.
> +2) htmtype: specifies the type of HTM.

[Severity: Low]
This isn't a bug, but should this say htm_type instead of htmtype to match
the parameter list above?

> +
> +Event Syntax
> +------------
> +
> +The event configuration uses named parameters::
> +
> +   htm/nodeindex=3DN,nodalchipindex=3DC,coreindexonchip=3DR,htm_type=3DT/
> +
> +To open the event on a specific cpu can be specified using::

[Severity: Low]
This isn't a bug, but there is a grammatical error here. Could this be upda=
ted
to something like "Opening the event on a specific CPU can be specified
using::"?

> +
> +   htm/nodeindex=3DN,nodalchipindex=3DC,coreindexonchip=3DR,htm_type=3DT=
,cpu=3Dx/
> +
> +Where:
> +
> +- N =3D node index
> +- C =3D chip index within the node
> +- R =3D core index on the chip
> +- T =3D HTM type
> +- x =3D CPU number
> +
> +Basic Usage Example
> +-------------------
> +
> +To collect HTM trace data for a specific chip:
> +
> +.. code-block:: sh
> +
> +   # perf record -C 1 -e htm/nodalchipindex=3D2,nodeindex=3D0,htm_type=
=3D1/ <workload>
> +
> +In this example:
> +
> +- ``-C 1``: Collect on CPU 1
> +- ``nodeindex=3D0``: Target node 0
> +- ``nodalchipindex=3D2``: Target chip 2 within node 0
> +- ``htm_type=3D1``: HTM trace type 1
> +
> +.. code-block:: sh
> +
> +   # perf record -m,256 -e htm/coreindexonchip=3D6,nodalchipindex=3D0,no=
deindex=3D0,htm_type=3D2,cpu=3D16/ -a sleep 1
> +
> +In this example:
> +
> +- ``cpu=3D16``: Collect on CPU 16
> +- ``nodeindex=3D0``: Target node 0
> +- ``nodalchipindex=3D0``: Target chip 0 within node 0
> +- ``coreindexonchip=3D6``: Target code 6

[Severity: Low]
This isn't a bug, but there's a typo here. Should "Target code" be
"Target core"?

> +- ``htm_type=3D2``: HTM trace type 2
> +- ``-m,256``: specifies number of mmap pages
> +
> +Running trace collection for multiple targets:
> +
> +.. code-block:: sh
> +
> +   # perf record -m,256 -e htm/nodalchipindex=3D2,nodeindex=3D0,htm_type=
=3D1,cpu=3D8/ -e htm/nodalchipindex=3D1,nodeindex=3D0,htm_type=3D1,cpu=3D9/=
 -a sleep 1
> +
> +
> +In this example, trace is collected for two events on different target c=
hips
> +
> +Output Files
> +------------
> +
> +After running ``perf record``, the following files are generated:
> +
> +.. code-block:: sh
> +
> +   # ls htm.bin.*
> +   htm.bin.n0.p2.c0 htm.bin.n1.p3.c0  # Binary trace files
> +
> +   # ls translation.*
> +   translation.n0.p2.c0  translation.n1.p3.c0  # Memory configuration fi=
les
> +
> +These files contain:
> +
> +- **htm.bin.*** - Raw HTM trace data in binary format
> +- **translation.*** - Memory address translation information for decoding
> +
> +Complete Workflow Example
> +--------------------------
> +
> +Here's a complete example of collecting and analyzing HTM traces:
> +
> +.. code-block:: sh
> +
> +   # Step 1: Collect trace data
> +   perf record -C 1 -e htm/nodalchipindex=3D2,nodeindex=3D0,htm_type=3D1=
/ sleep 5
> +
> +   # Step 2: Verify output files
> +   perf report -D
> +
> +   ls htm.bin.*        # Binary trace files
> +   ls translation.*    # Memory configuration files

[Severity: Medium]
Does perf report -D natively generate these specific binary output files
(htm.bin.* and translation.*) in the upstream tools/perf codebase?

This documentation seems to describe a non-existent feature in upstream
tools/perf and might rely on out-of-tree tooling that was not included in
this patch series. Should this be updated to reflect only supported feature=
s?

> +   ls perf.data        # Perf data file
> +
> +Benefits of using HTM interface

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260720104447.1184=
3-1-atrajeev@linux.ibm.com?part=3D6
