Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B6B23CF21F
	for <linux-perf-users@vger.kernel.org>; Mon,  7 Sep 2026 02:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788746541; cv=none; b=GDQ6f99yyJB2C3mMIt9a1vmNVCB4s2f3dr2z0d1mlWeO7jSmF/Uq0VUeKpM2+eRvs4RumrgG7zek5Pak/fn+qJRXlfk+iPQRiivivI7WA18SHfhq6dkl88J6DcXfnS/7oYUcNnTOATbF7ecwfpQ8Q2BYnk2QC0mkwHtB5p63Bp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788746541; c=relaxed/simple;
	bh=FziIBUKJese3/zCVFdctWmeGSyB52RJMLBjyA2o1o3k=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Te8Yjd2Bm8gmGrt7m5NzlBumS68vlwTMbRkpxzXfCQISxrbzVkzSD1+k03jAw5UQTXd8FE+A+IqSslByY1sExUUDsjexuTvltfzRJvvH4J/0wgJxxRXoiyHzRkchgM5JVumLSWELvD3OYHuXUM9KEvgAmVM9sGXI61FAY+BlUag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GUcH0nMA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GUcH0nMA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E1C61F00A3A;
	Mon,  7 Sep 2026 02:02:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788746539;
	bh=/qR+D/vq8AZLDgd/YyGEBAMi2yNTTr7riV8aeqB6Veo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=GUcH0nMALyO1Lkfnv8QohK7uUTiZFJW0IItVcttI6CEQI9BtiSZlZgssYxr1LaN3A
	 oOmm8DUX3eDmRMswVOHhbn6gUYIuSiMH/iePiQlzolQb8XOzOncnJXdWYakZ8L+gp1
	 a36RrLb/0iRbWMdADfq+OONafiN2vFjeo66WrP+aNu+hbdT772Q1icz6+Cby84OwpP
	 azTuujXsU5bZUZ9qhMJVosHu57ar3XIEB9jsZEGa7KvfN11NuMiOySXBrpqJ+nxZO4
	 iYD9KKzUe1/4ohy0zR0Rzwerc8PRmcMzcfk9ueZHK7QTrr76Z7cDfkbhoUV0Q+/4yK
	 ttqyKD4wX8Qeg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 perf-tools-next 1/6] perf trace: Add upper bound
 checks for augmented BTF struct printing
Reply-To: sashiko-reviews@lists.linux.dev
To: "Aaron Tomlin" <atomlin@atomlin.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260907015140.363076-2-atomlin@atomlin.com>
References: <20260907015140.363076-1-atomlin@atomlin.com>
 <20260907015140.363076-2-atomlin@atomlin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 07 Sep 2026 02:02:19 +0000
Message-Id: <20260907020219.9E1C61F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> When pretty-printing augmented struct payloads using BTF via
> btf_struct_scnprintf(), augmented_arg->size is currently only validated
> against values <=3D 0.
>=20
> However, several edge cases can result in size mismatches or buffer
> over-reads:
>     1.  If arg->augmented.size is smaller than sizeof(*augmented_arg),
>         dereferencing augmented_arg->size reads past the available
>         buffer.
>=20
>     2.  If augmented_arg->size exceeds arg->augmented.size -
>         sizeof(*augmented_arg), calculating consumed =3D
>         sizeof(*augmented_arg) + augmented_arg->size can overflow signed
>         integer limits (e.g., with crafted INT_MAX values in an
>         untrusted perf.data file) or cause arg->augmented.size to
> [ ... ]
> btf_dump__dump_type_data().
>=20
> Fixes: cb32035214b9 ("perf trace: Pretty print struct data")
> Reported-by: sashiko-bot <sashiko-bot@kernel.org>
> Signed-off-by: Aaron Tomlin <atomlin@atomlin.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260907015140.3630=
76-1-atomlin@atomlin.com?part=3D1

