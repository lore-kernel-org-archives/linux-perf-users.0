Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5222240DB2F
	for <linux-perf-users@vger.kernel.org>; Mon,  3 Aug 2026 15:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785770021; cv=none; b=F85SzDGY00+rdCHXpq1kKaydcQyQ8JgMVjhTr/CElmMrNSFGsWFlrr0/57581fyuntT18iMNNEALoBU347eCgteQPx0xP3w2Sbj1JKCpXCP7RZJlZngPaPOztVq1xSh8bCmSZWV/Xd0Y86C2hDLVZofPCnPRefrpeFdJJiddXYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785770021; c=relaxed/simple;
	bh=z/orlyTHusIKNNVetkelRnxkBsOoK7OxysxodBY6jdA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=HUHT2olZYGEmSEEbHRQnK2Gx80U6E5lVQmO2uNeB0OGsYV7FcKFEOBBcfNlp/xZ18PrfaEvuPbGGZ8VXOITE5Ojnw89Q+RglhtSIfRp+yaPrENbCrWWCWOLJGg/rL6T/dVu9FiSI7uihzVszPnBOD6rwiopNoUYXrJ18nkK2LVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IOAvUBwG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IOAvUBwG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B94841F000E9;
	Mon,  3 Aug 2026 15:13:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785770020;
	bh=VCX0LJSgNtjaQY6N3ieH4IFwR8MlWFeUAB7RWDyzLVI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=IOAvUBwGTuG8tyj1tIJjdaIEeOLFGfyC+bYuGhfTz14pCldxTJqYx4GdNYaE0foEH
	 6vlgK9D7BG+grYj5pDo1mCFSkCCNIneqnExme7J15s1VdPgX7buO2pOl/Mw3QpY/oX
	 xtlpX9PSF3rohYIvp+4jHOggqMwyhoRqDG9TzFUszvWHCJMOG8MxrVnhJDJ7WUyw3R
	 mrZSQ239w3Ejjz6881TFnuBxiej+3n9wQnLK+35l0iuIMYPVIYHEDdYUOCBDIBqB/r
	 Q65b/F+qW5TUN8LG7IbWMMik2h5YkswvEF7WA8ULnaHFu+ikCoS8vpigVZY2p5dm//
	 kfiE1eTBugecA==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v3 4/5] perf data: Add --to-trace-dat option for
 converting perf.data tracepoint events into trace.dat format
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tanushree Shah" <tshah@linux.ibm.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260803145958.299956-5-tshah@linux.ibm.com>
References: <20260803145958.299956-1-tshah@linux.ibm.com>
 <20260803145958.299956-5-tshah@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 03 Aug 2026 15:13:39 +0000
Message-Id: <20260803151339.B94841F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [Medium] Memory leak of page_records and page_rec_sizes arrays when exten=
d allocation fails.
- [Medium] The --to-trace-dat conversion silently ignores the --time filter=
ing option.
- [Low] Missing explicit POSIX header inclusions in trace-dat.h and data-co=
nvert-trace.c causes build failures on musl libc.
- [Low] Missing dummy inline stub for trace_convert__perf2dat when HAVE_LIB=
TRACEEVENT is absent.
--

--- Patch [4]: [RFC PATCH v3 4/5] perf data: Add --to-trace-dat option for =
converting perf.data tracepoint events into trace.dat format ---
commit 3f0a7b06f263871cd1c6bbd15fd1c2bd5d454bae
Author: Tanushree Shah <tshah@linux.ibm.com>
perf data: Add --to-trace-dat option for converting perf.data tracepoint ev=
ents into trace.dat format

This commit adds a new command-line option to perf data convert for generat=
ing
trace.dat output files. It provides a trace_convert__perf2dat function to
handle tracepoint events and write them in a format compatible with trace-c=
md
and KernelShark.

> diff --git a/tools/perf/util/data-convert-trace.c b/tools/perf/util/data-=
convert-trace.c
> new file mode 100644
> index 0000000000000..8dbdb2c9caa4f
> --- /dev/null
> +++ b/tools/perf/util/data-convert-trace.c
> @@ -0,0 +1,241 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright 2026, IBM Corporation
> + * Author: Tanushree Shah <tshah@linux.ibm.com>
> + *
> + * data-convert-trace.c
> + *
> + * Implements perf.data to trace.dat format conversion for tracepoint ev=
ents.
> + */
> +
> +#include <errno.h>
> +#include <inttypes.h>
> +#include <fcntl.h>
> +#include <string.h>
> +#include <unistd.h>
> +#include <linux/compiler.h>
> +#include <linux/err.h>
> +
> +#include "data-convert.h"

[ ... ]

> +/* Convert perf.data tracepoint events to trace.dat format */
> +int trace_convert__perf2dat(const char *input, const char *to_trace,
> +			   struct perf_data_convert_opts *opts)
> +{
> +	struct perf_session *session;

[Severity: Medium]
Does this function ignore the opts->time_str filtering option? In other for=
mat
conversions, the time parameter is parsed to filter samples within the spec=
ified
time ranges, but it appears to be unused here when converting to trace.dat.

> +	struct trace_convert tc =3D {
> +		.events_count =3D 0,
> +	};

[ ... ]

> +	if (!opts->force) {
> +		int fd =3D open(to_trace, O_WRONLY | O_CREAT | O_EXCL, 0644);
> +
> +		if (fd < 0) {
> +			if (errno =3D=3D EEXIST)
> +				pr_err("Output file '%s' already exists. Use --force to overwrite.\n=
",
> +				       to_trace);
> +			else
> +				pr_err("Failed to open output file '%s': %s\n",
> +				       to_trace, strerror(errno));
> +			return -errno;
> +		}
> +		trace_dat_fp =3D fdopen(fd, "wb");

[Severity: Low]
Should <stdio.h> be explicitly included at the top of this file? Standard I=
/O
functions like fdopen() and fopen() are used here, which could cause build
failures on musl libc without the direct header inclusion.

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

[Severity: Low]
Is a dummy inline stub needed here for when HAVE_LIBTRACEEVENT is disabled?
Without an #else block providing a fallback stub, it could cause future bui=
ld
failures if new callers are added that aren't guarded by the feature macro.

> diff --git a/tools/perf/util/trace-dat.c b/tools/perf/util/trace-dat.c
> new file mode 100644
> index 0000000000000..5598496c9a61c
> --- /dev/null
> +++ b/tools/perf/util/trace-dat.c

[ ... ]

> +static int trace_dat__write_cpu_dat(FILE *fp, struct tep_handle *pevent,
> +		int cpu, unsigned long long *file_offset_out)
> +{
> +	struct cpu_events *cpu_events =3D &trace_cpu_data[cpu];

[ ... ]

> +	for (i =3D 0; i < cpu_events->count; i++) {
> +		struct cpu_event *event =3D &cpu_events->events[i];

[ ... ]

> +		/* Emit TIME_EXTEND when delta does not fit in 27 bits */
> +		if (time_delta > TRACE_DAT_RECORD_TIME_MASK) {
> +			unsigned int extend_hdr;
> +			unsigned int delta_upper;
> +
> +			extend_size =3D TRACE_DAT_RECORD_TIME_EXTEND_SIZE;
> +			extend =3D calloc(1, extend_size);
> +			if (!extend)
> +				return -ENOMEM;

[Severity: Medium]
Can this early return cause a memory leak? If the allocation for extend fai=
ls,
returning -ENOMEM directly skips the out_free label at the end of the funct=
ion,
which is responsible for freeing the dynamically resized page_records and
page_rec_sizes arrays.

> diff --git a/tools/perf/util/trace-dat.h b/tools/perf/util/trace-dat.h
> new file mode 100644
> index 0000000000000..b63d4e8c1e2d7
> --- /dev/null
> +++ b/tools/perf/util/trace-dat.h
> @@ -0,0 +1,113 @@
> +/* SPDX-License-Identifier: GPL-2.0-or-later */

[ ... ]

> +#include <stdio.h>
> +#include <stdbool.h>
> +#include <event-parse.h>
> +#include <byteswap.h>
> +#include "util.h"
> +
> +/* trace.dat file format version */
> +#define TRACE_DAT_VERSION "7"

[ ... ]

> +static inline uint16_t to_file_u16(struct tep_handle *pevent, uint16_t v=
al)
> +{
> +	return tep_read_number(pevent, &val, 2);
> +}

[Severity: Low]
Does this file need to explicitly include <stdint.h> to ensure compatibility
when compiling with musl libc? Fixed-width integer types like uint16_t are =
used
here but the standard POSIX header for them is missing.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260803145958.2999=
56-1-tshah@linux.ibm.com?part=3D4
