Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B28F2459E1
	for <linux-perf-users@vger.kernel.org>; Fri, 21 Aug 2026 00:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787272326; cv=none; b=Y6XMeMxJTyNKF5UwCqVasw6g02a3smjwAjufhx6739XarYsVU3IEOHNMF7icsRBnYkzlwEkR3D19CarvJ/LmGQFtbSaWe3/QuWLPzNfKdJZqpYJahnyK4M5Icm2Igq7OSyfC8vDo25Av2pSt560B4jK+TeSVkvU2AgH5dYg+7CA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787272326; c=relaxed/simple;
	bh=TWETnI1Waw1r6hFOvpXK50i5P0x+myIeL4p/OPem+y4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=twC57zFjCXIke9DwftPuRn3UNw3OsxgVOHKSPwkjJSTO6gFZw1I0QwHHfYrThytwavbMvsSM6p1awGg3SKzu3RPtcrPWyJ5prDJs8w3UJQ1cscG69+KC59tpz+bz5Ps/qODu3FMDd5GHBwh9RDbkWKQtTmcurodUV+XGIDFQDPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hcT9rEyR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hcT9rEyR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE7F21F00A3A;
	Fri, 21 Aug 2026 00:32:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787272325;
	bh=7kpfIuvIpIsuqSwWT1QQ4jbiwHp4mZ+/QBd5HHzieZs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=hcT9rEyReY3QVKa0++o99zTkIhE64a2pzXjKXM8YAdnUaAjSwi8np5AM54eiobClZ
	 MqIKTKikyaIZGD/HxNikYAw7Jra+S1lENHfKzA3+p6jtizJODwFStBS2PaI9ceq6Vh
	 2vf+sY/3xmKDrwS6iJ19CTChgfstvPMaT/uLqaJ4dtz8KKiXSEP2sNSQw5n27mr/rF
	 ecOFRc6rDtEtLL1G4a14lvtKfF4qE5CST86RtDoCEv5THriVa1XV3zPWP42jglc61d
	 HR9dHN3UUox1KfPNWftPXRLpPyKDrl5TwxqPgUkoQ46CPS5oxETwnEEovT+imlk25J
	 9i9VBFaxL+bKQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 5/6] perf tools: Show memory region in perf-script
 subcommand
Reply-To: sashiko-reviews@lists.linux.dev
To: "Thomas Falcon" <thomas.falcon@intel.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260821001819.162277-6-thomas.falcon@intel.com>
References: <20260821001819.162277-1-thomas.falcon@intel.com>
 <20260821001819.162277-6-thomas.falcon@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 21 Aug 2026 00:32:04 +0000
Message-Id: <20260821003204.DE7F21F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [Low] Full inclusion of `"session.h"` in a header file instead of using a=
 forward declaration.

Pre-existing issues:
- [Critical] Unsafe accumulation of `i` and integer underflow on `sz` leadi=
ng to out-of-bounds stack writes in `perf_mem__region_scnprintf`.
--

--- Patch [5]: [PATCH v5 5/6] perf tools: Show memory region in perf-script=
 subcommand ---
commit bbe5b1b70fc8933143d1646f7f4d406b9364e4b3
Author: Dapeng Mi <dapeng1.mi@linux.intel.com>

perf tools: Show memory region in perf-script subcommand

This patch adds support to show the memory region in the perf-script
subcommand. It extracts the region from the mem_region field of the memory
information data source, printing it when the appropriate feature bits or
memory ranges are present.

Link: https://lore.kernel.org/all/20260114011750.350569-1-dapeng1.mi@linux.=
intel.com/

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

[Severity: Critical]
This is a pre-existing issue, but can this underflow and write out of bounds
if the accumulated length exceeds the buffer size?

If the preceding format functions in perf_script__meminfo_scnprintf() retur=
n a
combined length that exceeds the buffer size (sz =3D 200), sz - i will
underflow to a large unsigned value. When passed as sz into this function,
sz -=3D 1 and out[0] =3D '\0' will write a null byte and subsequent region =
string
out of bounds on the stack.

[ ... ]

> @@ -620,6 +689,21 @@ int perf_script__meminfo_scnprintf(char *out, size_t=
 sz, const struct mem_info *
>  	i +=3D perf_mem__lck_scnprintf(out + i, sz - i, mem_info);
>  	i +=3D scnprintf(out + i, sz - i, "|BLK ");
>  	i +=3D perf_mem__blk_scnprintf(out + i, sz - i, mem_info);
> +	if (session) {
> +		/*
> +		 * In case the feature bits are not available, as in
> +		 * pipe mode, fallback to checking for the existence of
> +		 * memory ranges
> +		 */
> +		env =3D perf_session__env(session);
> +		if ((env && session->data->is_pipe && env->nr_memory_ranges) ||
> +		    perf_header__has_feat(&session->header,
> +					  HEADER_MEMORY_RANGES)) {
> +			i +=3D scnprintf(out + i, sz - i, "|Region ");
> +			i +=3D perf_mem__region_scnprintf(out + i, sz - i,
> +							mem_info);

Should we verify that i < sz before computing sz - i and calling
perf_mem__region_scnprintf()?

> +		}
> +	}
> =20
>  	return i;
>  }
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
Could we use a forward declaration like struct perf_session; here instead of
including the entire session.h header?

The header only needs the structure pointer handle for the prototype of
perf_script__meminfo_scnprintf(). Including the full header unnecessarily
increases compilation time and risk of namespace pollution.

> =20
>  struct perf_mem_event {
>  	bool		supported;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260821001819.1622=
77-1-thomas.falcon@intel.com?part=3D5
