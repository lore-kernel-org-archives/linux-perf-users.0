Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68B723E49EC;
	Thu, 13 Aug 2026 21:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786658397; cv=none; b=mXCGtzIpUoCpgXGNMm7yzKJIM8Z46DanCW81aNe3qseXenUGozZeblxLNs+O9Dh/06Me7bNCs7ugYZU5kDP3OI8vOIcO54EiP419X5RqcslzMlo5LzRHBuj3OOV877kJZj8rCLVVEfcogNX8TEjtu00WWdV3bijK8w2vW6GwJPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786658397; c=relaxed/simple;
	bh=gbBLgvJ9lqGahwPQA1MkJTEn8DEA5Ys2FE96sWV4sHU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=A2I5rcpYJqMDhz9EJs0PYUO4tMiK/eLLyRCQnYQYImy4Ci9xwLnWww6Z8H7Vvd5SKom2+WDm881CnQUBe22vfvX2K9B9QWFF3HdH68Z3E7oulpKrcWv6hzgv/GBC+KG2EO9JimymM4w4V1Xhw8g6VYdBi27E5UfAnJ3hQCSLsgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nmgxEvnQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nmgxEvnQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7F641F000E9;
	Thu, 13 Aug 2026 21:59:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786658396;
	bh=paM/RbszpnE++Oux/a8KDTLuJ9WaTRJBLGqEaw2DI8w=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=nmgxEvnQMwzxfHHmZKkwCe1ohq8E3jE3HWBMjehm2SnrIDsxqZzc2zG43wdUkqN9K
	 jm1VIN/kJ4oZGw7tgf6Fwm3+3wFOfiacYrsFqDZNtvTzYG1RNsXhigiYtYwx4YN+/A
	 tsbxuOMkKU+u/WpfC4rz9A8eRynQtp+a15IlhcV4iMPIu9AuYvhzPFlUodML26kQxQ
	 SdKzUSTGdSzcbbdfri/xh3ZL5tnJ9HLn/1pWeLb5p2Zbyvdgki6vBbfTz4J10gLiXE
	 71brocyC+72p7p5Mr+ZbQc1JxrAgwk9E9eN66Z5OjECbhD2ZTnvuv2ObCb0UrCLCXE
	 70LQBvgMOyVHw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 06/26] tools build: Append
 -fzero-init-padding-bits=all to extra cflags
Reply-To: sashiko-reviews@lists.linux.dev
To: "Leo Yan" <leo.yan@arm.com>
Cc: linux-perf-users@vger.kernel.org, bpf@vger.kernel.org
In-Reply-To: <20260318-tools_build_fix_zero_init-v5-6-bbeffd8da199@arm.com>
References: <20260318-tools_build_fix_zero_init-v5-6-bbeffd8da199@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 13 Aug 2026 21:59:52 +0000
Message-Id: <20260813215952.A7F641F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [High] Unconditional appending to `EXTRA_CFLAGS` breaks default optimizat=
ion and debug flags for `libbpf`.
- [High] The `try-run` macro attempts to write to the source tree during Ma=
kefile parsing, breaking out-of-tree builds on read-only filesystems.
- [Medium] The compiler flag `-fzero-init-padding-bits=3Dall` is appended t=
o `HOST_EXTRACFLAGS`, which is never evaluated by the tools build framework=
, resulting in silent omission of the flag for host programs like bpftool.
- [Medium] The `try-run` macro uses a predictable temporary directory name =
(`.tmp_$$`), exposing the build process to a local symlink attack (CWE-377).
--

--- Patch [6]: [PATCH v5 06/26] tools build: Append -fzero-init-padding-bit=
s=3Dall to extra cflags ---
commit 526bce400539d6fdc8b0869f05e77b5305dcbce2
Author: Leo Yan <leo.yan@arm.com>

tools build: Append -fzero-init-padding-bits=3Dall to extra cflags

This commit adds -fzero-init-padding-bits=3Dall for tools building to
mitigate a new GCC-15 union initialization behavior. It implements cc-option
and host-cc-option macros to dynamically detect support for this flag.

Link: https://gcc.gnu.org/gcc-15/changes.html

> diff --git a/tools/scripts/Makefile.include b/tools/scripts/Makefile.incl=
ude
> index b5ecf137febca..a2397ceae512c 100644
> --- a/tools/scripts/Makefile.include
> +++ b/tools/scripts/Makefile.include

[ ... ]

> @@ -137,6 +137,36 @@ else
>  EXTRA_WARNINGS +=3D -Wshadow
>  endif
> =20
> +# output directory for tests below
> +TMPOUT =3D .tmp_$$$$
> +
> +# try-run
> +# Usage: option =3D $(call try-run, $(CC)...-o "$$TMP",option-ok,otherwi=
se)
> +# Exit code chooses option. "$$TMP" serves as a temporary file and is
> +# automatically cleaned up.
> +try-run =3D $(shell set -e;		\
> +	TMP=3D$(TMPOUT)/tmp;		\

[Severity: Medium]
Is this predictable temporary directory safe against local symlink attacks?

If a user builds the kernel tools in a shared directory, an attacker could
pre-create .tmp_<PID> directories containing a symlink named tmp pointing
to a target file. Because mkdir -p succeeds on existing directories, the
compiler command overwrites the attacker's symlink target.

> +	trap "rm -rf $(TMPOUT)" EXIT;	\
> +	mkdir -p $(TMPOUT);		\

[Severity: High]
Does this directory creation break out-of-tree builds on read-only trees?

Unlike Kbuild, tools Makefiles evaluate shell commands in the source tree
directory. This attempts to write to the source tree instead of the
designated output directory. The mkdir fails on a read-only filesystem,
and set -e aborts the snippet, dropping the compiler flag check.

> +	if ($(1)) >/dev/null 2>&1;	\
> +	then echo "$(2)";		\
> +	else echo "$(3)";		\
> +	fi)

[ ... ]

> +# Explicitly clear padding bits with the initializer '{ 0 }'
> +FLAG_ZERO_INIT :=3D $(call cc-option,-fzero-init-padding-bits=3Dall)
> +override EXTRA_CFLAGS +=3D $(FLAG_ZERO_INIT)

[Severity: High]
Will unconditionally appending to EXTRA_CFLAGS break the default optimizati=
on
and debug flags for libraries like libbpf?

Because Makefile.include is included before libbpf evaluates its flags,
EXTRA_CFLAGS is always defined. This forces libbpf to bypass its fallback
logic:

tools/lib/bpf/Makefile:
  ifdef EXTRA_CFLAGS
    CFLAGS :=3D $(EXTRA_CFLAGS)
  else
    CFLAGS :=3D -g -O2
  endif

and builds the library without debug symbols and optimizations.

> +HOST_FLAG_ZERO_INIT :=3D $(call host-cc-option,-fzero-init-padding-bits=
=3Dall)
> +override HOST_EXTRACFLAGS +=3D $(HOST_FLAG_ZERO_INIT)

[Severity: Medium]
Is HOST_EXTRACFLAGS evaluated by the standalone tools build framework?

The tools build framework relies exclusively on HOSTCFLAGS for host program=
s,
so appending to HOST_EXTRACFLAGS causes the flag to be ignored for tools
like bpftool.

> +
>  ifneq ($(findstring $(MAKEFLAGS), w),w)
>  PRINT_DIR =3D --no-print-directory
>  else

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260318-tools_buil=
d_fix_zero_init-v5-0-bbeffd8da199@arm.com?part=3D6
