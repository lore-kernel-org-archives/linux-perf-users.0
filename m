Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CDF43769E6
	for <linux-perf-users@vger.kernel.org>; Tue,  8 Sep 2026 08:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788854745; cv=none; b=GqW5zF5MBA7SWWXK99QCSMomSPV5//MNNbV3XStcx88nXSFcuEGKPOguOZ8fBLTDNVBZUYzLjoJ6scl9IGjxGE5gqnHguKhxb9g0D4d+zmDauwvAvIx5EY0xKkKmSQzFNniM1TOvBSPKJDalrQXu87Rq6WdOw/gJSuelpK//IYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788854745; c=relaxed/simple;
	bh=+qJd7plTL5SAJtSfw2roFAo9oS6zYqgcBmpyrPZOJCE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=f/AbRBcDM4bxfQaaHMoC2mB9btBSWuwuHlYO9XgKm6C5z/yd3wNqxBehw7pPuF/sxtFw6J2X1v9O4ALrdbTs+Eh/+5IwJKqrVBaxkSomtzjXk8PMrhTQtGt8ierMpB6qqVqiv4oWDiLl+UmUF7aOSvzMmrGyUGROJPp9r9ku2BI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jd5L0zYo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jd5L0zYo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A79BA1F00A3A;
	Tue,  8 Sep 2026 08:05:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788854743;
	bh=+qJd7plTL5SAJtSfw2roFAo9oS6zYqgcBmpyrPZOJCE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Jd5L0zYoprafrTqWSSEYu+xmBSN0RwotVdZjTh+egwALhSYk08/3DWOGN2McgOINM
	 G0gc1ibDKbxuGe+xF4kwggsohsXuRVCc0vC2fBUXCzm1RM7RcO7+z9uPSYZAYQjDCe
	 fquTSOv2WniFO5Xd5v7ywoLZVISChXkXRRbO0qaE7HLPUyGGcsWPt5VpdcTPZ+Ep3d
	 GvX7fqOHKf+1moLcgx0A/pKdzZOJYo/48ebBvTxm+wv/WnXK91d2b8tNRCuDgdNsQp
	 hV6C1i9enwutTc/XeuspoMkMwlXbEnkCvoQ0N3Hlk3qaYdwH3VV48/di0qiWSFca/e
	 IaN4pw/N8+fSw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/2] perf/x86/intel: Correct pt_regs->flags update for
 PEBS path
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dapeng Mi" <dapeng1.mi@linux.intel.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260908075102.540715-1-dapeng1.mi@linux.intel.com>
References: <20260908075102.540715-1-dapeng1.mi@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 08 Sep 2026 08:05:43 +0000
Message-Id: <20260908080543.A79BA1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> pt_regs->flags holds the saved CPU FLAGS register. In the PEBS path,
> it was incorrectly set to PERF_EFLAGS_EXACT instead of being populated
> from the PEBS flags snapshot.
>=20
> Update pt_regs->flags from PEBS GPR flags if GPRs group is present.
>=20
> Fixes: c22497f5838c ("perf/x86/intel: Support adaptive PEBS v4")
> Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260908075102.5407=
15-1-dapeng1.mi@linux.intel.com?part=3D1

