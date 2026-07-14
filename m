Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97FE830C158
	for <linux-perf-users@vger.kernel.org>; Tue, 14 Jul 2026 00:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783990800; cv=none; b=FSFQa78+DmW4Kr9QT/VEy2bRzurg17rvrIXCdBAEySUtJs5GMY7JTvewTJnVlx7/pJvPzqhtIl/xRsTQa8T1zUkO7SSERYN7yu3rHQbc8Gnxu01ZLJU0dYQ2OQgM3ZlT8V8QGo4PVTYFGgxWAVYdM9RufrwlwL9fKM03fMm9cws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783990800; c=relaxed/simple;
	bh=RfRyAKz2HigDj4pqpHPNQGanKRFBk/6qFzBf9Wwq2Yo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=irfqvF2sshUE/j+83vVAaVUKAxkqBf7wM4rlZ3nnQP0kGOQlJEVZQsOKIHiuEyXpEm5KYAIIwc9OOVoWB7A25HsXZpbuNx+O+QsCsy7jxbB6ZzZmxNIsaIfTKnw3tpxoxiCIDRIYjYRBzMHo9KRJY3MhpGLhsD+n02pxP8WWDB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M8WL+6IR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M8WL+6IR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1EE01F000E9;
	Tue, 14 Jul 2026 00:59:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783990796;
	bh=o2Zyhb9s0fIuyJitwET+uujjcgP//RlHxDQdlG3s/5A=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=M8WL+6IRjTDCWmN5HmKx9L7eqWIS3bhSo3WBXDckXA4AsFmqPYPep9gyC0EF3vWN6
	 3Wm+Wm5Dx01q+ObCnsgowDXmX8mGbJEEUbg+PUtAGYE+aqNLbdtoA2+rB4g6/RravF
	 iaIQLS3bm8A0eDEo2B53fiYrIkUVm/qseNgtfFsu0vyzMMqK25dAPq3VUuzV8QU0a5
	 nUqNpVgeM0ZcgLCw0o0ejhJLjCE9DG1pNZJ0mYXIvAV08SD7anc5Ig3CnyZjkpMANq
	 /MMpCzvyJcgn0SLDO3ik0Bq7uy+3tMk61LPX7jyoUfFOjHGZmYY3eUuKnai7bUraeW
	 PTPIFraBr0pSA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 4/6] perf tools: Show memory region in perf-script
 subcommand
Reply-To: sashiko-reviews@lists.linux.dev
To: "Thomas Falcon" <thomas.falcon@intel.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260714004359.179451-5-thomas.falcon@intel.com>
References: <20260714004359.179451-1-thomas.falcon@intel.com>
 <20260714004359.179451-5-thomas.falcon@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 14 Jul 2026 00:59:56 +0000
Message-Id: <20260714005956.A1EE01F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [Medium] Silent truncation in `data_src__fprintf` due to inadequately siz=
ed destination buffer.

Pre-existing issues:
- [High] Stack buffer overflow in `perf_script__meminfo_scnprintf` and its =
helpers due to unsafe string operations and integer underflow.
- [High] Out-of-bounds array read in `perf_mem__lvl_scnprintf` when accessi=
ng `mem_hops` without bounds checking.
--

--- Patch [4]: [PATCH v2 4/6] perf tools: Show memory region in perf-script=
 subcommand ---
commit 032c0a587669b230205736e968c969992f006ba6
Author: Dapeng Mi <dapeng1.mi@linux.intel.com>

perf tools: Show memory region in perf-script subcommand

This commit adds the memory region to the output of the perf-script
subcommand. The memory region is extracted from the mem_region field
of the memory information data source.

Link: https://lore.kernel.org/all/20260114011750.350569-1-dapeng1.mi@linux.=
intel.com/

> diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
> index 9ac29bdc3cd54..58aaf1dbf6eda 100644
> --- a/tools/perf/builtin-script.c
> +++ b/tools/perf/builtin-script.c
> @@ -2081,8 +2081,8 @@ static int evlist__max_name_len(struct evlist *evli=
st)
>  static int data_src__fprintf(u64 data_src, FILE *fp)
>  {
>  	struct mem_info *mi =3D mem_info__new();
> -	char decode[100];
> -	char out[100];
> +	char decode[200];
> +	char out[200];
>  	static int maxlen;
>  	int len;
> =20
> @@ -2090,10 +2090,10 @@ static int data_src__fprintf(u64 data_src, FILE *=
fp)
>  		return -ENOMEM;
> =20
>  	mem_info__data_src(mi)->val =3D data_src;
> -	perf_script__meminfo_scnprintf(decode, 100, mi);
> +	perf_script__meminfo_scnprintf(decode, 200, mi);
>  	mem_info__put(mi);
> =20
> -	len =3D scnprintf(out, 100, "%16" PRIx64 " %s", data_src, decode);
> +	len =3D scnprintf(out, 200, "%16" PRIx64 " %s", data_src, decode);

[Severity: Medium]
Is the out buffer sized correctly to prevent truncation?

The commit message mentions increasing the buffers to avoid silent
truncation, but the out buffer is exactly the same size as the decode
buffer. Since scnprintf() adds a 17-character prefix before appending the
decode string, won't the output still be truncated if the decode string
utilizes its full capacity?

>  	if (maxlen < len)
>  		maxlen =3D len;

[ ... ]

> diff --git a/tools/perf/util/mem-events.c b/tools/perf/util/mem-events.c
> index 4fd48fd200552..ff08f1fee0e33 100644
> --- a/tools/perf/util/mem-events.c
> +++ b/tools/perf/util/mem-events.c
> @@ -604,6 +604,72 @@ int perf_mem__blk_scnprintf(char *out, size_t sz, co=
nst struct mem_info *mem_inf
>  	return l;
>  }
> =20
> +static int perf_mem__region_scnprintf(char *out, size_t sz, const struct=
 mem_info *mem_info)
> +{
> +	size_t l =3D 0;
> +	u64 mem =3D PERF_MEM_REGION_NA;
> +
> +	sz -=3D 1; /* -1 for null termination */
> +	out[0] =3D '\0';

[Severity: High]
This isn't a bug introduced by this patch, but could this write out of
bounds if sz is 0?

In perf_script__meminfo_scnprintf(), earlier calls like
perf_mem__lvl_scnprintf() can write past the sz limit because they use
strcat(out, " or ") without checking the boundary, and they return lengths
larger than the remaining size.

This allows the accumulated index i to exceed sz. When
perf_mem__region_scnprintf() is eventually called, sz - i can underflow
or evaluate to 0.

If sz is 0, sz -=3D 1 will underflow, and out[0] =3D '\0' will write a null
byte out of bounds relative to the 200-byte stack buffer. Can a crafted
perf.data file trigger a stack overflow this way?

> +
> +	if (mem_info)
> +		mem =3D mem_info__const_data_src(mem_info)->mem_region;
> +
> +	switch (mem) {

[ ... ]

> @@ -620,6 +686,8 @@ int perf_script__meminfo_scnprintf(char *out, size_t =
sz, const struct mem_info *
>  	i +=3D perf_mem__lck_scnprintf(out + i, sz - i, mem_info);
>  	i +=3D scnprintf(out + i, sz - i, "|BLK ");
>  	i +=3D perf_mem__blk_scnprintf(out + i, sz - i, mem_info);
> +	i +=3D scnprintf(out + i, sz - i, "|Region ");
> +	i +=3D perf_mem__region_scnprintf(out + i, sz - i, mem_info);
> =20
>  	return i;
>  }

[Severity: High]
This is a pre-existing issue, but I noticed a potential out-of-bounds read
in perf_mem__lvl_scnprintf() which is called earlier in this function.

The mem_hops string array is defined with 5 elements. However,
data_src.mem_hops is a 3-bit bitfield, meaning it can take integer values
from 0 to 7.

If a crafted perf.data file sets data_src.mem_hops to 5, 6, or 7, does this
cause an out-of-bounds pointer read when accessing
mem_hops[data_src.mem_hops]?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260714004359.1794=
51-1-thomas.falcon@intel.com?part=3D4
