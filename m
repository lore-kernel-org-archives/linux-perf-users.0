Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 628311F2380
	for <linux-perf-users@vger.kernel.org>; Wed,  1 Jul 2026 09:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782896847; cv=none; b=MaoLxRsG2rTvzue+dw7wP0dZ0UCo+fsTWgM6e0CAg6M13ySbarQf83OiLQaRs4xOb05Y93nFWy60rGWUlzsAEl50eDujYNrK90CjYvVcZIjTiCOdaRS7vhhPZqhE93a9cIbJ8VSI29ODP+XnjOwD6SFJgMkAEUz3c2Z4/JdtRZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782896847; c=relaxed/simple;
	bh=wGtDSd2rYRx5Au+UHklqOvIT5RmWnB3J3JDHr2VZ4Ko=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=dTJKxa7KB5LbSDmR58YTz+uJrPR7ND/sA2joX03RAPRWSRhUs2bZU2FPLimskKGUi4/EP2zpu2h4BWLcq+U1YEpjmKX6MMFhAyPpxnZZ2UdDi+aFnJJSi+Uggp6etopV8O5P9myNOppSrWz6HoIMC9YPW6Jytq8nhjWdgXqjZ14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EeN1lA0O; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EeN1lA0O"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34FF71F00A3A;
	Wed,  1 Jul 2026 09:07:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782896846;
	bh=lpKaF6wG0udvbVfOwXeA3sJbnLjl5YPrcWK3DmRzj+0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=EeN1lA0OAOfaGfEH6CxMRo0P/F3rZPMGau/0AnAp+gBaogTYDjV0fFb0UIm6+St5E
	 jiuMNv0C3LRgXCdw9300Ss78WXVEbbEaCVGRNgQOXjPIrlVHcKu0H63YVUxI1Ndxoq
	 ldISXixs6RN1tDtewY6DlQoqvSpcUTeNyhbrTTey1xEajrX1rT22tW9i9xUnInqxx+
	 VOG5SkLcc0vgVAOGhNx4w3L6UL4CMoLr2tjvlYiUTEb4LuWN6k9arrqI93tzAv38/V
	 M0eSUmFMwwhqLYBQWmtmTwwExFPVIvREKVsvbwAVM7KduNVDKyok886se68b0e7Xz4
	 LZB5OwdGkTHyg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 7/9] perf tools powerpc: Add physical to logical address
 mapping for HTM traces
Reply-To: sashiko-reviews@lists.linux.dev
To: "Athira Rajeev" <atrajeev@linux.ibm.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260701084115.80383-8-atrajeev@linux.ibm.com>
References: <20260701084115.80383-1-atrajeev@linux.ibm.com>
 <20260701084115.80383-8-atrajeev@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 01 Jul 2026 09:07:25 +0000
Message-Id: <20260701090726.34FF71F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 8 potential issue(=
s) to consider:
- [Critical] Multiple integer overflows exist when calculating allocation s=
izes on 32-bit systems, leading to severe heap buffer overflows.
- [Critical] The `write_htm` function blindly trusts data from the untruste=
d AUX buffer to determine how much memory to write to the translation file,=
 allowing an attacker to leak sensitive heap memory.
- [High] Trace analysis improperly queries the host machine's `/proc/powerp=
c/lparcfg` rather than utilizing recorded trace metadata, breaking cross-pl=
atform analysis.
- [High] Missing bounds check and an off-by-one chunk error in `create_mem_=
maps` lead to out-of-bounds memory reads and misinterpretation of chunk hea=
ders.
- [High] Logical addresses are truncated on 32-bit hosts, corrupting addres=
ses greater than 4GB.
- [High] Unconditional byte swapping of HTM memory map entries corrupts dat=
a on matching-endian architectures.
- [Medium] Missing explicit POSIX libc header inclusions will cause compila=
tion failures under musl libc.
- [Medium] The unchecked return value of `add_map_entry` silently drops tra=
ce entries when memory allocation fails.
--

commit bb5ab27d1cf88495a27db7cca665426d73fc046d
Author: Tanushree Shah <tshah@linux.ibm.com>
Subject: perf tools powerpc: Add physical to logical address mapping for HT=
M traces

This commit adds support for mapping physical addresses from HTM traces
to logical addresses. It reads the current partition ID and extracts memory
map entries, then parses decoded HTM trace files to generate mappings.

> diff --git a/tools/perf/util/powerpc-htm.c b/tools/perf/util/powerpc-htm.c
> index 487989ca4fc7d..83253850870c2 100644
> --- a/tools/perf/util/powerpc-htm.c
> +++ b/tools/perf/util/powerpc-htm.c
> @@ -20,6 +20,13 @@
>  #include "sample.h"
>  #include <sys/types.h>
>  #include <sys/wait.h>
> +#include <regex.h>
> +#include <ctype.h>
> +#include <errno.h>

[Severity: Medium]
Could we include the standard posix headers here? Functions like fopen,
malloc, free, and strerror are used in this file, but <stdio.h>,
<stdlib.h>, <string.h>, and <fcntl.h> are missing. This causes build
failures when compiling with musl libc.

[ ... ]
> +struct mem_entries {
> +	unsigned long long phy_addr;
> +	unsigned long logical_addr;

[Severity: High]
Will this truncate logical addresses on 32-bit analysis hosts? PowerPC uses
64-bit addresses, but logical_addr is defined as an unsigned long. This
corrupts logical addresses over 4GB and causes the UINT64_MAX sentinel check
to fail when analyzed on a 32-bit system.

> +	u32 lp_index;
> +	u64 size;
> +};

[ ... ]
> +static int add_map_entry(struct addr_map **arr, size_t *count, size_t *c=
ap, struct addr_map entry)
> +{
> +	if (*count >=3D *cap) {
> +		size_t new_cap =3D (*cap =3D=3D 0) ? 1024 : (*cap * 2);
> +		void *tmp =3D safe_realloc(*arr, new_cap * sizeof(struct addr_map));

[Severity: Critical]
Could this multiplication wrap around on 32-bit systems? If new_cap is
sufficiently large from a large trace file, the size calculation can
overflow. This allocates a smaller buffer than expected, leading to
sequential out-of-bounds writes.

> +
> +		if (!tmp)
> +			return -1;
> +		*arr =3D tmp;
> +		*cap =3D new_cap;
> +
> +	}
> +
> +	(*arr)[(*count)++] =3D entry;
> +	return 0;
> +}

[ ... ]
> +static unsigned long find_logical_addr(unsigned long long given_addr,
> +				struct mem_entries *mem_entries_array,
> +				size_t n_entries,
> +				u32 lp_filter)
> +{
> +	for (size_t i =3D 0; i < n_entries; i++) {
[ ... ]
> +		if (start <=3D given_addr && given_addr < end &&
> +			mem_entries_array[i].lp_index =3D=3D lp_filter) {
> +			unsigned long long offset =3D given_addr - start;
> +			unsigned long logical =3D mem_entries_array[i].logical_addr + offset;

[Severity: High]
This variable also uses unsigned long, which truncates the 64-bit address on
32-bit architectures. Does it make sense to use a fixed-width type like u64
or unsigned long long here and in the structures?

> +
> +			pr_debug("DEBUG: Condition hit at i=3D%zu given_addr=3D0x%llx start=
=3D0x%llx end=3D0x%llx lp_index=3D%u\n",

[ ... ]
> +				entry.phys_addr   =3D phys_addr;
> +				entry.logical_addr =3D logical_addr;
> +
> +				add_map_entry(&maps, &count, &cap, entry);

[Severity: Medium]
Is it safe to ignore the return value here? If safe_realloc fails due to
memory pressure, add_map_entry returns -1. Ignoring this silently drops
trace entries without any error propagation.

> +
> +				ptr +=3D pmatch[0].rm_eo;

[ ... ]
> +	/* get the lp index */
> +	fp =3D fopen(lpar_cfg, "r");

[Severity: High]
Does this correctly handle cross-platform analysis? Reading from the local
host's /proc/powerpc/lparcfg means trace decoding might fail or misidentify
the partition if the analysis is run on an x86 machine or a different
system. Should this query the recorded trace metadata via perf_env instead?

> +	if (!fp) {

[ ... ]
> +	mem_entries_array =3D malloc(n_entries * sizeof(struct mem_entries));

[Severity: Critical]
Could this allocation overflow on 32-bit systems? If n_entries is very
large, the multiplication wraps around, leading to a small allocation that
will be followed by out-of-bounds writes in the initialization loop below.

> +	if (!mem_entries_array) {

[ ... ]
> +	/* get the HTM memory map data and store it in mem_entries_array
> +	 * to use it later on for physical->logical mapping
> +	 */
> +	for (u64 i =3D 0; i < n_entries; i++, mem++) {

[Severity: High]
Can this loop read past the end of the memory mapped region? The variable m=
em
starts at mapped_data + 0x20. If htm->htm_mem_entries includes chunk headers
across all auxiliary buffers, skipping the first 32-byte header but still
iterating n_entries times could cause the loop to read out of bounds and
misinterpret subsequent chunk headers.

> +		mem_entries_array[i].phy_addr =3D bswap_64(mem->phy_real);
> +		mem_entries_array[i].logical_addr =3D bswap_64(mem->logical_real);
> +		mem_entries_array[i].lp_index =3D bswap_32(mem->lp_index);
> +		mem_entries_array[i].size =3D bswap_64(mem->size);

[Severity: High]
Should this use endian-aware helpers like be64_to_cpu() instead of
unconditional byte swapping? Applying bswap_64() unconditionally corrupts
the native data format when the offline analysis is run on a big-endian host
like ppc64.

> +	}


[Severity: Critical]
Is it possible for write_htm() to read out of bounds from heap memory?

The function extracts an unbounded size from an untrusted buffer and passes
it directly to fwrite():

write_htm() {
    ...
    num_entries =3D data + 0x10;
    entries =3D be64_to_cpu(*num_entries);
    entries++;
    written =3D fwrite(data, 32, entries, fp);
    ...
}

A trace file with a small size but massive num_entries could cause an
out-of-bounds heap read, leaking sensitive memory into the translation file.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260701084115.8038=
3-1-atrajeev@linux.ibm.com?part=3D7
