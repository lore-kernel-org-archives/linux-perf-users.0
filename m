Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83F062D061C
	for <linux-perf-users@vger.kernel.org>; Tue, 18 Aug 2026 14:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787065169; cv=none; b=RNf5YLMh8pWpo2Uz8jJy3P+/ZCZh6ISG0BxQGJ+LJGXJjW+r8dednPOfP9iUWDBrEor0bee44w6xsGmWsHVAvrr+BUrpBB6v9Iq6hJCFJfbcBqloEavDryFG/GDawWR/izFIFyd/2GAKyAlF60bZFo9bo468PhqU++AgutommfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787065169; c=relaxed/simple;
	bh=yEx6mq6SFTtmRYfdqckPv09BN2MS9uMzAVdxmoHkJq4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ujbh18+KTfQLS3r9kvPBcQrJ1cUzQqrh4a8GQnCXjstlUj3gRa9LsrriCJIunVCbsjo3nyGWJTCA1/IHjVTQZ9O4PHbtxlOkZ8puhJ4V7SELpQZNjcp/iDFy+rfbNFJGQTXl02UrtS/YHnC07J0ZdWg84zKCJvCvxg19piyOHfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GXyp5zum; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GXyp5zum"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF7B41F000E9;
	Tue, 18 Aug 2026 14:59:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787065168;
	bh=yEx6mq6SFTtmRYfdqckPv09BN2MS9uMzAVdxmoHkJq4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=GXyp5zumgJRPLk/Vn9Bni/bvVVFchEXC7kz1swjIKszekeNdK2rAAqAtIPhDcBZBZ
	 zrmwis2TQBC10va9L+zEc3Tzs2335TK481JR+/Yxm0e42eQMVA33qeSOLplnDX9Bxa
	 FiWpeyTvHLoh3MT/1LHZL68h8wcw1+quXAon1PiVaWv/AcHWQT6vSzttQaVdHeZ58L
	 eZrmym0XpJK4vS0RsKBtzQwgQaK0+Ld3d393VQ3ve81TloDMwE92rF3fMoek8yTbXi
	 JWdWv+i8qBTJPK8env7nIgFE9Xxna/jtBxI2n7LfERbf8cKgtTOnkpBl6r9vaV/SMz
	 6Lj8xkWnLNB/w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] perf unwind: handle allocation failure in
 libdw__get_entries()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Triet Hoang" <triet.hoang.dev@gmail.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260818144837.741469-1-triet.hoang.dev@gmail.com>
References: <20260818142902.639F51F000E9@smtp.kernel.org>
 <20260818144837.741469-1-triet.hoang.dev@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 18 Aug 2026 14:59:27 +0000
Message-Id: <20260818145927.EF7B41F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> Check the return value of zalloc() before dereferencing the allocated
> dwfl_ui_ti structure.
>=20
> Return -ENOMEM when the allocation fails to avoid a NULL pointer
> dereference.
>=20
> Signed-off-by: Triet Hoang <triet.hoang.dev@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260818144837.7414=
69-1-triet.hoang.dev@gmail.com?part=3D1

