Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794707787;
	b=xq6gAJnMLSjzaBb+gizNwmm0ZinpK53fO9hEocjVTniUCrHXkeGFAldSQ13fYdKvzfpH
	 nzLzOpRxGQbLf8wnMRrDFE9DxHd/dKswIhdXi9DI0EF3doqEvnks/iqxEvDfw1zgjYl5f
	 RiG8OvE6cua6jPTjBTTbGB+VbQl5t4UgS+W8vGgJK5RuYDn+UR+j5sf8mx7Xzf1kZis7z
	 AX5B31vjGpwBeAybSrIBLYFZjJ4QBKofVbjV3Cve6/+94thbwff2s84P3cf6RaAXDpwYe
	 mlCLFeCPlO3PJKOWrS1URPRtOkIV0RbLo37jscUUv7HzBrgEsBLNWu/bad3VjdqZlPg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794707787;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=UHD6zgNrsN84TRa81XJot1PXgq9Ycck+fZ2TLl/HHh4=;
	b=jOga1neydLTO9Ul2Y+wK077inu6L5oymzgIdwMbnjTE4lHM/lt5jQ9mV9eY6m8oO3nrm
	 4zaUxavuhG6JdfLStcXYc15fAJ60Pi+e1v6xf8XVk0UCoIUwl0l8OorMxqbEuIIuJpuhq
	 mM7IwFutwxl0vfaTAJoRn5Rn2wy07pRc0xJhvRKXJqF36zu79Jk54y+qANZ4AiEmwBKEq
	 skNRqdxRFUkMKZMzRW7LuKfCjrPS+UDH2G9TzlO0JmkXo0x6TzMJxgd4/pqm4klS9SXQe
	 6jiB0yCBib6Xrz0D1oaSyu6X8su13A9SlsqRB8ETvEadUZU+dD19TZj+7wbqJMFaoTQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=m7ik3+vf;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1FD9606A323
	for <linux-perf-users@vger.kernel.org>; Sun, 15 Nov 2026 01:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=m7ik3+vf
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 281ED1F000C4;
	Sun, 15 Nov 2026 01:56:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794707787;
	bh=UHD6zgNrsN84TRa81XJot1PXgq9Ycck+fZ2TLl/HHh4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=m7ik3+vf+OmLkgZIe3q96DVOBqbUyisG6mC9r/kXNZO1JsyjrpTnWsnbXG2BgMv1b
	 FD9B/bU8NBMRVFV0VYSp849Ldxk1MlnksCQ1gr6jyDzR5c77/miFsaPokRPO+mernm
	 JKPbiZGfdUdo07es4BXRweDvyzFxUaId/zd3lOPwvmwj/JTMnsLlmuuFqacG6NPM2s
	 4Ha92+iWfpI0aHQBu5TmOpOjGRcUPxAYrHMqDWGdOXDI//ByQDy3/e5D7zdSgqSSYU
	 op51QSJR7IZXPCwXbKuCRK83Ej0G8fdNR/g6aB74OOTzj27PGVQqJxHKA3r3MZYDkD
	 BZiAQqHW+mFow==
Message-ID: <sashiko-outbox-215180@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 03/12] perf annotate-data: Resolve DW_OP_addrx global
 variables
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261115014102.2879372-4-acme@kernel.org>
References: <20261115014102.2879372-1-acme@kernel.org>
 <20261115014102.2879372-4-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 15 Nov 2026 01:56:26 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 2 potential
issues to consider:
- [Medium] perf annotate-data: DW_OP_addrx fallback in dwarf-aux.c
  breaks annotate-data.c build
- [Low] perf annotate-data: typo in Fixes trailer SHA d7d60803a790b716
  in commit message
--

commit c0595ea7c114bb34a2fadcf5632812fb611fb7b5
Author: Arnaldo Carvalho de Melo <acme@kernel.org>

> perf annotate-data: Resolve DW_OP_addrx global variables
>
> clang emits DW_AT_location with DW_OP_addrx for global variables in
> DWARF 5, gcc emits DW_OP_addr.  The address index was not resolved, so
> those variables were not found by address; the by-name fallback also
> missed the ones in .bss past the file backed end of the last segment.
>
> Resolve the index with dwarf_getlocation_attr() + dwarf_formaddr() and
> use the resulting address in the by-address lookup and in the global
> variable cache.  The new global_data workload keeps a zero initialized
> struct in .bss and its test checks that the accesses are annotated: when
> perf is built with clang and DWARF 5 it goes through DW_OP_addrx, with
> gcc through DW_OP_addr.  The test skips on 32-bit PIE builds, which
> load globals through the GOT, something the resolver does not follow.
>
> Fixes: d60469d7c0e5c4e8 ("perf dwarf-aux: Add die_find_variable_by_addr()=
")
> Fixes: d7d60803a790b716 ("perf dwarf-aux: Add die_collect_global_vars()")
> Cc: Namhyung Kim <namhyung@kernel.org>
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

[Severity: Low]
The second Fixes: tag has a typo in the SHA (d7d60803a790b716 cannot be
resolved); the commit that introduced die_collect_global_vars() is
d7b60803a790 ("perf dwarf-aux: Add die_collect_global_vars()").

[ ... ]

> diff --git a/tools/perf/util/annotate-data.c b/tools/perf/util/annotate-d=
ata.c
> index dd9c1d7b2da8b..d8d00646ef63b 100644
> --- a/tools/perf/util/annotate-data.c
> +++ b/tools/perf/util/annotate-data.c
> @@ -140,6 +140,10 @@ static void pr_debug_location(Dwarf_Die *die, u64 pc=
, int reg)
>  		case DW_OP_addr:
>  			pr_info("address=3D%#lx\n", (long)ops->number);
>  			break;
> +		case DW_OP_addrx:
> +		case DW_OP_GNU_addr_index:
> +			pr_info("address index=3D%#lx\n", (long)ops->number);
> +			break;
>  		default:
>  			pr_info("unknown: code=3D%#x, number=3D%#lx\n",
>  				ops->atom, (long)ops->number);
> diff --git a/tools/perf/util/dwarf-aux.c b/tools/perf/util/dwarf-aux.c
> index 48a11c95a6768..5db7458f01116 100644
> --- a/tools/perf/util/dwarf-aux.c
> +++ b/tools/perf/util/dwarf-aux.c
> @@ -14,6 +14,11 @@
>  #include "strbuf.h"
>  #include "string2.h"
> =20
> +/* DWARF 5 address index, libdw's dwarf_getlocations() returns it unreso=
lved */
> +#ifndef DW_OP_addrx
> +#define DW_OP_addrx 0xa1
> +#endif
> +

[Severity: Medium]
Does defining the DW_OP_addrx fallback only in dwarf-aux.c break the
build of annotate-data.c against older elfutils headers?

The libdw feature check accepts elfutils starting from 0.160, while
DW_OP_addrx was added to dwarf.h in 0.171.  Moving the #ifndef DW_OP_addrx
definition to tools/perf/util/dwarf-aux.h would make it visible to both
translation units.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261115014102.2879=
372-1-acme@kernel.org?part=3D3
