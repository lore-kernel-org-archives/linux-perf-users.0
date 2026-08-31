Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D235B376BEF
	for <linux-perf-users@vger.kernel.org>; Mon, 31 Aug 2026 22:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788215556; cv=none; b=deTZIA1USRv5oWJS57MZeUpUSlYVthx6SvoS4wFxXqL5GQ1tpiKNgCPRoUSdlFBM9yphgWJmjVJlLc3vGpDIfLFipHKP5LzRHPYShUdemUjaTSKHNtjQMXXVz60RZ2KHySG0w+u24duRoPPRFxDBi9zzqaseqY4L6TUoyDskyEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788215556; c=relaxed/simple;
	bh=10ksi17hA0z2CWuVQ5nw7+Glxh9gbhNVdWPBXcqBP7Y=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=oXynj2zUve5nxwEvIX9+p+2ewBODCkLcRuPeQrZpvUdVIg5puQ4hvndYBHzLuFJeRaTNQ9FEgGCpKt7iQgQebLLKvzP3EDQqVESYxWKQj0LiTI4oROti4YCC6WcuUDwqozhJPAoLYOEWXmsJVTj50yeJJ8Zk2Cw07pTZroWjsoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gTODrr5u; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gTODrr5u"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 455AA1F000E9;
	Mon, 31 Aug 2026 22:32:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788215554;
	bh=7t0x+dx8D126M0TofPcqsrzhIPLTM8J2c4B57PapqBU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=gTODrr5ukyqvge1mx/SX5zc/SheVY+tJ2IIkg2BCaFm0MrjRg/qM+Mc2Rn7N3KrOw
	 FCImGfuDHm4mJtaeeJI8VPqD6xVDSgG1kK/A+8tm8kDKZSaEftkwkSmk80qpihvSkb
	 f6qqsNb+UIus0uStLMcMU6O6bkKWNlwKObOtQcNFw5qmoP2YZg1Q6OJx8wHZYZtJh4
	 g7annTqQ9VAsGkCDwsnjLjlOrm00xJ5G9hKjkiS5WUMTtVObGHFGdoxWejcahOCtaN
	 lBcvTR9SSufRMgaC042GcjCCjUbCheA5+TdWdHG7DFw1fCAfKyV40GPUMRgypueMEE
	 3PYfHRXSe9Gjg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 5/6] perf tools: Show memory region in perf-script
 subcommand
Reply-To: sashiko-reviews@lists.linux.dev
To: "Thomas Falcon" <thomas.falcon@intel.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260831204613.2793526-6-thomas.falcon@intel.com>
References: <20260831204613.2793526-1-thomas.falcon@intel.com>
 <20260831204613.2793526-6-thomas.falcon@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 31 Aug 2026 22:32:33 +0000
Message-Id: <20260831223234.455AA1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [High] Integer underflow leading to out-of-bounds null byte write in `per=
f_mem__region_scnprintf`.
- [Low] Unnecessary full header inclusion of `session.h` violates subsystem=
 guidelines.

Pre-existing issues:
- [High] Buffer overflow due to unbounded `strcat` in memory reporting func=
tions.
--

commit 81377b3a6f0865259ee97043de4011f0758a4918
Author: Dapeng Mi <dapeng1.mi@linux.intel.com>

perf tools: Show memory region in perf-script subcommand

This commit adds the ability to display the memory region in the
perf-script subcommand. The memory region is extracted from the
mem_region field of the memory information data source.

Link: https://lore.kernel.org/all/20260114011750.350569-1-dapeng1.mi@linux.=
intel.com/

> diff --git a/tools/perf/util/mem-events.h b/tools/perf/util/mem-events.h
> index daa22748f9fea..4ebb8109fc3c4 100644
> --- a/tools/perf/util/mem-events.h
> +++ b/tools/perf/util/mem-events.h
> @@ -4,6 +4,7 @@
> =20
>  #include <stdbool.h>
>  #include <linux/types.h>
> +#include "session.h"

[Severity: Low]
Could this header inclusion be replaced with a forward declaration of
struct perf_session instead?

Including the full session.h here might cause unnecessary namespace polluti=
on
and increased build dependencies. The subsystem guidelines for posix libc a=
nd
musl compatibility suggest preferring forward declarations when only pointer
handles are used in headers.

[ ... ]

> diff --git a/tools/perf/util/mem-events.c b/tools/perf/util/mem-events.c
> index 4fd48fd200552..8ce4996cad8d3 100644
> --- a/tools/perf/util/mem-events.c
> +++ b/tools/perf/util/mem-events.c
> @@ -604,8 +604,77 @@ int perf_mem__blk_scnprintf(char *out, size_t sz, co=
nst struct mem_info *mem_inf
>  	return l;
>  }
> =20
> -int perf_script__meminfo_scnprintf(char *out, size_t sz, const struct me=
m_info *mem_info)
> +static int perf_mem__region_scnprintf(char *out, size_t sz, const struct=
 mem_info *mem_info)
>  {
> +	size_t l =3D 0;
> +	u64 mem =3D PERF_MEM_REGION_NA;
> +
> +	sz -=3D 1; /* -1 for null termination */
> +	out[0] =3D '\0';

[Severity: High]
Is there a possibility of an integer underflow here if sz is evaluated
as 0?

If the previous formatting functions perfectly exhaust the 200-byte buffer
and return exactly 200, sz would be 0 when this function is called. The
subtraction sz -=3D 1 would wrap to a maximum size_t value, leading to an
out-of-bounds null byte write at out[0] and allowing the subsequent
scnprintf calls to overwrite adjacent memory.

[ ... ]

> +int perf_script__meminfo_scnprintf(char *out, size_t sz,
> +				   const struct mem_info *mem_info,
> +				   struct perf_session *session)
> +{
> +	struct perf_env *env;
>  	int i =3D 0;
> =20
>  	i +=3D scnprintf(out, sz, "|OP ");
> @@ -620,6 +689,21 @@ int perf_script__meminfo_scnprintf(char *out, size_t=
 sz, const struct mem_info *
>  	i +=3D perf_mem__lck_scnprintf(out + i, sz - i, mem_info);
>  	i +=3D scnprintf(out + i, sz - i, "|BLK ");
>  	i +=3D perf_mem__blk_scnprintf(out + i, sz - i, mem_info);

[Severity: High]
This is a pre-existing issue, but do the perf_mem__lvl_scnprintf,
perf_mem__snp_scnprintf, and perf_mem__tlb_scnprintf functions called here
have a buffer overflow regression?

Looking at their implementations, they use unbounded string concatenations:

strcat(out, " or ");
l +=3D 4;

Since strcat ignores the remaining buffer size sz and simply writes until
it appends a null byte, could a crafted perf.data with multiple bits set in
mem_lvl, mem_snoop, or mem_tlb write well past the end of the array if the
available space is smaller than the appended string?

Furthermore, since l +=3D 4 artificially inflates the returned length beyond
sz, could this cause subsequent calls in this sequence to receive wrapped
negative sizes for sz - i?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260831204613.2793=
526-1-thomas.falcon@intel.com?part=3D5
