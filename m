Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78432343894;
	Tue,  9 Jun 2026 18:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781031153; cv=none; b=f/X6t1LtGHWnWnf8Ks/b3OLdPE5RYYiubgDIDveBEbTEswAykIE8yopEMAzpv47Fl5hjC4X+ZsvE4yDH+xj3dVBnoAvYDjwazyr1HP6fuoYazhT0ibf8uESU6kmvZVfa8xAyL4jZ+C3N+s+XlJ9H0arBjl2/Wqba1rwhEwxhYqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781031153; c=relaxed/simple;
	bh=Sg7G5ueKg2uWtkWHiLwg3tFfzBxrGal/KT4zEzHXIDg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=NE6LaP3Sca2E9XQd0P1nsKUe3EAnxr2XU1ywxdmzBz9jbNNTAath9FZ86eHrobuIkF0L+UTqrqwnZI5jLRS/W+Zb0QNGNNjOPDbXuJlM7VAx1RYO1v/nzHPCr57xk2oq3pfbYccbo808H1jNji15rw2VGO2YDllUK73CXu+S+TA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U1Mfc9Sq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U1Mfc9Sq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00C881F00893;
	Tue,  9 Jun 2026 18:52:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781031152;
	bh=/ynZVaxGAlmKq42AUjye1DWbDfAIQVD+qZ+gTHbiQWs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=U1Mfc9SqqfMq5Sk3C15dzYchVR/bQktceVyzmeUbUBRnsfiKgq0ftnnSjuXsYv9Um
	 Xo+h/q52Lpyb1WPzKVqBPLTaZWpOS6x+yM9DHWvQF/cZpDPVT3F5G0ZmzJ7DVF7Lvk
	 ooF/rsDallKYRllBsRnFDtgtQ5jrabWMTgVucKSR/vC3xe1ZazSjxct13DjvlzbHUE
	 7JkZ4IpVAj49EXZqP4cU8/XhdJ1tBrbvPrPLDgAMSPlKgTDBSJJYYPCBU/T4h96S3H
	 UXsG27RRM671XwPsE124oyqR975Tm+qyv3maL2sKNiqLv48CX0gkr3GcOCzH46I1v/
	 VJPD2Fe/dDPDQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 3/7] perf annotate: Implement elfutils libasm
 disassembler backend
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org, bpf@vger.kernel.org
In-Reply-To: <20260609182108.975586-4-irogers@google.com>
References: <20260609182108.975586-4-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 09 Jun 2026 18:52:31 +0000
Message-Id: <20260609185232.00C881F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:
- [High] Missing build system integration leaves the libasm backend as comp=
letely dead code.
- [High] The implementation incorrectly relies on internal, unexported elfu=
tils functions (`ebl_openbackend` and `ebl_closebackend`), causing linkage =
failures.
- [High] Incorrect return value check for `disasm_cb` causes immediate loop=
 failure.
- [High] Passing a callback with an incompatible pointer type to `disasm_cb=
` causes a compilation error.
- [Low] `annotation_options__add_disassemblers_str` is exposed in the API b=
ut never hooked up to command line options.
--

commit 10af4235f6a3a3ed8b8874f806432a73221075b5
Author: Ian Rogers <irogers@google.com>

perf annotate: Implement elfutils libasm disassembler backend

This commit implements a new core disassembler backend utilizing elfutils'
libasm API. It hooks the backend into perf annotate routing, sets it as
the default choice when available, and exposes a function to allow custom
disassembler selection.

> diff --git a/tools/perf/util/Build b/tools/perf/util/Build
> index b22cdc24082a5..f1d5ebb2edfa8 100644
> --- a/tools/perf/util/Build
> +++ b/tools/perf/util/Build
> @@ -12,6 +12,7 @@ perf-util-y +=3D block-range.o
>  perf-util-y +=3D build-id.o
>  perf-util-y +=3D cacheline.o
>  perf-util-$(CONFIG_LIBCAPSTONE) +=3D capstone.o
> +perf-util-$(CONFIG_LIBASM) +=3D libasm.o

[Severity: High]
Does this code require corresponding changes in the build system to actually
enable CONFIG_LIBASM and HAVE_LIBASM_SUPPORT?

Without feature detection in tools/build/feature/test-libasm.c and
Makefile.config, it seems libasm.o won't be built and the fallback inline
stub in libasm.h will be used permanently.

[ ... ]

> diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
> index 02505222d8c2d..2259ac2c2cd6c 100644
> --- a/tools/perf/util/annotate.c
> +++ b/tools/perf/util/annotate.c
[ ... ]
> @@ -2254,8 +2255,8 @@ static void annotation_options__add_disassembler(st=
ruct annotation_options *opti
>  	pr_err("Failed to add disassembler %d\n", dis);
>  }
> =20
> -static int annotation_options__add_disassemblers_str(struct annotation_o=
ptions *options,
> -						const char *str)
> +int annotation_options__add_disassemblers_str(struct annotation_options =
*options,
> +					     const char *str)
>  {
>  	while (str && *str !=3D '\0') {
>  		const char *comma =3D strchr(str, ',');

[Severity: Low]
Is this function ever hooked up to command line options like in cmd_annotat=
e()?

The commit message mentions exposing it to allow custom disassembler select=
ion,
but without binding it to arguments, it appears to remain uncalled.

[ ... ]

> diff --git a/tools/perf/util/libasm.c b/tools/perf/util/libasm.c
> new file mode 100644
> index 0000000000000..2f0a657335223
> --- /dev/null
> +++ b/tools/perf/util/libasm.c
> @@ -0,0 +1,184 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#include "libasm.h"
[ ... ]
> +#include "namespaces.h"
> +#include "symbol.h"
> +
> +struct ebl;
> +extern struct ebl *ebl_openbackend(Elf *elf);
> +extern void ebl_closebackend(struct ebl *ebl);

[Severity: High]
Are these internal libebl functions guaranteed to be available for linking?

They don't seem to be exposed in public elfutils headers like
<elfutils/libasm.h>. Standard Linux distributions might not export these
symbols in libdw.so or provide libebl.a, which could break compilation
and linkage.

> +
> +struct disasm_output_arg {
> +	char *buf;
> +	size_t size;
> +};
> +
> +static int disasm_output_cb(char *str, size_t len, void *arg)

[Severity: High]
Does the DisasmOutputCB_t signature expect the string argument to be
const char *?

Dropping the const qualifier here might cause a compilation failure since t=
he
perf tool builds with -Werror.

> +{
> +	struct disasm_output_arg *oa =3D arg;
> +	size_t to_copy =3D len < oa->size - 1 ? len : oa->size - 1;
[ ... ]
> +	offset =3D 0;
> +	while (pc < end) {
> +		struct disasm_output_arg oa =3D {
> +			.buf =3D disasm_buf,
> +			.size =3D sizeof(disasm_buf),
> +		};
> +		const uint8_t *prev_pc =3D pc;
> +
> +		ret =3D disasm_cb(handle, &pc, end, addr, "%7m %.1o,%.2o,%.3o,%.4o,%.5=
o",
> +				    disasm_output_cb, &oa, NULL);
> +		if (ret !=3D 1 || pc =3D=3D prev_pc) {
> +			/* Disassembly failed or got stuck */
> +			break;
> +		}

[Severity: High]
Does disasm_cb() return 0 on success?

If so, evaluating ret !=3D 1 here will evaluate to true on the very first
successful instruction parsing, instantly breaking the loop. This would
guarantee that offset !=3D buf_len, causing the code to discard all lines
and unconditionally fall back to objdump.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260609182108.9755=
86-1-irogers@google.com?part=3D3
