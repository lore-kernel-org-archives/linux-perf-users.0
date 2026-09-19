Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 056C2353A99
	for <linux-perf-users@vger.kernel.org>; Sat, 19 Sep 2026 01:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789779924; cv=none; b=L41hEZV0C13UXGaZwm96NrwmnsnB5cOZNEA+la/MzKfgQtxTsSUqrri58Wa4VgV/IQSVAuVUfngPZvRvGFATTQlQ6Jqi/EmBKj7lnf1sMgwt3r3pUNUrmdbDr55MS3qRkq/jDzdaK0umUC3h7bePf5W+KwpAk+PAg76YmD2JO/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789779924; c=relaxed/simple;
	bh=CK5giABOHwLTkDq9nVCHD0von64LPY8E/IKGc0gZvMI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=kaEBeUdk5a9Jtqxi/f/E2FwdJ3HEab6ydc61soIFpAgkSM3Iz5VeyRlqFhAaAcH9j69QAMb5lc1IAplcxJgN23xFigx+DcHs0A/KNkZQGJM2CclZKZTlj044mjlUmZvZLB7m0s5s6Ob/udjQuBj9OeYyllVwk9Iuq//s6r6YbU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dm4HXahK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dm4HXahK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEEB51F00898;
	Sat, 19 Sep 2026 01:05:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789779907;
	bh=XsP6njBu3DdD8IYZPdtBFo+ewUp840BCIsaKHov1dZs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=dm4HXahKkdtDO+hadh91GC54UA+AekckZ+vjO/O0kLfVpJMt76cHCiK0IGVEGlO98
	 PtpKWpblHlbblc8mXvJw85IbMvwPy3fFYFeCrTnKu6uH8rjAxD/dEhKpCdxIna5yuY
	 ZVGLxN0NEMyZ5ZV8id6SEaZTdGBfnFQWZdkcw/Y7h7WuqR3qGwBOYdbmGCVF+AVlea
	 89No8BHJ340Yywg9dqCj71lfEG5Qswa1n6Hl/Qhxadgkox+cPy6VwByOLq07MDke9D
	 IZAyIaGrCuk5L/ZwJpmgpJt1quQWFvb6D+53fHcqeogPjzSz+jv7uIsRoASJSSImY7
	 skbvqw2xUPhvQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 perf-tools-next 6/7] perf trace beauty: Validate
 payload size in augmented sockaddr beautifier
Reply-To: sashiko-reviews@lists.linux.dev
To: "Aaron Tomlin" <atomlin@atomlin.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260919005530.728615-7-atomlin@atomlin.com>
References: <20260919005530.728615-1-atomlin@atomlin.com>
 <20260919005530.728615-7-atomlin@atomlin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 19 Sep 2026 01:05:07 +0000
Message-Id: <20260919010507.BEEB51F00898@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] perf: missing stddef.h inclusion for offsetof() violating musl comp=
atibility
--

commit 319d4746425928b01209fdee80a73a7983207fbb
Author: Aaron Tomlin <atomlin@atomlin.com>

perf trace beauty: Validate payload size in augmented sockaddr beautifier

This commit adds payload size validation to the augmented sockaddr beautifi=
er
in perf trace. It prevents reading memory past the available buffer when
parsing malformed or truncated records.

> diff --git a/tools/perf/trace/beauty/sockaddr.c b/tools/perf/trace/beauty=
/sockaddr.c
> index a17a27ac2a6ff..98fdabc997812 100644
> --- a/tools/perf/trace/beauty/sockaddr.c
> +++ b/tools/perf/trace/beauty/sockaddr.c
> @@ -39,31 +39,48 @@ static size_t af_local__scnprintf(struct sockaddr *sa=
, char *bf, size_t size)
>  	return scnprintf(bf, size, ", path: %s", sun->sun_path);
>  }
> =20
> -static size_t (*af_scnprintfs[])(struct sockaddr *sa, char *bf, size_t s=
ize) =3D {
> -	[AF_LOCAL] =3D af_local__scnprintf,
> -	[AF_INET]  =3D af_inet__scnprintf,
> -	[AF_INET6] =3D af_inet6__scnprintf,
> +static const struct af_scnprintf {
> +	size_t (*scnprintf)(struct sockaddr *sa, char *bf, size_t size);
> +	size_t min_size;
> +} af_scnprintfs[] =3D {
> +	[AF_LOCAL] =3D { af_local__scnprintf, offsetof(struct sockaddr_un, sun_=
path) + 1 },

[Severity: Low]
Does this code need an explicit inclusion of stddef.h for the offsetof macr=
o?

When compiling perf tools against musl libc, relying on implicit includes c=
an
lead to compilation failures because musl does not include headers implicit=
ly
like glibc does. Should an explicit include for stddef.h be added to mainta=
in
compatibility with musl?

> +	[AF_INET]  =3D { af_inet__scnprintf,  sizeof(struct sockaddr_in) },
> +	[AF_INET6] =3D { af_inet6__scnprintf, sizeof(struct sockaddr_in6) },
>  };

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260919005530.7286=
15-1-atomlin@atomlin.com?part=3D6
