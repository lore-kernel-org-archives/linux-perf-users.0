Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A9EF4C8C69
	for <linux-perf-users@vger.kernel.org>; Tue, 15 Sep 2026 18:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789498236; cv=none; b=OnT8/l7PhZD0klmw3wYnkJfiBwRievdhynNuM8UzyBxq8nj0/6fSDiPOrvljAmHhI2QHkEgTIvMxL6XMfZkqL4r8AP/ngmihDE9R1SnA9nw3QEKNsUl5ZKf34D6rUl99rZ5fhUJSmyqaVd8qF4HBmd7TPOWXjkmfhdKNJhO0xDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789498236; c=relaxed/simple;
	bh=Qcm+m6V2rmJeuQKCDSItbTPPPQGoAaxsbQEzyCD/JS8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Xjb/Q/zEOfNnH78ZzqRDLGFbN/OGEm0xTq5YRxS14vxz67jpvmMgGCTeIfUxqasuh1VqRitUD6sHh3GUwV/PM5fFrKfwRTLSCMZ1fkcCjXMigxkc8PN4y9sBphoHm6iCDrfj+xt7KxjhjuqgtpEXpZWHuJgrtaD2jV3c6/GL5zo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q5kT6TY/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q5kT6TY/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D7591F00893;
	Tue, 15 Sep 2026 18:50:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789498235;
	bh=g/tN2vA8/miiVToWQ2UtS2rIFiCnQoehCGlMrUHv7b8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Q5kT6TY/INYvYbLpNB4kOabgip6k3qTjL6nuahyCE7DjMFNwaiBPrJD56ogRPPaxj
	 /jzJLqIjkU2P9Klime2rWoiv7AWgc+52BzcRZjVP45V3nWgVHQkjyUjZvC9iJ9oVpi
	 qnlIOoqdFedNWMJYxtlmd+JtyTJNUczN9S3xA9uXL8IQMPohRtoFxKi0iHz4rmmfuQ
	 FBqZZ5+QOMsgz/lAYfSrSAni8fGkLLwCOj4NN+qc2sWF3iSl4u3TdxN/GOcIjSkUVq
	 yiAUDBSWzOCR1d2a3s1mwiKkG5kQwyDUgm/dows8tbBkOeIwSUwRGXYTe1gF2dH4HN
	 stDzvpk56clLw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 4/4] perf script: Document and test --lazy-load-symbols
 and --max-symbol-bytes
Reply-To: sashiko-reviews@lists.linux.dev
To: "Alireza Haghdoost" <haghdoost@uber.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260915-perf-symbol-memory-send-v1-4-1d3360e21f07@uber.com>
References: <20260915-perf-symbol-memory-send-v1-0-1d3360e21f07@uber.com>
 <20260915-perf-symbol-memory-send-v1-4-1d3360e21f07@uber.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 15 Sep 2026 18:50:34 +0000
Message-Id: <20260915185035.2D7591F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] perf test: missing err=3D2 assignments cause skips to be reporte=
d as success
- [Medium] perf test: strict byte comparison fails on platforms with differ=
ing debug output
--

commit 152590a92c1dd38a6f7f70f13ced82231e7560bb
Author: Alireza Haghdoost <haghdoost@uber.com>

perf script: Document and test --lazy-load-symbols and --max-symbol-bytes

Document both new options in perf-script.txt detailing their interaction,
the memory tradeoffs, and output behavior for certain targets. Add a shell
test that records a small profile and asserts that lazy loading produces
identical output to the eager loader, and that the max symbol budget is
enforced.

> diff --git a/tools/perf/Documentation/perf-script.txt b/tools/perf/Docume=
ntation/perf-script.txt
> index 200ea25891d88..b5a90ff22342f 100644
> --- a/tools/perf/Documentation/perf-script.txt
> +++ b/tools/perf/Documentation/perf-script.txt
> @@ -412,6 +412,30 @@ include::itrace.txt[]
> =20
>          Default: 127
> =20
> +--lazy-load-symbols::
> +	Resolve symbols lazily instead of eagerly loading the full
> +	symbol table of every DSO that appears in a sample. A compact
> +	sorted index is built per DSO and only the addresses that appear
> +	in samples are materialized into symbols, with names read from the
> +	file's string table at lookup time. This sharply reduces memory
> +	(and usually time) for profiles of large binaries where only a
> +	small fraction of the symbol table is referenced. This applies only
> +	to userspace ELF DSOs; kernel DSOs and modules always load eagerly.
> +	Output may differ from the default loader for some targets
> +	(e.g. PPC64 .opd, .gnu_debugdata, or split debuginfo). Default: off.

[ ... ]

> diff --git a/tools/perf/tests/shell/script_lazy_load_symbols.sh b/tools/p=
erf/tests/shell/script_lazy_load_symbols.sh
> new file mode 100755
> index 0000000000000..799c61e2f3e87
> --- /dev/null
> +++ b/tools/perf/tests/shell/script_lazy_load_symbols.sh
> @@ -0,0 +1,120 @@
[ ... ]
> +test_lazy_load_identical() {
> +	echo "Lazy-load output matches eager loader"
> +
> +	# Record a small profile with callchains so symbol resolution runs.
> +	if ! perf record -o "${perfdata}" -g -- perf test -w thloop 2> /dev/null
> +	then
> +		echo "Lazy-load identical [Skipped record not supported]"
> +		return

[Severity: Medium]
Will this script falsely report success when it skips tests? It looks like
the function returns here without setting err=3D2, which would cause the te=
st
script to exit with 0 (pass) instead of 2 (skip) when perf record fails.

> +	fi
> +
> +	if ! perf script -i "${perfdata}" 2> /dev/null > "${eager_out}" || \
> +	   ! perf script --lazy-load-symbols -i "${perfdata}" 2> /dev/null > "$=
{lazy_out}"
> +	then
> +		echo "Lazy-load identical [Failed perf script error]"
> +		err=3D1
> +		return
> +	fi
> +
> +	# The comparison is only meaningful if something actually resolved;
> +	# two all-[unknown] outputs would also match.
> +	if ! grep -q "${testsym}" "${eager_out}"
> +	then
> +		echo "Lazy-load identical [Skipped no ${testsym} resolved]"
> +		return
> +	fi
> +
> +	if ! cmp -s "${eager_out}" "${lazy_out}"
> +	then
> +		echo "Lazy-load identical [Failed output differs]"
> +		err=3D1
> +		return

[Severity: Medium]
Since the documentation mentions that output may differ from the default lo=
ader
for some targets (e.g., PPC64, .gnu_debugdata, or split debuginfo), will th=
is
strict byte-identical comparison fail spuriously on those platforms?

> +	fi
> +	echo "Lazy-load identical [Success]"
> +}
> +
> +test_max_symbol_bytes() {
> +	echo "--max-symbol-bytes budget enforcement"
> +
> +	# Depends on ${perfdata} from test_lazy_load_identical.
> +	if [ ! -s "${perfdata}" ]
> +	then
> +		echo "--max-symbol-bytes budget [Skipped record not supported]"
> +		return

[Severity: Medium]
Similar to the skip path in test_lazy_load_identical(), should err=3D2 be s=
et
here so the script correctly returns the skip exit code rather than success?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260915-perf-symbo=
l-memory-send-v1-0-1d3360e21f07@uber.com?part=3D4
