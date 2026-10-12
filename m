Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB6C537F75D
	for <linux-perf-users@vger.kernel.org>; Mon, 12 Oct 2026 23:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791849413; cv=none; b=dulsKSIeiTdlB5nlf3sFNqN9+eswt0lf6s+F3nC5LGetzyBJrd1sVTX2feN5irjs9RcmExp6JBV3yzAyASDXZKycdkz+dngfePRo/MpVQjyQTgm4y1w0dNxjsQ1csfczaGSq2E626aFm8Y3gXEo3TTSh3Elg7oMhxwOwDMig7Ak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791849413; c=relaxed/simple;
	bh=JqUlZAyW6+2LWheeMjNj2na7sG0ywNzz6U+5VKiRg8k=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=DA8hHEvV8UmvUHbKTvB3m6aMk6xmcDljvK/v7HYxUKgpsXiuMv3xsEMfuafcF1qP0pobfCz/CMJCGbttL8SuIJyf3DhbeavHDd3XRifSh8rcS1n1xzqTV5Cv3keK5vcmgs793mk5FlUTbtkDZqsOGyW6Gh9WqftPMAzceoVRFB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bTGlz5Rz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bTGlz5Rz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 769321F0089B;
	Mon, 12 Oct 2026 23:56:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791849412;
	bh=HA3WSrjtrqt3ilXXy4AfciscmtzifBikRAXPuFZseh4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=bTGlz5Rz0TeLU5Jla9fxYpt4xdj1wh3AlW4YAIGTXobfZB8rN4clgw89cjB5seIVW
	 ldjcnJ+uvA03/apgACX8H5rP7fcePlG62tlvE1Wy7L68VanZS4KBx320NdhxWHwk+j
	 v3kYBCvh7fYztplGyy8FI9aCrnn5avcGjthK8mb0ZIqWhfrltqRkW2dJ3lyXc+BwdV
	 i//3XHrvIb3Xd6Ac4kEirZLJWCI5AmtkaD3cwj5Vkt0/F8jUgMyYGmdWvlx0zp06Z8
	 huZRWq1OGYy6LtIfeK7j/negYLHh50VgAjH57E+4CNI/ZAODKwR10xohti8S5N1rD9
	 E1tSht6eTeUcg==
Message-ID: <sashiko-outbox-168757@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 02/10] perf tools: Try linked debug files for DSO
 debug info
Reply-To: sashiko-reviews@lists.linux.dev
To: "Namhyung Kim" <namhyung@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261012234654.60666-3-namhyung@kernel.org>
References: <20261012234654.60666-1-namhyung@kernel.org>
 <20261012234654.60666-3-namhyung@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 12 Oct 2026 23:56:52 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] perf dso: DEBUGLINK path resolution flaws in dso__read_binary_ty=
pe_filename
--

commit 0c61bd07a4d26ed6f7bfc347b3ec0fe6ffc13ca0
Author: Namhyung Kim <namhyung@kernel.org>

perf tools: Try linked debug files for DSO debug info

This commit modifies dso__find_dbginfo_type() to include
DSO_BINARY_TYPE__DEBUGLINK in its search array. This allows perf to follow
.gnu_debuglink to locate debug information in separate files.

> diff --git a/tools/perf/util/dso.c b/tools/perf/util/dso.c
> index df03f84c97235..913877b84b2d4 100644
> --- a/tools/perf/util/dso.c
> +++ b/tools/perf/util/dso.c
> @@ -2111,6 +2111,7 @@ void dso__find_dbginfo_type(struct dso *dso)
>  		DSO_BINARY_TYPE__OPENEMBEDDED_DEBUGINFO,
>  		DSO_BINARY_TYPE__BUILDID_DEBUGINFO,
>  		DSO_BINARY_TYPE__SYSTEM_PATH_DSO,
> +		DSO_BINARY_TYPE__DEBUGLINK,

[Severity: Medium]
Enabling DSO_BINARY_TYPE__DEBUGLINK here exposes path resolution regression=
s in
dso__read_binary_type_filename().

If the filename lacks slashes, does this logic create an empty string for
dso_dir, breaking relative paths?

tools/perf/util/dso.c:dso__read_binary_type_filename() {
	...
	last_slash =3D filename + len;
	while (last_slash !=3D filename && *last_slash !=3D '/')
		last_slash--;

	strncpy(dso_dir, filename, last_slash - filename);
	dso_dir[last_slash-filename] =3D '\0';
	...
}

Additionally, does this direct host filesystem I/O bypass the container mou=
nt
namespace (/proc/<pid>/root/) fallback context?

tools/perf/util/dso.c:dso__read_binary_type_filename() {
	...
	if (!is_regular_file(filename)) {
		ret =3D -1;
		break;
	}

	ret =3D filename__read_debuglink(filename, symfile, PATH_MAX);
	...
}

Finally, does this inject the symfs-prefixed dso_dir into the middle of the
/usr/lib/debug path, searching the host filesystem instead of the symfs
chroot?

tools/perf/util/dso.c:dso__read_binary_type_filename() {
	...
	for (i =3D 0; i < ARRAY_SIZE(debuglink_paths); i++) {
		snprintf(filename, size,
				debuglink_paths[i], dso_dir, symfile);
	...
}

>  		DSO_BINARY_TYPE__NOT_FOUND,
>  	};
>  	const enum dso_binary_type *type;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261012234654.6066=
6-1-namhyung@kernel.org?part=3D2
