Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA4001534EC
	for <linux-perf-users@vger.kernel.org>; Fri,  6 Jun 2025 19:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749239982; cv=none; b=N/C8zUtWBRYlsvECtskG48scEIXdWenbTEind/66qoGlfmumVtNpw2Z1GW2xWg9bLyttJmknoxfx9Gxh1zEQ/LackJNmP55FhivbKq774AvTXZSuKOMKBJnLS/nBctb74u13bIoy4dAhan/fU9zGEPkpqVwfdE1BxfKVa+xyMbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749239982; c=relaxed/simple;
	bh=QbLyy1UkIqmAE109A59if/o3tV7eSEy/bU+JC4B5e2c=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ttFCDxQVzM5bfEhzL41w6SgeVMrXlwAAC6P1jN8dMFnsaScUszoxuKmq0lSTdwmKKdcnFVttj0MbZdHo0GEuOCuAfewN/tsp7jpdqzJ5Lkhcz1DhNVgksQqIaT0k55s+EBnYEffPrHNpEH7ZpXPHW3NZWbH72dYHRxNGysvTwr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=michel-slm.name; spf=pass smtp.mailfrom=michel-slm.name; dkim=pass (2048-bit key) header.d=michel-slm.name header.i=@michel-slm.name header.b=b/7WUp5F; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=i8HsdEqq; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=michel-slm.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=michel-slm.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=michel-slm.name header.i=@michel-slm.name header.b="b/7WUp5F";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="i8HsdEqq"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id ACE2C1380324;
	Fri,  6 Jun 2025 15:59:38 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Fri, 06 Jun 2025 15:59:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=michel-slm.name;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1749239978; x=
	1749326378; bh=ATrXQVKBafWP25eyTCb2DITloA6vSkgE4MXf2OOOKE8=; b=b
	/7WUp5FoOliZIBjmRWVFiDQNzv0aY4nVUAYEquCgcUKwCNaXPoHTeYlo57bb1KbQ
	6kxCAKHnSefIwhVfZpT+WXje40aoKolsRv2/HVi1Mo3VTtBDEo5XQkOTNZ/iOEr3
	8qfMePviiT6GCyavDFAIhSRKmBBYdu030TbrlO3S6o52zm74FMAmrBENYODaKxbn
	wAmVXHxcGAD16dkZZVIOHYi2LrlU57w/jjVRkh2AVkZVRDpuiLZIVc8goOhbDuLw
	tXAEoCMpBXnPrnUytFpGYXwhmWJ558T3sxbnhEnhsGC/p0CZnOOLB+aPrCKJfeGV
	BtLLPmw5Ih+AChIW9L5Pg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1749239978; x=1749326378; bh=ATrXQVKBafWP25eyTCb2DITloA6vSkgE4MX
	f2OOOKE8=; b=i8HsdEqq4OAJmhrASNqKC8rD3ZK14PFOOJGXFpHlx8kt4d2cxHu
	abR4x0dOKjS2flzWEt6ayOh/ZA9AyZD5ohalosczSxPAW0QK8h3Kt02VgPqAt1h0
	cqEh8iWhATDK29ZHj0+tVrg9MF/nhcYv99x1VjHHss54AK/CS4tlweIZJFF/5tos
	2pT1vKOEHAat620GIoscmLk2/K/75whHm6QIfKY0F5Wrv44rJvhz3wnps0kbXbLJ
	8FgTTZ40mq9idzeid2bn9IY73XrKOQxxfcGH8DcbvXafMTE/A+xIf3MI8bfXgc4F
	PHdP90XDQktOerEwseO2wLK32+HFsRhgDtA==
X-ME-Sender: <xms:qkhDaLYcqVUHSvDmIvTEf2fTsHqiPCI4qAdjqUETQoQPOGRPTLG2Qg>
    <xme:qkhDaKbZivxdi1mLQOkF1E7J2ek4HngqrO4rLXLCMP6OlXzovF1EfHo79_mZ4SroK
    kVW53MwXkKWyrKKGCg>
X-ME-Received: <xmr:qkhDaN8nEtcxhLTML_nU4nWn1wCnmfDFSwyqpQKLLaG4qFlGSjLuJGghgjbnLR41DEtorhgSOCkueMdsZ4y_Zu5IKudqvClFsNA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddugdehheegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepkffuhffvveffjghftggfggesghdtreertderjeen
    ucfhrhhomhepofhitghhvghlucfnihhnugcuoehmihgthhgvlhesmhhitghhvghlqdhslh
    hmrdhnrghmvgeqnecuggftrfgrthhtvghrnhepueeggfefhfelhedukeffveefveejvefg
    feeggffggefgheeljeejhfefffeileejnecuffhomhgrihhnpehkvghrnhgvlhdrohhrgh
    dpkhgvhihogihiuggvrdhorhhgpdhfvgguohhrrghprhhojhgvtghtrdhorhhgnecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepmhhitghhvghlse
    hmihgthhgvlhdqshhlmhdrnhgrmhgvpdhnsggprhgtphhtthhopeefpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopegrtghmvgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtoh
    eplhhinhhugidqphgvrhhfqdhushgvrhhssehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhr
    tghpthhtohepjhgrmhgvshdrtghlrghrkheslhhinhgrrhhordhorhhg
X-ME-Proxy: <xmx:qkhDaBrABEtv55F8CDRVZY984GAUvjsnjvYKZfWmsl3Nd4-h42jCNg>
    <xmx:qkhDaGrr2BVo976QPHGHtBmdfOPFcPap4psrq28UCnct3_rZsqvGoA>
    <xmx:qkhDaHQUfKMm0BS4O0dVNAoRfx505GSQoFYqkAVIz_Cd5vkYgb-_aA>
    <xmx:qkhDaOp-wvvV3oayZOZ6PaFprbNBUzt9-6JmEx3rlZQRaAA1_7AZHw>
    <xmx:qkhDaFlsmGl5chGhKblnS13BibHYLkp2kbqIxQBwGgq72fwXgxIm3ZRp>
Feedback-ID: i71264891:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 6 Jun 2025 15:59:38 -0400 (EDT)
Message-ID: <a4ac0d06699b0d69262953ce49c740d66590e05b.camel@michel-slm.name>
Subject: Re: perf-tools v6.15 tarball not uploaded?
From: Michel Lind <michel@michel-slm.name>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org, James Clark <james.clark@linaro.org>
Date: Fri, 06 Jun 2025 14:59:27 -0500
In-Reply-To: <aEHylyR4hGaqZ6C8@x1>
References: <c5ac84be0a119d3dd432edf36196d07ad562b34c.camel@michel-slm.name>
	 <aEHylyR4hGaqZ6C8@x1>
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-yn7ikUnQDzO4OIbh/PUw"
User-Agent: Evolution 3.56.1-1 
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0


--=-yn7ikUnQDzO4OIbh/PUw
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2025-06-05 at 16:40 -0300, Arnaldo Carvalho de Melo wrote:
> On Thu, Jun 05, 2025 at 11:24:50AM -0500, Michel Lind wrote:
> > Hi Arnaldo,
> >=20
> > I noticed the kernel.org mirrors don't have perf tarballs newer
> > than
> > 6.14.0 -
> > https://mirrors.edge.kernel.org/pub/linux/kernel/tools/perf/
> >=20
> > Will they be uploaded soon? Presumably I can just generate the
> > tarball
> > myself for now from the Git tag.
>=20
> Its there now:
>=20
> https://www.kernel.org/pub/linux/kernel/tools/perf/v6.15.0/perf-6.15.0.ta=
r.xz
>=20
Thanks! This works great on x86_64, on arm64 it's failing because some
files that are needed to generate unistd_64.h per James' commits
starting Apr 29 are not there.

(I tried copying the files that show up in the error log, but
eventually hit a wall - for the Hyperscale build I'm going to get
around it for now by just generating the file on CentOS Stream 9 and
Stream 10 VMs, but I'll try soldiering on a bit to get this fixed
properly next week)

These are the files I had to add so far for those curious

# needed to build uapi-asm-generic on arm64, see
tools/lib/perf/Makefile
Source1:      =20
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/plain/sc=
ripts/Makefile.asm-headers?h=3Dv%{tag_version}#/Makefile.asm-headers
Source2:      =20
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/plain/sc=
ripts/Kbuild.include?h=3Dv%{tag_version}#/Kbuild.include
Source3:      =20
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/plain/in=
clude/uapi/asm-generic/Kbuild?h=3Dv%{tag_version}#/uapi-asm-generic-Kbuild

...

%ifarch aarch64
cp -p %{SOURCE1} scripts/
cp -p %{SOURCE2} scripts/
mkdir -p include/uapi/asm-generic/
cp -p %{SOURCE3} include/uapi/asm-generic/Kbuild
%endif

Best regards,

--=20
 _o) Michel Lind
_( ) identities:
https://keyoxide.org/5dce2e7e9c3b1cffd335c1d78b229d2f7ccc04f2
     README:     https://fedoraproject.org/wiki/User:Salimma#README

--=-yn7ikUnQDzO4OIbh/PUw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iI0EABYKADUWIQRdzi5+nDsc/9M1wdeLIp0vfMwE8gUCaENInxccbWljaGVsQG1p
Y2hlbC1zbG0ubmFtZQAKCRCLIp0vfMwE8leGAQDXeHEEMxM5xE3i2OUm/SiAq3ax
278/TRpfPEnshN0lDwEArurmzFLyyw/4fkQ9k+uQzaonHnM9t7Xf/O8DsoBkWQo=
=VdqC
-----END PGP SIGNATURE-----

--=-yn7ikUnQDzO4OIbh/PUw--
