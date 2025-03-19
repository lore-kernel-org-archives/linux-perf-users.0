Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F636255E44;
	Wed, 19 Mar 2025 13:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742391173; cv=none; b=cvUoH6X9vlgURh+lCXZX050ZHJNIt4qqo27rpQWt/jTshQBW2Nf4Uz9uL6EPPBqGY6M671UMy3xwHVPZ7TLz6Np+r+DC2PH5JSD1FLe6MLX4+rYO1VloXOpKGG8oPH6P5ceO0JtpvKuxT2ezRwZx7EI58wukTzVxDtlERoO5BdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742391173; c=relaxed/simple;
	bh=UmbLkE3G+lImWSxYzI2cmejiT0+MhXgUb4SICK3ekoU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AamwK6/e3fkhANAG1zxcPYiml/Je38lt2QvkAAbfF41bgkMvvSEP52TiKEup+qvvkzWKFvf9kg4G3EQNU/s6/duzTVbcOiTIHUbBshMHC61hYzcga3Y8EGfzP0asdUzJg/WeBA1uCQlMUa8E1P1rSGabCwI9wUVhp/gl8u4yvIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i7PLjoNx; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i7PLjoNx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 162F6C4CEE9;
	Wed, 19 Mar 2025 13:32:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742391173;
	bh=UmbLkE3G+lImWSxYzI2cmejiT0+MhXgUb4SICK3ekoU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=i7PLjoNxeXyFkfFCxWxuKAMNTkMr/JU4cjlgnUl2p2aguKdlqPxjfHItXppQNIUI3
	 duMcWd5cWAXRyaQXEARjGbGhnwSR0KLNoasHbonncomc1z4o+4T1sFuOYSxB5q5TL/
	 iW37NWP134MUaADIHdvPS4eK7+9yMtqw04sUHt9a6Ygu/ojfo0rL+fRJDBfPUNqoJh
	 THs27D1urlu6dx/g8WyQmBxBsDvpSEezWPRxnP9B3tKF/NF1UJkpl/rGM1mImruYXL
	 Ilob95CevsfCaO8pS0pDdVaheWEmVpYYjSxNTvNOQ3ul4u7rZHlSIas1HuOwsw4Wra
	 Jyel91WjgMh/g==
Date: Wed, 19 Mar 2025 13:32:46 +0000
From: Mark Brown <broonie@kernel.org>
To: Jeremy Linton <jeremy.linton@arm.com>
Cc: linux-trace-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
	mhiramat@kernel.org, oleg@redhat.com, peterz@infradead.org,
	acme@kernel.org, namhyung@kernel.org, mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com, jolsa@kernel.org,
	irogers@google.com, adrian.hunter@intel.com,
	kan.liang@linux.intel.com, thiago.bauermann@linaro.org,
	yury.khrustalev@arm.com, kristina.martsenko@arm.com,
	liaochang1@huawei.com, catalin.marinas@arm.com, will@kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/7] uprobes: Allow the use of uprobe_warn() in arch code
Message-ID: <07499f3e-b730-444e-bd52-75bfaefef84f@sirena.org.uk>
References: <20250318204841.373116-1-jeremy.linton@arm.com>
 <20250318204841.373116-7-jeremy.linton@arm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="K9lkjfOgLHeIEjyd"
Content-Disposition: inline
In-Reply-To: <20250318204841.373116-7-jeremy.linton@arm.com>
X-Cookie: Chairman of the Bored.


--K9lkjfOgLHeIEjyd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 18, 2025 at 03:48:40PM -0500, Jeremy Linton wrote:
> The uprobe_warn function is limited to the uprobe core,
> but the functionality is useful to report arch specific errors.
>=20
> Drop the static so it can be used in those code paths.

=2E..and also make use of it in the arm64 code.

--K9lkjfOgLHeIEjyd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmfax30ACgkQJNaLcl1U
h9AkFQf/Y1q2Feg+KwP4cXtEJ9+aNY2Xsphb3PTa2oMFU3s3huFK2zT+Tw0wXrpB
T6eywqTDqWTMi2JY07llFmpN77P3NCk/wKxM3P1wnrf4+u06SthNy8nbKyXGRL+q
fljp81T5af2/Flj/OBFBGthbD7Dw8zRZjfn9TO1jR28NjsxcuARf7x1cX0pzQpTm
GH9CJKjInhK3LpzmCHbMvj7l4bJ/P+bBATxHsvboTgnazmAlPN/KjEI4NlBzObhP
n9nPZrAMVyMf4qF6q+BCOWs2rGEZ21PQFVzVzZoP8BeSwqwyq0VLvlvr7P5qQktq
gJJDd73z2qAdKnm1HXmzg61mBGQifQ==
=ChsK
-----END PGP SIGNATURE-----

--K9lkjfOgLHeIEjyd--
