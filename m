Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BC563C1994;
	Tue,  9 Jun 2026 05:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780982925; cv=none; b=LdPhFEmxj+BctACGkc3wsQNqRzhsVEikUi2obANmNa/gvMVZW/+AJ1IauLrqINB0TmdTwbCHPBS/PYfSllVi0hCEnH9QK9uiP8RmWENy4TFR3pmlfwxpu5IJ9UsmFIWSFaFEZlbP6dpLPCOSw2YNJBn7RQjKvIcEzqn7D9+YSGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780982925; c=relaxed/simple;
	bh=21n4TEbaW2a+fuYkFTvZm72vlXUzpax2P5QbVeGiTJE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=AVckdHFfZ675vR+LCO8aQ5TnSuPoPtx4sD3r3s1you2Ji84ntuV/Wk9mut5ZrmotVapZXH0dhWC1t2pJx+aiQ54UghhAa200kqvSs3lDNoimgLueGUnjk41q5lnDA8HrsjIU4boEhevkHhX5oKwartiO35bKyqLS25a0xFtoibI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aS0EiZYW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aS0EiZYW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2EA91F00898;
	Tue,  9 Jun 2026 05:28:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780982924;
	bh=1zG/0XsETkgULVYnhUfiyegqZh44TMBYtMU0FDuf96g=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=aS0EiZYW1lbft3O9RaggPXCa9lRLSySxXtBZej6k4W6haw947xdJnL+4iVpkPQnnT
	 gFuiD70CnkqySW5zykPpgj1NZxkI34pAXhVgFslgeiADcIc4zemtCDB4jdQuXeeac0
	 a2cIV0VGbL/SwYmMdMx3/yC21SOEUttJWdkYJhUm1mvMAJjU+D3EwGDwe1H2dYZKtv
	 t5+FzZ2w0isMqvI/V9kJ43UXIPuP5aZf8Mq1dXq3FYAB+BQFZ79PbGzPwy/js6yy67
	 PNeYZK3J5vtirwVy685c5O/G36Oa4hvsVfLwo0krqiilgR30km1Ul9BEccIZOT/ip9
	 EXc4ErqMim3/w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 2/7] perf build: Add build support and capability for
 elfutils libasm
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: bpf@vger.kernel.org, linux-perf-users@vger.kernel.org
In-Reply-To: <20260609051759.405027-3-irogers@google.com>
References: <20260609051759.405027-3-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 09 Jun 2026 05:28:42 +0000
Message-Id: <20260609052843.B2EA91F00898@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] The `libasm` feature detection bypasses `NO_LIBELF=3D1` and `NO_=
LIBDW=3D1` build flags, forcing unwanted linkage of `libelf` and `libdw`.
- [Low] The libasm feature check unconditionally prints a confusing and fal=
se build warning when libasm is absent, resulting from a copy-paste error f=
rom the libcapstone check.
--

commit f7a26566fa9af4fab8dbd2f6062cf9924751f23c
Author: Ian Rogers <irogers@google.com>

perf build: Add build support and capability for elfutils libasm

Configure perf build system to utilize the libasm feature check
(supporting both static and dynamic builds) and export the config flags.
Add "libasm" capability detection to perf check.

> diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
> index 6e7b15fab2ecc..8b6c32392d618 100644
> --- a/tools/perf/Makefile.config
> +++ b/tools/perf/Makefile.config

[ ... ]

> @@ -1060,6 +1067,22 @@ ifndef NO_CAPSTONE
>    endif
>  endif
> =20
> +ifndef NO_LIBASM
> +  $(call feature_check,libasm)
> +  ifeq ($(feature-libasm), 1)
> +    CFLAGS +=3D -DHAVE_LIBASM_SUPPORT $(LIBASM_CFLAGS)
> +    ifdef LIBASM_DLOPEN
> +      CFLAGS +=3D -DLIBASM_DLOPEN
> +    else
> +      LDFLAGS +=3D $(LIBASM_LDFLAGS)
> +      EXTLIBS +=3D -lasm -ldw -lelf

[Severity: Medium]
Will this force linkage of libelf and libdw even when the user builds with
NO_LIBELF=3D1 or NO_LIBDW=3D1?

It appears NO_LIBASM isn't automatically set when NO_LIBELF=3D1 is used, un=
like
other ELF-dependent libraries:

tools/perf/Makefile.config:
ifdef NO_LIBELF
  NO_LIBDW :=3D 1
  NO_LIBUNWIND :=3D 1
  NO_LIBBPF :=3D 1
  NO_JVMTI :=3D 1
else

Because of this, the libasm feature check will still run and unconditionally
append -lelf and -ldw to EXTLIBS, bypassing the user's explicit build
constraints.

> +    endif
> +    $(call detected,CONFIG_LIBASM)
> +  else
> +    msg :=3D $(warning No libasm found, disables disasm engine support f=
or 'perf script', please install elfutils-devel/elfutils-libelf-devel);

[Severity: Low]
Is this warning statement evaluating and printing during Makefile parsing
whenever libasm is absent?

In GNU Make, the $(warning) function is evaluated immediately as it is pars=
ed.
This means users compiling perf without the optional libasm library might be
shown this warning even if they did not explicitly request libasm support.

Additionally, is the warning text accurate? It seems this might be a copy-p=
aste
from the libcapstone check, as it claims missing libasm disables the
'perf script' disasm engine, but libasm is used for 'perf annotate' rather =
than
'perf script'.

> +  endif
> +endif
> +
>  ifdef EXTRA_TESTS
>      $(call detected,CONFIG_EXTRA_TESTS)
>      CFLAGS +=3D -DHAVE_EXTRA_TESTS

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260609051759.4050=
27-1-irogers@google.com?part=3D2
