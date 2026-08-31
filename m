Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDFC93ABD91
	for <linux-perf-users@vger.kernel.org>; Mon, 31 Aug 2026 21:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788212829; cv=none; b=J9cDQrcl8jhmCfjcARaFlJyWU0Ek11BSjt9O7pXTiVb4RzqawdoYuTU9yuOGIpFNEGy+Br1XPZ1Kly3plVjXLWBPe8nMgAUQTzT/MvQAxDvBCr28KwvZZA758dccd7WvaEkixPW3/yjojdnSOgVlxumLw2SoKM3KM07D8fpf+fo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788212829; c=relaxed/simple;
	bh=AUkdk+bsf9GpwTe8z+Jk+ylmn1LG0/4v6a9UzySDVXg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=dMW3penWXMcB1mD9RDdqG7cP8urPh5a/Q8gK8jNukrSGgo0RXXVJneNwucaPiwSh8rsk6hvrhra8Chg0foNs0r+47T7kFsUqjOQAYgp47rWfaw7E7CkOWqJkABh7Xk2HggPxTYiM7Oe0lEOVSoS9K4/Ndn1Mzdu0dCoI0AlKe6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iDRBEySI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iDRBEySI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 383291F000E9;
	Mon, 31 Aug 2026 21:47:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788212827;
	bh=4+Bjyy85MHcy/ao6myry7jveuEjv1XrgLmFiw0TUxIc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=iDRBEySIhD2XXBTe/JDSb56PBb6iTFi2V6DkGE5BD9rnvzzhOPZ+51slQXQ1zLMuu
	 bySFgNvBbRbTB/ogWGfcpI6YoKO0FU6RwZPALWfOay6GvLRLkV5MkD8snLKXb8A+Fn
	 g0s1cavcbx4rCIpiVSxXIkyO+lWqEy/uYQsq0nTled+qYJ63YhewaSQ3szEiUHtzNu
	 HX5rydyniOEaO3UlwI9vr2H2qcxCiUrGBKS8droeFidiKgOOoJhjcCT0i8GQ2co529
	 t13KMcyFP1Hda2rp2scDSK4PIdHplj0m7SlslMloqNsUCpLVQ3QQTcw2oq3h0jV4mq
	 HF+iKgWZH9lXQ==
From: sashiko-bot@kernel.org
Subject: Re: [RFC v1 19/19] ptwrite uprobes: Add self tests
Reply-To: sashiko-reviews@lists.linux.dev
To: "Andi Kleen" <ak@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260831150651.1134594-20-ak@kernel.org>
References: <20260831150651.1134594-1-ak@kernel.org>
 <20260831150651.1134594-20-ak@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 31 Aug 2026 21:47:06 +0000
Message-Id: <20260831214707.383291F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Missing test scripts and source files cause selftests build fail=
ures and unconditional skips.
--

commit cdbf7a2bf57258522e6b6951a74593c1f59e7dd4
Author: Andi Kleen <ak@kernel.org>

ptwrite uprobes: Add self tests

This commit adds selftests for ptwrite uprobes. It tests various cases usin=
g=20
both the main probes and the perf decoder.

> diff --git a/tools/testing/selftests/uprobes/Makefile b/tools/testing/sel=
ftests/uprobes/Makefile
> new file mode 100644
> index 0000000000000..9fc65c1f04c84
> --- /dev/null
> +++ b/tools/testing/selftests/uprobes/Makefile
> @@ -0,0 +1,15 @@
> +# SPDX-License-Identifier: GPL-2.0
> +# ptwrite uprobe selftests (x86-64).
> +ARCH ?=3D $(shell uname -m 2>/dev/null || echo not)
> +CFLAGS +=3D -O2 -Wall -no-pie
> +
> +TEST_GEN_FILES :=3D ptw_probe
> +TEST_PROGS :=3D run_ptw.sh run_module.sh run_perfprobe.sh run_decode.sh

[Severity: Medium]
Will this break the selftests build during a `make install`? The Makefile
lists run_module.sh and run_perfprobe.sh in TEST_PROGS, but these files do
not appear to be included in this patch.

[ ... ]

> diff --git a/tools/testing/selftests/uprobes/run_decode.sh b/tools/testin=
g/selftests/uprobes/run_decode.sh
> new file mode 100755
> index 0000000000000..b427442041aa9
> --- /dev/null
> +++ b/tools/testing/selftests/uprobes/run_decode.sh
> @@ -0,0 +1,177 @@
> +#!/bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# run_decode.sh - ptwrite decoder selftests.
> +# Exercises the decoder CLI and PT/perf integration.
> +# Root + tracefs + perf + gcc + a PTWRITE-capable CPU required.
> +set -u
> +DIR=3D$(dirname "$(readlink -f "$0")")
> +SRC=3D${1:-"$DIR/manual_ptw.c"}

[Severity: Medium]
Does this cause the test to unconditionally skip? The SRC variable defaults
to manual_ptw.c, but this source file seems to be missing from the commit.=
=20
If the file is added in a subsequent version, should it also be included in
TEST_FILES in the Makefile to ensure it is installed correctly during
`make install`?

[ ... ]

> +if ! gcc -O2 -no-pie -o "$BIN" "$SRC" 2>/dev/null; then
> +	echo "1..0 # SKIP test program build failed"
> +	exit 0
> +fi
> +
> +TV=3D$(objdump -d "$BIN" 2>/dev/null |
> +	awk '/^[0-9a-f]+ <target>:/{print $1;exit}' | tr -d ':')

[Severity: Medium]
Is manual_ptw.c missing from the commit? This logic expects the compiled
test binary to contain a `target` function, which further suggests that the
omitted C file is strictly required for this test to function.

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260831150651.1134=
594-1-ak@kernel.org?part=3D19
