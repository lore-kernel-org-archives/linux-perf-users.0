Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C888848125B
	for <linux-perf-users@vger.kernel.org>; Fri,  2 Oct 2026 09:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790932474; cv=none; b=W7wg0BMoGm3PeEtp24cfXlePdcsfUjCfia4294BAZFjz1lTKrXl1UmKF5+kXt8Uu6FzFvGhNa0vQjxEL/sbERly8fGrzGVVdcmzNAlpFfAPfpCgMHAPUxgnGjthHZCsp4DPtTZS7EdAHgvKNvJjDE9nYWA07KYL8jkGztdIKzT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790932474; c=relaxed/simple;
	bh=CcZmEdlqZxjHa0V+Z5zcuW+9GYONpJqIbl3T18a2IjM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=bFEfo4LZ0oVk0kejY6e2fGfP1awCQqcOI1ncxLQQRmabW7Dq88D9AON4A3UkeOynBU2ZuL/yy46VNs6p9s40kRJqBfBUQCEzGqMApf0sODx3DhJ6et999whWfeVGGwIU4CcYOPftKch6jOJD3OeyHLWJjtGswcHxZ08KGii93Hc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DNl6AKRH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DNl6AKRH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B7501F0089A;
	Fri,  2 Oct 2026 09:14:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790932473;
	bh=CcZmEdlqZxjHa0V+Z5zcuW+9GYONpJqIbl3T18a2IjM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=DNl6AKRHhfWCWNWKWlt5jkioCjmx5Jj1UsoJwLVOauyO2smHtYG/2sZn3qfbwqexQ
	 Ak++JlCQMcPjixF1EnMTjMGA84AgYseRLYIwE6ciT98ILizzY1xQVmApvtklaEpwh1
	 NkWChADqFKnQizQCI9k6yTX4qwB+7vVB/hcmM2ACmC2EWOCgNGam3vZNId3KXXB0tP
	 G6GVQC5yA4iMtdfgo5R0GcLFlNJ1016XzSH8ISktCMbokOrbki2xa6usVL0K1I6p0+
	 TxIK2agl/aDUPaMSTvB6U4PijtI7HJ2btWA6JXXqkf2+pOX/X2lN0X07StGXm/bVhh
	 jb4LqvS10oL9Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v15 2/2] iommu/riscv: create a auxiliary device for HPM
Reply-To: sashiko-reviews@lists.linux.dev
To: "Zong Li" <zong.li@sifive.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261002063315.1535817-3-zong.li@sifive.com>
References: <20261002063315.1535817-1-zong.li@sifive.com>
 <20261002063315.1535817-3-zong.li@sifive.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 02 Oct 2026 09:14:32 +0000
Message-Id: <20261002091433.5B7501F0089A@smtp.kernel.org>
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261002063315.1535=
817-1-zong.li@sifive.com?part=3D2

