Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FCAF3E3141
	for <linux-perf-users@vger.kernel.org>; Wed, 23 Sep 2026 17:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790183917; cv=none; b=fL+0Um1puQIHAcrUG4MZiBKe9BYM7HRPWVEj3ral6RIzVuEwuea+MYvXckJxtPnw6eiIY6odg0/jubYTeD/KAkUxfR/T77Gh4I4n0KRlTNrjbFPWAu8VLdVcR+iIrspJc7ZzTaTEliV2veLvBH2y2ElecVWG5sb2FlU73nvn4Yg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790183917; c=relaxed/simple;
	bh=oG47tRneEZz2gJe3bUdx+n9UnOaC9FJhE2x9zbzcfyo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=bTSTq3AF0nMJUgjSsrFR7nnZIerfuuCFa/cz40r5boYgBBHLrj7VLvG7soOWZQJB+hEcZ6oQczfhqkRsyayE1y3smlOnbmzC+VDBExlgrt31vEKnOAc05cUSJ4SjnOX9WEhrPokoXJVMyz0UbyJV6DPl+JhD3upVJL3pEMIcw+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vp8Rq0Jw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vp8Rq0Jw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06D711F00893;
	Wed, 23 Sep 2026 17:18:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790183916;
	bh=VOG3jVaF3z1yRrBPRQpETOf3onDl5AAXqcjjEOReKf8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Vp8Rq0JwXzoH7EHqaastOzOgCQlZJwEPmvXFl5+Pmdv7qhM+53HoBiYveq59VaW3E
	 EtlMZubCS4XXEhZxtzmbGIadJ/WDCTuiPlq2Z1a1eUN6dKroF1VFRKAxZ2vn4TbVOk
	 q14E73eGjJ2NuxTbc/u+NQBnl/mUNPx6edmdgmf/V5Q7hhnBZZJEFmHHpRBxuAaZE8
	 gUFNVGJs/fOUpaKhq4L81oJwcWLn65xX0cu8m+EDXA0I5NzO9n9YQYPaeGD0cZ5VZY
	 FXl8OVH4G85OChzFicfhF1hipKGHpXgCVR45kSVQ3RN9ysDOVfrkY7sWEE/qq8nvYk
	 VUkZ7SWSyUf4g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v12 6/6] perf c2c: print memory region data with stdio
 output
Reply-To: sashiko-reviews@lists.linux.dev
To: "Thomas Falcon" <thomas.falcon@intel.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260923170903.48388-7-thomas.falcon@intel.com>
References: <20260923161043.95C171F000FF@smtp.kernel.org>
 <20260923170903.48388-1-thomas.falcon@intel.com>
 <20260923170903.48388-7-thomas.falcon@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 23 Sep 2026 17:18:35 +0000
Message-Id: <20260923171836.06D711F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> Print memory range data in perf-c2c subcommand. Only available in stdio
> mode currently. If memory ranges are not supported or present, print
> nothing.
>=20
> Example output of perf c2c report --stdio:
>=20
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>                   Memory Ranges
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> Range 0: [0x0000000000000000-0x00000000bfffffff] Node 0, local region id =
0, remote region id 255
> Range 1: [0x0000000100000000-0x000000203fffffff] Node 0, local region id =
0, remote region id 255
> Range 2: [0x0000008000000000-0x0000027fffffffff] Node -2, local region id=
 1, remote region id 255
> Range 3: [0x0000028000000000-0x0000047fffffffff] Node -2, local region id=
 1, remote region id 255
> Range 4: [0x0000048000000000-0x000004ffffffffff] Node -2, local region id=
 1, remote region id 255
>=20
> Assisted-by: Sashiko:gemini-3.1-pro-preview
> Reviewed-by: Ian Rogers <irogers@google.com>
> Reviewed-by: Namhyung Kim <namhyung@kernel.org>
> Signed-off-by: Thomas Falcon <thomas.falcon@intel.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260923170903.4838=
8-1-thomas.falcon@intel.com?part=3D6

