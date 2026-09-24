Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44469456DE0
	for <linux-perf-users@vger.kernel.org>; Thu, 24 Sep 2026 10:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790244421; cv=none; b=bpG9xeV358/1g1Nmo44keA94jkoqi54bf62IwAlpIqjeJicWxPfekY4xeAso4QqEBKlOjDYLOC97J8ybKT6TX1gHSwHa/KcashPYlKRtU+T26PoaBMVYZC2VlJicyQlefLiZzN0ieNP/oNMt0R95rLl0CM5ET/CbenxnhYGtbRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790244421; c=relaxed/simple;
	bh=FOG/0dZfk7Tquq9kYGLesRKEUx8s19vRa0x8ZMgGCBU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=YjV0ahPP9m3bh+Z1RaRG0hAOUqzCOxPfGYMBHoksh9sPTgooite01rLExDg0vcQtKdX/rcC6n7IR9Y8hmSJHMiE7+Q2XvVyn2InbVTuhIzeDGHuHeyBHatVC+osainzJjUTtMgC5FrfEHzY8RdFITqHTS90+BG3fL39JFOBldZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k9g5W3sJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k9g5W3sJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 431EB1F0089A;
	Thu, 24 Sep 2026 10:06:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790244412;
	bh=FOG/0dZfk7Tquq9kYGLesRKEUx8s19vRa0x8ZMgGCBU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=k9g5W3sJcq1x2AgR7k/E3lwkiTPjyU9649qSs0bm/J1SHG5+IRmUeXeEl8YUG3qth
	 5OvSTTn51HOtnKfS8WoOno2XRWRLeCHxpZTLIzcCkxuFmzl97xCFpIU8VaLpz4/e7O
	 5tKVDL7xdK6DATGfomGhNzizC1UFzcj4IXgCCQb2nC1NWQdXu4eEXGB0grskUGEglP
	 oZpEJuP2TlB84NNFNcAR87t0pyMa11X1Iruztz1bIoDdYhipeW3xu/3PkMD79SlDoe
	 5uhq51fn9xWmwfA78pvSZ/on8JpMWk3650HugPoATxyuTprPFnma18QF1XXeiIM9WJ
	 hm4YJ9L6wiKeQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v14 2/2] iommu/riscv: create a auxiliary device for HPM
Reply-To: sashiko-reviews@lists.linux.dev
To: "Zong Li" <zong.li@sifive.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260924100106.2054127-3-zong.li@sifive.com>
References: <20260924100106.2054127-1-zong.li@sifive.com>
 <20260924100106.2054127-3-zong.li@sifive.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 24 Sep 2026 10:06:51 +0000
Message-Id: <20260924100652.431EB1F0089A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> Create an auxiliary device for HPM when the IOMMU supports a
> hardware performance monitor.
>=20
> Tested-by: Chen Pei <cp0613@linux.alibaba.com>
> Tested-by: Fangyu Yu <fangyu.yu@linux.alibaba.com>
> Reviewed-by: Nutty Liu <nutty.liu@hotmail.com>
> Reviewed-by: Guo Ren <guoren@kernel.org>
> Reviewed-by: Yicong Yang <yang.yicong@picoheart.com>
> Suggested-by: Samuel Holland <samuel.holland@sifive.com>
> Signed-off-by: Zong Li <zong.li@sifive.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260924100106.2054=
127-1-zong.li@sifive.com?part=3D2

