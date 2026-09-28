Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 716A23FF886
	for <linux-perf-users@vger.kernel.org>; Mon, 28 Sep 2026 05:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790575198; cv=none; b=bDvcBmWiIciOMstjDoU+CrGA2k6oLNRrMcSkXbzIifx5d4fWQPrajja1KQ8mFE9WuARYLbIqN/YOelVX9Kue3Au7Wxug4tr6v5sc6NR62J9kYQzo4jD0lm7VvJEOsbCjppHcvHfXgRuJZJcsSIMDw1lMhV/bVRgG4FuYMJwdmsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790575198; c=relaxed/simple;
	bh=0yYb0boSR6tcJwGUez3E2YXF1pTBQ9XiusHkT3CS6n4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=mcIYodwew3dM/ttzUVBI2QdH4S9ebGXhDl7OopWmbmqp5PZw799ny38R5s9Cod+dVEntrl3evE7PIp8sDkdxY7A6xdFv77GQ21XatT1WmdlZ6Sgm8/mFMSRu/i8DRgQ4nCj1Q1NjdGNJe3OdbgOnMoVqxjQQgECfsciF9Ygadgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mgg0flJG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mgg0flJG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D386E1F000FF;
	Mon, 28 Sep 2026 05:59:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790575197;
	bh=gTSS4RqeEZmNvgutFkHNT6kBJkESk+DSvt3jH5/yzpQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Mgg0flJGpzOnr/F1b8imhcJHYTsVQHFpqzMyDDsivVHoEf/DJfQRZHgi3qPTKPJro
	 86hhyg3YXSl6zxoww+qyrrCy36mD8xMLHhI0PMHAtDgAnSj8VZoCXUq4ylE7PFc2gp
	 OH8UzUHANT/xjfRPw2ELE0AkcdsUxQ+bJIi4357PJDHDU9grxVvKWfyrjpm+hT0oSD
	 6q+r6NlN4H/FwR2B+g5H1aZq6sYrrdZQ2OdZFlbV+vE6BIwLPzxt51PpSoG17qienB
	 YAmbs40dCLywP/X9g2qenBcTcG283sLDdIGnc5sxTZ8ihrm6JYGOB/CoQkCWpbNFSN
	 9n/JAkZQESJ4Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 3/8] perf tools: Check system path when check
 debuginfo
Reply-To: sashiko-reviews@lists.linux.dev
To: "Namhyung Kim" <namhyung@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260928055055.95144-4-namhyung@kernel.org>
References: <20260928055055.95144-1-namhyung@kernel.org>
 <20260928055055.95144-4-namhyung@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 28 Sep 2026 05:59:56 +0000
Message-Id: <20260928055956.D386E1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] perf tools: Loss of DWARF support for .gnu_debugdata and .zdebug_i=
nfo
--

commit 945ce7f07042383e50c7db270f3808ce02dd95b3
Author: Namhyung Kim <namhyung@kernel.org>

perf tools: Check system path when check debuginfo

This commit removes the fallback to open the given binary path in
debuginfo__new() and instead relies on checking the SYSTEM_PATH_DSO
type within dso__find_dbginfo_type().

> diff --git a/tools/perf/util/debuginfo.c b/tools/perf/util/debuginfo.c
> index d6bd0fcc22648..2669d5f5ee612 100644
> --- a/tools/perf/util/debuginfo.c
> +++ b/tools/perf/util/debuginfo.c
[ ... ]
> @@ -114,18 +114,12 @@ struct debuginfo *debuginfo__new(const char *path)
>  	dso__find_dbginfo_type(dso);
>  	if (dso__read_binary_type_filename(dso, dso__dbginfo_type(dso), &nil,
>  					   buf, PATH_MAX) < 0)
> -		goto out;
> +		return NULL;
> =20
>  	dinfo =3D __debuginfo__new(buf);
>  	dso__put(dso);
> =20
> -out:
> -	if (dinfo)
> -		return dinfo;
> -
> -	/* if failed to open all distro debuginfo, open given binary */
> -	symbol__join_symfs(buf, path);
> -	return __debuginfo__new(buf);

[Severity: High]
Does removing this fallback break DWARF support for files using alternative
debug sections like .gnu_debugdata (mini-debuginfo) or .zdebug_info?

The new logic entirely relies on dso__find_dbginfo_type() successfully
returning a binary type. However, dso__find_dbginfo_type() strictly
validates the file by exact string match:

tools/perf/util/dso.c:dso__find_dbginfo_type() {
	...
		if (filename__has_section(buf, ".debug_info"))
			break;
	...
}

Because files relying on .gnu_debugdata or .zdebug_info do not have a secti=
on
named exactly ".debug_info", this check fails. The type then defaults to
DSO_BINARY_TYPE__NOT_FOUND, and debuginfo__new() returns NULL.

Could this cause features like inline callchain resolution to silently fail=
 on
these binaries since we completely bypass libdw's native support for parsing
these alternative formats?

> +	return dinfo;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260928055055.9514=
4-1-namhyung@kernel.org?part=3D3
