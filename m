Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C0C6330D23;
	Sun,  1 Mar 2026 14:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772373688; cv=none; b=uBrG2uzLnE9iqmpnooyfSaWoJLlcyW0QrWj+sDDoAoSOsme/7JM8Nz7m5uXhDljJf9ZwMuhYVUTwRgmrMER41ALWjWz0RI4dm/mvEdAbKKPH76ffPXas5wJs6AhiJ41uJyuALwNN08QOjMzj8ivVUwH0/uy+5+VD710YIj+1FZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772373688; c=relaxed/simple;
	bh=UkBj1fdmtvPjwtZegWWzCtYjCqUCWuBNOkweq8/Mwi4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rzYhxs6xqC9SBP2PGaerlvAppZIXoICnqkUfYX8oW2FrteXZfMnBye9ZWIEU0OVwsMbEerZ1AoDKSHN9Qed9/XBKTUxJiYF5bui86IoKtDl48V+kIi2Mz+0m/HdIOCcZl9mADTOvg9fQRQokcg16u6oFWG1rdT9HpEHSFt2g1JQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cGXTTNyB; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cGXTTNyB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E186C116C6;
	Sun,  1 Mar 2026 14:01:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772373688;
	bh=UkBj1fdmtvPjwtZegWWzCtYjCqUCWuBNOkweq8/Mwi4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cGXTTNyBmnlKyu44XrDMcP6siXQEcE1rTkKz44S352nCoKVYzDHTizYoQYkdPaQv7
	 Tdc2cXxNwYr0PLkwc2wA9iRwLyk2LNzHCmLr1WfErPDg+MSpZGpF0jUmB/Iccm4hln
	 UKVi/T4tlUzyzAaDFLxxoC+WgQdVPwPyD7al/qmb5gieOo/yrAqDwapzRI5WufVhL5
	 AXYHoJI+CB0uj7IeiJ7bYqvfZAie0z0Fn5A547Fhp+3QOOIdjmJhgx/0wux4FM0YBe
	 I1/IYSYfL/mjQMq26y7UsuJYo8je+pofw9d6n3UydO7IaajkA17cj4LYar2gxH5itN
	 CjQ9MCqPspwDA==
Date: Sun, 1 Mar 2026 14:01:20 +0000
From: Conor Dooley <conor@kernel.org>
To: Lv Zheng <lv.zheng@linux.spacemit.com>
Cc: Conor Dooley <conor.dooley@microchip.com>,
	Tomasz Jeznach <tjeznach@rivosinc.com>,
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>, Yixun Lan <dlan@kernel.org>,
	Jingyu Li <joey.li@spacemit.com>, Zong Li <zong.li@sifive.com>,
	Yaxing Guo <guoyaxing@bosc.ac.cn>, iommu@lists.linux.dev,
	linux-perf-users@vger.kernel.org, linux-riscv@lists.infradead.org,
	spacemit@lists.linux.dev, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 4/8] dt-bindings: iommu: Add spacemit/t100 features
Message-ID: <20260301-acclimate-suburb-fc46da7e0cea@spud>
References: <cover.1772289741.git.lv.zheng@linux.spacemit.com>
 <D8CE6E5B1001D797+a6f36da0272ac18fff2a992976b1defc3bb01af6.1772289741.git.lv.zheng@linux.spacemit.com>
 <177231592262.848068.18080490567217057666@spud>
 <CAB7A310CE95B577+5f5c0825-25dd-4035-9316-db940c00216b@linux.spacemit.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="6IVfBrCiv9PlDrY6"
Content-Disposition: inline
In-Reply-To: <CAB7A310CE95B577+5f5c0825-25dd-4035-9316-db940c00216b@linux.spacemit.com>


--6IVfBrCiv9PlDrY6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 01, 2026 at 11:48:37AM +0800, Lv Zheng wrote:
> On 3/1/2026 5:58 AM, Conor Dooley wrote:
> > On Sat, 28 Feb 2026 22:44:49 +0800, Lv Zheng <lv.zheng@linux.spacemit.c=
om> wrote:
> > > Adds device tree bindings for SpacemiT T100 specific features by
> > > introducing spacemit,t100 compatible. T100 contains distributed IOATC=
s,
> > > each of which exposes pmiv interrupt.
> > >=20
> > > Signed-off-by: Lv Zheng <lv.zheng@linux.spacemit.com>
> > > Signed-off-by: Jingyu Li <joey.li@spacemit.com>
> >=20
> > Patch content here is fine, but the signoff chain on this patch is not
> > right. What did Jingyu do? You're author and submitter so either Jingyu
> > did nothing and should be removed, or is a co-developer which requires
> > attribution via the co-developed-by tag. If the latter, their signoff
> > should be before yours (the submitter is always last).
> >=20
> > pw-bot: changes-requested
>=20
> She is responsible for the common HPM part, and I just gave my comments to
> help to improve the quality of that implementation.
> I was just focusing on enabling and maintaining the T100 specific feature=
s.
>=20
> Our patches will go each other's local repository, leaving such tracks. T=
hat
> means the patch from me is Reviewed-and-tested-by her.
> And I'm responsible for sending the whole patchset for upstreaming.

Then you need to either fix your email setup (because it's not inserting
=46rom: Jingyu Li <joey.li@spacemit.com>) so that she is marked as the
author or actually set her to the author in git if you haven't.
Currently it looks like this when applied:
commit 872978c875731be43e84bec38798cb8ecd42b7a0
Author: Lv Zheng <lv.zheng@linux.spacemit.com>
Date:   Sat Feb 28 22:44:49 2026 +0800

    dt-bindings: iommu: Add spacemit/t100 features
   =20
    Adds device tree bindings for SpacemiT T100 specific features by
    introducing spacemit,t100 compatible. T100 contains distributed IOATCs,
    each of which exposes pmiv interrupt.
   =20
    Signed-off-by: Lv Zheng <lv.zheng@linux.spacemit.com>
    Signed-off-by: Jingyu Li <joey.li@spacemit.com>

In both cases, you need to change the order of signoffs so that yours is
last as the submitter.

--6IVfBrCiv9PlDrY6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaaRGlAAKCRB4tDGHoIJi
0mn2AP9rkEy4Ug5UediDg3aHRB/C9s3CSKAV8D0oiZ4Ym/UFnAD/UGK6en/VYMcZ
uBeeFSlzBPwP3I39ikzedY+nhp68sQE=
=VAxN
-----END PGP SIGNATURE-----

--6IVfBrCiv9PlDrY6--
