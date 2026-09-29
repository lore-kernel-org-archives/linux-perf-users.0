Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C63C1E9B1A
	for <linux-perf-users@vger.kernel.org>; Tue, 29 Sep 2026 01:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790645252; cv=none; b=kor2RINwJL/aolxpfODZH6+qW4svL43wkNRzTMtrNTbdqKjnayncJvKbd10x+6g8p38IgR2e8oR5LKsOkW+YxBWiCkxvmlLeZ77LOn6H9Vc0d5Ho3mT1bGZL9aG7FgEJmS9FIJim5QrKChbFTnW/sf6M3AWy5skCWq4vtcU9Nu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790645252; c=relaxed/simple;
	bh=zqO9M784+IEEuykQkmaFvGPZU8Cblehe7eizt8ARuBc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Jsg/livsLVp+O3NhsWl6qt0pzv5qyaEYTPYY1gSELxqua2KVXrwfMez6r2fH1wqdrJfIN1tEsoP1aAyOK/lK2xjChLsawpy91GrtnizlfeqyRm32JE/h9k8GOKJU/ifemeRyUvSIxPQ2l84YwTFsCBFo7hi9dFT1O/rBZLuka3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IDjiSvsg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IDjiSvsg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 171271F000FF;
	Tue, 29 Sep 2026 01:27:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790645251;
	bh=gDrGXeUsl55nCTlb1HsIxHwV1M0GV7h7KteHcnXxJhw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=IDjiSvsg+F0DWxlT3mn3dj4oDrO3Al4KznYJicwVfGhPUCDFUZo3CccSu9iONvTxQ
	 NUHVM8GS+CQ6Sj3aYCxbv1tf/6AC6HECiOpM33jE5QvyBeo0by5W/sd9SAk+4UWiNB
	 GLLVeirPkXqJZ4gDVSvT5WvustlMwwWellO5DBcCRkV7hT79fXuqBLmjLAPYz2u2Jz
	 51VVUw9/17HViFPLWCnZkALfkqQpQOxi9Ndza0KYTJKp9iuaR89jnvXPlTTX/AX+tj
	 HzPaybc+ccXKr3//H4X5lvdqwCJdiPmKGwy8noZFzIJDIJ2tcvkzwNlOUAEqjIphi+
	 CZLhuJrx+LZUw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 7/8] perf tools: Looks symbol file first when check
 debuginfo
Reply-To: sashiko-reviews@lists.linux.dev
To: "Namhyung Kim" <namhyung@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260929011139.53242-8-namhyung@kernel.org>
References: <20260929011139.53242-1-namhyung@kernel.org>
 <20260929011139.53242-8-namhyung@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 29 Sep 2026 01:27:30 +0000
Message-Id: <20260929012731.171271F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> There's a high chance that the file containing the symbol table also has
> debug information.  Let's check that first before other locations.
>=20
> Reviewed-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260929011139.5324=
2-1-namhyung@kernel.org?part=3D7

