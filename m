Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5801B347BAF
	for <linux-perf-users@vger.kernel.org>; Thu,  9 Jul 2026 22:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783636093; cv=none; b=FnaerSXwpVmb9un/ujw0CDSqHzipRFelcbGH9gTTBlL/9066bfdPw3zritmc97qF4qHT2R17h9Bb+Mrbr5mDMZg/yISVVJBh0+p5ZsUgpJmYuax3jY3+gnGozTuCBpr4WyV/B2GibIRW2zSp/4rgTsjPpeXOvkOEBDBcgtPDbzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783636093; c=relaxed/simple;
	bh=PTNTwDnNdGidjmDlQMi8axfd+4s3ZZQLrWV17vi93T4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=HdULAJyJSYrt9Uge2t3jgzUrK4TSMQ5SJBcuSgChSRUAVjy09OPbDVuqC15pAp+s83y841UBv5Z85nqq8zDdpw6vaNyfs4E1BdPuDy9ba8xblmtfMmbNHd3grHpS6tRSQmAWzA13FwC+vhDhxUzMfhyTFfYZ0zyEL9qS9lRPORk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hN6clHmZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hN6clHmZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9CEB1F000E9;
	Thu,  9 Jul 2026 22:28:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783636092;
	bh=jCudAgLEzFZch3iQOkJJjEznJJt6ER0WKS3lMrnd/6A=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=hN6clHmZSOHtr19r72c1yP9bmJSXY8ZXWw4pAf4sQ7gCK1uOO8fqYmglaP3yTPHcC
	 snmYkZ9DLjOStiqdA4ukJQpEwtPCZy0YbnTHhNjJksGpmmBQdbCDogY+3csq5lYnxU
	 tQL4o3bo2+7ZBX9PoA3zLnF7Sv1UK5PaO/gIT791/19XwVlt2k7jyalBr7wP9aRsws
	 3p2CVxXWDE2QBarrn3xJfsh00TDf9Mdy5TyBCAcZkUvYFvB8hltZ+kkqjCBjgDbbZ0
	 Vqze5QxGkmUxDUE1qiG6WDsmB4IL9uh8nnC9LULFsVRhGaveAC4JAnu5/wtlTPCTTN
	 IRYI0WcIckagQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 4/6] perf tools: Show memory region in perf-script
 subcommand
Reply-To: sashiko-reviews@lists.linux.dev
To: "Thomas Falcon" <thomas.falcon@intel.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260709221736.33446-5-thomas.falcon@intel.com>
References: <20260709221736.33446-1-thomas.falcon@intel.com>
 <20260709221736.33446-5-thomas.falcon@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 09 Jul 2026 22:28:11 +0000
Message-Id: <20260709222811.C9CEB1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Processing a crafted perf.data file triggers a stack buffer overfl=
ow due to integer underflow in size tracking and unbounded string operation=
s, allowing potential arbitrary code execution.
- [Medium] The destination buffer `out` is too small to hold the formatted =
memory information string along with its prefix, leading to silent truncati=
on.
--

--- Patch [4]: [PATCH 4/6] perf tools: Show memory region in perf-script su=
bcommand ---
commit 39c0417fbcfb9d114a4a74dd75932d9174d65104
Author: Dapeng Mi <dapeng1.mi@linux.intel.com>

perf tools: Show memory region in perf-script subcommand
   =20
This commit adds the memory region field to the perf-script subcommand
output. It utilizes the mem_region field introduced for Intel's OMR facility
and increases the output buffer sizes to accommodate the new region string.
   =20
Link: https://lore.kernel.org/all/20260114011750.350569-1-dapeng1.mi@linux.=
intel.com/

> diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
> index 9ac29bdc3cd54..e82ab5cb842e2 100644
> --- a/tools/perf/builtin-script.c
> +++ b/tools/perf/builtin-script.c
> @@ -2081,8 +2081,8 @@ static int evlist__max_name_len(struct evlist *evli=
st)
>  static int data_src__fprintf(u64 data_src, FILE *fp)
>  {
>  	struct mem_info *mi =3D mem_info__new();
> -	char decode[100];
> -	char out[100];
> +	char decode[150];
> +	char out[150];
>  	static int maxlen;
>  	int len;
> =20
> @@ -2090,10 +2090,10 @@ static int data_src__fprintf(u64 data_src, FILE *=
fp)
>  		return -ENOMEM;
> =20
>  	mem_info__data_src(mi)->val =3D data_src;
> -	perf_script__meminfo_scnprintf(decode, 100, mi);
> +	perf_script__meminfo_scnprintf(decode, 150, mi);
>  	mem_info__put(mi);
> =20
> -	len =3D scnprintf(out, 100, "%16" PRIx64 " %s", data_src, decode);
> +	len =3D scnprintf(out, 150, "%16" PRIx64 " %s", data_src, decode);

[Severity: Medium]
This is a pre-existing issue, but I am wondering if the out buffer is large
enough here in data_src__fprintf()? After the 17-byte prefix, only 132 bytes
remain for the decode string. Valid combinations of memory bits can easily
exceed this limit, especially with the addition of the new Region field.
Could this lead to silent truncation?

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
This isn't a bug introduced by this patch, but this newly added function
replicates a pre-existing pattern that seems unsafe. If
perf_mem__region_scnprintf() is called with sz equal to 0, sz -=3D 1 will
underflow to a large unsigned value, and out[0] =3D '\0' will write out of
bounds.

> +
> +	if (mem_info)
> +		mem =3D mem_info__const_data_src(mem_info)->mem_region;
> +
> +	switch (mem) {
> +	case PERF_MEM_REGION_NA:

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
This is a pre-existing issue, but could this sequence of calls in
perf_script__meminfo_scnprintf() lead to a stack buffer overflow?

If any previous formatter returns a length that exceeds the available space,
i will become greater than sz. If that happens, the sz - i calculation
passed to subsequent formatters will underflow to a large unsigned value,
completely disabling bounds checking.

For example, perf_mem__lvl_scnprintf() uses strcat in some cases:

    if (printed++) {
        strcat(out, " or ");
        l +=3D 4;
    }

This unbounded strcat can push the return length beyond the allocation,
guaranteeing i exceeds sz in the caller. Should the bounds tracking in
these functions be updated to prevent this underflow from propagating?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260709221736.3344=
6-1-thomas.falcon@intel.com?part=3D4
