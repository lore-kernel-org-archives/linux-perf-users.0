Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A84CC40F73A
	for <linux-perf-users@vger.kernel.org>; Mon,  3 Aug 2026 15:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785769912; cv=none; b=NM1pFb5R0eG1QI3JAl2qyef/gMY/CkTsxAJv7yydZHSJSP3m5wMoMTC4HIre8j91rojzjihaBY0ygbKpjrQEzWccStC2h//jd/uR31M/m4m8u9Ro3LbbOx90HZzeXoZWvZ9P4KSYgYC0o9/9lWPPrbv6ZXgYBj7jcq9AgDtAgug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785769912; c=relaxed/simple;
	bh=kr2JotTcZsY0j/u/6yrqBpbqLvZio4/xo6bqsxVz4MI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=T4DzHEvQ73Zs1AM6fTrLuRguFrB4VsYdsyi1Re0T03EK3rlAdMomeqHG6SVCzV3nt+B8Gr7Bz02NtxnTMtepPrxWz7SYGdsezPDWpritIde+SGkRwlccGHSCSLakdPALLFV/3YIUFd9Ph7/mCgD8AWpScJvkWAp8FYZ8CBj6X9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TeFw9zti; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TeFw9zti"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C33031F000E9;
	Mon,  3 Aug 2026 15:11:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785769911;
	bh=gTRjyZ4udGIntHr+Q8PoIE6DsMMUX41oLYY1/7rxBOs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=TeFw9zti7n93P0+NrhG6+wbeHQRp3YFhpZFUARpjno0l+1p+5Hiz8wxSzs+Lu/yTv
	 YqH5IJBizKwxF3T0qmslQJsYiQXJ5a9jlzTicLQC7NBFlbl+RA4BEQ9DPtR0dheD/K
	 cDCrRY6zFvpjcVQf7VPjLi4p/jtmct1IIZ96C/Sg7aSHQVvusaCtfch0ujtn/nNKOW
	 0V+meDdvTdbE5KUoltHGKl8mt7KYAIDpB97duHVQVhvduYcUgl2+F+WrFxynH8bQr6
	 BMLdwftnxYUgD5+ojrOVsTX6IGkB6aRcaIgAmcQkys9iTyQEqmQTk1V1pot3Trp4B0
	 GQ+i/4lMExd5A==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v3 3/5] perf data-convert: Add perf.data to
 trace.dat conversion backend
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tanushree Shah" <tshah@linux.ibm.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260803145958.299956-4-tshah@linux.ibm.com>
References: <20260803145958.299956-1-tshah@linux.ibm.com>
 <20260803145958.299956-4-tshah@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 03 Aug 2026 15:11:50 +0000
Message-Id: <20260803151150.C33031F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [Medium] Missing inline fallback stub for `trace_convert__perf2dat` when =
`HAVE_LIBTRACEEVENT` is undefined.
- [Medium] Missing POSIX header `<stdio.h>` for file I/O operations.
- [Medium] Resource leak: orphaned file left on the filesystem if `fdopen()=
` fails.
--

--- Patch [3]: [RFC PATCH v3 3/5] perf data-convert: Add perf.data to trace=
.dat conversion backend ---
commit 25ab95b73fc4726a00bca4e0429ad24d8f04129d
Author: Tanushree Shah <tshah@linux.ibm.com>

perf data-convert: Add perf.data to trace.dat conversion backend

Add data-convert-trace.c implementing trace_convert__perf2dat() to
convert perf.data tracepoint events to trace.dat format.

> diff --git a/tools/perf/util/data-convert-trace.c b/tools/perf/util/data-=
convert-trace.c
> new file mode 100644
> index 0000000000000..8dbdb2c9caa4f
> --- /dev/null
> +++ b/tools/perf/util/data-convert-trace.c
> @@ -0,0 +1,241 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
[ ... ]
> +#include <errno.h>
> +#include <inttypes.h>
> +#include <fcntl.h>
> +#include <string.h>
> +#include <unistd.h>

[Severity: Medium]
Does this file also need to include <stdio.h>?=20

The code heavily relies on FILE pointers and stdio routines like fopen(),=20
fdopen(), and fclose(). Without the explicit include, builds might fail on=
=20
musl libc due to relying on implicit inclusions.

> +#include <linux/compiler.h>
> +#include <linux/err.h>
[ ... ]
> +int trace_convert__perf2dat(const char *input, const char *to_trace,
> +			   struct perf_data_convert_opts *opts)
> +{
[ ... ]
> +	if (!opts->force) {
> +		int fd =3D open(to_trace, O_WRONLY | O_CREAT | O_EXCL, 0644);
> +
> +		if (fd < 0) {
[ ... ]
> +			return -errno;
> +		}
> +		trace_dat_fp =3D fdopen(fd, "wb");
> +		if (!trace_dat_fp) {
> +			int err =3D errno;
> +
> +			close(fd);
> +			pr_err("Failed to open output file '%s': %s\n",
> +			       to_trace, strerror(err));
> +			return -err;

[Severity: Medium]
Can this error path leave an orphaned file on the filesystem?=20

By returning directly instead of jumping to the out_close label where
unlink(to_trace) is called, the newly created 0-byte file isn't cleaned up.=
=20
This might break subsequent runs without --force since O_EXCL would fail=20
with EEXIST.

> +		}
[ ... ]
> diff --git a/tools/perf/util/data-convert.h b/tools/perf/util/data-conver=
t.h
> index a96240f156712..f041c23252263 100644
> --- a/tools/perf/util/data-convert.h
> +++ b/tools/perf/util/data-convert.h
> @@ -19,4 +19,8 @@ int bt_convert__perf2ctf(const char *input_name, const =
char *to_ctf,
>  int bt_convert__perf2json(const char *input_name, const char *to_ctf,
>  			 struct perf_data_convert_opts *opts);
> =20
> +#ifdef HAVE_LIBTRACEEVENT
> +int trace_convert__perf2dat(const char *input, const char *to_trace,
> +			   struct perf_data_convert_opts *opts);
> +#endif /* HAVE_LIBTRACEEVENT */

[Severity: Medium]
Should this declaration include a corresponding #else block with a dummy
inline fallback?=20

When libtraceevent is disabled, omitting the stub could cause compilation=20
failures if callers do not wrap their usage in #ifdef blocks.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260803145958.2999=
56-1-tshah@linux.ibm.com?part=3D3
