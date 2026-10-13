Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ECFC26AC5
	for <linux-perf-users@vger.kernel.org>; Tue, 13 Oct 2026 00:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791850001; cv=none; b=GP8WLOVdmOR4ewFOZ0XsVbUOIrIIL4NRCbyzDdMsgAvYDu5lW///m0/Sg3CxqsAyGyGnBMgVAoILSk9/JpMPXZJBNdVCFLk6dX5l2/X836AUZhyG0nhRD8CQfxT8Map4ZREQnEseklZVqCJomzGgdQMIgJ7NASGnYpzLmWvRY1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791850001; c=relaxed/simple;
	bh=yAbHzZeuxujWRwfk2aYtSyAucMxn5ticrJwbKoWiQcc=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=VFYLeNOTRPx3m4yqgXexq/Gg1SaOvJNX13SDOa88ow7Ps+wM8dyExYgf4JWjOXzueP9IjQuiZN/+EUihlVpbFK4g69hMLvj0tp8hKDx5hRdxMnDPW8jNl2wGHdczbG1ux7orSJowvzqSuuwgoHF7QM9EiPDXTRWiTSY9FRcwhXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dBPlzfne; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dBPlzfne"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF0BB1F0089B;
	Tue, 13 Oct 2026 00:06:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791850000;
	bh=y85RTQdvfK4AvDRUVnGJZ2bo9H6novrYiAbfD1o8ZhU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=dBPlzfneyA5MXC64U7lMEIELr4W0Rtzji4XZv+8vPLfktl77BLoXm1pAdJdgjf12/
	 Fo7qrTkRpQzQ1oo7xURrLFFHCvT0nPfUia4lPI9prJmWgmvUHoaXyDTZ6Dv98PYJG9
	 Qa0XCS00yX6C7no5cVobck1PZ8fGBLZguxagBXXC0XGsL0UWUvR9h2ZBtcgYKXLgAt
	 i1BC6y+rmOiVezrPxn0yIRjX+SyqE51Sssyz/H2K+E1Wr7fvQi9j0WVHVQ0z7DqlNH
	 6U6wtmHd+sEdpfssstAfbVd+xlKSUisBQX7Vz/5+d/VGW9t3P11yOmh2PGwPsjbq4w
	 nIRfd4ZVqqC8A==
Message-ID: <sashiko-outbox-168773@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 10/10] perf test: Fix dso data tests
Reply-To: sashiko-reviews@lists.linux.dev
To: "Namhyung Kim" <namhyung@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261012234654.60666-11-namhyung@kernel.org>
References: <20261012234654.60666-1-namhyung@kernel.org>
 <20261012234654.60666-11-namhyung@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 13 Oct 2026 00:06:39 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> Now dso__binary_type() requires that the target file is a valid ELF file
> containing ".text" section.  But the test only checks cached read/write
> operation on a file.  Let's set the binary type to bypass the ELF check
> to read/write the file properly.
>=20
> Reviewed-by: Ian Rogers <irogers@google.com>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261012234654.6066=
6-1-namhyung@kernel.org?part=3D10

