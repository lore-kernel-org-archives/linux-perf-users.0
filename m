Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A37A13BBFB4
	for <linux-perf-users@vger.kernel.org>; Thu, 17 Sep 2026 06:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789625783; cv=none; b=n8cgUpX0SgT7agVzvKeuzXubL3RglhMvamGz73mGv1qQ84rDCPSOG+quJ/X+0hPjz71CwSp6tDR1FH3Vv/YxtTC965bo8+B35OJzaVsYT7kwH5N+Q0XL9thzKsyblHnbaOdUtZ6Py/9LDqErNEexEoQzt7Ue0sJGCbY0ma3ieS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789625783; c=relaxed/simple;
	bh=AJOIoBe15uhw6aijh65/05zucFD837NZUlDXa8HISvA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=nI4vGz+6aJny/OCfqffbJrvA2WL6Vepw/d68PIR0wvU1Vhcu1hziKiA1OdKgsfYb5ktZWlBk8loGCBQ+4/Wa2Se4wowwEV9hu1pRyb2MpBUxe/B5rk33BjLo7RCfac9mK5+/Atm11IUB4bveEDI0nsQazbrdf2ndOWIIxssux/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fy4zRPzY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fy4zRPzY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 245001F00893;
	Thu, 17 Sep 2026 06:16:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789625782;
	bh=AJOIoBe15uhw6aijh65/05zucFD837NZUlDXa8HISvA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=fy4zRPzY3Yf66beI6fRuTp/u9K1NKVAV/dmezybf10NoCLUISDe7Gjw7//AFIMbBM
	 hhCRg7KJhllHU8h8JJuGmUyhXTMQXw3pfiw53wwn4h8z2jqfnAlzI+Udqi6/eCtn6a
	 6yToVWG+7UtumXPCETXM0939kH10YLQ3zfO1znrGDZ/Vi39VdN67sA82lNL06SUhkK
	 6LRL1YNe2B5PYA+F/81UfWSgWi1HLDc2yj35EeB6m2O5G2GckvQnuSk8fZt/GarjZj
	 8fG+QCh5//c+X1zWOToypNIWN/cs6W1XQgawnEt0POTbd1CFK+fisajvgpbTTDcfwv
	 yaMmCxUb5TM+A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1] perf test: stat metrics cgroup strip possible slash
 from cgroup name
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260917061312.820074-1-irogers@google.com>
References: <20260917061312.820074-1-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 17 Sep 2026 06:16:21 +0000
Message-Id: <20260917061622.245001F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> The grep to match cgroup name in metric output assumes no leading / on
> the cgroup name, however, cgroups in /proc/self/cgroup may have a
> leading /. Strip the / if it exists to avoid failures to match the
> cgroup name in the perf stat output.
>=20
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260917061312.8200=
74-1-irogers@google.com?part=3D1

