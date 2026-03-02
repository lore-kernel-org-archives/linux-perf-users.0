Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DCE330BBB8;
	Mon,  2 Mar 2026 17:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772474002; cv=none; b=BDAGQrmgq+9swOJSRCDNSTriUBGvhT7ZX5MIOTDr0G55FWs7bdocuZ83U3OL59tI5qmnVZvmNtw86NciEdIqHsKB2wH3zJHIP2ikbwMoTUIXPlpflVJ1cYJZd997l/ae4T/WtssXpBvHeyfwSfIthWqDtISPxzNxuczS5rAMbb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772474002; c=relaxed/simple;
	bh=vhDHla+zJiCxWn7+ZSZE11bQ1FNt76Ap+xB09PlL9cw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SORjDYhZLVKRYzssuxQMNFS2mi7wuJ6acQazAuyi3Y5xq02o0genu2srbswIjL7ztB+xYOT99U8TIX1ohp9VV5hRROhcrdyHmF3FqFwCM5sLZ4/D8dvXjgGar2sBdtirnlhuy2HRXZnCuasCDOHUNrG0oo9o5EnPeKqXW/RRGak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o+AEWwv+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o+AEWwv+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61DCCC19423;
	Mon,  2 Mar 2026 17:53:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772474002;
	bh=vhDHla+zJiCxWn7+ZSZE11bQ1FNt76Ap+xB09PlL9cw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=o+AEWwv+jmzgY1erzPnHWxkX3AlnObHZo5pe1wzC5RmpeQHAvqUg/Lsy7SjWk7qTO
	 7syyv87bwfpmtUFjdF86NQGqR8d7SF0YHRnk2pK4wXJMcGBvjXj4NuEWzAWJrkDFPe
	 BGVQgvtg+Q1xuibe1C46QzpnqlpcUOgd5T/rCca7k2mP8070Bd2cNwwjMrImOdbEY5
	 i2uvePt+G4BgarGffz5JzPiBl979bOcBt0dFrOyMDn5XVxzui5u4WMA752C75SN0RF
	 xrne9rRo80jLSQTD8A5E7W60PU5YZ9SeeMjSvzquU3WYyXBzBsg6lieDQhW15q4nqT
	 bqkp3jzTJupnA==
Date: Mon, 2 Mar 2026 17:53:13 +0000
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
Message-ID: <20260302-constrain-untrue-71626a545008@spud>
References: <cover.1772289741.git.lv.zheng@linux.spacemit.com>
 <D8CE6E5B1001D797+a6f36da0272ac18fff2a992976b1defc3bb01af6.1772289741.git.lv.zheng@linux.spacemit.com>
 <177231592262.848068.18080490567217057666@spud>
 <CAB7A310CE95B577+5f5c0825-25dd-4035-9316-db940c00216b@linux.spacemit.com>
 <20260301-acclimate-suburb-fc46da7e0cea@spud>
 <B8675026D2F6DF58+946ff82a-2e2e-4abb-a3c4-26fe67c43ab8@linux.spacemit.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="bIo31++ptAE9jI+O"
Content-Disposition: inline
In-Reply-To: <B8675026D2F6DF58+946ff82a-2e2e-4abb-a3c4-26fe67c43ab8@linux.spacemit.com>


--bIo31++ptAE9jI+O
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 02, 2026 at 09:41:55AM +0800, Lv Zheng wrote:
> On 3/1/2026 10:01 PM, Conor Dooley wrote:
> > On Sun, Mar 01, 2026 at 11:48:37AM +0800, Lv Zheng wrote:
> > > On 3/1/2026 5:58 AM, Conor Dooley wrote:
> > > > On Sat, 28 Feb 2026 22:44:49 +0800, Lv Zheng <lv.zheng@linux.spacem=
it.com> wrote:
> > > > > Adds device tree bindings for SpacemiT T100 specific features by
> > > > > introducing spacemit,t100 compatible. T100 contains distributed I=
OATCs,
> > > > > each of which exposes pmiv interrupt.
> > > > >=20
> > > > > Signed-off-by: Lv Zheng <lv.zheng@linux.spacemit.com>
> > > > > Signed-off-by: Jingyu Li <joey.li@spacemit.com>
> > > >=20
> > > > Patch content here is fine, but the signoff chain on this patch is =
not
> > > > right. What did Jingyu do? You're author and submitter so either Ji=
ngyu
> > > > did nothing and should be removed, or is a co-developer which requi=
res
> > > > attribution via the co-developed-by tag. If the latter, their signo=
ff
> > > > should be before yours (the submitter is always last).
> > > >=20
> > > > pw-bot: changes-requested
> > >=20
> > > She is responsible for the common HPM part, and I just gave my commen=
ts to
> > > help to improve the quality of that implementation.
> > > I was just focusing on enabling and maintaining the T100 specific fea=
tures.
> > >=20
> > > Our patches will go each other's local repository, leaving such track=
s. That
> > > means the patch from me is Reviewed-and-tested-by her.
> > > And I'm responsible for sending the whole patchset for upstreaming.
> >=20
> > Then you need to either fix your email setup (because it's not inserting
> > From: Jingyu Li <joey.li@spacemit.com>) so that she is marked as the
> > author or actually set her to the author in git if you haven't.
> > Currently it looks like this when applied:
> > commit 872978c875731be43e84bec38798cb8ecd42b7a0
> > Author: Lv Zheng <lv.zheng@linux.spacemit.com>
> > Date:   Sat Feb 28 22:44:49 2026 +0800
> >=20
> >      dt-bindings: iommu: Add spacemit/t100 features
> >      Adds device tree bindings for SpacemiT T100 specific features by
> >      introducing spacemit,t100 compatible. T100 contains distributed IO=
ATCs,
> >      each of which exposes pmiv interrupt.
> >      Signed-off-by: Lv Zheng <lv.zheng@linux.spacemit.com>
> >      Signed-off-by: Jingyu Li <joey.li@spacemit.com>
> >=20
> > In both cases, you need to change the order of signoffs so that yours is
> > last as the submitter.
>=20
> BTW, since this version of this patch has been worked out all due your
> constructive feedback and suggestions. Now that it has functionally
> converged to what the community requested, can I add "Reviewed-by: Conor
> Dooley <conor@kernel.org>" for its next version?

No, as I said the previous time you asked, I will provide one when I am
happy with the patch. I have not yet reached a point with you were I am
comfortable providing tags with the assumption that you will make the
correct changes. There's no need to hassle me for one at this point
anyway, because you have to send a v6 anyway. If v6 is satisfactory to
the maintainers, they'll grab my tag when they apply the series.

Cheers,
Conor.

--bIo31++ptAE9jI+O
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaaXOiQAKCRB4tDGHoIJi
0poHAQDxsjjLOPKOtb2IC4WJzgt1JbGia7F26+iLWwTvK6+FLwEAzjWz3FACYBYP
Z2zqTAghSNd/jVb4Yr4Ozyd2TMj26Ao=
=tGDQ
-----END PGP SIGNATURE-----

--bIo31++ptAE9jI+O--
