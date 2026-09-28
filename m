Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 706423630BE
	for <linux-perf-users@vger.kernel.org>; Mon, 28 Sep 2026 05:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790575044; cv=none; b=jYWMonE6nl6MUFQljle6N2hGOCET/9XmqecGeIIa44BrOmRFKCaTqslCsMVD8Uk1hEZlnIQxsNdrNK00jR+PMrQ/uJgkD3f/yEOpg+3mG1hks8syQRIAgTlZGrawHR5+9+EjwQpPRUQTDHNdUv/q0+3Xvjgn7awiIjwbgYQHScc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790575044; c=relaxed/simple;
	bh=NhNJqCvxKcYqyrmKUXvY0hEg+yB/SVKfSLGiOPtN/R8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=i/hOjFMaEGrd+/iVPY5UCjNYCB0uoLekpgg5jkogMYJNAE2b5IYZS1sbz+/Axs2f07ZpSq/yKDPJ+O5asp0qYysclQhJpaIWqBZE5/Y/lHVYdPRe8H7vRYr+/7FCDP6qku/h85nT97KIfT9qnhzb1RKMaLVg3z0qGGikfMWXw14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aPYI2Z0Y; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aPYI2Z0Y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7B411F000FF;
	Mon, 28 Sep 2026 05:57:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790575043;
	bh=SI3mv6qLBKrM1BrDpDT47EzXKRHclPujOBjt8RHJKA4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=aPYI2Z0YsX7Q7lWqkd8Z9yCLGrgXT6xjsnzCMI002qQoowpUrEixz+D9qFVPR2nIU
	 6b75vPkQCNS2W9k/G/eAgKGRjwRUXcTJmSKJ1g1tBIBA2+25/mVfHdit0gdxPEifu3
	 eWRiXM5uRQd4RjHEfgEKE6nzG4w3yWBz/agc2PVX7vj3JAfWwhQZ2nhQlGHr2hoMsM
	 L2Pnw/+faY+P2awwrWTcx1HabMk0/kX+J/dCfQIhuO6vY7uXCaVgDbLC896+sD40gs
	 gUdmeoczS9Vc9B8L43eRyaT4GZqAU54jQIeA27+FY/e1ao1VWVCg6s3DnwkhJIW8Ry
	 QBoDkN867mrvA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 1/8] perf tools: Add dso->dbginfo_type field
Reply-To: sashiko-reviews@lists.linux.dev
To: "Namhyung Kim" <namhyung@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260928055055.95144-2-namhyung@kernel.org>
References: <20260928055055.95144-1-namhyung@kernel.org>
 <20260928055055.95144-2-namhyung@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 28 Sep 2026 05:57:22 +0000
Message-Id: <20260928055722.D7B411F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> It saves where the debug info is available for the given DSO.  It's
> sometimes different than where binary data or symbol table is located.
> So let's add a new field to save the info.
>=20
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260928055055.9514=
4-1-namhyung@kernel.org?part=3D1

