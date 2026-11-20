Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795139112;
	b=fS65x4spYySYo5qyniYmBTNfrEgvA5PywBpZicm6+tNcLXYoHddRIqG3O+X4FKuZLNiO
	 e7tkkPqFHMT92SB97oaE8hVrkGM3HY0Od1/Fw4bXJ7OLTPw2GkrkXTkwS0n+7jgTBMY53
	 EwkleWTtHZUe2jA3/oWHpzl+7o/6NLDnZSdbrzAsW8DDeTX1vYhr/JEhcIxvvOSuRHLL9
	 ffX5UDwp/ff/4bcdbQwCG0WTeqc2NIm7dWkxN2aq3LnKorItUr1vDDgSuLQYF+VTYj/k5
	 Oao6x5V8sM8z++m6VfXgXvskwpDOHx4ex2dIWqbdXE/lz3aW75sGR8k2NcS7q7j/Y8w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795139112;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=UPvOxl+SGskPtGaoXm0zTWhpLBQCC4wfVX1BDA/It9g=;
	b=pj7X7UtyXLbJun/doiweLZW0gO6NBleS0YFHLHaiNQeYf14bp/zm+8o96yZUGHVR7vzk
	 sGZ6MDtrOtmtUwvJdjhJV0tG3biNdeC5OmQtm4EIGbKusJgZeIqMe4HTIFGCXBqP/PWXj
	 HawI+rNsQYF0sQPgh8jkzGKGbagt2WF9FBZd9Kv84u9xLE7VEKeLab5YP15cVXfLQRfOo
	 8OIr0TJNPaHLqCl3TZhz/W9aZALzKbDMR4ALvcAIYykYsd6ZRsEmpWT7PFtaQqhByhssj
	 sULpJHH8/OpVs34vsPIrPxaxwgsER2NBkKIBj/Sl7Q5mnLMSVx67WXD8AA4BVQdApxQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ePTrb8E7;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F7D0606A325
	for <linux-perf-users@vger.kernel.org>; Fri, 20 Nov 2026 01:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ePTrb8E7
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7D931F000C6;
	Fri, 20 Nov 2026 01:45:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795139112;
	bh=UPvOxl+SGskPtGaoXm0zTWhpLBQCC4wfVX1BDA/It9g=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ePTrb8E73+cxpZ/qfhZiWQ/aaiW+ZWrVDNbZ4YxpCnKQr0EaG5CrWxuqid5K+nxdy
	 p+P2r0SFdcSjxu92tObVZd2QrTT5UD/zwtheWvANtLPiCBSYCRw00ua4J556oyBJ/u
	 TZuTyi+Zzadb6+Rvdb6txxmyTPoFZmqiM18z+AUh/cgG8BeOxt8AlDb7iHHRe5nO6N
	 5cbHkex1IiWxPux/Bb4Ne47VVk9ob12zya3agCPSA0GsRfeA5OyA5ogWzuPQRNAOrK
	 FzwJKc5f3uoRlzhCSP1tQBua/b+MkeUN/SZT9o+Ul2Z1Rj9crrb8mHJ3/OATmmantd
	 d2P2NOeWoOZ5w==
Message-ID: <sashiko-outbox-224336@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 04/13] perf tests: Exercise DW_OP_addrx global
 variables
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261120013211.1510-5-acme@kernel.org>
References: <20261120013211.1510-1-acme@kernel.org>
 <20261120013211.1510-5-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 20 Nov 2026 01:45:11 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Low] perf tests: unguarded failure grep under set -e triggers EXIT
  trap
--

commit 85567045cfa714e73c50921ddd5598aea7a2e83d
Author: Arnaldo Carvalho de Melo <acme@redhat.com>

perf tests: Exercise DW_OP_addrx global variables

This commit adds a global_data test workload and a shell test that checks
DWARF global variable data-type resolution via perf mem record and perf
annotate --code-with-type.

> diff --git a/tools/perf/tests/shell/data_type_global.sh b/tools/perf/test=
s/shell/data_type_global.sh
> new file mode 100755
> index 0000000000000..11fbf852b44cf
> --- /dev/null
> +++ b/tools/perf/tests/shell/data_type_global.sh
> @@ -0,0 +1,73 @@
> +#!/bin/bash
> +# perf data type profiling test for a global variable
> +# SPDX-License-Identifier: GPL-2.0
> +
> +set -e
> +
> +perfdata=3D$(mktemp /tmp/__perf_test.perf.data.XXXXX)
> +perfout=3D$(mktemp /tmp/__perf_test.perf.out.XXXXX)
> +perferr=3D$(mktemp /tmp/__perf_test.perf.err.XXXXX)
> +
> +cleanup()
> +{
> +	rm -f "$perfdata" "$perfout" "$perferr"
> +	trap - EXIT TERM INT
> +}
> +
> +trap_cleanup()
> +{
> +	echo "Unexpected signal in ${FUNCNAME[1]}"
> +	cleanup
> +	exit 1
> +}
> +trap trap_cleanup EXIT TERM INT

[ ... ]

> +for member in "+0 (saddr)" "+0x4 (daddr)" "+0x8 (bytes)"; do
> +	if ! grep -Fq "# data-type: struct conn ${member}" "$perfout"; then
> +		echo "FAIL: member ${member} not resolved"
> +		grep 'struct conn' "$perfout"
> +		cleanup
> +		exit 1
> +	fi
> +done

[Severity: Low]
Will the diagnostic grep 'struct conn' "$perfout" trigger trap_cleanup()
when struct conn is not resolved at all?  With set -e enabled, a
non-matching grep exits before cleanup() can disarm the EXIT trap,
causing trap_cleanup() to print "Unexpected signal in main".  Appending
"|| true" to the grep avoids this.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261120013211.1510=
-1-acme@kernel.org?part=3D4
