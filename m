Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35E692E7366
	for <linux-perf-users@vger.kernel.org>; Tue, 29 Sep 2026 01:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790644984; cv=none; b=kTXFxxUl6lSvBp1+EgaaUKGOD+HLlJ9+oEfRyICcewQAhZ9B63MO5wh2lzGunywhdVnbMkcJkMH56gAFKOAhaiqQWkMyqqQlmaaTfAdDTAsI6Q2jVIaz0iIBUzx1cP/qWbAIaftli4iTifcUMmh3a8Mhod5EJDlv3TlCP2xz228=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790644984; c=relaxed/simple;
	bh=XhF/K83wDyxIe18z3GpEPiWabfzBNUVikkVlxVjrQIQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=FtKNE1yBwgQ3OQX1Hk1yded/+cazj0iQl5LAUvGJqeLeGPQLxPobDQUI7Hw4dBJEi+pSZTLOEpL0bKnAmd3SNa2WLC+JAm+qzwpaJbNg5EwFynT1Xf4xLgyQquQ4EcOs0u5DFy3oq4uoRKKhK98MmCMRK9M8G7AlO55hnLnfbe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DqSrB/Ih; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DqSrB/Ih"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 984D51F00893;
	Tue, 29 Sep 2026 01:23:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790644982;
	bh=/pjPAmyV68N6iQxY1R6uGSooPUnYdtCwvre5mU0MZUY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=DqSrB/IhZYjtFOZFz8fslH1lNi1NZ9VUYr3O/PcZN+9wdl/EbFIbtDaIAJfJuqfBo
	 qMlR+XRWAl2e82QtUQerH6aczF64sVbAwoQGwCQePND/CFhWB/UsD/MBmSwSQGXpFr
	 OQn+naLc8iImHY5rEP6ZhT5/xNWIY/jNmVz/IFD1C1drFaxnXxocDDMbw2jvM8MyeO
	 R9+N6ESgJrVGu2yons6B8ZiJJeCg311NxiIXvXcp04Ru8VGH5AGzbb8cEc6AQZSwOk
	 7CLSm12I635GLvPnLPKYcK0PT69cJNTwYuz7Dt123XnOZpU5FcMvLRnkLNX5SsCQHD
	 xpHHKNxWN7wlA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 3/8] perf tools: Check system path when check
 debuginfo
Reply-To: sashiko-reviews@lists.linux.dev
To: "Namhyung Kim" <namhyung@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260929011139.53242-4-namhyung@kernel.org>
References: <20260929011139.53242-1-namhyung@kernel.org>
 <20260929011139.53242-4-namhyung@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 29 Sep 2026 01:23:02 +0000
Message-Id: <20260929012302.984D51F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] perf: skipping libdw fallback on stripped binaries breaks debuginf=
od
--

commit b8cad86bb3e8eff20f4bbb18f568843350d829d9
Author: Namhyung Kim <namhyung@kernel.org>

perf tools: Check system path when check debuginfo

This commit refactors debuginfo__new() to check the system path via
dso__find_dbginfo_type() rather than using an explicit fallback. The new
approach adds DSO_BINARY_TYPE__SYSTEM_PATH_DSO to the debuginfo types list
and removes the fallback code in debuginfo__new().

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

[Severity: High]
Does this skip the libdw fallback entirely for stripped binaries, which
could break remote debuginfo resolution via debuginfod?

When running a tool like perf annotate on a stripped binary that lacks local
debuginfo files, dso__find_dbginfo_type() checks for debug sections:

tools/perf/util/dso.c:dso__find_dbginfo_type() {
    ...
		if (filename__has_section(buf, ".debug_info") ||
		    filename__has_section(buf, ".zdebug_info"))
			break;
    ...
}

Because stripped binaries fail this section check, their type is marked as
DSO_BINARY_TYPE__NOT_FOUND even when DSO_BINARY_TYPE__SYSTEM_PATH_DSO is
evaluated.

This causes the dso__read_binary_type_filename() check in debuginfo__new()
to fail and return NULL early. By bypassing __debuginfo__new(), this
prevents libdw from invoking dwfl_standard_find_debuginfo() to remotely
resolve the debuginfo.

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
> +	return dinfo;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260929011139.5324=
2-1-namhyung@kernel.org?part=3D3
