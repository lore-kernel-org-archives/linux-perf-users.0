Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 308082D97BB;
	Tue,  9 Jun 2026 07:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780989696; cv=none; b=fsRPkGi86tBdfkNDPa04eC/yg5QrRq8eyCQaMXjzyI1WaKttEWdUadoLQX7FekilWUsQF/7m+K6P+mBoj154HdabZ7i2alnkm57D68pmwChfYK1ejD7bMvtg3bK5+ntthlVQK3WWNdQB9ZCgQgvVEkoQHFEvYeY9Y8h71336pLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780989696; c=relaxed/simple;
	bh=CezKHHhQEE8DvGrnYrNuiWiOWBwHKf5ANf+6Zq8CrQU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=A0wSor7BVbhXLuGi31uwayH5W4Is0ImN02AuIAYjI5/W0ULnIkmVniNZgxd1o0kueimMScvuWMjqVKH2Rb8czrJnczNt0xzUbetWXKOKZcpQE90qtj7gP5sXWi+5eGF8N9yGqFH/OKZMmMPDtuvZHS8Gbb9lv4KGgrgetWIo1Bc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ann3tzZ3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ann3tzZ3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 986601F00893;
	Tue,  9 Jun 2026 07:21:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780989694;
	bh=tkeFq894W5/H5feuxgF9iRed4hKzxalGDTZKcEh/qsA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Ann3tzZ3Leryo2b4Zd3miml91BBiEkIt9KkzN6hS8P4C7sZw64l6IHtJ8hzTZ3QAC
	 6ZrfalH683sU09oVV2aA0PzStiGfd59BR5vpAu2Dt6XCTDqBb9BQgaYsJW70grMiBm
	 hSem1x6WRLxhypXJ4S/xzYCOOA/Iz+qk05IGZZs/7OvSrJ9YtvDC9MQZJOoV31HVdU
	 wHPf1sWD+pWY+lS2Sl34MpxaFl3bsrZyZrILYKNIhKi4tBN95UHdjfb3ls7DEhJNoE
	 CL/gwFi5pxGNEbiBaUr2iYb5v218WAJhGKpbAsk4hvqhKTD5UGiy+CxY2X7u63wsrj
	 +066KcxhpttXA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/7] tools build: Add feature check for elfutils
 libasm
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org, bpf@vger.kernel.org
In-Reply-To: <20260609070732.545416-2-irogers@google.com>
References: <20260609070732.545416-2-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 09 Jun 2026 07:21:34 +0000
Message-Id: <20260609072134.986601F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] The libasm feature check test relies on internal elfutils symbols =
(`ebl_openbackend`), guaranteeing linkage failure on all systems.
--

commit cf97b2eea73923674f23b7d737c06550cb83a7a9
Author: Ian Rogers <irogers@google.com>

tools build: Add feature check for elfutils libasm

This commit introduces a build-time feature test for the elfutils libasm
library in the shared tools/build system. It adds the test program and
updates the Makefiles to attempt building it to detect support.

> diff --git a/tools/build/feature/Makefile b/tools/build/feature/Makefile
> index 62909a9c799d3..f0f39a2ab2035 100644
> --- a/tools/build/feature/Makefile
> +++ b/tools/build/feature/Makefile

[ ... ]

> @@ -184,6 +185,11 @@ ifeq ($(findstring -static,${LDFLAGS}),-static)
>    DWARFLIBS +=3D -ldl
>  endif
> =20
> +ASMLIBS :=3D -lasm -ldw -lelf

[Severity: High]
On older systems where ebl_openbackend() was an exported symbol, it resided
in libebl.so. Since ASMLIBS omits -lebl, won't this cause linkage failures
during the test build due to missing dependencies?

> +ifeq ($(findstring -static,${LDFLAGS}),-static)
> +  ASMLIBS +=3D -lz -llzma -lbz2 -lzstd
> +endif

[ ... ]

> diff --git a/tools/build/feature/test-libasm.c b/tools/build/feature/test=
-libasm.c
> new file mode 100644
> index 0000000000000..f3598ad1cc9e1
> --- /dev/null
> +++ b/tools/build/feature/test-libasm.c
> @@ -0,0 +1,19 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#include <stddef.h>
> +#include <elfutils/libasm.h>
> +#include <gelf.h>
> +
> +typedef struct ebl Ebl;
> +extern Ebl *ebl_openbackend (Elf *elf);
> +extern void ebl_closebackend (Ebl *ebl);
> +
> +int main(void)
> +{
> +	Elf *elf =3D elf_begin(0, ELF_C_READ, NULL);
> +	Ebl *ebl =3D ebl_openbackend(elf);

[Severity: High]
Will this test program universally fail to link?

In modern elfutils (>=3D 0.177), libebl was merged into libdw, and functions
like ebl_openbackend() and ebl_closebackend() were made strictly internal
with hidden visibility. They are not exported by libdw.so or libasm.so.

Because of the missing -lebl flag on older systems and the hidden visibility
on newer systems, it seems this feature check will always fail, making
any libasm disassembler backend depending on it unreachable. Is there a
different way to initialize the disassembler context without relying on
internal symbols?

> +	DisasmCtx_t *ctx =3D disasm_begin(ebl, elf, NULL);
> +	disasm_end(ctx);
> +	ebl_closebackend(ebl);
> +	elf_end(elf);
> +	return 0;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260609070732.5454=
16-1-irogers@google.com?part=3D1
