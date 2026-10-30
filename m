Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793383105;
	b=vLoNCxhPRbl9Sd8hzDPJTgm23SpBOlUUgVLydct4nuTQxytVy9Nmrvha25Ws+ify/jDg
	 68Nk6ugbXrVqv3Ug5aLibtmVPRgq+KvMT4uA2BFsKEGfno7UEIXX8xHYTO7H892xtudD8
	 5VgubMd/ZVYDpI/6bn9WHOAxNgQwvGcZNHxV3EQf3A9mVtIjF8u326BIAXGelzyVlnZy1
	 aka1cbN0BIkFTszbs0J769IQmtAHc96L/YbSr+/Lc0+rgWqcOvkZPg8YgvNVYuRF+xvuv
	 jdZVz2u7UP5rXxmw7wwKqhyemCt3ZuMpFAR5xI/0zUzrUY3bAGCTkPQAnaZ7w+2xslw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793383105;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=wDHFjDvqgVe7sISCVwnLz6qxc07SyVIEQQAUb+D3rKM=;
	b=TwSHd6uvQN2NNR5WWIbvwQVMVi78G+uLxT1cFV+v37iFr1mbkBEqmoGxdBp3WRzsEM/4
	 4UslsS7taO59De01dZHkKfOeDVgxbC4hyz2+/GqKyRB/TMUnY/ZJcUxut1Mrdzhvb+F64
	 XIRN5vrStcaWYS6t0tuw4R2azKcYacGbK/DlsBbm70+/cyb6beghZotvole7qAswYeEYO
	 WEnh8leNqQlbTIg2HRiqHoVL9MHQqbfDe8MgBFvcXDClDaT2f7FhSOSAXsdFhpq4CXsua
	 oreg3FMKvHFf4b9pZ3LQIk3nZLuXRI4F95tuH4LA9vNkgtbIPobXK9fytJU2M9+ZK9g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RD3EwUsP;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 975E6606A333
	for <linux-perf-users@vger.kernel.org>; Fri, 30 Oct 2026 17:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RD3EwUsP
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 599921F00A16;
	Fri, 30 Oct 2026 17:58:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793383105;
	bh=wDHFjDvqgVe7sISCVwnLz6qxc07SyVIEQQAUb+D3rKM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=RD3EwUsPMoOW6bb5KmpDyR2L2KEXSdcDOBEBS97a8fyZ4Bn4VQ2N5+ujibE04Q0xF
	 CNx7jNQAjbjTvAnSW2AiV8RRoUDfCCXYiXLTpuIDxtkGMqnXKCVaOTJ64GdCD7a0gg
	 AI0kuiIQIf0tdRqMUxrxzhqUL9lTWgDoLnumJzWQ+LxsGs8PQ3dMwDm6sdChYfUjiN
	 dD8tZj7qdZoio9Td9ak4A8XPBymnJnmHOeBzdlay7hd2CpHYnc7rnARiiKbmyz/Eju
	 HdL0JH3/12SguYuz2HPbr0Cxb18yAc4reOdaeIiVE8UcvOTvnKocqmmM45nyZ6+sTw
	 tb4sqLqfxk47Q==
Message-ID: <sashiko-outbox-191380@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 9/9] perf Documentation: Describe PMU names numbered
 in more than one place
Reply-To: sashiko-reviews@lists.linux.dev
To: "Besar Wicaksono" <bwicaksono@nvidia.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261030174816.1544471-10-bwicaksono@nvidia.com>
References: <20261030174816.1544471-1-bwicaksono@nvidia.com>
 <20261030174816.1544471-10-bwicaksono@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 30 Oct 2026 17:58:24 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> The PMU naming convention describes an optional numeric suffix that tools
> ignore to treat PMUs as instances of one PMU. Some PMU names contain more
> than one number to identify an instance, such as the NVIDIA PCIe PMU
> nvidia_pcie_pmu_<socket>_rc_<rc>. Since commit 730670b1d108 ("perf pmu:
> Support more complex PMU event aliasing"), the perf tool matches such
> names with json event Units with comma-separated parts, like
> "nvidia_pcie_pmu_,rc_".
>=20
> Describe these names and how tools can tell that all their numbers
> identify an instance of the same PMU.
>=20
> Signed-off-by: Besar Wicaksono <bwicaksono@nvidia.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261030174816.1544=
471-1-bwicaksono@nvidia.com?part=3D9

