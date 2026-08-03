Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C42FB411FB1
	for <linux-perf-users@vger.kernel.org>; Mon,  3 Aug 2026 15:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785770053; cv=none; b=R6y9H2I5SjmlMqXrcxH/0O7dGMSfZCPKLAQZfUlo6Cw1ltgQ3krW1JfGfJ86yIbzPwkGKc2dVwgm1+mHHXuQyMyI5tHzKYMil00Bd432Ol2JHhGGng5SwoHrylW9Fv38+HbssjlzSjfR2DWPlaTVWyVvU7UNWceDiQtCKTAfkEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785770053; c=relaxed/simple;
	bh=6PzSzH8KLyV5nBRk9Mi93Tgs34loSx+3F8/ZHr2YAog=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=DWjo8MY7qifZrFgZA2pGycvJopvKZVLvPAhM8d2zjX8lHHK5oqZ8m+mjXmpAL0yElOu9B7H8mzZdn/HfID9++0escQXfDyGStT8Y/lNCFSsFHRW1JO4R0Th2HpQ2Pf/hma3R17Rmfm1XndURO3eRSf1lulBHmnBf2avuJrad2h4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B0cvdZcD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B0cvdZcD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B35C1F000E9;
	Mon,  3 Aug 2026 15:14:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785770051;
	bh=U8SzeuvohmAK//6RdeRkAY/ySZVpGTXwGpUqu6I+wVM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=B0cvdZcDUb1PcrP+Za0k09jSsVXZBh0SUdhC7hw43bEubVfv+ujevDOykJ44nCfMZ
	 RchJ9YHa/4t7HpVf3jGPsUKrtYAEU9gB+7XV7LFdwOHX30Dq2wHV3DnbVsVnI9sdyS
	 8xqdEqhVD0d93MRx+sVOUNhGi0soCVTAaghnAHM7c+obddtSzifpoPIx3kRo3BzO9F
	 Uonxu2TmqI8nQa19yQhLyTrTq4oIV6KkjtAl55uVqYNDuskuj1tKbzRz3cVMQ83UYu
	 4t9StbQiIBJ2O530H7+t12d+JJZYnhd87T3LbacWWTkJhh+gbE3Hh8qHgPXQo2shDd
	 qJj85IG18kSZQ==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v3 2/5] perf/trace-event: Write trace.dat metadata
 sections during parsing
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tanushree Shah" <tshah@linux.ibm.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260803145958.299956-3-tshah@linux.ibm.com>
References: <20260803145958.299956-1-tshah@linux.ibm.com>
 <20260803145958.299956-3-tshah@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 03 Aug 2026 15:14:10 +0000
Message-Id: <20260803151411.4B35C1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [Medium] Missing checks for `fseek` errors when patching section sizes ca=
n silently corrupt the output trace file.
- [Low] Missing explicit inclusion of `<stdint.h>` in `trace-dat.h`.

Pre-existing issues:
- [Critical] Integer overflow in `malloc(size + 1)` leads to a massive heap=
 buffer overflow.
--

--- Patch [2]: [RFC PATCH v3 2/5] perf/trace-event: Write trace.dat metadat=
a sections during parsing ---
commit 9121c22ee8da1e40687be01e1d9fb0edd88a10cd
Author: Tanushree Shah <tshah@linux.ibm.com>

perf/trace-event: Write trace.dat metadata sections during parsing

This commit modifies the perf trace event parsing logic to write trace.dat
compatible metadata sections when trace_dat_fp is set. It introduces
byte-order helpers and adds support for writing FTRACE EVENT FORMATS,
KALLSYMS, CMDLINES, and STRINGS sections.

> diff --git a/tools/perf/util/trace-dat.h b/tools/perf/util/trace-dat.h
> index 9aec37b708d41..5985083b275ac 100644
> --- a/tools/perf/util/trace-dat.h
> +++ b/tools/perf/util/trace-dat.h
> @@ -8,9 +8,13 @@
>  #define __PERF_TRACE_DAT_H
> =20
>  #include <stdio.h>
> +#include <stdbool.h>
> +#include <event-parse.h>
> +#include <byteswap.h>
> +#include "util.h"

[Severity: Low]
This isn't a bug, but could the lack of an explicit <stdint.h> inclusion he=
re
cause build failures on musl libc? The file uses uint16_t, uint32_t, and
uint64_t, and according to subsystem guidelines, all files using POSIX libc
types must explicitly include the declaring header.

[ ... ]
> --- a/tools/perf/util/trace-event-read.c
> +++ b/tools/perf/util/trace-event-read.c
[ ... ]
> @@ -338,6 +538,18 @@ static int read_event_files(struct tep_handle *peven=
t)
>  		}
>  		free(sys);
>  	}
> +	/* Fill in section size after writing all event files */
> +	if (trace_dat_fp && !trace_dat_write_failed) {
> +		end_pos =3D ftell(trace_dat_fp);
> +		section_size =3D to_file_u64(pevent, end_pos - sys_count_pos);
> +		fseek(trace_dat_fp, section_size_pos, SEEK_SET);
> +		if (!fwrite(&section_size, sizeof(unsigned long long), 1, trace_dat_fp=
)) {
> +			pr_warning("Failed to write trace.dat event formats section\n");
> +			trace_dat_write_failed =3D true;
> +		}
> +		fseek(trace_dat_fp, end_pos, SEEK_SET);

[Severity: Medium]
Can a failed fseek() here silently corrupt the output trace.dat file?

If the first fseek() fails due to an underlying I/O error, the subsequent
fwrite() would overwrite data at the wrong location. Since the second
fseek() is also unchecked, subsequent writes would also land at invalid
offsets.

> +	}
> +
>  	return 0;
>  }
[ ... ]
> @@ -349,8 +561,28 @@ static int read_saved_cmdline(struct tep_handle *pev=
ent)
> =20
>  	/* it can have 0 size */
>  	size =3D read8(pevent);
> -	if (!size)
> +	/* Write cmdlines section with empty payload if no data */
> +	if (!size) {
> +		if (trace_dat_fp && !trace_dat_write_failed) {
[ ... ]
> +		}
>  		return 0;
> +	}
> =20
>  	buf =3D malloc(size + 1);

[Severity: Critical]
This is a pre-existing issue, but could this malloc(size + 1) trigger a heap
buffer overflow regression when parsing an untrusted perf.data file?

For example, in read_ftrace_printk(), size is a 32-bit unsigned int. If
size is UINT_MAX, size + 1 deterministically wraps to 0. This results in a
0-byte allocation, into which do_read() subsequently attempts to read
UINT_MAX bytes.

A similar issue exists here in read_saved_cmdline() on 32-bit architectures
where size_t is 32-bit.

>  	if (buf =3D=3D NULL) {

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260803145958.2999=
56-1-tshah@linux.ibm.com?part=3D2
